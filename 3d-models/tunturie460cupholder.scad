// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

print=1;
strong=1;
supports=1; // patches for easier printing
$fn=print?90:30;

width=50.3;
depth=70.2;
collarz=130;
angle=15.75;
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
screwlength=30; //19;
screwtowerd=3*screwholed;
cupcutoffsetlow=-50;
cupcutoffsethigh=-45;

headphonehanglowd=10;
headphonehangd=10;
headphonehangw=70+headphonehangd;
headphonehangh=50;
headphonehangout=10;
thinwall=1.6;

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

module roundedbox(x,y,z,c) {
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

	// Headphone hanger
	hull() {
	  translate([-width/2-wall-headphonehanglowd/2+wall,depth/2-35,0]) cylinder(d=headphonehanglowd,h=1);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout+10,depth/2,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	}
	hull() {
	  translate([-width/2-wall-headphonehangd/2+wall,depth/2,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout+10,depth/2,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2+wall,depth/2-headphonehangd*sin(angle),collarz-headphonehangd/2-headphonehangd]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout+headphonehangd+10,depth/2-headphonehangd*sin(angle),collarz-headphonehangd/2-headphonehangd]) sphere(d=thinwall);
	}
	hull() {
	  translate([-width/2-wall-headphonehanglowd/2+wall,depth/2-35,0]) cylinder(d=thinwall,h=1);
	  translate([-width/2-wall-headphonehangd/2+wall,depth/2-headphonehangd*sin(angle),collarz-headphonehangd/2-headphonehangd]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout+headphonehangd+10,depth/2-headphonehangd*sin(angle),collarz-headphonehangd/2-headphonehangd]) sphere(d=thinwall);
	}
	hull() {
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout+10,depth/2,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout,depth/2+(headphonehangh-headphonehangd)*sin(angle),collarz+headphonehangh-headphonehangd]) sphere(d=headphonehangd);
	}
	hull() {
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout,depth/2+(headphonehangh)*sin(angle),collarz+headphonehangh]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout,depth/2+(headphonehangh-headphonehangd)*sin(angle),collarz+headphonehangh-headphonehangd]) sphere(d=headphonehangd);
	}
	hull() {
	  translate([-width/2-wall-headphonehangd/2-headphonehangout,depth/2,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2-headphonehangout,depth/2+headphonehangh*sin(angle),collarz+headphonehangh]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2+wall,depth/2,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2+wall,depth/2+headphonehangout*2*sin(angle),collarz-headphonehangd/2-headphonehangout*2*2]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2+wall,-depth/4,collarz-headphonehangd/2]) sphere(d=headphonehangd);
	}
	hull() {
	  translate([-width/2-wall-headphonehangd/2-headphonehangout,depth/2+(headphonehangh-headphonehangd)*sin(angle),collarz+headphonehangh-headphonehangd]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout,depth/2+(headphonehangh-headphonehangd)*sin(angle),collarz+headphonehangh-headphonehangd]) sphere(d=headphonehangd);
	  translate([-width/2-wall-headphonehangd/2-headphonehangout,depth/2+(headphonehangh-headphonehangd*2)*sin(angle),collarz+headphonehangh-headphonehangd*2]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout,depth/2+(headphonehangh-headphonehangd*2)*sin(angle),collarz+headphonehangh-headphonehangd*2]) sphere(d=thinwall);
	}
	hull() {
	  translate([-width/2-wall-headphonehangd/2-headphonehangout,depth/2+(headphonehangh-headphonehangd*2)*sin(angle),collarz+headphonehangh-headphonehangd*2]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout,depth/2+(headphonehangh-headphonehangd*2)*sin(angle),collarz+headphonehangh-headphonehangd*2]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2-headphonehangw-headphonehangout+10,depth/2,collarz-headphonehangd/2]) sphere(d=thinwall);
	  translate([-width/2-wall-headphonehangd/2-headphonehangout,depth/2,collarz-headphonehangd/2]) sphere(d=thinwall);
	}
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

translate([0,
	   depth/2*cos(angle)-collarz*sin(angle)+cupoutdiameter/2+cupout,
	   collarz-depth/2*sin(angle)+depth/2*sin(angle)+wall-0.01]) {
  difference() {
    cylinder(h=cupheight,d1=cupoutdiameter,d2=cupoutdiameter+cupexpansion);
    cylinder(h=cupheight+0.02,d1=cupdiameter,d2=cupdiameter+cupexpansion);
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

