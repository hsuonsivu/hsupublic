// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Diameter test set

print=1;

diametertable=[20,25,30,31,32,33,34,35,36,37,38,39,40,41,42,0];

textsize=7;
textdepth=0.7;

axled=8.5;
ringh=1.8;
wall=2.4;

module diameterring(d) {
  difference() {
    union() {
      hull() {
	translate([wall+axled/2,0,0]) cylinder(d=axled+wall,h=ringh);
	translate([wall+axled/2+1+textsize+1+axled/2+d/2,0,0]) cylinder(d=d+wall,h=ringh);
      }
    }

    translate([wall+axled/2,0,-0.01]) cylinder(d=axled,h=ringh+0.2);
    translate([wall+axled/2+1+textsize+1+axled/2+d/2,0,-0.01]) cylinder(d=d,h=ringh+0.2);
    translate([wall+axled/2+1+textsize/2+axled/2,0,ringh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text(str(d),font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
  }
}

module ringrecurse(i,end,distance,angle) {
  if (i < end) {
    rotate([0,0,angle]) {
      translate([distance,0,0]) diameterring(diametertable[i]);
    }
    newangle=angle+i+360/6-(i>6?11:3);
    ringrecurse(i+1,end,distance,newangle);
  }
}

if (print==1) ringrecurse(0,6,axled/2+wall,0);

if (print==2) ringrecurse(6,12,axled/2+wall,0);

if (print==3) ringrecurse(12,15,axled/2+wall,0);
