// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

width=105;
length=37.5;
depth=12;//12;
edge=2;
screww=69.2;
screwholed=4.4;
screwbarl=4;
endd=65;
endcornerd=12;
cornerd=1;
wall=2;
sidey=-3;
drainholew=width-20;

module shape(w,h) {
  hull() {
    intersection() {
      union() {
	hull() {
	  for (m=[0,1]) mirror([0,m,0]) {
	      translate([0,-width/2+endd/2,0]) roundedcylinder(endd+2*w,h,cornerd,1,90);
	    }
	}
      }

      translate([-length/2+endcornerd/3-w,-width/2-w,0]) cube([length-endcornerd*2/3+2*w,width+w*2,h]);
    }

    translate([-length/2-w,-width/2+sidey+endcornerd/2-w*0.6,0]) roundedboxxyz(length+2*w,width-sidey*2-endcornerd+w*2*0.6,h,endcornerd,cornerd,1,90);
  }
}

module markerlampbase() {
  difference() {
    shape(wall,depth+wall);
    translate([0,0,depth]) shape(0,wall+cornerd);
    translate([0,0,-cornerd/2]) shape(-wall,depth+cornerd);

    for (m=[0,1]) mirror([0,m,0]) {
	translate([-length/2-wall-0.1,-drainholew/2,-0.01]) cube([length/2,wall,wall]);
      }
  }

  // Screw towers
  for (m=[0,1]) mirror([0,m,0]) {
      difference() {
	union() {
	  translate([0,-screww/2,0]) roundedcylinder(screwholed*2+wall,depth,cornerd,1,90);
	  translate([-screwbarl/2,-width/2,0]) roundedbox(screwbarl,(width-screww)/2,depth,cornerd,1);
	}

	translate([0,-screww/2,-0.01]) cylinder(d=screwholed,h=depth+0.02,$fn=60);
      }
  }
}


markerlampbase();
