// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

diameter=120;
thickness=1.2;
w=0.8;
edgethickness=2;
edgew=0.8;
$fn=90;

versiontext="v1.0";
textsize=7;
textdepth=1;

cornerd=1;

handlel=200;
handlew=20;
handlethickness=3;
handledistance=20; // from diameter
handlethicknesscenter=2;
holdl=100;
holdthickness=8;
holdcornerd=8;

hangholed=handlew/2-1;
hangholel=handlew;
hangholex=diameter/2+handledistance+handlel+holdl-hangholel-15;
dstart=5;
ddistance=8;

//diametertable=[2,5,11];
//dividertable=[1,2,4];

module flyswatter() {
  difference() {
    union() {
      hull() {
	cylinder(d=diameter,h=edgethickness);
	translate([diameter/2+handledistance,-handlew/2,0]) cube([1,handlew,handlethickness]);
      }
      
      hull() {
	translate([diameter/2+handledistance-0.1,-handlew/2,0]) roundedbox(handlel,handlew,handlethickness,cornerd);
	translate([diameter/2+handledistance+handlel,-handlew/2,0]) roundedbox(holdl,handlew,holdthickness,holdcornerd);
      }
    }
    translate([0,0,-0.1]) cylinder(d=diameter-edgew*2,h=handlethickness+0.01);

    hull() {
      translate([hangholex,0,-1]) cylinder(d=hangholed,h=holdthickness+2);
      translate([hangholex+hangholel,0,-1]) cylinder(d=hangholed,h=holdthickness+2);
    }

    translate([hangholex-len(versiontext)*textsize,0,holdthickness-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center");
  }

  for (d=[dstart:ddistance:diameter-w*2]) {
    ring(d,w,thickness);

    for (a=[0:360/d:359]) {
      rotate([0,0,a]) translate([d/2-w,-w/2,0]) cube([min(ddistance/2+w-0.1,diameter/2-d/2+w/2),w,thickness]);
    }
  }
}

flyswatter();

