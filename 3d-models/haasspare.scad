// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <text_on_OpenSCAD/text_on.scad>

print=3;
debug=print>0?0:1;
versiontext="Haas knob spare V1.0";
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";
versiontextlen=textlen(versiontext,textsize);

outd=86-0.5;
outh=9.86;
outinnerd=81.1+0.5;
outinnerh=6.4;
holed=6.2;
holenarrow=5.15-holed/2;
centerd=16;
centerh=8;
midh=3.6+1.9;
midd=54;
cornerd=2;
l=13.64;
depth=0.95;
fingern=18;
fingerd=length_and_depth_to_diameter(l,depth);
fingerdistance=outd/2*cos(360/fingern/2)+fingerd/2;
knobd=15;
knobh=20;

module haasknob() {
  knob(knobd,knobh);
}

module haasspare() {
  difference() {
    union() {
      translate([midd/2+(outd-midd)/2/2,0,outh-0.01]) knobaxle(knobd,knobh);
      roundedcylinder(centerd,centerh,cornerd,1,90);
      roundedcylinder(midd+cornerd*2,midh,cornerd,1,90);
      minkowski(convexity=10) {
	if (1) hull() {
	  sphere(d=cornerd,$fn=90);
	  translate([0,0,-cornerd/2]) cylinder(d=cornerd/2,h=cornerd/2,$fn=90);
	}
	difference() {
	  hull() {
	    translate([0,0,cornerd/2]) cylinder(d=outinnerd-cornerd,h=outh-cornerd,$fn=90);
	    translate([0,0,outh/2-outinnerh/2+cornerd/2]) cylinder(d=outd-cornerd,h=outinnerh-cornerd,$fn=90);
	  }
	  translate([0,0,0]) cylinder(d=midd+cornerd,h=outh,$fn=90);
	  for (a=[0:360/18:359]) {
	    rotate([0,0,a])
	      translate([fingerdistance-cornerd/2,0,-0.01]) cylinder(d=fingerd+cornerd,h=outh+0.02,$fn=90);
	  }
	}
      }
    }

    // Center hole
    intersection() {
      translate([0,0,-0.01]) cylinder(d=holed,h=centerh+0.02,$fn=90);
      translate([-holenarrow,-holed/2,-0.01]) cube([holed,holed,centerh+0.02]);
    }
      
    rotate([0,0,90]) translate([0,0,outh-textdepth/2+0.01]) text_on_circle(t=versiontext,r=midd/2+(outd-midd)/2/2,size=textsize,font=textfont,extrusion_height=textdepth);
  }
}

if (print==0) {
  intersection() {
    union() {
      haasspare();
      haasknob();
    }
    if (debug) translate([0,0,0]) cube([100,100,100]);
  }
 }

if (print==1 || print==3) {
  haasspare();
 }

if (print==2 || print==3) {
  translate([outd/2+knobd/2-depth,0,knobh]) rotate([180,0,0]) haasknob();
 }

