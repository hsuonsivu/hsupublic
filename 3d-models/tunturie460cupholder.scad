// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
include <power-strip-attachment-lib.scad>

print=8; // 0=cupholder full, 1=both cupholder parts, 2=cupholder backplate, 3=cupholder front, 4=headphone hanger, 5=test, 6=powerstrip attachments
debug=0;

strong=(print>0)?1:0;
supports=1; // patches for easier printing
$fn=print?120:30;

versiontext="v1.1";
textsize=7;
textdepth=0.7;

screwd=4.4; // M5
screwheadd=8.5; //8.6; // Round head
screwheadh=3.5;
screwheadspaceh=6;
screwl=23.17;
screwtowerd=screwheadd+4;

nutd=7;
nuth=2.3;

thinwall=2;//1.6;
width=50.3;
depth=70.2;
collarz=130;
angle=print>5?0:15.75;
supportdistance=100;
wall=8;
cornerd=2;
cupout=35; // Move cup out to allow upper position
cupdiameter=90;
cupoutdiameter=cupdiameter+wall;
cupheight=90;
cupexpansion=10;
cuphandleraise=10;
cuphandlediameter=20;
screwholed=3.5;
screwholebase=1; // countersink
cupcutoffsetlow=-50;
cupcutoffsethigh=-45;
cupcornerd=3;

handlebard=31;
handlebarcurved=140;//160;
handlebarstraight=40+50+5;
headphonehangend=thinwall*2+7;
headphonehangendd=handlebard+headphonehangend;
headphonehangendh=2+thinwall;

headphonehanglowd=10;
headphonehangd=10;
headphonehangw=72+headphonehangd;//+screwholed*3/2;
headphonehangh=50;

dtolerance=0.5;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;

module deeptext(teksti, height, depth, ha) {
  h=depth/3;
  translate([0,0,h*2]) linear_extrude(height=h) text(teksti,size=height,font="Liberation Sans:style=Bold",halign=ha);

  for (xb=[-0.1,0.1]) {
    for (yb=[-0.1,0.1]) {
      translate([xb,yb,h]) linear_extrude(height=h+0.01) text(teksti,size=height,font="Liberation Sans:style=Bold",halign=ha);
    }
  }

  for (xs=[-0.2,0.2]) {
    for (ys=[-0.2,0.2]) {
      translate([xs,ys,0]) linear_extrude(height=h+0.01) text(teksti,size=height,font="Liberation Sans:style=Bold",halign=ha);
    }
  }
}

module ankermakeprintarea() {
  xsize=232; // Leave some space
  ysize=232;
  wall=0.8;
  h=0.2;
  
  difference() {
    translate([-xsize/2,-ysize/2,0]) cube([xsize,ysize,h]);
    translate([-xsize/2+wall,-ysize/2+wall,-0.1]) cube([xsize-wall*2,ysize-wall*2,h+0.2]);
  }
}

countersinkheightmultiplier=0.63;
countersinkdiametermultiplier=2.4;

module ruuvireika(height,diameter,countersink) {
  $fn=90;
  cylinder(h=height,d=diameter-0.1); // Slightly smaller hole

  if (strong) {
    if (1) {
      for (i=[0:1:(diameter*countersinkdiametermultiplier-(diameter+0.4)+4)/2]) {
	di=diameter+0.4+i*2;
	translate([0,0,-1])
	  difference() {
	  cylinder(h=height+1-0.1,d=di+0.05,$fn=20);
	  translate([0,0,-0.01]) cylinder(h=height+1+0.02,d=di,$fn=20);
	}
      }
    } else {
      for (xx=[-2*diameter:1:2*diameter]) {
	translate([xx,-2*diameter,-1]) cube([0.05,4*diameter,height+1-0.1]);
      }
    }
  }

  if (countersink) {
    translate([0,0,height-diameter*countersinkheightmultiplier]) cylinder(h=diameter*countersinkheightmultiplier,d1=diameter,d2=diameter*countersinkdiametermultiplier);
  }
}

module ruuvitorni(height,diameter) {
  cylinder(h=height,d=diameter);
  translate([0,0,height-0.01]) cylinder(h=diameter/3,d1=diameter,d2=diameter*0.6);
}

module roundedboxold(x,y,z,c) {
  corner=(c > 0) ? c : 1;
  scd = ((x < 1 || y < 1 || z < 1) ? min(x,y,z) : corner);
  f=(print > 0) ? 180 : 90;
  
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
  }
}

module cupholderback() {
  rotate([angle,0,0]) {
    difference() {
      hull() {
	translate([-width/2-wall,-depth/2-wall,0]) roundedbox(width+2*wall,wall,collarz,cornerd);

	translate([-width/2-screwtowerd/2-wall/2,-wall-depth/2,0]) cube([0.01+screwtowerd/2+wall/2,wall,0.01]);
	translate([-width/2-screwtowerd/2,-depth/2-wall+cornerd/2,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([-width/2-screwtowerd/2,-depth/2-wall,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      
	translate([width/2+screwtowerd/2,-depth/2-wall+cornerd/2,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([width/2,-wall-depth/2,0]) cube([0.01+screwtowerd/2+wall/2,wall,0.01]);
	translate([width/2+screwtowerd/2,-depth/2-wall,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      
	translate([-width/2-screwtowerd/2,-depth/2-wall+cornerd/2,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([-width/2-screwtowerd/2,-depth/2-wall,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      
	translate([width/2+screwtowerd/2,-depth/2-wall+cornerd/2,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([width/2+screwtowerd/2,-depth/2-wall,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      }

      for (x=[-width/2-screwtowerd/2,width/2+screwtowerd/2]) 
	for (z=[screwtowerd/2,collarz-screwtowerd/2]) 
	  translate([x,-depth/2-wall+screwlength-0.01,z]) rotate([90,0,0]) ruuvireika(screwlength,screwholed,1);

      translate([0,-depth/2-wall+textdepth-0.01,collarz/2]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
    }
  }
}

module cupholderfront() {
  rotate([angle,0,0]) {
    difference() {
      union() {
	hull() {
	  translate([width/2,-depth/2,0]) roundedbox(wall,depth+wall,collarz,cornerd);
	  translate([width/2,-depth/2,0]) cube([0.01+screwtowerd/2+wall/2,0.01,0.01]);
	  translate([width/2+screwtowerd/2,-depth/2,screwtowerd/2]) rotate([270,0,0]) ruuvitorni(screwlength-wall,screwtowerd);
	  translate([width/2+screwtowerd/2,-depth/2,collarz-screwtowerd/2]) rotate([270,0,0]) ruuvitorni(screwlength-wall,screwtowerd);
	}
	hull() {
	  translate([-width/2-wall,-depth/2,0]) roundedbox(wall,depth+wall,collarz,cornerd);
	  translate([-width/2-wall/2-screwtowerd/2,-depth/2,0]) cube([0.01+wall/2+screwtowerd/2,1,1]);
	  translate([-width/2-screwtowerd/2,-depth/2,screwtowerd/2]) rotate([270,0,0]) ruuvitorni(screwlength-wall,screwtowerd);
	  translate([-width/2-screwtowerd/2,-depth/2,collarz-screwtowerd/2]) rotate([270,0,0]) ruuvitorni(screwlength-wall,screwtowerd);
	}
	translate([-width/2-wall,depth/2,0]) roundedbox(width+2*wall,wall,collarz,cornerd);
      }
      for (x=[-width/2-screwtowerd/2,width/2+screwtowerd/2]) 
	for (z=[screwtowerd/2,collarz-screwtowerd/2]) 
	  translate([x,-depth/2-wall+screwlength-0.01,z]) rotate([90,0,0]) ruuvireika(screwlength,screwholed,1);
    }
  }
  
  // cup base
  hull() {
    translate([0,
	       depth/2*cos(angle)-collarz*sin(angle)+cupoutdiameter/2+cupout,
	       collarz-depth/2*sin(angle)+depth/2*sin(angle)+wall])
      cylinder(h=wall,d=cupoutdiameter);
    translate([0,
	       depth/2*cos(angle)-collarz*sin(angle)+cupoutdiameter/2+cupout,
	       collarz-depth/2*sin(angle)+depth/2*sin(angle)+wall-cupoutdiameter/2])
      cylinder(h=wall,d=cupoutdiameter/2);
    rotate([angle,0,0]) {
      translate([-width/2-wall,depth/2,0]) roundedbox(width+2*wall,wall,collarz,cornerd);
    }
  }

  hull() {
    translate([0,
	       depth/2*cos(angle)-collarz*sin(angle)+cupoutdiameter/2+cupout,
	       collarz-depth/2*sin(angle)+depth/2*sin(angle)+wall-cupoutdiameter/2])
      cylinder(h=wall,d=cupoutdiameter/2);
    rotate([angle,0,0]) {
      translate([-width/2-wall,depth/2,0]) roundedbox(width+2*wall,wall,collarz,cornerd);
      translate([0,supportdistance,0]) cylinder(h=1,d=cupoutdiameter/5);
    }
  }

  rotate([angle,0,0]) {
    translate([0,depth/2+cornerd+1+textsize,textdepth-0.01]) rotate([0,180,0]) linear_extrude(textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
  }

  translate([0,
	     depth/2*cos(angle)-collarz*sin(angle)+cupoutdiameter/2+cupout,
	     collarz-depth/2*sin(angle)+depth/2*sin(angle)+cupcornerd/2+wall-0.01])  minkowski() {
    sphere(d=cupcornerd);
    difference() {
      cylinder(h=cupheight,d1=cupoutdiameter-cupcornerd,d2=cupoutdiameter+cupexpansion-cupcornerd);
      translate([0,0,cupcornerd]) {
	cylinder(h=cupheight+0.02,d1=cupdiameter+cupcornerd,d2=cupdiameter+cupexpansion+cupcornerd);
      }
      // Front cut to accomodate bikes form
      hull() {
	translate([-cupoutdiameter/2-cupexpansion/2-0.01,cupcutoffsetlow,cuphandlediameter/2+cuphandleraise]) rotate([90,0,90]) cylinder(h=cupoutdiameter+cupexpansion+0.02,d=cuphandlediameter);
	translate([-cupoutdiameter/2-cupexpansion/2-0.01,cupcutoffsethigh,cuphandlediameter/2+cuphandleraise+cupheight]) rotate([90,0,90]) cylinder(h=cupoutdiameter+cupexpansion+0.02,d=cuphandlediameter);
      }
    }
  }
}

module cupholder() {
  cupholderback();
  cupholderfront();
}

module endcap() {
  translate([xtolerance,0,0]) {
    diameter=handlebard+2*thinwall;
    difference() {
      hull() {
	translate([handlebarcurved/2+headphonehangw+headphonehangendh-4+thinwall,0,0]) rotate([0,90,0]) cylinder(d=headphonehangendd+10,h=2);
	translate([handlebarcurved/2+headphonehangw-screwholed*3+xtolerance,0,0]) rotate([0,90,0]) cylinder(d1=headphonehangendd,d2=headphonehangendd+10,h=headphonehangendh+screwholed*3+thinwall);
	//      translate([handlebarcurved/2+headphonehangw-screwholed*3/2,0,-headphonehangendd/2]) cylinder(d=screwholed*3,h=screwlength+headphonehangend);
      }
      rotate([90,0,0]) hull() {
	translate([handlebarcurved/2,0,0]) rotate([0,90,0]) {
	  cylinder(d=diameter+dtolerance,h=headphonehangw+thinwall);
	}
	//translate([handlebarcurved/2,diameter/2-1,-diameter/4-ztolerance]) cube([headphonehangw+thinnwall,1+ztolerance,diameter/2+ztolerance*2]);
	translate([handlebarcurved/2,-diameter/2-ztolerance,-diameter/4-ztolerance]) cube([headphonehangw+thinwall,1,diameter/2+ztolerance*2]);
      }

      translate([handlebarcurved/2+headphonehangw-screwholed*3/2-xtolerance,0,-headphonehangendd/2+screwlength-0.01]) rotate([180,0,0]) ruuvireika(screwlength,screwholed,1);
      translate([handlebarcurved/2+headphonehangw-screwholed*3/2-xtolerance,0,-headphonehangendd/2+0.01]) rotate([180,0,0]) cylinder(h=10,d1=screwholed*countersinkdiametermultiplier,d2=screwholed*countersinkdiametermultiplier*3);
    }
  }
}

module handlebarform(w) {
  diameter=handlebard+w*2;
  rotate([-90,0,0]) {
    rotate([0,45,0]) rotate([0,-90,90+180]) {
      rotate([0,0,20+(w?-0.1:0)]) rotate_extrude(angle=70+(w?0:0.1),convexity=10) translate([handlebarcurved/2,0]) hull() {
	circle(d=diameter);
	if (w) {
	  translate([-diameter/4,diameter/2-1]) square([diameter/2,1]);
	} else {
	  translate([-diameter/6,-diameter/2]) square([diameter/3,1]);
	}
      }
      rotate([90,0,20]) translate([handlebarcurved/2,0,-0.1]) {
	hull() {
	  cylinder(d=diameter,h=handlebarstraight+0.1+(w?-0.1:0));
	  if (w) {
	    translate([-diameter/4,diameter/2-1,0]) cube([diameter/2,1,handlebarstraight]);
	  } else {
	    translate([-diameter/6,-diameter/2-0.2,-0.1+0.2]) cube([diameter/3,1,handlebarstraight-0.2]);
	  }
	}
	 
	// Inner upper screw
	if (w) {
	  difference() {
	    hull() {
	      translate([-handlebard/2-screwholed*3/2,-diameter/2,-diameter/2+handlebarstraight+diameter/2-screwholed*3/2]) rotate([-90,0,0]) cylinder(h=diameter,d=screwholed*3);
	      translate([-screwholed*3/2,-diameter/2,-diameter/2+handlebarstraight+diameter/2-screwholed*3/2]) rotate([-90,0,0]) cylinder(h=diameter,d=screwholed*3);
	    }

	    translate([-handlebard/2-screwholed*3/2,handlebard/2-screwlength+thinwall+0.01,-diameter/2+handlebarstraight+diameter/2-screwholed*3/2]) rotate([-90,0,0]) ruuvireika(screwlength,screwholed,1);
	  }
	}
      }
    }

    if (w) hull() {
	translate([handlebarcurved/2,0,0]) rotate([0,90,0]) {
	  cylinder(d=diameter,h=headphonehangw+w);
	}
	translate([handlebarcurved/2,diameter/2-1,-diameter/4]) cube([headphonehangw+w,1,diameter/2]);
      } else {
      difference() {
	translate([handlebarcurved/2,0,0]) rotate([0,90,0]) {
	  hull() {
	    translate([0,0,diameter/2+thinwall]) cylinder(d=diameter,h=headphonehangw+thinwall-diameter/2-thinwall+0.01);
	    translate([-diameter/6,-diameter/2,diameter/2+thinwall]) cube([diameter/3,1,headphonehangw+thinwall-diameter/2-thinwall]);
	  }
	}
	translate([handlebarcurved/2+headphonehangw-screwholed*3/2,diameter/2,0]) rotate([90,0,0]) cylinder(h=diameter+0.01,d=screwholed*3);
      }
    }
  }

  if (w) {
    // Inner center screw
    hull() {
      translate([handlebarcurved/2-handlebard/2-screwholed*3/2,0,-diameter/2]) cylinder(h=diameter,d=screwholed*3);
      translate([handlebarcurved/2-screwholed*3/2,0,-diameter/2]) cylinder(h=diameter,d=screwholed*3);
    }
  } else {
    translate([handlebarcurved/2-handlebard/2-screwholed*3/2,0,(handlebard/2+thinwall)-1-4-0.01]) rotate([180,0,0]) ruuvireika(screwlength,screwholed,1);
    translate([handlebarcurved/2+headphonehangw-screwholed*3/2,0,-headphonehangendd/2+screwlength-0.01]) rotate([180,0,0]) ruuvireika(screwlength,screwholed,1);
  }

  // Lower screw
  // Math for this is broken, but I am too lazy to fit it right now
  if (w) {
    rotate([0,0,20-70+9]) hull() {
      translate([handlebarcurved/2+handlebard/2+screwholed*3/2,0,-diameter/2]) cylinder(h=diameter,d=screwholed*3);
      translate([handlebarcurved/2+screwholed*3/2,0,-diameter/2]) cylinder(h=diameter,d=screwholed*3);
    }
  } else {
    rotate([0,0,20-70+9]) {
      translate([handlebarcurved/2+handlebard/2+screwholed*3/2,0,(handlebard/2+thinwall)-1-4-0.01]) rotate([180,0,0]) ruuvireika(screwlength,screwholed,1);
    }
  }
}

module handlebar() {
  difference() {
    handlebarform(thinwall);
    handlebarform(0);
  }
}

module headphonehanger() {
  xmove=26;//10+45+84+screwholed*3/2/2;
  ymove=9;
  yoffset=14;
  r=0; //12.5;

  translate([-4,0,0]) rotate([0,0,-28]) {
    translate([-xmove,-ymove+yoffset-30,0]) {
      if (1) rotate([0,0,r]) intersection() {
	  handlebar();
	  translate([0,-handlebarcurved,0]) cube([handlebarcurved+headphonehangw,handlebarcurved*2,handlebard/2+thinwall]);
	}
    }

    translate([xmove,ymove+yoffset,handlebard/2+thinwall]) {
      if (1) translate([0,0,0]) rotate([0,0,180-r]) intersection() {
	  handlebar();
	  translate([0,-handlebarcurved,-(handlebard/2+thinwall)]) cube([handlebarcurved+headphonehangw,handlebarcurved*2,handlebard/2+thinwall]);
	}
    }
  }
}

if (print==0)
  cupholder();

if (print==1 || print==2)
  translate([-width-wall-wall-headphonehangd*cos(angle)-screwtowerd/2+3,0,0]) 
  rotate([-angle-90,0,0]) 
  translate([0,depth/2*cos(angle),depth/2*sin(angle)])
      cupholderback();

if (print==1 || print==3)
  rotate([-angle,0,0]) 
  translate([0,depth/2*cos(angle),depth/2*sin(angle)])
    cupholderfront();

if (print==4) {
  // #printareacube("ankermake");
  
   rotate([0,0,0]) translate([6,-2,0]) {
     headphonehanger();
     //     translate([-handlebard*2-20,headphonehangendd-20,headphonehangendh+screwholed*3+thinwall-0.25]) rotate([0,90,0]) translate([-handlebarcurved,0,0]) endcap();
     translate([-handlebarcurved/2-10,handlebard/2+5,-6]) rotate([0,90,0]) translate([-handlebarcurved/2-headphonehangw-headphonehangend+thinwall-3.5,0,0]) endcap();
   }
 }

if (print==5) {
  intersection() {
    union() {
      handlebar();
      endcap();
    }
    if (debug) translate([0,0,-100]) cube([200,200,200]);
  }
 }

module powerstripholderback() {
  rotate([angle,0,0]) {
    difference() {
      hull() {
	translate([-width/2-wall,-depth/2-wall,0]) roundedbox(width+2*wall,wall,collarz,cornerd);

	translate([-width/2-screwtowerd/2-wall/2,-wall-depth/2,0]) cube([0.01+screwtowerd/2+wall/2,wall,0.01]);
	translate([-width/2-screwtowerd/2,-depth/2-wall+cornerd/2,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([-width/2-screwtowerd/2,-depth/2-wall,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      
	translate([width/2+screwtowerd/2,-depth/2-wall+cornerd/2,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([width/2,-wall-depth/2,0]) cube([0.01+screwtowerd/2+wall/2,wall,0.01]);
	translate([width/2+screwtowerd/2,-depth/2-wall,screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      
	translate([-width/2-screwtowerd/2,-depth/2-wall+cornerd/2,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([-width/2-screwtowerd/2,-depth/2-wall,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      
	translate([width/2+screwtowerd/2,-depth/2-wall+cornerd/2,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall-cornerd/2,d=screwtowerd);
	translate([width/2+screwtowerd/2,-depth/2-wall,collarz-screwtowerd/2]) rotate([270,0,0]) cylinder(h=wall,d=screwtowerd-cornerd);
      }

      if (0) for (x=[-width/2-screwtowerd/2,width/2+screwtowerd/2]) 
	for (z=[screwtowerd/2,collarz-screwtowerd/2]) 
	  translate([x,-depth/2-wall+screwlength-0.01,z]) rotate([90,0,0]) ruuvireika(screwlength,screwholed,1);

      translate([0,-depth/2-wall+textdepth-0.01,collarz/2]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
    }
  }
}

powerstripcollarz=screwtowerd;

module powerstripholderfront() {
  rotate([angle,0,0]) {
    difference() {
      union() {
	for (m=[0,1]) mirror([m,0,0]) hull() {
	    translate([width/2,-depth/2,0]) roundedbox(wall,depth+wall,powerstripcollarz,cornerd,1);
	    translate([width/2+screwtowerd/2,-depth/2,screwtowerd/2]) rotate([270,0,0]) roundedcylinder(screwtowerd,screwl-wall,cornerd,0,90);
	    translate([width/2+screwtowerd/2-screwtowerd/4,-depth/2,0]) roundedbox(screwtowerd/2,screwl-wall,screwtowerd/2,cornerd,1);
	  }
	translate([-width/2-wall,depth/2,0]) roundedbox(width+2*wall,wall,powerstripcollarz,cornerd,1);
      }

      for (m=[0,1]) mirror([m,0,0]) hull() {
	  translate([width/2+screwtowerd/2,-depth/2-0.01,screwtowerd/2]) rotate([270,0,0]) cylinder(d=screwd,h=screwl-wall,$fn=90);
	  translate([width/2+screwtowerd/2-screwd/4,-depth/2-0.01,screwtowerd/2]) cube([screwd/2,screwl,screwd/2]);
	}
      
      for (m=[0,1]) mirror([m,0,0]) hull() {
	  translate([width/2+screwtowerd/2,thinwall+cornerd-depth/2-0.01,screwtowerd/2+screwtowerd]) rotate([270,0,0]) cylinder(d=nutd,h=nuth,$fn=6);
	  translate([width/2+screwtowerd/2,thinwall+cornerd-depth/2-0.01,screwtowerd/2]) rotate([270,0,0]) cylinder(d=nutd,h=nuth,$fn=6);
	}

#      translate([0,depth/2+wall-textdepth+0.01,powerstripcollarz/2]) rotate([-90,180,0]) linear_extrude(textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
    }
  }
}

if (print==6 || print==8) {
  powerstripholderfront();
 }

if (print==7 || print==8) {
  difference() {
    translate([0,-HEIGHT/2-depth/2-0.5,WIDTH_MAX/2-12]) rotate([0,-90,90]) end_cap(1,width+screwtowerd,screwd,screwheadd);
    translate([width/2,-depth/2-textsize,textdepth-0.01]) rotate([0,180,90]) linear_extrude(textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="left");
  }
 }


