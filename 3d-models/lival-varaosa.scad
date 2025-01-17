// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
dtolerance=0.6;

maind=18.5;
mainbodyw=12.95;
mainprikkad=8.8;
mainprikkah=0.75;
mainholed=4.5;
halfthickness=5;
lampaxled=7.25;
lampaxlew=lampaxled/3;
lampaxleoutd=11;
lampaxlel=18.25;
lampaxlenotch=13.4;
lampaxlenotchh=8.6;
lampaxlenotchl=5;
lampaxlenotchroot=3;
lampaxlenotchoffset=-1;
lampaxlenotchend=2.5;
lampaxlecenter=lampaxled/2;
cornerd=1;

$fn=(print==1)?60:30;

module livallampattachment() {
  difference() {
    minkowski(convexity=10) {
      sphere(d=cornerd);
      union() {
	intersection() {
	  translate([0,0,-halfthickness+cornerd/2]) cylinder(d=maind-cornerd,h=halfthickness*2-cornerd);
	  translate([-maind/2+cornerd/2,-mainbodyw/2+cornerd/2,-halfthickness+cornerd/2]) cube([maind-cornerd,mainbodyw-cornerd,halfthickness*2-cornerd]);
	}

	intersection() {
	  translate([lampaxled/2,-mainbodyw/2-0.1,0]) rotate([-90,0,0]) cylinder(d=lampaxleoutd-cornerd,h=mainbodyw-cornerd/2+0.2);
	  translate([-maind/2+cornerd/2,-mainbodyw/2+cornerd/2,-halfthickness+cornerd/2]) cube([maind-cornerd,mainbodyw-cornerd,halfthickness*2-cornerd]);
	}

	hull() {
	  translate([-lampaxlenotchroot+lampaxlenotchoffset+cornerd/2,-mainbodyw/2+cornerd/2,-lampaxlenotchh/2+cornerd/2]) cube([lampaxlenotchroot-cornerd/2,mainbodyw/2-cornerd/2,lampaxlenotchh-cornerd]);
	  translate([-lampaxlenotchend+lampaxlenotchoffset+cornerd/2,-mainbodyw/2-lampaxlenotchl+cornerd/2,-lampaxlenotchh/2+cornerd/2]) cube([lampaxlenotchend-cornerd/2,lampaxlenotchl+mainbodyw/2-cornerd/2,lampaxlenotchh-cornerd]);
	  translate([lampaxled/2-0.5,-mainbodyw/2-lampaxlenotchl+cornerd/2,0]) rotate([-90,0,0]) cylinder(d=0.1,h=lampaxlenotchl+mainbodyw/2-cornerd/2);
	}
      }
    }
    
    translate([0,0,-halfthickness-0.1]) cylinder(d=mainholed,h=halfthickness*2+0.2);
    translate([0,0,halfthickness-mainprikkah]) cylinder(d=mainprikkad,h=mainprikkah+0.1);
    hull() {
      translate([lampaxled/2,-mainbodyw/2-lampaxlenotchl-0.1,0]) rotate([-90,0,0]) cylinder(d=lampaxled,h=mainbodyw+lampaxlenotchl+0.2);
      translate([lampaxled/2-lampaxlew/2,-mainbodyw/2-lampaxlenotchl-0.1,-lampaxled/2]) cube([lampaxlew,mainbodyw+lampaxlenotchl+0.2,lampaxled]);
    }
  }
}

if (print==0) livallampattachment();

if (print==1) {
  translate([0,0,0]) rotate([180,0,0]) intersection() {
    livallampattachment();
    translate([-maind/2,-mainbodyw/2-lampaxlenotchl,-halfthickness]) cube([maind,mainbodyw+lampaxlenotchl*2,halfthickness]);
  }

  translate([maind+1,0,0]) intersection() {
    livallampattachment();
    translate([-maind/2,-mainbodyw/2-lampaxlenotchl,0]) cube([maind,mainbodyw+lampaxlenotchl*2,halfthickness*2]);
  }
 }
