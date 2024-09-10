// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

$fn=60;

teslamodels=1;

versiontext=str("V1.1",teslamodels?"S":"");;
textdepth=0.8;
textsize=8;

chargerthickness=9;
chargerwidth=teslamodels?175:180.2;
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
legwidth=10;
legheight=phoneheight;
legthickness=phoneheight;
legposition=teslamodels?5:10;
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
bottomlift=teslamodels?12:0;
angle=teslamodels?15:45;
bottomy=bottomlift*sin(angle);
bottomz=bottomlift*cos(angle);
echo("y,z ",bottomy,bottomz);
wall=2;
midcut=3;
width=chargerwidth+10;
height=chargerheight+phoneheight-phoneheightreduction+bottomheight;
thickness=chargerthickness+phonethickness+backthickness+thicknessmargin+2;
union() {
  difference() {
    union() {
      // left leg
      translate([legposition,0,0]) cube([wall,height*cos(angle),bottomlift/2]);
      hull() {
	translate([legposition,0,bottomlift/2-0.01]) cube([wall,height*cos(angle),wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }

      // front leg
      translate([legposition,0,0]) cube([width-legposition*2,wall,bottomlift/2]);
      hull() {
	translate([legposition,0,bottomlift/2-0.01]) cube([width-legposition*2,wall,wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }

      // right leg
      translate([width-legposition-wall,0,0]) cube([wall,height*cos(angle),bottomlift/2]);
      hull() {
	translate([width-legposition-wall,0,bottomlift/2-0.01]) cube([wall,height*cos(angle),wall]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	}
      }
    
      // support for printing
      //      translate([bottomlift,bottomlift/2,0]) cube([width-bottomlift*2,(height+bottomlift)*cos(angle)/2,bottomlift/2]);
      hull() {
	h=height*cos(angle)+bottomlift;
	midlift=(h/2)*sin(angle)+bottomlift*2;
	translate([bottomlift,bottomlift,0]) cube([width-bottomlift*2,0.1,bottomlift]);
	translate([midlift,h-midlift-bottomlift,0]) cube([width-midlift*2,0.1,bottomlift]);
	translate([0,0,bottomlift]) rotate([angle,0,0]) {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	      translate([width-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);	}
      }

      translate([0,0,bottomlift]) rotate([angle,0,0]) {
	union() {
	  translate([width/2,bottomheight+divideredge+0.5,backthickness+chargerthickness+usbholethickness]) rotate([0,0,45]) cube([usbholewidth/2.18,usbholewidth/2.18,thickness-backthickness-chargerthickness-usbholethickness]);
      
	  union() {
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
	//	#	translate([width/2,-usbholewidth/sqrt(2)/2,backthickness]) rotate([0,0,45]) cube([usbholewidth/sqrt(2),usbholewidth/sqrt(2),thickness+1]);
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
  }
  //translate([-0.01,-2,-height]) cube([width+1,height,height+backthickness]);
  //translate([-0.01,125,-phoneheight]) cube([width+1,height+phoneheight,height+phoneheight]);
}
