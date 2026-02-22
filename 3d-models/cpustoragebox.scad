// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=print==0?1:0;
xtolerance=0.30;
ytolerance=0.30;
ztolerance=0.20;
dtolerance=0.60;

versiontext="V1.0";
textdepth=0.7;
textsize=7;
textfont="Liberation Sans:style=Bold";

wall=1.2*2+max(xtolerance,ytolerance);
inwall=1.2; // Around the object, raised
outwall=wall-inwall-max(xtolerance,ytolerance);
cornerd=2;

cpu=1;
cputable=[["amd-athlon64-hp-dx2250",41,41,7.5],
	  ["celeron-acerpower-s290",38,38,6]
	  ];
  
l=cputable[cpu][1];
w=cputable[cpu][2];
h=cputable[cpu][3];

echo(cpu,cputable[cpu][0],cputable[cpu][1],cputable[cpu][2],cputable[cpu][3]);

// Centered at axle
axled=h;
axledepth=2;
axlel=w-axledepth;
  
clipw=20;
clipd=1.5+dtolerance;
//clipdepth=1.0;
clipcut=0.5;

// Size of actual box
lout=wall+l+wall+clipd/2-inwall+xtolerance+clipd-inwall;
wout=wall+w+wall;
hout=inwall+ztolerance+h+ztolerance+inwall;

axleheight=hout/2;

//boxx=hout/2+xtolerance;//axled/2+xtolerance;
boxx=axled/2+xtolerance;//axled/2+xtolerance;
topx=-lout-hout/2-xtolerance;

insidecutx=boxx+wall;
//topinsidecutx=topx+wall+xtolerance;
topinsidecutx=insidecutx-inwall-xtolerance;
topinsidecutl=xtolerance+inwall+l+inwall+xtolerance;
corneropening=3;

sideboxy=-w/2+corneropening;
sideboxw=10;//(lout-(wall-inwall)-clipw)/2-2;
sideboxl=sideboxw;

//fingeropeningl=lout-sideboxw*2-corneropening*2+wall-inwall;
//fingeropeningl=lout-wall*2-xtolerance-corneropening-sideboxl*2;
//fingeropeningl=boxx+wall+xtolerance+l-sideboxl-corneropening+wall-inwall-(boxx+wall-inwall+corneropening);
//fingeropeningl=boxx+wall+xtolerance+l+xtolerance+wall+clipd/2-(sideboxl+corneropening)*2;
fingeropeningl=l-(sideboxl+corneropening)*2;
fingeropeningx=boxx+wall+corneropening+sideboxl;

module base() {
  difference() {
    union() {
      translate([boxx+(hout-axled)/2,-wout/2,-hout/2]) roundedbox(lout-(hout-axled)/2-outwall-xtolerance,wout,cornerd,cornerd,1);
      translate([boxx+(hout-axled)/2,-wout/2,-hout/2]) roundedbox(fingeropeningx-boxx-(hout-axled)/2,wout,hout/2-ztolerance,cornerd,1);
      //      translate([fingeropeningx+fingeropeningl,-wout/2,-hout/2]) roundedbox(boxx+lout-fingeropeningx-fingeropeningl,wout,hout/2-ztolerance,cornerd,1);
      for (m=[0,1]) mirror([0,m,0]) {
	  w=(wout-clipw)/2-xtolerance;
	  // translate([boxx,-wout/2,-hout/2]) roundedbox(lout,(wout-clipw)/2-xtolerance,hout/2-ztolerance,cornerd,1);
	  translate([boxx+(hout-axled)/2,-wout/2,-hout/2]) roundedbox(fingeropeningx-boxx-(hout-axled)/2,w,hout/2-ztolerance,cornerd,1);
	  translate([fingeropeningx+fingeropeningl,-wout/2,-hout/2]) roundedbox(boxx+lout-fingeropeningx-fingeropeningl,w,hout/2-ztolerance,cornerd,1);
	}
      intersection() {
	for (m=[0,1]) mirror([0,m,0]) {
	    for (x=[insidecutx-inwall,insidecutx+l-sideboxl+inwall]) {
	      translate([x,sideboxy,-hout/2]) roundedbox(sideboxl,sideboxw,inwall+ztolerance+h-ztolerance,cornerd,1);
	    }
	    
	    for (x=[insidecutx+corneropening,insidecutx+l-sideboxl-corneropening]) {
	      translate([x,sideboxy-inwall-corneropening,-hout/2]) roundedbox(sideboxl,sideboxw,inwall+ztolerance+h-ztolerance,cornerd,1);
	    }
	  }
	rotate([90,0,0]) cylinder(r=boxx+wall-inwall+lout-(wall-inwall)*2+xtolerance,h=wout,center=true,$fn=360);
      }
      translate([-axled/2,-axlel/2+ytolerance,-hout/2]) roundedbox(axled+xtolerance+lout-xtolerance-inwall,axlel-ytolerance*2,hout/2-ztolerance,cornerd,1);
      onehinge(axled,axlel,axledepth,0,ytolerance,dtolerance);
    }

    translate([insidecutx,-w/2,-hout/2+inwall]) cube([l,w,h+0.1]);
    translate([boxx+lout-clipd/2,0,-hout/2+clipd/2]) rotate([0,0,90]) tubeclip(clipw,clipd,dtolerance);

    translate([boxx+lout/2,0,-hout/2+textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module top() {
  difference() {
    union() {
      translate([boxx,-wout/2,0]) roundedbox(lout,wout,hout/2,cornerd,2);
      translate([boxx+lout-wall,-clipw/2,-hout/2]) roundedbox(wall,clipw,hout,cornerd,2);
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([boxx-hout/2,-wout/2,0]) roundedbox(lout+hout/2,(wout-axlel)/2,hout/2,cornerd,2);
	  translate([fingeropeningx+xtolerance,-wout/2,-hout/2+cornerd+ztolerance]) roundedbox(fingeropeningl-xtolerance*2,(wout-axlel)/2,hout-cornerd-ztolerance*2,cornerd,0);
	}
      for (m=[0,1]) mirror([0,m,0]) hull() {
	translate([0,-wout/2,0]) roundedbox(hout/2,(wout-axlel)/2,hout/2,cornerd,2);
	translate([0,-wout/2,0]) rotate([-90,0,0]) roundedcylinder(hout,(wout-axlel)/2,cornerd,0,90);
      }
    }

    onehinge(axled,axlel,axledepth,2,ytolerance,dtolerance);
    for (m=[0,1]) mirror([0,m,0]) translate([boxx+lout-cornerd/2-wall-0.01,-clipw/2-clipcut,-0.01]) cube([wall+cornerd/2+0.02,clipcut,hout/2-ztolerance-inwall+0.01]);
    translate([topinsidecutx,-wout/2+wall-inwall-ytolerance,-h/2]) roundedbox(topinsidecutl,wout-(wall-inwall)*2+ytolerance*2,h,cornerd,0);
    translate([boxx+wall-inwall-xtolerance,-clipw/2-clipcut-cornerd/2,-hout/2-cornerd/2]) roundedbox(lout-wall+xtolerance,clipw+clipcut*2+cornerd/2,inwall+ztolerance+h+cornerd/2,cornerd,0);
  }

  translate([boxx+lout-clipd/2,0,-hout/2+clipd/2]) rotate([0,0,90]) tubeclip(clipw,clipd,0);
  for (m=[0,1]) mirror([0,m,0]) {
      translate([fingeropeningx+xtolerance,-wout/2,-hout/2+cornerd+ztolerance]) roundedbox(fingeropeningl-xtolerance*2,wall,hout-cornerd-ztolerance*2,cornerd,0);
    }
}

if (print==0) {
  intersection() {
    if (debug) translate([-100,0,-100]) cube([200,200,200]);
    //if (debug) translate([0,-100,-100]) cube([200,200,200]);
    union() {
      base();
      //rotate([0,180,0]) top();
      top();
    }
  }
 }

if (print==1) {
  intersection() {
    if (debug) translate([-100,0,-100]) cube([200,200,200]);
    //if (debug) translate([0,-100,-100]) cube([200,200,200]);
    union() {
      base();
      rotate([0,180,0]) top();
    }
  }
 }
