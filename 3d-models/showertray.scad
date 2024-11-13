// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

//include <hsu.scad>

print=1;
pipes=1;

fnsmall=print?60:12;
fnlarge=print?120:30;

$fn=fnsmall;

bardiameter=18;
distancefromwall=52+4.45-bardiameter;

piped=14;
pipeseparation=126+piped;
pipedepth=22-piped/2;

versiontext="Showertray V1.3";
textdepth=0.5;
textsize=7;

cornerd=10;
xcornerd=2;
ycornerd=2;
zcornerd=10;

width=220;
height=20;
backcornerd=distancefromwall*2;
topextension=5;
bardepth=distancefromwall-bardiameter/2;
barnarrowing=0.3;
depth=distancefromwall-bardiameter/2+height*2+20;
wall=2.5;

holed=12;
holesx=3;
holesy=5;
holexstart=pipedepth+piped;
holeystart=bardiameter/2+ycornerd/2;
holexend=depth-xcornerd/2;
holeyend=width/2-ycornerd/2-wall/2;
holexstep=(holexend-holexstart)/holesx;
holeystep=(holeyend-holeystart)/holesy;

module curvedcylinder(h,diameter,curved,a,stretch) {
  rotate_extrude(convexity=10,angle=a) translate([curved,0,0]) {
    hull() {
      circle(d=diameter);
      translate([stretch,0,0]) circle(d=diameter);
    }
  }
}

module trayform(w) {
  difference() {
    intersection() {
      minkowski(convexity=2) {
	scale([xcornerd/cornerd,ycornerd/cornerd,zcornerd/cornerd]) sphere(d=cornerd);
	difference() {
	  union() {
	    translate([xcornerd/2+backcornerd/2+w,w,zcornerd/2+w]) cube([depth-backcornerd/2-xcornerd-w*2,width/2-ycornerd/2-w*2,height-zcornerd/2-w+topextension]);
	    intersection() {
	      hull() {
		translate([backcornerd/2,0,height]) rotate([-90,0,0]) cylinder(d=backcornerd-xcornerd-w*2,h=width/2-xcornerd/2-w,$fn=fnlarge);
		if (backcornerd/2+topextension > height) {
		  translate([backcornerd/2,0,backcornerd/2+topextension]) rotate([-90,0,0]) cylinder(d=backcornerd-xcornerd-w*2,h=width/2-xcornerd/2-w);
		}
	      }
	      translate([xcornerd/2,0,zcornerd/2+w]) cube([backcornerd/2+xcornerd,width/2+ycornerd/2-w,height+zcornerd/2+topextension]);
	    }
	  }

	  union() {
	    // Cut for bar
	    translate([distancefromwall+bardiameter/2,0,zcornerd/2-0.01]) cylinder(h=height+zcornerd/2+topextension+0.02,d=bardiameter+xcornerd+w*2,$fn=fnlarge);
	    translate([distancefromwall+bardiameter/2,-ycornerd/2,zcornerd/2-0.01]) cube([depth-distancefromwall-bardiameter/2,bardiameter/2+ycornerd+w-barnarrowing,height+topextension+0.02]);

	    if (pipes) {
	      // Cuts for pipes on the wall
	      translate([pipedepth,pipeseparation/2,height-0.01]) cylinder(h=zcornerd+topextension+0.02+w,d=piped+xcornerd+w*2,$fn=fnlarge);
	      intersection() {
		translate([pipedepth+distancefromwall,pipeseparation/2,height]) rotate([-90,0,180]) curvedcylinder(height+ycornerd/2+topextension+0.02,piped+xcornerd+w*2,distancefromwall,90,piped);
		translate([pipedepth-piped/2-w,pipeseparation/2-piped/2-ycornerd/2-w,0]) cube([distancefromwall,piped+ycornerd+w*2,height+cornerd/2-w]);
	      }
	      translate([w-0.01,pipeseparation/2-piped/2-ycornerd/2-w,w-0.01]) cube([pipedepth,piped+ycornerd+w*2,height+topextension+zcornerd+1+0.02]);
	    }
	  }
	}
      }

      // Cut off outside extras
      if (w==0) {
	cube([depth,width/2,height+topextension]);
      }
    }

    // Make holes for draining and lightness
    if (w==0) {
      if ((holexstep>holed) && (holeystep>holed)) {
	for (x=[holexstart:holexstep:holexend-1]) {
	  for (y=[holeystart:holeystep:holeyend-1]) {
	    translate([x+holexstep/2,y+holeystep/2,-0.1]) cylinder(h=height+topextension+1,d=holed);
	  }
	}
      }

      translate([distancefromwall-wall-1,-0.01,height-0.01]) cube([bardiameter/2+wall+1,bardiameter/2+0.02,topextension+0.02]);
    }
  }
}

module oneside() {
  difference() {
    trayform(0);
    trayform(wall);
  }
}

module showertray() {
  difference() {
    union() {
      oneside();
      mirror([0,1,0]) oneside();
      translate([pipedepth,0,wall-0.01]) rotate([0,0,90]) linear_extrude(height=textdepth+1) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

      if (!pipes) difference() {
	translate([0.1,0,depth-height-(pipeseparation-piped-zcornerd)*0.5]) rotate([0,90,0]) scale([0.4,1,1]) cylinder(h=wall-0.1,d=pipeseparation-piped-xcornerd);
	translate([-0.2,-pipeseparation/2,-pipeseparation/2-0.1]) cube([wall+0.4,pipeseparation,height+pipeseparation/2]);
      }
    }
  }
}

if (print==0) {
  intersection() {
    showertray();
    //      cube([100,width/2,100]);
  }
 }

if (print==1) {
  rotate([0,0,90]) showertray();
 }
