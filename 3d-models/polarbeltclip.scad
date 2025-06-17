// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// If you do not want to break the belt loop, this will open belt
// slots so that the belt can be inserted without cutting and
// reattaching.
openbelt=1;

extral=2;

clipw=40; //35;
clipl=21.8+extral; //21.8;
beltw=29.3;
belth=1.3; // This is belt opening thickness
cliph=4.4;
beltspacetoph=0; // 1.9; (would not be printable without supports)
beltspacebottomh=2.5;
beltspacebottoml=5.5;
clipzcornerd=3;
clipxycornerd=5;

barw=7;
barh=2.3;
barl=36+extral;
barcornerd=1;

cyld=14.5;
cylnarrowd=13.29;
cylh=2.3;
cylcornerd=1;

beltholesl=12.9;

belthole1x=4.3;
belthole1l=belth;
belthole1h=cliph;

belthole2l=belth;
belthole2h=cliph;
belthole2x=belthole1x+beltholesl-belthole2l;

beltholecornerd=3;

cornerd=1;

module cyl(dx,dy,h) {
  scale([1,dy/dx,1]) roundedcylinder(dx,h,cylcornerd,1,30);  
}

module polarbeltclip() {
  // Clip body
  difference() {
    union() {
      translate([0,-clipw/2,0]) roundedboxxyz(clipl,clipw,cliph,clipxycornerd,clipzcornerd,1,30);
      
      // Bar connecting to cylinder
      translate([clipzcornerd/2,-barw/2,cliph-barh]) roundedbox(barl-clipzcornerd/2,barw,barh,barcornerd);

      // Cylinder 
      translate([barl,0,0]) cyl(cyld,cylnarrowd,cylh); //roundedcylinder(cyld,cylh,cylcornerd,1,30);
      intersection() {
	translate([barl,0,0]) cyl(cyld,cylnarrowd,cliph);
	translate([barl-cyld/2,-barw/2,0]) roundedbox(cyld,barw,cliph,cylcornerd);
      }
    }
    translate([-0.1,-clipw/2-0.1,cliph-beltspacebottomh]) cube([beltspacebottoml,clipw+0.2,beltspacebottomh]);
    translate([belthole1x,-beltw/2,-0.1]) cube([beltholesl,beltw,cliph+0.2]);

    if (openbelt) {
      // Cut openings
      //translate([belthole1x,-clipw/2,-0.1]) cube([belthole1l,beltw,cliph+0.2]);
      //translate([belthole2x,-clipw/2,-0.1]) cube([belthole2l,beltw,cliph+0.2]);
      translate([-0.1,-beltw/8,-0.1]) cube([belthole1x+0.2,beltw/4,cliph+0.2]);
    }
  }
  difference() {
    translate([belthole1x+belthole1l,-beltw/2-beltholecornerd/2,0]) roundedbox(beltholesl-belthole1l-belthole2l,beltw+beltholecornerd,cliph-beltspacetoph,beltholecornerd,1);
    translate([-0.1,-belth,-0.1]) cube([belthole2x+belthole2l+0.1,belth*2,cliph+0.2]);
  }
}

polarbeltclip();
