// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

versiontext="V1.0";
font="Liberation Sans:style=Bold";
textdepth=0.5;
textheight=10;
width=24.45;
thickness=3.18;
length=65;
notchwidth=2.17-0.8;
notchlength=1.67;
slotwidth=1.9;
slotposition=2.67;
slotlength=12;//9.6;
slotendholex=((slotposition+slotwidth) + 2.11) / 2;
slotenddiameter=2.83;
hangthickness=43;
hangwidth=width;
hanglength=8;
hangback=13;
hangposition=length-0;
hangsupportposition=length-hanglength;
hangsupportthickness=8;
smalld=min(notchwidth,notchlength,thickness);
cornerd=smalld;

$fn=36;

union() {
  difference() {
    union() {
      translate([0,-width/2,0]) roundedbox(length,width,thickness,cornerd,1);
     hull() {
	for (y=[-width/2,width/2-cornerd]) {
	  translate([hangsupportposition,y+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([hangsupportposition+hanglength,y+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([hangsupportposition+hanglength/2,y+cornerd/2,hangsupportthickness]) sphere(d=cornerd);
	  translate([hangsupportposition+hanglength,y+cornerd/2,cornerd/2]) sphere(d=cornerd);
	}
      }
      hull() {
	for (y=[-width/2,width/2-cornerd]) {
	  translate([hangsupportposition+hanglength/2,y+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([hangsupportposition+hanglength+1,y+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([hangsupportposition+hanglength/2-hangback,y+cornerd/2,hangthickness]) sphere(d=cornerd);
	  translate([hangsupportposition+hanglength-hangback,y+cornerd/2,hangthickness]) sphere(d=cornerd);
	}
      }
      
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([0,-width/2-notchwidth,0]) roundedbox(notchlength,notchwidth+cornerd,thickness,cornerd,1);
	}
    }

    for (m=[0,1]) mirror([0,m,0]) {
	translate([-0.01,-width/2+slotposition,-0.01]) cube([slotlength,slotwidth,thickness+0.02]);
	translate([slotlength,-width/2+slotposition+slotenddiameter/2,-0.01]) cylinder(h=thickness+0.02,d=slotenddiameter);
      }
  }
  //translate([0,width-1,0]) roundedbox(notchlength,notchwidth+1,thickness,cornerd);
}
