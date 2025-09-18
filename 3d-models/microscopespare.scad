// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

wall=2;
cornerd=1;

dtop=9.4;
outdtop=dtop+wall*2;
dbottom=dtop+0.2;
outdbottom=dbottom+wall*2;
h=6.5;//+wall;

screwd=2.92+0.4;

screwl=17.9;
screwbased=5.5;

module microscopespare() {
  intersection() {
    difference() {
      union() {
	hull() {
	  roundedcylinder(outdtop,h,cornerd,1,90);
	  roundedcylinder(outdbottom,h,cornerd,1,90);
	}
      }
      hull() {
	translate([0,0,wall]) roundedcylinder(dtop,h-wall+cornerd/2,cornerd,0,90);
	translate([0,0,h-cornerd/2]) roundedcylinder(dbottom,cornerd,cornerd,0,90);
      }
      translate([0,0,-0.01]) cylinder(d=screwd,h=wall+0.02,$fn=60);

      // Make part narrower in one side to fit
    }
    
    translate([-outdbottom/2+wall/2,-outdbottom/2,0]) cube([outdbottom,outdbottom,h]);
  }
}

microscopespare();
