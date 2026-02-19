// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=print==0?1:0;

xtolerance=0.30;
ytolerance=0.30;
ztolerance=0.30;
dtolerance=0.60;

versiontext="V1.0";
textdepth=0.7;
textsize=7;

wall=1.2*2+max(xtolerance,ytolerance);
inwall=1.2; // Around the object, raised
outwall=wall-inwall-max(xtolerance,ytolerance);
cornerd=2;

// Size of contents
l=40.5;
w=40.5;
h=7.5;

// Centered at axle
axled=h;
axledepth=2;
axlel=w-axledepth;
  
clipw=20;
clipd=1.5+dtolerance;
//clipdepth=1.0;
clipcut=0.5;

// Size of actual box
lout=wall+xtolerance+l+xtolerance+wall+clipd/2;
wout=wall+ytolerance+w+ytolerance+wall;
hout=inwall+ztolerance+h+ztolerance+inwall;

axleheight=hout/2;

boxx=axled/2+xtolerance;
topx=-lout-axled/2-xtolerance;

module base() {
  difference() {
    union() {
      translate([boxx+(hout-axled)/2,-wout/2,-hout/2]) roundedbox(lout-(hout-axled)/2-outwall-xtolerance,wout,hout/2-ztolerance,cornerd,1);
      for (m=[0,1]) mirror([0,m,0]) translate([boxx+(hout-axled)/2,-wout/2,-hout/2]) roundedbox(lout-(hout-axled)/2,(wout-clipw)/2-xtolerance,hout/2-ztolerance,cornerd,1);
      intersection() {
	translate([boxx+wall-inwall,-wout/2+wall-inwall,-hout/2]) roundedbox(lout-(wall-inwall)*2,wout-(wall-inwall)*2,inwall+ztolerance+h-ztolerance,cornerd,1);
	rotate([90,0,0]) cylinder(r=boxx+wall-inwall+lout-(wall-inwall)*2,h=wout,center=true,$fn=360);
      }
      translate([-axled/2,-axlel/2+ytolerance,-hout/2]) roundedbox(axled/2+axled/2+lout-inwall,axlel-ytolerance*2,hout/2-ztolerance,cornerd,1);
      onehinge(axled,axlel,axledepth,0,ytolerance,dtolerance);
    }

    translate([boxx+wall+xtolerance,-w/2,-hout/2+inwall]) cube([l,w,h+0.1]);
    translate([boxx+lout-clipd/2,0,-hout/2+clipd/2]) rotate([0,0,90]) tubeclip(clipw,clipd,dtolerance);
  }
}

module top() {
  difference() {
    union() {
      translate([topx,-wout/2,-hout/2]) roundedbox(lout,wout,hout/2,cornerd,1);
      translate([topx,-clipw/2,-hout/2]) roundedbox(wall,clipw,hout,cornerd,1);
      for (m=[0,1]) mirror([0,m,0]) translate([topx,-wout/2,-hout/2]) roundedbox(-topx+cornerd,(wout-axlel)/2,hout/2-ztolerance,cornerd,1);
      for (m=[0,1]) mirror([0,m,0]) hull() {
	translate([0,-wout/2,-hout/2]) roundedbox(hout/2,(wout-axlel)/2,hout/2-ztolerance,cornerd,1);
	translate([0,-wout/2,0]) rotate([-90,0,0]) roundedcylinder(hout,(wout-axlel)/2,cornerd,0,90);
      }
    }

    onehinge(axled,axlel,axledepth,2,ytolerance,dtolerance);
    for (m=[0,1]) mirror([0,m,0]) translate([topx-0.01,-clipw/2-clipcut,-hout/2+inwall]) cube([wall+0.02,clipcut,hout/2]);
    translate([topx+wall-inwall-xtolerance,-wout/2+wall-inwall-ytolerance,-hout/2+inwall]) roundedbox(lout-(wall-inwall)*2+xtolerance*2,wout-(wall-inwall)*2+ytolerance*2,inwall+ztolerance+h-ztolerance+cornerd,cornerd,1);
    
  }

  translate([topx+clipd/2,0,hout/2-clipd/2]) rotate([0,0,90]) tubeclip(clipw,clipd,0);
}

if (print==0) {
  intersection() {
    if (debug) translate([-100,0,-100]) cube([200,200,200]);
    //if (debug) translate([0,-100,-100]) cube([200,200,200]);
    union() {
      base();
      rotate([0,180,0]) top();
    }
  }
 }

if (print==1) {
  intersection() {
    if (debug) translate([-100,0,-100]) cube([200,200,200]);
    //if (debug) translate([0,-100,-100]) cube([200,200,200]);
    union() {
      base();
      top();
    }
  }
 }
