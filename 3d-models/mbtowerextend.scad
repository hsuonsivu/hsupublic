// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

screwholed=3.2; // Slightly below 3.4 measured from outside
topoutd=7/cos(180/6);
bottomoutw=7;
bottomoutd=7/cos(180/6);
handlel=25; // Bar protruding out
handlew=bottomoutw;
mbthickness=1.65;
h=8.5-mbthickness;
//h=6.15;//10;
wall=2;
cornerd=2;
screwtolppad=3;
screwtolppah=2;
mbsupportw=15;

mbtowerd=5.4;
mbtowerh=6.15;
mbtowerattachd=mbtowerd+wall*2+dtolerance;
mbtowerattachh=mbtowerh+ztolerance;

barl=23-mbtowerattachd/2;
towerx=barl;

module mbtowerextend() {
  difference() {
    union() {
      //roundedcylinder(topoutd,h,cornerd,1,6);
      translate([-topoutd/2,-mbsupportw/2,0]) roundedbox(topoutd,mbsupportw,h,cornerd,1);
      hull() {
	translate([-wall,-mbsupportw/2,h+mbthickness+wall]) roundedbox(topoutd/2+wall,mbsupportw,cornerd,cornerd,1);
	translate([0,-mbsupportw/2,h+mbthickness]) roundedbox(topoutd/2,mbsupportw,wall,cornerd,1);
      }
      translate([0,-mbsupportw/2,0]) roundedbox(topoutd/2,mbsupportw,h+mbthickness+wall,cornerd,1);
      translate([towerx,0,0]) roundedcylinder(mbtowerattachd,mbtowerh+ztolerance+wall*2,cornerd,1,90);
      
      hull() {
	roundedcylinder(topoutd,max(wall,h/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	//roundedcylinder(bottomoutd,wall,cornerd,1,6);
	translate([-topoutd/2,-mbsupportw/2,0]) roundedbox(topoutd,mbsupportw,wall,cornerd,1);
	translate([towerx,0,0]) roundedcylinder(mbtowerattachd,wall,cornerd,1,90);
	translate([0,-handlew/2,0]) roundedbox(barl,handlew,wall,cornerd,1);
      }
      //      translate([0,0,0]) roundedcylinder(screwtolppad,h+screwtolppah,screwtolppad,0,90);
    }

    //    translate([0,0,-0.01]) cylinder(d=screwholed,h=h+0.02,$fn=90);
    hull() {
      translate([towerx,0,-0.01]) cylinder(d=mbtowerd+dtolerance,h=mbtowerattachh+0.01,$fn=90);
      translate([towerx,0,-0.01]) cylinder(d=screwholed,h=mbtowerattachh+wall+0.02,$fn=90);
    }
    translate([towerx,0,-0.01]) cylinder(d=screwholed,h=mbtowerattachh+wall*2+0.02,$fn=90);

    //translate([-topoutd/2-0.01,-mbsupportw/2-0.01,h]) roundedbox(topoutd,mbsupportw,h+mbthickness+wall,cornerd,1);
  }
}

mbtowerextend();

