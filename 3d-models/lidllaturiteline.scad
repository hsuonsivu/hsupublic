// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

$fn=60;

print=1;
teslamodels=1;
abs=0;
cornerd=2;

strong=(print>0)?0:0;

versiontext=str("V1.6",teslamodels?"S":"");;
textdepth=0.8;
textsize=8;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

wall=2;
chargerthickness=9;
chargerwidth=180.2;
chargerheight=85.2;
phonethickness=15;
phonewidth=82;
phoneheight=172; //167;
phoneheightreduction=100;
phonebottomlevel=31.4; //20; // Below bottom of charging pad
chargingcoildistance=95;
chargingcoildiameter=64;
usbholewidth=11.5;
usbholethickness=0;//1;
usbholed=chargerthickness+usbholethickness;
bottomheight=25;
backthickness=2.4;
thicknessmargin=2;
legwidth=5; //wall;
legheight=phoneheight;
legthickness=phoneheight;
legposition=teslamodels?11:5;
phonecutdiameter=10;
phonecut=5; // Edge to which phone drops and stays in place
keycutposition=30-55;
keycutheight=55;
divideredge=chargingcoildistance-phonewidth;
microphoneholewidth=50; //45;
microphoneholedepth=40;
microphoneholeangle=45;
microphoneholeposition=0; // Offset from center
smallcornerdiameter=5;
largecornerdiameter=10;
baselift=teslamodels?7:0;
bottomlift=teslamodels?baselift+legposition:legposition;
angle=teslamodels?28:45;
bottomy=bottomlift*sin(angle);
bottomz=bottomlift*cos(angle);
midcut=3;
width=chargerwidth+10;
height=chargerheight+phoneheight-phoneheightreduction+bottomheight;
thickness=chargerthickness+phonethickness+backthickness+thicknessmargin+2;

screwd=3.5;
screwlength=19;

heightbaseheight=5;
heightbasesupportheight=1.8;
heightbasenarrowing=2-xtolerance*2;
heightbasenarrowingl=15;
heightbasenarrowingextral=6;

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

module body() {
  difference() {
    union() {
      // left leg
      leftybottom=0;
      leftybase=0;
      for (m=[0,1]) mirror([m,0,0]) {
	  hull() {
	    translate([-width/2+legposition,leftybottom,0]) cube([legwidth,height*cos(angle)-leftybottom,0.01]);//baselift
	    translate([-width/2+legposition,leftybase,baselift]) cube([legwidth,height*cos(angle)-leftybase,0.01]);//baselift
	  }

	  if (baselift) {
	    for (y=[screwd*3/2,height*cos(angle)-screwd*3/2]) {
	      translate([-width/2+legposition+screwd*3/2,y,screwlength]) rotate([180,0,0]) ruuvitorni(screwlength,screwd*3);
	    }
	  }

	  translate([-width/2,0,0]) hull() {
	    translate([legposition,leftybase,baselift]) cube([legwidth,height*cos(angle)-leftybase,wall]);
	    translate([0,0,bottomlift]) rotate([angle,0,0]) {
	      translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([legposition+legwidth-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([legposition+legwidth-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	    }
	  }
	}

      // front leg
      translate([-width/2,0,0]) hull() {
	translate([legposition,0,baselift]) cube([width-legposition*2,legwidth,wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }
    
      // support for printing
      translate([-width/2,0,0]) 
	hull() {
	h=(height-baselift)*cos(angle);
	l=(height-baselift)*sin(angle);
	if (h>l) {
	  ll=h-l;
	  xx=(angle==0)?0:ll/cos(angle);
	  x=xx*sin(angle);
	  //echo("h ",h," l ",l," ll ",ll," xx ",xx," x ",x);
	  translate([legposition+legwidth+bottomlift-baselift,bottomlift-baselift,baselift]) cube([width-(legposition+legwidth+bottomlift-baselift)*2,0.1,bottomlift]);
	  translate([legposition+x,ll,baselift]) cube([width-legposition*2-x*2,0.1,0.1]);
	  translate([0,0,bottomlift]) rotate([angle,0,0]) {
	    translate([legposition+legwidth,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	    translate([width-legposition-legwidth,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	    translate([legposition+legwidth,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	    translate([width-legposition-legwidth,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  }
	}
      }

      // Top box
      translate([0,0,bottomlift]) rotate([angle,0,0]) {
	union() {
	  basebox();
	}
      }
    }
    
    translate([0,0,bottomlift]) rotate([angle,0,0]) {
      translate([0,largecornerdiameter,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");

      // Cut for lidl charger
      translate([-chargerwidth/2,bottomheight+phonebottomlevel,backthickness]) cube([chargerwidth,chargerheight,chargerthickness+phonethickness+10+0.01]);

      // Phone cuts
      for (m=[0,1]) mirror([m,0,0]) {
	  for (x=[-chargingcoildistance/2,chargingcoildistance/2]) {
	    translate([x-phonewidth/2,bottomheight,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+1]);
	
	    // Phone openings
	    translate([width/2+x-phonewidth/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+5]);
	  }

	  //Lower cutout (shaped)
	  translate([-width/2+chargingcoildistance/2,0,0]) {
	    hull() {
	      translate([-phonewidth/2+phonecutdiameter,bottomheight+phonecut,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	      translate([-phonewidth/2+phonecutdiameter/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	      translate([phonewidth/2-phonecutdiameter/2+midcut,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	      translate([phonewidth/2-phonecutdiameter,bottomheight+phonecut,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	    }

	  // Angled cut to open microphone and speaker
	    translate([-microphoneholeposition-microphoneholewidth/2,bottomheight,backthickness+chargerthickness]) rotate([microphoneholeangle,0,0]) cube([microphoneholewidth,microphoneholewidth,microphoneholedepth]);
	  }
	}
      
      // USB cable tunnel
      union() {
	hull() {
	  translate([-usbholewidth/2,-0.01,backthickness]) cube([usbholewidth,bottomheight+phonebottomlevel+1,chargerthickness+usbholethickness]);
	  for (x=[-usbholewidth/2+usbholed/4,usbholewidth/2-usbholed/4]) {
	    translate([x,-0.01,backthickness+usbholed/2]) rotate([-90,0,0]) cylinder(d=usbholed,h=bottomheight+phonebottomlevel+1,$fn=60);
	  }
	}
	t=usbholewidth/1.3;
	translate([-usbholewidth/2,bottomheight+phonebottomlevel-t-0.01,backthickness+chargerthickness+usbholethickness-0.01]) triangle(usbholewidth,t+0.02,usbholewidth/2,11);
	translate([-usbholewidth/2,-0.01,backthickness+chargerthickness+usbholethickness-0.01]) triangle(usbholewidth/2,bottomheight+phonebottomlevel+1,usbholewidth/2,0);
	translate([-0.01,-0.01,backthickness+chargerthickness+usbholethickness-0.01]) triangle(usbholewidth/2+0.01,bottomheight+phonebottomlevel+1,usbholewidth/2,2);
      }

      // Cutout to for buttons in the right side of a phone
      translate([-width/2+phonewidth,bottomheight+phonebottomlevel+chargerheight+keycutposition,chargerthickness+backthickness+1]) cube([width,keycutheight,phonethickness+thicknessmargin+backthickness]);
    }

    if (baselift) {
      for (m=[0,1]) mirror([m,0,0]) {
	  for (y=[screwd*3/2,height*cos(angle)-screwd*3/2]) {
	    translate([-width/2+legposition+screwd*3/2,y,screwlength-0.01]) rotate([180,0,0]) ruuvireika(screwlength,screwd,1,strong);
	  }
	}
    }
  }
}

module heightbase() {
  difference() {
    union() {
      translate([-phonewidth/2+xtolerance,ytolerance,ztolerance]) roundedbox(phonewidth-xtolerance*2,heightbaseheight-ytolerance*2,phonethickness+thicknessmargin+1-ztolerance*2,cornerd,1);
      for (m=[0,1]) mirror([m,0,0]) translate([-phonewidth/2+xtolerance,0,0]) {
	  hull() {
	    translate([0,ytolerance,ztolerance]) roundedbox(cornerd*2,heightbaseheight-ytolerance*2,phonethickness+thicknessmargin+1-ztolerance*2,cornerd,1);
	    translate([0,ytolerance,ztolerance]) roundedbox(heightbasenarrowing-xtolerance,heightbaseheight-ytolerance*2,phonethickness+thicknessmargin+1-ztolerance*2,cornerd,1);
	  }
	  hull() {
	    translate([0,ytolerance+cornerd/2,ztolerance]) roundedbox(heightbasenarrowing-xtolerance,heightbaseheight+heightbasenarrowingl-ytolerance*2,phonethickness+thicknessmargin+1-ztolerance*2,cornerd,1);
	    translate([0,ytolerance+cornerd/2+heightbasenarrowingl+heightbasenarrowingextral,ztolerance]) cylinder(d=0.5,h=phonethickness+thicknessmargin+1-ztolerance*2);
	  }
	}
    }
    translate([-microphoneholewidth/2,0,heightbasesupportheight+ztolerance]) cube([microphoneholewidth,heightbaseheight,phonethickness+thicknessmargin+1]);
    translate([-phonewidth/2+(phonewidth-microphoneholewidth)/4+(cornerd+1)/4,textdepth+ytolerance-0.01,(phonethickness+thicknessmargin+1)/2]) rotate([90,0,0]) scale([0.6,1,1]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");

  }
}
  
if (print==0) {
  body();

  translate([0,0,bottomlift]) rotate([angle,0,0]) translate([chargingcoildistance/2,bottomheight,backthickness+chargerthickness]) heightbase();
 }

if (print==1) {
  if (!teslamodels) {
    body();
  }

  // Teslas need bottom of legs to be printed separately, as angle is too low to print in one piece and center console is slightly convex
  if (teslamodels) {
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
    antiwarpwall(-screwd*3/2-1,-thickness/2*cos(angle)-(teslamodels?0:8),0,width+screwd*3+2,thickness/2*cos(angle)+height*cos(angle)+screwd*3/2+2,(height+baselift)*sin(angle)+(thickness+baselift)*cos(angle)+5);
  }
 }

if (print==2 || print==1) {
  translate([-width/2+legposition+legwidth+0.5+phonewidth/2,height*cos(angle)-screwd*3*3-0.5-cornerd/2-0.5,-ztolerance]) {
    translate([0,0,0]) rotate([0,0,0]) translate([0,0,0]) heightbase();
    translate([0,-min(0.5,xtolerance*2),0]) rotate([0,0,180]) translate([0,0,0]) heightbase();
  }
 }

if (print==3) {
  heightbase();
 }
