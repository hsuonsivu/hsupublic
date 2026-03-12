// Copyright 2023,2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO small disk lock numerot puuttuvat
include <hsu.scad>

print=0;
debug=1;

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
slots=1;//2; // 1,2,3

// Maximum (3.5) disks, rest of space is allocated to 2.5 drives.  If
// 0, dynamically allocated, 3.5 first and rest of space for 2.5.
// This will not always fill the space optimally.
maxdisks=slots==3?4:slots==2.5?3:slots==2?0:slots==1?0:slots==0.5?1:-1;

// Full version, includes all material saving holes (very slow in openscad - render before rotating view)
full=1;

// Holes are through for better cooling.
throughholes=1;

// One of our cases has metal clips holding the drives. Replace outside locks with guides with clip
guideversion=0;

// Some cases expect fixed screws in either lower or upper settings. IN PROGRESS
// Could also be basis for screw-in version
sideslideversion=0;

// Sideslides have fixed screwheads IN PROGRESS
sideslidescrewheads=1;

// Sideslides have screw holes TBD
sideslidescrewholes=0;

if (guideversion && sideslideversion) {
  echo("ERROR guideversion and sideslideversion cannot be enabled together.");
 }

maxbridge=10;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

sidewall=2.4;

// Generic narrow cut for moving parts
cut=0.5;

// Screwheads for certain cases
headd=7;
headh=2.9;
headcornerd=1;

// Generic disk screwd is about 3.5mm
diskscrewholed=3.6;

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
//guidex=25;//24.45; // Not including clip
guidew=5;
guidecornerd=1;
guideclipwall=1.6;
guideclipattachx=guidex+guideclipwall;
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

versiontext="V3.2";
textsize=8;

length=short?170:198; // Shorter version 17.05, long version 19.8; Standard says 203.2 mm

outsideincornerd=6;
outsidecornerd=outsideincornerd+sidewall*2;
cornerd=2;
printable=7;
lockprintable=4;

// Distance between two slots when they are
// half-height. This is likely case specific and cannot
// be trusted, but is used to leave some gap between
// slots as some cases have extrusions. Outside screws
// cannot likely be used in that case anyway.
slotmingap=42.26-41.3;
slotmaxgap=44.2-41.3;

width=146.1; //146;
slimheight=31.5; // About 32mm
halfheight=41.3;
fullheight=82.6;
hpdoubleheight=95;
height=(slots==3)?min(slots*(halfheight+slotmaxgap),128):(slots==2?fullheight:(slots==1?halfheight:(slots==0.5?slimheight:(slots==2.5?hpdoubleheight:halfheight)))); // Standard say 41.3mm and 82.6mm

slotgapw=6;

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
diskyposition=width/2-diskw/2;
diskentrywidth=diskw; //105;

diskgaph=1.6; // This may need to be smaller..XXX
smalldiskbottomh=1.8;
diskgapw=8;

bottomthickness=2.2;
bottomthin=0.8;
roofthickness=2.2;
roofthin=0.8;
sidebottomthickness=bottomthickness;
sideroofthickness=roofthickness;
//diskscrewheight=bottomthickness+6.7;
diskscrewheight=6.7;
diskscrewxtable=[16.52,76.71,118.19];
diskscrewdiameter=3;
diskscrewbase=outscrewbase;
diskscrewspringlength=25;
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

//springpusherextra=5.3; // How much wider pusher needs to be to have strong enough sides at openings.
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

outlockl=outscrewxtable[1]+outscrewdiameter*2;//outscrewspringheight; //outscrew2position + outscrewspringheight;
disklockl=diskxposition+diskscrewxtable[2]+diskscrewdiameter*2;//keyh;
smalldisklockl=smalldiskxposition+smalldiskscrewxtable[1]+diskscrewdiameter*2;//keyh;
lockthickness=2.5;//5;
//springpushergap=0.6;//1;
lockgap=0.7;
springpusherbottom=1.5;
springpusherroof=1.5;

lockhandlel=10;
lockhandlethickness=7;

outlockcuth=outscrewspringheight+outlockextrah+lockgap;

outlockh=outscrewspringheight+outlockextrah;
outlockcutw=lockthickness+lockgap;
  
disklockh=keyh+disklockextrah;
smalldisklockh=keyh+smalldisklockextrah;
disklockcutw=lockthickness+lockgap;
disklockcuth=keyh+disklockextrah+ztolerance*2;
smalldisklockcuth=keyh+smalldisklockextrah;

smalldisklockhandleh=smalldiskslotstep*(smalldiskslots-1)+smalldiskscrewheight*2;

outlockcoverbottom=outscrewztable[0]-outlockcuth/2-lockwall;

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

sideslidelockh=6;
sideslidelockl=5;
sideslidelockcutl=21;
sideslidelockbodyl=5+sideslidelockcutl;
sideslideh=headd+1;
sideslideopeningh=ztolerance+sideslideh+ztolerance;
sideslidebasel=outscrewxtable[1]+outscrewdiameter*1.5;
sideslideopeningcutl=sideslidebasel+xtolerance*2;
sideslideopeningl=sideslidebasel;
sideslidew=1.6;

sideslidelockx=sideslidebasel+sideslidelockbodyl-3-sideslidelockl;

sideslideinl=sideslidebasel+sideslidelockbodyl;
sideslideiny=1;
sideslideinw=1.6;
sideslideinh=sideslideh+1.6;
sideslideincutl=sideslideinl+xtolerance*2; // Allow some bridge droop for printing
sideslideincutx=0;
sideslideincuty=sideslidew-ytolerance;
sideslideincutw=ytolerance+sideslideinw+ytolerance;
sideslideincuth=ztolerance+sideslideinh+ztolerance;

// Locking clip
sideslidelockcutx=sideslideopeningl+5;
sideslidelockcuty=-0.01;
sideslidelockcutw=sideslidew-ytolerance+sideslideincutw+0.01;
sideslidelockcut=sideslidew+ytolerance+0.01;
sideslidelockcuth=cut;
sideslidelockcutendh=sideslideincuth;

module tappi(screwdiameter,screwbase) {
  cylinder(h=screwbase,d=screwdiameter,$fn=30);
  translate([0,0,screwbase-0.01]) sphere(d=screwdiameter,$fn=30);
}

keycornerd=1.5;

module key(keylength,keywidth,keythickness,keyscrewdiameter,keyscrewdepth) {
  render() {
    translate([-keyanglel,-keywidth/2,0]) union () {
      hull() {
	translate([-keycornerd/2,0,0])  roundedbox(keylength+keyanglel+keycornerd,keywidth,keythickness,keycornerd,0);
	translate([keylength+keyanglel,keywidth/2,1]) roundedcylinder(keywidth,keythickness-1,keycornerd,0,60);
      }
      hull() {
	translate([keylength+keyanglel,keywidth/2,1]) roundedcylinder(keywidth,keythickness-1,keycornerd,0,60);
	translate([keylength+keyanglel+0.5+2,keywidth/2,keythickness-1]) roundedcylinder(keywidth-1,1,1,0,60);
	if (!simple) {
	  translate([keylength+keyanglel,keywidth/2,0.5]) resize([0,0,lockgap+sidewall-0.5]) sphere(d=keywidth,$fn=60);
	}
      }
      translate([keylength+keyanglel,keywidth/2,keythickness]) tappi(keyscrewdiameter,keyscrewdepth);
    }
  }
}

// This is centered on key
module keycut(keycutlength,keycutwidth,keycutthickness) {
  render() {
    translate([-0.01,-springgap-keycutwidth/2,-0.01]) cube([keycutlength+keycutextra+springgap*2+0.02,keycutwidth+springgap*2,keycutthickness+0.02]);
    translate([keycutlength+keycutextra+springgap*2,-springgap-keycutwidth/2,0]) intersection() {
      dia=keycutwidth+springgap;
      diaroot=sqrt(dia)*2;
      translate([0,0,-0.01]) rotate([0,0,45]) cube([diaroot,diaroot,keycutthickness+0.02]);
      translate([0,0,-0.01]) cube([keycutwidth/2+springgap*2,keycutwidth+0.02+springgap*2,keycutthickness+0.02]);
    }
  }
}

module holvicut(x,y,z) {
  hull() {
    topw=y>maxbridge?maxbridge:y;
    toph=y>maxbridge?(y-topw)/1.5:0;
    holvicornerd=4;
    
    translate([0,0,-holvicornerd/2-0.01]) roundedbox(x-toph,y,z+holvicornerd+0.02,holvicornerd,0);
    translate([x-toph,y/2-topw/2,-0.01]) cube([toph,topw,z+0.02]);
  }
}

//tappi();

//rotate([0,outscrewspringangle,0]) translate([-30,0,0]) key(20,6,2,3,0.3);
//translate([-30,0,-3]) keycut(20,6,2);

module sideslide() {
  intersection() {
    translate([0,0,-sideslideincuth/2-sideslidewall]) cube([length,width,sideslidewall+sideslideincuth+sideslidewall]);
    hull() {
      translate([-cornerd/2,sidewall-cornerd,-sideslideincuth/2-sideslidewall]) roundedbox(cornerd/2+sideslideincutl+xtolerance+sideslidewall,sideslideincuty+sideslideincutw+sideslidewall-sidewall+cornerd,sideslidewall+sideslideincuth+sideslidewall,cornerd,printable);
      translate([sideslideopeningl,sidewall-cornerd,-sideslideincuth/2-sideslidewall]) roundedbox(sideslideincutl+xtolerance+sideslidewall+sideslidewall*2-sideslideopeningl,sideslidewall,sideslidewall+sideslideincuth+sideslidewall,cornerd,printable);
    }
  }

  translate([0,-1.2,-sideslideopeningh/2-0.8]) cube([0.6,1.4,0.4]);
  translate([0,-1.2,-sideslideopeningh/2-0.8]) cube([0.6,0.4,sideslideopeningh+0.8*2]);
  translate([0,-1.2,sideslideopeningh/2+0.4]) cube([0.6,1.4,0.4]);
}

module sideslidecut() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) {
	  translate([sideslidelockcutx,sideslidelockcuty,-sideslidelockcutendh/2]) cube([sideslidelockcutl,sideslidelockcutw,cut]);
	}
      
      hull() {
	hull() {
	  translate([sideslidelockcutx+sideslidelockcutl-cut,sideslidelockcuty,-sideslidelockcutendh/2]) cube([cut*2,sideslidelockcutw,sideslidelockcutendh]);
	  translate([sideslidelockcutx+sideslidelockcutl-cut,sideslidelockcuty-cut,-sideslidelockcutendh/2]) cube([sideslidelockcutw+cut*2,cut,sideslidelockcutendh]);
	}
      }

      translate([-0.01,-0.01,-sideslideopeningh/2]) cube([sideslideopeningcutl+0.01,0.01+sideslidew,sideslideopeningh]);
      translate([-0.01,sideslideincuty,-sideslideincuth/2]) cube([sideslideinl+0.01,sideslideincutw,sideslideincuth]);
    }

    hull() {
      translate([sideslidelockx,0,-sideslidelockh/2+ztolerance]) cube([sideslidelockl,sideslideincuty,sideslidelockh-ztolerance*2]);
      translate([sideslidelockx+sideslidelockl-1,0,-sideslidelockh/2+ztolerance+sideslidewall]) cube([1,sideslideincuty+ytolerance+sideslidewall,sideslidelockh-ztolerance*2-sideslidewall*2]);
    }
  }
}

module sideslidebody() {
  difference() {
    union() {
      translate([0,sideslidewall,-sideslideinh/2]) roundedbox(sideslideinl,sideslidewall,sideslideinh,sideslidecornerd,sideslideprintable);
      translate([0,0,-sideslideh/2]) roundedbox(sideslidebasel,sideslidewall+sideslidecornerd,sideslideh,sideslidecornerd,sideslideprintable);
    }

    translate([sideslidelockx-xtolerance,sideslidewall-0.01,-sideslidelockh/2]) cube([xtolerance+sideslidelockl+xtolerance,0.01+sideslidewall+0.01,sideslidelockh]);

    translate([sideslidecornerd+1,sideslidewall*2-textdepth+0.01,0]) rotate([-90,0.0]) linear_extrude(height=textdepth) text(versiontext,size=min(textsize,sideslideinh)-sideslidecornerd-1,halign="left",valign="center");
  }
}

module sideslideheads() {
  sideslidebody();
  for (x=outscrewxtable) {
    translate([x,-headh,0]) rotate([-90,0,0]) roundedcylinder(headd,headh+headcornerd+0.01,headcornerd,0,90);
  }
}

module sideslidescrewholes() {
  difference() {
    union() {
      sideslidebody();
    }
    for (x=outscrewxtable) {
      translate([x,-0.01,0]) rotate([-90,0,0]) cylinder(d=diskscrewholed,sideslidewall+sideslidewall+0.02,$fn=90);
    }
  }
}

module guideclipshape(p) {
  translate([0,0,-guidecliph/2]) roundedbox(guideclipwall,guideclipwall,guidecliph,guideclipcornerd,p);
}

module guideclip() {
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
      
      translate([-0.01,guidesloty-0.01,-guidecliph/2-ztolerance]) cube([guidex+guideclipwall,guideslotoutw+0.02,ztolerance+guidecliph+ztolerance]);
      translate([-0.01,guidesloty+guideclipwall,-guidecliph/2-ztolerance]) cube([guideclipattachx+guideclipwall+guideclipattachl,ytolerance+guideclipwall+ytolerance,ztolerance+guidecliph+ztolerance]);
    }
    hull() {
      translate([guidecliplockx+xtolerance,guidesloty,-guidecliplockh/2+ztolerance]) cube([guidecliplockl-xtolerance*2,guideclipwall,guidecliplockh-ztolerance*2]);
      translate([guidecliplockx+xtolerance+guidecliplockl-xtolerance*2-1,guidesloty,-guidecliplockh/2+ztolerance+guideclipwall]) cube([1,guideclipwall+ytolerance+guideclipwall,guidecliplockh-ztolerance*2-guideclipwall*2]);
    }
  }
}

module smalldisklockcover(h,cuth,n) {
  translate([0,0,-cornerd/2]) roundedbox(smalldisklockl,lockwall+lockthickness+lockgap+0.01+lockwall,smalldiskslotstep*(n-1)+smalldiskscrewheight*2+diskgaph+cornerd/2,cornerd,printable);
}


module smalldisklockcut(h,cuth,n) {
  translate([-0.01,lockwall,0]) cube([smalldisklockl+0.02,lockthickness+lockgap,smalldisklockhandleh]);

  hull() {
    translate([-0.01,-0.01,0]) cube([lockhandlel+0.01,lockwall+0.02,smalldisklockhandleh]);
    translate([lockhandlel,-0.01,smalldisklockhandleh/2-maxbridge/2]) cube([(smalldisklockhandleh/2-maxbridge/2)*1.3,lockwall+0.02,maxbridge]);
  }
}

module lockcover(h,cuth) {
  translate([0,0,-cuth/2-lockwall]) roundedbox(disklockl,lockwall+lockthickness+lockgap+0.01+lockwall,cuth+lockwall*2,cornerd,printable);
}

module lockcut(h,cuth) {
  translate([-0.01,lockwall,-cuth/2]) cube([disklockl+0.02,lockthickness+lockgap,cuth]);
	
  hull() {
    translate([lockhandlel,lockthickness+lockgap-disklockcutw-0.01,-cuth/2]) triangle(disklockcuth+xtolerance,lockwall+0.02,disklockcuth,1);
    translate([-0.01,lockthickness+lockgap-disklockcutw-0.01,-cuth/2]) cube([1,lockwall+0.02,disklockcuth]);
  }

  hull() {
    h=cuth/2-0.01;
    //translate([-0.01,sidewall+sidecutwidth/2,h]) cube([0.01+lockhandlel-2,sidecutwidth/2,lockwall+0.02]);
    translate([-0.01,0,h]) cube([0.01+lockhandlel-2,lockwall+lockthickness+lockgap,lockwall+0.02]);
    translate([sidecutwidth/2+lockhandlel-1,0,h]) cube([0.01,0.01,lockwall+0.02]);
  }
}

module basebody() {
  intersection() {
    union() {
      for (i=[0:1:floor(slots)-1]) {
	hh=i*(halfheight+slotmaxgap);
	translate([-outsidecornerd/2,0,hh]) roundedbox(length+outsidecornerd/2+cornerd,width,halfheight-(slotmaxgap-slotmingap)*2*i,outsidecornerd,printable);
      }
      translate([-outsidecornerd/2,slots>1?slotgapw:0,0]) roundedbox(length+outsidecornerd/2+cornerd,width-(slots>1?slotgapw:0),height,outsidecornerd,printable);
    }
    cube([length,width,height]);
  }
}

module halfholder() {
  disky = width/2-diskw/2-sidewall;
  smally = width/2-smalldiskw/2-sidewall;
  
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
	    translate([-0.01-outsideincornerd/2,slotgapw+sidewall,smalldiskheight]) roundedbox(length+outsideincornerd+0.02,smalldisksidecutwidth-slotgapw,smalldiskspaceh,outsideincornerd,printable);
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
	    for (z=[0:diskslotstep:disksh]) {
	      union() {
		for (i=[0:1:slots<1?0:(slots-1)]) {
		  hh=bottomthickness+i*(halfheight+slotmaxgap);
		  translate([-outsidecornerd/2,sidewall,hh]) roundedbox(length+outsidecornerd+cornerd,sidecutwidth,halfheight-(slotmaxgap-slotmingap)*2*i-bottomthickness-roofthickness,outsideincornerd,printable);
		}
		translate([-outsidecornerd/2,slotgapw+sidewall,bottomthickness]) roundedbox(length+outsidecornerd+cornerd,sidecutwidth-slotgapw,height-bottomthickness-roofthickness,outsideincornerd,printable);
	      }
	    }
	  } else {
	    translate([-0.01-outsideincornerd,sidewall,sidebottomthickness]) roundedbox(length+outsideincornerd*2+0.02,sidecutwidth,sidecutheight,outsideincornerd,0);
	  }
	  translate([-0.01,sidewall+sidecutwidth-outsideincornerd,sidebottomthickness]) cube([length+outsideincornerd*2+0.02,outsideincornerd,outsideincornerd/2]);
	  if (smalldiskslots>0) translate([-0.01,sidewall+smalldisksidecutwidth-outsideincornerd,smalldiskheight]) cube([length+outsideincornerd*2+0.02,outsideincornerd,outsideincornerd/2]);

	  // Lightenin holes, top&bottom
	  if (full) {
	    zstart=throughholes?-0.01:bottomthin;
	    zend=smalldiskslots>0?bottomthickness+disksh-diskh:throughholes?height+0.02:height-bottomthickness-roofthickness;
	    
	    for(x=[0:1:airholesx-1]) {
	      for(y=[0:1:floor((airholesy+1)/2)]) {
		translate([airholexstart+x*(airholediameterx+airholedistancex),airholeystart+y*(airholediametery+airholedistancey),zstart]) holvicut(airholediameterx, airholediametery, zend);
	      }
	    }

	    // Lightening holes, top if 2.5 inch slots exist
	    if (smalldiskslots>0) {
	      for(x=[0:1:smalldiskairholesx-1]) {
		for(y=[0:1:floor((smalldiskairholesy+1)/2)]) {
		  translate([smalldiskairholexstart+x*(smalldiskairholediameterx+smalldiskairholedistancex),smalldiskairholeystart+y*(smalldiskairholediametery+smalldiskairholedistancey),(diskslots>0?smalldiskbottomheight:0)-0.01]) holvicut(smalldiskairholediameterx, smalldiskairholediametery, height-(diskslots>0?smalldiskbottomheight:0)+0.02);
		}
	      }
	    }

	    // Lightenin holes, sides
	    if (smalldiskslots>0) for(x=[0:1:sidetopairholesx-1]) { //slots==1 || slots==0.5
		translate([sidetopairholexstart+x*(sidetopairholediameterx+sidetopairholedistancex),sidetopairholeystart,(diskslots>0?height-sideroofthickness:0)-0.01]) holvicut(sidetopairholediameterx,sidetopairholediametery,diskslots>0?sideroofthickness+1:height+0.02);
	      }

	    if (slots==1 && diskslots>0) for(x=[0:1:sideairholesx-1]) {
		translate([sideairholexstart+x*(sideairholediameterx+sideairholedistancex),sidecutwidth+sidewall*2,sideairholezstart]) rotate([90,0,0]) holvicut(sideairholediameterx,sideairholediametery,sidewall+1);
	      }
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
	  for (z=outscrewztable) translate([0,0,z]) sideslide();
	}
	
	if (guideversion==1) {
	  translate([0,0.01,guideheight]) guide();
	}

	if (!simple) {
	  if (!guideversion && !sideslideversion) {
	    translate([0,sidewall/2,outlockcoverbottom]) roundedbox(outlockl,sidewall/2+lockthickness+lockgap+0.01+lockwall,outscrewztable[1]+outlockcuth/2+lockwall-outlockcoverbottom,cornerd,printable);
	  }

	  // lock pin cover for disk
	  if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	    translate([0,sidewall+sidecutwidth-lockthickness-lockgap-lockwall,z+bottomthickness+diskscrewheight]) lockcover(disklockh,disklockcuth);
	  }

	  if (smalldiskslots>0) {
	    translate([0,width/2-smalldiskw/2-sidewall-lockthickness-lockgap-lockwall,smalldiskheight]) smalldisklockcover(smalldisklockh,smalldisklockcuth,smalldiskslots);
	    if (0) for (i=[0:1:smalldiskslots-1]) {
		translate([0,width/2-smalldiskw/2-sidewall-lockthickness-lockgap-lockwall,smalldiskheight+smalldiskscrewheight+i*smalldiskslotstep]) lockcover(smalldisklockh,smalldisklockcuth);
	      }
	  }
	}
      }

      if (sideslideversion) {
	for (z=outscrewztable) translate([0,0,z]) sideslidecut();
      }
      
      if (!simple) {
	if (!guideversion && !sideslideversion) for (z=outscrewztable) {
	    // Side lock space
	    translate([-0.01,sidewall,z-outlockcuth/2]) cube([outlockl+0.02,lockthickness+lockgap,outlockcuth]);
	    hull() {
	      translate([lockhandlel+lockthickness+lockwall,sidewall+lockthickness+lockgap-0.01,z-outlockcuth/2]) triangle(outlockcuth+xtolerance,lockwall+0.02,outlockcuth,1);
	      translate([-0.01,sidewall+outlockcutw-0.01,z-outlockcuth/2]) cube([1,lockwall+0.02,outlockcuth]);
	    }
	  }
	
	// Disk lock spaces
	if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	  translate([0,sidewall+sidecutwidth-lockthickness-lockgap-lockwall,z+bottomthickness+diskscrewheight]) lockcut(disklockh,disklockcuth);
	}

	// Small disk lock spaces
	if (smalldiskslots>0) for (i=[0:1:smalldiskslots-1]) {
	    translate([0,width/2-smalldiskw/2-sidewall-lockthickness-lockgap-lockwall,smalldiskheight]) smalldisklockcut(smalldisklockh,smalldisklockcuth,smalldiskslots);
	  }
	
	if (sideslideversion) {
	  for (z=outscrewztable) {
	    hull() {
	      translate([-0.01,sidewall,z-sideslideincuth/2]) cube([0.01+lockhandlel-2,sidecutwidth/2,sideslideincuth]);
	      if (sideslideincuth>maxbridge) translate([(sideslideincuth-maxbridge)/2-0.01,sidewall,z-maxbridge/2]) cube([0.01+lockhandlel-2,sidecutwidth/2,maxbridge]);
	    }
	  }
	} else {
	  hull() {
	    cutheight=min(outscrewztable[0],bottomthickness+diskscrewheight-roofthickness);
	    h=min(height,halfheight)-sidebottomthickness-cutheight-roofthickness-outsideincornerd/2;
	    translate([-0.01,sidewall,sidebottomthickness+cutheight]) cube([0.01+lockhandlel-2,sidecutwidth/2,h]);
	    translate([sidecutwidth/2+lockhandlel-1,sidewall+sidecutwidth/2,sidebottomthickness+cutheight]) cube([1,0.01,h]);
	  }
	}
      }
      
      translate([sidewall+diskxposition,width-(width/2-diskw/2-2*sidewall)-sidewall,sidebottomthickness]) cube([disklength-2*sidewall,width/2-diskw/2-2*sidewall,height-sidebottomthickness-sideroofthickness+20]);

      if (!guideversion && !sideslideversion) for (z=outscrewztable) {
	  for (x=outscrewxtable) {
	    translate([x-outscrewspringlength,0,z]) rotate([270,0,0]) keycut(outscrewspringlength,outscrewspringheight,sidewall);
	  }
	}
      
      if (guideversion) translate([0,0,guideheight]) guidecut();

      if (sideslideversion) for (z=outscrewztable) {
	  translate([0,0,z]) sideslidecut();
	}

      if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	for (x=diskscrewxtable) {
	  translate([diskxposition+x-diskscrewspringlength,disky,z+bottomthickness+diskscrewheight]) rotate([270,0,0]) keycut(diskscrewspringlength,keyh,sidewall);
	}
      }

      if (smalldiskslots>0) for (z=[0:smalldiskslotstep:smalldisksh]) {
	  for (x=smalldiskscrewxtable) {
	    translate([smalldiskxposition+x-diskscrewspringlength,smally,z+smalldiskheight+smalldiskscrewheight]) rotate([270,0,0]) keycut(diskscrewspringlength,keyh,sidewall);
	  }
	}

      translate([-0.01,width/2+0.01,-0.01]) cube([length+0.02,width,height+0.02]);
    }

    // Keys for outside if applicable
    if (!guideversion && !sideslideversion) {
      for (z=outscrewztable) {
	for (x=outscrewxtable) {
	  translate([x-outscrewspringlength,sidewall,z]) rotate([90,0,outscrewspringangle]) key(outscrewspringlength,outscrewspringheight,sidewall,outscrewdiameter,outscrewbase);
	}
      }
    }

    // Keys for disks
    if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
      for (x=diskscrewxtable) {
	translate([diskxposition+x-diskscrewspringlength,sidecutwidth+sidewall,z+bottomthickness+diskscrewheight]) rotate([270,0,-diskscrewspringangle]) key(diskscrewspringlength,keyh,sidewall,diskscrewdiameter,diskscrewbase);
      }
    }

    // Keys for small disks
    if (smalldiskslots>0) for (z=[0:smalldiskslotstep:smalldisksh]) {
	for (x=smalldiskscrewxtable) {
	  translate([smalldiskxposition+x-diskscrewspringlength,smally,z+smalldiskheight+smalldiskscrewheight]) rotate([270,0,-diskscrewspringangle]) key(diskscrewspringlength,keyh,sidewall,diskscrewdiameter,diskscrewbase);
	}
      }
  }
}

module holder() {
  difference() {
    union() {
      halfholder();
      translate([0,width,0]) mirror([0,1,0]) halfholder();
    }
    translate([2,width/2,bottomthickness-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="center");
    translate([2,width/2,height-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="center");
    slotnumbersize=lockthickness+lockwall+1;

    if (!simple) {
      w=lockthickness+lockgap+0.01+lockwall;
      if (!guideversion && !sideslideversion) {
	translate([1,width-sidewall-w/2,outscrewztable[0]-outlockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("1",size=slotnumbersize,halign="center");
      }

      if (diskslots>0) for (z=[0:diskslotstep:disksh]) {
	translate([1,width-sidewall-sidecutwidth+w/2,z+bottomthickness+diskscrewheight-disklockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("2",size=slotnumbersize,halign="center");
	translate([1,sidewall+sidecutwidth-w/2,z+bottomthickness+diskscrewheight-disklockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("3",size=slotnumbersize,halign="center");
      }
	
      if (smalldiskslots>0) {
	translate([1,width-sidewall-smalldisksidecutwidth+w/2,smalldiskheight-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("5",size=slotnumbersize,halign="center");
	translate([1,sidewall+smalldisksidecutwidth-w/2,smalldiskheight-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("6",size=slotnumbersize,halign="center");
      }
	
      if (!guideversion && !sideslideversion) {
	translate([1,sidewall+w/2,outscrewztable[0]-outlockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("4",size=slotnumbersize,halign="center");
      }
    }
  }
}

locktable=[[0,1],
	   [1,0],
	   [0,0],
	   [1,1],
	   [1,0],
	   [0,0]
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

    translate([lockhandlethickness+lockhandlel+cornerd,lockthickness-textdepth+0.01,0]) rotate([90,rotate?0:180,180]) linear_extrude(height=textdepth) text(versiontext,size=h-4,halign=rotate?"right":"left",valign="center");
    if (out) {
      for (x=outscrewxtable) {
	if (x<outlockl-10) lockspringcut(x,outscrewdiameter,outscrewspringlength,outscrewspringheight);
      }
    } else {
      for (x=diskscrewxtable) {
	if (x<disklockl-diskxposition-10) lockspringcut(diskxposition+x,diskscrewdiameter,diskscrewspringlength,keyh);
      }
    }
    translate([lockhandlel/2,-0.1,-h/2-1]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([lockhandlel/2,-0.1,-h/2+1+h]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([textdepth-0.01,lockhandlethickness/2,0]) rotate([90,rotate?0:180,-90]) linear_extrude(height=textdepth) resize([lockhandlethickness-3,0,0]) text(t,size=h-3,halign="center",valign="center");
  }
}

module smalldisklockbody(i) {
  rotate=locktable[i][0];
  out=locktable[i][1];
  h=smalldisklockh;
  hh=min(smalldisklockh,smalldisklockhandleh-lockgap);

  hull() {
    translate([lockhandlel-cornerd,0,-h/2+h-(rotate?h:smalldisklockhandleh-lockgap)]) roundedbox(smalldisklockl-lockhandlel+cornerd,lockthickness,smalldisklockhandleh-lockgap,cornerd,lockprintable);
    translate([lockhandlel-cornerd,lockthickness-1,-h/2+h-(rotate?h:smalldisklockhandleh-lockgap)+0.5]) roundedbox(smalldisklockl-lockhandlel+cornerd+lockthickness,1,smalldisklockhandleh-lockgap-1,1,lockprintable);
  }

  translate([0,0,-h/2]) roundedbox(lockhandlel,lockhandlethickness,h,cornerd,lockprintable);
  translate([0,0,rotate?0:hh-cornerd/2]) hull() {
    translate([lockhandlel-0.01,lockthickness-0.01,-h/2+(rotate?cornerd/2:-h+cornerd)]) cube([0.8+0.01,lockwall+0.01,hh-cornerd]);
    translate([lockhandlel+0.8,lockthickness-0.01,-h/2+(rotate?cornerd/2:-h+cornerd)]) triangle((hh-cornerd)*1.3,lockwall+0.01,hh-cornerd,rotate==0?2:1);
  }
}

module smalldisklock(i) {
  t=str(i+1);
  rotate=locktable[i][0];
  out=locktable[i][1];
  h=smalldisklockh;
  
  difference() {
    union() {
      smalldisklockbody(i);
    }

    translate([lockhandlethickness+lockhandlel*1.3+cornerd,lockthickness-textdepth+0.01,rotate?-2.2:2.2]) rotate([90,rotate?0:180,180]) linear_extrude(height=textdepth) text(versiontext,size=h-5.5,halign=rotate?"right":"left",valign="center");
    if (smalldiskslots>1) for (z=[0:smalldiskslotstep:smalldisksh]) {
      for (x=smalldiskscrewxtable) {
	if (x<smalldisklockl-smalldiskxposition-10) translate([0,0,(rotate?smalldisklockhandleh-lockgap-z-h+2.1:-z+keyh/2+lockgap/2)]) lockspringcut(smalldiskxposition+x,smalldiskscrewdiameter,diskscrewspringlength,keyh+1);
      }
    }
    
    translate([lockhandlel/2,-0.1,-h/2-1]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([lockhandlel/2,-0.1,-h/2+1+h]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([textdepth-0.01,lockhandlethickness/2,0]) rotate([90,rotate?0:180,-90]) linear_extrude(height=textdepth) resize([lockhandlethickness-3,0,0]) text(t,size=h-3,halign="center",valign="center");
  }
}

// springpushersticks
module springpushersticks() {
  if (!simple) {
    //out
    for (i=((guideversion || sideslideversion)?[1:1:2]:[0:1:3])) {
      translate([0,0,height+outlockh/2+1+((guideversion || sideslideversion)?i-1:i)*(max(outlockh,disklockh)+1)]) lock(i);
    }
  }
}

if (print==0) {
  intersection() {
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight]);
    //if (debug) translate([-100,-100,-100]) cube([1000,1000,105+outscrewztable[0]]);
    if (debug) translate([-100,33,-100]) cube([1000,1000,1000]);
    difference() {
      union() {
	holder();
	if (!guideversion && !sideslideversion) {
	  translate([0,sidewall+lockgap,outscrewztable[0]]) rotate([0,0,0]) lock(3);
	}
	
	if (diskslots>0) translate([0,sidewall+sidecutwidth-lockgap,bottomthickness+diskscrewheight]) rotate([180,0,0]) lock(2);
	
	#	if (smalldiskslots>0) {
	  translate([0,smalldiskyposition-sidewall-lockgap,smalldiskheight+smalldisklockh/2+ztolerance]) rotate([180,0,0]) smalldisklock(5);
	  translate([0,width-(smalldiskyposition-sidewall-lockgap),smalldiskheight+smalldisklockh/2+ztolerance]) rotate([0,0,0]) smalldisklock(4);
	}
	
	if (guideversion) {
	  translate([0,0,guideheight]) guideclip();
	}
	if (sideslideversion && sideslidescrewheads) translate([0,0,outscrewztable[0]]) sideslideheads();
	if (sideslideversion && sideslidescrewholes) translate([0,0,outscrewztable[0]]) sideslidescrewholes();
	//translate([0,-10,0]) lock(3);
      }

      for (i=[0:1:diskslots-1]) {
	translate([diskxposition,width/2-diskw/2,bottomthickness+i*diskslotstep]) cube([disklength,diskw,diskh]);
      }

      if (smalldiskslots>0) for (i=[0:1:smalldiskslots-1]) {
	translate([smalldiskxposition,width/2-smalldiskw/2,smalldiskheight+i*smalldiskslotstep]) cube([smalldiskl,smalldiskw,smalldiskh]);
      }
    }
  }
 }

if (print==1 || print==3) {
  rotate([0,0,90]) {
    translate([width,0,0]) rotate([0,-90,90]) holder();
  }
 }

if (!simple && (print==2 || print==3)) {
  if (!simple) {
    // Side parts
    l1=height+0.5;
    l2=l1+(guideversion?0:sideslideversion?(sideslideinh+0.5)*2:(outlockh+0.5)*2);
    translate([l1,0,0]) if (!guideversion && !sideslideversion) {
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
	    }
	  }
	}
      }
    }

    // Disk locks
    l3=l2+diskslots*(disklockh+0.5)*2;
    translate([l2,0,0]) if (diskslots>0) {
      translate([disklockh/2,0,0]) {
	for (ds=[0:1:diskslots-1]) {
	  translate([ds*(disklockh*2+1),0,0]) {
	    for (i=[1,2]) {
	      translate([(i-1)*(disklockh+0.5),0,0]) rotate([90,0,90]) {
		lock(i);
	      }
	    }
	  }
	}
      }
    }
    
    if (smalldiskslots>0) {
      translate([l3,0,0]) if (smalldiskslots>0) {
	translate([smalldisklockh/2,smalldisklockl,0]) {
	  translate([smalldisklockhandleh-smalldisklockh,0,0]) rotate([90,0,-90]) smalldisklock(4);
	  translate([smalldisklockhandleh+0.5,0,0]) rotate([90,0,-90]) smalldisklock(5);
	}
      }
    }
  }
 }

if (guideversion) {
  if (print==4 || print==1 || print==3) {
    translate([guidew+sidewall-guidesloty+guideslotoutw+0.5,width/2-(guideclipattachl+guideclipattachx+guideclipl)/2,guidecliph/2]) rotate([0,0,90]) {
      translate([10,2.5,0]) guideclip();
      translate([10,2.5+guidew+0.5,0]) guideclip();
    }
  }
 }

