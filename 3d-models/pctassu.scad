// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

kantad=8.5;
screwd=3.5;
//d=8.5+6*2;
d=20;
bottomd=d-3;

belowscrew=0.8; // Likely too small
h=10;
$fn=90;
largecornerd=3;
cornerd=1;
  
difference() {
  hull() {
    roundedcylinder(d,largecornerd,largecornerd,1,90);
    roundedcylinder(bottomd,h,largecornerd,1,90);
  }
  translate([0,0,-0.1]) cylinder(d=screwd,h=h+0.2);
  translate([0,0,belowscrew]) roundedcylinder(kantad,h+0.2,cornerd,0,90);
}
