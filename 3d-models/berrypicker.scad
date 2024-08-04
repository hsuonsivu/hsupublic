// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

debug=0;

length=228;
height=70; // 125;

versiontextb="v1.2";
textsize=7;
textdepth=1;

wall=1.5;

topl=190;
bottoml=170;

fingerl=70;
fingerw=9;
fingers=9;
fingerh=3*wall;
fingerdistance=15.5;// width/fingers; // This should be diameter of a full grown blueberry, need to test
width=fingerdistance*9; //140;
fingerendh=8;
fingertoph=height-10;
fingertopl=topl+20;
fingerstart=bottoml-20;
fingernarrowl=6;

storagel=100;
storageh=10;

handled=20;
handleattachd=25;
handlex=40;
handlefrontattach=topl-handleattachd;
handlel=topl-handlex-10;

cornerd=wall/2;

versiontext=str("piikki ",fingerw,"  rako ",fingerdistance-fingerw,"  ",versiontextb);

module berrypicker() {
  // bottom
  translate([0,0,storagel]) roundedbox(wall,width,bottoml-storagel,cornerd);
  translate([-storageh,0,0]) roundedbox(wall,width,storagel-storageh,cornerd);
  hull() {
    translate([0,0,storagel]) roundedbox(wall,width,wall,cornerd);
    translate([-storageh,0,storagel-storageh-wall]) roundedbox(wall,width,wall,cornerd);
  }
  // sides
  for (y=[0,width-wall]) {
    hull() {
      translate([0,y,0]) roundedbox(height,wall,topl,cornerd);
      translate([fingerendh,y,length]) roundedbox(wall,wall,wall,cornerd);
      translate([fingertoph,y,fingertopl]) roundedbox(wall,wall,wall,cornerd);
    }

    hull() {
      translate([-storageh,y,0]) roundedbox(storageh+wall,wall,storagel-storageh,cornerd);
      translate([0,y,storagel]) roundedbox(wall,wall,wall,cornerd);
    }
  }
  
  // top
  difference() {
    translate([height-wall,0,0]) roundedbox(wall,width,topl,cornerd);
    translate([height-textdepth+0.01,cornerd+1,cornerd+1]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="right", valign="bottom");
  }

  // back
  translate([-storageh,0,0]) roundedbox(height+storageh,width,wall,cornerd);
  
  // handle
  difference() {
    union() {
      hull() {
	translate([height-wall,width/2-handleattachd/2,0]) roundedbox(wall,handleattachd,handleattachd-handlex/3,cornerd);
	translate([height+handlex,width/2,0]) cylinder(d=handled,h=handled+handlex*2/3);
      }
      translate([height+handlex,width/2,0]) cylinder(d=handled,h=handlel);

      hull() {
	translate([height-wall,width/2-handleattachd/2,handlefrontattach]) roundedbox(wall,handleattachd,handleattachd,cornerd);
	translate([height+handlex,width/2,handlel]) cylinder(d=handled,h=wall);
      }
    }
    
    hull() {
      translate([height,width/2-handleattachd/2+wall,wall]) roundedbox(wall,handleattachd-2*wall,handleattachd-handlex/3-2*wall,cornerd);
      translate([height+handlex,width/2,wall]) cylinder(d=handled-wall*2,h=handled+handlex*2/3-wall*2);
    }
    translate([height+handlex,width/2,-0.1]) cylinder(d=handled-wall*2,h=handlel+0.2+wall/2);

    hull() {
      translate([height,width/2-handleattachd/2+wall,handlefrontattach+wall/2]) roundedbox(0.1,handleattachd-wall*2,handleattachd-wall*2,cornerd);
      translate([height+handlex,width/2,handlel+wall/2]) cylinder(d=handled-wall*2,h=0.1);
    }
  }

  // fingers
  intersection() {
    union() {
      for (y=[0:fingerdistance:width]) {
	hull() {
	  translate([0,y-fingerw/2,fingerstart]) roundedbox(wall,fingerw,bottoml-fingerstart,cornerd);
	  translate([0,y-fingerw/2,bottoml+cornerd]) roundedbox(fingerh,fingerw,wall,cornerd);
	}
	translate([0,y-fingerw/2,bottoml]) roundedbox(fingerh,fingerw,topl-bottoml+cornerd,cornerd);
	hull() {
	  translate([0,y-fingerw/2,topl]) roundedbox(fingerh,fingerw,wall,cornerd);
	  translate([fingerendh,y-fingerw/2,length-fingernarrowl]) roundedbox(fingerh,fingerw,wall,cornerd);
	  translate([fingerendh+fingerh-wall/2,y,length]) sphere(wall);
	}
      }
    }

    cube([height,width,length+cornerd+wall]);
  }
}

intersection() {
  berrypicker();
  if (debug) cube([height+handlex+handled/2+1,width/2,length+1]);
}
 
