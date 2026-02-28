// Filament holder for wide rolls.

// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <threadlib/threadlib.scad>

// height=x
// depth=y
// width=z

print=0; // 1=left, 2=right, 3=both, 4=lockpin, 5=cutter
debug=0;
dodebug=print>0?0:debug;

m20div=1.3;
m20drext=1.5830/m20div;
m20drint=1.5330/m20div+0.1;

MY_THREAD_TABLE=[
		 ["M20-ext", [2.5, 8.3120+(1.1583-m20drext)+0.1, 16.9380+(1.5830-m20drext)*2, [[0, -1.0929], [0, 1.0929], [m20drext+0.1, 0.1790], [m20drext+0.1, -0.1790]]]],
		 //["M20-ext", [2.5, 8.3120, 16.9380, [[0, -1.0929], [0, 1.0929], [m20drext+0.1, 0.1790], [m20drext+0.1, -0.1790]]]],
		 ["M20-int", [2.5, -10.2925, 20.2925, [[0, 1.2304], [0, -1.2304], [m20drint, -0.3453], [m20drint, 0.3453]]]]
		 ];

$fn=90;
versiontext="V1.5";
font="Liberation Sans:style=Bold";
textdepth = 0.5;
textsize=7;

wall=2;
maxbridge=10;

xtolerance=0.30;
ytolerance=0.30;
ztolerance=0.30;
dtolerance=0.70;
cornerd=1;

rollwidth=75;
rolldiameteroutside=200;
rolldiameterinside=35; //3;
rollextra=5; // Distance from backplate to roll
rollborediameter=rolldiameterinside-2*rollextra;
rolltubew=40;
rolltubenarrowing=10;

backplateheight=150;
backplatedepth=10;
frontheight=75;
holdersupportdepth=rolldiameteroutside/2+backplatedepth;
holdersupportwidth=10;
holdersupportupdepth=25;
backplatewidth=rollwidth+holdersupportwidth*2;

rollaxisdepth=130; //rolldiameteroutside/2+backplatedepth+rollextra;
rollaxisheight=backplateheight-rolldiameterinside/2; // rolldiameteroutside/2;
rollborewidth=45; // rollwidth + 2*holdersupportwidth + 10;

rollnarrowingh=10;
rollnarrowingd=rolldiameterinside-8;

rolloverlapd=rollborediameter-dtolerance;
rolloverlaph=30;
rolloverlapheight=rollwidth-rolloverlaph; //rollwidth*2/3;
rolloverlapnarrowingh=10;
rolloverlapnarrowingd=rolloverlapd-10;

rolllockcut=0.5;
rolllockd=6;
rolllockdepth=rolllockd/3;

lockpinw=9;
lockpinfromedge=5;
lockpinfrombottom=10;
lockpinh=3;
lockpinextendl=10;
lockpinextendw=lockpinw+4;
lockpinextendh=lockpinh+2;

filamentholed=4;

fingerwidth=lockpinfromedge+lockpinw+lockpinfromedge+ztolerance; //30;
fingerdepth=5;
fingerdepthposition=1.5;
fingerheight=20;
fingerupper=backplateheight - 25 - fingerheight; // rollaxisheight*2+backplatedepth/2-10-fingerheight;
fingerlower=20;
fingernotchdepth=1; //backplatedepth;
fingernotchmalediameter=1.5;
fingernotchwidth=3;
fingerholediameter=4;
fingernarrowing=3;

tolerance=0.3;
tolerancedepth=0.5;
diametertolerance=0.97; // 97;
  
holeedge=63;
roundholediameter=40;
holezadjust=6;

lockpinhandleh=17;
lockpinhandlew=30;
lockpinhandlethickness=backplatedepth+10;
lockpinhandlecornerd=5;
lockpinhandlefingerd=20;
lockpinhandlefingersink=5;

lockpinl=backplateheight-lockpinfrombottom+lockpinhandlecornerd;
lockpinheight=lockpinfrombottom;
lockpinhandleheight=lockpinl-lockpinhandlecornerd+xtolerance;

boltturns=5;
boltholespecs=thread_specs("M20-int",table=MY_THREAD_TABLE);
boltholepitch=boltholespecs[0];
boltholed=boltholespecs[2];
boltholel=(boltturns+1)*boltholespecs[0];
boltspecs=thread_specs("M20-ext",table=MY_THREAD_TABLE);
boltpitch=boltspecs[0];
boltd=boltspecs[2];
boltl=(boltturns+1)*boltpitch;
boltbasel=7;
boltbaseh=7;
boltbased=boltd+10;

sidebolty=45;
sideboltx=30;
sidebolth=holdersupportwidth;
boltbodyd=boltholed+10;

smalltronxyholdersideh=10;
smalltronxyholderheight=-boltholel-smalltronxyholdersideh;
smalltronxyholderh=smalltronxyholdersideh;
smalltronxyholderbarh=21;
smalltronxyholderbarw=21;
smalltronxyholderbary=10;

supportringl=holdersupportwidth;
supportringdepth=2;
boltthreadh=ztolerance+supportringl-supportringdepth+boltbasel;

frontboltheight=holdersupportwidth+rollwidth/2;
frontbolty=holdersupportwidth+5+boltbased/2;
frontboltx=0;
frontbolth=holdersupportwidth;

module attachbolt() {
  rotate([180,0,0]) {
    difference() {
      union() {
	translate([0,0,0]) roundedcylinder(boltbased,boltbasel,cornerd,1,6);
	translate([0,0,boltbasel-cornerd]) roundedcylinder(boltholed,supportringl-supportringdepth+cornerd,1,90);
	translate([0,0,supportringl-supportringdepth+boltbasel-0.01]) cylinder(d=boltd,h=ztolerance+0.02);
	translate([0,0,boltthreadh]) bolt("M20",turns=boltturns,table=MY_THREAD_TABLE);
	hull() {
	  translate([0,0,boltthreadh+supportringl+boltpitch/2+boltpitch-cornerd/2]) roundedcylinder(boltd,cornerd,cornerd,0,90);
	  translate([0,0,boltthreadh+supportringl+boltpitch/2+boltpitch+cornerd]) roundedcylinder(boltd-cornerd*2,cornerd,cornerd,0,90);
	}
      }

      translate([0,0,-0.01]) linear_extrude(textdepth) rotate([180,0,0]) text(versiontext,size=textsize,font=font,valign="center",halign="center");
    }
  }
}

module boltcutout() {
  translate([0,0,boltholepitch/2-0.01]) tap("M20",turns=boltturns,table=MY_THREAD_TABLE);
  translate([0,0,-0.01+boltholel-0.01]) cylinder(d=boltholed,h=0.01,$fn=90);
}

module roll() {
#  translate([rollaxisheight,rollaxisdepth,holdersupportwidth]) difference() {
    cylinder(d=rolldiameteroutside,h=rollwidth);
    translate([0,0,-0.1]) cylinder(d=rolldiameterinside+wall*2,h=rollwidth+0.2);
  }
}

module holder() {
  difference() {
    union() {
      difference() {
	union() {
	  difference() {
	    union() {
	      roundedbox(backplateheight,backplatedepth,backplatewidth,cornerd,3);
	    }

	    // Lightening holes
	    for (x=[backplateheight/4+5/2,backplateheight*3/4-15/2]) {
	      h=(backplateheight+15)/2;
	      translate([x-h/2,0,0]) lighten(h,backplatewidth-lockpinw-lockpinfromedge-5,backplatedepth+1,15,10,10,"up");
	    }
    
	    // Lightening holes in roll supports
	    for (z=[backplatedepth*3/4,backplatewidth-backplatedepth-backplatedepth*3/4]) {
	      ze=backplatedepth/2;
	      e=backplatedepth*2/3;
      
	      difference() {
		hull() {
		  union() {
		    hull() {
		      for (x=[backplatedepth*2,backplateheight-backplatedepth*2]) {
			for (y=[backplatedepth*2]) {
			  translate([x,y,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
			}
		      }
		      translate([backplatedepth*2,frontheight-backplatedepth*2,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
		      translate([backplateheight-backplatedepth*2,rollaxisdepth-backplatedepth,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
		    }
		  }

		  union() {
		    hull() {
		      for (x=[backplatedepth*2,backplateheight-backplatedepth*2]) {
			for (y=[backplatedepth*2]) {
			  translate([x,y,z+ze]) cylinder(h=0.1,d=backplatedepth+abs(e));
			}
		      }
		      translate([backplatedepth*2,frontheight-backplatedepth*2,z+ze]) cylinder(h=0.1,d=backplatedepth+abs(e));
		      translate([backplateheight-backplatedepth*2,rollaxisdepth-backplatedepth,z+ze]) cylinder(h=0.1,d=backplatedepth+abs(e));
		    }
		  }
		}

		translate([rollaxisheight,rollaxisdepth,z-0.1]) cylinder(d=rolldiameterinside,h=holdersupportwidth+cornerd+0.2);	
	      }
	    }
	  }

	  for (z=[0,backplatewidth-holdersupportwidth]) {
	    translate([0,0,z]) hull() {
	      translate([backplatedepth/2,backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,z==0?1:2,$fn);
	      translate([backplatedepth/2,frontheight-backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,z==0?1:2,$fn);
	      translate([rollaxisheight,rollaxisdepth,0]) roundedcylinder(rolldiameterinside,holdersupportwidth,cornerd,z==0?1:2,$fn);
	      translate([backplateheight-backplatedepth/2,backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,z==0?1:2,$fn);
	    };
	  }

	  // Left roll holder (female)
	  translate([rollaxisheight,rollaxisdepth,0]) {
	    difference() {
	      roundedcylinder(rolldiameterinside,holdersupportwidth+rolloverlapheight+rollnarrowingh-ztolerance*2,cornerd,1,$fn);
	      hull() {
		translate([0,0,rolloverlapheight+rollnarrowingh-ztolerance]) roundedcylinder(rollnarrowingd,rollnarrowingh,cornerd,1,$fn);
		translate([0,0,holdersupportwidth+rolloverlapheight+rollnarrowingh-ztolerance]) roundedcylinder(rolldiameterinside,rollnarrowingh,cornerd,1,$fn);
	      }
	    }
	  }
	}

	translate([rollaxisheight,rollaxisdepth,-0.1]) {
	  hull() {
	    cylinder(h=holdersupportwidth+rolloverlapheight+0.2,d=rollborediameter);
	    //	translate([0,0,rollwidth-rolltubew-holdersupportwidth-wall*2]) cylinder(h=rolltubenarrowing,d=rollborediameter-wall*2);
	  }
	}


	translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph+rolloverlapnarrowingh+rolllockd/2]) rotate([0,0,90]) tubeclip(rolloverlapd+rolllockdepth,rolllockd,xtolerance);

	hull() {
	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight]) rotate([0,0,90]) tubeclip(rolloverlapd+rolllockdepth,rolllockd,xtolerance*2);
	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolllockd]) rotate([0,0,90]) tubeclip(rolloverlapd,rolllockd,xtolerance);
	}
    
	// Lightening holes in roll supports
	for (z=[0,backplatewidth-backplatedepth]) {
	  difference() {
	    union() {
	      hull() {
		for (x=[backplatedepth*2,backplateheight-backplatedepth*2]) {
		  for (y=[backplatedepth*2]) {
		    translate([x,y,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
		  }
		}
		translate([backplatedepth*2,frontheight-backplatedepth*2,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
		translate([backplateheight-backplatedepth*2,rollaxisdepth-backplatedepth,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
	      }
	    }

	    translate([rollaxisheight,rollaxisdepth,z]) roundedcylinder(rolldiameterinside,holdersupportwidth+cornerd,cornerd,0,$fn);	
	  }

	  for (i=[0:2:6]) {
	    y=frontheight-backplatedepth-filamentholed*i;
	    translate([backplatedepth-filamentholed/2,y,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=filamentholed);
	  }
	}
      }
      
      hull() {
	translate([0,0,0]) roundedbox(sideboltx+boltbodyd/2,boltbodyd/2,sidebolth,cornerd,1);
	translate([sideboltx,sidebolty,0]) roundedcylinder(boltbodyd,sidebolth,cornerd,1,90);
      }
      
      hull() {
	translate([frontboltx,0,0]) roundedbox(frontbolth,frontbolth,frontboltheight+boltbodyd/2,cornerd,1);
	translate([frontboltx,frontbolty,frontboltheight]) rotate([0,90,0]) roundedcylinder(boltbodyd,frontbolth,cornerd,1,90);
      }

      hull() {
	translate([0,holdersupportwidth+1,holdersupportwidth+rollwidth]) roundedbox(sideboltx+boltbodyd/2,boltbodyd/2-holdersupportwidth-1,sidebolth,cornerd,1);
	translate([sideboltx,sidebolty,holdersupportwidth+rollwidth]) roundedcylinder(boltbodyd,sidebolth,cornerd,1,90);
      }
    }

    translate([sideboltx,sidebolty,-0.01]) cylinder(d=boltholed,h=sidebolth+0.02,$fn=90);
    translate([frontboltx-0.01,frontbolty,frontboltheight]) rotate([0,90,0]) roundedcylinder(boltholed,frontbolth+0.02,cornerd,1,90);

    translate([2,holdersupportwidth-textdepth+0.01,holdersupportwidth+rollwidth-1]) rotate([-90,270,0]) linear_extrude(height = textdepth+0.02) text(text = str(versiontext), font = font, size = textsize, halign="right",valign="baseline");
    
    translate([2,holdersupportwidth+2-textdepth+0.01,holdersupportwidth+rollwidth+textdepth-0.01]) rotate([0,180,-90]) linear_extrude(height = textdepth) text(text = str(versiontext), font = font, size = textsize, valign="bottom", halign="left");
  }
}

module lockpin() {
  difference() {
    union() {
      hull() {
	translate([lockpinh/1.5,0,0]) roundedbox(lockpinl-lockpinh/1.5,lockpinh,lockpinw,cornerd,4);
	translate([lockpinh/3,0,lockpinw/4]) roundedbox(lockpinl-lockpinh/3,lockpinh,lockpinw-lockpinw/2,cornerd,4);
	translate([0,lockpinh/4,lockpinw/4]) roundedbox(lockpinl,lockpinh/2,lockpinw/2,cornerd,0);
      }
      minkowski(convexity=10) {
	render() union() {
	  difference() {
	    translate([lockpinhandleheight+lockpinhandlecornerd/2,lockpinhandlecornerd/2,lockpinw/2-lockpinhandlew/2+lockpinhandlecornerd/2]) cube([lockpinhandleh-lockpinhandlecornerd,lockpinhandlethickness-lockpinhandlecornerd,lockpinhandlew-lockpinhandlecornerd]);

	    translate([lockpinhandleheight+lockpinhandleh+lockpinhandlefingerd/2-lockpinhandlefingersink,lockpinhandlethickness/2,lockpinw/2-lockpinhandlew/2]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlew,$fn=30);
	    translate([lockpinhandleheight-lockpinhandlefingerd/2+lockpinhandlefingersink,lockpinhandlethickness/2,lockpinw/2-lockpinhandlew/2]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlew,$fn=30);
	    translate([lockpinhandleheight,lockpinhandlethickness/2,lockpinw/2-lockpinhandlew/2-lockpinhandlefingerd/2+lockpinhandlefingersink]) rotate([0,90,0]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlethickness,$fn=30);
	    translate([lockpinhandleheight,lockpinhandlethickness/2,lockpinw/2+lockpinhandlew/2+lockpinhandlefingerd/2-lockpinhandlefingersink]) rotate([0,90,0]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlethickness,$fn=30);
	  }
	}

	hull() {
	  sphere(d=lockpinhandlecornerd,$fn=30);
	  rotate([90,0,0]) translate([0,0,-lockpinhandlecornerd/2]) cylinder(d=lockpinhandlecornerd/3,h=lockpinhandlecornerd,$fn=30);
	}
      }
    }
  
  translate([lockpinhandleheight+lockpinhandleh/2,lockpinhandlethickness-textdepth+0.01,lockpinw/2]) rotate([-90,270,0]) linear_extrude(height = textdepth) text(text = "Open", font = font, size = textsize - 1, valign="center", halign="center");

  translate([fingerlower,lockpinh-textdepth+0.01,lockpinw/2]) rotate([-90,180,0]) linear_extrude(height = textdepth) text(text = versiontext, font = font, size = max(textsize-2,lockpinw-2), valign="center", halign="center");
  }
}

module left() {
  difference() {
    holder();
    translate([-0.01,-0.01,holdersupportwidth+rollwidth-0.01]) cube([backplateheight+20+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+1],center=false);
    for (x=[fingerupper,fingerlower]) {
      // Finger holes
      hull() {
	translate([x-xtolerance,-0.01,holdersupportwidth+rollwidth-fingerwidth-ztolerance]) cube([fingerheight+xtolerance*2,0.01,fingerwidth+tolerance],center=false);
	translate([x-(backplatedepth-lockpinh)/2-xtolerance,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-fingerwidth-ztolerance]) cube([fingerheight+backplatedepth-lockpinh+xtolerance*2,lockpinh+ytolerance*2,fingerwidth+tolerance],center=false);
	translate([x-xtolerance,backplatedepth,holdersupportwidth+rollwidth-fingerwidth-ztolerance]) cube([fingerheight+xtolerance*2,0.01,fingerwidth+tolerance],center=false);
      }

      // Space for lock pin
      hull() {
	translate([backplateheight-lockpinextendl,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw-ztolerance]) cube([lockpinextendl+0.01,lockpinh+ytolerance*2,lockpinw+ztolerance*2]);
	translate([backplateheight,backplatedepth/2-lockpinextendh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw/2-lockpinextendw/2-ztolerance]) cube([0.01,lockpinextendh+ytolerance*2,lockpinextendw+ztolerance*2]);
      }
      translate([lockpinheight-xtolerance,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw-ztolerance]) cube([lockpinl+xtolerance*2,lockpinh+ytolerance*2,lockpinw+ztolerance*2]);

      // Temprary space for lock pin to put into while changing rolls
      z=backplatewidth-lockpinhandlew-lockpinw+ztolerance;//0,-45,0
      translate([backplateheight+lockpinextendl+lockpinh,0,z]) rotate([0,-30,0]) translate([lockpinl/2-backplateheight,backplatedepth/2-lockpinh/2-ytolerance,0]) {
	cube([lockpinl/2+xtolerance*2,lockpinh+ytolerance*2,lockpinw+ztolerance*4]);
	hull() {
	  translate([lockpinl/2-lockpinextendl*2,0,0]) cube([lockpinextendl*2,lockpinh+ytolerance*2,lockpinw+ztolerance*4]);
	  translate([lockpinl/2,lockpinh/2-lockpinextendh/2,lockpinw/2-lockpinextendw/2-2]) cube([0.01,lockpinextendh+ytolerance*2,lockpinextendw+3]);
	}
      }
    }
  }
}

module right() {
  difference() {
    union() {
      difference() {
	union() {
	  holder();
	}
	translate([-0.01,-0.01,-0.01]) cube([backplateheight+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+rollwidth+0.01],center=false);
	translate([sideboltx,sidebolty,holdersupportwidth+rollwidth-0.01]) cylinder(d=boltholed,h=sidebolth+0.02,$fn=90);
      }

      for (x=[fingerupper,fingerlower]) {
	hull() {
	  translate([x,0,holdersupportwidth+rollwidth-fingerwidth+fingernarrowing]) roundedbox(fingerheight,cornerd,fingerwidth-fingernarrowing+cornerd,cornerd);
	  translate([x-(backplatedepth-lockpinh)/2,backplatedepth/2-lockpinh/2,holdersupportwidth+rollwidth-fingerwidth+fingernarrowing]) roundedbox(fingerheight+backplatedepth-lockpinh,lockpinh,fingerwidth-fingernarrowing+cornerd,cornerd);
	  translate([x,backplatedepth-cornerd,holdersupportwidth+rollwidth-fingerwidth+fingernarrowing]) roundedbox(fingerheight,cornerd,fingerwidth-fingernarrowing+cornerd,cornerd);

	  translate([x+1,0,holdersupportwidth+rollwidth-fingerwidth]) roundedbox(fingerheight-2,backplatedepth,fingernarrowing,cornerd);
	}
	
	// right roll holder (male)
	union() {
	  translate([rollaxisheight,rollaxisdepth,rolloverlapheight+ztolerance+rollnarrowingh]) {
	    hull() {
	      translate([0,0,rollnarrowingh]) roundedcylinder(rolldiameterinside,backplatewidth-rolloverlapheight-rollnarrowingh-ztolerance-holdersupportwidth,cornerd,2,$fn);
	      roundedcylinder(rollnarrowingd,rollnarrowingh,cornerd,0,$fn);
	    }
	  }

	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph]) {
	    hull() {
	      translate([0,0,rolloverlapnarrowingh]) roundedcylinder(rolloverlapd,rolloverlaph+wall,cornerd,1,$fn);
	      roundedcylinder(rolloverlapnarrowingd,rolloverlaph+wall,cornerd,1,$fn);
	    }
	  }

	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph+rolloverlapnarrowingh+rolllockd/2]) rotate([0,0,90]) tubeclip(rolloverlapd+rolllockdepth,rolllockd,0);
	}
      }
    }
  
    // Space for lock pin
    translate([lockpinheight-xtolerance,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw-ztolerance]) cube([lockpinl+xtolerance*2,lockpinh+ytolerance*2,lockpinw+ztolerance*2]);

    // Right roll insides cut
    union() {
      translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight+rollnarrowingh]) {
	hull() {
	  translate([0,0,wall]) cylinder(h=rollwidth+holdersupportwidth-rolloverlapheight-rollnarrowingh-wall+0.1,d=rollborediameter);
	  //translate([0,0,wall]) cylinder(h=rolltubew-holdersupportwidth-wall+0.1,d=rollborediameter);
	  translate([0,0,-holdersupportwidth+rolltubenarrowing/2]) cylinder(h=rolltubenarrowing-wall,d=rolloverlapd-wall*2);
	}
      }

      translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph]) {
	hull() {
	  translate([0,0,rolloverlapnarrowingh]) roundedcylinder(rolloverlapd-wall*2,rolloverlaph+0.1,cornerd,1,$fn);
	  translate([0,0,wall]) roundedcylinder(rolloverlapnarrowingd-wall,rolloverlaph,cornerd,1,$fn);
	}
      }
    }

    translate([rollaxisheight-rolllockd/2,rollaxisdepth-rolloverlapd/2,holdersupportwidth+rolloverlapheight-rolloverlaph+rolloverlapnarrowingh-0.1]) {
      for (x=[-rolllockcut,rolllockd]) {
	translate([x,0,0]) cube([rolllockcut,rolloverlapd,rolloverlaph-rolloverlapnarrowingh]);
      }
      hull() {
	translate([-rolllockcut,0,0]) cube([rolllockcut,rolloverlapd,rolllockcut]);
	translate([rolllockd/2-rolllockcut/2,0,-rolllockd/2]) cube([rolllockcut,rolloverlapd,rolllockcut]);
      }
      hull() {
	translate([rolllockd,0,0]) cube([rolllockcut,rolloverlapd,rolllockcut]);
	translate([rolllockd/2-rolllockcut/2,0,-rolllockd/2]) cube([rolllockcut,rolloverlapd,rolllockcut]);
      }
    }

    //    translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-cutteraxlesupportl+cutteraxleind/3-10+ztolerance]) cylindervoids(cutteraxleind,cutteraxleind,holdersupportwidth+cutteraxlesupportl-cutteraxleind/3+10-ztolerance,0,0,1);
  }
}

module smalltronxyholder() {
  c=5;
  difference() {
    union() {
      h=max(smalltronxyholdersideh+boltholel,smalltronxyholderbarh+smalltronxyholdersideh);
      height=-h;
      translate([sideboltx,sidebolty,height]) roundedcylinder(boltbodyd,h,cornerd,1,90);
      translate([sideboltx-boltbodyd/2,0,height]) roundedbox(boltbodyd,smalltronxyholderbary,h,c,1);
      hull() {
	translate([sideboltx,sidebolty,height]) roundedcylinder(boltbodyd,smalltronxyholdersideh,c,1,90);
	translate([sideboltx-boltbodyd/2,0,height]) roundedbox(boltbodyd,smalltronxyholderbarh,smalltronxyholdersideh,c,1);
      }
    }

    translate([sideboltx,sidebolty,-boltl+0.1]) boltcutout(); //tap("M20",turns=boltturns,table=MY_THREAD_TABLE);
  }
}

if (print==0) {
  intersection() {
    difference() {
      union() {
	left();
	right();
	translate([lockpinheight,backplatedepth/2-lockpinh/2,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw]) lockpin();
	translate([0,0,-0.01]) smalltronxyholder();
      }

      #     roll();
       translate([sideboltx,sidebolty,sidebolth+boltbaseh]) attachbolt();
    }
    
    //if (dodebug) translate([0,backplatedepth/2,0]) cube([rollaxisheight,1000,1000]);
    if (dodebug) translate([sideboltx,-1000,-1000]) cube([2000,2000,2000]);
  }
 }

if (print == 1 || print== 3) {
  translate([115,-rolldiameterinside,0]) rotate([0,0,90]) left();
 }


if (print == 2 || print == 3) {
  translate([15,-115,0]) rotate([180,0,150.5]) translate([0,0,-backplatewidth]) right();
 }

if (0 && (print == 3)) {
  rotate([0,0,90]) {
    difference() {
      union() {
	translate([-backplateheight/2,-rolldiameteroutside/2,0]) union() {
	  left();
  
	  translate([rollaxisheight*2+rolldiameterinside+70,backplatewidth-rolldiameterinside-9+lockpinw,backplatewidth]) rotate([180,0,-70.5]) right();
	}
      }
    }
  }
 }

if (print==3) {    
  //      #    printareacube("ankermake");
 }

if (print==4) {
  rotate([0,0,90]) translate([-20,-7,0]) rotate([90,0,0]) rotate([0,75+70-0.3,0]) translate([-102,0,0]) lockpin();
 }

if (print==5) {
  translate([0,0,smalltronxyholderbarh+smalltronxyholdersideh]) intersection() {
    if (debug) translate([sideboltx,-1000,-1000]) cube([2000,2000,2000]);
    smalltronxyholder();
  }
  translate([2,boltd,0]) rotate([180,0,360/12]) attachbolt();
 }

