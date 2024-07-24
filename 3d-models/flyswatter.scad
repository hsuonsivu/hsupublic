// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

diameter=120;
thickness=1.2;
w=0.8;
edgethickness=2;
edgew=0.8;

cornerd=1;

handlel=200;
handlew=20;
handlethickness=3;
handledistance=20; // from diameter
handlethicknesscenter=2;
holdl=100;
holdthickness=8;
holdcornerd=8;

dstart=5;
ddistance=6;

diametertable=[2,5,11];
dividertable=[1,2,4];

module flyswatter() {
  difference() {
    hull() {
      cylinder(d=diameter,h=edgethickness);
      translate([diameter/2+handledistance,-handlew/2,0]) cube([1,handlew,handlethickness]);
    }
    translate([0,0,-0.1]) cylinder(d=diameter-edgew*2,h=handlethickness+0.01);
  }

  hull() {
    translate([diameter/2+handledistance-0.1,-handlew/2,0]) roundedbox(handlel,handlew,handlethickness,cornerd);
    translate([diameter/2+handledistance+handlel,-handlew/2,0]) roundedbox(holdl,handlew,holdthickness,holdcornerd);
  }

  for (d=[dstart:ddistance:diameter-ddistance/2]) {
    ring(d,w,thickness);

    for (a=[0:360/d:359]) {
      rotate([0,0,a]) translate([d/2,-w/2,0]) cube([ddistance/2,w,thickness]);
    }
  }

  if (0) {  for (a=[0:30:360-1]) {
    rotate([0,0,a]) translate([0,-w/2,0]) cube([diameter/2,w,thickness]);
  }

  for (i=[0:1:2]) {
    d=dstart/2+diametertable[i]*ddistance/2;
    for (a=[15/dividertable[i]:30/dividertable[i]:360-1]) {
      rotate([0,0,a]) translate([d,-w/2,0]) cube([diameter/2-d,w,thickness]);
    }
  }
  }
}

flyswatter();

