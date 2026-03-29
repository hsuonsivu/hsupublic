// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

angle=10.6;

wall=2.4;
cornerd=wall*2;

// Bottom is a flattened
bottomw=20.6; //20.4;
bottomh=19;
bottomx=0;

midw=20;//19.4;
midh=19;
midx=23;

loww=19.7;
lowh=18.39;
lowx=14;

flatw=19.8;//19.4;
flath=18.9;
flatx=30-cornerd/2; // Take minkowski into account

table=[[bottomx,bottomw,bottomh],
       [lowx,loww,lowh],
       [midx,midw,midh],
       [flatx,flatw,flath]
       ];
	
// Tube is not perfectly round, approximately 19mm.
tubed=19; // Not used

module lowplugform(w) {
  minkowski() {
    if (w) hull() {
	sphere(d=cornerd,$fn=30);
	translate([0,0,-cornerd/2]) cylinder(d=cornerd/2,h=cornerd/2,$fn=30);
      }
    difference() {
      union() {
	for (i=[0:1:len(table)-2]) {
	  hull() {
	    translate([0,0,table[i][0]-0.05]) resize([table[i][2],table[i][1],0.1]) cylinder(d=tubed,h=0.1,$fn=90);
	    translate([0,0,table[i+1][0]-0.05]) resize([table[i+1][2],table[i+1][1],0.1]) cylinder(d=tubed,h=0.1,$fn=90);
	    if ((w==0) && (i==len(table)-2)) 
	      translate([0,0,table[i+1][0]+wall-0.05]) resize([table[i+1][2]+wall,table[i+1][1]+wall,0.1]) cylinder(d=tubed,h=0.1,$fn=90);
	  }
	}
      }
      translate([-lowh/2,0,lowx]) rotate([0,-angle,0]) translate([-lowh,-loww,-lowx*2]) cube([lowh,loww*2,lowx*2+flatx]);
    }
  }
}

module lowplug() {
  difference() {
    lowplugform(wall);
    lowplugform(0);

    // Cut angle... XXX */
  }
}

lowplug();
