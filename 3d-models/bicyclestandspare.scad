// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=0;

versiontext="V1.0";
textdepth=0.7;
textsize=6;
text1=str("Bicyclestandspare ",versiontext);

angle=20;
upd=7;
upw=12.7;
downd=5;
downw=7;
l=12;
tubeh=32;
cornerd=2;

wallbase=4;
walltop=3;
wallstand=9;
wallextend=20;

standh=35; // Original was about 29mm
standbottomh=3;
standbottomouth=6;

module roundedtubeshape(w=0,h=tubeh,printable=0) {
  hh=h<cornerd+0.01?cornerd+0.01:h+0.01;
  minkowski() {
    hull() {
      sphere(d=cornerd,$fn=90);
      if (printable) translate([0,0,-cornerd/2]) cylinder(d=cornerd/2,h=cornerd/2,$fn=90);
    }
    
    translate([0,0,cornerd/2]) hull() {
      linear_extrude(h=hh-cornerd) {
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([downd/2,-downw/2+downd/2,0]) circle(d=downd-cornerd+w,$fn=90);
	    translate([l-upd/2,-upw/2+upd/2,0]) circle(d=upd-cornerd+w,$fn=90);
	  }
      }
    }
  }
}

module tubeshape() {
  translate([0,0,0]) hull() {
    linear_extrude(h=tubeh) {
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([downd/2,-downw/2+downd/2,0]) circle(d=downd,$fn=90);
	  translate([l-upd/2,-upw/2+upd/2,0]) circle(d=upd,$fn=90);
	}
    }
  }
}

module bicyclestandshape(w) {
  linear_extrude(h=0.1) {
    for (m=[0,1]) mirror([0,m,0]) {
	translate([downd/2,-downw/2+downd/2,0]) circle(d=downd+w*2,$fn=90);
	translate([l-upd/2,-upw/2+upd/2,0]) circle(d=upd+w*2,$fn=90);
      }
  }
}

module bicyclestandspare() {
  difference() {
    union() {
      hull() {
	translate([0,0,standbottomh]) roundedtubeshape(w=wallbase,h=cornerd);
	translate([0,0,standbottomh+standh-cornerd]) roundedtubeshape(w=walltop,h=cornerd);
      }

      hull() {
	translate([0,0,standbottomouth]) roundedtubeshape(w=wallbase,h=cornerd);
	rotate([0,20,0]) translate([0,0,standbottomh-wallstand/2*sin(angle)]) roundedtubeshape(w=wallstand,h=cornerd);
      }

      rotate([0,20,0]) hull() {
	translate([0,0,standbottomh-wallstand/2*sin(angle)]) roundedtubeshape(w=wallstand,h=cornerd);
	translate([0,0,0]) roundedtubeshape(w=wallextend,h=cornerd);
      }
    }

    translate([0,0,standbottomh]) roundedtubeshape(w=0,h=standh+cornerd*2,printable=0);

    a=atan((wallbase-walltop)/(standh+cornerd*2))/2;
    #    translate([l+(wallbase-walltop)/2*cos(a)+textdepth-0.01,0,standh/2+cornerd]) rotate([0,90-a,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

if (print==0) {
  bicyclestandspare();
 }

if (print==1) {
  rotate([0,-20,0]) bicyclestandspare();
 }

if (print==4) {
  roundedtubeshape(w=0,h=30);
}


