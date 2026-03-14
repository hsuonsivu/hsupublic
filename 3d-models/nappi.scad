// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

l=2.1;
w=3.1;
h=11;
depth=4.5;

d=6.5;

outd=10;
outh=4;

cornerd=2;

textsize=7;
textdepth=0.7;

module nappi(t) {
  difference() {
    union() {
      roundedcylinder(outd,outh,cornerd,1,90);
      roundedcylinder(d,h,cornerd,1,90);
    }
    translate([-l/2,-w/2,h-depth]) cube([l,w,depth+0.01]);

    translate([0,0,textdepth-0.01]) rotate([180,0,90]) linear_extrude(height=textdepth) text(t,size=outd-cornerd*2,halign="center",valign="center");
  }
}

nappi("R");

translate([outd+0.5,0,0]) nappi("P");


  
