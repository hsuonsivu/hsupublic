// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <text_on_OpenSCAD/text_on.scad>

print=1;
debug=0;

wall=2;

textdepth=0.7;
textsize=8;
versiontext="v1.3";
label="Headphones";
textfont="Liberation Sans:style=Bold";

hangsidedepth=2;
depth=55;
width=60;
walldistance=18; // In addition to depth
wallattachdepth=5;
wallattachh=80;
wallattachw=72;
cornerd=hangsidedepth;
wallattachcornerd=5;

hangd=100;
hangdepth=depth;
hangh=5;
hangw=50;
hangheight=wallattachh;
hangsideh=3;
hangsided=hangd+hangsideh*2;

supportw=40;
supporth=50;
topsupporth=20;
supportdepth=walldistance+hangdepth/2;

// Height of hanger
height=wallattachcornerd-1; //wallattachh-supporth-5;

screwd=3;
screwl=20;
screwbased=screwd*3;
screwcornerdistance=cornerd+1+screwbased/2;

module hang(edges,h) {
  translate([0,0,height]) {
    intersection() {
      translate([walldistance,-hangw/2,0]) roundedbox(hangdepth,hangw,supporth+hangsideh,cornerd);
      difference() {
	translate([walldistance+hangdepth/2,0,0]) for (m=[0,1]) mirror([m,0,0]) translate([0,0,0]) {
	    if (edges) hull() {
		translate([-hangdepth/2,0,supporth-hangd/2]) rotate([0,90,0]) roundedcylinder(hangsided,hangsidedepth,cornerd,0,180);
		translate([-hangdepth/2,0,supporth-hangd/2]) rotate([0,90,0]) roundedcylinder(hangd,hangsideh*2,cornerd,0,180);
	      }
	    translate([-hangdepth/2,0,supporth-hangd/2]) rotate([0,90,0]) roundedcylinder(hangd,hangdepth,cornerd,0,180);
	  }
	translate([walldistance-0.01,0,supporth-hangd/2]) rotate([0,90,0]) cylinder(d=hangd-h*2,h=hangdepth+0.02,$fn=180);
      }
    }
  }
}

module headphonehanger() {
  difference() {
    union() {
      // Wall attach plate
      translate([0,-wallattachw/2,0]) roundedbox(wallattachdepth,wallattachw,wallattachh,wallattachcornerd,5);

      // Hang
      hang(1,hangh);

      echo(height,supporth,topsupporth);
      for (m=[0,1]) mirror([0,m,0]) hull() {
	intersection() {
	  translate([0,-hangw/2,height+supporth-topsupporth]) roundedbox(walldistance+hangsidedepth,hangw/2+cornerd,topsupporth+hangsideh,cornerd);
	  hang(1,cornerd);
	}

	translate([0,-supportw/2,height+supporth-topsupporth]) roundedbox(wallattachdepth,supportw/2+cornerd,topsupporth,cornerd);
      }

      for (m=[0,1]) mirror([0,m,0]) {
	  hull() {
	    intersection() {
	      translate([0,-hangw/2,height]) roundedbox(walldistance+hangdepth,wall,supporth-hangh,cornerd);
	      hang(0,hangh);
	    }

#	    translate([0,-supportw/2,height]) roundedbox(wallattachdepth,wall,supporth-topsupporth+cornerd,cornerd);
	  }
	}
    }
    
    for (z=[screwcornerdistance,wallattachh-screwcornerdistance]) {
      for (y=[-wallattachw/2+screwcornerdistance,wallattachw/2-screwcornerdistance]) {
	translate([wallattachdepth-screwl+0.01,y,z]) rotate([0,90,0]) render() ruuvireika(screwl,screwd,1,1,wallattachdepth);
      }
    }

    translate([wallattachdepth-textdepth+0.01,0,wallattachh-wallattachcornerd-textsize/2+2]) rotate([90,0,90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-1,halign="center", valign="center");
    translate([wallattachdepth-textdepth+0.01,0,wallattachh-wallattachcornerd-textsize-textsize/2]) rotate([90,0,90]) linear_extrude(height=textdepth) text(label,font="Liberation Sans:style=Bold,Narrow",size=textsize,halign="center", valign="center");
  }
}

if (print==0) {
  intersection() {
    headphonehanger();

    if (debug) translate([0,-wallattachw/2,0]) cube([100,wallattachw-screwcornerdistance,100]);
  }
 }

if (print==1) {
  rotate([0,-90,0]) headphonehanger();
 }

