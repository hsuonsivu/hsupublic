// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Berry cleaner

include <hsu.scad>

print=0; // 0=both units for testing, 1=cleaner, 2=box co collect litter

// Length is limited by bed size, width of 200 seems practical.
maxlength=360;
maxwidth=300; //360

versiontext="Berrycleaner v1.6";
textsize=7;
textdepth=1;

berryslitw=5; // Measured more than 6.5mm for berries.
supportdistance=43;
barw=1.5;
barh=3;
frontslideh=4;
frontslidel=(berryslitw+barw)*3;
supportw=1.5;
supporth=2;
height=50;
cornerd=5;
wall=2; //1.6;// 2.5

length=floor(maxlength/(supportdistance+supportw)) * (supportdistance+supportw); // y, 220
width=floor(maxwidth/(berryslitw+barw)) * (berryslitw+barw); // x, 200

echo(length,width);

narrowstart=length-100;
narroww=100;

tolerance=0.3;
below=7;
midh=10;
toph=20;
topout=2;
in=wall;
out=wall+tolerance;

module berrycleaner() {
  difference() {
    union() {
      intersection() {
	union() {
	  for (x=[0:berryslitw+barw:width]) {
	    translate([x,0,-barw]) roundedbox(barw,length+supportw,barh+barw,barw); // cube([barw,length,barh+barw]);
	  }

	  for (y=[0:supportdistance+supportw:length]) {
	    translate([0,y,0]) cube([width,supportw,supporth]);
	  }
	}
	translate([0,0,-cornerd]) roundedbox(width,length+wall,height,cornerd);
      }
      difference() {
	union() {
	  translate([0,0,-cornerd]) roundedbox(wall,narrowstart+wall,height,wall);
	  translate([width-wall,0,-cornerd]) roundedbox(wall,narrowstart+wall,height,wall);
	  translate([0,0,-cornerd]) roundedbox(width,wall,height,wall);
	}

	translate([width/2,textdepth-0.01,height/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
      }

      hull() {
	translate([0,narrowstart,-cornerd]) roundedbox(wall,wall,height,wall);
	translate([width/2-narroww/2,length,-cornerd]) roundedbox(wall,wall,height,wall);
      }

      hull() {
	translate([0,narrowstart,-cornerd]) roundedbox(wall,wall,frontslideh+cornerd,wall);
	translate([width/2-narroww/2,length,-cornerd]) roundedbox(wall,wall,frontslideh+cornerd,wall);
	translate([0,narrowstart-frontslidel,-cornerd]) roundedbox(wall,wall,supporth+cornerd,wall);
	translate([width/2-narroww/2+frontslidel,length,-cornerd]) roundedbox(wall,wall,supporth+cornerd,wall);
      }

      hull() {
	translate([width-wall,narrowstart,-cornerd]) roundedbox(wall,wall,height,wall);
	translate([width/2+narroww/2,length,-cornerd]) roundedbox(wall,wall,height,wall);
      }

      hull() {
	translate([width-wall,narrowstart,-cornerd]) roundedbox(wall,wall,frontslideh+cornerd,wall);
	translate([width/2+narroww/2,length,-cornerd]) roundedbox(wall,wall,frontslideh+cornerd,wall);
	translate([width-wall,narrowstart-frontslidel,-cornerd]) roundedbox(wall,wall,supporth+cornerd,wall);
	translate([width/2+narroww/2-frontslidel,length,-cornerd]) roundedbox(wall,wall,supporth+cornerd,wall);
      }
    }
    translate([0,narrowstart+wall,-cornerd]) triangle(width/2-narroww/2,length-narrowstart,height,7);
    translate([width/2+narroww/2+wall,narrowstart+wall,-cornerd]) triangle(width/2-narroww/2-wall,length-narrowstart,height,4);
    
    translate([-0.1,narrowstart+wall,-cornerd]) cube([0.11,length-narrowstart,height]);
    translate([width-0.1,narrowstart+wall,-cornerd]) cube([1,length-narrowstart,height]);


    translate([-0.1,-0.1,-cornerd-0.1]) cube([width+0.2,length+wall+0.2,cornerd+0.1]);
  }
}

module berrycleanerbase() {
  translate([0,0,-height-0.01]) {
    difference() {
      union() {

	// Bottom
	hull() {
	  translate([0,0,0]) roundedbox(wall,narrowstart+wall,wall,wall);
	  translate([width-wall,0,0]) roundedbox(wall,narrowstart+wall,wall,wall);
	  translate([0,0,0]) roundedbox(width,wall,wall,wall);
	  
	  hull() {
	    translate([0,narrowstart,0]) roundedbox(wall,wall,wall,wall);
	    translate([width/2-narroww/2,length-height+below,0]) roundedbox(wall,wall,wall,wall);
	  }

	  hull() {
	    translate([width-wall,narrowstart,0]) roundedbox(wall,wall,wall,wall);
	    translate([width/2+narroww/2,length-height+below,0]) roundedbox(wall,wall,wall,wall);
	  }
	}

	// Support for box above and extend out
	union() {
	  hull() {
	    translate([width/2-narroww/2,length,height-below]) roundedbox(narroww+wall,wall,wall,wall);
	    translate([width/2-narroww/2,length-in,height-wall]) roundedbox(narroww+wall,wall+in+out,wall,wall);
	  }
	  hull() {
	    translate([0,0,height-below]) roundedbox(wall,narrowstart+wall,wall,wall);
	    translate([-out,-out,height-wall]) roundedbox(wall+in+out,narrowstart+wall+out+out,wall,wall);
	  }
	  hull() {
	    translate([width-wall,0,height-below]) roundedbox(wall,narrowstart+wall,wall,wall);
	    translate([width-wall-in,-out,height-wall]) roundedbox(wall+in+out,narrowstart+wall+out+out,wall,wall);
	  }
	  hull() {
	    translate([0,0,height-below]) roundedbox(width,wall,wall,wall);
	    translate([-out,-out,height-wall]) roundedbox(width+out+out,wall+in+out,wall,wall);
	  }
	  
	  hull() {
	    translate([0,narrowstart,height-below]) roundedbox(wall,wall,wall,wall);
	    translate([-out,narrowstart-in,height-wall]) roundedbox(wall+in+out,wall+in+out,wall,wall);
	    translate([width/2-narroww/2,length,height-below]) roundedbox(wall,wall,wall,wall);
	    translate([width/2-narroww/2-out,length-in,height-wall]) roundedbox(wall+in+out,wall+in+out,wall,wall);
	  }
	  hull() {
	    translate([width-wall,narrowstart,height-below]) roundedbox(wall,wall,wall,wall);
	    translate([width/2+narroww/2-in,length-in,height-wall]) roundedbox(wall+in+out,wall+in+out,wall,wall);
	    translate([width-wall-in,narrowstart-in,height-wall]) roundedbox(wall+in+out,wall+in+out,wall,wall);
	    translate([width/2+narroww/2,length,height-below]) roundedbox(wall,wall,wall,wall);
	  }
	}

	// Guides to allow easy align of the box above
	union() {
	  hull() {
	    translate([-out,-out,height-wall]) roundedbox(wall,narrowstart+wall+out+out,midh,wall);
	  }
	  hull() {
	    translate([width-wall+out,-out,height-wall]) roundedbox(wall,narrowstart+wall+out+out,midh,wall);
	  }
	  hull() {
	    translate([-out,-out,height-wall]) roundedbox(width+out+out,wall,midh,wall);
	  }
	  
	  hull() {
	    translate([-out,narrowstart+out,height-wall]) roundedbox(wall,wall,midh,wall);
	    translate([width/2-narroww/2-out,length+out,height-wall]) roundedbox(wall,wall,midh,wall);
	  }
	  hull() {
	    translate([width/2+narroww/2+out,length+out,height-wall]) roundedbox(wall,wall,midh,wall);
	    translate([width-wall+out,narrowstart+out,height-wall]) roundedbox(wall,wall,midh,wall);
	  }
	}

	// Top part of guides
	union() {
	  hull() {
	    translate([-out,-out,height+midh-2*wall]) roundedbox(wall,narrowstart+wall+out+out,wall,wall);
	    translate([-out-topout,-out-topout,height+toph-2*wall]) roundedbox(wall,narrowstart+wall+out+out+topout,wall,wall);
	  }
	  hull() {
	    translate([width-wall+out,-out,height+midh-2*wall]) roundedbox(wall,narrowstart+wall+out+out,wall,wall);
	    translate([width-wall+out+topout,-out-topout,height+toph-2*wall]) roundedbox(wall,narrowstart+wall+out+out+topout,wall,wall);
	  }
	  hull() {
	    translate([-out,-out,height+midh-2*wall]) roundedbox(width+out+out,wall,wall,wall);
	    translate([-out-topout,-out-topout,height+toph-2*wall]) roundedbox(width+out+out+topout*2,wall,wall,wall);
	  }
	  
	  hull() {
	    translate([-out,narrowstart+out,height+midh-2*wall]) roundedbox(wall,wall,wall,wall);
	    translate([width/2-narroww/2-out-topout,length+out,height+toph-2*wall]) roundedbox(wall,wall,wall,wall);
	    translate([-out-topout,narrowstart+out,height+toph-2*wall]) roundedbox(wall,wall,wall,wall);
	    translate([width/2-narroww/2-out,length+out,height+midh-2*wall]) roundedbox(wall,wall,wall,wall);
	  }
	  hull() {
	    translate([width/2+narroww/2+out,length+out,height+midh-2*wall]) roundedbox(wall,wall,wall,wall);
	    translate([width-wall+out+topout,narrowstart+out,height+toph-2*wall]) roundedbox(wall,wall,wall,wall);
	    translate([width/2+narroww/2+out+topout,length+out,height+toph-2*wall]) roundedbox(wall,wall,wall,wall);
	    translate([width-wall+out,narrowstart+out,height+midh-2*wall]) roundedbox(wall,wall,wall,wall);
	  }
	}
	  
	difference() {
	  union() {
	    hull() {
	      translate([width/2-narroww/2,length,height-below]) roundedbox(narroww+wall,wall,wall,wall);
	      translate([width/2-narroww/2,length-height+below,0]) roundedbox(narroww+wall,wall,wall,wall);
	    }
	    translate([0,0,0]) roundedbox(wall,narrowstart+wall,height,wall);
	    translate([width-wall,0,0]) roundedbox(wall,narrowstart+wall,height,wall);
	    translate([0,0,0]) roundedbox(width,wall,height,wall);

	    hull() {
	      translate([0,narrowstart,0]) roundedbox(wall,wall,height-below+wall,wall);
	      translate([width/2-narroww/2,length-height+below,0]) roundedbox(wall,wall,wall,wall);
	    }
	    hull() {
	      translate([0,narrowstart,height-below]) roundedbox(wall,wall,wall,wall);
	      translate([width/2-narroww/2,length-height+below,0]) roundedbox(wall,wall,wall,wall);
	      translate([width/2-narroww/2,length,height-below]) roundedbox(wall,wall,wall,wall);
	    }

	    hull() {
	      translate([width-wall,narrowstart,0]) roundedbox(wall,wall,height-below+wall,wall);
	      translate([width/2+narroww/2,length-height+below,0]) roundedbox(wall,wall,wall,wall);
	    }
	    hull() {
	      translate([width-wall,narrowstart,height-below]) roundedbox(wall,wall,wall,wall);
	      translate([width/2+narroww/2,length-height+below,0]) roundedbox(wall,wall,wall,wall);
	      translate([width/2+narroww/2,length,height-below]) roundedbox(wall,wall,wall,wall);
	    }
	  }
	  
	  translate([width/2,textdepth-0.01,height/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(str(versiontext," Base"),font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
	}
      }
    }
  }
}

if (print==0) {
  #berrycleaner();
  berrycleanerbase();
 }

if (print==1) {
  berrycleaner();
 }

if (print==2) {
  berrycleanerbase();
 }

  
