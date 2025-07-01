// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
abs=1;

$fn=90;

versiontext="hsu BH V1.0";
textdepth=0.8;
textsize=7;

bicyclebarh=60;
bicyclebarw=38;
barl=250; // Only used for testing

dtolerance=0.7;
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

wall=2.5;

screwdistance=62;

cand=66;
canh=115;

limupullod=61;
limupulloh=160;
  
holderdiameter=cand+dtolerance;
backoffset=wall;
frontoffset=10;
drinkcenter=frontoffset+holderdiameter/2;
drinkbottomheight=wall;

originald=65;
originalh=150;
originalbarbump=6;
originalbarbumph=18;

bodyattachw=bicyclebarw/2;
bodyattachh=originalh;

bottleholderh=80;

screwd=5.4;
screwl=21;
screw1h=24;
screw2h=screw1h+63.5;
screwbased=10.5;
screwbaseh=4;
screw1l=1; // Screw 1 hole slightly lengthened to allow easier installation.
screwinsidespace=1;
screwinsidespaced=10;
  
binderw=8.4;
binderh=2.6;
binderwall=2+binderh;
binder1height=screw1h-screwbased-screw1l-wall*3;
binder2height=screw2h+screwbased-wall;
frontcutd=15;

rainholed=10;

cornerd=1;

module bar() {
  translate([-bicyclebarh/2,0,0]) resize([bicyclebarh,bicyclebarw,barl]) cylinder(d=bicyclebarw,h=barl,$fn=60);
}

module can() {
  translate([drinkcenter,0,drinkbottomheight]) cylinder(d=cand,h=canh);
}

module bottleholder() {
  intersection() {
    difference() {
      union() {
	hull() {
	  translate([-bicyclebarh/2+backoffset,0,0]) resize([bicyclebarh,bicyclebarw+wall,bodyattachh]) cylinder(d=bicyclebarw,h=bodyattachh,$fn=60);
	  translate([0,-bodyattachw/2,0]) roundedbox(frontoffset,bodyattachw,bodyattachh,cornerd);
	}

	// Up is slightly pushed towers the bottle
	hull() {
	  translate([0,-bodyattachw/2,bodyattachh-originalbarbumph]) roundedbox(frontoffset,bodyattachw,originalbarbumph,cornerd);
	  translate([0,-bodyattachw/2,bodyattachh-1]) roundedbox(frontoffset+originalbarbump,bodyattachw,1,cornerd);
	}
	
	hull() {
	  translate([0,-bodyattachw/2,0]) roundedbox(wall,bodyattachw,bottleholderh,cornerd);
	  translate([drinkcenter,0,0]) cylinder(d=cand+dtolerance+wall*2,h=bottleholderh);
	}
      }
      
      translate([-bicyclebarh/2,0,-0.01]) resize([bicyclebarh,bicyclebarw,barl]) cylinder(d=bicyclebarw,h=bodyattachh+0.02,$fn=60);

      translate([drinkcenter,0,wall]) cylinder(d=cand+dtolerance,h=bottleholderh+0.02);
      translate([drinkcenter,0,wall-textdepth+0.01]) rotate([0,0,90]) linear_extrude(height=textdepth+1) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

      hull() {
	translate([drinkcenter,0,screw1h-screw1l/2]) rotate([0,90,0]) cylinder(d=frontcutd,h=cand+dtolerance+wall);
	translate([drinkcenter,0,bottleholderh-frontcutd-wall]) rotate([0,90,0]) cylinder(d=frontcutd,h=cand+dtolerance+wall);
      }

      hull() {
	translate([screwbaseh-screwl,0,screw1h-screw1l/2]) rotate([0,90,0]) ruuvireika(screwl,screwd,0,0,screwbaseh);
	translate([screwbaseh-screwl,0,screw1h+screw1l/2]) rotate([0,90,0]) ruuvireika(screwl,screwd,0,0,screwbaseh);
      }
      translate([screwbaseh-screwl,0,screw2h]) rotate([0,90,0]) ruuvireika(screwl,screwd,0,print==1?1:0,screwbaseh);
      
      hull() {
	translate([screwbaseh-0.01,0,screw1h-screw1l/2]) rotate([0,90,0]) cylinder(d1=screwbased,d2=screwbased+screwl,h=screwl);
	translate([screwbaseh-0.01,0,screw1h+screw1l/2]) rotate([0,90,0]) cylinder(d1=screwbased,d2=screwbased+screwl,h=screwl);
      }

      hull() {
	translate([-5,0,screw1h-screw1l/2]) rotate([0,90,0]) cylinder(d2=screwinsidespaced,d1=screwinsidespaced+screwinsidespace+5,h=screwinsidespace+5);
	translate([-5,0,screw1h+screw1l/2]) rotate([0,90,0]) cylinder(d2=screwinsidespaced,d1=screwinsidespaced+screwinsidespace+5,h=screwinsidespace+5);
      }
      translate([-5,0,screw2h]) rotate([0,90,0]) cylinder(d2=screwinsidespaced,d1=screwinsidespaced+screwinsidespace+5,h=screwinsidespace+5);
	
      translate([screwbaseh-0.01,0,screw2h]) rotate([0,90,0]) cylinder(d1=screwbased,d2=screwbased+screwl,h=screwl);

      for (z=[binder1height,binder2height]) {
	translate([-bicyclebarh/2,0,z]) scale([1,bicyclebarw/bicyclebarh,1]) ring(bicyclebarh+binderwall*2+binderh,binderh,binderw,1);
      }

      // Rain emptying hole
      translate([frontoffset+rainholed/2,0,-0.01]) cylinder(d=rainholed,h=wall+0.02);
    }
    translate([-bicyclebarh/2+frontoffset,-bicyclebarw,-0.01]) cube([bicyclebarh+cand,bicyclebarw*2,barl]);
  }
}

//#bar();
//#can();
if (print==0) {
  intersection() {
    bottleholder();
    //    translate([-100,0,0]) cube([200,200,binder2height+1]);
  }
 }

module testing() {
  render() bottleholder();
  echo("bbox X is ",$xmin,$xmax);
  echo("bbox Y is ",$ymin,$ymax);
  echo("bbox Z is ",$zmin,$zmax);
}

if (print==1) {
  bottleholder();
  w=cand+dtolerance+wall*2;
  antiwarpwall(-bicyclebarw/2,-w/2,0,bicyclebarw/2+drinkcenter+w/2,w,bodyattachh);
 }
