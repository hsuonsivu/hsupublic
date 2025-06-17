// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

l=30;
w=11;
hl=4;
hu=3.5;
cabled=5;
cablesquishratio=0.7;
cornerd=1;
screwd=3.5;
screwl=25;
screwtowerd=w-cornerd; // screwd*3;

versiontext="V1";
textdepth=0.7;
textsize=6;

module vedonpoistaja(l,w,h,d,upper) {
  difference() {
    minkowski(convexity=2) {
      union() {
	difference() {
	  translate([-l/2+cornerd/2,-w/2+cornerd/2,cornerd/2]) cube([l-cornerd,w-cornerd,h-cornerd]);
	  translate([0,-w/2,upper?0:h]) scale([1/cablesquishratio,1,cablesquishratio]) rotate([-90,0,0]) cylinder(d=cabled,h=w,$fn=30);
	}
      }
      rotate([upper?180:0,0,0]) hull() {
	translate([0,0,-cornerd/2]) cylinder(d=cornerd/2,h=0.1,$fn=30);
	sphere(d=cornerd,$fn=30);
      }
    }

    for (x=[-l/2+w/2,l/2-w/2]) translate([x,0,-screwl]) ruuvireika(screwl+(upper?hu:hl)+0.01,screwd,upper?1:0);
    
    translate([0,0,upper?h-textdepth+0.01:textdepth-0.01]) rotate([upper?0:180,0,0]) linear_extrude(height=textdepth+0.02) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

vedonpoistaja(l,w,hl,cabled,0);
translate([0,w+0.5,hu]) rotate([180,0,0]) vedonpoistaja(l,w,hu,cabled,1);

