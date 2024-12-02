// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;

$fn=print==1?60:12;

slots=5;
length=100;
width=15;
height=6;
slotd=16;
largecornerd=5;
topd=min(width/1.5,largecornerd*2);
cornerd=1;
distancefromedge=8;
step=(length-distancefromedge*2)/slots;
first=-length/2+distancefromedge+step/2;
last=length/2-distancefromedge-step/2;
textsize=width/2.5;
textdepth=1;

module rawteline() {
  translate([0,0,0]) {
    difference() {
      hull() {
	translate([-length/2+largecornerd/2,-width/2+largecornerd/2,0]) roundedbox(length-largecornerd,width-largecornerd,cornerd,cornerd);
	translate([-length/2+largecornerd/2,0,height-largecornerd/2]) rotate([0,90,0]) cylinder(d=topd-largecornerd,h=length-largecornerd);
      }

      for (x=[first:step:last]) {
	translate([x,-width/2,height+largecornerd/2]) rotate([-90,0,0]) cylinder(d=slotd,h=width);
      }
    }
  }
}

module teline() {
  difference() {
    union() {
      translate([0,0,largecornerd/2]) minkowski(convexity=10) {
	sphere(d=largecornerd);
	rawteline();
      }
      hull() {
	translate([-length/2,-width/2,0]) roundedbox(length,width,largecornerd,largecornerd);
#	translate([-length/2+largecornerd/4,-width/2+largecornerd/4,0]) roundedbox(length-largecornerd/2,width-largecornerd/2,cornerd,cornerd);
      }
    }
    #    translate([0,0,-0.01]) linear_extrude(textdepth) rotate([180,0,0]) text("Lempi",size=textsize,halign="center",valign="center");
  }
}

translate([0,0,0]) teline();

