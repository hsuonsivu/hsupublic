// glassless film holder for Epson V850 pro

// TODO:
// Major cleanup of old stuff. Some fixes, but obsolete stuff and spaghetti still there
// Narrow framew to filmw, as 35mm film seems to fit fine due to shrinkage -- ok for 35, 46 under testing

use <hsu.scad>;

print=0; // 1 = print film frame, 2 print 1 cover set, 2 = print covers for all film frames, 3 = print one whole set, 4 print attachment test
debug=0; // 1 just one strip, 2 smallest possible
testcuts=0; // Cutouts to reveal clip structures.

filmtype=35;//35;//110; // 110 //35; //46; //35; // 35mm or 46, 912 for 9x12

// large 912 

// Table of film formats

// number of strips in frame, film width, frame length, image width,
// distance between frames, frameseparators used, frame separator
// width, open film holes to avoid reflections, open side gaps to scan
// film codes, filmsupport notches, space between one-frame films,
// space between film strips

// [strips, film width, frame length, image width, image length, distance between frames, frameseparators, frameseparator width, antireflection, open sides, support notches, space between one-frame films, space between film strips],

film=(filmtype==35)?0:(filmtype==46)?1:(filmtype==110)?2:(filmtype==912)?3:-1;
if (film==-1) {
  echo("ERROR Unknown film type ",filmtype);
 }

// 912 type is turned 90 degrees, other formats are x direction.

// Name of the film type
FILMNAME=0;

// Number of film strips in frame
FILMSTRIPS=1;

// Width of the film
FILMWIDTH=2;

// Width of the picture frame
FILMFRAMEWIDTH=3;

// Length of the picture frame
FILMFRAMELENGTH=4;

// Width of the image area
FILMIMAGEWIDTH=5;

// Length of the image area
FILMIMAGELENGTH=6;

// Distance of frames on film
FILMDISTANCEBETWEENFRAMES=7;

// Distance of the frame from edge. 0 for centered to the film
FILMFRAMEFROMEDGE=8;

// Add frame separator bars 
FILMFRAMESEPARATORS=9;

// Width of the frame separator bar
FILMFRAMESEPARATORWIDTH=10;

// Angle film openings slightly to reduce reflections
FILMANTIREFLECTION=11;

// This is not used anywhere?
FILMOPENSIDES=12; // 2=35mm only, 1=35 and 110

// Small notches added to sides to support film minimizing covering possible markings
FILMSUPPORTNOTCHES=13;

// Film types which have one single image per frame
FILMONEFRAMEFILM=14;

// Multiple single films used, distance between them
FILMONEFRAMEFILMOFFSET=15;

// Length of the film strip (example)
FILMLENGTH=16;

// Film has sprocket holes
FILMSPROCKETS=17;

// Film has sprocket holes on one side only (110, for example)
FILMSPROCKETONESIDE=18;

// Distance between sprocket holes
FILMSPROCKETDISTANCEWIDTH=19;

// Distance of the sprocket hole from film edge
FILMSPROCKETFROMEDGE=20; // If FILMSPROCKETONESIDE, this is taken from FILMSPROCKETDISTANCEWIDTH

// Width of the sprocket hole
FILMSPROCKETWIDTH=21;

// Length of the sprocket hole
FILMSPROCKETLENGTH=22;

// Distance between sprocket holes
FILMSPROCKETDISTANCE=23;

// Width between film strips. Wider makes structure stronger but uses more space in the scanning glass
FILMHOLDERGAP=24;

// How much edges of the film is covered by structure keeping the film in place
FILMEDGECOVER=25;

// Cover is using side clips to keep the cover in place, how many of them are used per frame.
FILMSIDECLIPSPERFRAME=26;

// Start of the image frame from start of film strip
FILMFRAMESTART=27;

// Slits are created to scan sides of the film containing film type codes etc, so they can be included in the scanning process
FILMSLITS=28;

// Epson Id hole code. 35mm strip adapter=1, 912 adapter=2. Epson does not have 46mm or 110 adapter.
EPSONIDHOLETYPE=29;

// Do shrink compensation
FILMSHRINKADJUST=30;
  
CALCULATED=999999;
NA=0; // Value not used

//              0  1     2      3     4         5       6     7          8  9   10 11 12 13 14 15 16 17 18     19 20     21     22    23   24          25 26    27 28 29 30
filmtable=[[ "35", 4,   35,  24.5,   36,     24.6,     36,   38,         0, 1, 0.8, 1, 2, 0, 0, 0, 5, 1, 0, 25.17, 0, 2.794, 1.854, 38/8, 8.4,          0, 2, 0.35, 1, 1, 1 ],
	   [ "46", 3, 45.9,    40,   44, 45.9-0.5,     40,   46,         0, 1, 0.8, 0, 0, 1, 0, 0, 4, 0, 0,    42, 0,     1, 1.854,    0, 8.4, CALCULATED, 2,    2, 0, 2, 1 ],
	   ["110", 7,   16,    13,   17,   16-0.5,     17,   25, 16-1.9-13, 1, 0.8, 1, 1, 0, 0, 0, 7, 1, 0,   0.8, 0,  1.75,   2.5,   25, 8.4, CALCULATED, 1,    5, 0, 1, 1 ],
	   ["912", 1,  119, 119-4, 88.2,  119-0.5, 88.2-4, 88.2,         0, 1,   1, 0, 0, 1, 1, 4, 1, 0, 0, 113.9, 2,     2, 1.854,    0,  10, CALCULATED, 3,    1, 0, 3, 0 ],
	   ];

for (f=[0:1:3]) {
 }

// Observed on kodak film. This needs to be debugged, as it is not used universally. XXX
filmshrunksize=149;
filmshouldbesize=(filmtable[film][FILMSHRINKADJUST]?150:149);

filmshrink=filmshrunksize/filmshouldbesize;
filmshrinktext=str(floor(10000*(filmshouldbesize-filmshrunksize)/filmshouldbesize)/100,"%");

tappitypemale=1; // 0 = rounded cube, 1 = circular
tappitypefemale=1; // 0 = rounded cube, 1 = circular
filmstrips=((debug>0) || (print==5))?1:filmtable[film][1];
detachable_epson_bits=1;
idsquares=0; // Squares used by the scanner to determine of scanning frame is used. This does is work-in-progress;
adhesion=print>0?0:0; // Adds some structures to increase bed adhesion.
tassusizelarge=10;
tassusizesmall=5;
antiwarp=0;

frameseparators=filmtable[film][FILMFRAMESEPARATORS];

v="V1.42";
versiontext=debug?str(v, "-", debug):v;

copyrighttext="© Heikki Suonsivu CC-BY-NC-SA";
  
textdepth=1;
textsize=6;
textxposition=textsize/3;
copyrighttextsize=5;

wall=textdepth+1;

cornerd=0.3;

xtolerance=0.4;
ytolerance=0.5;
xhookholetolerance=0.5;
yhookholetolerance=0.5;
ztolerance=0.3;
tappiztolerance=0.35;

length=(debug==2)?90:(debug==1)?225:230;

thickness=5; // Thickness.

// filmw is width of the film strip

filmw=filmtable[film][FILMWIDTH];

// Framew is width of the picture frame
framew=filmw;

holedistance=filmtable[FILMSPROCKETDISTANCE];

// Framel is length of single picture frame (including any overhead)
// For single film such as 912, this is fill length of film
// This does not include space taken by separators between images on film
// Single films do not have frame gaps.

framel=filmtable[film][FILMFRAMELENGTH];//(filmtype==35)?36:(filmtype==110?17:(filmtype==46?44:(filmtype==912)?88.8:0)); // 118.5

// Width of image area (for 46mm film this is expanded close to film
// width, as the pictures are not framed exactly and we want to scan
// film type codes in the sides. For 35mm side data is scanned through
// side slits so this does not need to be that accurate.

// Frameimagew is the image area of the film (not including side
// perforations and such. This is the width which needs to be scanned
// for image.

frameimagew=filmtable[film][FILMIMAGEWIDTH];//(filmtype==35) ? 24.6 : (filmtype==46 ? filmw-0.5 : (filmtype==110 ? filmw-0.5 : (filmtype==912) ? filmw-0.5: 0));
frameimagey=framew/2-frameimagew/2;

filmholdery=31;
filmholderx=15;
filmthickness=0.18; // was 0.2, 0.12 measured - note needs to have some slack due to tolerance issues
// frame starts at hole, new frame every 8 holes.

// XXX these values are not right, sometimes this is calculated from middle of the film, sometimes absolute - need to fix
scannerfocusheight=2-filmthickness/2; // Scanner focus point above the glass

filmheigthfromscansurface=thickness-scannerfocusheight-filmthickness/2;

coverh=thickness-scannerfocusheight;

// Position of the film from scanner glass
filmheight=coverh-filmthickness;

// If filmtype is fixed size and multiple films can be scanned in one go, need a bit of separation between films.
filmseparatorgap=filmtable[film][FILMONEFRAMEFILMOFFSET];
filmseparatorbetweenl=filmseparatorgap?filmseparatorgap-xtolerance*2:0;

// First frame start
framestart=1+filmseparatorbetweenl;

frameseparator=filmtable[film][FILMFRAMESEPARATORWIDTH];
frameseparatoroffset=(2-frameseparator)/2;
framedistance=filmtable[film][FILMDISTANCEBETWEENFRAMES];

// Openings widened toward scanning glass to reduce reflections
narrowing=(filmtable[film][FILMANTIREFLECTION]?scannerfocusheight*0.7:0);
framewidenedw=frameimagew+narrowing*2;
framewidenedy=framew/2-framewidenedw/2;

// Make small support notches for 46mm
framesidesupportwidening=1.0;
framesidesupportw=frameimagew-framesidesupportwidening;
framesidesupportdistance=framedistance/4;

adapterw=19.7; // From right side
adapterl=24.9;
adapteroffset=18; // From top
adaptertappid=4.85;
adaptertappih=6.5; // From base
adapterdistance=182;
adapterh=1.5;
adaptertextx=adapterl/2; // relative from start of adapter
adaptertexty=-9-textsize; // relative from start of adapter
adapterattachy=4;
adapterattachx=18;
adapterattachd=adapterattachy-0.5;
adapterattachxin=3;
adapterattachxtolerance=0.14;
adapterattachytolerance=0.14;
adapterattachdtolerance=0.10;
adapterattachdxoffset=0.5;
adapteraxlesink=0.5;
adapteraxled=thickness-adapterh-ztolerance;
adapteraxledepth=2;
adapteraxleheight=adapterh+adapteraxled/2+ztolerance;
dtolerance=0.7;
adapterattachyoffset=1;

// Epson Id hole code. 35mm strip adapter=1, 912 adapter=2. Epson does not have 110 adapter. There is medium format adapter which can take 46mm+ films.
// 35mm holder has 3 holes in row
// medium format holder has 2 left holes and one centered 2.23mm below
// 912 holder has 3 holes in row, and one centered between two right holes 2.23mm below
// 46/912 holders have positioning holes 3.81 below at edges of the film. We are testing with 46mm film positioning holes.
// 912 holder has different orientation for the film, as it only allow one film at the. We use our positioning.

idcenterholey=127.5-adapterw;
idleftholey=idcenterholey-3.82;
idrightholey=idcenterholey+3.82;
idoffset=adapteroffset-9.46;
idholed=1.4;

idsquareoffset=90;
idsquarew=7.1;
idsquareyoffset1=10.4;
idsquareyoffset2=200;
//idsquareframew=25.1; This is too large to fit in ankermake printer. Does not work with 35mm slides with 4 strips
idsquareframew=20;
idsquareframeyoffset1=idsquareyoffset1+idsquarew/2-idsquareframew/2;
idsquareframeyoffset2=idsquareyoffset2+idsquarew/2-idsquareframew/2;
idsquareframeoffset=idsquareoffset+idsquarew/2-idsquareframew/2;

idsquarecliptolerance=0.5;
idsquareclipd=2;
idsquareclipdepth=max(xtolerance,ytolerance)+idsquarecliptolerance;
idsquareclipl=idsquarew/2;

filmholderl=length-filmholderx*2;
filmholdergap=filmtable[film][FILMHOLDERGAP];
filmholderoffset=framew+filmholdergap;

filmwidenedw=filmw+narrowing*2;
filmwidenedy=framew/2-filmwidenedw/2;

filmedgecover=(filmtable[film][FILMEDGECOVER]==CALCULATED)?(filmw-frameimagew)/2:filmtable[film][FILMEDGECOVER];

guidew=22;
guidel=36;
guideh=wall;
guidey=2;
guidex=adapteroffset+adapterdistance-wall-guidel;
  
lightenholeystart=7;
lightenholexstart=filmholderx;
lightenholexend=adapteroffset+adapterdistance-wall-adapterl-wall-guidel-wall-1;
lightenholes=floor((lightenholexend-lightenholexstart)/24);
lightenholestep=(lightenholexend-lightenholexstart)/lightenholes;
lightenholey=17;
lightenholexoffset=2.5;
lightenholex=lightenholestep-lightenholexoffset;

rolldiameter=100;

width=filmholdery+filmstrips*(framew+filmholdergap)+1.5;

clipdepth=0.6;
cliph=2;
clipz=1;
clipx=1.2;
clipdistance=20;
clipwidth=20;
clipxtolerance=0.30;
clipytolerance=0.5;

sideclipsperframe=filmtable[film][FILMSIDECLIPSPERFRAME];
sideclipxtolerance=0.50;
sideclipdepth=0.7;
sidecliph=2;
sideclipgap=1+sideclipxtolerance*2;
sideclipz=1;
sideclipy=1.2;
sideclipwidth=6;
sideclipmargin=3;
sidecliparea=framedistance-frameseparator-sideclipmargin*2;
// Length of single sideclip (both sides)
sideclipsl=sideclipwidth*2+sideclipgap;
sideclipsgapx=sidecliparea-sideclipsl*sideclipsperframe-sideclipsl/2;
sideclipsgap=sideclipsgapx<1+sideclipxtolerance*2?sideclipgap:sideclipsgapx;
// Distance between sideclips (inside a frame)
sideclipdistance=(sidecliparea-sideclipsl)/(sideclipsperframe-1);
// Length of sideclips area (inside a frame)
sideclipsalll=(sideclipdistance)*(sideclipsperframe-1)+sideclipsl;
sideclipspace=1.5;
sideclipoffset=sideclipwidth+sideclipgap;
sideclipysink=2.2;
sideclipytolerance=0.30;
// Start of side clips from start of frame. This is centered to the frame
sideclipstart=frameseparator/2+sideclipmargin;
sideclipend=filmholderx+framestart+filmholderl-sideclipmargin*2-sideclipsl;
  
holdertotalw=framew+sideclipysink+ytolerance+sideclipy;

covertopwiden=7.5;
covertopw=framew+covertopwiden;
covertoph=1-filmthickness;

filmframew=filmtable[film][FILMFRAMEWIDTH];
filmsprocketoneside=filmtable[film][FILMSPROCKETONESIDE];
filmframefromedge=filmtable[film][FILMFRAMEFROMEDGE]?filmtable[film][FILMFRAMEFROMEDGE]:filmw/2-filmframew/2;
filml=framedistance*filmtable[film][FILMLENGTH];
filmsprocketdistancew=filmtable[film][FILMSPROCKETDISTANCEWIDTH];
filmsprocketw=filmtable[film][FILMSPROCKETWIDTH];
filmsprocketl=filmtable[film][FILMSPROCKETLENGTH];
filmsprocketcornerd=0.4;
filmframel=filmtable[film][FILMIMAGELENGTH];
filmframecornerd=3;
filmsprocketfromedge=(filmtable[film][FILMSPROCKETONESIDE]?filmsprocketdistancew:filmtable[film][FILMSPROCKETFROMEDGE]?filmtable[film][FILMSPROCKETFROMEDGE]:(filmw-filmsprocketdistancew-filmsprocketw*2)/2);

module epsonidholes(type) {
  // All holders have two holes
  if (type>0) {
    translate([idoffset,idcenterholey,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
    translate([idoffset,idleftholey,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
  }
  if (type==1 || type==3) {
    translate([idoffset,idrightholey,-0.1]) cylinder(d=idholed,h=thickness+0.2,$fn=30);
  }
  if (type==2) {
    translate([idoffset+2.23,(idleftholey+idcenterholey)/2,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
    translate([idoffset+3.81,filmholdery+filmholderoffset,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
    translate([idoffset+3.81,filmholdery+filmholderoffset+filmw,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
  }
  if (type==3) {
    translate([idoffset+2.23,(idrightholey+idcenterholey)/2,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
    translate([idoffset+3.81,filmholdery,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
    translate([idoffset+3.81,filmholdery+filmw,-0.01]) cylinder(d=idholed,h=thickness+0.02,$fn=30);
  }
}

module filmstrip() {
  h=thickness-scannerfocusheight-filmthickness;
  yy=filmholdery+framew/2-filmw/2;
  difference() {
    union() {
      translate([filmholderx+framestart,yy,h]) cube([filml,filmw,filmthickness]);

      for (x=[filmholderx+framestart+filmtable[film][FILMFRAMESTART]:framedistance:filmholderx+framestart+filml-2]) {
	color("blue") translate([x+1,yy+filmframefromedge,h]) roundedboxxyz(filmframel,filmframew,filmthickness+0.01,filmframecornerd,0,0,30);
      }
    }
    if (filmtable[film][FILMSPROCKETS]) {
      for (x=[filmholderx+framestart+1:holedistance:filmholderx+framestart+filml-2]) {
	for (y=[yy+filmw/2-filmsprocketdistancew/2-filmsprocketw,yy+filmw/2+filmsprocketdistancew/2]) {
	  	  translate([x,y,h-0.01]) roundedboxxyz(filmsprocketl,filmsprocketw,filmthickness+0.02,filmsprocketcornerd,0,0,30);
	}
      }
    }

    if (filmtable[film][FILMSPROCKETONESIDE]) {
      for (x=[filmholderx+framestart+1:holedistance:filmholderx+framestart+filml-2]) {
	for (y=[yy+filmw-filmsprocketdistancew-filmsprocketw]) {
	  	  translate([x,y,h-0.01]) roundedboxxyz(filmsprocketl,filmsprocketw,filmthickness+0.02,filmsprocketcornerd,0,0,30);
	}
      }
    }
  }
}

module triangle(x,y,z,mode) {
  if (mode==0) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x,z],[x,0]]);
  } else if (mode==1) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z]]);
  } else if (mode==2) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,0]]);
  } else if (mode==3) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x,0]]);
  } else if (mode==4) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y,x],[y,0]]);
  } else if (mode==5) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x]]);
  } else if (mode==6) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,0]]);
  } else if (mode==7) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y,0]]);
  } else if (mode==8) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z,y],[z,0]]);
  } else if (mode==9) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y]]);
  } else if (mode==10) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,0]]);
  } else if (mode==11) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z,0]]);
  }
}

// height=total diameter, toph=height of narrowing top part 
module tappi(diameterx,diametery,height,toph,cd,circulartappi,down) {
  if (circulartappi) {
    diameter=min(diameterx,diametery);
    th=toph>0?toph:diameter/3;
    translate([diameter/2,diameter/2,0]) {
      if (down) {
	translate([0,0,th]) cylinder(h=height-th,d=diameter,$fn=30);
	cylinder(h=th+0.01,d1=diameter/3,d2=diameter,$fn=30);
      } else {
	cylinder(h=height-th,d=diameter,$fn=30);
	translate([0,0,height-th-0.01]) cylinder(h=th+0.01,d1=diameter,d2=diameter/3,$fn=30);
      }
    }
  } else {
    // toph is ignored here
    roundedbox(diameterx,diametery,height,cd);
  }
}

module roundedbox(x,y,z,c) {
  corner=(c && (c > 0)) ? c : 1;
  scd = ((x < corner || y < corner || z < corner) ? min(x,y,z) : corner);
  f=(print > 0) ? 30 : 30;
  
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
  }
}

module scanadapter() {
  if (adhesion) {
    tassu(-135,tassusizesmall);
    translate([length,width,0]) tassu(45,tassusizesmall);
    translate([0,width,0]) tassu(135,tassusizesmall);
  }
  

  difference() {
    // Adapters
    for (x=[adapteroffset:adapterdistance:length-adapterl]) {
      debugangle=(print==0 && x>adapteroffset)?180:0;
      translate([0,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([debugangle,0,0]) translate([0,-(adapteraxled/2+adapteraxlesink),-adapteraxleheight]) {
	{
	  translate([x,-adapterw,0]) roundedbox(adapterl,adapterw+(detachable_epson_bits?-1:cornerd),adapterh,cornerd);
	  if (adhesion) {
	    translate([x,-adapterw,0]) tassu(-135,tassusizelarge);
	    translate([x+adapterl,-adapterw,0]) tassu(-45,tassusizesmall);
	  }
	  translate([x+adaptertappid/2,-adapterw+adaptertappid/2,cornerd/2]) cylinder(h=adaptertappih-cornerd/2,d=adaptertappid,$fn=90);
	  if (detachable_epson_bits) {
	    translate([x+(adapterl-adapterattachx)/2,0,0]) {
	      translate([0,-cornerd-1,0]) cube([adapterattachx,adapteraxlesink+cornerd+1,adapterh]);
	      hull() {
		translate([0,adapteraxlesink,0]) cube([adapterattachx,adapteraxled,adapterh]);
		translate([0,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,90,0]) cylinder(d=adapteraxled,h=adapterattachx,$fn=30);
	      }
	      translate([adapterattachx/2,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,0,90]) onehinge(adapteraxled,adapterattachx,adapteraxledepth,0,ytolerance,dtolerance);
	    }
	  }
	}
      }
    }
	
    if (0) for (x=[adapteroffset:adapterdistance:length-adapterl]) {
      translate([x+adapterl/2,adaptertexty,adapterh-textdepth-0.01])  linear_extrude(height=textdepth+0.02) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    }
  }
  
  difference() {
    union() {
      roundedbox(length,width,thickness,cornerd);

      // White squares possibly used for film scan frame identification? TODO
      if (idsquares) {
	difference() {
	  union() {
	    for (y=[idsquareframeyoffset1,idsquareframeyoffset2]) {
	      translate([idsquareframeoffset,y,0]) roundedbox(idsquareframew,idsquareframew,thickness,cornerd);
	    }

	    if (idsquareframeyoffset2>width-cornerd) {
	      translate([idsquareframeoffset,width-cornerd]) roundedbox(idsquareframew,idsquareframeyoffset2-width+cornerd*2,thickness,cornerd);
	    }
	  }
	}
      }
    }

    epsonidholes(filmtable[film][EPSONIDHOLETYPE]);
    
    // Adapters cut
    if (detachable_epson_bits) {
      for (x=[adapteroffset:adapterdistance:length-adapterl]) {
	h1=adapterh+thickness-adaptertappih-0.01;
	h2=adhesion?max(h1,0.2):h1;
	translate([x+adaptertappid/2,adapterw-adaptertappid/2+(adapteraxled/2+adapteraxlesink)*2,h2]) cylinder(h=adaptertappih+0.02,d=adaptertappid+1,$fn=90);

	translate([x+(adapterl-adapterattachx)/2,0,0]) {
	  translate([-adapterattachxtolerance,-0.01,-0.01]) cube([adapterattachx+adapterattachxtolerance*2,adapteraxled+adapteraxlesink+dtolerance/2+0.01,thickness+0.02]);
	  translate([adapterattachx/2,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,0,90]) onehinge(adapteraxled,adapterattachx,adapteraxledepth,1,ytolerance,dtolerance);
	}
      }
    }

    if (idsquares) {
      for (y=[idsquareyoffset1,idsquareyoffset2]) {
	translate([idsquareoffset,y,-0.01]) cube([idsquarew,idsquarew,thickness+0.02]);
	translate([idsquareoffset+idsquarew/2,y+idsquarew/2,thickness/2]) {
	  for (clipy=[-idsquarew/2+idsquarecliptolerance,idsquarew/2-idsquarecliptolerance]) {
	    translate([0,clipy,0]) tubeclip(idsquareclipl,idsquareclipd,idsquarecliptolerance);
	  }
	  for (clipx=[-idsquarew/2+idsquarecliptolerance,idsquarew/2-idsquarecliptolerance]) {
	    translate([clipx,0,0]) rotate([0,0,90]) tubeclip(idsquareclipl,idsquareclipd,idsquarecliptolerance);
	  }
	}

	for (clipy=[y-idsquarew/2-idsquareclipdepth,y+idsquarew/2+idsquareclipdepth]) {
	}
      }
    }
    
    // Film openings
    for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
      // Open slits in sides to let scanner see film type and bar codes
      if (filmtable[film][FILMSLITS]) {
	for (yy=[y+framew/2-filmw/2,y+framew/2+filmw/2-filmsprocketfromedge]) {
	  translate([filmholderx,yy,-0.01]) cube([filmholderl,filmsprocketfromedge,thickness-scannerfocusheight+0.02]);
	}
      }
      
      // Widen cover at top
      difference() {
	translate([-0.1,y+framew/2-covertopw/2-ytolerance,filmheight]) cube([length+0.2,covertopw+ytolerance*2,thickness-filmheight+0.02]);

	// Vertical support for film to drop neatly in place
	translate([filmholderx+framestart,y,filmheight]) {
	  hull() {
	    translate([xtolerance,-ytolerance/2-(thickness-filmheight),0]) triangle(filmholderl-framestart-xtolerance*2,thickness-filmheight,thickness-filmheight,11);
	    translate([xtolerance,0,0]) cube([filmholderl-framestart-xtolerance*2,ytolerance,thickness-filmheight]);
	  }
	  hull() {
	    translate([xtolerance,framew+ytolerance/2,0]) triangle(filmholderl-framestart-xtolerance*2,thickness-filmheight,thickness-filmheight,8);
	    translate([xtolerance,framew-ytolerance,0]) cube([filmholderl-framestart-xtolerance*2,ytolerance,thickness-filmheight]);
	  }
	}
      }
      
      // Frame separator cuts
      for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
	if (frameseparators) {
	  for (x=[filmholderx+framestart:framedistance+filmseparatorgap:filmholderx+filmholderl]) {
	    translate([x-xtolerance,y+framew/2-covertopw/2,filmheigthfromscansurface]) cube([frameseparator+xtolerance*2,covertopw,thickness-filmheigthfromscansurface]);
	    if (filmseparatorgap) translate([x+framedistance-frameseparator-xtolerance,y+framew/2-covertopw/2,filmheigthfromscansurface]) cube([frameseparator+xtolerance*2,covertopw,thickness-filmheigthfromscansurface]);
	  }
	}
      }
	
      // End clip cuts
      translate([-0.01,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipx+clipxtolerance+0.02,clipwidth+clipytolerance*2,filmheigthfromscansurface+0.02]);
      translate([clipx+clipxtolerance-0.01,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02]);
      translate([clipx+clipxtolerance-0.01,y+framew/2-clipwidth/2-clipytolerance,cliph/2-0.01]) triangle(clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02,2);

      translate([length-clipx-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipx+clipxtolerance+0.01,clipwidth+clipytolerance*2,filmheigthfromscansurface+0.02]);
      translate([length-clipx-clipdepth-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipdepth+0.01,clipwidth+clipytolerance*2,cliph/2+0.02]);
      translate([length-clipx-clipdepth-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,cliph/2-0.01]) triangle(clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02,0);

      // Side clip cut
      for (clipxx=[filmholderx+framestart:framedistance+filmseparatorgap:sideclipend]) {
	for (clipx=[clipxx+sideclipstart:sideclipdistance:clipxx+sideclipstart+sideclipdistance*(sideclipsperframe-1)+1]) {
	  if (clipx < sideclipend) {

	    // right clip hole cut
	    translate([clipx-sideclipxtolerance,y-sideclipy-sideclipspace-sideclipysink-0.01,filmheigthfromscansurface]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+sideclipysink+0.02,thickness-filmheigthfromscansurface+0.02]);
	    translate([clipx-sideclipxtolerance,y-sideclipy-sideclipspace-sideclipysink,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+0.01,thickness+0.02]);
	    translate([clipx-sideclipxtolerance,y-sideclipysink,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02]);
	    translate([clipx-sideclipxtolerance,y-sideclipysink,sidecliph/2-0.01]) triangle(sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02,8);
	
	    // left clip hole
	    translate([clipx+sideclipoffset-sideclipxtolerance,y+framew-0.01,filmheigthfromscansurface]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+sideclipysink+0.01,thickness-filmheigthfromscansurface+0.02]);
	    translate([clipx+sideclipoffset-sideclipxtolerance,y+framew+sideclipysink,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+0.01,thickness+0.02]);
	    translate([clipx+sideclipoffset-sideclipxtolerance,y+framew+sideclipysink-sideclipdepth,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02]);
	    translate([clipx+sideclipoffset-sideclipxtolerance,y+framew+sideclipysink-sideclipdepth,sidecliph/2-0.01]) triangle(sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02,11);
	  }
	}
      }

      // Film opening cut
      translate([filmholderx,y+frameimagey,-0.1]) cube([filmholderl,frameimagew,filmheigthfromscansurface+0.2]);
      hull() {
	translate([filmholderx,y+frameimagey,filmheigthfromscansurface-0.6]) cube([filmholderl,frameimagew,0.1]);
	translate([filmholderx-scannerfocusheight*0.7,y-narrowing+frameimagey,-0.01]) cube([filmholderl+narrowing*2,frameimagew+narrowing*2,0.01]);	
      }

      translate([filmholderx,y+frameimagey,-0.1]) cube([filmholderl,frameimagew,filmheigthfromscansurface+0.02]);
      translate([-0.01,y,filmheigthfromscansurface]) cube([length+0.02,framew,thickness-filmheigthfromscansurface+0.1]);
    }

    // Holes to save filament
    for (y=[lightenholeystart]) {
      for (x=[lightenholexstart:lightenholestep:lightenholexend]) {
	if (!idsquares || (x+lightenholex < idsquareframeoffset || x > idsquareframeoffset+idsquarew)) {
	  translate([x,y,-0.1]) cube([lightenholex,lightenholey,thickness+0.2]);
	}
      }
    }

    // Orientation help
    translate([guidex,guidey,guideh]) cube([guidel,guidew,thickness-guideh+0.1]);

    translate([textxposition,filmholdery/2-covertopwiden/2/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");

    translate([guidex+guidel/2,guidey+2+textsize/2,guideh-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text("Top", size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([guidex+guidel/2,guidey+guidew-2-textsize/2,guideh-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text(filmshrinktext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([adapteroffset+adapterl+1,lightenholeystart/2,thickness-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="right",font="Liberation Sans:style=Bold");
  }

  // Frame separators
  for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance+filmseparatorgap:filmholderx+filmholderl-framedistance]) {
	translate([x,y+filmwidenedy-cornerd/2,0]) cube([frameseparator,filmwidenedw+cornerd,filmheigthfromscansurface]);
	if (filmseparatorgap) translate([x+framedistance-frameseparator,y+filmwidenedy-cornerd/2,0]) cube([frameseparator,filmwidenedw+cornerd,filmheigthfromscansurface]);
      }

      if (filmseparatorgap) {
	for (x=[filmholderx+framestart:framedistance+filmseparatorgap:filmholderx+filmholderl-framedistance]) {
	  translate([x-filmseparatorgap/2-filmseparatorbetweenl/2,y+filmwidenedy-cornerd/2,0]) cube([filmseparatorbetweenl,filmwidenedw+cornerd,filmheigthfromscansurface]);
	  translate([x-filmseparatorgap/2-filmseparatorbetweenl/2,y+frameimagey+ytolerance,0]) roundedbox(filmseparatorbetweenl,frameimagew-ytolerance*2,thickness,cornerd);
	  
	  translate([x+framel+filmseparatorgap/2-filmseparatorbetweenl/2,y+filmwidenedy-cornerd/2,0]) cube([filmseparatorbetweenl,filmwidenedw+cornerd,filmheigthfromscansurface]);
	  translate([x+framel+filmseparatorgap/2-filmseparatorbetweenl/2,y+frameimagey+ytolerance,0]) roundedbox(filmseparatorbetweenl,frameimagew-ytolerance*2,thickness,cornerd);
	}
      }
    }
  }

  for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
    for (clipxx=[filmholderx+framestart:framedistance+filmseparatorgap:filmholderx+filmholderl]) {
      for (clipx=[clipxx+sideclipstart:sideclipdistance:clipxx+sideclipstart+sideclipdistance*(sideclipsperframe-1)+1]) {
	if (clipx < sideclipend) {
	  // Frame side supports
	  if (filmtable[film][FILMSUPPORTNOTCHES]) {
	    for (xx=[clipx,clipx+sideclipwidth-frameseparator]) {
	      hull() {
		translate([xx,y-cornerd/2,filmheigthfromscansurface-0.1]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
		translate([xx,y-cornerd/2,filmheigthfromscansurface/2]) cube([frameseparator,cornerd/2,filmheigthfromscansurface/2]);
	      }
	      hull() {
		translate([xx+sideclipoffset,y+filmw-framesidesupportwidening,filmheigthfromscansurface-0.1]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
		translate([xx+sideclipoffset,y+filmw,filmheigthfromscansurface/2]) cube([frameseparator,cornerd/2,min(coverh/2,framesidesupportwidening)]);
	      }
	    }
	  }
	}
      }
    }
  }
}

module scancover() {
  if (adhesion) {
    translate([0,filmholdery+ytolerance,thickness]) mirror([0,0,1]) tassu(-135,tassusizesmall);
    translate([length,filmholdery+ytolerance,thickness]) mirror([0,0,1]) tassu(-45,tassusizesmall);
    translate([length,filmholdery+ytolerance+framew-2*ytolerance,thickness]) mirror([0,0,1]) tassu(45,tassusizesmall);
    translate([0,filmholdery+ytolerance+framew-2*ytolerance,thickness]) mirror([0,0,1]) tassu(135,tassusizesmall);
  }
  
  // Frame separators
  for (y=[filmholdery:filmholderoffset:filmholdery]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance+filmseparatorgap:filmholderx+filmholderl-framedistance]) {
	translate([x,y+framew/2-covertopw/2+cornerd/2,coverh]) cube([frameseparator,covertopw-cornerd,thickness-coverh]);
	if (filmseparatorgap)
	  translate([x+framedistance-frameseparator,y+framew/2-covertopw/2+cornerd/2,coverh]) cube([frameseparator,covertopw-cornerd,thickness-coverh]);
      }
    }
  }
    
  difference() {
    union() {
      translate([0,filmholdery+ytolerance,coverh]) roundedbox(length,framew-2*ytolerance,thickness-coverh,cornerd);
      translate([0,filmholdery+framew/2-covertopw/2,coverh]) roundedbox(length,covertopw,thickness-coverh,cornerd);
    }

    // Brute force id holes to all covers
    
    for (i=[0:1:filmtable[film][FILMSTRIPS]-1]) translate([0,filmholderoffset*(i-filmtable[film][FILMSTRIPS]+1),0]) epsonidholes(filmtable[film][EPSONIDHOLETYPE]);
    
    // Vertical support for film to drop neatly in plade.
    translate([filmholderx+framestart,filmholdery,filmheight]) {
      hull() {
	translate([0,-ytolerance-(thickness-filmheight),0]) triangle(filmholderl-framestart,thickness-filmheight,thickness-filmheight+0.01,11);
	translate([0,0,0]) cube([filmholderl-framestart,ytolerance,thickness-filmheight+0.01]);
      }

      hull() {
	translate([0,framew+ytolerance,0]) triangle(filmholderl-framestart,thickness-filmheight,thickness-filmheight+0.01,8);
	translate([0,framew-ytolerance,0]) cube([filmholderl-framestart,ytolerance,thickness-filmheight+0.01]);
      }
    }
 
    if (filmtable[film][FILMSLITS]) {
      for (y=[filmholdery+framew/2-filmw/2,filmholdery+framew/2+filmw/2-filmsprocketfromedge]) {
	translate([filmholderx,y,thickness-scannerfocusheight-0.01]) cube([filmholderl,filmsprocketfromedge,scannerfocusheight+0.02]);
      }
    }
      
    for (y=[filmholdery:filmholderoffset:filmholdery]) {
      translate([filmholderx,y+frameimagey,filmheigthfromscansurface-0.01]) cube([filmholderl,frameimagew,scannerfocusheight+0.02]);
      hull() {
	translate([filmholderx,y+frameimagey,filmheigthfromscansurface+0.5+ztolerance-0.01]) cube([filmholderl,frameimagew,0.2]);
	translate([filmholderx-narrowing,y-narrowing+frameimagey,thickness+0.01]) cube([filmholderl+2*narrowing,frameimagew+2*narrowing,0.2]);
      }

      translate([textxposition,y+framew/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
      translate([length-textxposition,y+framew/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(filmshrinktext, size=textsize, valign="top",halign="center",font="Liberation Sans:style=Bold");
    }
  }

  translate([0,filmholdery+framew/2-clipwidth/2,0]) cube([clipx,clipwidth,filmheigthfromscansurface+cornerd+ztolerance]);
  translate([clipx,filmholdery+framew/2-clipwidth/2,0]) triangle(clipdepth,clipwidth,cliph/2,1);
  translate([clipx,filmholdery+framew/2-clipwidth/2,cliph/2]) triangle(clipdepth,clipwidth,cliph/2,2);

  translate([length-clipx,filmholdery+framew/2-clipwidth/2,0]) cube([clipx,clipwidth,filmheigthfromscansurface+cornerd+ztolerance]);
  translate([length-clipx-clipdepth,filmholdery+framew/2-clipwidth/2,0]) triangle(clipdepth,clipwidth,cliph/2,3);
  translate([length-clipx-clipdepth,filmholdery+framew/2-clipwidth/2,cliph/2]) triangle(clipdepth,clipwidth,cliph/2,0);

  for (y=[filmholdery:filmholderoffset:filmholdery]) {
    for (clipxx=[filmholderx+framestart:framedistance+filmseparatorgap:filmholderx+filmholderl]) {
      for (clipx=[clipxx+sideclipstart:sideclipdistance:clipxx+sideclipstart+sideclipdistance*(sideclipsperframe-1)+1]) {
	if (clipx < sideclipend) {
	  // Right clip
	  translate([clipx,y-sideclipy-sideclipysink-sideclipytolerance,coverh]) cube([sideclipwidth,sideclipy+sideclipysink+sideclipytolerance+(framew/2-filmw/2)+filmedgecover,thickness-coverh]);
	  translate([clipx,y-sideclipy-sideclipytolerance-sideclipysink,0]) cube([sideclipwidth,sideclipy,thickness]);
	  translate([clipx,y-sideclipytolerance-sideclipysink,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,8);
	  translate([clipx,y-sideclipytolerance-sideclipysink,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,10);

	  // Left clip
	  translate([clipx+sideclipoffset,y+filmw+(framew/2-filmw/2)-filmedgecover,coverh]) cube([sideclipwidth,sideclipy+sideclipysink+sideclipytolerance+(framew/2-filmw/2)+filmedgecover,thickness-coverh]);
	  translate([clipx+sideclipoffset,y+framew+sideclipysink+sideclipytolerance,0]) cube([sideclipwidth,sideclipy,thickness]);
	  translate([clipx+sideclipoffset,y+framew+sideclipysink-sideclipdepth+sideclipytolerance,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,11);
	  translate([clipx+sideclipoffset,y+framew+sideclipysink-sideclipdepth+sideclipytolerance,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,9);

	  // Frame side supports
	  if (filmtable[film][FILMSUPPORTNOTCHES]) {
	    for (xx=[clipx,clipx+sideclipwidth-frameseparator]) {
	      hull() {
		translate([xx,y-cornerd/2,coverh]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
		translate([xx,y-cornerd/2,coverh+min(coverh/2,framesidesupportwidening)]) cube([frameseparator,cornerd/2,min(coverh/2,framesidesupportwidening)]);
	      }
	      hull() {
		translate([xx+sideclipoffset,y+filmw-framesidesupportwidening,coverh]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
		translate([xx+sideclipoffset,y+filmw,coverh+min(coverh/2,framesidesupportwidening)]) cube([frameseparator,cornerd/2,min(coverh/2,framesidesupportwidening)]);
	      }
	    }
	  }
	}
      }
    }
  }
}

if (print==0) {
  difference() {
    union() {
      scanadapter();
      scancover();
      #filmstrip();
      if (filmstrips>1) {
	translate([0,filmholderoffset,0]) scancover();
	#color("red") translate([0,filmholderoffset,0]) filmstrip();
      }
      if (filmstrips>2) {
	//#translate([0,filmholderoffset*2,0]) color("red") filmstrip();
      }
    }

    if (testcuts) {
      translate([0,filmholdery+framew/2,-0.01]) cube([length,width,thickness+1]);
      //translate ([10,filmholdery+framew/2,-0.01]) cube([13,width-filmholdery-framew/2+1,thickness+1]);//filmholdery+framew/2+1
      //translate ([52.2,framew/2,-0.01]) cube([50,width-filmholdery-framew/2+1,thickness+1]);//filmholdery+framew/2+1
      //translate ([-0.01,-0.01,-0.01]) cube([12+20-0.02,filmholdery+framew+framegap+10,thickness+1]);
      //translate ([length-12-15,-0.01,-0.01]) cube([12+20+0.02,filmholdery+framew/2+1,thickness+1]);
      //translate ([length/2+38,filmholderoffset-5.5,-0.01]) cube([12+20+0.02,filmholdery+framew/2+1,thickness+1]);
      //translate ([length/2,filmholderoffset-8,-0.01]) cube([12+20+0.02,framew-1,thickness+1]);
    }
  }
 }

if (print==1) {
  scanadapter();
  //  translate([0,width+holdertotalw+filmholdery+1,+thickness]) rotate([0,180,180]) scancover();
 }

if (print==2) {
  for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
    translate([0,y,thickness]) rotate([0,180,180]) scancover();
  }
 }

if (print==3) {
  scanadapter();
  translate([0,width+filmholdery + holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
  if (filmstrips > 1) {
    translate([0,width+filmholdery + 2*holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
    if (filmstrips==4) {
    translate([0,width+filmholdery + 3*holdertotalw+1,+thickness]) rotate([0,180,180]) scancover();
    }
      translate([filmholdery-sideclipysink-sideclipy-sideclipspace-(adhesion?3.5:0),length,thickness]) rotate([0,180,90]) scancover();
  }
 }

if (print==4) {
  intersection() {
    scanadapter();
    translate([adapteroffset-17+adapterdistance,-adapterw-adapterattachy-1,0]) cube([adapterl+18,adapterw+adapterattachy+1+7+25,thickness+5]);
  }
 }

if (print==5) {
  if (antiwarp) {
    antiwarpwall(0,-adapterw,0,length,width+adapterw+filmholderoffset+sideclipy+sideclipysink,thickness+2,1,0.8);
  }
  scanadapter();
  //#translate([0,0,0]) filmstrip();

  translate([0,width+filmholdery + holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
 }

if (print==6) {
  intersection() {
    scanadapter();
    #scancover();
  }
 }
