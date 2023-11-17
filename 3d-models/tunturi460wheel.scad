// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Replacement for Tunturi E430 exercise bike moving wheels, which
// tend to break up with age.

// 1: make model easier to print with no supports. This is
// particularly useful when printing with TPU which does not stick
// well to the bed. The down side is that the resulting wheel is not
// symmetric like the original.
supports=1;

// Cut model to see the profile, mostly used for debugging.
leikkaa=0;
$fn=180;

bearingoutdiameter=22.25; //21.95;
bearingaxlediameter=13.40; //12.56;
bearingaxle=10.8; //11.29;
wheeldiameter=23.45*2+bearingaxlediameter;
wheelwidth=38;
wheelballd=8;
wheelballdiameter=wheeldiameter-wheelballd;
bearingwidth=7;
wheelthickness=6;
ballcutd=30;
ballcutposition=bearingaxle/2+bearingwidth+ballcutd/2-2;

echo("Wheel diameter ",wheeldiameter);

module wheel() {
  difference() {
    union() {
      translate([0,0,-bearingaxle/2]) cylinder(h=bearingaxle,d=bearingoutdiameter);
      rotate_extrude() translate([wheelballdiameter/2-wheelballd/2,0,0]) hull() {
	translate([0,wheelwidth/2-wheelballd,0]) circle(wheelballd);
	if (supports) {
	  translate([4,-wheelwidth/2+0.01,0]) square(1);
	}
	translate([-bearingaxle,-wheelwidth/2+0.01,0]) square(1);
	translate([0,-wheelwidth/2+wheelballd,0]) circle(wheelballd);
	translate([-wheelthickness,wheelwidth/2-wheelballd,0]) circle(wheelballd);
	translate([-wheelthickness,-wheelwidth/2+wheelballd,0]) circle(wheelballd);
      }
    }
    translate([0,0,-bearingaxle/2]) cylinder(h=bearingaxle+1,d=bearingaxlediameter);
    translate([0,0,-bearingaxle/2-(bearingwidth+wheelwidth/2)+0.01]) cylinder(h=(bearingwidth+wheelwidth/2),d=bearingoutdiameter);
    translate([0,0,bearingaxle/2]) cylinder(h=bearingwidth+wheelwidth/2,d=bearingoutdiameter);
    translate([0,0,ballcutposition+ballcutd/2]) sphere(ballcutd);
    if (!supports) {
      translate([0,0,-ballcutposition-ballcutd/2]) sphere(ballcutd);
    }
    translate([0,0,-wheelwidth/2]) cylinder(h=wheelwidth/2-bearingaxle/2-bearingwidth,d1=bearingoutdiameter+(wheelwidth/2-bearingaxle/2-bearingwidth),d2=bearingoutdiameter);
    #translate([0,0,bearingaxle/2]) cylinder(h=bearingwidth,d=bearingoutdiameter);
    #translate([0,0,-bearingaxle/2-bearingwidth]) cylinder(h=bearingwidth,d=bearingoutdiameter);
    translate([0,0,-bearingaxle/2-0.01]) cylinder(h=bearingwidth/2,d1=bearingoutdiameter,d2=bearingaxlediameter);
  }
}

if (leikkaa) {
  difference() {
    wheel();
    translate([-wheeldiameter/2,0,-wheelwidth/2-0.01]) cube([wheeldiameter,wheeldiameter,wheelwidth+0.02]);
  }
 } else wheel();

  
