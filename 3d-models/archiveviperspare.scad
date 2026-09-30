// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

debug=0;

h=7.4;
d=12;
ind=8.92;
outd=8.9;
inh=5;

midslope=(ind-outd)/2;
slopeh=inh+midslope*h;

thickness=(d-ind)/2;

$fn=180;

translate([0,0,h/2]) intersection() {
  if (debug) translate([-100,0,-100]) cube([200,200,200]);
  
  union() {
    difference() {
      union() {
	translate([0,0,-h/2]) cylinder(d=d,h=h);
      }

      translate([0,0,-h/2-0.01]) cylinder(d=outd,h=h+0.02);
      hull() {
	translate([0,0,-inh/2]) cylinder(d=ind,h=inh);
	translate([0,0,-slopeh/2]) cylinder(d=outd,h=slopeh);
      }
    }
  }
}

//ring(d,thickness,7,0,180);
