// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=7;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

screwholed=3.2; // Slightly below 3.4 measured from outside
topoutd=7/cos(180/6);
bottomoutw=7;
bottomoutd=7/cos(180/6);
bottomouthighd=25/cos(180/4);
handlel=25; // Bar protruding out
handlew=bottomoutw;
mbthickness=1.65;
mbh=8.5-mbthickness;
wall=2;
cornerd=2;
screwtolppad=3;
screwtolppah=2;
mbsupportw=15;
ruuvitolppah=10;
ruuvitornih=10;
ruuvitolppakorkeah=22;

mbtowerd=5.4;
mbtowerh=6.15;
mbtowerattachd=mbtowerd+wall*2+dtolerance;
mbtowerattachh=mbtowerh+ztolerance;

barl=21.5-mbtowerattachd/2;
towerx=barl;

module mbtowerextend() {
  difference() {
    union() {
      translate([-topoutd/2,-mbsupportw/2,0]) roundedbox(topoutd,mbsupportw,mbh,cornerd,1);
      hull() {
	translate([-wall,-mbsupportw/2,mbh+mbthickness+ztolerance+wall]) roundedbox(topoutd/2+wall,mbsupportw,cornerd,cornerd,1);
	translate([0,-mbsupportw/2,mbh+mbthickness+ztolerance]) roundedbox(topoutd/2,mbsupportw,wall,cornerd,1);
      }
      translate([0,-mbsupportw/2,0]) roundedbox(topoutd/2,mbsupportw,mbh+mbthickness+ztolerance+wall,cornerd,1);
      hull() {
	translate([towerx,0,0]) roundedcylinder(mbtowerattachd,mbtowerh+ztolerance+wall*2,cornerd,1,90);
	translate([towerx-1.5,0,0]) roundedcylinder(mbtowerattachd,cornerd,cornerd,1,90);
      }
      
      hull() {
	roundedcylinder(topoutd,max(wall,mbh/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	translate([-topoutd/2,-mbsupportw/2,0]) roundedbox(topoutd,mbsupportw,wall,cornerd,1);
	translate([towerx,0,0]) roundedcylinder(mbtowerattachd,wall,cornerd,1,90);
	translate([0,-handlew/2,0]) roundedbox(barl,handlew,wall,cornerd,1);
      }
    }

    hull() {
      translate([towerx-1.5,0,-0.01]) cylinder(d=mbtowerd+dtolerance,h=0.1+0.01,$fn=90);
      translate([towerx,0,-0.01]) cylinder(d=mbtowerd+dtolerance,h=mbtowerattachh+0.01,$fn=90);
      translate([towerx,0,-0.01]) cylinder(d=screwholed,h=mbtowerattachh+wall+0.02,$fn=90);
    }
    translate([towerx,0,-0.01]) cylinder(d=screwholed,h=mbtowerattachh+wall*2+0.02,$fn=90);
  }
}

module mbtowerextendscrew() {
  difference() {
    union() {
      translate([-topoutd/2,-mbsupportw/2,0]) roundedbox(topoutd,mbsupportw,mbh,cornerd,1);
      hull() {
	translate([-wall,-mbsupportw/2,mbh+mbthickness+ztolerance+wall]) roundedbox(topoutd/2+wall,mbsupportw,cornerd,cornerd,1);
	translate([0,-mbsupportw/2,mbh+mbthickness+ztolerance]) roundedbox(topoutd/2,mbsupportw,wall,cornerd,1);
      }
      translate([0,-mbsupportw/2,0]) roundedbox(topoutd/2,mbsupportw,mbh+mbthickness+ztolerance+wall,cornerd,1);
      hull() {
	translate([towerx,0,0]) roundedcylinder(mbtowerattachd,mbh,cornerd,1,90);
	translate([towerx-1.5,0,0]) roundedcylinder(mbtowerattachd,cornerd,cornerd,1,90);
      }
      
      hull() {
	roundedcylinder(topoutd,max(wall,mbh/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	translate([-topoutd/2,-mbsupportw/2,0]) roundedbox(topoutd,mbsupportw,wall,cornerd,1);
	translate([towerx,0,0]) roundedcylinder(mbtowerattachd,wall,cornerd,1,90);
	translate([0,-handlew/2,0]) roundedbox(barl,handlew,wall,cornerd,1);
      }
    }

    translate([towerx,0,-0.01]) cylinder(d=screwholed+dtolerance,h=mbtowerattachh+wall*2+0.02,$fn=90);
  }
}

module ruuvitorni() {
  difference() {
    union() {
      roundedcylinder(topoutd,ruuvitornih,cornerd,1,6);
      hull() {
	roundedcylinder(topoutd,max(wall,ruuvitornih/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
	translate([0,-handlew/2,0]) roundedbox(handlel,handlew,wall,cornerd,1);
      }
    }

    translate([0,0,-0.01]) cylinder(d=screwholed,h=ruuvitornih+0.02,$fn=90);
  }
}

module ruuvitolppa() {
  difference() {
    union() {
      roundedcylinder(topoutd,ruuvitolppah,cornerd,1,6);
      hull() {
	roundedcylinder(topoutd,max(wall,ruuvitolppah/3),cornerd,1,6);
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
      }
      hull() {
	roundedcylinder(bottomoutd,wall,cornerd,1,6);
	translate([0,-handlew/2,0]) roundedbox(handlel,handlew,wall,cornerd,1);
      }
      translate([0,0,0]) roundedcylinder(screwtolppad,ruuvitolppah+screwtolppah,screwtolppad,0,90);
    }
  }
}

module ruuvitornikorkea() {
  difference() {
    union() {
      roundedcylinder(topoutd,ruuvitolppakorkeah,cornerd,1,6);
      hull() {
	roundedcylinder(topoutd,max(wall,ruuvitolppakorkeah/3),cornerd,1,6);
	rotate([0,0,45]) roundedcylinder(bottomouthighd,wall,cornerd,1,4);
      }
    }

    translate([0,0,-0.01]) cylinder(d=screwholed,h=ruuvitolppakorkeah+0.02,$fn=90);
  }
}

if (print==1 || print==6 || print==7) {
  translate([-handlel-1,0,0]) {
    if (print==7) {
      mbtowerextendscrew();
    } else {
      mbtowerextend();
    }
  }
 }

if (print==2 || print==6 || print==7) {
  translate([-handlel-1,mbsupportw+0.5,0]) mbtowerextendscrew();
 }

if (print==3 || print==6) {
  ruuvitorni();
 }

if (print==4 || print==6) {
  translate([0,bottomoutd+0.5,0]) ruuvitolppa();
 }

if (print==5 || print==6 || print==7) {
  translate([-handlel-bottomouthighd/2-0.5,mbsupportw/2,0]) ruuvitornikorkea();
 }
