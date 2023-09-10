// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

print=1;

versiontext="V1.5";
font="Liberation Sans:style=Bold";
textdepth=0.5;
textheight=8;

$fn=60;

// 11.04, some extra to allow crimp deform
tubediameter=13;
tubeoutdiameter=tubediameter+6;
// groove for cablebinder
tubebinderdiameter=tubediameter+3;
tubebinderwidth=4.9; // This the width of cablebinder end, not width of binder itself
tubebinderheight=2;
tubebindergap=4;
tubelength=19;

binderholderwidth=5;
binderholderheight=4;

coverwall=2;
coverwidth=20+2*coverwall;
coverlength=31+2*coverwall;
coverheight=21+coverwall;
coverangle=4;

cablecut=4;
cablecutwidth=6;
cablecutgap=1;
cableposition=0;

// Add some support for cablecuts
cablecutsupport=0.2;

wall=coverwall;
snapwidth=wall/5;
width=coverwidth;
height=coverheight;
textposition=5;

topbarwidth=tubediameter/2;

cornerdiameter=1;

fill=5;
snapstart=fill+1;

module roundedbox(x,y,z) {
  scd=1;
  f=30;
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

module cablecutsnap(x,y,z,xdepth,wall) {
  translate([-xdepth+x-wall-0.01,y-0.01,z]) cube([xdepth+0.02,wall-cablecutsupport+0.02,cablecutgap]);
  translate([-xdepth+x-wall-0.01,y+cablecutsupport-0.01,z]) cube([xdepth+0.02,wall-cablecutsupport+0.02,cablecutgap]);
  translate([-xdepth+x-wall-0.01,y-0.01,z+cablecutwidth]) cube([xdepth+0.02,wall+0.02,cablecutgap]);
  translate([x-cornerdiameter-wall+cornerdiameter/2,y+wall-snapwidth+0.01,z]) triangle(snapwidth,snapwidth,cablecutwidth+cablecutgap+0.01,4);
  translate([x-cornerdiameter-wall+cornerdiameter/2,y-0.01,z]) triangle(snapwidth,snapwidth,cablecutwidth+cablecutgap+0.01,6);
}

module cover() {
  difference() {
    union() {
      cylinder(h=tubelength,d=tubeoutdiameter);
      translate([-tubediameter/2-binderholderheight,-binderholderwidth/2,0]) roundedbox(binderholderheight,binderholderwidth,tubelength);
      translate([0,0,tubelength]) rotate([0,coverangle,0]) {
	union() {
	  difference() {
	    translate([-tubeoutdiameter/2,-coverwidth/2,0]) roundedbox(coverheight,coverwidth,coverlength);
	    translate([-tubeoutdiameter/2+coverheight-textdepth+0.01,-textheight/2,coverlength-textposition]) rotate([0,90,0]) linear_extrude(height=textdepth) text(text = str(versiontext), font = font, size=textheight, valign="baseline");
	    translate([-tubeoutdiameter/2,-coverwidth/2,-coverwall]) translate([-cornerdiameter,coverwall,coverwall+fill]) roundedbox(coverheight-coverwall+cornerdiameter,coverwidth-coverwall*2,coverlength-coverwall-fill);
	    translate([0,0,-coverwall]) hull() {
	      translate([0,0,fill-coverwall]) cylinder(h=fill,d=tubediameter);
	      translate([-coverheight/2,0,fill-coverwall]) cylinder(h=fill,d=tubediameter);
	      translate([-tubeoutdiameter/2+cornerdiameter/2-cornerdiameter,-coverwidth/2+coverwall+cornerdiameter/2,fill+coverwall+cornerdiameter/2]) sphere(d=cornerdiameter);
	      translate([-tubeoutdiameter/2+cornerdiameter/2-cornerdiameter,coverwidth/2-coverwall-cornerdiameter/2,fill+coverwall+cornerdiameter/2]) sphere(d=cornerdiameter);
	      translate([-tubeoutdiameter/2+coverheight-2*coverwall+cornerdiameter/2+cornerdiameter,-coverwidth/2+coverwall+cornerdiameter/2,fill+coverwall+cornerdiameter/2]) sphere(d=cornerdiameter);
	      translate([-tubeoutdiameter/2+coverheight-2*coverwall+cornerdiameter/2+cornerdiameter,coverwidth/2-coverwall-cornerdiameter/2,fill+coverwall+cornerdiameter/2]) sphere(d=cornerdiameter);
	    }

	    for (y=[-coverwidth/2,coverwidth/2-coverwall]) {
	      cablecutsnap(-tubeoutdiameter/2+coverheight-wall,y,snapstart,coverheight-wall-wall,coverwall);
	      cablecutsnap(-tubeoutdiameter/2+coverheight-wall,y,snapstart+cablecutwidth,coverheight-wall-wall,coverwall);
	      cablecutsnap(-tubeoutdiameter/2+coverheight-wall,y,snapstart+2*(cablecutwidth),coverheight-wall-wall,coverwall);
	      cablecutsnap(-tubeoutdiameter/2+coverheight-wall,y,snapstart+3*(cablecutwidth),coverheight-wall-wall,coverwall);
	    }
	  }
	  translate([-tubeoutdiameter/2+coverheight-tubediameter/2,-topbarwidth/2,-sin(coverangle)*(tubeoutdiameter/2-coverheight+tubediameter/2)-cos(coverangle)*(tubelength)]) roundedbox(tubediameter/2,topbarwidth,tubelength+sin(coverangle)*coverheight);
	}
      }
    }

    translate([0,0,-tubelength]) cylinder(d=2*tubeoutdiameter,h=tubelength);
    
    translate([0,0,-0.01]) cylinder(h=tubelength+coverwall*2+0.02,d=tubediameter);
    hull() {
      translate([0,0,tubelength-sin(coverangle)*tubeoutdiameter/2]) cylinder(h=coverwall*2+0.02,d=tubediameter);
      translate([-coverheight,0,tubelength-sin(coverangle)*tubeoutdiameter/2]) cylinder(h=coverwall*3+0.02,d=tubediameter);
  }
  for (z=[0,tubebinderwidth+tubebindergap]) {
    a=tubeoutdiameter-tubebinderdiameter;
    translate([0,0,z+tubebinderheight-a/2]) difference() {
      cylinder(h=tubebinderwidth+a,d=tubeoutdiameter+0.01);
      cylinder(h=tubebinderwidth+a,d=tubebinderdiameter);
      translate([0,0,0.01]) cylinder(h=a/2,d2=tubebinderdiameter,d1=tubeoutdiameter);
      translate([0,0,a/2+tubebinderwidth]) cylinder(h=a/2,d1=tubebinderdiameter,d2=tubeoutdiameter);
    }
  }
}

  translate([tubediameter/2,-topbarwidth/2]) cube([(tubeoutdiameter-tubediameter)/2,topbarwidth,tubelength]);
}

if (print == 0) {
  cover();
 } else if (print == 1) {
  translate([0,0,coverheight-cos(coverangle)*tubeoutdiameter/2-sin(coverangle)*tubeoutdiameter]) rotate([0,90-coverangle,0]) difference() {
    cover();
    translate([-tubeoutdiameter/2-binderholderheight,-tubeoutdiameter/2-1,-sin(coverangle)*tubeoutdiameter/2+0.01]) cube([tubeoutdiameter/2+binderholderheight,tubeoutdiameter+2,tubelength+sin(coverangle)*tubeoutdiameter/2]);
 }
    translate([tubelength,tubeoutdiameter+binderholderheight,0]) {
      difference() {
	cover();
	translate([0,-tubeoutdiameter-1,-sin(coverangle)*tubeoutdiameter/2]) cube([tubeoutdiameter+2,tubeoutdiameter*2+2,tubelength*2]);
	translate([-tubeoutdiameter/2-2*coverwall+sin(coverangle)*coverlength+1,-coverwidth/2-coverwall,tubelength]) cube([coverheight+2*coverwall,coverwidth+2*coverwall,coverlength+2*coverwall]);
}
aa=tubeoutdiameter-tubebinderdiameter;
for (zz=[0,tubebinderwidth+tubebindergap]) {
  translate([0,0,zz]) union() {
    hull() {
      translate([-cornerdiameter/2,tubebinderdiameter/2+aa/2,tubebinderheight]) rotate([90,0,0]) cylinder(h=aa/2,d=cornerdiameter);
      translate([-cornerdiameter/2,tubebinderdiameter/2+aa/2,tubebinderheight+tubebinderwidth]) rotate([90,0,0]) cylinder(h=aa/2,d=cornerdiameter);
      translate([tubebinderwidth-aa/2,tubebinderdiameter/2+aa/2,tubebinderheight+tubebinderwidth/2]) rotate([90,0,0]) cylinder(h=aa/2,d=cornerdiameter);
    }
    hull() {
      translate([-cornerdiameter/2,tubebinderdiameter/2+aa/2-cornerdiameter/2-0.01,tubebinderheight-aa/2]) cylinder(h=tubebinderwidth+aa+0.02,d=cornerdiameter);
      translate([-cornerdiameter/2,tubebinderdiameter/2-0.01,tubebinderheight-aa/2]) cylinder(h=tubebinderwidth+aa+0.02,d=cornerdiameter);
      translate([-aa*1.3,tubebinderdiameter/2-aa/2,tubebinderheight-aa/2]) cylinder(h=tubebinderwidth+aa+0.02,d=cornerdiameter);
  }

    hull() {
      translate([-cornerdiameter/2,-tubebinderdiameter/2,tubebinderheight]) rotate([90,0,0]) cylinder(h=aa/2,d=cornerdiameter);
      translate([-cornerdiameter/2,-tubebinderdiameter/2,tubebinderheight+tubebinderwidth]) rotate([90,0,0]) cylinder(h=aa/2,d=cornerdiameter);
      translate([tubebinderwidth-aa/2,-tubebinderdiameter/2,tubebinderheight+tubebinderwidth/2]) rotate([90,0,0]) cylinder(h=aa/2,d=cornerdiameter);
    }
    hull() {
translate([-cornerdiameter/2,-tubebinderdiameter/2-aa/2+cornerdiameter/2-0.01,tubebinderheight-aa/2]) cylinder(h=tubebinderwidth+aa+0.02,d=cornerdiameter);
      translate([-cornerdiameter/2,-tubebinderdiameter/2-0.01,tubebinderheight-aa/2]) cylinder(h=tubebinderwidth+aa+0.02,d=cornerdiameter);
      translate([-aa*1.3,-tubebinderdiameter/2+aa/2,tubebinderheight-aa/2]) cylinder(h=tubebinderwidth+aa+0.02,d=cornerdiameter);
  }

  }}
 }
}
