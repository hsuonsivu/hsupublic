// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

$fn=60;

print=1;
teslamodels=1;
abs=0;
phones=2;
lighten=0;
lmargin=8;
support=1; // Use slicer supports

// Add springs to base shift to keep phones better in place. Does not work very well with some wireless chargers,
// as the phone is not always fully seated because of this.
basespring=0;

cornerd=2;
forcedebug=0;
debug=(print>0)?forcedebug:forcedebug;

strong=(print>0)?1:0; // 1:0

versiontext=str("V1.10",teslamodels?"S":"");;
textdepth=0.8;
textsize=8;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
maxbridge=10;

wall=2;
supportwall=1.8;
thinwall=1.2;

chargerthickness=(phones==2?9:8.15-1);

chargerheight=(phones==2?85.2:57);
chargerwidth=(phones==2?180.2:57);
phonethickness=15;
phonewidth=81.6;
phoneheight=172; //167;
phoneheightreduction=12;
phonebottomlevel=(phones==2?31.4:48); //20; // Below bottom of charging pad
mirroring=(phones==2?[0,1]:[0]);
chargingcoildistance=(phones==2?95:0);
chargingcoildiameter=(phones==2?64:chargerwidth);
usbholewidth=10;
usbconnectorl=35;
usbholethickness=chargerthickness;
usbholed=usbholethickness;
usbconnectorw=18; // USB A, really uses C for single phone base
bottomheight=25; //5;
backthickness=2;
thicknessmargin=2;
legwidth=4; //wall;
legheight=phoneheight;
legthickness=phoneheight;
legposition=teslamodels?11:5;
phonecutdiameter=10;
phonecut=5; // Edge to which phone drops and stays in place
keycutposition=70;//5.2/2+30-55;
keycutheight=80;//55;
divideredge=chargingcoildistance-phonewidth;
microphoneholewidth=50; //45;
microphoneholedepth=40;
microphoneholeangle=45;
microphoneholeposition=0; // Offset from center
smallcornerdiameter=legwidth;
largecornerdiameter=5;
baselift=teslamodels?7:0;
supportlift=baselift;
bottomlift=teslamodels?baselift+legposition:legposition;
angle=teslamodels?28:45;
bottomy=bottomlift*sin(angle);
bottomz=bottomlift*cos(angle);
midcut=0;
thickness=chargerthickness+phonethickness+backthickness+thicknessmargin+2;

cameradepth=2; // Upper part of modern phones have protruding cameras.
cameraheight=116;
camerawidth=phonewidth-1;

screwd=3.5;
screwlength=19;

heightbaseheight=7;
heightbasesupportheight=1.8;
heightbasenarrowing=2-xtolerance;
heightbasewidth=phonewidth+heightbasenarrowing*2;
heightbasenarrowingextral=4; //6;
basespringheight=heightbaseheight+13-6+3;
basespringd=50;
basespringgap=0.5;
  
ratchetw=20;
ratchetkeyw=ratchetw-5;
ratchetkeyheight=4;
ratchetkeys=3;
ratchetwall=2;
ratchetkeydistance=ratchetkeyheight+ratchetwall;
ratchetthickness=3;
ratchetkeyh=ratchetthickness+ztolerance;
ratchetheight=bottomheight-heightbaseheight;//-bottomlift;
ratchetspringw=4;
ratchetspringthickness=2;
ratchethandlew=4;
ratchethandlethickness=10;
ratchetmaxmovement=ratchetkeydistance*2;
ratchetoffset=ratchetkeydistance*0;

centerlowerwidth=-heightbasewidth+0.01;
heightbasechargery=phonebottomlevel-ztolerance-ratchetkeydistance*2;
heightbasenarrowingl=31.4-heightbasenarrowingextral-ratchetkeydistance*2;
narrowy=ytolerance+cornerd/2+heightbasenarrowingl+heightbasenarrowingextral;
heightbasethickness=phonethickness+thicknessmargin+1+ratchetthickness-ztolerance*2;

//heightbasesiderampwidth=(phonewidth-ratchetw)/2-basespringgap-ratchetspringw+basespringgap-ratchetspringw-heightbasesiderampw;
ratchetspringwidth=ratchetspringw+basespringgap+ratchetw+basespringgap+ratchetspringw;
heightbasel=heightbaseheight+heightbasenarrowingl+heightbasenarrowingextral;

heightbaserampwidth=ratchetw+basespringgap+ratchetspringw+xtolerance+32;
heightbaserampw=(heightbaserampwidth-ratchetspringwidth)/2+xtolerance;
  
heightbasesiderampwidth=59;//heightbaserampwidth+basespringgap*2;//ratchetspringwidth+32;
heightbasesiderampw=8;

heightbaseouterrampwidth=heightbasesiderampwidth+heightbasesiderampw*2;
heightbaseouterrampw=(heightbasewidth-heightbaseouterrampwidth)/2-xtolerance*2;

width=(phones==2?chargerwidth:max(heightbasewidth,57))+legwidth*2;
//height=chargerheight+phoneheight-phoneheightreduction+bottomheight;
height=bottomheight+phoneheight-phoneheightreduction;

topcutthickness=chargerthickness;

module basebox() {
  hull() {
    translate([-width/2+smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([-width/2+smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([width/2-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([width/2-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([-width/2+largecornerdiameter/2,largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
    translate([-width/2+largecornerdiameter/2,height-largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
    translate([width/2-largecornerdiameter/2,largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
    translate([width/2-largecornerdiameter/2,height-largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
  }
}

// support for printing
supportbottomstart=(legwidth+supportlift+supportwall/2);
supportbottomend=(height-smallcornerdiameter/2)*cos(angle)-(height-smallcornerdiameter/2)*sin(angle)-supportlift;
supportwidth=width/2-legwidth-maxbridge-maxbridge/2;
supportbottomwideend=supportbottomstart+supportwidth/2-supportlift;
supportmidpoint=supportbottomwideend<supportbottomend?supportbottomend-supportbottomwideend:0;
supportdistance=(width/2-legwidth-maxbridge + maxbridge/2);

module supportbase() {
  intersection() {
    for (m=[0,1]) mirror([m,0,0]) {
	translate([-supportdistance/2,0,0]) {
	  translate([-supportwall/2,supportbottomwideend-supportwall/2,0]) cube([supportwall,supportbottomend-supportbottomwideend+supportwall/2,supportlift]);

	  if (supportbottomstart<supportbottomend) hull() {
	      for (z=[0,supportlift]) {
		translate([0,supportbottomwideend-supportwall/2,z]) cylinder(d=supportwall,h=0.1);
		for (m2=[0,1]) mirror([m2,0,0]) {
		    translate([-supportwidth/2+supportlift*2+supportwall,supportbottomstart+supportwall/2,z]) cylinder(d=supportwall,h=0.1);
		  }
	      }
	    }
	}
      }
    
    union() {
      for (m=[0,1]) mirror([m,0,0]) {
	  translate([-supportdistance/2,0,0]) {
	    translate([-supportwall/2,supportbottomwideend-supportwall/2,0]) supportbox(supportwall,supportbottomend-supportbottomwideend+supportwall/2,supportlift,1);

	    if (supportbottomstart<supportbottomend) translate([0,0,0]) {
		translate([-supportwidth/4-supportwall-supportwall,supportbottomstart,0]) supportbox(supportwidth/2+supportwall*4,supportbottomend-supportbottomwideend+supportwall+supportwall/2,supportlift,1);
	      }
	  }
	}
    }
  }
}

module body() {
  difference() {
    union() {
      // Legs
      leftybottom=0;
      leftybase=0;
      for (m=[0,1]) mirror([m,0,0]) {
	  hull() {
	    translate([-width/2+legposition,leftybottom,0]) roundedboxxyz(legwidth,height*cos(angle)-leftybottom,0.01,smallcornerdiameter,0,1,90);//baselift
	    translate([-width/2+legposition,leftybase,baselift]) roundedboxxyz(legwidth,height*cos(angle)-leftybase,0.01,smallcornerdiameter,0,1,90);//baselift
	  }

	  if (baselift && !support) {
	    for (y=[screwd*3/2,height*cos(angle)-screwd*3/2]) {
	      hull() {
		translate([-width/2+legposition+screwd*3/2,y,screwlength]) rotate([180,0,0]) ruuvitorni(screwlength,screwd*3);
		translate([-width/2+legposition+legwidth/2,y-screwd*3/2,0]) roundedboxxyz(legwidth/2,screwd*3,baselift,smallcornerdiameter,0,1,90);
	      }
	    }
	  }

	  translate([-width/2,0,0]) hull() {
	    translate([legposition,leftybase,baselift]) roundedboxxyz(legwidth,height*cos(angle)-leftybase,wall,smallcornerdiameter,0,1,90);
	    translate([0,0,bottomlift]) rotate([angle,0,0]) {
	      translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([legwidth-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	    }
	  }

	  translate([-width/2,0,0]) hull() {
	    translate([legposition,height*cos(angle)-smallcornerdiameter,baselift]) roundedboxxyz(legwidth,smallcornerdiameter,wall,smallcornerdiameter,0,1,90);
	    translate([0,0,bottomlift]) rotate([angle,0,0]) {
	      translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([legwidth-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	    }
	  }
	}

      // front leg
      translate([-width/2,0,0]) hull() {
	translate([legposition,0,baselift]) roundedboxxyz(width-legposition*2,legwidth,wall,smallcornerdiameter,0,1,90);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }

      if (teslamodels&&support) {
	translate([legposition-width/2+legwidth+1,0,0]) supportbox(width-legposition*2-legwidth*2-2,legwidth,baselift,1);
      }
      
      if (supportbottomend>supportbottomstart) {
	if (support) supportbase();
	
	for (m=[0,1]) mirror([m,0,0]) {
	    translate([-supportdistance/2,0,0]) hull() {
	      translate([0,supportbottomstart+supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);
	      translate([0,supportbottomend-supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);
	      translate([0,supportbottomend+supportmidpoint-supportwall/2,supportlift+supportmidpoint+supportwall/2]) sphere(d=supportwall);
	      
	      translate([0,0,bottomlift]) rotate([angle,0,0]) {
		translate([0,height-smallcornerdiameter/2,supportwall/2]) sphere(d=supportwall);
	      }
	    }
      
	    if (supportbottomstart<supportbottomend) translate([-supportdistance/2,0,0]) hull() {
		translate([0,supportbottomend+supportmidpoint-supportwall/2,supportlift+supportmidpoint+supportwall/2]) sphere(d=supportwall);
	      
		for (m2=[0,1]) mirror([m2,0,0]) {
		    hull() {
		      translate([0,supportbottomwideend-supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);
	      
		      translate([0,0,bottomlift]) rotate([angle,0,0]) {
			translate([0,height-smallcornerdiameter/2,supportwall/2]) sphere(d=supportwall);
			translate([-supportwidth/2+supportwall/2,height-smallcornerdiameter/2,supportwall/2]) sphere(d=supportwall);
		      }
		    }
		
		    hull() {
		      translate([-supportwidth/2+supportlift*2+supportwall,supportbottomstart+supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);
		      translate([-0,supportbottomwideend-supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);

		      translate([0,0,bottomlift]) rotate([angle,0,0]) {
			translate([-supportwidth/2+supportwall/2,height-smallcornerdiameter/2,supportwall/2]) sphere(d=supportwall);
		      }
		    }
	
 
		    hull() {
		      translate([-supportwidth/2+supportlift*2+supportwall,supportbottomstart+supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);
		      translate([0,supportbottomstart+supportwall/2,supportlift]) cylinder(d=supportwall,h=0.1);
	    
		      translate([0,0,bottomlift]) rotate([angle,0,0]) {
			translate([-0,legwidth,0]) cylinder(d=supportwall,h=0.1);
			translate([-supportwidth/2+supportwall/2,legwidth,0]) cylinder(d=supportwall,h=0.1);
		      }
		    }
		  }
	      }
	  }
      }

      // Top box
      translate([0,0,bottomlift]) rotate([angle,0,0]) {
	difference() {
	  basebox();
	  if (!teslamodels) {
	    l=bottomheight+phonebottomlevel+chargerheight+wall;
	    translate([-width/2+legwidth,l,-cornerd/2]) roundedbox(width-legwidth*2,height-l+cornerd/2+0.1,topcutthickness-cameradepth+cornerd/2-ztolerance,cornerd,0);

	    left=usbholewidth/2+wall;
	    right=width/2-legwidth;
	    w=right-left;
	    // This adds one hour to printing time and saves a whopping 2 grams of filament...
	    if (lighten) for (m=[0,1]) mirror([m,0,0]) {
		translate([left,wall,chargerthickness-ratchetthickness-ztolerance-0.01]) rotate([-90,0,0]) lighten(w,bottomheight+phonebottomlevel-wall*2,backthickness+chargerthickness-ratchetthickness-wall,wall,thinwall,maxbridge,"up");
	      }
	  }
	}
      }
    }
    
    translate([0,0,bottomlift]) rotate([angle,0,0]) {
      if (phones==1) {
	translate([0,height-2-textsize,backthickness+chargerthickness-cameradepth-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
      } else {
	translate([0,textsize,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
      }

      // Cut for charger
      if (phones==2) {
	translate([-chargerwidth/2,bottomheight+phonebottomlevel,backthickness]) roundedbox(chargerwidth,chargerheight,chargerthickness+phonethickness+10+0.01,cornerd);
	for (m=mirroring) mirror([m,0,0]) translate([-chargingcoildistance/2-heightbasewidth/2,bottomheight+heightbasel-phonecutdiameter/2-cornerd/2,backthickness+chargerthickness]) roundedbox(heightbasewidth,heightbasel+chargerheight/2,chargerthickness+phonethickness+10+0.01,cornerd);
      } else {
	translate([0,bottomheight+phonebottomlevel+chargerwidth/2,backthickness]) roundedcylinder(chargerwidth,chargerthickness+phonethickness+10+0.01,cornerd,0,120);
	translate([-heightbasewidth/2,bottomheight+heightbasel-phonecutdiameter/2-cornerd/2,backthickness+chargerthickness-ztolerance]) roundedbox(heightbasewidth,heightbasel+chargerheight+cornerd/2,chargerthickness+phonethickness+10+0.01,cornerd);
      }

      // Phone cuts. For two phones, this is mirrored, mirror is a no-op.
      for (m=mirroring) mirror([m,0,0]) {
	  // Upper part (thicker for easier insertion)
	  translate([-chargingcoildistance/2-phonewidth/2,bottomheight+phonebottomlevel,backthickness+chargerthickness-ztolerance]) roundedbox(phonewidth,phoneheight+bottomlift-phonebottomlevel,thickness,cornerd);

	  // Phone itself
	  translate([-chargingcoildistance/2-phonewidth/2,bottomheight,backthickness+chargerthickness-ztolerance]) roundedbox(phonewidth,phoneheight+bottomlift,phonethickness+thicknessmargin+1,cornerd);

	  // Cutout for heightbase
	  //cutl=heightbaseheight+(heightbasenarrowingl+heightbasenarrowingextral+ratchetmaxmovement)*2+1;
	  cutl=heightbasel*2+1;
	  difference() {
	    translate([-chargingcoildistance/2-heightbasewidth/2,bottomheight-heightbaseheight,backthickness+chargerthickness-ratchetthickness-ztolerance]) cube([heightbasewidth,cutl,phonethickness+thicknessmargin+1+ratchetthickness]);
	    translate([-chargingcoildistance/2,0,0]) {
	      for (m=[0,1]) mirror([m,0,0]) {
		  translate([heightbasesiderampwidth/2,bottomheight-heightbaseheight-cornerd,-ztolerance]) roundedbox(heightbasesiderampw,cutl+cornerd+cornerd/2,backthickness+chargerthickness,cornerd);
		}
	    }
	  }

	  // Cut for cameras
	  translate([-chargingcoildistance/2-camerawidth/2,bottomheight+cameraheight,backthickness+chargerthickness-cameradepth-ztolerance]) roundedbox(camerawidth,phoneheight-cameraheight+1,cameradepth+cornerd/2,cornerd);
		 
	  // Cut for ratchet
	  difference() {
	    w=ratchetspringwidth+xtolerance*2;
	    translate([-chargingcoildistance/2-w/2-xtolerance,bottomheight-heightbaseheight-ratchetheight-ytolerance-cornerd/2,backthickness+chargerthickness-ratchetthickness-ztolerance]) roundedbox(w+xtolerance*2,ratchetheight+ytolerance*2+cornerd,thickness+ztolerance*2,cornerd,1);
	    // Add ratchet lock
	    translate([-chargingcoildistance/2-ratchetkeyw/2,bottomheight-heightbaseheight-ratchetkeydistance+ratchetwall-0,backthickness+chargerthickness-ratchetthickness-ztolerance-0.01]) triangle(ratchetkeyw,ratchetkeyheight,ratchetthickness+ztolerance,11);
	  }
	    
	  //Lower cutout (shaped)
	  translate([-chargingcoildistance/2,0,0]) hull() for (m=[0,1]) mirror([m,0,0]) {
	    height=backthickness+chargerthickness;
	    h=phonethickness+thicknessmargin+backthickness+3+0.01;
	    xposition=0; //(phones==2?-width/2+chargingcoildistance/2:0);
	    translate([xposition,0,0]) {
	      d=0.1;
	      translate([-microphoneholewidth/2,bottomheight-heightbaseheight+d/2,height]) cylinder(h=h,d=d);
	    }
	    translate([-centerlowerwidth/2-phonecutdiameter/2,bottomheight+heightbasel-phonecutdiameter/2,height]) cylinder(h=h,d=phonecutdiameter);
	  }
	  
	  // Angled cut to open microphone and speaker
	  translate([-chargingcoildistance/2-microphoneholewidth/2,-ytolerance,backthickness+chargerthickness]) rotate([0,0,0]) cube([microphoneholewidth,microphoneholewidth,microphoneholedepth]);
	}
      
      // USB cable tunnel (can go through back or front)
      if (phones==2) {
	union() {
	  w=chargingcoildistance-heightbasewidth+0.01;//divideredge;
	  hull() {
	    translate([-w/2,bottomheight+phonebottomlevel-usbconnectorl,-0.01]) cube([w,usbconnectorl+cornerd/2,backthickness+usbholethickness]);
	    translate([-w/2,bottomheight+phonebottomlevel+cornerd/2,-0.01]) triangle(w,w/2+usbholed/2,backthickness+usbholethickness,17);
	    for (x=[-usbholewidth/2+usbholed/4,usbholewidth/2-usbholed/4]) {
	      for (z=[0,backthickness+usbholed/2]) {
		if (z > 0) {
		  translate([x,bottomheight+phonebottomlevel-usbconnectorl,z]) rotate([-90,0,0]) cylinder(d=usbholed,h=usbconnectorl+cornerd/2,$fn=60);
		} else {
		  translate([x,-usbholed-0.1,z]) rotate([-90,0,0]) cylinder(d=usbholed,h=usbconnectorl+bottomheight+usbholed,$fn=60);
		}
	      }
	    }

	    t=usbholewidth/1.3;
	    if (angle<45) {
	      translate([-w/2-0.02,bottomheight+phonebottomlevel-usbconnectorl,backthickness+usbholethickness-0.01]) triangle(w+0.04,usbconnectorl+0.1,usbconnectorl*sin(45-angle),11);
	    }
	  }
	}
      } else {
	hull() {
	  translate([-usbconnectorw/2,bottomheight+phonebottomlevel+chargerheight-wall,-usbconnectorw-0.01]) cube([usbconnectorw,wall*2+cornerd/2,chargerthickness+wall+usbconnectorw+0.02]);
	  translate([-usbconnectorw/2,bottomheight+phonebottomlevel+chargerheight+wall+ytolerance,-usbconnectorw-0.01]) triangle(usbconnectorw,usbconnectorw/2,chargerthickness+wall+usbconnectorw+0.02,17);
	}
      }

      // Cutout to for buttons in the right side of a phone
      translate([-width/2+phonewidth,bottomheight+keycutposition,chargerthickness+backthickness+1]) cube([width,keycutheight,phonethickness+thicknessmargin+backthickness]);
    }

    if (baselift && !support) {
      for (m=mirroring) mirror([m,0,0]) {
	  for (y=[screwd*3/2,height*cos(angle)-screwd*3/2]) {
	    intersection() {
	      translate([-width/2+legposition+screwd*3/2,y,screwlength-0.01]) rotate([180,0,0]) {
		render() ruuvireika(screwlength,screwd,1,strong);
	      }

	      translate([-width/2+legposition+screwd*3/2,y,-0.01]) union() {
		difference() {
		  union() {
		    cylinder(d=screwd*3,h=baselift-0.4);
		    translate([0,0,baselift+0.6]) cylinder(d=screwd*3,h=screwlength-baselift);
		    cylinder(d=screwd,h=screwlength);
		  }
		}
	      }
	    }
	  }
	}
    }

    // Lightening holes
    if (0) hull() {
      y=cos(angle)*height-maxbridge*2;
      z=sin(angle)*height-maxbridge*2-lmargin*2;
      translate([-width/2,y,z+bottomlift]) cube([width,1,0.1]);
      translate([-width/2,y-z+4+8/2+10+lmargin,bottomlift+8/2+5+lmargin]) rotate([0,90,0]) cylinder(d=8,h=width);
      translate([-width/2,y+maxbridge/2-lmargin,bottomlift+8/2+5+lmargin]) rotate([0,90,0]) cylinder(d=8,h=width);
    }
  }
}

module heightbase() {
  difference() {
    union() {
      difference() {
	for (m=[0,1]) mirror([m,0,0]) {
	    w=phonewidth-microphoneholewidth;
	    w2=ratchetw+(basespringgap+ratchetspringw+basespringgap)*2;
	    
	    // Back
	    difference() {
	      translate([microphoneholewidth/2,ytolerance,0]) roundedbox((heightbasewidth-microphoneholewidth)/2-xtolerance,heightbaseheight-ytolerance*2,heightbasethickness,cornerd,1);
	      hull() {
		translate([heightbasesiderampwidth/2-xtolerance,0,-0.01]) cube([heightbasesiderampw+xtolerance*2,heightbaseheight,ratchetthickness+0.01]);
		translate([heightbasesiderampwidth/2-xtolerance,0,ratchetthickness]) triangle(heightbasesiderampw+xtolerance*2,heightbaseheight,(heightbasesiderampw+xtolerance)/2,12);
	      }
	    }
	    
	    // Side ramps
	    hull() {
	      translate([ratchetspringwidth/2+basespringgap,ytolerance,0]) roundedbox(heightbaserampw,heightbaseheight+heightbasenarrowingl-ytolerance,ratchetthickness,cornerd,1);
	      translate([ratchetspringwidth/2+basespringgap+heightbaserampw/2,heightbaseheight+heightbasenarrowingl+heightbasenarrowingextral-0.5/2,+0.5/2]) tubeclip(heightbaserampw,0.5,0);
	    }
	    // Outer side ramp
	    hull() {
	      translate([heightbaseouterrampwidth/2+xtolerance,ytolerance,0]) roundedbox(heightbaseouterrampw,heightbaseheight+heightbasenarrowingl-ytolerance,ratchetthickness,cornerd,1);
	      translate([heightbaseouterrampwidth/2+xtolerance+heightbaseouterrampw/2,heightbaseheight+heightbasenarrowingl+heightbasenarrowingextral-0.5/2,0.5/2]) tubeclip(heightbaseouterrampw,0.5,0);
	    }
	    // Angled support between side ramps and back
	    hull() {
	      s=heightbasethickness/2.5;
	      translate([microphoneholewidth/2,ytolerance,0]) roundedbox((heightbaserampwidth-microphoneholewidth)/2,heightbaseheight-ytolerance*2,s,cornerd,1);
	      translate([microphoneholewidth/2-s,ytolerance,0]) roundedbox((heightbaserampwidth-microphoneholewidth)/2,heightbaseheight-ytolerance*2,ratchetthickness,cornerd,1);
	    }

	    // Spring between ratchet and ramps
	    translate([ratchetw/2+basespringgap,-ratchetheight,0]) roundedbox(ratchetspringw,ratchetheight+heightbaseheight+heightbasenarrowingl-ytolerance,ratchetspringthickness,cornerd,1);
	    translate([ratchetw/2+basespringgap,heightbaseheight+heightbasenarrowingl-ratchetspringw,0]) roundedbox(ratchetspringw+0.5+cornerd,ratchetspringw,ratchetspringthickness,cornerd,1); 
	  }
      }

      // Ratchet connect to spring
     translate([-ratchetw/2-ratchetspringw-basespringgap,-ratchetheight,0]) roundedbox(ratchetw+ratchetspringw*2+basespringgap*2,ratchetspringw,ratchetthickness,cornerd,1);

     // Ratchet
     hull() {
	translate([-ratchetw/2,-ratchetheight,0]) roundedbox(ratchetw,ratchetheight+heightbaseheight+heightbasenarrowingl,ratchetthickness,cornerd,1);
	translate([0,heightbaseheight+heightbasenarrowingl+heightbasenarrowingextral-0.5/2,0.5/2]) rotate([0,0,0]) tubeclip(ratchetw,0.5,0);
      }
      translate([-ratchethandlew/2,-ratchetheight,0]) roundedbox(ratchethandlew,ratchetheight+ytolerance+heightbaseheight-cornerd/2,ratchetthickness+ratchethandlethickness,cornerd,1);

      // Sides
      for (m=[0,1]) mirror([m,0,0]) translate([-heightbasewidth/2+xtolerance,0,0]) {
	  difference() {
	    union() {
	      intersection() {
		translate([0,0,0]) cube([heightbasenarrowing*2,heightbasel,heightbasethickness]);
		union() {
		  if (basespring) {
		    translate([-basespringd/2+heightbasenarrowing*2,basespringheight,0]) roundedcylinder(basespringd,heightbasethickness,cornerd,1,180);
		  
		    hull() {
		      translate([0,ytolerance,0]) roundedbox(cornerd*2,heightbaseheight-ytolerance*2,heightbasethickness,cornerd,1);
		      translate([0,ytolerance,0]) roundedbox(heightbasenarrowing-xtolerance,heightbaseheight-ytolerance*2,heightbasethickness,cornerd,1);
		    }
		  }
		  hull() {
		    translate([0,ytolerance+cornerd/2,0]) roundedbox(heightbasenarrowing-xtolerance,heightbasenarrowingl-ytolerance*2,heightbasethickness,cornerd,1);
		    translate([0,narrowy,heightbasethickness/2]) rotate([0,90,0]) tubeclip(heightbasethickness,0.5,0);
		  }
		}
	      }
	    }
	    if (basespring) translate([-basespringd/2+heightbasenarrowing*2,basespringheight,-0.01]) cylinder(d=basespringd-heightbasenarrowing,h=heightbasethickness+0.02,$fn=180);
	  }
	}
    }
    
    for (y=[0:ratchetkeydistance:ratchetheight-ratchetkeydistance]) {
      translate([-ratchetkeyw/2-xtolerance,-ratchetkeydistance+ratchetwall-y-ytolerance,-0.01]) cube([ratchetkeyw+xtolerance*2,ratchetkeyheight+ytolerance*2,ratchetthickness+1+0.02]);
    }

    translate([0,heightbaseheight+heightbasenarrowingl-textsize/2-2,ratchetthickness-textdepth+0.01]) rotate([0,0,0]) scale([0.7,1,1]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");

  }
}
  
if (print==0) {
  intersection() {
    union() {
      body();

      translate([0,0,bottomlift]) rotate([angle,0,0]) translate([chargingcoildistance/2,bottomheight-heightbaseheight+ratchetoffset,backthickness+chargerthickness-ratchetthickness]) heightbase();
    }
      
    //if (debug) translate([-200,screwd*3/2,-200]) cube([400,400,400]); // Debug screws
    if (debug) translate([0,-200,-200]) cube([400,400,400]); // Debug screws
  }
 }

if (print==1) {
  intersection() {
    union() {
      if (!teslamodels || support) {
	body();
      }

      // Teslas need bottom of legs to be printed separately, as angle is too low to print in one piece and center console is slightly convex
      if (teslamodels && !support) {
	translate([0,0,-baselift]) {
	  difference() {
	    body();
	    translate([-width/2-0.1,-thickness,-0.1]) cube([width+0.2,height+bottomlift,baselift+0.1]);
	  }
	}

	// Legs
	for (m=[0,1]) mirror([m,0,0]) translate([-width+legposition+legwidth,0,baselift]) rotate([180,0,180]) {
	    intersection() {
	      body();
	      translate([-width/2,-baselift,0]) cube([width/2,height+baselift,baselift-0.01]);
	    }
	  }
      }

      if (abs) {
	//antiwarpwall(x,y,z,l,w,h,distanceoption,walloption);
	antiwarpwall(-width/2-screwd*3/2-1,-thickness/2*cos(angle)-(teslamodels?0:8),0,width+screwd*3+2,thickness/2*cos(angle)+height*cos(angle)+screwd*3/2+2,(height+baselift)*sin(angle)+(thickness+baselift)*cos(angle)+5,adhesion=3);
      }
    }
      
    if (debug) translate([-200,screwd*3/2,-200]) cube([400,400,400]);
  }
 }

if (print==2) {
  translate([-width/2+legposition+legwidth+0.5+phonewidth/2-screwd*3/2-1,height*cos(angle)-screwd*3*3-0.5-cornerd/2-0.5,0]) {
    translate([0,0,0]) rotate([0,0,90]) translate([0,0,0]) heightbase();
  }
  if (phones>1) translate([width/2-(legposition+legwidth+0.5+phonewidth/2-screwd*3/2-1),height*cos(angle)-screwd*3*3-0.5-cornerd/2-0.5,0]) {
    translate([0,0,0]) rotate([0,0,-90]) translate([0,0,0]) heightbase();
  }
 }

if (print==3) {
  heightbase();
 }
