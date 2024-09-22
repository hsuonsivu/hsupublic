// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

$fn=60;

print=0;
teslamodels=1;

strong=(print>0)?1:0;

versiontext=str("V1.2",teslamodels?"S":"");;
textdepth=0.8;
textsize=8;

wall=2;
chargerthickness=9;
chargerwidth=180.2;
chargerheight=85.2;
phonethickness=15;
phonewidth=82;
phoneheight=167;
phoneheightreduction=100;
phonebottomlevel=20; // Below bottom of charging pad
chargingcoildistance=95;
chargingcoildiameter=64;
usbholewidth=11.5;
usbholethickness=1;
bottomheight=25;
backthickness=2;
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
microphoneholewidth=45;
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

module basebox() {
  hull() {
    translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([width-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
    translate([largecornerdiameter/2,largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
    translate([largecornerdiameter/2,height-largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
    translate([width-largecornerdiameter/2,largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
    translate([width-largecornerdiameter/2,height-largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
  }
}

module body() {
  difference() {
    union() {
      // left leg
      leftybottom=0;
      leftybase=0;
      hull() {
	translate([legposition,leftybottom,0]) cube([legwidth,height*cos(angle)-leftybottom,0.01]);//baselift
	translate([legposition,leftybase,baselift]) cube([legwidth,height*cos(angle)-leftybase,0.01]);//baselift
      }

      if (baselift) {
	for (x=[legposition+screwd*3/2,width-legposition-screwd*3/2]) {
	  for (y=[screwd*3/2,height*cos(angle)-screwd*3/2]) {
	    translate([x,y,screwlength]) rotate([180,0,0]) ruuvitorni(screwlength,screwd*3);
	  }
	}
      }
	
      hull() {
	translate([legposition,leftybase,baselift]) cube([legwidth,height*cos(angle)-leftybase,wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([legposition+legwidth-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([legposition+legwidth-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }

      // front leg
      //	translate([legposition,0,baselift]) cube([width-legposition*2-legwidth,legwidth,baselift]);
      hull() {
	translate([legposition,0,baselift]) cube([width-legposition*2,legwidth,wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }

      // right leg
      hull() {
	translate([width-legposition-legwidth,leftybottom,0]) cube([legwidth,height*cos(angle)-leftybottom,0.01]);
	translate([width-legposition-legwidth,leftybase,baselift]) cube([legwidth,height*cos(angle)-leftybase,0.01]);
      }
      hull() {
	translate([width-legposition-legwidth,leftybase,baselift]) cube([legwidth,height*cos(angle)-leftybase,wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-legposition-legwidth+smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-legposition-legwidth+smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }
    
      // support for printing
      if (1) { //!teslamodels
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
      }

      translate([0,0,bottomlift]) rotate([angle,0,0]) {
	union() {
	  //translate([width/2,bottomheight+divideredge+0.5,backthickness+chargerthickness+usbholethickness]) rotate([0,0,45]) cube([usbholewidth/2.18,usbholewidth/2.18,thickness-backthickness-chargerthickness-usbholethickness]);
      
	  basebox();
	}
      }
    }
    
    translate([0,0,bottomlift]) rotate([angle,0,0]) {
      translate([width/2,largecornerdiameter,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
      
      translate([(width-chargerwidth)/2,bottomheight+phonebottomlevel,backthickness]) cube([chargerwidth,chargerheight,chargerthickness+phonethickness+10+0.01]);
      translate([width/2-chargingcoildistance/2-phonewidth/2,bottomheight,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+1]);
      translate([width/2+chargingcoildistance/2-phonewidth/2,bottomheight,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+1]);
      translate([width/2-chargingcoildistance/2-phonewidth/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+5]);
      translate([width/2+chargingcoildistance/2-phonewidth/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+5]);

      union() {
	translate([width/2-usbholewidth/2,-0.01,backthickness]) cube([usbholewidth,bottomheight+phonebottomlevel+1,chargerthickness+usbholethickness]);
	translate([width/2-usbholewidth/2,bottomheight+phonebottomlevel-usbholewidth/2-0.01,backthickness+chargerthickness+usbholethickness-0.01]) triangle(usbholewidth,usbholewidth/2+0.02,usbholewidth/2,11);
	translate([width/2-usbholewidth/2,-0.01,backthickness+chargerthickness+usbholethickness-0.01]) triangle(usbholewidth/2,bottomheight+phonebottomlevel+1,usbholewidth/2,0);
	translate([width/2-0.01,-0.01,backthickness+chargerthickness+usbholethickness-0.01]) triangle(usbholewidth/2+0.01,bottomheight+phonebottomlevel+1,usbholewidth/2,2);
      }
      
      hull() {
	translate([width/2-chargingcoildistance/2-phonewidth/2+phonecutdiameter,bottomheight+phonecut,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2-chargingcoildistance/2-phonewidth/2+phonecutdiameter/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2-chargingcoildistance/2+phonewidth/2-phonecutdiameter/2+midcut,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2-chargingcoildistance/2+phonewidth/2-phonecutdiameter,bottomheight+phonecut,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
      }

      translate([width/2-chargingcoildistance/2-microphoneholeposition-microphoneholewidth/2,bottomheight,backthickness+chargerthickness]) rotate([microphoneholeangle,0,0]) cube([microphoneholewidth,microphoneholewidth,microphoneholedepth]);
      translate([width/2+chargingcoildistance/2-microphoneholeposition-microphoneholewidth/2,bottomheight,backthickness+chargerthickness]) rotate([microphoneholeangle,0,0]) cube([microphoneholewidth,microphoneholewidth,microphoneholedepth]);
		 
      
      hull() {
	translate([width/2+chargingcoildistance/2-phonewidth/2+phonecutdiameter,bottomheight+phonecut,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2+chargingcoildistance/2-phonewidth/2+phonecutdiameter/2-midcut,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2+chargingcoildistance/2+phonewidth/2-phonecutdiameter/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2+chargingcoildistance/2+phonewidth/2-phonecutdiameter,bottomheight+phonecut,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
      }

      translate([phonewidth,bottomheight+phonebottomlevel+chargerheight+keycutposition,chargerthickness+backthickness+1]) cube([width,keycutheight,phonethickness+thicknessmargin+backthickness]);
    }

    if (baselift) {
      for (x=[legposition+screwd*3/2,width-legposition-screwd*3/2]) {
	for (y=[screwd*3/2,height*cos(angle)-screwd*3/2]) {
	  translate([x,y,screwlength-0.01]) rotate([180,0,0]) ruuvireika(screwlength,screwd,1,strong);
	}
      }
    }
  }
}

if (print==0) {
  body();
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
	translate([-0.1,-thickness,-0.1]) cube([width+0.2,height+bottomlift,baselift+0.1]);
      }
    }

    // left leg
    translate([legposition+legwidth,0,baselift]) rotate([180,0,180]) {
      intersection() {
	body();
	translate([0,-baselift,0]) cube([width/2,height+baselift,baselift-0.01]);
      }
    }
    
    // right leg
    translate([width-legposition+1.5-screwd*3/2-1,height*cos(angle),baselift]) rotate([180,0,0]) {
      intersection() {
	body();
	translate([0,-baselift,0]) cube([width/2,height+baselift,baselift-0.01]);
      }
    }
  }
 }
