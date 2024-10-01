// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO: weather cover
// reed switch/sensor, ESP32

include <hsu.scad>

print=0;

textsize=3;

xtolerance=0.35;
ytolerance=0.35;
ztolerance=0.35;
axledtolerance=0.7;
dtolerance=0.5;

cupwall=1.6;
cupwidth=20+cupwall*2;
cuph=20;
cuplength=40;
cupaxled=7;
cupbaseh=5;
cupbasesupporth=cupbaseh;
cupbelowh=15;

baseaxlesupportwall=cupwall;

cupaxleheight=25+cupwall;
cupaxlew=baseaxlesupportwall;
cupaxlewidth=cupwidth;

cupangle=-atan(cuph/cuplength);
cornerd=0.5;
smallcornerd=0.01;

echo(sin(cupangle));
basel=cuplength*cos(-cupangle)-cupbaseh*sin(-cupangle);
basew=cupaxlewidth+cupwall*3+ytolerance*2;

angle=cupangle;
lowercupangle=cupangle+10;

towerw=cupaxled+1;

raincupd=60;
rainpiped=3; // Inside diameter
raincupbottomh=2;
raincupmidh=25;
raincuptoph=5;
funneltop=raincupbottomh+raincupmidh+raincuptoph;
wall=2;

funnelbasew=cupaxlewidth+(cupwall/2+wall+ytolerance)*2;
funnelh=cupaxleheight+cupbaseh+cuph+wall+wall;
funneltopd=90;

gridstep=10;
gridthickness=2;

magnetd=6.36;
magnetwall=0.8;
magneth=3.2;

module funnel() {
  difference() {
    union() {
      // Sides
      translate([-basel,-funnelbasew/2,0]) roundedbox(basel*2,wall,funnelh+wall*2,cornerd);
      translate([-basel,funnelbasew/2-wall,0]) roundedbox(basel*2,wall,funnelh+wall*2,cornerd);

      // Extension flanges to help with printing
     translate([basel-wall,-funnelbasew/2-wall*2,0]) roundedbox(wall,wall*3,funnelh+funneltop-raincuptoph/2,cornerd);
     translate([basel-wall,funnelbasew/2-wall,0]) roundedbox(wall,wall*3,funnelh+funneltop-raincuptoph/2,cornerd);

      // Top stoppers to limit cup movement
      stopperheight = cupaxleheight+cuplength*sin(-cupangle)+(cupbaseh+wall)*cos(cupangle);
      hull() {
	translate([basel-2*cupwall,-funnelbasew/2,stopperheight]) roundedbox(cupwall*2,cupwall*2,cupwall,cornerd);
	translate([basel-3*cupwall,-funnelbasew/2,stopperheight]) roundedbox(cupwall*3,cupwall,cupwall,cornerd);
      }
      hull() {
	translate([basel-2*cupwall,funnelbasew/2-cupwall*2,stopperheight]) roundedbox(cupwall*2,cupwall*2,cupwall,cornerd);
	translate([basel-3*cupwall,funnelbasew/2-cupwall,stopperheight]) roundedbox(cupwall*3,cupwall,cupwall,cornerd);
      }

      hull() {
	translate([-basel,-funnelbasew/2,stopperheight]) roundedbox(cupwall*2,cupwall*2,cupwall,cornerd);
	translate([-basel,-funnelbasew/2,stopperheight]) roundedbox(cupwall*3,cupwall,cupwall,cornerd);
      }
      hull() {
	translate([-basel,funnelbasew/2-cupwall*2,stopperheight]) roundedbox(cupwall*2,cupwall*2,cupwall,cornerd);
	translate([-basel,funnelbasew/2-cupwall,stopperheight]) roundedbox(cupwall*3,cupwall,cupwall,cornerd);
      }
      
      // Low part of pipe
      translate([0,0,funnelh]) cylinder(h=raincupbottomh,d1=rainpiped+wall/2,d2=rainpiped+raincupbottomh+wall*2,$fn=30);

      // Mid part of funnel
      hull() {
	translate([0,0,funnelh+raincupbottomh]) cylinder(h=0.1,d=rainpiped+raincupbottomh+wall*2,$fn=30);
	translate([-funneltopd/2+basel,0,funnelh+raincupbottomh+raincupmidh]) cylinder(h=0.1,d=funneltopd,$fn=60);
      }

      // Top part of funnel
      translate([basel-wall,-funnelbasew/2,funnelh]) roundedbox(wall,funnelbasew,funneltop-raincuptoph/2,cornerd);
      hull() {
	translate([0-funneltopd/2+basel,0,funnelh+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph,d1=funneltopd,d2=funneltopd-wall,$fn=60);
	translate([basel-wall,-funnelbasew/2-wall*2,funnelh+raincupbottomh+raincupmidh]) roundedbox(wall,funnelbasew+wall*4,raincuptoph/2,cornerd);
      }

      // Top of base structure
      translate([-towerw/2,-funnelbasew/2,funnelh+wall]) roundedbox(towerw/2+basel,funnelbasew,wall,cornerd);
    }

    // Cutout for funnel insides
    translate([0,0,funnelh-0.01]) cylinder(h=raincupbottomh+0.02,d1=rainpiped,d2=rainpiped+raincupbottomh,$fn=30);
    hull() {
      translate([0,0,funnelh+raincupbottomh-0.01]) cylinder(h=0.1,d=rainpiped+raincupbottomh,$fn=30);
      translate([-funneltopd/2+basel,0,funnelh+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph+0.1,d=funneltopd-wall*2,$fn=60);
    }
  }

  // Top grill
  intersection() {
    translate([-funneltopd/2+basel,0,funnelh+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph,d=funneltopd-wall,$fn=60);
    union() {
      for (x=[-funneltopd+1+basel:gridstep:basel-1]) {
	translate([x,-funneltopd/2,funnelh+raincupbottomh+raincupmidh]) triangle(gridthickness,funneltopd-1,raincuptoph,12);
      }
      for (y=[-funneltopd/2+1:gridstep:funneltopd/2-1]) {
	translate([-funneltopd+basel,y,funnelh+raincupbottomh+raincupmidh]) triangle(funneltopd,gridthickness,raincuptoph,22);
      }
    }
  }
}

module cups() {
  difference() {
    union() {
      translate([0,-cupaxlewidth/2,cupaxleheight]) onehinge(cupaxled,cupaxlew,baseaxlesupportwall,0,ytolerance,axledtolerance);
      translate([0,cupaxlewidth/2,cupaxleheight]) onehinge(cupaxled,cupaxlew,baseaxlesupportwall,0,ytolerance,axledtolerance);

      translate([0,0,cupaxleheight]) rotate([0,angle,0]) {
	lengthadjust=cupbaseh*sin(-cupangle);
	middleadjust=sin(45+cupangle);

	difference() {
	  union() {
	    // End plates for cups below cup baseplate, only for printing
	    for (y=[-cupaxlewidth/2,cupaxlewidth/2]) {
	      // Cup sideplates
	      hull() {
		translate([0,y-cupwall/2,0]) rotate([-90,0,0]) cylinder(d=cupaxled,h=cupwall);
		translate([-cuplength,y-cupwall/2,cupbaseh]) roundedbox(cuplength*2,cupwall,cupwall,cornerd);
		translate([0,y-cupwall/2,cupbaseh+cuph+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
	      }
	    }

	    // Cup baseplate
	    translate([-cuplength,-cupaxlewidth/2,cupbaseh]) roundedbox(cuplength*2,cupwidth,cupwall,smallcornerd);

	    // Middle barrier separating cups. Needs an angle for printing (45-cupangle)
	    hull() {
	      translate([0,-cupaxlewidth/2,cupbaseh+cuph+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	      translate([cuph*middleadjust,-cupaxlewidth/2,cupbaseh+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	      translate([-cuph*middleadjust,-cupaxlewidth/2,cupbaseh+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	      translate([-cuph*middleadjust,-cupaxlewidth/2,cupbaseh+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	    }

	    // Magnet holder
	    hull() {
	      outd=cupwall-magnetwall+magneth+dtolerance+magnetwall;
	      translate([0,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+dtolerance,h=magnetwall+magneth+magnetwall+ytolerance);
	      translate([0,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+dtolerance,h=magnetwall+magneth+magnetwall+ytolerance);
	      translate([magnetd*middleadjust,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/2-magnetwall-outd]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+outd,h=cupwall);
	      translate([-magnetd*middleadjust,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/2-magnetwall-outd]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+outd,h=cupwall);
	    }
	
	    for (y=[-cupaxlewidth/2,cupaxlewidth/2]) {
	      hull() {
		translate([0,y-cupwall/2,cupbaseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([cuplength,y-cupwall/2,cupbaseh]) rotate([0,-cupangle,0]) {
		  translate([-0.1,0,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(0.1,cupwall,cupbelowh,smallcornerd);
		}
	      }
	    }
	
	    for (y=[-cupaxlewidth/2,cupaxlewidth/2]) {
	      hull() {
		translate([0,y-cupwall/2,cupbaseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([-cuplength,y-cupwall/2,cupbaseh]) rotate([0,cupangle,0]) {
		  translate([0,0,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(0.1,cupwall,cupbelowh,smallcornerd);
		}
	      }
	    }
	
	    translate([cuplength,0,cupbaseh]) rotate([0,-cupangle,0]) {
	      hull() {
		translate([-cupwall/2,-cupaxlewidth/2-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([-cupwall/2,-cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	      hull() {
		translate([-cupwall/2,0-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([-cupwall/2,cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	    }
	
	    translate([-cuplength,0,cupbaseh]) rotate([0,cupangle,0]) {
	      hull() {
		translate([0,-cupaxlewidth/2-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([0,-cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	      hull() {
		translate([0,0-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([0,cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	    }
	  }
	  
	  // Magnet holder cutout
	  hull() {
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance,$fn=60);
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall+magnetd-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance,$fn=60);
	  }
	}
      }

      // Funnel structure
      funnel();

      // Bottom plate
      translate([-basel,-basew/2,0]) roundedbox(2*basel,basew,cupwall,cornerd);

      // Center support to avoid hinge support flexing
      hull() {
	translate([0,-cupaxlewidth/2+cupwall*2+ytolerance,cupaxleheight]) rotate([-90,0,0]) cylinder(d=cupwall,h=cupaxlewidth/2-cupwall*2,$fn=30);
	translate([basel-cupwall,-cupaxlewidth/2+cupwall/2+cupwall+ytolerance,0]) roundedbox(cupwall,cupwall*2,cupwall,cornerd);
      }
      hull() {
	translate([0,cupaxlewidth/2-cupwall*2-ytolerance,cupaxleheight]) rotate([90,0,0]) cylinder(d=cupwall,h=cupaxlewidth/2-cupwall*2,$fn=30);
	translate([basel-cupwall,cupaxlewidth/2-cupwall/2-cupwall-ytolerance-cupwall*2,0]) roundedbox(cupwall,cupwall*2,cupwall,cornerd);
      }

      // Hinge supports
      for (yy=[-cupaxlewidth/2, cupaxlewidth/2]) {
	difference() {
	  union() {
	    for (i=[0,1]) {
	      y=(i==0)?yy-cupwall/2-ytolerance-cupwall*2:yy+cupwall/2+ytolerance;
	      hull() {
		translate([-towerw/2,y,0]) roundedbox(towerw,2*cupwall,cupaxleheight,cornerd);
		translate([0,y,cupaxleheight]) rotate([-90,0,0]) cylinder(d=towerw,h=cupwall*2);
		translate([basel-cupwall,y+cupwall/2+cupwall/4,0]) roundedbox(cupwall,cupwall/2,cupwall,cornerd);
		translate([basel-cupwall,y+cupwall/2+cupwall/4,0]) roundedbox(cupwall,cupwall/2,cupwall,cornerd);
	      }
	    }
	  }
	}
      }
    }

    // Hinge cutouts
    for (yy=[-cupaxlewidth/2, cupaxlewidth/2]) {
      translate([0,yy,cupaxleheight]) onehinge(cupaxled,cupaxlew,baseaxlesupportwall+0.01,1,ytolerance,axledtolerance);
    }
  }
}

module rainmeter() {
  cups();
}

if (print==0) {
  intersection() {
    rainmeter();
    //                      translate([-basel*2,-basew,0]) cube([basel*4,basew-10,100]);
  }
 }

if (print==1) translate([0,0,basel]) rotate([0,90,0]) rainmeter();

//translate([60,0,0]) triangletest();
