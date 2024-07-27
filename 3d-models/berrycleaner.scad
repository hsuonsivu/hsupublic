// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Berry cleaner

include <hsu.scad>

versiontext="Berrycleaner v1.1";
textsize=7;
textdepth=1;

berryslitw=5; // Measured more than 6.5mm for berries.
supportdistance=50;
barw=1.5;
barh=3;
supportw=1.5;
supporth=2;
height=50;
cornerd=5;
wall=2.5;
  
length=floor(300/(supportdistance+supportw)) * (supportdistance+supportw); // y, 220
width=floor(200/(berryslitw+barw)) * (berryslitw+barw); // x, 200

module berrycleaner() {
  intersection() {
    union() {
      for (x=[0:berryslitw+barw:width]) {
	translate([x,0,0]) cube([barw,length,barh]);
      }

      for (y=[0:supportdistance+supportw:length]) {
	translate([0,y,0]) cube([width,supportw,supporth]);
      }
    }
    translate([0,0,-cornerd]) roundedbox(width,length+wall,height,cornerd);
  }
  difference() {
    translate([0,0,-cornerd]) roundedbox(width,length+wall,height,cornerd);
    translate([wall,wall,-cornerd]) roundedbox(width-2*wall,length+cornerd,height+wall*2+cornerd,cornerd);
    translate([-0.1,-0.1,-cornerd-0.1]) cube([width+0.2,length+wall+0.2,cornerd+0.1]);
    translate([width/2,textdepth-0.01,height/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
  }
}

berrycleaner();
