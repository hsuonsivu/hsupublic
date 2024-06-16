// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

use <hsu.scad>

debug=0;

$fn=90;

height=25;//17;
edge=89.6;
uray=10;
urah=5;
wall=urah/2;
outsider=3; //5;
insider=urah/2;//6.5;
insideh=height-outsider/2;

textdepth=1;
textsize=15;

module insidecut(x,y,h,d) {
  hull() {
    translate([d/2,d/2,0]) cylinder(r=d/2,h=h);
    translate([d/2,y-d/2,0]) cylinder(r=d/2,h=h);
    translate([x-d/2,d/2,0]) cylinder(r=d/2,h=h);
    translate([x-d/2,y-d/2,0]) cylinder(r=d/2,h=h);
  }
}

module kansi() {
  difference() { 
    roundedbox(edge,edge,height,outsider*2);
    translate([wall,wall,-0.01]) insidecut(edge-wall*2,edge-wall*2,insideh,insider*2);
    translate([0,0,insideh-uray]) {
      hull() {
	translate([wall+1,wall+1,0]) sphere(d=urah);
	translate([wall+1,edge-wall-1,0]) sphere(d=urah);
	translate([edge-wall-1,wall+1,0]) sphere(d=urah);
	translate([edge-wall-1,edge-wall-1,0]) sphere(d=urah);
      }
    }
if (debug) translate([outsider*2,-0.01,-0.01]) cube([edge-outsider*2+1,edge+1,height+2]);

translate([edge/2,edge/2,height-textdepth+0.01]) linear_extrude(height=textdepth) text("TOWER",size=textsize,halign="center",valign="center");
  }
}

if (debug)
  kansi();
else
  translate([0,0,height]) rotate([180,0,0]) kansi();
