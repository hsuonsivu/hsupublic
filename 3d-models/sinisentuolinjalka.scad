// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

//
// height=z
$fn=90;

// Notice not angled
totalheight=22;
throughholediameter=4;

// Plug to chair feet
insidediameter=15.63 + 0.9;
outsidediameter=19.5;
plugheight=10;

// angled part
// bottomnarrowdiameter=23.8;
bottomnarrowdiameter=27.0;
bottomnarrowheight=1.69;
bottomwidestdiameter=29.33;
bottomnarrowestdiameter=15;
correction=2.8;
bottomheight=12.97 - correction;
bottomcylinderheight=16.9-bottomheight - correction;

angle=90-83.7;

// "ball"
equatorheight=4.23;

module jalka()
{difference() {
    union()
    {
      cylinder(h=10+0.01,d=insidediameter);
      translate([0,0,plugheight]) cylinder(h=equatorheight,d=outsidediameter);
      translate([0,0,plugheight+equatorheight]) difference() {
	sphere(d=outsidediameter);
	translate([0,0,-outsidediameter-0.01]) cylinder(h=outsidediameter,d=outsidediameter);
      }
      translate([0,0,plugheight+equatorheight]) rotate(a=[angle,0,0]) {
	cylinder(h=bottomheight+0.001,d1=bottomnarrowestdiameter,d2=bottomwidestdiameter);
	translate([0,0,bottomheight]) cylinder(h=bottomcylinderheight,d=bottomwidestdiameter);
	translate([0,0,bottomheight+bottomcylinderheight-0.001]) cylinder(h=bottomnarrowheight+0.001,d1=bottomwidestdiameter,d2=bottomnarrowdiameter);
      }
    }
    translate([0,0,-0.001]) cylinder(h=totalheight*2,d=throughholediameter);
  }
}

rotate([180-angle,0,0]) jalka();

