// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;

versiontext="V1.0";
textdepth=0.7;
textsize=8;

wall=2;
cornerd=2;

fansize=92;
fanh=ztolerance+25+ztolerance;
fand=89;
fanoutd=89+wall;
fanscrewl=82.5;
fantowerd=4;
fantowerh=6;
fantowernarrowh=1;

casescrewl=71.5;

screwd=4.4;
screwheadd=7.5;
screwheadh=2.5;
platesize=wall+xtolerance+92+xtolerance+wall;

plateh=1.6+screwheadh;

cableholex=fansize/2-23; // -23;//16,23,
cableholel=23-16;
cableholeh=8;

clipd=3;
clipl=10;
clipheight=clipd+cornerd;

coversize=wall+xtolerance+platesize+xtolerance+wall;
coverheight=plateh+fanh;
coverh=plateh+fanh+wall;

module fanadapter() {
  difference() {
    union() {
      translate([-platesize/2,-platesize/2,0]) roundedbox(platesize,platesize,plateh,cornerd,1);
      for (n=[0,1]) mirror([n,0,0]) for (m=[0,1]) mirror([0,m,0]) {
	    translate([-platesize/2,-platesize/2,0]) roundedbox(wall,platesize,plateh+fanh,cornerd,1);
	    translate([-platesize/2,-platesize/2,0]) roundedbox(platesize,wall,plateh+fanh,cornerd,1);
	    translate([0,-platesize/2+wall-clipd/2,clipheight]) tubeclip(clipl,clipd,0);
	    translate([-platesize/2+wall-clipd/2,0,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,0);
	    translate([-fanscrewl/2,-fanscrewl/2,plateh-cornerd/2-0.01]) hull() {
	      roundedcylinder(fantowerd,fantowerh+cornerd/2,cornerd,1,90);
	      roundedcylinder(fantowerd/2,fantowerh+fantowernarrowh+cornerd/2,cornerd,1,90);
	    }
	  }
    }
    
    for (x=[-casescrewl/2,casescrewl/2]) {
      for (y=[-casescrewl/2,casescrewl/2]) {
	translate([x,y,-0.01]) cylinder(d=screwd,h=plateh+0.02,$fn=90);
	translate([x,y,plateh-screwheadh]) cylinder(d=screwheadd,h=screwheadh+0.02,$fn=90);
      }
    }

    translate([cableholex,-platesize/2-0.01,plateh]) roundedbox(cableholel,wall+0.02,fanh,0);

    translate([0,0,-0.01]) cylinder(d2=fand,d1=fanoutd,h=plateh+0.02,$fn=90);

    #translate([0,-platesize/2+textdepth-0.01,(plateh+fanh)/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module fancover() {
  printable=2;
  
  difference() {
    union() {
      translate([-coversize/2,-coversize/2,coverheight]) roundedbox(coversize,coversize,wall,cornerd,printable);
      for (n=[0,1]) mirror([n,0,0]) for (m=[0,1]) mirror([0,m,0]) {
	    translate([-coversize/2,-coversize/2,0]) roundedbox(wall,coversize,coverh,cornerd,printable);
	    translate([-coversize/2,-coversize/2,0]) roundedbox(coversize,wall,coverh,cornerd,printable);
	    translate([-fanscrewl/2,-fanscrewl/2,0]) hull() {
	      translate([0,0,coverheight-fantowerh-0.01]) roundedcylinder(fantowerd,fantowerh+cornerd/2,cornerd,1,90);
	      translate([0,0,coverheight-fantowerh-fantowernarrowh-0.01]) roundedcylinder(fantowerd/2,fantowerh+fantowernarrowh,cornerd,1,90);
	    }
	  }
    }
    
    for (n=[0,1]) mirror([n,0,0]) for (m=[0,1]) mirror([0,m,0]) {
	  translate([0,-platesize/2+wall-clipd/2,clipheight]) tubeclip(clipl,clipd,1);
	  translate([-platesize/2+wall-clipd/2,0,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,1);
	}
    
    for (x=[-casescrewl/2,casescrewl/2]) {
      for (y=[-casescrewl/2,casescrewl/2]) {
	translate([x,y,-0.01]) cylinder(d=screwd,h=plateh+0.02,$fn=90);
	translate([x,y,plateh-screwheadh]) cylinder(d=screwheadd,h=screwheadh+0.02,$fn=90);
      }
    }

    translate([cableholex,-coversize/2-cornerd/2-0.01,-cornerd/2-0.01]) roundedbox(cableholel,wall+cornerd+0.02,plateh+cableholeh+cornerd/2,cornerd,0);;

    translate([0,0,coverheight-0.01]) cylinder(d1=fand,d2=fanoutd,h=wall+0.02,$fn=90);

    #translate([0,-coversize/2+textdepth-0.01,(plateh+fanh)/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

if (print==0) {
  fanadapter();
  #fancover();
 }

if (print==1) {
  fanadapter();
  translate([platesize/2+(clipd-wall)+0.5+coversize/2,0,coverh]) rotate([180,0,0]) fancover();
 }

