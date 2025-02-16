// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Light diffusor for lidl desk lamp

include <hsu.scad>

print=1;
debug=01;

angle=0;

versiontext="v1.2";
versiontextsize=7;
textdepth=0.8;
textsize=8;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
dtolerance=0.6;

lamph=75+xtolerance*2;
lampw=228+ytolerance*2;
lampdepth=25.5+ztolerance*2;
lampcornerd=20;
lampbased=16.5;

diffusorh=45;
diffusorw=204;
diffusordepth=2.7;
diffusorcornerd=10;
wall=2;

cornerd=1;

diffusorwall=1.6;

axled=5;
axledepth=1.5;
axlel=30;
axlex=65-12.5-axlel/2; //lampw*0.4/2;
axley=ytolerance*2;

axleheight=wall+lampdepth/2;
axleyposition=lamph/2+axled/2+axley;
latchheight=1.8; //lampdepth/10;

clipdepth=0.8;
clipd=wall+clipdepth;
clipl=axlel-5;
clipheight=lampdepth/2+wall-ztolerance*3-clipd/2;
clipbacky=-lamph/2-wall*2-ytolerance/2;
clipy=clipbacky+clipd/2;
clipbackh=clipd+wall/2+ztolerance;//+ztolerance;
  
module lamp() {
  translate([-lampw/2,-lamph/2,wall]) roundedboxxyz(lampw,lamph,lampdepth,lampcornerd,lampcornerd,0,30);
  translate([0,0,lampdepth/2+wall]) rotate([90,0,0]) cylinder(d=lampbased,h=lamph/2+20);
}

module diffusorlatch() {
  difference() {
    union() {
      intersection() {
	translate([-lampw/2-wall,lamph-lamph/2-wall+wall*2,lampdepth+wall*2]) rotate([180,0,0]) roundedboxxyz(lampw+wall*2,lamph+wall*2,lampdepth+wall*2,lampcornerd+wall*2,lampcornerd+wall*2,1,30);

	for (x=[-axlex,axlex]) {
	  union() {
	    translate([x-axlel/2,-lamph/2-wall,lampdepth/2+wall+ztolerance]) cube([axlel,lamph+wall*2,lampdepth/2+wall+ztolerance]);
	    //translate([x-axlel/2,-lamph/2-wall,wall+latchheight]) cube([axlel,lamph/2+wall,lampdepth/2+wall+ztolerance]);
	  }
	}
      }

      for (x=[-axlex,axlex]) {
	hull() {
	  translate([x-axlel/2,-lamph/2-0.1,lampdepth/2+wall+ztolerance]) cube([axlel,0.1,wall*3-ytolerance]);
	  translate([x-axlel/2,clipbacky+wall-cornerd,lampdepth/2+wall+ztolerance]) cube([axlel,wall,cornerd/2]);
	  translate([x-axlel/2,clipbacky,lampdepth/2+wall+ztolerance]) roundedbox(axlel,wall,wall,cornerd);
	}
	translate([x-axlel/2,clipbacky,lampdepth/2+wall+ztolerance-clipbackh]) roundedbox(axlel,wall,clipbackh+wall,cornerd);
	translate([x,clipy,clipheight]) tubeclip(clipl,clipd,0);
	  
	translate([x,lamph/2+axled/2+axley,axleheight]) rotate([0,0,90]) onehinge(axled,axlel,axledepth,0,ytolerance,dtolerance);

	hull() {
	  translate([x,lamph/2+axled/2+axley,wall+lampdepth/2]) rotate([0,90,0]) cylinder(d=axled,h=axlel,center=true,$fn=30);
	  translate([x-axlel/2,lamph/2-0.1,wall+lampdepth/2+ztolerance]) cube([axlel,0.1,axled+axley]);
	}
      }
    }
    lamp();

    for (x=[-axlex,axlex]) {
      translate([x,0,lampdepth+wall+wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font="Liberation Sans:style=Bold",valign="center",halign="center");
    }
  }
}

module diffusor() {
  difference() {
    union() {
      translate([-lampw/2-wall,-lamph/2-wall,0]) intersection() {
	roundedboxxyz(lampw+wall*2,lamph+wall*2,lampdepth+wall*2,lampcornerd+wall*2,lampcornerd+wall*2,1,30);
	cube([lampw+wall*2,lamph+wall*2,lampdepth/2+wall-ztolerance]);
      }
      for (x=[-axlex,axlex]) {
	hull() {
	  translate([x-axlel/2-xtolerance-axledepth-wall,axleyposition,wall+lampdepth/2]) rotate([0,90,0]) cylinder(d=axled+dtolerance*2,h=axledepth+wall,$fn=30);
	  translate([x-axlel/2-xtolerance-axledepth-wall-axled/4,axleyposition,wall+lampdepth/2]) rotate([0,90,0]) cylinder(d=axled/2+dtolerance*2,h=axledepth+wall,$fn=30);
	  translate([x-axlel/2-xtolerance-axledepth-wall,lamph/2+axley,lampdepth/2-axledepth-wall-ztolerance]) cube([axledepth+wall,0.1,axledepth+axledepth]);
	}
	hull() {
	  translate([x+axlel/2+xtolerance,axleyposition,wall+lampdepth/2]) rotate([0,90,0]) cylinder(d=axled+dtolerance*2,h=axledepth+wall,$fn=30);
	  translate([x+axlel/2+xtolerance+axled/4,axleyposition,wall+lampdepth/2]) rotate([0,90,0]) cylinder(d=axled/2+dtolerance*2,h=axledepth+wall,$fn=30);
	  translate([x+axlel/2+xtolerance,lamph/2+axley,lampdepth/2-axledepth-wall-ztolerance]) cube([axledepth+wall,0.1,axledepth+axledepth]);
	}
      }
    }
    
    for (x=[-axlex,axlex]) {
      if (0) translate([x-axlel/2-xtolerance,-lamph/2-wall,wall+latchheight-ztolerance]) cube([axlel+xtolerance*2,lamph/2+wall,lampdepth/2+wall+ztolerance]);

      translate([x,clipy,clipheight]) tubeclip(clipl,clipd,dtolerance);
    

      hull() {
	translate([x-axlel/2-xtolerance,lamph/2-ytolerance,wall+lampdepth/2]) cube([axlel+xtolerance*2,0.1,axled+axley]);
	translate([x,axleyposition,wall+lampdepth/2]) rotate([0,90,0]) cylinder(d=axled+dtolerance,h=axlel,center=true,$fn=30);
	translate([x-axlel/2-xtolerance,lamph/2+axley+axled/2,wall+lampdepth/2-axled-dtolerance+ztolerance]) cube([axlel+xtolerance*2,0.1,axled/2+axley]);
      }

      translate([x,axleyposition,axleheight]) rotate([0,0,90]) onehinge(axled,axlel,axledepth,2,ytolerance,dtolerance);
    }
      
    lamp();

    // Thinner light area part - reduces diffusion effect so disabled.
    // translate([-diffusorw/2,-diffusorh/2,diffusorwall]) roundedboxxyz(diffusorw,diffusorh,wall-diffusorwall+0.06,diffusorcornerd,0,1,30);
    //#    translate([-diffusorw/2,-diffusorh/2,diffusorwall]) cube([diffusorw,diffusorh,wall-diffusorwall+0.06]);
  }
}

if (print==0) {
  intersection() {
    union() {
      difference() {
	union() {
	  diffusor();
	  translate([axleheight,axleyposition,lampdepth/2+wall]) rotate([angle,0,0]) translate([-axleheight,-axleyposition,-lampdepth/2-wall]) diffusorlatch();
	}
	#lamp();
	#printareacube("ankermake");
      }
    }

    if (debug) translate([-axlex,-100,-100]) cube([1000,1000,1000]);
  }
 }

if (print==1) {
  difference()  
    {
      translate([9,-9,0]) rotate([0,0,45]) {
	diffusor();
	translate([axleheight,axleyposition,lampdepth/2+wall]) rotate([180,0,0]) translate([-axleheight,-axleyposition,-lampdepth/2-wall]) diffusorlatch();
      }
      #printareacube("ankermake");
    }
 }
 
