// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

w=26.7;
l=160;
h=7;
diameter=33*2;
edgediameter=4.7;
screwhole=33;
lockslot=39;
lockslotd=3;
toproundingd=w;
cornerd=2;
screwd=6;

module lukituspala() {
  difference() {
    wsf=(w-cornerd)/w;
    hsf=(h-cornerd)/h;
    lsf=(l-cornerd)/l;
    translate([0,0,-cornerd/2])
    minkowski() {
      translate([0,0,cornerd]) scale([lsf,wsf,hsf]) intersection() {
	hull() {
	  translate([diameter/2,0,-h]) cylinder(d=diameter,h=h*2,$fn=90);
	  translate([l-diameter/2,0,-h]) cylinder(d=diameter,h=h*2,$fn=90);
	  //	translate([diameter/2,0,-h]) roundedcylinder(diameter,h*2,edgediameter,0,90);
	  //	translate([l-diameter/2,0,-h]) roundedcylinder(diameter,h*2,edgediameter,0,90);
	}

	//translate([0,-w/2,-h]) roundedboxxyz(l,w,h*2,edgediameter,edgediameter,0,30);
	translate([0,-w/2,0]) cube([l,w,h]);

	hull() {
	  translate([0,0,0]) scale([1,1,(h-1)*2/toproundingd]) rotate([0,90,0]) cylinder(d=toproundingd,h=l,$fn=180);
	  translate([0,0,1]) scale([1,1,(h-1)*2/toproundingd]) rotate([0,90,0]) cylinder(d=toproundingd,h=l,$fn=180);
	}
      }
      hull() {
	sphere(d=cornerd,$fn=60);
	translate([0,0,-cornerd/2]) cylinder(d=cornerd/2,h=cornerd/2,$fn=60);
      }
    }

    translate([screwhole,0,-0.01]) cylinder(d=screwd,h=h+0.02,$fn=60);
    hull() {
      translate([l-lockslot,0,-0.01]) cylinder(d=lockslotd,h=h+0.02,$fn=60);
      translate([l-lockslot,w/2+lockslotd,-0.01]) cylinder(d=lockslotd+1,h=h+0.02,$fn=60);
    }
  }
}

lukituspala();
translate([0,w+1,0]) mirror([0,1,0]) lukituspala();
