// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO: weather cover
// reed switch/sensor, ESP32

include <hsu.scad>

print=0;
grid=1;
weathercover=0;

$fn=60;

textsize=3;

xtolerance=0.35;
ytolerance=0.35;
ztolerance=0.35;
axledtolerance=0.7;
dtolerance=0.5;

cupwall=1.6;
cupwidth=20+cupwall*2;
cuph=20;
cuplength=45;
cupaxled=7;
cupbaseh=5;
cupbasesupporth=cupbaseh;
cupbelowh=15;

baseaxlesupportwall=cupwall;

cupaxleheight=25+cupwall;
cupaxlew=baseaxlesupportwall+2;
cupaxlewidth=cupwidth;

cupangle=-atan(cuph/cuplength);
cornerd=0.5;
smallcornerd=0.01;

basel=cuplength*cos(-cupangle)-cupbaseh*sin(-cupangle);
basew=cupaxlewidth+cupwall*3+ytolerance*2;

angle=0; //cupangle; //cupangle;
lowercupangle=cupangle+10;

towerw=cupaxled+1;

raincupd=90;
rainpiped=3; // Inside diameter
raincupbottomh=2;
raincupmidh=25;
raincuptoph=5;
funneltop=raincupbottomh+raincupmidh+raincuptoph;
wall=2;

stopperw=wall*3;
stopperh=wall;
stopperl=wall*3;

//magnetd=6.36;
//magneth=3.2;
magnetwall=0.8;
magnetd=4.4;
magneth=1.6;

//funnelbasew=cupaxlewidth+(cupwall/2+wall+ytolerance)*2;
funnelbasew=cupaxlewidth+(cupaxlew/2+wall+ytolerance)*2;
funnelh=cupbaseh+cupwall+cuph+max(stopperh,magnetd);
baselargerthancup=(basel*2>=90);
funneltopd=baselargerthancup?basel*2:90;
funneloffset=baselargerthancup?0:-funneltopd/2+basel;

funnelheight=cupaxleheight+funnelh;

top=funnelheight+funneltop;

gridstep=10;
gridthickness=3;
gridh=7;

weathercoveroutd=-funneloffset*2+cuplength*2+cupwidth/2; // cupwidth part could be calculated more accurately.
weathercoverringh=2;
weathercoverinsideh=raincuptoph-gridh-ztolerance;
weathercoverdroph=raincuptoph-gridh;

module weathercover() {
  translate([funneloffset,0,top+ztolerance]) ring(funneltopd+wall*2+dtolerance*1.5,wall*2,weathercoverringh);
  translate([funneloffset,0,top-(weathercoveroutd-raincupd)/2]) {
    difference() {
      cone(weathercoveroutd+wall*4,funneltopd+dtolerance*2+cupwall+wall,wall*2,weathercoverringh+ztolerance+(weathercoveroutd-raincupd)/2);
      //      translate([0,0,weathercoverringh+ztolerance*2+(weathercoveroutd-raincupd)/2]) cylinder(d=raincupd-wall*2-dtolerance,h=wall*2+0.1);
    }
  }
  translate([funneloffset,0,0]) ring(weathercoveroutd+wall*4,wall*2,top-(weathercoveroutd-raincupd)/2);
}

module funnel() {
  difference() {
    union() {
      // Sides
      translate([-basel,-funnelbasew/2,0]) roundedbox(basel*2,wall,funnelheight+wall*2,cornerd);
      translate([-basel,funnelbasew/2-wall,0]) roundedbox(basel*2,wall,funnelheight+wall*2,cornerd);

      // Extension flanges to help with printing
      translate([basel-wall,-funnelbasew/2-wall*2,0]) roundedbox(wall,wall*3,funnelheight+wall*2,cornerd);
      translate([basel-wall,funnelbasew/2-wall,0]) roundedbox(wall,wall*3,funnelheight+wall*2,cornerd);

      // Top stoppers to limit cup movement
      stopperheight = funnelheight+wall; //cupaxleheight+cuplength*sin(-cupangle)+(cupbaseh+wall)*cos(cupangle);
      hull() {
	translate([basel-stopperl,-funnelbasew/2,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([basel-stopperl-stopperw,-funnelbasew/2,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }
      hull() {
	translate([basel-stopperl,funnelbasew/2-stopperw,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([basel-stopperl-stopperw,funnelbasew/2-cupwall,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }

      hull() {
	translate([-basel,-funnelbasew/2,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([-basel,-funnelbasew/2,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }
      hull() {
	translate([-basel,funnelbasew/2-stopperw,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([-basel,funnelbasew/2-cupwall,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }
      
      // Low part of pipe
      translate([0,0,funnelheight]) cylinder(h=raincupbottomh,d1=rainpiped+wall/2,d2=rainpiped+raincupbottomh+wall*2);

      // Mid part of funnel
      hull() {
	translate([0,0,funnelheight+raincupbottomh]) cylinder(h=0.1,d=rainpiped+raincupbottomh+wall*2);
	translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=0.1,d=funneltopd);
      }

      // Top part of funnel
      translate([basel-wall,-funnelbasew/2,funnelheight+cornerd]) roundedbox(wall,funnelbasew,funneltop-raincuptoph,cornerd);
      hull() {
	translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph,d1=funneltopd,d2=funneltopd-wall);
	translate([basel-wall,-funnelbasew/2,top-raincuptoph]) roundedbox(wall,funnelbasew,cornerd,cornerd);
	intersection() {
	  translate([basel-wall,0,top-funnelbasew/2-wall/2]) rotate([0,90,0]) cylinder(h=wall,d=funnelbasew); //roundedbox(wall,funnelbasew+wall*4,raincuptoph/2,cornerd);
	  translate([basel-wall,-funnelbasew/2,top-raincuptoph]) roundedbox(wall,funnelbasew,raincuptoph,cornerd);
	}
      }

      // Top of base structure
      translate([-towerw-wall,-funnelbasew/2,funnelheight+wall]) roundedbox(towerw+basel+wall,funnelbasew,wall,cornerd);
    }

    // Cutout for funnel insides
    translate([0,0,funnelheight-0.01]) cylinder(h=raincupbottomh+0.02,d1=rainpiped,d2=rainpiped+raincupbottomh);
    hull() {
      translate([0,0,funnelheight+raincupbottomh-0.01]) cylinder(h=0.1,d=rainpiped+raincupbottomh);
      translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph+0.1,d=funneltopd-wall*2);
    }
  }

  if (grid)
#    translate([funneloffset,0,top-raincuptoph-cupwall/2]) ring(funneltopd-wall-wall,wall/2,raincuptoph+wall*2+cupwall/2,1);
  
  // Top grill
  if (grid) 
  intersection() {
    translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh-cupwall]) cylinder(h=raincuptoph+wall*4,d=funneltopd-wall*2-dtolerance);
    union() {
      for (x=[-funneltopd+1+basel:gridstep:basel-1]) {
	translate([x,-funneltopd/2,funnelheight+raincupbottomh+raincupmidh]) triangle(gridthickness,funneltopd-1,gridh,12);
      }
      for (y=[-funneltopd/2+1:gridstep:funneltopd/2-1]) {
	translate([-funneltopd+basel,y,funnelheight+raincupbottomh+raincupmidh]) triangle(funneltopd,gridthickness,gridh,22);
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
		translate([-cuplength,y-cupwall/2,cupbaseh+cuph/2+cupwall/2]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([cuplength,y-cupwall/2,cupbaseh+cuph/2+cupwall/2]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
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
	      translate([0,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/3]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+dtolerance,h=magnetwall+magneth+magnetwall+ytolerance);
	      translate([0,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+dtolerance,h=magnetwall+magneth+magnetwall+ytolerance);
	      translate([magnetd*middleadjust,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/4-magnetwall-outd]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+outd,h=cupwall);
	      translate([-magnetd*middleadjust,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/4-magnetwall-outd]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+outd,h=cupwall);
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
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance);
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall+magnetd-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance);
	  }
	}
      }

      // Funnel structure
      funnel();

      // Bottom plate
      translate([-basel,-basew/2,0]) roundedbox(2*basel,basew,cupwall,cornerd);

      // Center support to avoid hinge support flexing
      hull() {
	translate([0,-cupaxlewidth/2+cupwall*2+ytolerance,cupaxleheight]) rotate([-90,0,0]) cylinder(d=cupwall,h=cupaxlewidth/2-cupwall*2);
	translate([basel-cupwall,-cupaxlewidth/2+cupwall/2+cupwall+ytolerance,0]) roundedbox(cupwall,cupwall*2,cupwall,cornerd);
      }
      hull() {
	translate([0,cupaxlewidth/2-cupwall*2-ytolerance,cupaxleheight]) rotate([90,0,0]) cylinder(d=cupwall,h=cupaxlewidth/2-cupwall*2);
	translate([basel-cupwall,cupaxlewidth/2-cupwall/2-cupwall-ytolerance-cupwall*2,0]) roundedbox(cupwall,cupwall*2,cupwall,cornerd);
      }

      // Hinge supports
      for (yy=[-cupaxlewidth/2, cupaxlewidth/2]) {
	difference() {
	  union() {
	    for (i=[0,1]) {
	      y=(i==0)?yy-cupwall*2-cupaxlew/2-ytolerance:yy+cupaxlew/2+ytolerance;
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
    union() {
      weathercover();
      rainmeter();
    }
                   translate([funneloffset-basel*3,-basew,0]) cube([weathercoveroutd*2,basew,100]);
  }
 }

if (print==1) {
  translate([0,0,basel]) rotate([0,90,0]) rainmeter();
    translate([weathercoveroutd/2-funneloffset/2,0,0]) rotate([0,0,0]) weathercover();
 }

//translate([60,0,0]) triangletest();
