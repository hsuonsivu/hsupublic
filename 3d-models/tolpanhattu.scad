// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;

baseh=20;
edge=5;
edgedrop=1;
toph=20;
cornerd=1;
wall=2;
adhesion=1;
adhesionh=0.2;
adhesiongap=0.075;
ruuvid=4.2;
ruuvitornid=ruuvid*3;
ruuvil=20;
$fn=30;
tolppaoutd=49+2*wall;
angle=atan2(toph+edgedrop-cornerd/2,tolppaoutd+edge*2+cornerd/2);
echo(angle);
	   
module tolpanhattu() {
  difference() {
    union() {
      translate([-tolppaoutd/2,-tolppaoutd/2,0]) roundedbox(tolppaoutd,tolppaoutd,baseh,cornerd);
      hull() {
	for (x=[-tolppaoutd/2,tolppaoutd/2]) {
	  translate([x+sign(x)*(edge-cornerd/2),-tolppaoutd/2-edge+cornerd/2,baseh+cornerd/2-edgedrop]) sphere(d=cornerd);
	  translate([x+sign(x)*cornerd/2,-tolppaoutd/2+cornerd/2,baseh]) sphere(d=cornerd);
	}
	translate([0,tolppaoutd/2+edge-cornerd/2,baseh-cornerd/2+toph]) sphere(d=cornerd);
      }
      
      hull() {
	for (y=[-tolppaoutd/2,tolppaoutd/2]) {
	  translate([-tolppaoutd/2-edge+cornerd/2,y+sign(y)*(edge-cornerd/2),baseh+cornerd/2-edgedrop]) sphere(d=cornerd);
	  translate([-tolppaoutd/2+cornerd/2,y-cornerd/2,baseh]) sphere(d=cornerd);
	}
	translate([0,tolppaoutd/2+edge-cornerd/2,baseh-cornerd/2+toph]) sphere(d=cornerd);
      }

      hull() {
	for (y=[-tolppaoutd/2,tolppaoutd/2]) {
	  translate([tolppaoutd/2+edge-cornerd/2,y+sign(y)*(edge-cornerd/2),baseh+cornerd/2-edgedrop]) sphere(d=cornerd);
	  translate([tolppaoutd/2-cornerd/2,y,baseh]) sphere(d=cornerd);
	}
	translate([0,tolppaoutd/2+edge-cornerd/2,baseh-cornerd/2+toph]) sphere(d=cornerd);
      }

      hull() {
	for (x=[-tolppaoutd/2,tolppaoutd/2]) {
	  translate([x-sign(x)*cornerd/2,tolppaoutd/2-cornerd/2,baseh]) sphere(d=cornerd);
	}
	translate([-tolppaoutd/2,-tolppaoutd/2,baseh]) cube([tolppaoutd,tolppaoutd,1]);
	translate([0,tolppaoutd/2+edge-cornerd/2-2,baseh-cornerd/2+toph-1]) sphere(d=cornerd);
      }
    }

    translate([-tolppaoutd/2+wall,-tolppaoutd/2+wall,-0.01]) cube([tolppaoutd-wall*2+0.01,tolppaoutd-wall*2,0.01+baseh+0.01]);
    translate([0,-tolppaoutd/2+ruuvil,baseh/2]) rotate([90,0,0]) ruuvireika(ruuvil,ruuvid,0);
  }
}

module ruuvitorni(height,diameter) {
  cylinder(h=height,d=diameter,$fn=6);
  translate([0,0,-diameter/3+0.01]) cylinder(h=diameter/3,d2=diameter,d1=diameter*0.6,$fn=6);
}

if (print==0) {
  tolpanhattu();
 }

if (print==1) {
  intersection() {
    union() {
      for (x=[-tolppaoutd/2-edge-ruuvitornid/2,tolppaoutd/2+edge+ruuvitornid/2]) {
	translate([0,0,ruuvil]) rotate([180,0,0]) translate([x+sign(x),0,0]) {
	  difference() {
	    ruuvitorni(ruuvil,ruuvitornid);
	    translate([0,0,+0.01]) ruuvireika(ruuvil,ruuvid,0);
	  }
	}
      }
    
      rotate([180-angle,0,0]) translate([0,0,-toph+edgedrop-baseh/2-cornerd]) tolpanhattu();
    }
  }
 }
