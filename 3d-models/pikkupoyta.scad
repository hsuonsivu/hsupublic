// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;

//0.35
xtolerance=0.40;
ytolerance=0.40;
ztolerance=0.45;
dtolerance=0.7;

scaling=0.85;
length=280*scaling;
width=105*scaling;
legx=280*0.8/2*scaling;
h=20*scaling;
legangle=25;
openangle=25;//-90; //25;
height=102*cos(legangle)*scaling;
textsize=width/2.5;
textdepth=0.8;
text="Lempi";

cornerd=1*scaling;
tablecornerd=5*scaling;

axled=9*scaling;
axleheight=axled/2+2*scaling;
axledepth=2*scaling;
axlex=legx*scaling;
legw=width-tablecornerd*2-axledepth;
legheight=0;
legmidh=10*scaling;
legbw=axled+2*scaling;
legbwidth=legw-legbw;

module leg(angle,cutout,zexpand) {
  l=cutout?ytolerance:0;
  lw=cutout?ytolerance*2:0;
  dt=cutout?dtolerance:0;
  
  translate([0,legbwidth/2,0]) onehinge(axled,legbw,axledepth,cutout,ytolerance,dtolerance);
  translate([0,legbwidth/2+legbw/2+l,0]) rotate([90,0,0]) cylinder(d=axled+dt,h=legbw+l*2+0.02);
  translate([0,-legbwidth/2,0]) onehinge(axled,legbw,axledepth,cutout,ytolerance,dtolerance);
  translate([0,-legbwidth/2+legbw/2+l,0]) rotate([90,0,0]) cylinder(d=axled+dt,h=legbw+l*2);

  zlist=(cutout&&zexpand)?[0,-legbw]:[0];
  zt=cutout?ztolerance:0;
  translate([0,0,-axleheight]) {
    hull() {
      for (z=zlist) {
	xl=z?-legbw/2:legbw/2;
	translate([0-zt,legbwidth/2-legbw/2-l,z+legheight-zt]) roundedbox(height+xl,legbw+l*2,legbw+zt*2,cornerd);
      }
      if (cutout) {
	translate([0,legbwidth/2-legbw/4,legheight+legbw/4]) cube([height,legbw/2,legbw+ztolerance]);
      }
    }
    hull() {
      for (z=zlist) {
	xl=z?-legbw/2:legbw/2;
	translate([0-zt,-legbwidth/2-legbw/2-l,z+legheight-zt]) roundedbox(height+xl,legbw+l*2,legbw+zt*2,cornerd);
      }
      if (cutout) {
	translate([0,-legbwidth/2-legbw/4,legheight+legbw/4]) cube([height,legbw/2,legbw+ztolerance]);
      }
    }
    hull() {
      for (z=zlist) {
	xl=z?legbw/2:0;
	hull() {
	  translate([height-cornerd/2-xl,-legbwidth/2-legbw/2-l,z+legheight+zt]) rotate([0,-legangle,0]) roundedbox(legbw+xl*2,legbwidth+legbw+l*2,legbw,cornerd);
	  translate([height-cornerd/2-xl-legbw*sin(angle)+2,-legbwidth/2-legbw/2-l,z+legheight/2+zt]) roundedbox(legbw+xl*2+legbw/2*sin(angle),legbwidth+legbw+l*2,1,cornerd);
	}
      }
      if (cutout) {
	translate([height,-legbwidth/2-legbw/2,legheight+legbw/4+legbw/4*sin(legangle)]) cube([legbw/2,legbwidth+legbw,legbw+ztolerance]);
      }
    }
    hull() {
      for (z=zlist) {
	xl=z?legbw/2:0;
	translate([legmidh-xl-zt,-legbwidth/2-legbw/2-l,z+legheight-zt]) roundedbox(legbw+xl*2+zt*2,legbwidth+legbw+l*2,legbw+zt*2,cornerd);
      }
      if (cutout) {
	translate([legmidh+legbw/4,-legbwidth/2-legbw/2+legbw/4,legheight+legbw/4]) cube([legbw/2,legbwidth+legbw/2,legbw+ztolerance+0.2]);
      }
    }
  }
}

module legcut(angle) {
  translate([0,legbwidth/2,0]) onehinge(axled,legbw+ytolerance*2,axledepth,1,ytolerance,dtolerance);
  translate([0,-legbwidth/2,0]) onehinge(axled,legbw+ytolerance*2,axledepth,1,ytolerance,dtolerance);
}

module pikkupoyta(angle) {
  difference() {
    translate([-length/2,-width/2,0]) roundedbox(length,width,h,tablecornerd);
    translate([-legx,0,axleheight]) leg(legangle,1,1);
    translate([-legx,0,axleheight]) rotate([0,90+legangle,0]) leg(legangle,1,0);
    mirror([1,0,0]) {
      translate([-legx,0,axleheight]) leg(legangle,1,1);
      translate([-legx,0,axleheight]) rotate([0,90+legangle,0]) leg(legangle,1,0);
    }
    translate([0,0,h-textdepth+0.01]) linear_extrude(textdepth) rotate([0,0,0]) text("Lempi",size=textsize,halign="center",valign="center");
  }

  translate([-legx,0,axleheight]) rotate([0,angle,0]) leg(legangle,0,0);
  mirror([1,0,0]) translate([-legx,0,axleheight]) rotate([0,angle,0]) leg(legangle,0,0);
}

if (print==0) {
  intersection() {
    pikkupoyta(print==1?0:90+openangle);
    //translate([20,-200,-200]) cube([400,400,400]);
    //translate([-200,00,-200]) cube([400,400,400]);
  }
 }

if (print==1) {
  rotate([0,0,45]) pikkupoyta(0);
 }

