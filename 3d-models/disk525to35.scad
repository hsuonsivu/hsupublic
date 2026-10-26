
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO Front cover clips are not yet in new orientation.
// TODO screw version needs to be redesigned, wont fit with new disk lock system.

include <hsu.scad>
include <hsubolt.scad>

print=20;
abs=1;
brimw=abs?8:0; // Used when setting abs (turns on brim)
useheatwall=abs?1:0;

// Brim is selectively enabled for taller parts.

fn=$preview?16:90;
smallfn=$preview?16:60;

wall=2;

debug=0;

// 0: Make a complex version with locking mechanism
// 1: Make a simple version, with no locking mechanism
simple=0;

// Number drive slots to use, 1 is half-height, 2 is full-height, 3 is
// three half-height, and otherwise the value is taken as height in mm
// which is from a specific case and may not indicate any kind of
// standard.  For full height and larger, gap is created for first and
// second slot space as many cases include extrusions which prevent
// full-height disks from being used. These extrusions and gap between
// half-height slots is not standardized so we only create this gap
// between with expanding distance to try to avoid these
// extrusions. Outside screws will not work for these cases so they
// are only implemented for the first slot.
// 0.5 is 30mm low profile 5.25, 2.5 is +10mm higher version of 2 slot, both for HP cases.
slotconfig=2;
slottable=[0.5,1,2,2.5,3,4,5];
slots=slottable[slotconfig];

// Maximum (3.5) disks, rest of space is allocated to 2.5 drives.  If
// 0, dynamically allocated, 3.5 first and rest of space for 2.5.
// This will not always fill the space optimally.
maxdisks=slots==5?6:slots==3?4:slots==2.5?2:slots==2?2:slots==1?1:slots==0.5?1:-1;

// Full version, includes all material saving holes (very slow in openscad - render before rotating view)
full=1;

// Holes are through for better cooling.
throughholes=1;

// One of our cases has metal clips holding the drives. Replace outside locks with guides with clip
guideversion=0;

// Aopen case
aopenversion=0;

// Some cases expect fixed screws in either lower or upper settings. IN PROGRESS
// Could also be basis for screw-in version
sideslideversion=1;

// Sideslides have fixed screwheads
sideslidescrewheads=0;

// Sideslides have screw holes
sideslidescrewholes=1;

// Sideslides with clip WORK IN PROGRESS
sideslideclips=0;

// First version of locking disks in place. 
olddisklocksystem=0;

// Other versions have outside locks going to screw holes
screwversion=(!guideversion && !aopenversion && !sideslideversion);

// Cooling fan size, 80,92 or 120.  Selected automatically based on
// number of disk bays. One disk is approximately 26mm high and slot
// distance is about 28mm, halfheight slot is 41.3mm. So, for smaller
// frames, use attachments with disk width, and for larger frames use
// outside attachments.
//
// 2 disks would need fan less than 56mm
// 3 disks would need fan less than 84mm
// 4 disks would need fan less than 112mm, but will be limited by disk width (101.6mm + sidewalls), will need to use outer attachments (146.1mm-sidewalls)
// 5 disks would need fan less than 140mm, but will be limited by disk width (101.6mm + sidewalls), will need to use outer attachments (146.1mm-sidewalls)
// So, 120mm fan might be too oversize.
//
// Adding fan to one slot adapter would make little sense, as the
// attachment design would need to be changed, based to half-height
// slot size and different attachment.

coverwithfan=slots>1;

//forcefantype=0; // 

fantype1=(!is_undef(forcefantype)?forcefantype:slots==5?6:slots==4?6:slots==3?4:slots==2.5?4:slots==2?3:-1);
fantype=fantype1>6?6:fantype1;

fansizetable=[[40,32,10],     //0
	      [50,40,10],     //1
	      [60,50,15],     //2
	      [70,60,15],     //3
	      [80,71.5,25],   //4
	      [92,82.5,25],   //5
	      [120,105,25.4],   //6
	      //[140,124.5,28], //7
	      //[200,154,30],   //8
	      //[220,170,30]    //9
	      ];

if (guideversion && sideslideversion) {
  echo("ERROR guideversion and sideslideversion cannot be enabled together.");
 }

if (aopenversion && sideslideversion) {
  echo("ERROR aopenversion and sideslideversion cannot be enabled together.");
 }

maxbridge=10;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

sidewall=2;//2.2;

// Generic narrow cut for moving parts
cut=0.5;

// Screwheads for certain cases
headd=7;
headh=2.9;
headcornerd=1;

// Gap for top of lock cover
locktopspace=2+xtolerance;

// Generic disk screwd is about 3.5mm
diskscrewholed=3.6;

guidebrimw=abs?3:0;
guideclipx=15.5;//15;
guidex=26;
guidel=150-guidex;
guidenarrowingl=150-135;
guidesloty=-0.7;
guideh=20.6;
guidewall=1.6; // Measured about 0.8-1, metal
//guidel=123; //124
//guidenarrowingl=16;
guidenarrowingh=16.6;
guideclipw=7.75;
guidecliph=10;
guideclipl=13;//11.85;
guidecliphandlel=12;
guidecliphandled=3;
guideclipdepth=3.5;
guidew=5;
guidecornerd=1;
guideclipwall=1.6;
guideclipattachx=guidex+guideclipwall+10;
guideclipattachl=30;
guideclipcornerd=guideclipwall;
guideclipcut=cut;
guideclipcutl=20;
//guidecliplockdepth=1;
//guidecliplockd=guidecliplockdepth+guideclipwall;
guidecliplockh=6;
guidecliplockl=5;
//guidecliplockx=guidex+guideclipattachl-guidecliplockd/2;
guidecliplockx=guideclipattachx+guideclipattachl-8;
//guidecliplocky=guidesloty+guidecliplockd/2;
guidecliplocky=guidesloty+guideclipwall+ytolerance;
guidecliplockcutl=15;
guideslotoutw=guideclipwall+ytolerance+guideclipwall+ytolerance+guideclipwall;

// Short or long version
short=1;

// Width locking keys as multiple of screw diameter
keywidthmultiplier=1.2; //1.60;

shortversiontext="4.0";
versiontext=str("V",shortversiontext);
textsize=8;

length=short?170-10:170; // Short version
echo("Length ",length);
outsideincornerd=8;
outsidecornerd=outsideincornerd+sidewall*2;
cornerd=1.6;
printable=7;
lockprintable=4;
leftlockprintable=4;
rightlockprintable=5;

// Distance between two slots when they are half-height. This is
// likely case specific and cannot be trusted, but is used to leave
// some gap between slots as some cases have extrusions. Outside
// screws cannot likely be used in that case anyway.  For cases which
// have been measured fixed value of 1 for both.
slotmingap=(aopenversion||guideversion)?0:42.26-41.3;
slotmaxgap=(aopenversion||guideversion)?0:44.2-41.3;

width=146.1; //146;
slimheight=31.5; // About 32mm
halfheight=41.3;
fullheight=82.6;
hpdoubleheight=95;

// Standard say 41.3mm and 82.6mm
height=(slots==3)?min(slots*(halfheight+slotmaxgap),128):(slots==5?214:(slots==4?170:(slots==2?fullheight:(slots==1?halfheight:(slots==0.5?slimheight:(slots==2.5?hpdoubleheight:halfheight))))));

slotgapw=3.8;

//sideztable=[0,halfheight+slotmaxgap,halfheight+slotmaxgap+halfheight+slotmaxgap];
//sidehtable=[0,halfheight-(slotmaxgap-slotmingap),halfheight*2-(slotmaxgap-slotmingap)];

outscrewztable=[10,22.5];
outscrewxtable=[52.3,131.93];
outscrewdiameter=3;
outscrewbase=0.1;
outscrewspringlength=25;
outscrewspringheight=outscrewdiameter*keywidthmultiplier;
outscrewspringangle=simple?0:3;
springgap=0.7;

guideheight=(outscrewztable[0]+outscrewztable[1])/2; // Center of guide

disklength=147;
diskw=xtolerance+101.6+xtolerance; //102.7;
diskh=ztolerance+26.1+ztolerance; // max height can be up to 41.2 but that is also 5.25 max height - needs to be two separate parts in that case
diskxposition=length-disklength+2;
diskx=diskxposition;
disky=width/2-diskw/2;
diskentrywidth=diskw; //105;

diskgaph=1.6; // This may need to be smaller..XXX
smalldiskbottomh=1.8;
diskgapw=8;

// Lightening holes
margin=10;
bar=10;

bottomthickness=2.2;
bottomthin=0.8;
roofthickness=2.2;
roofthin=0.8;
sidebottomthickness=bottomthickness;
sideroofthickness=roofthickness;

diskheight=bottomthickness;
//diskscrewheight=bottomthickness+6.7;
diskscrewheight=6.7;
diskscrewxtable=[16.52,76.71,118.19];
diskscrewdiameter=3; // Old system
diskscrewd=3-dtolerance-0.3;
echo("Disk screwd ",diskscrewd);
diskscrewbase=outscrewbase;
diskscrewspringlength=20;
keyh=max(outscrewdiameter,diskscrewdiameter)*keywidthmultiplier;
diskscrewspringangle=simple?0:3;

smalldiskh=ztolerance+9.5+ztolerance;
smalldiskl=100.45;
smalldiskw=ytolerance+69.82+max(0.25,ytolerance);
smalldiskscrewxtable=[smalldiskl-90.6,smalldiskl-14];
smalldiskyposition=width/2-smalldiskw/2;

diskslotsmax=floor((height-bottomthickness-roofthickness+diskgaph)/(diskh+diskgaph));
diskslots=maxdisks!=-1?(maxdisks>diskslotsmax?diskslotsmax:maxdisks):diskslotsmax;
diskslotstep=diskh+diskgaph;
disksh=diskslots*diskslotstep-(diskslots>0?diskgaph:0);
smalldiskbottomheight=bottomthickness+disksh;
smalldiskheight=smalldiskbottomheight+(diskslots>0?smalldiskbottomh:0);
smalldiskspaceh=height-smalldiskheight-roofthickness;
smalldiskslots=floor((smalldiskspaceh+diskgaph)/(smalldiskh+diskgaph)+0.01);
smalldiskslotstep=smalldiskh+diskgaph;
smalldiskxposition=length-smalldiskl;
smalldiskscrewdiameter=3;
smalldiskscrewheight=3;
smalldiskscrewd=3; // M3
smalldisksh=smalldiskslots*smalldiskslotstep-diskgaph;
  

// Kludge: this is used for both angles even though they are
// independent. Likely best to simply remove independence.
keyanglel=sidewall*sin(diskscrewspringangle)+0.01;

outlockextrah=5.5;
disklockextrah=6.0;
smalldisklockextrah=6.0; // XXX

airholediameterx=35;
airholediametery=19;
airholedistancex=10;
airholedistancey=11;
airholesx=floor((length-airholedistancex)/(airholediameterx+airholedistancex));
airholesy=floor(diskw/(airholediametery+airholedistancey));
airholeslength=airholesx*airholediameterx+(airholesx-1)*airholedistancex;
airholeswidth=airholesy*airholediametery+(airholesy-1)*airholedistancey;
airholexstart=length/2-airholeslength/2;
airholeystart=width/2-airholeswidth/2;

smalldiskairholediameterx=35;
smalldiskairholediametery=19;
smalldiskairholedistancex=10;
smalldiskairholedistancey=11;
smalldiskairholesx=floor((length-smalldiskairholedistancex)/(smalldiskairholediameterx+smalldiskairholedistancex));
smalldiskairholesy=floor(smalldiskw/(smalldiskairholediametery+smalldiskairholedistancey));
smalldiskairholeslength=smalldiskairholesx*smalldiskairholediameterx+(smalldiskairholesx-1)*smalldiskairholedistancex;
smalldiskairholeswidth=smalldiskairholesy*smalldiskairholediametery+(smalldiskairholesy-1)*smalldiskairholedistancey;
smalldiskairholexstart=length/2-smalldiskairholeslength/2;
smalldiskairholeystart=width/2-smalldiskairholeswidth/2;

sidecutwidth=width/2-diskw/2-2*sidewall;
sidecutheight=height-sidebottomthickness-sideroofthickness;

smalldisksidecutwidth=width/2-smalldiskw/2-2*sidewall;
lockwall=1.6;

sideairholediameterx=38;
sideairholediametery=14;
sideairholedistancex=7;
sideairholedistancey=7;
sideairholesx=floor(length/(sideairholediameterx+sideairholedistancex));
sideairholesy=floor(diskw/(sideairholediametery+sideairholedistancey));
sideairholeslength=sideairholesx*sideairholediameterx+(sideairholesx-1)*sideairholedistancex;
sideairholeswidth=sideairholesy*sideairholediametery+(sideairholesy-1)*sideairholedistancey;
sideairholexstart=length/2-sideairholeslength/2;
sideairholeystart=width/2-sideairholeswidth/2;

sidetopairholediameterx=38;
sidetopairholediametery=(smalldiskslots>0)?(slots>1?17:19):11;
sidetopairholedistancex=7;
sidetopairholedistancey=7;
sidetopairholesx=floor(length/(sidetopairholediameterx+sidetopairholedistancex));
sidetopairholesy=floor(diskw/(sidetopairholediametery+sidetopairholedistancey));
sidetopairholeslength=sidetopairholesx*sidetopairholediameterx+(sidetopairholesx-1)*sidetopairholedistancex;
sidetopairholeswidth=sidetopairholesy*sidetopairholediametery+(sidetopairholesy-1)*sidetopairholedistancey;
sidetopairholexstart=length/2-sidetopairholeslength/2;
cutw=smalldiskslots>0?smalldisksidecutwidth:sidecutwidth;
sidetopairholeystart=sidewall+cutw/2-sidetopairholediametery/2+(slots>1?1.5:0); //width/2-sidetopairholeswidth/2;

disklockx=wall+xtolerance;
outlockl=outscrewxtable[1]+outscrewdiameter/2+wall;//length-disklockx;//outscrewxtable[1]+outscrewdiameter*2;//outscrewspringheight; //outscrew2position + outscrewspringheight;
disklockaddl=0;
disklockl=olddisklocksystem?diskxposition+diskscrewxtable[2]+diskscrewdiameter*2:length-disklockx;//diskxposition-disklockx+diskscrewxtable[2]+diskscrewd/2+disklockaddl;
smalldisklockl=smalldiskxposition+smalldiskscrewxtable[1]+diskscrewdiameter*2;//keyh;

lockthickness=2.5;//5;
//springpushergap=0.6;//1;
lockgap=0.7;//0.7;
springpusherbottom=1.5;
springpusherroof=1.5;

lockhandlel=10;
lockhandlethickness=6;

outlockcuth=outscrewspringheight+outlockextrah+lockgap;

outlockh=outscrewspringheight+outlockextrah;
outlockcutw=lockthickness+lockgap;

disklockslideh=1.4;
disklockcornerd=0.8;
disklockslidel=12;//disklockslideh*6;
disklocksink=3+ytolerance;
disklockw=disklockslideh*4;
//disklockh=disklockslideh*3;
disklockwall=1.6;
disklocky=disky-disklockwall-disklockwall; //sidewall
disklockmovement=[0,-disklocksink,0];
disklockh=olddisklocksystem?keyh+disklockextrah:disklockwall*2;//diskscrewd;//disklockslideh*3;
smalldisklockh=keyh+smalldisklockextrah;
disklockcutw=lockthickness+lockgap;
disklockcuth=keyh+disklockextrah+ztolerance*2;
disklocktension=0.9;
disklocktotalw=diskscrewbase+(diskscrewdiameter-diskscrewdiameter/2)/2+diskscrewdiameter/2+disklockwall*2+disklocksink+disklockwall/2;
disklocknotchsink=1;
disklocknotchtrackextrasink=0.2;
disklocknotchd=disklockwall+disklocknotchsink;
//disklocknotchx=diskx+(diskscrewxtable[len(diskscrewxtable)-1]-diskscrewxtable[0])/2+disklockslidel*2+wall;
disklocknotchx=length-disklocknotchd/2;
disklocklowerh=disklockh/2-ztolerance;
disklocknotchcutl=10;

  //disklockcovery=olddisklocksystem?sidewall+sidecutwidth-lockthickness-lockgap-lockwall:disky-sidewall-disklockmovement[1]-disklockwall-ytolerance-disklockwall;
  
// Visual stuff
diskpinin=print>0?0:0;

//echo(disklockcoverh);

diskpinx=wall+xtolerance;
diskpinl=length-xtolerance-wall;
diskpinbodyw=disklockwall+disklockwall/2+disklocknotchsink+ytolerance;
diskpiny=-xtolerance-diskpinbodyw-disklocksink*2;
diskpinw=disklocksink+ytolerance;
diskpinheight=-diskscrewd/2;
diskpinh=disklockwall*2;//diskscrewd;
diskpinslidel=10;
diskpinhandlel=15;
diskpinhandlew=10;//10-0.15+0.5+ytolerance+disklocknotchd/2-disklocknotchsink;
diskpinhandleh=10; //diskpinh;
diskpinhandley=diskpiny;
diskpinhandledepth=0.8;
diskpinhandleheight=diskpinheight+diskpinh/2-diskpinhandleh/2;

disklockendx=diskx+diskscrewxtable[len(diskscrewxtable)-1]-diskscrewd/2;
disklockendll=length-wall-xtolerance*2-(disklockendx+diskscrewd);
disklockenda=atan((disklocksink+disklockwall)/disklockendll);
disklockendl=cos(disklockenda)*disklockendll;
echo(disklockendll,disklockenda,disklockendl);
disklockendd=length_and_depth_to_diameter(disklockendl*2+diskscrewd*2,disklocksink+disklockwall/2+disklocktension);

disklockcoverheight=-diskscrewd/2-ztolerance-disklockwall;
//disklockcovery=diskpiny-ytolerance-disklockwall;
disklockcoverw=olddisklocksystem?disklockwall+ytolerance+disklocksink+ytolerance:ytolerance+disklockwall+disklocksink+disklockwall+ytolerance+disklocksink+diskpinbodyw+ytolerance+disklockwall+ytolerance;
disklockcovery=olddisklocksystem?sidewall+sidecutwidth-lockthickness-lockgap-lockwall:disky-disklockcoverw;
//disklockcoverh=disklockwall+ytolerance+diskpinh+ytolerance+disklockwall;
disklockcoverh=olddisklocksystem?disklockwall+ztolerance+diskscrewd+ztolerance+disklockwall:disklockwall+ytolerance+diskpinh+ytolerance+disklockwall;
disklockcoverfrontl=diskx+diskscrewxtable[0]-xtolerance-diskscrewd/2-disklockwall-diskpinslidel-disklockwall;
disklockcoverfrontw=disklockcoverw-disklocksink-disklockwall;

smalldisklockcuth=keyh+smalldisklockextrah;

smalldisklockhandleh=smalldiskslotstep*(smalldiskslots-1)+smalldiskscrewheight*2;

outlockcoverbottom=outscrewztable[0]-outlockcuth/2-lockwall;

outlockmidwallh=(outscrewztable[1]-outlockcuth/2)-(outscrewztable[0]+outlockcuth/2);

// this probably should be calculated from lockgap; This adjusts steepness of raise behing screwhole insert.
keysupportadjust=0.5;

// Extra length for the hole to allow releasing springpusher in the wrong hole :/
keycutextra=4;
textdepth=0.5;

sidefreez=height-sideroofthickness-bottomthickness-diskscrewheight-disklockcuth/2-lockwall;
sideairholezstart=height-sideroofthickness-sidefreez/2-sideairholediametery/2;

sideslidewall=1.6;
sideslidecornerd=sideslidewall;
sideslideprintable=5;

sideslidelockh=8;
sideslidelockl=6;
//sideslidelockcutl=21;
//sideslidelockbodyl=5+sideslidelockcutl;
sideslideh=headd+1;
sideslideopeningh=ztolerance+sideslideh+ztolerance;
sideslidebasel=outscrewxtable[1]+outscrewdiameter*1.5;
sideslideopeningcutl=sideslidebasel+xtolerance*2;
sideslideopeningl=sideslidebasel;
sideslidew=1.6;
sideslideinw=1.6;


sideslidel=sideslidebasel+1;
sideslideinh=sideslideh+1.6;
sideslideincutl=sideslidel+xtolerance*2; // Allow some bridge droop for printing
sideslideincutx=0;
sideslideincuty=sideslidew-ytolerance;
sideslideincutw=ytolerance+sideslideinw+ytolerance;
sideslideincuth=ztolerance+sideslideinh+ztolerance;

// Locking clip
//sideslidelockcutx=sideslideopeningl+5;
//sideslidelockcuty=-0.01;
sideslidelockcutw=sideslidew-ytolerance+sideslideincutw+0.01;
sideslidelockcut=sideslidew+ytolerance+0.01;
sideslidelockcuth=cut;
sideslidelockcutendh=sideslideincuth;

// Aopen
// Values relative to first screw hole
aopenbrimw=abs?3:0;
aopenx=outscrewxtable[0]-22;
aopenheight=outscrewztable[0]-9.74;
aopenh=16.3;
aopennarrowingh=10;
aopenw=5.4;
aopenl=114;
aopennarrowingl=128;
aopennarrowingw=4.47;
aopencornerd=2;
aopenwall=2;
aopenclipx=aopenx+0.9;

aopenclipw=7.75;
aopenclipdepth=3.5;
aopencliph=9;
aopensloty=-0.7;
aopenclipwall=1.6;
aopenclipattachx=aopenx+22;
aopenclipattachl=30;
aopenclipcornerd=aopenclipwall;
aopenclipcut=cut;
aopenclipcutl=20;
aopencliplockh=5.5;
aopencliplockl=5;
aopencliplockx=aopenclipattachx+aopenclipattachl-8;
aopencliplocky=aopensloty+aopenclipwall+ytolerance;
aopencliplockcutl=15;
aopenslotoutw=aopenclipwall+ytolerance+aopenclipwall+ytolerance+aopenclipwall;
aopencliphandlex=aopenclipx-14.1;
aopencliphandlew=aopenclipw+2;
aopenclipheight=aopenheight+aopenh/2; // Center of guide

// Table for clip height for aopen case for different number of
// slots. Due to clip position, upper position is used for larger slot
// numbers. For larger slot numbers is is possible to use multiple
// clips.
cliptable=[[0],
		[0],
		[1],
		[1],
		[1],
		[1,3],
		[1,3]
		];

// aopen and guide version have been measured. Rest is guesswork and
// is adapted with slotmingap and slotmaxgap
sloth=slots==0.5?slimheight:aopenversion?44:guideversion?42:43;

// Side lighten holes
// 0 no hole
// 1 standard hole
// 2 shortened hole (space for version-dependent clips, screws etc.
// 3 Side slide, guide, aopen, etc
sidelightentables=(guideversion || aopenversion)?[[-1], [3], [1,3], [1,3], [1,3,3], [1,3,1,3], [1,3,1,3,1]]:
  [[-1],
		  [0],
		  [0,1],
		  [0,1],
		  [0,1,1],
		  [0,1,1,1],
		  [0,1,1,1,1],
		  ];

sidelightentable=sidelightentables[slotconfig];

// Fan cover
// Not dimensions are for fan laying flat
fanl=fantype!=-1?fansizetable[fantype][0]:0;
fanw=fanl;
fanscrewl=(fantype!=-1)?fansizetable[fantype][1]:0;
fanscreww=fanscrewl;
fanh=fantype!=-1?fansizetable[fantype][2]:0;
fanzcornerd=fanw-fanscreww;

if (fantype!=-1) echo("Fan type ",fantype," size ",fanw," screws ",fanscrewl," thickness ",fanl);

// XXX goofed up first print, so it is 8-tolerances for compatibility :/
fancliph=8-ztolerance*2;
fanclipl=8-xtolerance*2;
fanclipw=sidewall+1;
fanclipx=8+xtolerance;
fand=fanw-3;
fanscrewd=4.4;

fancoverwall=1.6;
coverwall=fancoverwall;

if (!is_undef(forcefantype)) {
  if (coverwithfan && forcefantype) {
    if (fanw>height-coverwall*2*2) {
      echo("ERROR Fan is too large for ",slots," slots");
    }
  }
 }

frontcornerd=10;
frontincornerd=10-coverwall*2;

fanholderclipl=fanw/2.2;
fanholderclipd=fancoverwall+1.1;
fanholderw=fancoverwall+ytolerance+fanw+ytolerance+fancoverwall;
fanholderh=fancoverwall+ztolerance+fanw+ztolerance+fancoverwall;

// Only generate insides for fan cover if it would be smaller than
// disk width.  For smaller fans, it would help directing the cooling
// air towards the disks.  For larger fans, this is less releavant.

fancoverinsides=(fand+sidewall*2+5<diskw);

fanclipholeh=ztolerance+fancliph+ztolerance;
fanclipheight=diskh-fanclipholeh; // Remove 2 after debugged.;
fanclipholel=xtolerance+8+xtolerance;
fanclipholex=8-xtolerance;
// Inside clips are obsolete, but generate holes anyway for future
//proofing.
//fanclips=disksh>fancliph+fanclipholeh+diskgaph*2?1:0;
fanclipholeheight=fanclipheight-ztolerance;//disksh/2-fancliph/2-fanclipholeh/2; // Centered at height.
fanclipholew=fanclipw+0.02;
fanclipholey=sidewall+sidecutwidth+sidewall+ytolerance-fanclipholew-0.01;
fanheight=height/2;//bottomthickness+disksh/2fanheightt; // Center
fany=width/2;
fanplateh=4.2;
fanwall=1.5;

//fancoverh=bottomthickness+disksh+(smalldiskslots>0?smalldiskbottomh:roofthickness);
//fancoverw=sidewall+diskw+sidewall;
//smalldiskfancoverw=sidewall+smalldiskw+sidewall;
fancoverfanbaseh=1.2;
fanspace=0; // Extra space allow for airflow?
//fancoverdepth=max(fanh+fancoverwall+fancoverfanbaseh+4,fancoverw-(fanw+fancoverwall*2));
coverdepth=(coverwithfan?fanh+fancoverwall+fancoverfanbaseh+fanholderclipd+fanspace:coverwall);
fancoverfrontfanw=fancoverwall+ytolerance+fanw+ytolerance+fancoverwall;
fancoverfrontfanh=fancoverwall+ztolerance+fanw+ztolerance+fancoverwall;
//fancoverfrontw=fancoverw-coverdepth;
//smalldiskfancoverfrontw=smalldiskfancoverw-coverdepth;
//fancoverfronth=fancoverh-coverdepth;
  
fanholderl=xtolerance+fancoverwall+fancoverfanbaseh+fanh+xtolerance+fanholderclipd;

coverfrontshrink=slots>1?coverdepth/3:0;
coverpullshrink1=slots>1?coverfrontshrink-3:0;
coverpullshrink=coverpullshrink1>coverfrontshrink?coverfrontshrink:coverpullshrink1;

// Cover only uses bottom and top clips for easy removal
//fanattachztable=[bottomthickness+fanclipholeheight,bottomthickness+(diskslots-1)*diskslotstep+fanclipholeheight];
fanattachwidth=slots>3?width:diskw;

fantowerd=4-dtolerance;
fantowerh=6+fancoverwall+fancoverfanbaseh;

fancoverprintable=7;

fangrilldepth=2;
fangrillthickness=1.6;

// Outside cover clips
cliph=5.5;
clipl=8;
clipw=sidewall+1;
clipx=6;
clipholeh=ztolerance+cliph+ztolerance;
//clipheighttable=slots>1?[halfheight-outsideincornerd-clipholeh,height-halfheight/2-clipholeh/2]:slots>0.5?[halfheight-outsideincornerd-clipholeh]:[];
//clipheighttable=slots==2.5?[halfheight-outsideincornerd-clipholeh,fullheight-outsideincornerd-clipholeh]:slots==2?[halfheight-outsideincornerd-clipholeh,fullheight-halfheight/2-clipholeh/2]:slots>1?[halfheight-outsideincornerd-clipholeh,fullheight-outsideincornerd-clipholeh]:slots>0.5?[halfheight-outsideincornerd-clipholeh]:[];
//clipheighttable=slots==3?[halfheight-outsideincornerd-clipholeh,height-halfheight/2]:slots==2.5?[halfheight-outsideincornerd-clipholeh,hpdoubleheight-halfheight/2-clipholeh/2]:slots==2?[halfheight-outsideincornerd-clipholeh,hpdoubleheight-halfheight/2-clipholeh/2]:slots>1?[halfheight-outsideincornerd-clipholeh,fullheight-outsideincornerd-clipholeh]:slots>0.5?[halfheight-outsideincornerd-clipholeh]:[];
//oldclipheighttable=[halfheight-outsideincornerd-clipholeh:halfheight+slotmingap:height];
clipholel=xtolerance+clipl+xtolerance;
clipholex=clipx-xtolerance;
clipholew=clipw+0.02;
clipholey=sidewall+ytolerance-clipholew-0.01;

//clipsupporty=sidewall+y
clipsupportw=sidewall+coverwall+5+ytolerance;
clipsupportl=coverdepth-xtolerance;//coverwall+fanholderl+ytolerance;
clipsupportlowheight=halfheight/2;
clipsupportlowh=clipsupportlowheight-maxbridge;
clipspringw=1.2;//2;
clipspringl=8;
clipspringh=clipsupportlowh+maxbridge+cliph;
clipspringx=-clipspringl-xtolerance;
clipsupportcornerd=clipspringw;

clipcutx=min(coverdepth-coverwall,15); 
fingerholel=10;
fingerholedepth=1;
fingerholed=length_and_depth_to_diameter(fingerholel,fingerholedepth);
fingerholey=-width/2-fingerholed/2+fingerholedepth;
clippressfingerholex=-4-fingerholel/2;
clippressl=3+fingerholel+2;
clipcutl=clipcutx+xtolerance;

lockfingerspacel=15;
lockfingerspacew=12;
lockfingerspaceh=20;

smalldisklockfingerspacel=15;
smalldisklockfingerspacew=12;
smalldisklockfingerspaceh=11;

// Cover clip
oldcoverclipl=5;
oldcovercliph=2;
oldcoverclipd=oldcovercliph+ztolerance+0.5;
oldcoverclipw=smalldiskw-10;
oldcoverclipx=oldcoverclipl-oldcoverclipd/2;

// New cover clip system using lockclip()
coverclipwall=1.6;
coverclipoverhang=1.4;
coverclipw=3.3;
coverclipl=8;
coverclipbodyh=4;
covercliph=20;
coverclipoutl=coverclipl+coverclipwall*2+dtolerance*2+coverclipoverhang*2;
coverclipoutw=coverclipw+coverclipwall*2+dtolerance*2;
coverclipcut=coverclipoverhang*2+xtolerance*2;
coverclipoverhangh=6.5;
coverclipcuth=covercliph-coverclipbodyh/2+coverclipoverhangh;
coverclipxoffset=coverclipwall*3;
coverclipyoffset=coverclipwall*3;
covercliptotalh=covercliph+coverclipbodyh*2+coverclipoverhangh;
coverclipy=outsidecornerd/2+coverclipoutl/2;//coverclipw/2+ytolerance+sidewall;
coverclipx=covercliph/2-ztolerance-fancoverwall-ztolerance*2;
coverclipztable=[coverclipoutw/2,height-coverclipoutw/2];
//coverclipzstep=sloth;//halfheight+slotmaxgap;
//firstcoverclipheight=halfheight/2+coverclipl/2+wall*1.5+coverclipoverhang;//slots>=2?halfheight/2+coverclipzstep:halfheight/2+coverclipzstep;
//coverclipheighttable=slots>3?[firstcoverclipheight+coverclipzstep,firstcoverclipheight+(slots-2)*coverclipzstep]:

//slots>2?[firstcoverclipheight+coverclipzstep]:
//slots==2?[firstcoverclipheight]:
//  [];
covercliptotall=covercliph+coverclipbodyh*2+coverclipoverhang*2-ztolerance*2+coverclipwall*2;

coverclipfingerspace=10;

// If no fan, make some cooling holes
coolingslith=4;
coolingslitgap=2.5;
coolingw=smalldiskw-5;
coolingh=height-(bottomthickness+ztolerance+oldcovercliph)*2;
coolingslitw=coolingw/2-5;
coolingslity=coolingslitgap/2;
coolingslits=floor(coolingh/(coolingslith+coolingslitgap));
coolingslitsh=coolingslits>0?coolingslith*coolingslits+coolingslitgap*(coolingslits-1):coolingslith;
coolingheight=height/2-coolingslitsh/2;
coolingtop=height/2+coolingslitsh/2;

midh=outscrewztable[1]-sideslidelockcutendh/2-(outscrewztable[0]+sideslidelockcutendh/2);
midheight=sideslidelockcutendh/2;
//sideslidelockx=sideslidebasel+sideslidelockbodyl-3-sideslidelockl;
//bothl=sideslidelockl+5-0.5-1;
//bothx=sideslidelockx+sideslidelockl/2-bothl/2;

//bothcuttable=[bothx-cut];
lockendspringh=8;
lockendspringtoph=slots>0.5?8:0;

sideslidelockcuty=sideslideincuty+sideslidewall+ytolerance; //+ytolerance
sideslidelockcutl=cut+sideslidelockl+cut;
sideslideinbasex=19+xtolerance;//15;
sideslideinbasel=22-xtolerance;//24;
sideslideinbasecutl=sideslideinbasel-0.5-cut;
sideslidelockx=sideslideinbasex+sideslideinbasel;
sideslidelockcutx=sideslidelockx-0.5;
//sideslidelockspringx=25;
sideslidelockspringw=sideslideinw;

bothinl=sideslidelockl+1;
bothinx=sideslidelockx-0.5;//+sideslidelockl/2-bothinl/2;
bothincutl=cut+bothinl+cut;
bothincutx=bothinx-cut;

// Cover heat wall is about height, but for larger objects heatwall
// seems less critical after the base has been generated.
heatwallh=print==5?coverdepth:40;

module fan() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) translate([-fanl/2,-fanw/2,-fanh/2]) roundedboxxyz(fanl,fanw,fanplateh,fanzcornerd,cornerd,0,fn);
      translate([0,0,0]) cylinder(d=fand,h=fanh,$fn=fn,center=true);
    }
    translate([0,0,0]) cylinder(d=fand-fanwall*2,h=fanh+0.02,$fn=fn,center=true);

    for (n=[0,1]) mirror([0,n,0]) for (m=[0,1]) mirror([m,0,0]) translate([-fanscrewl/2,-fanscreww/2,-fanh/2-0.01]) cylinder(d=fanscrewd,fanh+0.02,$fn=smallfn);
  }
}

module tappi(screwdiameter,screwbase) {
  hull() {
    cylinder(h=screwbase+0.4,d=screwdiameter,$fn=30);
    translate([0,0,screwbase+0.1+(screwdiameter-screwdiameter/2)/2]) sphere(d=screwdiameter/2,$fn=30);
    // echo("Tappidepth", screwbase+0.1+(screwdiameter-screwdiameter/2)/2+screwdiameter/2/2);
  }
}

keycornerd=1.5;

module key(keylength,keywidth,keythickness,keyscrewdiameter,keyscrewdepth) {
  union() {
    translate([-keyanglel,-keywidth/2,0]) union () {
      hull() {
	translate([-keycornerd/2,0,0])  roundedbox(keylength+keyanglel+keycornerd,keywidth,keythickness,keycornerd,0);
	translate([keylength+keyanglel,keywidth/2,1]) roundedcylinder(keywidth,keythickness-1,keycornerd,0,smallfn);
      }
      hull() {
	translate([keylength/2+keyanglel,keywidth/2,1]) roundedcylinder(keycornerd,keythickness-1,keycornerd,0,smallfn);
	translate([keylength+keyanglel,keywidth/2,1]) roundedcylinder(keywidth,keythickness-1,keycornerd,0,smallfn);
	translate([keylength+keyanglel+0.5+2,keywidth/2,keythickness-1]) roundedcylinder(keywidth-1,1,1,0,smallfn);
	if (!simple) {
	  translate([keylength+keyanglel,keywidth/2,0.5]) resize([0,0,sidewall-0.3]) sphere(d=keywidth,$fn=smallfn);
	}
      }
      translate([keylength+keyanglel,keywidth/2,keythickness]) tappi(keyscrewdiameter-dtolerance,keyscrewdepth);
    }
  }
}

// This is centered on key
module keycut(keycutlength,keycutwidth,keycutthickness) {
  translate([-0.01,-springgap-keycutwidth/2,-0.01]) cube([keycutlength+keycutextra+springgap*2+0.02,keycutwidth+springgap*2,keycutthickness+0.02]);
}

module sideslide() {
  intersection() {
    translate([0,0,-sideslideincuth/2-sideslidewall]) cube([length,width,sideslidewall+sideslideincuth+sideslidewall]);
    hull() {
      translate([-cornerd/2,sidewall,-sideslideincuth/2-sideslidewall]) roundedbox(cornerd/2+sideslideincutl+xtolerance+sideslidewall,sideslideincuty+sideslideincutw+sideslidewall-sidewall,sideslidewall+sideslideincuth+sideslidewall,cornerd,printable);
      translate([-cornerd/2,sidewall-cornerd,-sideslideincuth/2-sideslidewall]) roundedbox(cornerd/2+sideslideincutl+xtolerance+sideslidewall,sideslideincuty+sideslideincutw+sideslidewall-sidewall+cornerd,sideslidewall+sideslideincuth+sideslidewall,cornerd,printable);
      translate([sideslideopeningl,sidewall-cornerd,-sideslideincuth/2-sideslidewall+cornerd]) roundedbox(sideslideincutl+xtolerance+sideslidewall+sideslidewall*2-sideslideopeningl,sideslidewall,sideslidewall+sideslideincuth+sideslidewall-cornerd-(slots<1?cornerd:0),cornerd,printable);
    }
  }

  translate([0,-1.2,-sideslideopeningh/2-0.8]) cube([0.6,1.4,0.4]);
  translate([0,-1.2,-sideslideopeningh/2-0.8]) cube([0.6,0.4,sideslideopeningh+0.8*2]);
  translate([0,-1.2,sideslideopeningh/2+0.4]) cube([0.6,1.4,0.4]);
}

module sideslidecut(lower) {
  difference() {
    union() {
      hull() {
	translate([-0.01,-0.01,-sideslideopeningh/2]) cube([sideslideopeningcutl+0.01,0.01+sideslidew,sideslideopeningh]);
	translate([-0.01,sideslideincuty,-sideslideincuth/2]) cube([sideslidel+xtolerance*2+0.02,sideslideincutw,sideslideincuth]);
      }

      translate([sideslidelockcutx+sideslidelockcutl-0.01,sideslidew*2,-sideslideinh/2-ztolerance]) cube([cut+1,sideslidew+ytolerance+0.01,sideslideinh+ztolerance*2]); 
      if (lower) {
	translate([bothincutx,sideslidelockcuty-ytolerance-0.01,midheight-cut]) cube([cut,cut+sideslidew+cut+0.01,cut+midh+cut]);
	translate([bothincutx,sideslidelockcuty-ytolerance,midheight-cut]) cube([bothincutl,cut,cut+midh+cut]);
	for (z=[midheight-cut,midheight+midh]) {
	  translate([sideslideinbasex,sideslidelockcuty-ytolerance,z]) cube([sideslideinbasecutl+cut,cut+sideslidelockspringw+cut,cut]);
	}
	for (z=[-sideslideinh/2-ztolerance]) {
	  translate([sideslideinbasex,sideslidelockcuty-ytolerance,z]) cube([sideslideinbasel+sideslidelockcutl+cut,cut+sideslidelockspringw+cut,cut]);
	}
	hull() {
	  translate([sideslidelockcutx+sideslidelockcutl,sideslidelockcuty-cut+ytolerance-0.01,-sideslidelockcutendh/2]) cube([cut,sideslidew+cut+0.01,sideslidelockcutendh+midh+cut+ztolerance]);
	  translate([sideslidelockcutx+sideslidelockcutl,sideslidew*3+ytolerance+0.01,-sideslidelockcutendh/2]) cube([cut+sideslidew*3-sideslidelockcuty-ytolerance+cut,cut,sideslidelockcutendh+midh+cut+ztolerance]);
	}
      } else {
	if (slots<1) translate([bothincutx,sideslidelockcuty-0.01,sideslidelockcutendh/2-cut]) cube([cut+bothl+cut,sideslidew-ytolerance+cut+0.02,cut+lockendspringtoph]);
	hull() {
	  translate([sideslidelockcutx+sideslidelockcutl,sideslidelockcuty-cut+ytolerance-0.01,-sideslidelockcutendh/2]) cube([cut,sideslidew+cut+0.01,sideslidelockcutendh+lockendspringtoph]);
	  translate([sideslidelockcutx+sideslidelockcutl,sideslidew*3+ytolerance+0.01,-sideslidelockcutendh/2]) cube([cut+sideslidew*3-sideslidelockcuty-ytolerance+cut,cut,sideslidelockcutendh+lockendspringtoph]);
	}
	for (z=[sideslideinh/2-ztolerance]) {
	  translate([sideslideinbasex,sideslidelockcuty-ytolerance,z]) cube([sideslideinbasecutl+cut,cut+sideslidelockspringw+cut,cut]);
	}
	translate([bothincutx,sideslidelockcuty-ytolerance,sideslideinh/2-ztolerance]) cube([cut,cut+sideslidelockspringw+cut,lockendspringtoph+cut]);
	translate([bothincutx,sideslidelockcuty-ytolerance,sideslideinh/2-ztolerance]) cube([bothincutl,cut,lockendspringtoph+cut]);
      }
    }

    hull() {
      translate([sideslidelockx,sideslidelockcuty+ytolerance,-sideslidelockh/2+ztolerance]) cube([sideslidelockl,sideslidewall,sideslidelockh-ztolerance*2]);
      translate([sideslidelockx+sideslidelockl-1,sideslidewall/2,-sideslidelockh/2+ztolerance+sideslidewall*2]) cube([1,sideslidewall*2.5+ytolerance,sideslidelockh-ztolerance*2-sideslidewall*4]);
    }
  }
}

module sideslidebody() {
  difference() {
    union() {
      hull() {
	//	translate([0,sideslidewall,-sideslideinh/2]) roundedbox(sideslidel,sideslidewall,sideslideinh,sideslidecornerd,sideslideprintable);
	//	translate([0,0,-sideslideh/2]) roundedbox(sideslidebasel,sideslidewall+sideslidecornerd,sideslideh,sideslidecornerd,sideslideprintable);
	translate([0,sideslidewall-ytolerance,-sideslideinh/2]) cube([sideslidel,sideslidewall+ytolerance,sideslideinh]);
	translate([0,0,-sideslideh/2]) cube([sideslidebasel,sideslidewall+sideslidecornerd,sideslideh]);
      }
    }

    translate([sideslidelockx-xtolerance,-0.01,-(sideslidelockh-2)/2]) cube([xtolerance+sideslidelockl+xtolerance,0.01+sideslidewall+sideslidewall+0.01,sideslidelockh-2]);

    translate([sideslidecornerd+1,textdepth-0.01,0]) rotate([90,0.0]) linear_extrude(height=textdepth) text(versiontext,size=min(textsize,sideslideinh)-sideslidecornerd-1,halign="left",valign="center");
  }
}

module sideslideheads() {
  sideslidebody();
  for (x=outscrewxtable) {
    translate([x,-headh,0]) rotate([-90,0,0]) roundedcylinder(headd,headh+headcornerd+0.01,headcornerd,0,fn);
  }
}

module sideslidescrewholes() {
  difference() {
    union() {
      sideslidebody();
    }
    for (x=outscrewxtable) {
      translate([x,-0.01,0]) rotate([-90,0,0]) cylinder(d=diskscrewholed,sideslidewall+sideslidewall+0.02,$fn=fn);
    }
  }
}

// TBD, special version of sideslide with a guide case
module sideslideclips() {
  sideslidebody();

  translate([0,-sideslidecornerd,-sideslideh/2]) roundedbox(sideslidebasel,sideslidewall+sideslidecornerd+sideslidecornerd,sideslideh,sideslidecornerd,sideslideprintable);
  
}

module guideclipshape(p) {
  translate([0,0,-guidecliph/2]) roundedbox(guideclipwall,guideclipwall,guidecliph,guideclipcornerd,p);
}

module guideclipnobrim() {
  difference() {
    union() {
      hull() {
	translate([guideclipattachx-guideclipwall,guidesloty+guideclipwall+ytolerance,0]) guideclipshape(1);
	translate([guideclipattachx+guideclipattachl-guideclipwall,guidesloty+guideclipwall+ytolerance,0]) guideclipshape(1);
      }
      hull() {
	translate([guideclipattachx-guideclipwall,guidesloty+guideclipwall+ytolerance,0]) guideclipshape(1);
	translate([guideclipx,-guideclipw-guideclipwall,0]) guideclipshape(1);
      }
      hull() {
	translate([guideclipx,-guideclipw-guideclipwall,0]) guideclipshape(1);
	translate([guideclipx-guideclipdepth/3,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
      }
      hull() {
	translate([guideclipx-guideclipdepth/3,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
	translate([0,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
      }
      hull() {
	for (x=[-guideclipcornerd/2,0]) {
	  translate([x,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
	  translate([x,-guideclipw-guideclipwall,0]) guideclipshape(1);
	}
      }
    }

    translate([guidecliplockx-0.01,guidecliplocky-0.01,-guidecliplockh/2-0.01]) cube([guidecliplockl+0.02,guideclipwall+0.02,guidecliplockh+0.02]);

    translate([guideclipattachx+1,guidesloty+guideclipwall+ytolerance+textdepth-0.01,0]) rotate([90,0.0]) linear_extrude(height=textdepth) text(versiontext,size=min(textsize,guidecliph-guideclipcornerd-1)-1,halign="left",valign="center");
  }
}

module guideclip() {
  if (abs && print>0) {
    translate([0,0,-guidecliph/2]) {
      difference() {
	brim(w=guidebrimw) translate([0,0,guidecliph/2]) guideclipnobrim();
	brimcut(w=guidebrimw) translate([0,0,guidecliph/2]) guideclipnobrim();
      }
    }
  }
  guideclipnobrim();
}

module guide() {
  w=ytolerance+guideclipwall+ytolerance+guideclipwall;
  
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) {
	  hull() {
	    translate([guidex,-guidew,-guideh/2]) roundedbox(guidel-guidenarrowingl,guidew+guidewall,guidewall,guidecornerd);
	    translate([guidex-guidew,0,-guideh/2]) roundedbox(guidel-guidenarrowingl,guidewall,guidewall,guidecornerd);
	  }
	  hull() {
	    translate([guidex+guidel-guidenarrowingl-guidecornerd,-guidew,-guideh/2]) roundedbox(guidecornerd,guidew+guidewall,guidewall,guidecornerd);
	    translate([guidex+guidel-guidecornerd,-guidew,-guidenarrowingh/2]) roundedbox(guidecornerd,guidew+guidewall,guidewall,guidecornerd);
	  }
	}

      hull() {
	translate([guideclipattachx,guidesloty,-guidecliph/2-ztolerance-guideclipwall]) roundedbox(guideclipattachl+guideclipwall*2+xtolerance,guideslotoutw,guideclipwall+ztolerance+guidecliph+ztolerance+guideclipwall,guideclipcornerd,0);
	translate([guidex+guideclipwall-guideslotoutw/2,guidesloty+guideslotoutw/2-guideclipcornerd/2,-guidecliph/2-ztolerance-guideclipwall]) roundedbox(guideclipattachl,guideclipcornerd,guideclipwall+ztolerance+guidecliph+ztolerance+guideclipwall,guideclipcornerd,0);
      }

      translate([0,-1.2,-guidecliph/2-0.8]) cube([0.6,1.4,0.4]);
      translate([0,-1.2,-guidecliph/2-0.8]) cube([0.6,0.4,guidecliph+0.8*2]);
      translate([0,-1.2,guidecliph/2+0.4]) cube([0.6,1.4,0.4]);
    }
  }
}

module guidecut() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) {
	  translate([guideclipattachx+guideclipattachl-guideclipcutl,guidesloty-0.01,-guidecliph/2-guideclipcut]) cube([guideclipcutl+guideclipcut,guideclipwall+0.02,guideclipcut]);
	}
      hull() {
	h=guidecliph+guideclipcut*2;
	xd=h>maxbridge?(h-maxbridge)/2:0;
	
	translate([guideclipattachx+guideclipattachl,guidesloty-0.01,-guidecliph/2-guideclipcut]) cube([guideclipcut,guideclipwall+0.02,guideclipcut+guidecliph+guideclipcut]);
	translate([guideclipattachx+guideclipattachl+xd,guidesloty-0.01,-maxbridge/2]) cube([guideclipcut,guideclipwall+0.02,maxbridge]);
      }
      
      translate([-0.01,guidesloty-0.01,-guidecliph/2-ztolerance]) cube([guideclipattachx+guideclipwall,guideslotoutw+0.02,ztolerance+guidecliph+ztolerance]);
      translate([-0.01,guidesloty+guideclipwall,-guidecliph/2-ztolerance]) cube([guideclipattachx+guideclipcut*2+guideclipattachl,ytolerance+guideclipwall+ytolerance,ztolerance+guidecliph+ztolerance]);
    }
    hull() {
      translate([guidecliplockx+xtolerance,guidesloty,-guidecliplockh/2+ztolerance]) cube([guidecliplockl-xtolerance*2,guideclipwall,guidecliplockh-ztolerance*2]);
      translate([guidecliplockx+xtolerance+guidecliplockl-xtolerance*2-1,guidesloty,-guidecliplockh/2+ztolerance+guideclipwall]) cube([1,guideclipwall+ytolerance+guideclipwall,guidecliplockh-ztolerance*2-guideclipwall*2]);
    }
  }
}

module aopenclipshape(p) {
  difference() {
    translate([0,0,-aopencliph/2]) roundedbox(aopenclipwall,aopenclipwall,aopencliph,aopenclipcornerd,p);
    translate([0,0,-aopencliph/2-0.01]) cube([aopenclipwall,aopenclipwall,+0.01]);
  }
}

module aopenclipnobrim() {
  difference() {
    union() {
      hull() {
	translate([aopenclipattachx-aopenclipwall,guidesloty+aopenclipwall+ytolerance,0]) aopenclipshape(1);
	translate([aopenclipattachx+aopenclipattachl-aopenclipwall,guidesloty+aopenclipwall+ytolerance,0]) aopenclipshape(1);
      }
      hull() {
	translate([aopenclipattachx-aopenclipwall,guidesloty+aopenclipwall+ytolerance,0]) aopenclipshape(1);
	translate([aopenclipx,-aopenclipw-aopenclipwall,0]) aopenclipshape(1);
      }
      hull() {
	translate([aopenclipx,-aopenclipw-aopenclipwall,0]) aopenclipshape(1);
	translate([aopenclipx-aopenclipdepth/3,aopenclipdepth-aopenclipw-aopenclipwall,0]) aopenclipshape(1);
      }
      hull() {
	translate([aopenclipx-aopenclipdepth/3,aopenclipdepth-aopenclipw-aopenclipwall,0]) aopenclipshape(1);
	translate([aopencliphandlex,aopenclipdepth-aopenclipw-aopenclipwall,0]) aopenclipshape(1);
      }
      hull() {
	for (x=[-aopenclipcornerd/2+aopencliphandlex-1,aopencliphandlex]) {
	  translate([x,aopenclipdepth-aopenclipw-aopenclipwall,0]) aopenclipshape(1);
	  translate([x,-aopencliphandlew-aopenclipwall,0]) aopenclipshape(1);
	}
      }
    }

    translate([aopencliplockx-0.01,aopencliplocky-0.01,-aopencliplockh/2-0.01]) cube([aopencliplockl+0.02,aopenclipwall+0.02,aopencliplockh+0.02]);

    translate([aopenclipattachx+1,guidesloty+aopenclipwall+ytolerance+textdepth-0.01,0]) rotate([90,0.0]) linear_extrude(height=textdepth) text(versiontext,size=min(textsize,aopencliph-aopenclipcornerd-1)-1,halign="left",valign="center");
  }
}

module aopenclip() {
  if (abs && print>0) {
    translate([0,0,-aopencliph/2]) {
      difference() {
	brim(w=aopenbrimw) translate([0,0,aopencliph/2]) aopenclipnobrim();
	brimcut(w=aopenbrimw) translate([0,0,aopencliph/2]) aopenclipnobrim();
      }
    }
  }
  aopenclipnobrim();
}

module aopenguide() {
  hull() {
    translate([aopenx,-aopenw,aopenheight]) roundedbox(aopenl,aopenw+outsideincornerd/2+aopencornerd,aopenwall,aopencornerd,0);
    translate([aopenx-aopenw,outsideincornerd/2+aopencornerd-aopenwall,aopenheight]) roundedbox(aopenl+aopenw,aopenwall,aopenwall,aopencornerd,0);
  }
  hull() {
    translate([aopenx+aopenl-aopencornerd,-aopenw,aopenheight]) roundedbox(aopencornerd,aopenw+sidewall+aopencornerd/2,aopenwall,aopencornerd,0);
    translate([aopenx+aopennarrowingl-aopencornerd,-aopennarrowingw,aopenheight+(aopenh-aopennarrowingh)/2]) roundedbox(aopencornerd,aopennarrowingw+aopencornerd/2,aopenwall,aopencornerd,0);
  }

  hull() {
    translate([aopenx,-aopenw,aopenheight+aopenh-aopenwall]) roundedbox(aopenl,aopenw+aopencornerd/2,aopenwall,aopencornerd,0);
    translate([aopenx-aopenw,0,aopenheight+aopenh-aopenwall]) roundedbox(aopenl+aopenw,aopenwall,aopenwall,aopencornerd,0);
  }
  hull() {
    translate([aopenx+aopenl-aopencornerd,-aopenw,aopenheight+aopenh-aopenwall]) roundedbox(aopencornerd,aopenw+aopencornerd,aopenwall,aopencornerd,0);
    translate([aopenx+aopennarrowingl-aopencornerd,-aopennarrowingw,aopenheight+aopenh-(aopenh-aopennarrowingh)/2-aopenwall]) roundedbox(aopencornerd,aopennarrowingw+aopencornerd/2,aopenwall,aopencornerd,0);
  }

}

module aopen() {
  difference() {
    union() {
      aopenguide();

      translate([0,0,aopenh/2]) {
	hull() {
	  translate([aopenclipattachx,aopensloty,-aopencliph/2-ztolerance-aopenclipwall]) roundedbox(aopenclipattachl+aopenclipwall*2+xtolerance,aopenslotoutw,aopenclipwall+ztolerance+aopencliph+ztolerance+aopenclipwall,aopenclipcornerd,0);
	  translate([aopenx+aopenclipwall-aopenslotoutw/2,aopensloty+aopenclipcornerd,-aopencliph/2-ztolerance-aopenclipwall]) roundedbox(aopenclipattachl,aopenclipcornerd,aopenclipwall+ztolerance+aopencliph+ztolerance+aopenclipwall,aopenclipcornerd,0);
	}

	translate([0,-1.2,-aopencliph/2-0.8]) cube([0.6,2.4,0.4]);
	translate([0,-1.2,-aopencliph/2-0.8]) cube([0.6,0.4,aopencliph+0.8*2]);
	translate([0,-1.2,aopencliph/2+0.4]) cube([0.6,1.4,0.4]);
      }
    }
  }
}

module aopencut() {
  translate([0,0,aopenh/2]) {
    difference() {
      union() {
	for (m=[0,1]) mirror([0,0,m]) {
	    translate([aopenclipattachx+aopenclipattachl-aopenclipcutl,aopensloty-0.01,-aopencliph/2-aopenclipcut]) cube([aopenclipcutl+aopenclipcut,aopenclipwall+0.02,aopenclipcut]);
	  }
	hull() {
	  h=aopencliph+aopenclipcut*2;
	  xd=h>maxbridge?(h-maxbridge)/2:0;
	
	  translate([aopenclipattachx+aopenclipattachl,aopensloty-0.01,-aopencliph/2-aopenclipcut]) cube([aopenclipcut*2,aopenclipwall+0.02,aopenclipcut+aopencliph+aopenclipcut]);
	  translate([aopenclipattachx+aopenclipattachl+xd,aopensloty-0.01,-maxbridge/2]) cube([aopenclipcut,aopenclipwall+0.02,maxbridge]);
	}

	// Open bottom of wall
	translate([-0.01,aopensloty-0.01,-aopencliph/2-ztolerance]) cube([aopenclipattachx+aopenclipwall+0.01,aopenslotoutw+0.02,ztolerance+aopencliph+ztolerance]);

	// Hole to insert clip into
	translate([-0.01,aopensloty+aopenclipwall,-aopencliph/2-ztolerance]) cube([aopenclipattachx+aopenclipwall+aopenclipattachl,ytolerance+aopenclipwall+ytolerance,ztolerance+aopencliph+ztolerance]);
      }
      hull() {
	translate([aopencliplockx+xtolerance,aopensloty,-aopencliplockh/2+ztolerance]) cube([aopencliplockl-xtolerance*2,aopenclipwall,aopencliplockh-ztolerance*2]);
	translate([aopencliplockx+xtolerance+aopencliplockl-xtolerance*2-1,aopensloty,-aopencliplockh/2+ztolerance+aopenclipwall]) cube([1,aopenclipwall+ytolerance+aopenclipwall,aopencliplockh-ztolerance*2-aopenclipwall*2]);
      }
    }
  }
}

module smalldisklockcover(h,cuth,n) {
  translate([0,0,-cornerd/2]) roundedbox(smalldisklockl+locktopspace+lockwall,lockwall+lockthickness+lockgap+0.01+lockwall,smalldiskslotstep*(n-1)+smalldiskscrewheight*2+diskgaph+cornerd/2,cornerd,printable);
}


module smalldisklockcut(h,cuth,n) {
  translate([-0.01,lockwall,0]) cube([smalldisklockl+locktopspace+0.02,lockthickness+lockgap,smalldisklockhandleh]);

  hull() {
    translate([-0.01,-0.01,0]) cube([lockhandlel+0.01,lockwall+0.02,smalldisklockhandleh]);
    if (smalldiskslots==1) {
      translate([-ztolerance-0.01,-0.01,smalldisklockhandleh-0.01]) cube([lockhandlel+smalldisklockhandleh*1.3,lockwall+0.02,0.01]);
    }
    if (smalldiskslots==2) {
      translate([0,-0.01,smalldisklockhandleh/2-0.005]) cube([lockhandlel+smalldisklockhandleh/2*1.3,lockwall+0.02,0.01]);
    }

    if (smalldiskslots>2) {
      translate([-ztolerance+lockhandlel,-0.01,smalldisklockhandleh/2-maxbridge/2]) cube([(smalldisklockhandleh/2-maxbridge/2)*1.3,lockwall+0.02,maxbridge]);
    }
  }
}

module screwtappi(h=1,d=diskscrewd) {
  hull() {
    roundedcylinder(d,h-d/2,cornerd,0,90);
    translate([0,0,h-d/2]) sphere(d=d/2,$fn=30);
  }
}

module disklock() {
  printable=1;
  midl=diskscrewxtable[len(diskscrewxtable)-1]-diskscrewxtable[0];
  xx=diskx+diskscrewxtable[0]-diskscrewd/2;
  ll=xx-(disklockx+xtolerance*2);
  a=atan((disklocksink+disklockwall)/ll);
  l=cos(a)*ll;
  x=xx-l;
  echo(xx,ll,a,x,l);
  d=length_and_depth_to_diameter(l*2+diskscrewd*2,disklocksink+disklockwall/2+disklocktension);
      
  difference() {
    union() {
      translate([diskpinin==1?disklockx:diskx+diskscrewxtable[0]-diskscrewd/2-disklockwall,diskpinin?0:-disklocksink,-diskscrewd/2]) roundedbox(diskpinin==1?disklockl-xtolerance-wall:midl+diskscrewd+disklockwall*2,disklockwall,disklockh,disklockcornerd,printable);

      // Springs
      if (diskpinin==0) {
	intersection() {
	  union() {
	    translate([xx,d/2-disklocksink+disklockwall/2,0]) rotate_extrude(convexity=10,$fn=180,start=180+45,angle=45) {
	      hull() {
		for (xx=[d/2-disklockwall/2+disklockcornerd/2,d/2+disklockwall/2-disklockcornerd/2]) {
		  for (yy=[-diskscrewd/2+disklockcornerd/2,-diskscrewd/2+disklockh-disklockcornerd/2]) {
		    translate([xx,yy,0]) circle(d=disklockcornerd,$fn=30);
		  }
		}
		translate([d/2-disklockwall/2+disklockcornerd/4,-disklockh/2]) square([disklockwall-disklockcornerd/2,disklockh/2]);
	      }
	    }
	  }
	  translate([x,-disklocksink,-diskscrewd/2]) roundedbox(l,disklockwall+disklocksink+disklocktension,disklockh,disklockcornerd,printable);
	}

	intersection() {
	  union() {
	    translate([disklockendx+diskscrewd,disklockendd/2-disklocksink+disklockwall/2,0]) rotate_extrude(convexity=10,$fn=180,start=270,angle=45) {
	      hull() {
		for (xx=[disklockendd/2-disklockwall/2+disklockcornerd/2,disklockendd/2+disklockwall/2-disklockcornerd/2]) {
		  for (yy=[-diskscrewd/2+disklockcornerd/2,-diskscrewd/2+disklockh-disklockcornerd/2]) {
		    translate([xx,yy,0]) circle(d=disklockcornerd,$fn=30);
		  }
		}
		translate([disklockendd/2-disklockwall/2+disklockcornerd/4,-disklockh/2]) square([disklockwall-disklockcornerd/2,disklockh/2]);
	      }
	    }
	  }
	  translate([disklockendx+diskscrewd,-disklocksink,-diskscrewd/2]) roundedbox(disklockendl,disklockwall+disklocksink+disklocktension,disklockh,disklockcornerd,printable);
	}
      }

      // Slides used to push diskscrew pegs in
      x1=diskx+diskscrewxtable[0]-diskscrewd/2;
      l1=disklockslidel;//x1-disklockx;
      d1=length_and_depth_to_diameter(l1*2+diskscrewd*2,disklocksink+disklockwall);

      translate([0,diskpinin?0:-disklocksink,0]) {
	intersection() {
	  union() {
	    translate([x1+diskscrewd-disklockcornerd/2,d1/2-disklocksink+disklockwall/2,0]) rotate_extrude(convexity=10,$fn=180,start=270,angle=45) {
	      hull() {
		for (xx=[d1/2-disklockwall/2+disklockcornerd/2,d1/2+disklockwall/2-disklockcornerd/2]) {
		  for (yy=[-diskscrewd/2+disklockcornerd/2,-diskscrewd/2+disklockh-disklockcornerd/2]) {
		    translate([xx,yy,0]) circle(d=disklockcornerd,$fn=30);
		  }
		}
		translate([d1/2-disklockwall/2+disklockcornerd/4,-disklockh/2]) square([disklockwall-disklockcornerd/2,disklockh/2]);
	      }
	    }
	  }
	  translate([disklockx+l+diskscrewd,-disklocksink,-diskscrewd/2]) roundedbox(l1+disklockwall,disklockwall+disklocksink,disklockh,disklockcornerd,printable);
	}
	translate([xx,-disklocksink,-diskscrewd/2]) roundedbox(diskscrewd,disklockwall/2+disklocksink,diskpinh,disklockcornerd,printable);

	hull() {
	  intersection() {
	    union() {
	      translate([disklockendx+diskscrewd-disklockcornerd/2,d1/2-disklocksink+disklockwall/2,0]) rotate_extrude(convexity=10,$fn=180,start=270,angle=45) {
		hull() {
		  for (xx=[d1/2-disklockwall/2+disklockcornerd/2,d1/2+disklockwall/2-disklockcornerd/2]) {
		    for (yy=[-diskscrewd/2+disklockcornerd/2,-diskscrewd/2+disklocklowerh-disklockcornerd/2]) {
		      translate([xx,yy,0]) circle(d=disklockcornerd,$fn=30);
		    }
		  }
		  translate([d1/2-disklockwall/2+disklockcornerd/4,-disklockh/2]) square([disklockwall-disklockcornerd/2,disklocklowerh]);
		}
	      }
	    }
	    translate([disklockendx,-disklocksink-disklockwall,-diskscrewd/2]) roundedbox(l1+disklockwall,disklockwall+disklocksink,disklocklowerh,disklockcornerd,printable);
	  }
	  translate([disklockendx,-disklockwall/2,-diskscrewd/2]) roundedbox(l1+disklockwall-disklockwall,disklockcornerd,disklocklowerh,disklockcornerd,printable);
	}
	//translate([disklockendx,-disklocksink,-diskscrewd/2]) roundedbox(diskscrewd,disklockwall+disklocksink,disklocklowerh,disklockcornerd,printable);
	translate([xx,-disklocksink,-diskscrewd/2]) roundedbox(midl+diskscrewd,disklockwall/2+disklocksink,disklocklowerh,disklockcornerd,printable);
	hull() {
	  translate([disklockendx,-disklocksink,-diskscrewd/2]) roundedbox(disklockcornerd,disklockwall+disklocksink,disklocklowerh,disklockcornerd,printable);
	  translate([disklockendx-disklockslidel,0,-diskscrewd/2]) roundedbox(diskscrewd+disklockslidel,disklockwall/2,disklocklowerh,disklockcornerd,printable);
	}
      }

      for (i=[0:1:len(diskscrewxtable)-1]) {
	x=diskx+diskscrewxtable[i];
	translate([x,diskpinin?0:-disklocksink,0]) rotate([-90,0,0]) screwtappi(h=disklockwall+disklockwall+disklocksink); //+ytolerance
	translate([x-diskscrewd/2,diskpinin?0:-disklocksink,-diskscrewd/2]) roundedbox(diskscrewd,disklockwall+disklockwall,diskscrewd,disklockcornerd,printable);
      }
    }

    translate([xx+midl/2,-disklocksink-disklockwall/2,-diskscrewd/2+textdepth-0.01]) rotate([180,0,0]) linear_extrude(height=textdepth) text(versiontext,size=disklockwall+disklocksink-disklockcornerd-1,valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module diskpin() {
  printable=4;
  
  difference() {
    union() {
      slide1x=diskx+diskscrewxtable[0]-diskscrewd/2;
      slide2x=disklockendx+diskscrewd/2;
      hull() {
	translate([slide1x-diskpinslidel,diskpiny,diskpinheight]) roundedbox(length-slide1x+diskpinslidel,diskpinbodyw,diskpinh,disklockcornerd,printable);
	translate([slide1x-diskpinslidel-disklockwall,diskpiny+disklockwall*2/3,diskpinheight+disklockwall/2]) roundedbox(length-slide1x+diskpinslidel+disklockwall,diskpinbodyw-disklockwall*1.5,diskpinh-disklockwall*1,disklockcornerd,printable);
      }
      translate([slide1x+disklockwall,diskpiny,diskpinheight-disklockwall/2]) roundedbox(length-slide1x-disklockwall+diskpinslidel,disklockwall,diskpinh+disklockwall,disklockcornerd,printable);
      hull() {
	translate([slide1x-diskpinslidel,diskpiny,diskpinheight+disklockwall+(disklockwall-disklocklowerh)]) roundedbox(length-slide1x+diskpinslidel,diskpinbodyw,disklocklowerh,disklockcornerd,printable);
	translate([slide1x,diskpiny,diskpinheight+disklockwall+(disklockwall-disklocklowerh)]) roundedbox(length-slide1x+xtolerance+cornerd,diskpinbodyw+disklocksink,disklocklowerh,disklockcornerd,printable);
      }
      hull() {
	translate([slide2x-diskpinslidel,diskpiny,diskpinheight]) roundedbox(length-slide2x+diskpinslidel+xtolerance+cornerd,diskpinbodyw,diskpinh,disklockcornerd,printable);
	translate([slide2x,diskpiny,diskpinheight]) roundedbox(length-slide2x+xtolerance+cornerd,diskpinbodyw+disklocksink,diskpinh,disklockcornerd,printable);
      }

      // Handle to pull pin out
      handle=min(diskpinhandlew,diskpinhandlel)-cornerd;
      fingerd=length_and_depth_to_diameter(handle,diskpinhandledepth);
      difference() {
	translate([length+xtolerance,diskpinhandley,diskpinhandleheight]) roundedbox(diskpinhandlel,diskpinhandlew,diskpinhandleh,cornerd,printable);
	hull() for (x=[0,diskpinhandlel-diskpinhandlel/2-disklockwall]) {
	  translate([length+xtolerance+x,diskpinhandley+diskpinhandlew/2,-diskscrewd/2-diskpinhandlel/2]) rotate([90,0,0]) cylinder(d=diskpinhandlel,h=diskpinhandlew+0.02,$fn=180,center=true);
	}
	hull() for (x=[0,diskpinhandlel-diskpinhandlel/2-disklockwall]) {
	  translate([length+xtolerance+x,diskpinhandley+diskpinhandlew/2,-diskscrewd/2-diskpinh/2+diskpinhandleh/2+diskpinhandlel/2]) rotate([90,0,0]) cylinder(d=diskpinhandlel,h=diskpinhandlew+0.02,$fn=180,center=true);
	}
      }
    }

    hull() {
      for (x=[disklocknotchx-disklockslidel-wall*2,disklocknotchx]) {
	translate([x,-disklocky+disklockcovery+disklockwall+disklocknotchsink+disklocknotchtrackextrasink-disklocknotchd/2,diskpinheight-disklockwall/2-ztolerance]) cylinder(d=disklocknotchd+dtolerance,h=disklockh+disklockwall+ztolerance*2+0.02,$fn=60);
      }
    }

    translate([length+xtolerance+diskpinhandlel-textdepth+0.01,-diskpinhandlew/2-disklockcornerd/2,0]) rotate([-90,0,-90]) resize([diskpinhandlew-disklockcornerd-1,0,0]) linear_extrude(height=textdepth) text(shortversiontext,size=diskpinhandleheight-disklockcornerd-1,valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module lockcover(y,h,cuth) {
  //disklockcoverfronty=disklockcoverw-(disklockcoverw-disklockcoverfrontw);
  //disklockcoverfrontbackw=disklockcoverw-disklockcoverfrontw;
  frontw=sidewall+disklockwall+disklocksink+disklockwall;
  difference() {
    union() {
      if (olddisklocksystem) {
	translate([0,y,-cuth/2-lockwall]) roundedbox(disklockl+locktopspace+lockwall,lockwall+lockthickness+lockgap+0.01+lockwall,cuth+lockwall*2,cornerd,printable);
      } else {
	translate([0,y+wall*2,-diskscrewd/2-ztolerance-disklockwall]) roundedbox(wall,disklockcoverw-wall*2,disklockcoverh,disklockcornerd,7);
	translate([disklockcoverfrontl,y,disklockcoverheight]) roundedbox(length-disklockcoverfrontl,disklockwall,disklockcoverh,disklockcornerd,7);
	for (z=[disklockcoverheight-ztolerance,disklockcoverheight+disklockcoverh-disklockwall]) {
	  difference() {
	    translate([disklockcoverfrontl,y,z]) roundedbox(length-disklockcoverfrontl,disklockcoverw,disklockwall+ztolerance,disklockcornerd,7);
	    ll=length-disklockcoverfrontl;
	    n=floor(ll/8);
	    lstep=ll/n;
	    if (0) for (x=[disklockcoverfrontl:lstep:length-lstep*4]) {
	      translate([x+disklockwall,y+disklockwall+disklockcornerd/2,z]) reverseroundedplate(lstep-disklockwall*2,disklockcoverw-disklockwall*2-disklockcornerd,disklockwall+ztolerance,disklockcornerd);
	    }
	  }
      
	  hull() {
	    translate([disklockcoverfrontl,y,z]) roundedbox(disklockwall,disklockwall,disklockwall+ztolerance,disklockcornerd,7);
	    translate([0,y+disklockcoverw-sidewall,z]) roundedbox(disklockcoverfrontl+disklockwall,disklockwall,disklockwall+ztolerance,disklockcornerd,7);
	    //#	    translate([0,y+wall*2,z]) roundedbox(wall,disklockcoverw-wall*2,disklockwall+ztolerance,disklockcornerd,7);
	    translate([0,disky-frontw-disklockwall,z]) roundedbox(disklockwall,disklockcoverw-frontw,disklockwall+ztolerance,disklockcornerd,7);
	  }
	}

	translate([disklockcoverfrontl,y,disklockcoverheight-ztolerance]) roundedbox(disklockwall,disklockcoverw-disklockcoverfrontw,disklockcoverh+ztolerance*2,disklockcornerd,7);
	hull() {
	  translate([disklockcoverfrontl,y,disklockcoverheight-ztolerance]) roundedbox(disklockwall,disklockwall,disklockcoverh+ztolerance*2,disklockcornerd,7);
	  translate([0,disky-frontw-disklockwall,disklockcoverheight-ztolerance]) roundedbox(disklockwall,disklockwall,disklockcoverh+ztolerance*2,disklockcornerd,7);
	}
	translate([length-wall,y+disklockcoverw-sidewall-disklockwall/2,-diskscrewd/2-ztolerance-disklockwall]) roundedbox(wall,disklockwall/2+sidewall,disklockcoverh+ztolerance,disklockcornerd,7);
      }
    }
    frontx=disklockcoverfrontl+disklockwall+diskpinslidel;
    translate([frontx,y+disklockwall,disklockcoverheight+disklockwall/2]) roundedbox(length-frontx+disklockcornerd/2,disklockwall+ytolerance*2,disklockcoverh-disklockwall,disklockcornerd);

    // Pin clip cuts
    difference() {
      union() {
	translate([length-disklocknotchcutl,disklockcovery+disklockwall+disklocknotchsink,disklockcoverheight-ztolerance-0.1]) cube([disklocknotchcutl+0.1,0.6,disklockcoverh+ztolerance*2+0.2]);
	hull() {
	  translate([length-0.5,disklockcovery+disklockwall+disklocknotchsink,disklockcoverheight-ztolerance-0.1]) cube([0.01,0.6,disklockcoverh+ztolerance*2+0.2]);
	  translate([length,disklockcovery+disklockwall+disklocknotchsink-0.5+0.1,disklockcoverheight-ztolerance]) cube([0.1,1,disklockcoverh+ztolerance*2]);
	}
      }
      if (print==0 || print==20) {
	for (z=[0,disklockcoverh-disklockwall/2+ztolerance]) {
	  translate([length-0.5-1,disklockcovery+disklockwall+disklocknotchsink,z+disklockcoverheight-ztolerance]) cube([1,0.6,0.4]);
	  translate([length-0.5-1,disklockcovery+disklockwall+disklocknotchsink,z+disklockcoverheight-ztolerance+disklockwall/2-0.1]) cube([1,0.6,0.4]);
	  translate([length-0.5-1,disklockcovery+disklockwall+disklocknotchsink,z+disklockcoverheight-ztolerance]) cube([1,0.3,disklockwall/2+0.2]);
	}
      }
    }
  }

  // Small catch to help keep pin from dropping out easily
  translate([disklocknotchx,disklockcovery+disklockwall+disklocknotchsink-disklocknotchd/2,disklockcoverheight]) roundedcylinder(disklocknotchd,disklockcoverh,disklockcornerd,0,60);
}

module lockcut(h,cuth) {
  if (olddisklocksystem) {
    translate([-0.01,lockwall,-cuth/2]) cube([disklockl+locktopspace+0.02,lockthickness+lockgap,cuth]);
	
    hull() {
      translate([lockhandlel,lockthickness+lockgap-disklockcutw-0.01,-cuth/2]) triangle(disklockcuth+xtolerance,lockwall+0.02,disklockcuth,1);
      translate([-0.01,lockthickness+lockgap-disklockcutw-0.01,-cuth/2]) cube([1,lockwall+0.02,disklockcuth]);
    }

    hull() {
      h=cuth/2-0.01;
      translate([-0.01,-0.01,h]) cube([0.01+lockhandlel-2,lockwall+lockthickness+lockgap+0.01,lockwall+0.02]);
      translate([sidecutwidth/2+lockhandlel-1,0,h]) cube([0.01,0.01,lockwall+0.02]);
    }
  }
}

module basebody() {
  intersection() {
    union() {
      for (i=[0:1:floor(slots)-1]) {
	hh=i*(sloth+slotmaxgap);
	translate([-outsidecornerd/2,0,hh]) roundedbox(length+outsidecornerd/2+cornerd,width,halfheight-(slotmaxgap-slotmingap)*2*i/2,outsidecornerd,printable);
      }
      translate([-outsidecornerd/2,slots>1?slotgapw:0,0]) roundedbox(length+outsidecornerd/2+cornerd,width-(slots>1?slotgapw:0),height,outsidecornerd,printable);
    }
    translate([-outsidecornerd/2,0,0]) roundedbox(length+outsidecornerd/2+cornerd,width,height,outsidecornerd,printable);
    cube([length,width,height]);
  }
}

module coverform(w) {
  narrow=slots>1?min(coverfrontshrink-coverwall,coverdepth/2-coverwall+outsidecornerd/2):0;
  cd=width-narrow*2-fancoverfrontfanw;
  difference() {
    union() {
      // Front shape for pulling the cover off
      if (slots>1) hull() {
	  translate([-coverdepth+(w?0.01:coverwall)+w,-width/2+coverpullshrink+w*1.5,coverpullshrink+w*1.5]) rotate([0,-90,0]) roundedboxxyz(height-coverpullshrink*2-w*3,width-coverpullshrink*2-w*3,w?0.01:coverwall,w?frontincornerd:frontcornerd,w?0.01:coverwall,0,fn);
	  //#	  translate([-coverdepth-coverwall+(w?0.01:coverwall)+w,-fanholderw/2+coverpullshrink+w*1.5,height/2-fanholderh/2+coverpullshrink+w*1.5]) roundedbox(w?0.01:coverwall,fanholderw-coverpullshrink*2-w*3,fanholderh-coverpullshrink*2-w*3,cornerd,0);
	  translate([-coverdepth+coverwall+2+(w?0.01:coverwall)+w,-width/2+coverfrontshrink+w,coverfrontshrink+w]) rotate([0,-90,0]) roundedboxxyz(height-coverfrontshrink*2-w*2,width-coverfrontshrink*2-w*2,w?0.01:coverwall,w?frontincornerd:frontcornerd,0,fn);
	}
      
      hull() {
	translate([(w?0.01:0),-width/2+(w?sidewall:0),w?bottomthickness:0]) rotate([0,-90,0]) roundedboxxyz(height-(w?bottomthickness+roofthickness:0),width-(w?sidewall:0)*2,w?0.01:coverwall,w?outsideincornerd:outsidecornerd,w?0.01:coverwall,0,fn);
	if (fantype==-1) {
	  translate([-coverdepth+w+coverwall,-width/2+narrow+(w?sidewall:0),narrow+w]) rotate([0,-90,0]) roundedboxxyz(height-narrow*2-w*2,width-narrow*2-(w?sidewall*2:0),coverwall,w?outsideincornerd:outsidecornerd,cornerd,w?0:fancoverprintable,fn);
	} else {
	  translate([-coverdepth+w,-fanholderw/2+w,height/2-fanholderh/2+w]) roundedbox(fancoverwall,fanholderw-w*2,fanholderh-w*2,cornerd,0);
	}
	translate([-coverdepth+coverwall+w,-width/2+coverfrontshrink+w,coverfrontshrink+w]) rotate([0,-90,0]) roundedboxxyz(height-coverfrontshrink*2-w*2,width-coverfrontshrink*2-w*2,coverwall,w?outsideincornerd:outsidecornerd,cornerd,w?0:fancoverprintable,fn);
      }
    }

    if (w) {
      translate([-coverdepth,-oldcoverclipw/2,bottomthickness+ztolerance]) roundedbox(coverdepth+oldcoverclipl,oldcoverclipw,oldcovercliph,cornerd);
      translate([-coverdepth,-oldcoverclipw/2,height-roofthickness-oldcovercliph-ztolerance]) roundedbox(coverdepth+oldcoverclipl,oldcoverclipw,oldcovercliph,cornerd);

      for (m=[0,1]) mirror([0,m,0]) {
	  for (z=coverclipztable) {
	    hull() {
	      //#translate([-coverdepth-0.1+coverclipoutl/2,-width/2,z-coverclipoutl/2-fancoverwall]) roundedbox(0.1+coverdepth,coverclipoutw,coverclipoutl+fancoverwall*2,cornerd,8);
	      //      #translate([-coverdepth-0.1,-width/2+fancoverwall,z-coverclipoutl/2-fancoverwall-coverclipfingerspace]) roundedbox(0.1+coverdepth-10,0.1+fancoverwall,coverclipoutl+fancoverwall*2+coverclipfingerspace*2,cornerd,8);
	      translate([-coverdepth,-width/2+coverclipy-coverclipoutl/2-fancoverwall,z-coverclipoutw/2]) roundedbox(0.1+coverdepth,coverclipoutl+fancoverwall*2,coverclipoutw,cornerd,7);
	      translate([-coverdepth-0.1,-width/2+coverclipy-coverclipoutl/2-fancoverwall-coverclipfingerspace,z-coverclipoutw/2+fancoverwall]) roundedbox(0.1+coverdepth-10,coverclipoutl+fancoverwall*2+coverclipfingerspace*2,0.1+fancoverwall,cornerd,8);
	    }
	  }
	}
    }
      
    // Fan clips and tower
    if (coverwithfan) if (w) {
	translate([0,0,fanheight]) {
	  // Thicker fan base to allow grille
	  translate([-coverdepth,-fanholderw/2,-fanholderh/2]) roundedbox(fancoverwall+fancoverfanbaseh,fanholderw,fanholderh,cornerd,0);

	  for (y=[-fanscreww/2,fanscreww/2]) {
	    for (z=[-fanscrewl/2,fanscrewl/2]) {
	      translate([-coverdepth,y,z]) rotate([0,90,0]) roundedcylinder(fantowerd,fantowerh,fancoverwall,0,fn);
	    }
	  }

	  for (r=[0,90]) rotate([r,0,0]) for (m=[0,1]) mirror([0,0,m]) {
		translate([-coverdepth,-fanholderclipl/2,-fanholderh/2]) roundedbox(fanholderl,fanholderclipl,fancoverwall,cornerd,0);
		hull() {
		  translate([-coverdepth+fanholderl-fanholderclipd,-fanholderclipl/2,-fanholderh/2]) roundedbox(fanholderclipd,fanholderclipl,fancoverwall,cornerd,0);
		  translate([-coverdepth+fanholderl-fanholderclipd/2,0,-fanholderh/2+fanholderclipd/2]) rotate([0,0,90]) tubeclip(fanholderclipl,fanholderclipd,0);
		}
	      }
	}
      }
  }
}

module coverclip() {
  translate([-coverwall,-oldcoverclipw/2,0]) roundedbox(coverwall,oldcoverclipw,oldcovercliph+ztolerance+bottomthickness,cornerd);
  translate([-coverwall,-oldcoverclipw/2,bottomthickness+ztolerance]) roundedbox(coverwall+oldcoverclipl,oldcoverclipw,oldcovercliph,cornerd);
  hull() {
    translate([oldcoverclipl-oldcoverclipd,-oldcoverclipw/2,bottomthickness+ztolerance]) roundedbox(oldcoverclipd,oldcoverclipw,oldcovercliph,cornerd);
    translate([oldcoverclipl-oldcoverclipd/2,0,bottomthickness+ztolerance+oldcovercliph-oldcoverclipd/2]) rotate([0,0,90]) tubeclip(oldcoverclipw,oldcoverclipd,0);
  }
}

module cover() {
  coverfrontl=coverpullshrink+fancoverwall;
  difference() {
    union() {
      difference() {
	union() {
	  coverform(0);
	}
	coverform(coverwall);

	
	if (coverwithfan) {
	  difference() {
	    translate([-coverdepth-0.01,0,fanheight]) rotate([0,90,0]) cylinder(d=fand-fanwall,h=fancoverwall+fancoverfanbaseh+0.02,$fn=fn);
	    translate([-coverdepth-0.01,0,fanheight]) rotate([0,90,0]) grill(fand);
	  }
	} else {
	  for (m=[0,1]) mirror([0,m,0]) for (z=[coolingheight:coolingslith+coolingslitgap:coolingtop]) translate([-coverdepth-coolingslith/2,coolingslity,z]) roundedbox(coverwall+coolingslith+0.02,coolingslitw,coolingslith,coolingslith,0);
	}
      }

      translate([0,0,0]) coverclip();
      translate([0,0,height]) rotate([180,0,0]) coverclip();
    }

    translate([0,0,height/2]) for (m=[0,1]) mirror([0,m,0]) {
	for (n=[0,1]) mirror([0,0,n]) translate([0,0,-height/2]) {
	    hull() {
	      translate([-coverdepth+coverfrontl-cornerd/2,-width/2+coverclipy-coverclipoutl/2,coverclipoutw/2-coverclipoutw/2-0.1]) cube([cornerd/2+coverdepth-coverfrontl-xtolerance-fancoverwall-xtolerance,coverclipoutl,0.1+coverclipoutw/2+coverclipw/2+ytolerance]);
	      translate([-coverdepth+coverfrontl-cornerd/2,-width/2+coverclipy-coverclipoutw/2-coverclipfingerspace,coverclipoutw/2-0.1]) cube([cornerd/2+coverdepth-coverfrontl-xtolerance-fancoverwall-xtolerance-coverclipfingerspace,coverclipoutw+coverclipfingerspace*2,0.1]);
	      translate([-coverdepth+coverfrontl-cornerd/2,-width/2+coverclipy-coverclipoutl/2,coverclipoutw/2-coverclipw/2-0.1]) cube([cornerd/2+coverdepth-coverfrontl-xtolerance-fancoverwall-xtolerance,coverclipoutl,0.1+coverclipw+ytolerance]);
	      translate([-coverdepth+coverfrontl-cornerd/2,-width/2+coverclipy-coverclipoutw/2-coverclipfingerspace,coverclipoutw/2-coverclipoutw/2-0.1]) cube([cornerd/2+coverdepth-coverfrontl-xtolerance-fancoverwall-xtolerance-coverclipfingerspace,coverclipoutw+coverclipfingerspace*2,0.1]);
	    }
	    translate([-coverdepth+coverfrontl-cornerd/2,-width/2+coverclipy-coverclipoutl/2,coverclipoutw/2-coverclipw/2-ytolerance]) cube([cornerd/2+coverdepth-coverfrontl-xtolerance-fancoverwall-xtolerance+0.2,coverclipoutl,coverclipw+ytolerance*2]);
	    translate([-coverdepth+coverfrontl-cornerd/2,-width/2+coverclipy-coverclipl/2-ztolerance,coverclipoutw/2-coverclipw/2-ytolerance]) cube([coverdepth-coverfrontl+cornerd,coverclipl+ztolerance*2,coverclipw+ytolerance*2]);
	  }
      }

    translate([-1,-oldcoverclipw/2,-cornerd/2]) roundedbox(cornerd+cornerd,oldcoverclipw,cornerd/2+1,0);
    translate([-1,-oldcoverclipw/2,height-1]) roundedbox(cornerd+cornerd,oldcoverclipw,cornerd/2+1,0);
    
    if (coverwithfan) {
      translate([-coverdepth+textdepth-0.01,0,fanheight]) rotate([90,0,-90]) rotate([0,0,45]) translate([0,fand/2+1,0]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-3,valign="bottom",halign="center");
    } else {
      translate([-coverdepth+textdepth-0.01,coolingslity+coolingslitw+2,height/2]) rotate([90,0,-90]) translate([0,fand/2+1,0]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,valign="center",halign="right");
    }

    // Clip holes for cover
    for (z=coverclipztable) {
      translate([coverclipx,-width/2+coverclipy,z]) {
	rotate([90,0,90]) lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,1,text=versiontext,textdepth=0.7);
      }
    }
  }
}

module outkey() {
  render() key(outscrewspringlength,outscrewspringheight,sidewall,outscrewdiameter,outscrewbase);
}

module diskkey() {
  if (olddisklocksystem) render() key(diskscrewspringlength,keyh,sidewall,diskscrewdiameter,diskscrewbase);
}

module diskkeycut() {
  if (olddisklocksystem) render() keycut(diskscrewspringlength,keyh,sidewall);
}

module lighteningholes() {
  if (!screwversion) for (slot=[0:1:len(sidelightentable)-1]) {
      slottype=sidelightentable[slot];
      if (slottype>0) {
	minh=bottomthickness+slot*(halfheight+slotmingap)-wall;
	toph=bottomthickness+slot*(halfheight+slotmaxgap);
	h=(slottype==3?(aopenversion?halfheight-aopenheight-aopenh/2-(toph-minh)-wall:0):halfheight-(toph-minh)/2-outsidecornerd+sidewall*2+wall*2)+margin/2-wall;
	hght=(slottype==3?(aopenversion?slot*sloth+aopenheight+aopenh/2+wall:0):slot*(sloth)+(toph-minh)/2+outsidecornerd/2-sidewall-margin/4-wall);
	x=slottype==2?coverdepth:0;
	ll=length+(slottype==2?-coverdepth:0);
	l=ll/3;
	for (i=[0:1:2]) {
	  translate([x+i*(l-margin/3),sidewall,hght]) rotate([90,-90,90]) lighten(h,l+margin*2/3,sidewall,margin,bar,maxbridge,"up",cornerd=sidewall);
	}
      }
    }
	    
  zstart=throughholes?-0.01:bottomthin;
  zend=smalldiskslots>0?bottomthickness+disksh-diskh:throughholes?height+0.02:height-bottomthickness-roofthickness;
	    
  translate([textsize,width/2-diskw/2,0]) rotate([90,0,90]) lighten(diskw,length-textsize,bottomthickness,margin,bar,maxbridge,"up",cornerd=bottomthickness);
  if (smalldiskslots==0) translate([textsize,width/2-diskw/2,height-roofthickness]) rotate([90,0,90]) lighten(diskw,length-textsize,bottomthickness,margin,bar,maxbridge,"up",cornerd=bottomthickness);
	    
  // Lightening holes, top if 2.5 inch slots exist
  if (smalldiskslots>0) {
    for (z=[smalldiskbottomheight,height-roofthickness]) {
      translate([textsize,width/2-smalldiskw/2,z]) rotate([90,0,90]) lighten(smalldiskw,length-textsize,roofthickness,margin,bar,maxbridge,"up",cornerd=roofthickness);
    }
  }

  // Lightening holes, sides
  if (smalldiskslots>0) {
    x=covercliptotall-coverclipx;
    l=(length-x)/3;
    for (i=[0:1:2]) {
#      translate([x+i*(l-margin/3),outsideincornerd/2-margin/2,height-roofthickness]) rotate([90,0,90]) lighten(width/2-smalldiskw/2-sidewall-sidewall-outsideincornerd/2+margin,l+margin*2/3,roofthickness,margin,bar,maxbridge,"up",cornerd=roofthickness); // sidewall,hght]) rotate([90,-90,90]) lighten(h,l+margin*2/3,sidewall,margin,bar,maxbridge,"up",cornerd=sidewall);
    }
    //#    translate([x+i*(l-margin/3),outsidecornerd/2-margin/4,height-roofthickness]) rotate([90,0,90]) lighten(width/2-smalldiskw/2-sidewall-sidewall-outsidecornerd/2+margin,length/2,roofthickness,margin,bar,maxbridge,"up",cornerd=roofthickness);
    //translate([length/2-margin,outsidecornerd/2-margin/4,height-roofthickness]) rotate([90,0,90]) lighten(width/2-smalldiskw/2-sidewall-sidewall-outsidecornerd/2+margin,length/2+margin,roofthickness,margin,bar,maxbridge,"up",cornerd=roofthickness);
  }

  if (diskslots>0) { //slots==1 && 
    for (i=[0:1:diskslots-1]) {
      for(x=[0:1:2]) {
	xstart=margin/2;
	l=length-margin;
	hh=diskscrewheight+disklockh/2+lockwall-margin/3;
	h=diskh-diskscrewheight+disklockh/2+lockwall-outsideincornerd+(slots==1?margin/2:0);
	translate([xstart+x*l/3,width/2-diskw/2,bottomthickness+i*diskslotstep+hh]) rotate([90,-90,90]) lighten(h,l/3,sidewall,margin/2,bar,maxbridge,"up",cornerd=sidewall);
      }
    }
  }
}

module halfholder() {
  diskwally = width/2-diskw/2-sidewall;
  smalldiskwally = width/2-smalldiskw/2-sidewall;
  
  union() {
    difference() {
      union() {
	difference() {
	  basebody();
	  
	  for (i=[0:1:diskslots-1]) {
	    translate([-0.01,width/2-diskw/2,bottomthickness+i*diskslotstep]) cube([length+0.02,diskw,diskh]);
	  }
	  
	  if (smalldiskslots>0) {
	    translate([-0.01,width/2-smalldiskw/2,smalldiskheight]) cube([length+0.02,smalldiskw,smalldiskspaceh]);
	    translate([-0.01-outsideincornerd/2,slotgapw+sidewall+outsideincornerd,smalldiskheight]) roundedbox(length+outsideincornerd+0.02,smalldisksidecutwidth-slotgapw-outsideincornerd,smalldiskspaceh,outsideincornerd,printable);
	    intersection() {
	      translate([-0.01-outsideincornerd/2,slotgapw+sidewall,smalldiskheight]) roundedbox(length+outsideincornerd+0.02,smalldisksidecutwidth-slotgapw,smalldiskspaceh,outsideincornerd,printable);
	      translate([wall,slotgapw+sidewall,smalldiskheight]) cube([length+outsideincornerd+0.02,smalldisksidecutwidth-slotgapw,smalldiskspaceh]);
	    }
	    translate([-0.01,width/2-diskentrywidth/2,bottomthickness]) cube([length+0.02,diskentrywidth,disksh]);
	  } else {
	    // No small disks, cut all out
	    translate([-0.01,width/2-diskw/2,bottomthickness]) cube([length+0.02,diskw,height-bottomthickness-roofthickness]);
	  }

	  
	  if (diskxposition+disklength>length) {
	    translate([diskxposition+disklength-0.01,width/2-diskentrywidth/2,bottomthickness]) cube([length-diskxposition-disklength+1,diskentrywidth,height-bottomthickness-roofthickness]);
	  } else {
	    echo("Disk is recessed in the case, this is bad for cabling.");
	  }

	  // Side cuts
	  if (slots>1) {
	    difference() {
	      union() {
		for (z=[0:diskslotstep:disksh]) {
		  intersection() {
		    union() {
		      for (i=[0:1:slots<1?0:(slots-1)]) {
			hh=bottomthickness+i*(sloth+slotmaxgap);
			translate([-outsidecornerd/2,sidewall,hh]) roundedbox(length+outsidecornerd+cornerd,sidecutwidth,halfheight-(slotmaxgap-slotmingap)*2*i/2-bottomthickness-roofthickness,outsideincornerd,printable);
		      }
		      translate([-outsidecornerd/2,slotgapw+sidewall,bottomthickness]) roundedbox(length+outsidecornerd+cornerd,sidecutwidth-slotgapw,height-bottomthickness-roofthickness,outsideincornerd,printable);
		    }

		    translate([-outsidecornerd/2,sidewall,bottomthickness]) roundedbox(length+outsidecornerd+cornerd,sidecutwidth,height-bottomthickness-roofthickness,outsideincornerd,printable);
		    translate([wall,sidewall,bottomthickness]) cube([length+outsidecornerd/2+cornerd,sidecutwidth,height-bottomthickness-roofthickness]);
		  }
		}

		//translate([0,width/2-smalldiskw/2-sidewall-lockthickness-lockgap-lockwall,smalldiskheight]) translate([-0.01,-smalldisklockfingerspacew,0]) cube([smalldisklockfingerspacel+0.01,smalldisklockfingerspacew,max(smalldisklockhandleh+wall,smalldisklockfingerspaceh)+0.01]);

		if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
		    if (olddisklocksystem) {
		      translate([-cornerd/2,sidewall+sidecutwidth-lockfingerspacew,z+bottomthickness+diskscrewheight-disklockcuth/2]) roundedbox(lockfingerspacel+cornerd,lockfingerspacew,lockfingerspaceh+0.01,cornerd,0);
		    } else {
		      hg=diskscrewheight+disklockcoverheight+disklockcoverh+ztolerance;
		      h=diskh-hg-ztolerance;
		      //echo(diskh,hg,h);
		      w=disklockcoverw-sidewall;
		      y=disklockcovery;
		      translate([-cornerd/2,y,z+bottomthickness+hg]) roundedbox(wall+cornerd,w,h,cornerd,0);
		    }
		  }
	      }

	      // Higher versions need supports
	      if (slots>2) {
		translate([-outsidecornerd/2,slotgapw+sidewall-0.01,bottomthickness+halfheight*2+(slotmaxgap+slotmingap)/2-diskgaph+0.1]) cube([length+outsidecornerd+cornerd,sidecutwidth-slotgapw+0.02,smalldiskbottomh]);
	      }

	      if (slots>4 && diskslots>5) {
		translate([-outsidecornerd/2,slotgapw+sidewall-0.01,smalldiskheight-smalldiskbottomh]) cube([length+outsidecornerd+cornerd,sidecutwidth-slotgapw+0.02,smalldiskbottomh]);
	      }
	    }
	  } else {
	    intersection() {
	      translate([-0.01-outsideincornerd,sidewall,sidebottomthickness]) roundedbox(length+outsideincornerd*2+0.02,sidecutwidth,sidecutheight,outsideincornerd,0);
	      translate([-outsidecornerd/2,sidewall,bottomthickness]) roundedbox(length+outsidecornerd+cornerd,sidecutwidth,height-bottomthickness-roofthickness,outsideincornerd,printable);
	      translate([wall,sidewall,bottomthickness]) cube([length+outsidecornerd/2+cornerd,sidecutwidth,height-bottomthickness-roofthickness]);
	    }
	  }

	  for (z=[0:diskslotstep:disksh]) {
	    for (x=diskscrewxtable) { //[diskscrewxtable[0],diskscrewxtable[len(diskscrewxtable)-1]]) {
	      hull() {
		translate([diskxposition+x-diskscrewd/2-xtolerance*3,disky,diskheight+z+diskscrewheight-diskscrewd/2-ztolerance*3]) cube([diskscrewd+xtolerance*6,0.1,diskscrewd+ztolerance*6]);
		translate([diskxposition+x-diskscrewd/2-xtolerance*5,disky-disklockwall-0.02,diskheight+z+diskscrewheight-diskscrewd/2-ztolerance*4]) cube([diskscrewd+xtolerance*10,0.02,diskscrewd+ztolerance*8]);
	      }
	      translate([wall,diskwally-0.1,diskheight+z+diskscrewheight-diskscrewd/2-ztolerance]) cube([length-wall+0.01,sidewall-disklockwall+0.1,ztolerance+disklockh+ztolerance]);
	      translate([length-disklocknotchcutl,disklockcovery-disklocknotchsink,diskheight+z+diskscrewd/2-disklockcoverheight-0.01]) cube([disklocknotchcutl+0.01,disklocknotchsink,disklockcoverh+0.02]);
	    }
	  }
	  
	  
	  if (olddisklocksystem) translate([-0.01,sidewall+sidecutwidth-outsideincornerd,sidebottomthickness]) cube([length+outsideincornerd*2+0.02,outsideincornerd,outsideincornerd/2]);
	  if (smalldiskslots>0) translate([-0.01,sidewall+smalldisksidecutwidth-outsideincornerd,smalldiskheight]) cube([length+outsideincornerd*2+0.02,outsideincornerd,outsideincornerd/2]);

	  // See where slot mid barriers could be at
	  if (debug) for (i=[1:1:slots]) {
	    hull() {
	      //#	      translate([0,0,i*(halfheight)+(i-1)*slotmingap]) cube([length,slotgapw,slotmingap]);
	      //#	      translate([0,0,i*(halfheight)+(i-1)*slotmaxgap]) cube([length,slotgapw,slotmaxgap]);
	    }
	  }
	  
	  // Lightening holes, top&bottom
	  if (full) lighteningholes();
	}

	difference() {
	  for (z=coverclipztable) {
	    translate([0,coverclipy-coverclipoutl/2,z-coverclipoutw/2]) {
	      roundedbox(covercliptotall-coverclipx+wall,coverclipoutl,coverclipoutw,cornerd,7);
	    }
	  }

	  // Cut out disk lock spaces as they come too close
	  if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	      translate([disklockcoverfrontl+disklockwall,disklockcovery+disklockwall,diskheight+z+diskscrewheight-diskscrewd/2-disklockwall/2-ztolerance]) roundedbox(disklockl-disklockwall,disklockcoverw-sidewall-disklockwall,disklockcoverh-disklockwall,disklockcornerd,0);
	    }
	}
	  
	// Supports below disks if more than 1
	for (i=[1:1:diskslots-1]) {
	  translate([0,width/2-diskw/2-sidewall,bottomthickness+i*diskslotstep-diskgaph]) roundedbox(length,diskgapw+sidewall,diskgaph,cornerd,printable);
	}

	if (smalldiskslots>0) for (i=[1:1:smalldiskslots-1]) {
	    translate([0,width/2-smalldiskw/2-sidewall,smalldiskheight-diskgaph+i*smalldiskslotstep]) roundedbox(length,diskgapw+sidewall,diskgaph,cornerd,printable);
	  }

	if (sideslideversion==1) {
	  for (z=outscrewztable) translate([0,0,z]) {
	      sideslide();
	    }

	  for (z=[0]) {
	    intersection() {
	      basebody();
	      hull() {
		translate([sideslideinbasex-sideslidew*3,0,z]) cube([sideslideinbasel+sideslidelockcutl+cut+sideslidew*5,sidewall,sloth]);
		translate([sideslideinbasex-sideslidew*2,0,z]) cube([sideslideinbasel+sideslidelockcutl+cut+sideslidew*4,sideslidew*3+ytolerance,sloth]);
	      }
	    }
	  }
	}
	  
	if (guideversion==1) {
	  for (slot=cliptable[slotconfig]) {
	    translate([0,0.01,slot*sloth+guideheight]) guide();
	  }
	}

	if (aopenversion==1) {
	  for (slot=cliptable[slotconfig]) {
	    translate([0,0,slot*sloth]) render() aopen();
	  }
	}

	if (!simple) {
	  if (!guideversion && !sideslideversion && !aopenversion) {
	    translate([0,sidewall/2,outlockcoverbottom]) roundedbox(outlockl+locktopspace+lockwall,sidewall/2+lockthickness+lockgap+0.01+lockwall,outscrewztable[1]+outlockcuth/2+lockwall-outlockcoverbottom,cornerd,printable);
	  }

	  // lock pin cover for disk
	  if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	      translate([0,0,z+bottomthickness+diskscrewheight]) lockcover(disklockcovery,disklockh,disklockcuth);
	  }

	  if (smalldiskslots>0) {
	    translate([0,width/2-smalldiskw/2-sidewall-lockthickness-lockgap-lockwall,smalldiskheight]) smalldisklockcover(smalldisklockh,smalldisklockcuth,smalldiskslots);
	  }
	}
      }

      // Cover clip holes
      translate([0,0,height/2]) for (m=[0,1]) mirror([0,0,m]) translate([0,0,-height/2]) {
	  z=coverclipztable[0];
	  translate([coverclipx,coverclipy,z]) {
#	    rotate([90,0,90]) lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,1,text=versiontext,textdepth=0.7);
	  }

	  w=coverclipoutl>maxbridge?coverclipoutl-maxbridge:maxbridge;
	  l=(coverclipoutl-maxbridge)/2;
	  clipspacel=6.5+wall/2-xtolerance;
	  hull() {
	    translate([coverclipx+covercliph/2-xtolerance,coverclipy-coverclipoutl/2,-0.1]) cube([clipspacel-l,coverclipoutl,0.1+z+coverclipw/2]);
	    translate([coverclipx+covercliph/2-xtolerance,coverclipy-coverclipoutl/2+w/2,-0.1]) cube([clipspacel,maxbridge,0.1+z+coverclipw/2]);
	  }
	  if (0) hull() {
	    h=z+coverclipw/2-bottomthickness;
	    translate([coverclipx+covercliph/2-xtolerance,coverclipy-coverclipoutl/2+w/2,bottomthickness]) cube([coverclipl+l,maxbridge,h]);
	    translate([coverclipx+covercliph/2-xtolerance+h,coverclipy-coverclipoutl/2+w/2,bottomthickness+h-0.1]) cube([coverclipl+l,maxbridge,0.1]);
	  }
	}
      
     if (sideslideversion) {
	for (z=outscrewztable) translate([0,0,z]) {
	    sideslidecut(z<outscrewztable[1]);
	
	    for (x=outscrewxtable) {
	      translate([x,-0.01,0]) rotate([-90,0,0]) cylinder(d=diskscrewholed,sideslidewall+sideslidewall*2+ytolerance*2+0.02,$fn=fn);
	    }
	}
      }
      
      if (!simple) {
	if (!guideversion && !sideslideversion && !aopenversion) for (z=outscrewztable) {
	    // Side lock handle space
	    hull() {
	      translate([-cornerd/2,sidewall,outscrewztable[0]-outlockcuth/2]) roundedbox(lockhandlel+cornerd/2,ytolerance+lockhandlethickness+ytolerance*2,outlockcuth,cornerd,0);
	      translate([-cornerd/2,sidewall,outscrewztable[0]-outlockcuth/2]) roundedbox(lockhandlel+cornerd/2+lockhandlethickness-lockthickness,ytolerance+lockthickness+ytolerance,outlockcuth,cornerd,0);
	    }
	    
	    // Side lock space
	    translate([-0.01,sidewall,z-outlockcuth/2]) cube([outlockl+locktopspace+0.02,lockthickness+lockgap,outlockcuth]);
	    hull() {
	      translate([lockhandlel,sidewall+lockthickness+lockgap-0.01,z-outlockcuth/2]) triangle(outlockcuth+xtolerance,lockwall+0.03,outlockcuth,1);
	      translate([-0.01,sidewall+outlockcutw-0.01,z-outlockcuth/2]) cube([1,lockwall+0.02,outlockcuth]);
	    }
	    
	    hull() {
	      cutheight=min(outscrewztable[0],bottomthickness+diskscrewheight-roofthickness);
	      h=min(height,halfheight)-sidebottomthickness-cutheight-roofthickness-outsideincornerd/2;
	      translate([-0.01,sidewall,z+outlockcuth/2-0.01]) cube([0.01+lockhandlel-(lockthickness+lockgap+lockwall)+0.01,lockthickness+lockgap+lockwall+0.02,outlockmidwallh+0.02]);
	      translate([lockhandlel-(lockthickness+lockgap+lockwall)+lockthickness+lockgap+lockwall-0.01,sidewall+lockthickness+lockgap+lockwall+0.01,z+outlockcuth/2-0.01]) cube([0.01,0.01,outlockmidwallh+0.02]);
	    }
	  }
	
	// Disk lock spaces
	if (diskslots>0) {
	  for (z=[0:diskslotstep:disksh]) {
	    if (olddisklocksystem) {
	      translate([0,sidewall+sidecutwidth-lockthickness-lockgap-lockwall,z+bottomthickness+diskscrewheight]) lockcut(disklockh,disklockcuth);
	    } else {
	      if (0) for (x=diskscrewxtable) { //[diskscrewxtable[0],diskscrewxtable[len(diskscrewxtable)-1]]) {
		translate([diskxposition+x-diskscrewd/2-xtolerance*2,diskwally-0.01,diskheight+z+diskscrewheight-diskscrewd/2-ztolerance*2]) cube([diskscrewd+xtolerance*4,sidewall+0.02,diskscrewd+ztolerance*4]);
		translate([wall,diskwally+0.01,diskheight+z+diskscrewheight-diskscrewd/2-ztolerance]) cube([length-wall+0.01,sidewall-disklockwall+0.01,ztolerance+disklockh+ztolerance]);
	      }
	    }
	  }
	}

	// Small disk lock spaces
	if (smalldiskslots>0) for (i=[0:1:smalldiskslots-1]) {
	    translate([0,width/2-smalldiskw/2-sidewall-lockthickness-lockgap-lockwall,smalldiskheight]) smalldisklockcut(smalldisklockh,smalldisklockcuth,smalldiskslots);
	  }

	// This seems obsolete??
	if (0) if (sideslideversion) {
	  for (z=outscrewztable) {
	    hull() {
	      translate([-0.01,sidewall,z-sideslideincuth/2]) cube([0.01+lockhandlel-2,sidecutwidth/2,sideslideincuth]);
	      if (sideslideincuth>maxbridge) translate([(sideslideincuth-maxbridge)/2-0.01,sidewall,z-maxbridge/2]) cube([0.01+lockhandlel-2,sidecutwidth/2,maxbridge]);
	    }
	  }
	}
      }

      // This seems obsolete?
      //translate([sidewall+diskxposition,width-(width/2-diskw/2-2*sidewall)-sidewall,sidebottomthickness]) cube([disklength-2*sidewall,width/2-diskw/2-2*sidewall,height-sidebottomthickness-sideroofthickness+20]);

      if (!guideversion && !sideslideversion && !aopenversion) for (z=outscrewztable) {
	  for (x=outscrewxtable) {
	    translate([x-outscrewspringlength,0,z]) rotate([270,0,0]) keycut(outscrewspringlength,outscrewspringheight,sidewall);
	  }
	}
      
      if (guideversion) {
	for (slot=cliptable[slotconfig]) {
	  translate([0,0,slot*sloth+guideheight]) guidecut();
}
      }

      if (aopenversion) {
	for (slot=cliptable[slotconfig]) {
	  translate([0,0,slot*sloth+aopenheight]) render() aopencut();
	}
      }


      // This is duplicated earlier, need to check it some time...
      if (sideslideversion) for (z=outscrewztable) {
	  translate([0,0,z]) sideslidecut(z<outscrewztable[1]);
	}

      if (screwversion) {
	if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	    for (x=diskscrewxtable) {
	      translate([diskxposition+x-diskscrewspringlength,diskwally,z+bottomthickness+diskscrewheight]) rotate([270,0,0]) diskkeycut();
	    }
	  }
	
	if (smalldiskslots>0) for (z=[0:smalldiskslotstep:smalldisksh]) {
	    for (x=smalldiskscrewxtable) {
	      translate([smalldiskxposition+x-diskscrewspringlength,smalldiskwally,z+smalldiskheight+smalldiskscrewheight]) rotate([270,0,0]) diskkeycut(); //keycut(diskscrewspringlength,keyh,sidewall);
	    }
	  }
      }
      
      translate([-0.01,width/2+0.01,-0.01]) cube([length+0.02,width,height+0.02]);

      for (z=[bottomthickness+ztolerance+oldcovercliph-oldcoverclipd/2,height-roofthickness-ztolerance-oldcovercliph+oldcoverclipd/2]) translate([oldcoverclipx,width/2,z]) rotate([0,0,90]) tubeclip(oldcoverclipw,oldcoverclipd,dtolerance);
    }

    // Keys for outside if applicable
    if (screwversion) {
      for (z=outscrewztable) {
	for (x=outscrewxtable) {
	  translate([x-outscrewspringlength,sidewall,z]) rotate([90,0,outscrewspringangle]) outkey();
	}
      }
    }

    // Keys for disks
    if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	for (x=diskscrewxtable) {
	  if (olddisklocksystem) {
	    translate([diskxposition+x-diskscrewspringlength,sidecutwidth+sidewall,z+bottomthickness+diskscrewheight]) rotate([270,0,-diskscrewspringangle]) diskkey(); 
	  }
	}
      }

    // Keys for small disks
    if (smalldiskslots>0) for (z=[0:smalldiskslotstep:smalldisksh]) {
	for (x=smalldiskscrewxtable) {
	  translate([smalldiskxposition+x-diskscrewspringlength,smalldiskwally,z+smalldiskheight+smalldiskscrewheight]) rotate([270,0,-diskscrewspringangle]) diskkey(); //key(diskscrewspringlength,keyh,sidewall,diskscrewdiameter,diskscrewbase);
	}
      }
  }
}

module holder() {
  difference() {
    union() {
      render() halfholder();
      translate([0,width,0]) mirror([0,1,0]) halfholder();
    }

    // HP quirk
    if (slots<1) {
      translate([sideslidel+5,-0.01,outscrewztable[0]-sideslideh/2-ztolerance]) cube([length-sideslidel-5+1,sideslidew*2+ytolerance,sideslideh+ztolerance*2]);
    }
    
    translate([2+oldcoverclipl,width/2,bottomthickness-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="center");
    translate([2,width/2,height-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="center");
    slotnumbersize=lockthickness+lockwall+1;

    if (!simple) {
      w=lockthickness+lockgap+0.01+lockwall;
      if (screwversion) {
	translate([1,width-sidewall-w/2,outscrewztable[0]-outlockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("1",size=slotnumbersize,halign="center");
      }

      if (olddisklocksystem) if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	    translate([1,width-sidewall-sidecutwidth+w/2,z+bottomthickness+diskscrewheight-disklockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("2",size=slotnumbersize,halign="center");
	    translate([1,sidewall+sidecutwidth-w/2,z+bottomthickness+diskscrewheight-disklockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("3",size=slotnumbersize,halign="center");
	  }
	
      if (smalldiskslots>0) {
	translate([1,width-sidewall-smalldisksidecutwidth+w/2,smalldiskheight-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("5",size=slotnumbersize,halign="center");
	translate([1,sidewall+smalldisksidecutwidth-w/2,smalldiskheight-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("6",size=slotnumbersize,halign="center");
      }
	
      if (screwversion) if (!guideversion && !sideslideversion && !aopenversion) {
	translate([1,sidewall+w/2,outscrewztable[0]-outlockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("4",size=slotnumbersize,halign="center");
      }
    }
  }
}

locktable=[[0,1], // Left side
	   [1,0], // Left side
	   [0,0], // Right side
	   [1,1], // Right side
	   [1,0], // Left side
	   [0,0]  // Right side
	   ];

module lockbody(i) {
  rotate=locktable[i][0];
  out=locktable[i][1];
  h=out?outlockh:disklockh;
  
  if (out) {
    hull() {
      translate([0,0,-h/2]) roundedbox(outlockl,lockthickness,h,cornerd,lockprintable);
      translate([0,lockthickness-1,-h/2+cornerd/2]) roundedbox(outlockl+lockthickness-0.5,1,h-cornerd,cornerd,lockprintable);
    }
  } else {
    hull() {
      translate([0,0,-h/2]) roundedbox(disklockl,lockthickness,h,cornerd,lockprintable);
      translate([0,lockthickness-1,-h/2+cornerd/2]) roundedbox(disklockl+lockthickness-0.5,1,h-cornerd,cornerd,lockprintable);
    }
  }
  translate([0,0,-h/2]) roundedbox(lockhandlel,lockhandlethickness,h,cornerd,lockprintable);
  hull() {
    translate([lockhandlel-0.01,lockthickness-0.01,-h/2+cornerd/2]) cube([0.8+0.01,lockwall+0.01,h-cornerd]);
    translate([lockhandlel+0.8,lockthickness-0.01,-h/2+cornerd/2]) triangle(h-cornerd,lockwall+0.01,h-cornerd,rotate==0?2:1);
  }
}

module lockspringcut(x,d,sl,sh) {
  hull() {
    translate([x+d*2+lockthickness*2-2.5-1,lockthickness,-sh/2-lockgap]) cube([sl+d*2-lockthickness*2+3+2,0.1,sh+lockgap*2]);
    translate([x+d*2+lockthickness*2-2.5,lockthickness-0.3,-sh/2-lockgap]) cube([sl+d*2-lockthickness*2+3,0.1,sh+lockgap*2]);
  }
  translate([x+d*2+lockthickness*2-2.5,-0.01,-sh/2-lockgap]) cube([sl+d*2-lockthickness*2+3,lockthickness+0.02,sh+lockgap*2]);
  hull() {
    translate([x+d*2-1,-0.4,-sh/2-lockgap]) cube([sl+d*2+lockthickness*2,0.4,sh+lockgap*2]);
    translate([x+d*2-1+lockthickness*2,-0.01,-sh/2-lockgap]) cube([sl+d*2-lockthickness*2,lockthickness+0.02,sh+lockgap*2]);
  }
}

module lock(i) {
  t=str(i+1);
  rotate=locktable[i][0];
  out=locktable[i][1];
  h=out?outlockh:disklockh;

  difference() {
    union() {
      lockbody(i);
    }

    translate([lockhandlethickness+lockhandlel+cornerd,lockthickness-textdepth+0.01,0]) rotate([90,rotate?0:180,180]) linear_extrude(height=textdepth) text(versiontext,size=keyh+2,halign=rotate?"right":"left",valign="center");
    if (out) {
      for (x=outscrewxtable) {
	if (x<outlockl-10) lockspringcut(x,outscrewdiameter,outscrewspringlength,outscrewspringheight);
      }
    } else {
      for (i=[0:1:len(diskscrewxtable)-1]) {
	x=i>0?diskscrewxtable[i-1]:diskscrewxtable[i]+diskscrewdiameter*2;
	l=i>0?diskscrewxtable[i]-diskscrewxtable[i-1]-diskscrewspringlength:diskscrewspringlength;
	
	if (x<disklockl-diskxposition-10) lockspringcut(diskxposition+x,diskscrewdiameter,l,keyh);
      }
    }
    translate([lockhandlel/2,-0.1,-h/2-1]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([lockhandlel/2,-0.1,-h/2+1+h]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([textdepth-0.01,lockhandlethickness/2,0]) rotate([90,rotate?0:180,-90]) linear_extrude(height=textdepth) resize([lockhandlethickness-3,0,0]) text(t,size=h-3,halign="center",valign="center");
  }
}

module smalldisklockcuts(i) {
  t=str(i+1);
  left=locktable[i][0];
  height=0;
  hh=min(smalldisklockh,smalldisklockhandleh-lockgap);
  handleh=min(smalldisklockh,smalldisklockhandleh-lockgap);

  if (smalldiskslots>1) for (z=[0:smalldiskslotstep:smalldisksh]) {
      for (x=smalldiskscrewxtable) {
	l=smalldiskscrewxtable[1]-smalldiskscrewxtable[0]-diskscrewspringlength-keyanglel-keycornerd-20;
	if (x<smalldisklockl-smalldiskxposition-10) translate([0,0,z+height+smalldiskscrewheight-ztolerance]) lockspringcut(smalldiskxposition+x,smalldiskscrewdiameter,diskscrewspringlength+l,keyh+1);
      }
      translate([0,0,z+height+smalldiskscrewheight-ztolerance]) lockspringcut(hh,smalldiskscrewdiameter,smalldiskxposition-hh*1.3-diskscrewspringlength/2,keyh+1);
    }
}

module smalldisklockbody(i) {
  t=str(i+1);
  left=locktable[i][0];
  height=0;
  hh=min(smalldisklockh,smalldisklockhandleh-lockgap);
  handleh=min(smalldisklockh,smalldisklockhandleh-lockgap);
  
  // Lock body
  hull() {
    translate([lockhandlel-cornerd,0,height]) roundedbox(smalldisklockl-lockhandlel+cornerd,lockthickness,smalldisklockhandleh-lockgap,cornerd,leftlockprintable);
    translate([lockhandlel-cornerd,lockthickness-1,height+0.5]) roundedbox(smalldisklockl-lockhandlel+cornerd+lockthickness,1,smalldisklockhandleh-lockgap-1,1,leftlockprintable);
  }
}

module smalldisklock(i) {
  t=str(i+1);
  left=locktable[i][0];
  height=0;
  hh=min(smalldisklockh,smalldisklockhandleh-lockgap);
  handleh=min(smalldisklockh,smalldisklockhandleh-lockgap);

  if (left) {
    difference() {
      union() {
	smalldisklockbody(i);
	
	// Handle
	translate([0,0,height]) roundedbox(lockhandlel,lockhandlethickness,handleh,cornerd,rightlockprintable);

	// Angled counter
	hull() {
	  translate([lockhandlel-0.01,lockthickness-0.01,height+cornerd/2]) cube([0.8+0.01,lockwall+0.01,hh-cornerd]);
	  translate([lockhandlel+0.8,lockthickness-0.01,height+cornerd/2]) triangle((hh-cornerd)*1.3,lockwall+0.01,hh-cornerd,1);
	}
      }

      // Cut finger form for handle
      translate([lockhandlel,lockhandlethickness,height-0.01]) cylinder(r=lockhandlethickness-lockwall-lockthickness,h=hh+0.02,$fn=smallfn);
      
      //translate([lockhandlel+0.8+hh*1.3,lockthickness-textdepth+0.01,height+hh/2]) rotate([90,0,180]) linear_extrude(height=textdepth) text(versiontext,size=handleh-cornerd,halign="right",valign="center");
      translate([smalldiskxposition+2,lockthickness-textdepth+0.01,height+hh/2]) rotate([90,0,180]) linear_extrude(height=textdepth) text(versiontext,size=smalldiskscrewheight*2-cornerd,halign="right",valign="center");

      smalldisklockcuts(i);
      
      translate([textdepth-0.01,lockhandlethickness/2,height+hh/2]) rotate([90,0,-90]) linear_extrude(height=textdepth) resize([lockhandlethickness-cornerd,0,hh-cornerd]) text(t,size=hh-2,halign="center",valign="center");
    }
  } else {
    difference() {
      union() {
	translate([0,lockthickness,0]) mirror([0,1,0]) smalldisklockbody(i);

	// Handle
	translate([0,-lockhandlethickness+lockthickness,height]) roundedbox(lockhandlel,lockhandlethickness,handleh,cornerd,rightlockprintable);

	// Angled counter
	hull() {
	  translate([lockhandlel-0.01,-lockwall+0.01,height+cornerd/2]) cube([0.8+0.01,lockwall+0.01,hh-cornerd]);
	  translate([lockhandlel+0.8,-lockwall+0.01,height+cornerd/2]) triangle((hh-cornerd)*1.3,lockwall+0.01,hh-cornerd,1);
	}
      }

      translate([lockhandlel,-lockhandlethickness+lockthickness,height-0.01]) cylinder(r=lockhandlethickness-lockwall-lockthickness,h=hh+0.02,$fn=smallfn);
      translate([smalldiskxposition+2,textdepth-0.01,height+hh/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,size=smalldiskscrewheight*2-cornerd,halign="left",valign="center");

      translate([0,lockthickness,0]) mirror([0,1,0]) smalldisklockcuts(i);
      
      translate([textdepth-0.01,-lockhandlethickness+lockthickness+lockhandlethickness/2,height+hh/2]) rotate([90,0,-90]) linear_extrude(height=textdepth) resize([lockhandlethickness-cornerd,0,hh-cornerd]) text(t,size=hh-2,halign="center",valign="center");
    }
  }
}

module printsnobrim() {
  if (!simple && (print==2 || print==3)) {
    if (!simple) {
      // Side parts
      l1=height+brimw+0.5;

      // Side slides or guides
      // aopen and guide versions place locks inside holder
      l2=l1+((aopenversion||guideversion)?0:sideslideversion?(sideslideinh+0.5)*2:screwversion?(outlockh+0.5)*2:0);

      // Disk locks
      l3=olddisklocksystem?l2+diskslots*(disklockh+0.5)*2:l2+diskslots*(disklocktotalw+diskpinw+disklockwall+0.5)*2;

      // l1 is side slides, guides or outer locks
      // l2 is disk locks
      // l3 is small disk locks
      echo(l1,l2,l3);
      
      translate([l1,0,0]) if (!guideversion && !sideslideversion && !aopenversion) {
	translate([outlockh/2,0,0]) {
	  for (i=[0,3]) {
	    translate([floor(i/3)*(outlockh+0.5),0,0]) rotate([90,0,90]) lock(i);
	  }
	}
      } else {
	if (sideslideversion) {
	  translate([sideslideinh/2,0,0]) {
	    for (i=[0,3]) {
	      translate([floor((i/3)*(sideslideinh+0.5)),0,sideslidewall*2]) rotate([-90,0,90]) {
		if (sideslidescrewheads) sideslideheads();
		if (sideslidescrewholes) sideslidescrewholes();
		if (sideslideclips) sideslideclips();
	      }
	    }
	  }
	}
      }

      if (olddisklocksystem) {
	translate([l2,0,0]) if (diskslots>0) {
	  translate([disklockh/2,0,0]) {
	    for (ds=[0:1:diskslots-1]) {
	      translate([ds*(disklockh*2+1),0,0]) {
		for (i=[1,2]) {
		  translate([(i-1)*(disklockh+0.5),0,0]) {
		    rotate([90,0,90]) lock(i);
		  }
		}
	      }
	    }
	  }
	}
      } else {
	translate([l2,-brimw,0]) if (diskslots>0) {
	  translate([0,-wall-xtolerance,0]) {
	    for (i=[0:1:diskslots*2-1]) {
	      translate([(disklocktotalw+diskpinw+disklockwall+0.5)*i,0,0]) {
		rotate([0,0,90]) translate([0,disklocksink-6.5,diskscrewd/2]) disklock();
		translate([0,-6.5-3-0.5,diskpinhandlew+0.4]) translate([disklocktotalw+disklockwall/2+0.5,0,0]) rotate([90,0,90]) translate([0,0,diskscrewd/2]) diskpin();
	      }
	    }
	  }
	}
      }
      
      if (smalldiskslots>0) {
	translate([l3,-10,0]) if (smalldiskslots>0) {
	  translate([smalldisklockh/2,smalldisklockl,0]) {
	    translate([smalldisklockhandleh-smalldisklockh/2,-smalldisklockl,0]) rotate([90,0,90]) smalldisklock(4);
	    translate([-smalldisklockh/2+smalldisklockhandleh-0.5,-smalldisklockl,lockthickness]) rotate([-90,0,90]) smalldisklock(5);
	  }
	}
      }
    }
  }

  if (guideversion) {
    if (print==4 || print==1 || print==3) {
      translate([guidew+sidewall-guidesloty+guideslotoutw+guidebrimw+0.5,width/2-(guideclipattachl+guideclipattachx+guideclipl)/2,guidecliph/2]) rotate([0,0,90]) {
	translate([7.7,2.5,0]) rotate([0,0,-8]) guideclip();
	translate([7.7,8+guidew+0.5,0]) rotate([0,0,-8]) guideclip();
      }
    }
  }

  if (aopenversion) {
    if (print==4 || print==1 || print==3) {
      translate([aopenw+sidewall-aopensloty+aopenslotoutw+aopenbrimw+0.5,width/2-(aopenclipattachl+aopenclipattachx+guideclipl)/2-10,aopencliph/2]) rotate([0,0,90]) {
	translate([11,7,0]) rotate([0,0,-11]) aopenclip();
	translate([11,13+guidew+0.5,0]) rotate([0,0,-11]) aopenclip();
      }
    }
  }

  if (print==5) {
    if (slots<=1) {
      translate([0,0,coverdepth]) rotate([0,-90,0]) cover();
    }
  }
  
  if (print==8) {
    if (sideslideversion) {
      translate([sideslideinh/2,0,0]) {
	for (i=[0,3]) {
	  translate([floor((i/3)*(sideslideinh+0.5)),0,sideslidewall*2]) rotate([-90,0,90]) {
	    if (sideslidescrewheads) sideslideheads();
	    if (sideslidescrewholes) sideslidescrewholes();
	    if (sideslideclips) sideslideclips();
	  }
	}
      }
    }
  }

  if (print==9 || print==5) {
    if (slots>1) {
      translate([0,width/2,0]) for (i=[0:1:3]) {
	translate([i*(coverclipl+coverclipoverhang*2+0.5)+coverclipw+coverclipoverhang+wall,width/2-(abs?0:coverpullshrink)+brimw+0.5+covercliptotalh/2+0.5,coverclipw/2]) rotate([90,0,0]) lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,0,text=versiontext,textdepth=0.7);
      }
    }
  }
}

module printswithbrim() {
  if (print==1 || print==3) {
    rotate([0,0,90]) {
      translate([width,0,0]) rotate([0,-90,90]) render() holder();
    }
  }

  if (print==5) {
    if (slots>1) {
      translate([height,width/2,coverdepth]) rotate([0,-90,0]) cover();
    }
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([-200,-200,-200]) cube([1000,1000,200+coverclipoutw/2+coverclipw/2-0.01]); // coverclips
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight-5]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+outscrewztable[0]]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([180,110,200]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight-5]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight-5.5-1.6]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight-5.5]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight-5.5-2+diskslotstep]); // Debug guides
    //if (debug) translate([-100,6,-100]) cube([1000,-6+disky,100+guideheight-4]); // Debug disklock
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+smalldiskheight+5]); // Debug guides smalldisk lower
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+smalldiskheight+5+smalldiskh*2]); // Debug guides smalldisk upper
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+oldclipheighttable[0]+2]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight+4]); // Debug guides
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+aopenheight+aopenh/2]); // aopen
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,105+outscrewztable[0]]);
    //if (debug) translate([-100,33,-100]) cube([1000,1000,1000]);
    //if (debug) translate([-100,20,-100]) cube([1000,1000,1000]);
    //if (debug) translate([-100,50,-100]) cube([1000,1000,1000]);
    difference() {
      union() {
	translate([-xtolerance,width/2,0]) render() cover();
	
	render() holder();
	
	if (0) if (!simple && !guideversion && !sideslideversion && !aopenversion) {
	  translate([0,sidewall+lockgap,outscrewztable[0]]) rotate([0,0,0]) lock(3);
	}
	
	if (olddisklocksystem) {
	  if (!simple && diskslots>0) translate([0,sidewall+sidecutwidth-lockgap,bottomthickness+diskscrewheight]) rotate([180,0,0]) lock(2);
	} else {
	  for (z=[0:diskslotstep:disksh]) {
	    translate([0,disklocky,diskheight+z+diskscrewheight]) {
	      //disklock();
	      //translate([diskpinin==1?0:diskpinslidel+wall*3,0,0]) diskpin();
	    }
	  }
	}
	
	if (!simple && smalldiskslots>0) {
	  translate([0,smalldiskyposition-sidewall-lockgap-lockthickness,smalldiskheight+lockgap/2]) smalldisklock(5);
	  translate([0,width-(smalldiskyposition-sidewall-lockgap),smalldiskheight+lockgap/2]) smalldisklock(4);
	}
	
	if (guideversion) {
	  for (slot=cliptable[slotconfig]) {
	    translate([0,0,slot*sloth+guideheight]) guideclip();
	  }
	}

	if (aopenversion) {
	  for (slot=cliptable[slotconfig]) {
	    translate([0,0,slot*sloth+aopenheight+aopenh/2]) aopenclip();
	  }
	}
	
	if (sideslideversion && sideslidescrewheads) translate([0,0,outscrewztable[0]]) sideslideheads();
	if (sideslideversion && sideslidescrewholes) translate([0,0,outscrewztable[0]]) sideslidescrewholes();
	if (sideslideversion && sideslideclips) translate([0,0,outscrewztable[0]]) sideslideclips();
      }

      for (z=coverclipztable) {
	translate([coverclipx,coverclipy,z]) rotate([90,0,90]) {
	  #lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,0,text=versiontext,textdepth=0.7);
	}
      }
	    
      if (0) {
	for (i=[0:1:diskslots-1]) {
	  %translate([diskxposition,width/2-diskw/2,bottomthickness+i*diskslotstep]) cube([disklength,diskw,diskh]);
	}
	
	if (smalldiskslots>0) for (i=[0:1:smalldiskslots-1]) {
	    %translate([smalldiskxposition,width/2-smalldiskw/2,smalldiskheight+i*smalldiskslotstep]) cube([smalldiskl,smalldiskw,smalldiskh]);
	  }
      }
    }
  }
 }

if (print==1 || print==3 || (print==5 && slots>1)) {
  if (abs) {
    difference() {
      union() {
	brim(w=brimw,heatcoverh=(useheatwall?heatwallh:0),heatcoverwall=0.4) printswithbrim();
	adhesionl=60;
	if (0) if (print==1 || print==3) {
	  extraw=brimw+10+aopenclipw*aopenversion;
	  translate([-brimw,-extraw,0]) roundedboxxyz(adhesionl,extraw*2+width,0.6,outsidecornerd,0,0);
	  translate([height-adhesionl+brimw,-extraw,0]) roundedboxxyz(adhesionl,extraw*2+width,0.6,outsidecornerd,0,0);
	}
      }
      brimcut(w=brimw) printswithbrim();
    }
  }
  
  printswithbrim();
 }

if (print==1 || print==2 || print==3 || print==4 || print==5 || print==8 || print==9) {
  printsnobrim();
}

if (print==20) {
  translate([0,0,16]) rotate([-90,0,0]) translate([0,-6,0]) intersection() {
    union() {
      //translate([-100,7,4]) cube([1000,-7+disky,guideheight-4-4+1]); // Debug disklock
      translate([-100,5.2,0]) cube([100+covercliptotall,disky-5.2,guideheight-4-4+1+5]); // Debug disklock
    }
    holder();
  }

  translate([20,14,coverdepth]) rotate([0,-90,0]) intersection() {
    translate([-100,0,0]) cube([100+covercliptotall,disky+10,guideheight-4-4+1+5]); // Debug disklock
    translate([0,width/2,0]) cover();
  }
      
  translate([-coverclipl/2-0.5,covercliph/2-1,coverclipw/2]) rotate([90,0,0])  lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,0,text=versiontext,textdepth=0.7);
  
  y=disklocksink-6.7;
  //translate([0,y,diskscrewd/2]) disklock();
  //translate([0,y-disklockwall-diskpinbodyw-diskpinbodyw,0]) rotate([90,0,0]) translate([0,-diskpiny,diskscrewd/2]) diskpin();
 }

