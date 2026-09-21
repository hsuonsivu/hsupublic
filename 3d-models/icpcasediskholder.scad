// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO: add lightening holes to reduce filament consumption.

include <hsu.scad>
include <hsubolt.scad>

print=10;
debug=0;

lighteningholes=1;
cornerd=1.6;
wall=2;
abs=1;

maxbridge=10;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

fantype=7;

fansizetable=[[40,32,10],     //0
	      [50,40,10],     //1
	      [60,50,15],     //2
	      [70,60,15],     //3
	      [80,71.5,25],   //4
	      [92,82.5,25],   //5
	      [120,105,25.4],   //6
	      [60,50,11.5],	//7 measured from one of my fans
	      [70,60,25.5],     //8 measured from one of my fans
	      [140,124.5,28], //9
	      [200,154,30],   //10
	      [220,170,30]    //11
	      ];

fanl=fantype!=-1?fansizetable[fantype][0]:0;
fanw=fanl;
fand=min(fanl,fanw)-wall;
fanscrewl=(fantype!=-1)?fansizetable[fantype][1]:0;
fanscreww=fanscrewl;
fanh=fantype!=-1?fansizetable[fantype][2]:0;
fanzcornerd=fanw-fanscreww;

if (fantype!=-1) echo("Fan type ",fantype," size ",fanw," screws ",fanscrewl," thickness ",fanl);
fanscrewd=3.9;
fantowerh=6;
fanholderclipl=fanw/2;
fanholderclipd=wall+1.1;
fanholderl=xtolerance+fanh+xtolerance+fanholderclipd;
fanholderw=wall+ytolerance+fanw+ytolerance+wall;
fanholderh=wall+ztolerance+fanw+ztolerance+wall;

versiontext="V1.3";
textdepth=0.8;
textsize=8;
brandtext="Diskholder";
longtext=str(brandtext," ",versiontext);

// Bring case slightly forward from original measurements to allow
// floppy screwholes.
caseshift=5;

disk35=diskdimensions("3.5");
diskl=disk35[1];
diskw=disk35[2];
diskh=disk35[3];
diskspaceh=ztolerance+diskh+ztolerance;

diskscrewxtable=disk35[4];
diskscrewztable=disk35[5];
diskscrewd=disk35[8];

disk25=diskdimensions("2.5H");
disk25l=disk25[1];
disk25w=disk25[2];
disk25h=disk25[3];
disk25spaceh=ztolerance+disk25h+ztolerance;

floppy=diskdimensions("3.5FLOPPY");
floppyl=floppy[1];
floppyw=floppy[2];
floppyh=floppy[3];
floppyspaceh=ztolerance+floppyh+ztolerance;
floppyx=-25+caseshift;
floppyscrewxtable=floppy[4];
floppyscrewheight=floppy[5][0];
floppyscrewd=floppy[8];

basew=175;
baseleftl=120;
bottomscreww=162.6-(abs?0:0.4); //164;
bottomleftscrewxtable=[35+caseshift-1,95+caseshift-1.1]; // plusminus 4mm;
bottomrightscrewxtable=[35+caseshift-1,115+caseshift-1];
bottomrightscrewy=-bottomscreww/2;
  
tassuh=4.82;
tassul=15;
tassuw=12;
tassuleftxtable=[bottomleftscrewxtable[0]-tassul-10,bottomleftscrewxtable[1]-tassul-10];
tassumidxtable=[bottomleftscrewxtable[0]-tassul-10,bottomleftscrewxtable[1]-tassul];
tassurightxtable=[bottomrightscrewxtable[0]-tassul-15,bottomrightscrewxtable[1]+10];
leftl=wall+xtolerance+disk25l;
lefth=100;//120?
maxh=150;
rightoverlap=28;
originalw=149;
disksw=wall+ytolerance+disk35[2]+ytolerance+wall;
baserighty=-originalw/2-rightoverlap;
disky=baserighty+disksw/2-diskw/2;
diskx=wall+xtolerance;

disk25y=baserighty+disksw+xtolerance;
disk25x=wall+xtolerance;
lefty=disk25y+disk25w+xtolerance+wall;

diskstopperw=wall+8;

floppyy=originalw/2+5.37+48+0.5-floppyw;
floppyheight=lefth+ztolerance;
floppytopheight=lefth-wall+floppyspaceh*2+wall;

bottomleftscrewd=5;//4.3;
bottomrightscrewd=5; // Slide in
bottomrightscrewbased=9;
bottomrightscrewopeningx=bottomrightscrewd/2+bottomrightscrewbased/2;
bottomscrewmoveh=8-wall;//+2;
bottomscrewbaseh=2; //3.5;
bottomscrewbased=9;
bottomscrewxflex=4;

disksheight=wall+bottomscrewmoveh+bottomscrewbaseh+0.5;
disks25height=wall+5+0.5;//disksheight;

diskhstep=ztolerance+diskh+ztolerance+wall;
disk25hstep=ztolerance+disk25h+ztolerance+wall;

disks=3;
disks25=6;

baserightl=wall+xtolerance+diskl; //140;

disklockclips=1;

disklockl=30;
disklockw=3;
disklockh=diskh-2;
disk25lockh=disk25h-1;
disklockcut=0.50;

disksleftlockl=baserightl+xtolerance*2;

diskcliph=disk25h-1;
diskclipl=40;
diskcliplockw=9;
diskclipw=wall;
diskcliplockl=5;
diskcliplockh=diskcliph-4;
diskcliplockbarh=diskcliplockh+2;
diskcliplockx=10+2.5;
diskclipcoverl=wall+xtolerance+diskcliplockx+diskcliplockl+4;
diskclipcoverx=-wall-xtolerance;
diskcliphandlel=2;

diskcliplockcutx=diskclipcoverx+2;
diskcliplockcutl=diskcliplockx+diskcliplockl-diskcliplockcutx;

diskclipcut=0.6;

clipwall=1.6;

diskclipcoverh=wall+ztolerance+diskcliph+ztolerance+wall;
diskclipcoverfullw=wall+ytolerance+diskclipw+ytolerance+clipwall;

diskclipx=diskx+diskl-diskclipl;
disk25clipx=disk25x+disk25l-diskclipl;

midsidey=baserighty+disksw-wall;

covercliph=disk25h-1;
coverclipl=22;
covercliplockw=9;
coverclipw=wall;
covercliplockl=5;
covercliplockh=covercliph-4;
covercliplockbarh=covercliplockh+2;
covercliplockx=10+3;
coverclipcoverl=wall+xtolerance+13+covercliplockl+4;
coverclipcoverx=-wall-xtolerance;
covercliphandlel=9;
covercliphandlew=4;
covercliphandleh=4;

covercliplockcutx=coverclipcoverx+2;
covercliplockcutl=covercliplockx+covercliplockl;//-covercliplockcutx;

coverclipcut=0.6;

coverclipcoverh=wall+ztolerance+covercliph+ztolerance+wall;
coverclipcoverfullw=wall+ytolerance+coverclipw+ytolerance+clipwall;

coverclipbridge=maxbridge+2;

fanframel=13;
fanframew=149; //148.29;
fanframeh=86;
fanframeflange=2;//1.5;
fanframeheight=0;
fanframelargecornerd=20;

fany=0;
fanx=-fanh+5;
fansupportw=wall+ytolerance+fanw+ytolerance+wall;
fansupportl=wall+1.5;
fansupporth=fansupportw;
fanframebasex=min(fanx-fansupportl,-(coverclipl-fanframel+fansupportl));
fanframeclipy=-fanframew/2+maxbridge+coverclipcoverh/2+fanframelargecornerd/2;

module tassu() {
  difference() {
    union() {
      roundedboxxyz(tassul,tassuw,tassuh+cornerd,cornerd,cornerd,7,90);
      for (y=[0,tassuw-wall]) {
	hull() {
	  translate([-tassuh,y,tassuh]) roundedbox(wall+cornerd+tassuh,wall,wall,cornerd,7);
	  translate([0,y,0]) roundedbox(wall+cornerd,wall,wall,cornerd,7);
	}
      }
    }
    translate([wall,wall,-cornerd/2]) roundedbox(tassul-wall*2,tassuw-wall*2,tassuh+cornerd/2,0);
  }
}

module printablehole(d,h) {
  hull() {
    cylinder(d=d,h=h,$fn=90);
    translate([0,-d/4,0]) cube([d/2,d/2,h]);
  }
}

module lockcut() {
  cube([disklockl+0.01,disklockw+0.02,disklockcut]);
}

module diskclip() {
  difference() {
    union() {
      translate([0,0,-diskcliph/2]) roundedbox(diskclipl+xtolerance+wall,wall,diskcliph,cornerd,1);
      translate([diskclipl+xtolerance,-diskcliplockw+wall,-diskcliph/2]) roundedbox(wall,diskcliplockw,diskcliph,cornerd,1);
      hull() {
	translate([diskclipl,0,-diskcliph/2]) roundedbox(xtolerance+wall,wall,diskcliph,cornerd,1);
	translate([diskclipl+diskcliphandlel,0,-diskcliph/2]) roundedbox(xtolerance+wall,wall,diskcliph,cornerd,1);
      }
    }

    translate([diskcliplockx-xtolerance,-cornerd/2,-diskcliplockh/2-ztolerance]) roundedbox(diskcliplockl+xtolerance*2,diskclipw+cornerd,diskcliplockh+ztolerance*2,0);

    translate([(diskclipl+diskcliplockl+diskcliplockx+wall)/2,wall-textdepth+0.01,0]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module diskclipcover(bottom=0) {
  hull() {
    translate([diskclipcoverx-xtolerance-diskclipcoverfullw+wall,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverfullw,wall,diskclipcoverh,cornerd);
    translate([diskclipcoverx-xtolerance,diskclipw+ytolerance,-diskclipcoverh/2]) roundedbox(wall,clipwall,diskclipcoverh,cornerd);
  }
  hull() {
    translate([diskcliplockcutx+diskcliplockcutl-wall*2,diskclipw+ytolerance,-diskcliplockbarh/2]) roundedbox(wall,clipwall,diskcliplockbarh,0);
    translate([diskcliplockcutx+diskcliplockcutl-wall*2+diskcliphandlel,diskclipw+ytolerance+diskcliphandlel,-diskcliplockbarh/2]) roundedbox(wall,clipwall/2,diskcliplockbarh,clipwall/2,0);
  }
  translate([diskclipcoverx-xtolerance,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverl+xtolerance,diskclipcoverfullw,wall,cornerd);
  if (bottom) hull() {
    translate([diskclipcoverx-xtolerance,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverl+xtolerance,diskclipcoverfullw,wall,cornerd);
    translate([diskclipcoverx-xtolerance,-wall-ytolerance,-diskclipcoverh/2-diskclipcoverfullw+wall]) roundedbox(diskclipcoverl-xtolerance,wall,wall,cornerd);
    translate([diskclipcoverx-xtolerance-diskclipcoverfullw+wall,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverfullw,wall,wall,cornerd);
  }
  translate([diskclipcoverx-xtolerance,diskclipw+ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverl+xtolerance,clipwall,diskclipcoverh,cornerd);
  translate([diskclipcoverx,-wall-ytolerance,+diskclipcoverh/2-wall]) roundedbox(diskclipcoverl,diskclipcoverfullw,wall,cornerd);
  hull() {
    translate([diskcliplockx,diskclipw+ytolerance,-diskcliplockh/2]) cube([diskcliplockl,clipwall,diskcliplockh]);
    translate([diskcliplockx,0,-diskcliplockh/2+diskclipw+ytolerance]) cube([1,diskclipw+ytolerance+clipwall,diskcliplockh-(diskclipw+ytolerance)*2]);
  }
}

module diskclipcovercut() {
  difference() {
    union() {
      translate([diskcliplockcutx,diskclipw+ytolerance-diskclipcut,-diskcliplockbarh/2-diskclipcut]) cube([diskcliplockcutl+diskclipcut,clipwall+diskclipcut+0.01,diskclipcut]);
      translate([diskcliplockcutx+diskcliplockcutl,diskclipw+ytolerance-0.01,-diskcliplockbarh/2-diskclipcut]) cube([diskclipcut*2,clipwall+0.02,diskcliplockbarh+diskclipcut*2]);
      translate([diskcliplockcutx,diskclipw+ytolerance-0.01,diskcliplockbarh/2]) cube([diskcliplockcutl+diskclipcut,clipwall+0.02,diskclipcut]);
    }

    if (0) for (z=[-diskcliplockbarh/2-diskclipcut,diskcliplockbarh/2]) {
      for (x=[diskcliplockcutx+diskcliplockcutl-0.4,diskcliplockcutx+diskcliplockcutl/2-0.2]) {
	if ((z < 0) || (x < diskcliplockcutx+diskcliplockcutl/2)) {
	  translate([x,diskclipw+ytolerance,z-0.01]) cube([0.4,0.4,diskclipcut+0.02]);
	  translate([x,diskclipw+ytolerance,z+diskclipcut-0.2]) cube([0.4,clipwall,0.2+0.01]);
	  translate([x,diskclipw+ytolerance+clipwall-0.4,z-0.01]) cube([0.4,0.4,diskclipcut+0.02]);
	}
      }
    }
  }
}

module coverclip() {
  difference() {
    union() {
      hull() {
	translate([0,0,-covercliph/2+wall]) roundedbox(coverclipl+xtolerance+wall,wall/2,covercliph-wall*2,cornerd,1);
	translate([wall/2,0,-covercliph/2]) roundedbox(coverclipl+xtolerance+wall-wall/2,wall,covercliph,cornerd,1);
      }
      translate([coverclipl+xtolerance,-covercliplockw+wall,-covercliph/2]) roundedbox(wall,covercliplockw+covercliphandlel,covercliph,cornerd,1);
      if (0)       hull() {
	translate([coverclipl,0,-covercliph/2]) roundedbox(xtolerance+wall,wall,covercliph,cornerd,1);
	//	translate([coverclipl+covercliphandlel,0,-covercliph/2]) roundedbox(xtolerance+wall,wall,covercliph,cornerd,1);
      }

      hull() {
	translate([covercliplockx,0,-covercliplockh/2]) cube([covercliplockl,clipwall,covercliplockh]);
	translate([covercliplockx+covercliplockl-1,0,-covercliplockh/2+coverclipw+ytolerance]) cube([1,coverclipw+ytolerance+clipwall,covercliplockh-(coverclipw+ytolerance)*2]);
      }
    }

    if (0) translate([covercliplockx-xtolerance,-cornerd/2,-covercliplockh/2-ztolerance]) roundedbox(covercliplockl+xtolerance*2,coverclipw+cornerd,covercliplockh+ztolerance*2,0);

    translate([coverclipl/2,textdepth-0.01,0]) rotate([90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=6, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module coverclipcover(bottom=0) {
  hull() {
    x=coverclipcoverx-xtolerance-coverclipcoverfullw+wall;
    if (x>bottom) translate([x,coverclipw+ytolerance+clipwall-coverclipcoverfullw,-coverclipcoverh/2+wall]) roundedbox(wall,wall,coverclipcoverh-wall*2,cornerd);
    if (x<bottom) translate([bottom,coverclipw+ytolerance+clipwall-coverclipcoverfullw,-coverclipcoverh/2]) roundedbox(wall,coverclipcoverfullw,coverclipcoverh,cornerd);
    translate([coverclipcoverx-xtolerance,coverclipw+ytolerance+clipwall-coverclipcoverfullw,-coverclipcoverh/2]) roundedbox(wall,coverclipcoverfullw,coverclipcoverh,cornerd);
  }
  if (0) hull() {
    translate([coverclipcoverx+coverclipl-wall/2,coverclipw+ytolerance,-covercliplockbarh/2]) roundedbox(wall,clipwall,covercliplockbarh,0);
    translate([coverclipcoverx+coverclipl-wall/2+covercliphandlel,coverclipw+ytolerance+covercliphandlel,-covercliplockbarh/2]) roundedbox(wall,clipwall/2,covercliplockbarh,clipwall/2,0);
  }
  hull() {
    translate([coverclipcoverx+coverclipl-covercliphandlew+wall+xtolerance,coverclipw+ytolerance,coverclipcoverh/2-clipwall-clipwall-wall]) roundedbox(covercliphandlew,clipwall,covercliphandlew+wall,cornerd);
    translate([coverclipcoverx+coverclipl-covercliphandlel+wall+xtolerance+covercliphandlel-clipwall,coverclipw+ytolerance+covercliphandlew,coverclipcoverh/2-wall+covercliphandlew]) roundedbox(clipwall,clipwall,clipwall,cornerd);
  }
  hull() {
    translate([coverclipcoverx+coverclipl-covercliphandlel+wall+xtolerance-covercliphandlew,coverclipw+ytolerance,coverclipcoverh/2-clipwall]) roundedbox(covercliphandlel+covercliphandlew,clipwall,clipwall,cornerd);
    translate([coverclipcoverx+coverclipl-covercliphandlel+wall+xtolerance,coverclipw+ytolerance+covercliphandlew,coverclipcoverh/2-wall+covercliphandlew]) roundedbox(covercliphandlel,clipwall,clipwall,cornerd);
  }
  for (m=[0,1]) mirror([0,0,m]) {
      translate([coverclipcoverx-xtolerance,-wall-ytolerance,-coverclipcoverh/2]) roundedbox(coverclipcoverl+xtolerance,coverclipcoverfullw-clipwall-coverclipcut,wall,cornerd);
    }
  for (m=[0]) mirror([0,0,m]) {
      translate([coverclipcoverx-xtolerance,-wall-ytolerance,-coverclipcoverh/2-coverclipbridge-wall]) roundedbox(coverclipcoverl+xtolerance,coverclipcoverfullw,wall,cornerd);
    }
  translate([coverclipcoverx-xtolerance,coverclipw+ytolerance,-coverclipcoverh/2]) roundedbox(coverclipcoverl+xtolerance,clipwall,coverclipcoverh,cornerd);
  translate([covercliplockx,coverclipw+ytolerance,-coverclipcoverh/2-coverclipbridge-wall]) roundedbox(covercliplockl+wall*2,clipwall,coverclipcoverh+coverclipbridge+wall,cornerd);
  if (0) #  translate([coverclipcoverx,-wall-ytolerance,+coverclipcoverh/2-wall]) roundedbox(coverclipcoverl,coverclipcoverfullw,wall,cornerd);
  if (0) hull() {
    translate([covercliplockx,coverclipw+ytolerance,-covercliplockh/2]) cube([covercliplockl,clipwall,covercliplockh]);
    translate([covercliplockx,0,-covercliplockh/2+coverclipw+ytolerance]) cube([1,coverclipw+ytolerance+clipwall,covercliplockh-(coverclipw+ytolerance)*2]);
  }
}

module coverclipcovercut() {
  difference() {
    union() {
      if (0) for (m=[0,1]) mirror([0,0,m]) {
	  translate([covercliplockcutx,coverclipw+ytolerance-coverclipcut,-covercliph/2-ztolerance]) cube([covercliplockcutl+coverclipcut,clipwall+coverclipcut+0.01,coverclipcut]);
	}

      translate([covercliplockcutx,coverclipw+ytolerance-coverclipcut,-coverclipcoverh/2-0.01]) cube([coverclipcoverl,coverclipcut,coverclipcoverh+0.02]);
      if (0) translate([covercliplockcutx+covercliplockcutl,coverclipw+ytolerance-0.01,-covercliph/2-ztolerance]) cube([coverclipcut*2,clipwall+0.02,covercliph+ztolerance*2]);
      //      translate([covercliplockcutx,coverclipw+ytolerance-0.01,covercliplockbarh/2]) cube([covercliplockcutl+coverclipcut,clipwall+0.02,coverclipcut]);
      translate([covercliplockx-xtolerance,coverclipw-cornerd/2,-covercliplockh/2-ztolerance]) roundedbox(covercliplockl+xtolerance*2,coverclipw+cornerd,covercliplockh+ztolerance*2,0);
    }

    if (0) for (z=[-covercliplockbarh/2-coverclipcut,covercliplockbarh/2]) {
      for (x=[covercliplockcutx+covercliplockcutl-0.4,covercliplockcutx+covercliplockcutl/2-0.2]) {
	if ((z < 0) || (x < covercliplockcutx+covercliplockcutl/2)) {
	  translate([x,coverclipw+ytolerance,z-0.01]) cube([0.4,0.4,coverclipcut+0.02]);
	  translate([x,coverclipw+ytolerance,z+coverclipcut-0.2]) cube([0.4,clipwall,0.2+0.01]);
	  translate([x,coverclipw+ytolerance+clipwall-0.4,z-0.01]) cube([0.4,0.4,coverclipcut+0.02]);
	}
      }
    }
  }
}

module icopdiskholder() {
  difference() {
    union() {
      // Bottom plate
      translate([0,0,0]) roundedbox(leftl,basew/2,wall,cornerd,7);
      translate([0,baserighty,0]) roundedbox(baserightl+xtolerance+wall,disksw,wall,cornerd,7);

      // Right disk side plate
      translate([0,baserighty,0]) roundedbox(baserightl,wall,lefth,cornerd,7);
      translate([0,baserighty,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);

      // Left side plate
      translate([0,lefty-wall,0]) roundedbox(leftl,wall,lefth,cornerd,7);
      if (disklockclips) {
	for (i=[0:1:disks25-1]) {
	  z=disks25height+i*disk25hstep+disk25spaceh/2;
	  translate([disk25clipx,lefty+ytolerance,z]) diskclipcover(i==0);
	}
      } else {
	for (i=[0:1:disks25-1]) {
	  z=disks25height+i*disk25hstep;
	  hull() {
	    translate([leftl-wall+xtolerance*2,lefty-wall,z+disk25h/2-disk25lockh/2]) roundedbox(wall,wall,disk25lockh,cornerd,0);
	    translate([leftl-wall+xtolerance*2+disklockw,lefty-wall-disklockw,z+disk25h/2-disk25lockh/2]) roundedbox(wall,wall,disk25lockh,cornerd,0);
	  }
	}
      }
      
      // Mid/left side disk side plate
      translate([0,midsidey,0]) roundedbox(disksleftlockl,wall,lefth,cornerd,7);
      translate([0,baserighty+disksw-diskstopperw,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);
      if (disklockclips) {
	for (i=[0:1:disks-1]) {
	  z=disksheight+i*diskhstep+diskspaceh/2;
	  translate([diskclipx,baserighty-ytolerance,z]) mirror([0,1,0]) diskclipcover(i==0);//rotate([180,0,0])
	}
      } else {
	for (i=[0:1:disks-1]) {
	  z=disksheight+i*diskhstep;
	  hull() {
	    translate([disksleftlockl-wall,baserighty+disksw-wall,z+diskh/2-disklockh/2]) roundedbox(wall,wall,disklockh,cornerd,0);
	    translate([disksleftlockl-wall+disklockw,baserighty+disksw-wall-disklockw,z+diskh/2-disklockh/2]) roundedbox(wall,wall,disklockh,cornerd,0);
	  }
	}
      }

      // Left top
      translate([0,lefty-basew,lefth-wall]) roundedbox(leftl,basew,wall,cornerd,7);
      
      // Raise bottom screws to avoid them hitting disks
      for (x=bottomrightscrewxtable) {
	h=wall+bottomscrewmoveh+bottomscrewbaseh+0.5;

	hull() {
	  for (xx=[-bottomrightscrewopeningx,0]) {
	    translate([x+xx,-bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=h,$fn=90);
	    translate([x+xx,-bottomscreww/2-bottomscrewbased/4,0]) cube([bottomscrewbased/2+wall,bottomscrewbased/2,h]);
	    translate([x+xx-bottomscrewmoveh-bottomscrewbaseh-0.5,-bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=wall,$fn=90);
	  }
	}
      }

      for (x=tassuleftxtable) {
	translate([x,bottomscreww/2-tassuw/2,-tassuh]) tassu();
      }
      for (x=tassumidxtable) {
	translate([x,midsidey+wall/2-tassuw/2,-tassuh]) tassu();
      }
      for (x=tassurightxtable) {
	translate([x,baserighty+wall/2,-tassuh]) tassu();
      }
      
      for (x=bottomleftscrewxtable) {
	h=wall+bottomscrewbaseh+0.5;
	hull() {
	  translate([x,bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=h,$fn=90);
	  translate([x,bottomscreww/2-bottomscrewbased/4,0]) cube([bottomscrewbased/2+wall,bottomscrewbased/2,h]);
	  translate([x-bottomscrewbaseh-0.5,bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=wall,$fn=90);
	}
      }

      // Disk supports
      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep;
	translate([0,baserighty,z-wall]) roundedbox(baserightl,diskstopperw,wall,cornerd,7);
	translate([0,baserighty+disksw-diskstopperw,z-wall]) roundedbox(baserightl,diskstopperw,wall,cornerd,7);
      }

      for (i=[0:1:disks25-1]) {
	z=disks25height+i*disk25hstep;
	translate([0,disk25y-xtolerance-wall,z-wall]) roundedbox(wall+xtolerance+disk25l,diskstopperw,wall,cornerd,7);
	translate([0,disk25y+disk25w+xtolerance+wall-diskstopperw,z-wall]) roundedbox(wall+xtolerance+disk25l,diskstopperw,wall,cornerd,7);
      }
      translate([0,disk25y-xtolerance-wall,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);
      translate([0,disk25y+disk25w+xtolerance+wall-diskstopperw,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);

      // Floppy supports
      translate([0,floppyy+ytolerance,lefth-wall]) roundedbox(leftl,wall,floppyspaceh*2+wall+wall,cornerd,7);
      translate([0,floppyy-floppyw-ytolerance-wall,lefth-wall]) roundedbox(leftl,wall,floppyspaceh*2+wall+wall,cornerd,7);
      translate([0,floppyy-floppyw-ytolerance-wall,floppytopheight]) roundedbox(leftl,wall+ytolerance+floppyw+ytolerance+wall,wall,cornerd,7);
      
      // First top
      translate([0,baserighty,lefth-wall]) roundedbox(baserightl,disksw,wall,cornerd,7);
    }

    // Disk locks
    if (!disklockclips) for (i=[0:1:disks-1]) {
      z=disksheight+i*diskhstep;

      translate([disksleftlockl-disklockl,baserighty+disksw-disklockw-0.01,z]) lockcut();
      translate([disksleftlockl-disklockl,baserighty+disksw-disklockw-0.01,z+ztolerance+diskh+ztolerance-disklockcut]) lockcut();
    }

    if (disklockclips) {
      for (i=[0:1:disks25-1]) {
	z=disks25height+i*disk25hstep+disk25spaceh/2;
	translate([disk25clipx,lefty+ytolerance,z]) diskclipcovercut();
      }
      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep+diskspaceh/2;
	translate([diskclipx,baserighty-ytolerance,z]) mirror([0,1,0]) diskclipcovercut();
      }
    }
    
    // Floppy and upper slots screwholes
    for (i=[0:1:1]) {
      z=floppyheight+i*(ztolerance+floppyh+ztolerance);
      w=wall+ytolerance+floppyw+ytolerance+wall;
      for (x=floppyscrewxtable) {
	translate([floppyx+floppyl-x,floppyy+ytolerance+wall-w-0.1,z+floppyscrewheight]) rotate([-90,0,0]) cylinder(d=floppyscrewd,h=w+0.2,$fn=30);
      }

      for (zz=diskscrewztable) {
	for (x=diskscrewxtable) {
	  translate([floppyl-x,floppyy+ytolerance+wall-w-0.1,z+zz]) rotate([-90,0,0]) cylinder(d=floppyscrewd,h=w+0.2,$fn=30);
	}
      }
    }
    
    // Screw holes
    for (x=bottomrightscrewxtable) {
      h=bottomscrewbaseh+0.5+0.02;
      hull() {
	for (xx=[-bottomrightscrewopeningx,0]) {
	  translate([x+xx,-bottomscreww/2,wall+bottomscrewmoveh]) printablehole(bottomscrewbased,h+0.01,$fn=90);
	}
      }
      hull() {
	for (xx=[-bottomrightscrewopeningx,0]) {
	  translate([x+xx,-bottomscreww/2,-0.01]) printablehole(bottomrightscrewd,wall+bottomscrewmoveh+0.02,$fn=90);
	}
      }

      translate([x-bottomrightscrewopeningx,-bottomscreww/2,-0.01]) {
	printablehole(bottomscrewbased,bottomscrewmoveh+bottomscrewbaseh+0.02,$fn=90);
      }
    }
    for (x=bottomleftscrewxtable) {
      h=wall+bottomscrewbaseh+0.5;
      intersection() {
	hull() {
	  translate([x,bottomscreww/2,wall]) cylinder(d=bottomscrewbased,h=h,$fn=90);
	}
      }
      translate([x,bottomscreww/2,-0.01]) cylinder(d=bottomleftscrewd,h=wall+0.02,$fn=90);
    }

    // Bottom lightening holes
    if (lighteningholes) {
      margin=10;
      barw=8;
      upx=bottomrightscrewxtable[1]-bottomscrewmoveh-bottomrightscrewd/2-4;
      upw=midsidey-bottomrightscrewy;
      uph=baserightl-upx;
      midx=bottomrightscrewxtable[0]+bottomrightscrewd/2;
      midw=diskw;
      midh=upx-midx;
      lowx=wall;
      loww=midsidey-bottomrightscrewy;
      lowh=midx-lowx;
      translate([wall+xtolerance,disk25y,0]) rotate([90,0,90]) lighten(disk25w,disk25l,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      translate([lowx,-bottomscreww/2,0]) rotate([90,0,90]) lighten(loww,lowh+margin,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      translate([midx,disky,0]) rotate([90,0,90]) lighten(midw,midh,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      translate([upx-margin,-bottomscreww/2,0]) rotate([90,0,90]) lighten(upw,uph+margin,wall,margin,barw,maxbridge,"up",cornerd=cornerd);

      // Top lightening holes
      toplefty=floppyy+wall; //+floppyw+xtolerance+wall;
      topleftw=lefty-wall-toplefty;
      translate([wall+xtolerance,toplefty,lefth-wall]) rotate([90,0,90]) lighten(topleftw,disk25l,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      topmidy=floppyy-floppyw;
      topmidw=midsidey-wall-topmidy;
      translate([wall+xtolerance,topmidy,lefth-wall]) rotate([90,0,90]) lighten(topmidw,diskl,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      translate([textsize+2-margin/2,topmidy,floppytopheight]) rotate([90,0,90]) lighten(floppyw,leftl-(textsize+2-margin/2),wall,margin,barw,maxbridge,"up",cornerd=cornerd);

      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep;
	fulll=diskclipx+diskclipcoverx-diskclipcoverfullw+wall;
	l=fulll/2;
	for (x=[wall,wall+fulll/2]) {
	  translate([x,baserighty+wall,z+ztolerance]) rotate([90,-90,90]) lighten(diskh,l,wall,5,barw,maxbridge,"up",cornerd=cornerd);
	}
	translate([leftl,midsidey+wall,z+ztolerance]) rotate([90,-90,90]) lighten(diskh,baserightl-leftl-margin/2,wall,5,barw,maxbridge,"up",cornerd=cornerd);
      }
    }
    
    translate([textsize,floppyy-floppyw/2,lefth+floppyspaceh*2+wall-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(longtext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module fantappi(d,h) {
  hull() {
    cylinder(h=h+0.4,d=d,$fn=30);
    translate([0,0,h+0.1+(d-d/2)/2]) sphere(d=d/2,$fn=30);
  }
}

module fan() {
  difference() {
    translate([-fanl/2,-fanw/2,0]) roundedbox(fanl,fanw,fanh,cornerd,0);
    translate([0,0,-0.1]) rotate([0,00,0]) cylinder(d=fanw-2,h=fanh+0.2,$fn=90);
    for (x=[-fanscrewl/2,fanscrewl/2]) {
      for (y=[-fanscreww/2,fanscreww/2]) {
	translate([x,y,-0.1]) cylinder(d=fanscrewd,h=fanh+0.2,$fn=90);
      }
    }
  }
}

module fanframe() {
  difference() {
    union() {
      difference() {
	union() {
	  // Hole frame
	  translate([-cornerd/2,-fanframew/2,-fanframeh/2]) roundedbox(cornerd/2+fanframel,fanframew,fanframeh,cornerd,7);

	  // Flange
	  hull() {
	    translate([-wall,-fanframew/2-fanframeflange,-fanframeh/2-fanframeflange]) roundedbox(wall,fanframew+fanframeflange*2,fanframeh+fanframeflange*2,cornerd,7);
	    translate([-wall-wall,-fanframew/2,-fanframeh/2]) roundedbox(wall,fanframew,fanframeh,cornerd,7);
	  }

	  difference() {
	    hull() {
	      translate([-wall-wall,-fanframew/2,-fanframeh/2]) roundedbox(wall,fanframew,fanframeh,cornerd,7);
	      translate([fanframebasex+wall,-fanframew/2,-fanframeh/2]) rotate([0,-90,0]) roundedboxxyz(fanframeh,fanframew,wall,fanframelargecornerd,cornerd,2,90);
	    }
	    hull() {
	      translate([-wall-wall-cornerd/2,-fanframew/2+wall,-fanframeh/2+wall]) roundedbox(wall+cornerd/2,fanframew-wall*2,fanframeh-wall*2,cornerd,0);
	      translate([fanframebasex+wall*2,-fanframew/2+wall,-fanframeh/2+wall]) rotate([0,-90,0]) roundedboxxyz(fanframeh-wall*2,fanframew-wall*2,wall,fanframelargecornerd,cornerd,2,90);
	    }
	  }
      
	  // Fan base
	  translate([fanframebasex,-fansupportw/2,-fansupporth/2]) roundedbox(fansupportl,fansupportw,fansupporth,cornerd,7);
	  
	  // Front
	  translate([fanframebasex+wall,-fanframew/2,-fanframeh/2]) rotate([0,-90,0]) roundedboxxyz(fanframeh,fanframew,wall,fanframelargecornerd,cornerd,2,90);
	}

	// Opening cut
	translate([-wall*2-cornerd/2,-fanframew/2+wall,-fanframeh/2+wall]) roundedbox(wall*2+fanframel+cornerd,fanframew-wall*2,fanframeh-wall*2,cornerd,0);

	// Fan air hole
	translate([fanframebasex-0.01,0,0]) rotate([0,90,0]) cylinder(d=fand,h=fansupportl+0.02,$fn=90);
      }

      // Taps for fan
      for (y=[-fanscreww/2,fanscreww/2]) {
	for (z=[-fanscrewl/2,fanscrewl/2]) {
	  translate([fanframebasex,y,z]) rotate([0,90,0]) fantappi(fanscrewd,wall+ztolerance+4);
	}
      }

      // Fan side holders
      for (r=[0,90,180,270]) rotate([r,0,0]) {
	  translate([fanframebasex+fansupportl-cornerd/2,-fanholderclipl/2,-fanholderh/2]) roundedbox(cornerd/2+fanholderl,fanholderclipl,wall,cornerd,0);
	  hull() {
	    translate([fanframebasex+fansupportl+fanholderl-fanholderclipd,-fanholderclipl/2,-fanholderh/2]) roundedbox(fanholderclipd,fanholderclipl,wall,cornerd,0);
	    translate([fanframebasex+fansupportl+fanholderl-fanholderclipd/2,0,-fanholderh/2+fanholderclipd/2]) rotate([0,0,90]) tubeclip(fanholderclipl,fanholderclipd,0);
	  }
	}

      // side clips
      for (m=[0,1]) mirror([0,m,0]) {
	  clipcoverbottomx=fanframel-coverclipl-coverclipcoverx-xtolerance;
	  clipcoverbottomslopex=clipcoverbottomx-coverclipcoverfullw+wall;
	  b=fanframebasex-clipcoverbottomslopex-wall;
	  translate([fanframel-coverclipl,-fanframew/2+wall+ytolerance,0]) coverclipcover(bottom=b);
	  for (n=[0,1]) mirror([0,0,n]) {
	      translate([fanframel-coverclipl,fanframeclipy,-fanframeh/2+wall+ztolerance]) rotate([90,0,0]) coverclipcover(bottom=b);
	    }
	}
    }

    // side clip cuts
    for (m=[0,1]) mirror([0,m,0]) {
	translate([fanframel-coverclipl,-fanframew/2+wall+ytolerance,0]) coverclipcovercut();
	for (n=[0,1]) mirror([0,0,n]) {
	    translate([fanframel-coverclipl,fanframeclipy,-fanframeh/2+wall+ztolerance]) rotate([90,0,0]) coverclipcovercut();
	  }
      }

    l=-fanframebasex-wall-cornerd/2;
    translate([fanframebasex+l/2,0,fanframeh/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(longtext, size=min(textsize,l)-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }

  translate([fanframebasex,0,0]) rotate([0,90,0]) grill(fand+1,thickness=wall);
}

if (print==0) {
  intersection() {
    if (debug) translate([-1000,-1000,-1000]) cube([2000,2000,1000+disks25height+disk25spaceh/2+disk25spaceh+wall]);

    union() {
      
      icopdiskholder();

      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep;
	%translate([diskx+diskl,disky+diskw/2,z]) rotate([0,0,180]) diskform("3.5");
	#translate([diskx+diskl-diskclipl,baserighty-ytolerance,z+ztolerance+diskh/2]) mirror([0,1,0]) diskclip();
      }

      for (i=[0:1:disks25-1]) {
	z=disks25height+i*disk25hstep;
	%translate([disk25x+disk25l,disk25y+disk25w/2,z]) rotate([0,0,180]) diskform("2.5");
	#translate([disk25x+disk25l-diskclipl,lefty+ytolerance,z+ztolerance+disk25h/2]) diskclip();
      }

      for (i=[0:1:1]) {
	z=floppyheight+i*(ztolerance+floppyh+ztolerance);
	%translate([floppyx+floppyl,floppyy-floppyw/2,z]) rotate([0,0,180]) diskform("3.5FLOPPY");
      }
    }
  }
 }

if (print==1 || print==3) {
  difference() {
    brim(w=8,heatcoverh=abs?baserightl:0) rotate([0,-90,0]) icopdiskholder();
    brimcut(w=8) rotate([0,-90,0]) icopdiskholder();
  }
  rotate([0,-90,0]) icopdiskholder();
 }

if (print==2 || print==3) {
  translate([-diskcliplockw-0.5,-diskclipl-diskstopperw-diskcliplockl,0]) rotate([0,0,90]) {
    for (i=[0:1:disks+disks25-1]) {
      translate([0,i*(diskcliplockw+0.5),diskcliph/2]) diskclip();
    }
  }
 }

if (print==5) {
  x=disk25x+disk25l-diskclipl-7;
  translate([30,-70,-x]) rotate([0,-90,0]) intersection() {
    icopdiskholder();
    translate([x,disk25x+disk25l-30,0]) cube([100,20,21]);
  }
  translate([0,0,diskcliph/2]) diskclip();
 }

if (print==6) {
  rotate([0,-90,0]) intersection() {
    icopdiskholder();
    union() {
      translate([bottomleftscrewxtable[0]-10,-200,-100]) cube([20,400,100+wall+1]);
      translate([0,-bottomscreww/2-10,-100]) cube([bottomrightscrewxtable[1]+bottomscrewbased-2,20,100+disksheight]);
      translate([0,-bottomscreww/2-22,-100]) cube([145,14,100+disksheight-wall-1]);
      translate([0,-bottomscreww/2-22,-100]) cube([wall+1,200,100+disksheight+5]);
      translate([0,-10,-100]) cube([100,20,100+disks25height-wall-0.01]);
      translate([0,bottomscreww/2-13,-100]) cube([70,20,100+disksheight-wall-1]);
      translate([0,bottomscreww/2-7,-100]) cube([bottomleftscrewxtable[1]+bottomscrewbased-2,20,100+disksheight-wall]);
    }
  }
 }

if (print==7) {
  intersection() {
    icopdiskholder();
    if (1) union() {
      translate([bottomleftscrewxtable[0]-10,-200,0]) cube([20+10,400,wall+1]);
      translate([bottomleftscrewxtable[0]-10,-200,0]) cube([20+60,400,wall+1]);
      translate([0,-bottomscreww/2-10,0]) cube([bottomrightscrewxtable[1]+bottomscrewbased-2,20,disksheight]);
      translate([0,-bottomscreww/2-22,0]) cube([145,14,disksheight-wall-1]);
      translate([0,-bottomscreww/2-22,0]) cube([wall+20,200,disksheight-5]);
      translate([0,-10,0]) cube([100,20,disks25height-wall-0.01]);
      translate([0,bottomscreww/2-13,0]) cube([70,20,disksheight-wall-1]);
      translate([0,bottomscreww/2-7,0]) cube([bottomleftscrewxtable[1]+bottomscrewbased-2,20,disksheight-wall]);
    }
  }
 }

if (print==8 || print==10) {
  translate([0,0,-fanframebasex]) rotate([0,-90,0]) intersection() {
    if (debug) translate([-100,-100,0]) cube([200,200,200]);
    difference() {
      union() {
	fanframe();
      }

      #if (debug) for (m=[0,1]) mirror([0,m,0]) {
	  clipcoverbottomx=fanframel-coverclipl-coverclipcoverx-xtolerance;
	  clipcoverbottomslopex=clipcoverbottomx-coverclipcoverfullw+wall;
	  b=fanframebasex-clipcoverbottomslopex-wall;
	  translate([fanframel-coverclipl,-fanframew/2+wall+ytolerance,0]) coverclip();
	  for (n=[0,1]) mirror([0,0,n]) {
	      translate([fanframel-coverclipl,fanframeclipy,-fanframeh/2+wall+ztolerance]) rotate([90,0,0]) coverclip();
	    }
	}
    }
  }
 }

if (print==9 || print==10) {
  for (i=[0:1:5]) translate([fanframeh/2+0.5+1,(i-3)*(covercliplockw+covercliphandlel+0.5)+covercliph/2,covercliph/2]) rotate([0,0,0]) coverclip();
 }

if (print==11) {
  translate([0,0,-fanframebasex]) rotate([0,-90,0]) intersection() {
    translate([-fanframel,fanframeclipy-15,-30-20]) cube([30,38,20]);
    fanframe();
  }
  
  for (i=[0]) translate([fanframeh/2+0.5+1,(i-3)*(covercliplockw+covercliphandlel+0.5)+covercliph/2,covercliph/2]) rotate([0,0,0]) coverclip();
 }
