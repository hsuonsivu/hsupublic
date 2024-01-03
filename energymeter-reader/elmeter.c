#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>

// #define LONGMESSAGES 1

#define WAIT_COMMAND 200000
#define MAX_CHANNELS 16

#ifdef LONGMESSAGES
#define MESSAGE_BYTES 267
#define START_OF_CHANNEL_DATA 138 /* 146 */
#else
#define MESSAGE_BYTES 129
#define START_OF_CHANNEL_DATA 0
#endif

#define CHANNEL_DATA_BYTES 8 /* (1+2+2+2+1) */
#define MAX_TIMEOUT 5
#define CRC_INITIAL_VALUE 183

/* Indicates version of this log. */
#define LOGVERSION 1
// #define LOGVERSION 2

const unsigned char CRC7_POLY = 0x91;
int debug = 0; //3; /* 3; */
int logformat = LOGVERSION; /* 1 prints summed power of all channels, 2 prints all channels */

 
unsigned char getCRC(unsigned char message[], unsigned char length)
{
  unsigned char i, j, crc = 0;
 
  for (i = 0; i < length; i++)
  {
    crc ^= message[i];
    for (j = 0; j < 8; j++)
    {
      if (crc & 1)
        crc ^= CRC7_POLY;
      crc >>= 1;
    }
  }
  return crc;
}

typedef struct {
  char magic; /* Should always be 53 */
  char channelnumber; /* Ascii two digits */
  int channelid; /* ffff if the channel has not been paired, 
		otherwise some number */
  unsigned int power; /* in kW, (lsb,msb) */
  char somevalue; /* Seems to be 31 ('1') for active channel,
			 32 ('2') for non-active */
} Channeldata;

/* Channels 0-15 */
Channeldata channels[16];

/*
 * 'open_port()' - Open serial port 1.
 *
 * Returns the file descriptor on success or -1 on error.
 */

int
open_port(char *device)
{
  int fd; /* File descriptor for the port */
  struct termios options;

  fd = open(device, O_RDWR | O_NOCTTY | O_NDELAY);
  if (fd == -1)
    {
      /*
       * Could not open the port.
       */

      perror(device);
    }
  else
    fcntl(fd, F_SETFL, 0);

  /*
   * Get the current options for the port...
   */

  tcgetattr(fd, &options);

  /*
   * Set the baud rates 
   */

  cfsetispeed(&options, B9600);
  cfsetospeed(&options, B9600);

  /*
   * Enable the receiver and set local mode...
   */

  options.c_cflag |= (CLOCAL | CREAD);

  /*
   * Set the new options for the port...
   */

  options.c_cflag &= ~PARENB;
  options.c_cflag &= ~CSTOPB;
  options.c_cflag &= ~CSIZE; /* Mask the character size bits */
  options.c_cflag |= CS8;    /* Select 8 data bits */
  options.c_cflag &= ~CRTSCTS;
  options.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG); 
  options.c_oflag &= ~OPOST;
  options.c_cc[VMIN] = 0;
  options.c_cc[VTIME] = 50;
  if (tcsetattr(fd, TCSANOW, &options) < 0)
    {
      perror("Could not set port parameters");
      exit(EXIT_FAILURE);
    }

  if (fcntl(fd, F_SETFL, FNDELAY) < 0)
    {
      perror("Could not set port nodelay");
      exit(EXIT_FAILURE);
    }
  
  return (fd);
}

void write_data(int fd, char *data, int len)
{
  int n = len, written;

  do {
    written = write(fd, data, n);
    if (written < 0)
      {
	perror("write");
	exit(EXIT_FAILURE);
      }
    n -= written;
  } while (n > 0);
}

char start_command[] = { 0xaa, 0x00, 0x00, 0xad };
char read1_command[] = { 0xaa, 0x01, 0x00, 0xad };
char read2_command[] = { 0xaa, 0x02, 0x00, 0xad };

int main()
{
  int fd, n, bytes_read, previous_bytes_read, checksum;
  time_t clock;
  int channels;
  time_t starttime;
  
  unsigned char buffer[1024];
  unsigned char previous[1024];
  
  /* XXX Should do locking... */
  
  fd = open_port("/dev/cuaU0");

  /* Dump possible leftovers from previous run */
  n = read(fd, buffer, 1023);
  if (0) /* n < 0 */
    {
      perror("Initial read error");
      exit(EXIT_FAILURE);
    }

  starttime=time(NULL);
  
  previous_bytes_read = 0;
  do
    {
      // fprintf(stderr, "start command\n");
      write_data(fd, start_command, 4);

      usleep(WAIT_COMMAND);

      checksum = CRC_INITIAL_VALUE;
      
      /* Skip until 0xaa seen */
      while (1) {
	if (read(fd, buffer, 1) == 1)
	  {
	    if (debug & 2)
	      fprintf(stderr, "%02x", buffer[0]);
	    if (buffer[0] == 0xaa)
	      break;
	  }

	if (time(NULL) > starttime + MAX_TIMEOUT)
	  {
	    fprintf(stderr, "Timeout\n");
	    exit(EXIT_FAILURE);
	  }
      }

      checksum = ((checksum + buffer[0]) & 0xff);
      
      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2)
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0xf0)
	    {
	      fprintf(stderr, "Did not get 0xf[1]\n");
	      /* Assume this is number of channels the unit supports */
	      channels = buffer[0];
	      exit(EXIT_FAILURE);
	    }
	}

      checksum = ((checksum + buffer[0]) & 0xff);
     

      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2) 
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0x0)
	    {
	      fprintf(stderr, "Did not get 0x0[2]\n");
	      exit(EXIT_FAILURE);
	    }
	}

  
      checksum = ((checksum + buffer[0]) & 0xff);
     
      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2)
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0xad)
	    {
	      fprintf(stderr, "Did not get 0xad[3]\n");
	      exit(EXIT_FAILURE);
	    }
	}

      checksum = ((checksum + buffer[0]) & 0xff);
     
      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2)
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0x1)
	    {
	      fprintf(stderr, "Did not get 0x1[4]\n");
	      exit(EXIT_FAILURE);
	    }
	}

      checksum = ((checksum + buffer[0]) & 0xff);
      
      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2)
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0x0)
	    {
	      fprintf(stderr, "Did not get 0x0[5]\n");
	      exit(EXIT_FAILURE);
	    }
	}

      checksum = ((checksum + buffer[0]) & 0xff);
     
      
      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2)
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0x1)
	    {
	      fprintf(stderr, "Did not get 0x1[6]\n");
	      exit(EXIT_FAILURE);
	    }
	}

      checksum = ((checksum + buffer[0]) & 0xff);
           
      if (read(fd, buffer, 1) == 1)
	{
	  if (debug & 2)
	    fprintf(stderr, "%02x", buffer[0]);
	  if (buffer[0] != 0x0)
	    {
	      fprintf(stderr, "Did not get 0x0[7]\n");
	      exit(EXIT_FAILURE);
	    }
	}

      checksum = ((checksum + buffer[0]) & 0xff);
     
      clock = time(NULL);

      // fprintf(stderr, "read1 command\n");
#ifdef LONGMESSAGES
      write_data(fd, read1_command, 4);
      usleep(WAIT_COMMAND);
#endif
      // fprintf(stderr, "read2 command\n");
      write_data(fd, read2_command, 4);
      usleep(WAIT_COMMAND);

      bytes_read = 0;
      if ((n = read(fd, buffer, sizeof(buffer) - 1)) > 0)
	{
	  // fprintf(stderr, "DEBUG: read %d bytes\n", n);
	  bytes_read = n;

	  if (1) /* memcmp(buffer, previous, bytes_read)) */
	    {
	      if (debug & 2)
		{
		  for (int i = 0; i < n; i++)
		    {
		      checksum = ((checksum + buffer[i]) & 0xff);
		      if ((previous_bytes_read != 0) &&
			  (buffer[i] != previous[i]))
			{
			  printf("\033[31;1m");
			  printf("%02x", buffer[i]);	
			  printf("\033[0m"); 
			}
		      else
			printf("%02x", buffer[i]);
#if 0		  
		      if ((i == 0) ||
			  (i == 8) ||
			  (i == 2*8) ||
			  (i == 3*8) ||
			  (i == 4*8) || 
			  (i == 5*8) || 
			  (i == 6*8) || 
			  (i == 7*8) || 
			  (i == 8*8) || 
			  (i == 9*8) || 
			  (i == 10*8) || 
			  (i == 11*8) || 
			  (i == 12*8) || 
			  (i == 13*8) || 
			  (i == 14*8) || 
			  (i == 15*8) ||
			  (i == 16*8 - 1)) putc(' ', stdout);
#endif
		
		    }
		}
	    }
	
	  if (debug & 2)
	    printf(" checksum 0x%02x bytes %d\n", checksum, n);
	  fflush(stdout);
	}
      else
	{
	  if (errno == EAGAIN)
	    {
	      sleep(1);
	      continue;
	    }
	  else {
	    perror("reading input failed");
	    exit(EXIT_FAILURE);
	  }
	}

      if (n != MESSAGE_BYTES)
	{
	  fprintf(stderr, "Ignoring message of length %d, should be %d bytes\n", n, MESSAGE_BYTES);
	}
      else
	{
	  Channeldata channeldata[MAX_CHANNELS];
	  unsigned char *channelstart;
	  unsigned char *p;
	  int activechannel = -1;
	  int activechannels = 0;
	  int errors_detected = 0;

	  p = buffer + START_OF_CHANNEL_DATA;
	
	  if (debug & 2)
	    fprintf(stderr, "DEBUG start of channel data Data 0x%lx: ", (unsigned long) p);
	  
	  for (int i = 0; i < MAX_CHANNELS; i++)
		    
	    {
	      int channelnumber;
	      int magic;
	      unsigned int channelid;
	      unsigned int power;
	      unsigned int somevalue;

	      channelstart = p;

	      if (debug & 1)
		{
		  fprintf(stderr, "DEBUG Channel %d Data 0x%lx: ", i, (unsigned long) p);
		  for (int j = 0; j < 8; j++) fprintf(stderr, "%02x", *(channelstart + j));
		  fprintf(stderr, "\n");
		}
	    
	      magic = *p++;
	      if (magic != 0x53)
		{
		  /* Magic does not match */
		  fprintf(stderr, "Channel %d, magic 0x%x is not 0x53\n", i, magic);
		  fprintf(stderr, "Data 0x%lx: ", (unsigned long) p);
		  for (int j = 0; j < 8; j++) fprintf(stderr, "%02x", *(channelstart + j));
		  fprintf(stderr, "\n");
		  errors_detected = 1;
		  break;
		}

	      channelnumber = *p - '0';
	      channelnumber = channelnumber * 10 + *(p+1) - '0' - 1;
	      if (channelnumber != i)
		{
		  fprintf(stderr, "Channel %d, channel number %d (%.2s) does not match\n", i, channelnumber, p);
		  fprintf(stderr, "Data: ");
		  for (int j = 0; j < 8; j++) fprintf(stderr, "%02x", *(channelstart + j));
		  fprintf(stderr, "\n");
		  errors_detected = 1;
		  break;
		}

	      p += 2;

	      channelid = *p;
	      channelid = (*p << 8) + channelid;
	      if (debug & 1)
		fprintf(stderr, "DEBUG Channel %d, channelid 0x%x.\n", i, channelid);

	      p += 2;

	      power = *p++;
	      power = power + (*p++ << 8);

	      somevalue = *p++;
	      if (somevalue == 0x31)
		{
		  activechannel = i;
		  activechannels++;
		}

	      if ((somevalue != 0x31) && (somevalue != 0x32))
		{
		  fprintf(stderr, "Channel %d somevalue 0x%x is not 0x31-0x32.\n", i, somevalue);
		  errors_detected = 1;
		  break;
		}
	    
	      if ((somevalue == 0x32) && (power != 0))
		{
		  fprintf(stderr, "Channel %d is not active, but power %d is non-zero.\n", i, power);
		  errors_detected = 1;
		  break;
		}

	      if ((channelid == 0xffff) && (somevalue == 0x31))
		{
		  fprintf(stderr, "Channel %d is active, but channelid 0x%x indicates never paired.\n", i, channelid);
		  errors_detected = 1;
		  break;
		}

	      if ((channelid == 0xffff) && (power != 0))
		{
		  fprintf(stderr, "Channel %d is not paired, but power %d is non-zero.\n", i, power);
		  errors_detected = 1;
		  break;
		}

	      /* Sometimes negative values are received - assume error */
	      if (power & 0x8000)
		{
		  fprintf(stderr, "Channel %d power %d is negative.\n", i, power);
		  errors_detected = 1;
		  break;
		}
	      
	      /* Sometimes impossible values are received - assume out
		 of sync error. The power value cannot be larger than
		 65k as it is a 16-bit value. */
	      if (power > 65535)
		{
		  fprintf(stderr, "Channel %d power %d is too large.\n", i, power);
		  errors_detected = 1;
		  break;
		}
	      
	      /* XXX Also zero values are sometimes received - may be
		 an error, but we cannot distinguish those from actual
		 zero power situation. */

	      channeldata[i].magic = 0x53;
	      channeldata[i].channelid = channelid;
	      channeldata[i].power = power;
	      channeldata[i].somevalue = somevalue;
	    }

	  if (activechannel == -1)
	    {
	      fprintf(stderr, "No active channels.\n");
	      break;
	      errors_detected = 1;
	    }

	  if (!errors_detected)
	    {
	      unsigned int totalpower = 0;
	      
	      for (int i = 0; i < MAX_CHANNELS; i++)
		{
		  totalpower += channeldata[i].power;
		}

	      if (totalpower > 65535)
		{
		  fprintf(stderr, "Total power %u is larger than 65536, should be impossible for 3x63A\n", totalpower);
		}
	      else
		{
		  if (logformat == 2)
		    {
		      printf("%d,%ld,%ud",logformat,time(NULL),activechannels);
		      for (int i = 0; i < MAX_CHANNELS; i++)
			{
			  printf(",%d,%d", (channeldata[i].somevalue == 0x31) ? 1 : 0,
				 channeldata[i].power);
			}
		      printf("\n");
		    }
		  else
		    {
		      printf("%d,%ld,%d,%u\n",logformat,time(NULL),activechannels,totalpower);
	      
		    }
		}
	    }
	}
    
      memcpy(previous,buffer,bytes_read);
      previous_bytes_read = bytes_read;
      sleep(1);
    }
  while (0);
}
