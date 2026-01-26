// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;

// Set to desired belt width
desiredbeltwidth=8.5;

// Original belt width to be narrowed
originalbeltwidth=16.25;

beltwidew=originalbeltwidth;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

cornerd=2;

// Parkside precision hobby knife blade
bladextolerance=0.3;
bladeytolerance=0.2;
bladeztolerance=0.2;

bladel=39.7;
bladew=0.54;

versiontext=str("V1.1");
brandtext="Belt cutter";

textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

// Adjust for blade positions for later calculations.
// XXX This is a kludge and causes the cut to be slightly off-center
beltcutadjust=-bladeytolerance-bladew/2-ytolerance/2+ytolerance;
beltcutw=desiredbeltwidth+beltcutadjust;

belth=4.7;

bladekantal=10.44;
bladekantah=5.83;

bladeholex=4.3;
bladeholel=4.75;
bladeholed=2.56;

bladebodyx=15;

bladebodynarrowingl=bladebodyx-bladekantal;
bladebodynarrowingx=bladekantal;

bladecutx=19.26;
bladecutangle=23.24;
bladecutl=bladel-bladecutx;

bladebodyh=8;
bladebodyl=bladel-bladekantal-bladebodynarrowingl-bladecutl;

beltcuttersidew=5;
beltcuttertoph=27;
beltcutterbottomh=10;
beltcutterw=beltcuttersidew+ytolerance+beltwidew+ytolerance+beltcuttersidew;
beltcutterl=80;
beltcutterh=beltcutterbottomh+ztolerance+belth+ztolerance+beltcuttertoph;
beltcuttertrim=(beltwidew-beltcutw)/2;
beltcutterleftw=beltcuttersidew+ytolerance+beltwidew;

beltcuttermidw=beltcutw-ytolerance;

bladeheight=29;
bladeangle=75;
bladex=beltcutterl-bladebodyh-sin(bladeangle)*bladel/2;

bladepinw=ytolerance+2;

screwd=4.4; // M4
screwheadd=8.5; //8.6; // Round head
screwheadh=3.1;
screwheadspaceh=6;
screwl=22.6; // 23; // 23.15;
nutd=7.1;
nuth=2.3;

screwtable=[[cornerd+screwheadd,-beltcutterbottomh+beltcutterh-screwheadd],
	    [min(beltcutterl/2,bladex-bladel/3-screwd+bladebodyh),-beltcutterbottomh+beltcutterh-screwheadd],
	    [beltcutterl-screwheadd-cornerd,-beltcutterbottomh+beltcutterh-screwheadd],
	    [bladex-bladebodyh/2,-beltcutterbottomh/2]];

bladeytable=[-beltcuttermidw/2-bladeytolerance-bladew/2,beltcuttermidw/2+ytolerance/2];
echo(bladeytable[0],bladeytable[1],bladeytable[1]-bladeytable[0]);

module screwholes() {
  //screwy=-screwl/2;
  screwy=beltcutterw/2-screwl+0.02;
  for (xz=screwtable) {
    translate([xz[0],screwy-0.01,xz[1]]) rotate([-90,0,0]) cylinder(d=screwd,h=screwl,$fn=90);
    hull() {
      difference=nutd-screwd;
      translate([xz[0],screwy+0.01,xz[1]]) rotate([90,0,0]) cylinder(d=nutd/cos(180/6),h=screwl,$fn=6);
      translate([xz[0],screwy+0.01+difference/2,xz[1]]) rotate([90,0,0]) cylinder(d=nutd-difference,h=screwl+difference/2,$fn=6);
    }
    //translate([xz[0],screwl/2-0.01,xz[1]]) rotate([-90,0,0]) cylinder(d=screwheadd,h=screwl,$fn=90);
  }
}

module blade() {
  difference() {
    union() {
      translate([0,-bladew/2,-bladekantah/2]) cube([bladekantal,bladew,bladekantah]);
      hull() {
	translate([bladebodyx,-bladew/2,-bladebodyh/2]) cube([bladebodyl,bladew,bladebodyh]);
	translate([bladecutx,-bladew/2,-bladebodyh/2]) triangle(bladecutl,bladew,bladebodyh,1);
      }
      hull() {
	translate([bladebodynarrowingx-0.01,-bladew/2,-bladekantah/2]) cube([bladebodynarrowingl,bladew,bladekantah]);
	translate([bladebodynarrowingx+bladebodynarrowingl-0.01,-bladew/2,-bladebodyh/2]) cube([0.02,bladew,bladebodyh]);
      }
    }

    bladehole(0);
  }
}

module bladehole(dt) {
  hull() {
    translate([bladeholex+bladeholed/2,-bladew/2-0.01,0]) rotate([-90,0,0]) cylinder(d=bladeholed-dt,h=bladew+0.02,$fn=90);
    translate([bladeholex+bladeholel-bladeholed/2,-bladew/2-0.01,0]) rotate([-90,0,0]) cylinder(d=bladeholed-dt,h=bladew+0.02,$fn=90);
  }
}

module bladepinspaceold() {
  for (y=[-beltcuttermidw/2-ytolerance/2,baltcuttermidw/2+ytolerance/2]) rotate([0,bladeangle,0]) {
      hull() {
	translate([bladeholex+bladeholed/2,y,0]) rotate([-90,0,0]) cylinder(d=bladeholed,h=bladepinw+ytolerance,$fn=90);
	translate([bladeholex+bladeholel-bladeholed/2,y,0]) rotate([-90,0,0]) cylinder(d=bladeholed,h=bladepinw+ytolerance,$fn=90);
      }
    }
}

module bladepinspace(y) {
  translate([bladex,y-bladew/2-ytolerance,bladeheight]) rotate([0,bladeangle,0]) {
    hull() {
      translate([bladeholex+bladeholed/2,0,0]) rotate([-90,0,0]) cylinder(d=bladeholed,h=bladepinw+ytolerance,$fn=90);
      translate([bladeholex+bladeholel-bladeholed/2,0,0]) rotate([-90,0,0]) cylinder(d=bladeholed,h=bladepinw+ytolerance,$fn=90);
    }
  }
}

module bladepin(y) {
  dt=0.3;
  
  translate([bladex,y-bladew/2-ytolerance-0.01,bladeheight]) rotate([0,bladeangle,0]) {
    hull() {
      translate([bladeholex+bladeholed/2,0,0]) rotate([-90,0,0]) cylinder(d=bladeholed-dt,h=bladepinw,$fn=90);
      translate([bladeholex+bladeholel-bladeholed/2,0,0]) rotate([-90,0,0]) cylinder(d=bladeholed-dt,h=bladepinw,$fn=90);
    }
  }
}

module bladespace() {
  for (yy=bladeytable) {
    hull() {
      for (z=[-bladeztolerance/2,bladeztolerance]) {
	for (y=[-bladeytolerance/2,bladeytolerance]) {
	  for (x=[-xtolerance/2,xtolerance/2]) {
	    translate([bladex,yy,bladeheight]) rotate([0,bladeangle,0]) translate([x,y,z]) blade();
	  }
	}
      }
    }
  }

  hull() {
    translate([beltcutterl,0,belth/2]) rotate([0,90,0]) cylinder(d=beltwidew,h=1,$fn=180);
    translate([bladex+sin(bladeangle)*bladel/3-bladebodyh,0,belth/2]) rotate([0,90,0]) cylinder(d=belth,h=1,$fn=180);
  }
}

module blades() {
  for (yy=bladeytable) {
    translate([bladex,yy,bladeheight]) rotate([0,bladeangle,0]) blade();
  }
}
module beltcutterleft() {
  difference() {
    union() {
      translate([0,-beltcutterw/2,-beltcutterbottomh-ztolerance]) roundedbox(beltcutterl,beltcutterleftw,beltcutterbottomh,cornerd,4);
      translate([0,-beltcutterw/2,-beltcutterbottomh-ztolerance]) roundedbox(beltcutterl,beltcuttersidew,beltcutterh,cornerd,4);
      translate([0,-beltcutterw/2,belth+ztolerance]) roundedbox(beltcutterl,beltcuttersidew+beltcuttertrim+ytolerance/2,beltcuttertoph,cornerd,4);
    }

    bladespace();

    beltcutexpand();

    screwholes();

    translate([beltcutterl-textlen("OUT",textsize)-cornerd,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+textsize+1+cornerd/2]) rotate([90,0,0]) linear_extrude(textdepth) text("OUT",size=textsize,font=textfont,valign="top",halign="left");
    translate([textlen("IN",textsize)+cornerd+1,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+textsize+1+cornerd/2]) rotate([90,0,0]) linear_extrude(textdepth) text("IN",size=textsize,font=textfont,valign="top",halign="right");
    
    translate([beltcutterl/2,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh/2+textsize/2]) rotate([90,0,0]) linear_extrude(textdepth) text(str(brandtext," ",versiontext),size=textsize,font=textfont,valign="center",halign="center");
    translate([beltcutterl/2,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh/2-textsize/2-1]) rotate([90,0,0]) linear_extrude(textdepth) text(str(originalbeltwidth," to ",desiredbeltwidth),size=textsize-1,font=textfont,valign="center",halign="center");
  }

  bladepin(bladeytable[0]);
}

module beltcutexpand() {
  for (m=[0,1]) mirror([0,m,0]) hull() {
      translate([bladex+sin(90-bladeangle)*bladel*2/3+bladebodyh,-beltwidew/2-ytolerance/2-bladew,-ztolerance]) cube([beltcutterl/2,ytolerance+bladew*2,belth+ztolerance*2]);
      translate([bladex+sin(90-bladeangle)*bladel*2/3,-beltwidew/2-ytolerance/2-bladew/2,-ztolerance]) cube([beltcutterl/2,ytolerance+bladew,belth+ztolerance*2]);
      translate([bladex+sin(90-bladeangle)*bladel*2/3-bladebodyh,-beltwidew/2-ytolerance/2,-ztolerance]) cube([beltcutterl/2,ytolerance,belth+ztolerance*2]);
  }
}

module beltcuttermid() {
  difference() {
    union() {
      translate([0,-beltcuttermidw/2,belth+ztolerance]) roundedbox(beltcutterl,beltcuttermidw,beltcuttertoph,cornerd,4);
    }

    bladespace();

    bladepinspace(bladeytable[0]);

    screwholes();

    translate([textlen(versiontext,textsize)+cornerd+1,beltcuttermidw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2-0.01]) rotate([-90,180,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="left");
  }

  bladepin(bladeytable[1]);
}

module beltcutterright() {
  difference() {
    union() {
      translate([0,beltwidew/2+ytolerance,-beltcutterbottomh-ztolerance]) roundedbox(beltcutterl,beltcuttersidew,beltcutterh,cornerd,5);
      translate([0,beltcutw/2+ytolerance/2,belth+ztolerance]) roundedbox(beltcutterl,ytolerance/2+beltcuttersidew+beltcuttertrim,beltcuttertoph,cornerd,5);
    }
    bladespace();

    bladepinspace(bladeytable[1]);

    beltcutexpand();

    screwholes();

    translate([beltcutterl-textlen("OUT",textsize)-cornerd,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+textsize+1+cornerd/2]) rotate([-90,180,0]) linear_extrude(textdepth) text("OUT",size=textsize,font=textfont,valign="top",halign="right");
    translate([textlen("IN",textsize)+cornerd+1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+textsize+1+cornerd/2]) rotate([-90,180,0]) linear_extrude(textdepth) text("IN",size=textsize,font=textfont,valign="top",halign="left");

    translate([beltcutterl/2,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2+textsize/2]) rotate([-90,180,0]) linear_extrude(textdepth) text(str(brandtext," ",versiontext),size=textsize,font=textfont,valign="center",halign="center");
    translate([beltcutterl/2,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2-textsize/2-1]) rotate([-90,180,0]) linear_extrude(textdepth) text(str(originalbeltwidth," to ",desiredbeltwidth),size=textsize-1,font=textfont,valign="center",halign="center");
  }
}

if (print==0) {
  difference() {
    union() {
      beltcutterleft();
      #    beltcuttermid();
      beltcutterright();
      #    blades();
    }
  
    //#translate([-100,-beltwidew/2,0]) roundedbox(beltcutterl*3,beltwidew,belth,cornerd,0);
  }
 }

if (print==1 || print==4) {
  translate([0,-beltcutterbottomh-ztolerance-0.5,beltcutterw/2]) rotate([90,0,0]) beltcutterleft();
 }

if (print==2 || print==4) {
  translate([0,-beltcutterh+belth-ztolerance-0.5,beltcuttermidw/2]) rotate([90,0,0]) beltcuttermid();
 }

if (print==3 || print==4) {
  translate([beltcutterl,beltcutterh-beltcutterbottomh-ztolerance,beltcutterw/2]) rotate([-90,0,180]) beltcutterright();
 }

if (print==5) {
  translate([-0.5,0,bladew/2]) rotate([90,0,180]) blade();
 }
