// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

screwholed=3.2; // Slightly below 3.4 measured from outside
topoutd=7/cos(180/6);
bottomoutw=7;
bottomoutd=7/cos(180/6);
handlel=25; // Bar protruding out
handlew=bottomoutw;
h=10;
wall=2;
cornerd=2;

module ruuvitorni() {
  difference() {
    union() {
      roundedcylinder(topoutd,h,cornerd,1,6);
      hull() {
	roundedcylinder(topoutd,max(wall,h/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
	translate([0,-handlew/2,0]) roundedbox(handlel,handlew,wall,cornerd,1);
      }
    }

    translate([0,0,-0.01]) cylinder(d=screwholed,h=h+0.02,$fn=90);
  }
}

ruuvitorni();

