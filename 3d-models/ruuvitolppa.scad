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
ruuvitolppah=10;
wall=2;
cornerd=2;
screwtolppad=3;
screwtolppah=2;

mbtowerd=5.4;
mbtowerh=6.2;
barl=23;

module ruuvitolppa() {
  difference() {
    union() {
      roundedcylinder(topoutd,ruuvitolppah,cornerd,1,6);
      hull() {
	roundedcylinder(topoutd,max(wall,ruuvitolppah/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
	translate([0,-handlew/2,0]) roundedbox(handlel,handlew,wall,cornerd,1);
      }
      translate([0,0,0]) roundedcylinder(screwtolppad,ruuvitolppah+screwtolppah,screwtolppad,0,90);
    }
  }
}

ruuvitolppa();

