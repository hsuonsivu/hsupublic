// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

handled=31;
wall=2.5;
handleh=142;
bottomh=3.5;
ribd=2;
bottomd=handled+ribd*2+ribd*2;
cornerd=2;
ribh=handleh-wall;
ribs=10;
ribsink=0.5;

module handle() {
  difference() {
    union() {
      roundedcylinder(bottomd,bottomh,cornerd,1,90);
      roundedcylinder(handled+wall*2,handleh,cornerd,1,90);
      for (a=[0:360/ribs:359]) {
	rotate([0,0,a]) {
	  translate([handled/2+wall-ribsink,0,0]) roundedcylinder(ribd,ribh,ribd,1,90);
	}
      }
    }

    translate([0,0,wall]) roundedcylinder(handled,handleh,cornerd,0,90);
  }
}

handle();
