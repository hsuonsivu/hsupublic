// Dispenser for eye drop pipettes
// Made for Oftagel and Oftaquix doses, likely fits others as well
// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

slots=12;

debug=0;
print=1; // 0 = Print model as it would work, 1 = printable model

pipettithickness=8;
pipettiheight=12.5;
pipettihandlethickness=3.6;
pipettilength=75.5;
pipettihandlel=24;
pipettiendtagthickness=3.1;
pipettiendl=3;

use <hsu.scad>

slotbetween=0.5;
wall=1;
cornerd=1;

axled=8;
axleendd=2;
axleendl=6;
axletolerance=0.5;
axleytolerance=0.3;
axledtolerance=0.5;
axlex=-axled/2-wall;
  
clipdepth=1;
clipd=1.4;
clipdoffset=clipd/2;

clipx=1.5;
clipxtolerance=0.2;
clipytolerance=0.5;
clipztolerance=0.2;
clipdtolerance=0.15;
clipw=20;
clipcut=0.5;
clipholex=1.5*clipx;

pressd=20;
pressdepth=0.5;
  
boxztolerance=0.4;

dosettiboxx=wall+slots*pipettithickness+(slots-1)*slotbetween+wall+clipholex+wall;
dosettiboxy=wall+pipettilength;
dosettiboxz=wall+pipettiheight+wall;

axlel=dosettiboxy-2*axleendl;
axlez=dosettiboxz/2;

cliph=dosettiboxz-2*wall;
clipz=wall;
clipy=dosettiboxy/2-clipw/2;

clipyposition=dosettiboxy/2-clipw/2;

module pipetti() {
  translate([pipettithickness/2-pipettihandlethickness/2,0,0]) roundedbox(pipettihandlethickness,pipettilength-pipettiendl,pipettiheight,cornerd);
  translate([0,pipettihandlel,0]) roundedbox(pipettithickness,pipettilength-pipettihandlel-pipettiendl,pipettiheight,cornerd*2);
  translate([pipettithickness/2-pipettiendtagthickness/2,pipettilength-pipettiendl-wall-cornerd,0]) roundedbox(pipettiendtagthickness,pipettiendl+cornerd,pipettiheight,cornerd);
}

module dosettibox() {
  difference() {
    roundedbox(dosettiboxx,dosettiboxy,dosettiboxz,cornerd);
    for (x=[wall:pipettithickness+slotbetween:dosettiboxx-pipettithickness]) {
      translate([x,wall,wall]) pipetti();
    }
  }
}

module dosettitop() {
  // Top
  difference() {
    union() {
      dosettibox();

      translate([axlex,0,axlez]) rotate([-90,0,0]) cylinder(d2=axled+wall*2-axledtolerance,d1=axleendd+wall*3,h=axleendl-axleytolerance,$fn=90);
      translate([-axled-wall,0,dosettiboxz/2+boxztolerance/2]) roundedbox(axled+wall+cornerd,axleendl-axleytolerance,dosettiboxz/2-boxztolerance/2,cornerd);

      translate([axlex,dosettiboxy-axleendl+axleytolerance,axlez]) rotate([-90,0,0]) cylinder(d1=axled+wall*2-axledtolerance,d2=axleendd+wall*3,h=axleendl-axleytolerance,$fn=90);
      translate([-axled-wall,dosettiboxy-axleendl+axleytolerance,dosettiboxz/2+boxztolerance/2]) roundedbox(axled+wall+cornerd,axleendl-axleytolerance,dosettiboxz/2-boxztolerance/2,cornerd);
    }
  
    translate([-0.01,-0.01,-0.01]) cube([dosettiboxx+0.02,dosettiboxy+0.02,dosettiboxz/2+boxztolerance/2+0.01]);
    translate([axlex,-0.01,axlez]) rotate([-90,0,0]) cylinder(d1=axleendd+axledtolerance,d2=axled+axledtolerance,h=axleendl-axleytolerance+0.02,$fn=90);
    translate([axlex,dosettiboxy-axleendl+axleytolerance-0.01,axlez]) rotate([-90,0,0]) cylinder(d2=axleendd+axledtolerance,d1=axled+axledtolerance,h=axleendl-axleytolerance+0.02,$fn=90);

    translate([dosettiboxx-clipholex-wall-clipxtolerance,clipyposition-clipytolerance,clipz-clipztolerance]) cube([clipholex+clipxtolerance*2,clipw+clipytolerance*2,dosettiboxz-clipz-clipztolerance-wall+0.01]);
    translate([dosettiboxx-clipholex-wall-clipxtolerance,clipyposition-clipytolerance,dosettiboxz/2]) cube([clipholex+clipxtolerance*2+wall,clipw+clipytolerance*2,dosettiboxz/2-wall-0.01]);
  }

  difference() {
    union() {
      translate([dosettiboxx-clipx,clipy,clipz+clipd+clipd/2]) cube([clipx,clipw,dosettiboxz-clipz-clipd-clipd/2-cornerd/2+0.01]);
      hull() {
	translate([dosettiboxx-clipx,clipy,clipz+clipd+clipd/2]) cube([clipx,clipw,wall*2]);
	translate([dosettiboxx-clipx-wall,clipy,clipz+clipd+clipd/2]) cube([clipx+wall,clipw,wall]);
      }
      translate([dosettiboxx-clipx-wall,clipy,clipz]) cube([clipx,clipw,clipd+clipd/2+0.02]);
      translate([dosettiboxx-clipdoffset-wall-clipxtolerance+clipd/2,clipyposition,clipz+clipd/2]) rotate([-90,0,0]) cylinder(d=clipd,h=clipw,$fn=90);
    }
    translate([dosettiboxx+pressd/2-pressdepth,dosettiboxy/2,dosettiboxz/2]) sphere(d=pressd,$fn=90);
  }
}

module dosettibottom() {
  // Bottom
  difference() {
    union() {
      dosettibox();
      translate([axlex,0,axlez]) rotate([-90,0,0]) cylinder(d1=axleendd,d2=axled,h=axleendl,$fn=90);
      translate([axlex,axleendl,axlez]) rotate([-90,0,0]) cylinder(d=axled,h=axlel,$fn=90);
      translate([axlex,axlel+axleendl,axlez]) rotate([-90,0,0]) cylinder(d1=axled,d2=axleendd,h=axleendl,$fn=90);
      translate([-axled-wall,axleendl,0]) roundedbox(axled+wall+wall,axlel,dosettiboxz/2-boxztolerance,cornerd);
    }
    translate([-0.01,-0.01,dosettiboxz/2-boxztolerance/2]) cube([dosettiboxx+0.02,dosettiboxy+0.02,dosettiboxz/2+boxztolerance/2+0.02]);

    translate([dosettiboxx-clipholex-wall-clipxtolerance,clipyposition-clipytolerance,clipz-clipztolerance]) cube([clipholex+clipxtolerance*2,clipw+clipytolerance*2,cliph+clipztolerance*2]);
    translate([dosettiboxx-clipdoffset-wall-clipxtolerance+clipd/2,clipyposition-clipytolerance,clipz+clipd/2]) rotate([-90,0,0]) cylinder(d=clipd+clipdtolerance,h=clipw+clipytolerance*2,$fn=90);
    translate([dosettiboxx-wall-0.01,clipyposition-clipytolerance,clipz+clipd+clipd/2-clipztolerance]) cube([wall+0.02,clipw+clipytolerance*2,dosettiboxz/2-clipz-clipd-clipd/2+clipztolerance]);
  }
}

module dosetti() {
  dosettibottom();
  dosettitop();
}

if (print==0) {
  if (debug) {
    difference() {
      dosetti();
      translate([axlex-axled,-0.01,-0.01]) cube([dosettiboxx+axlel+axled,dosettiboxy/2+0.02,dosettiboxz*2+0.02]);
    }
  } else {
    dosetti();
  }
 }

if (print==1) {
  dosettibottom();
  translate([-axled-wall-wall,0,dosettiboxz]) rotate([0,180,0]) dosettitop();
 }
