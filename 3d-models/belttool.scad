// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// This cuts belt narrower, either with two blades from middle of wide
// belt, or from edge. Thinner is version which thins leather belt.

include <hsu.scad>

print=0;
debug=1;

// 1 = cut one edge, 2 = cut from both sides. Maybe more accurate but wastes material.
cuts=2;
// This reverses measurements to allow thinning. Only works with cuts=1
thinning=0;

if (cuts==2 && thinning>0)
  echo("ERROR when thinning cuts cannot be 2 !");

// Set to desired belt width and thickness
//desiredbeltwidth=7.5;
//desiredbeltthickness=3.9;
desiredbeltwidth=7.5; //16.25;
desiredbeltthickness=3.9;

// Original belt width to be narrowed
originalbeltwidth=16.25;
originalbeltthickness=4.7;

beltwidew=thinning?originalbeltthickness:originalbeltwidth;

xtolerance=0.2;
ytolerance=0.2;
ztolerance=0.2;
dtolerance=0.5;

beltxtolerance=0.05;
beltytolerance=0.05;
beltztolerance=0.05;
beltdtolerance=0.1;

cornerd=2;

// Parkside precision hobby knife blade
bladextolerance=0.20;
bladeytolerance=0.20;
bladeztolerance=0.20;

bladel=39.7;
bladew=0.54;

versiontext=str("V1.10");
brandtext=thinning?str("Thinner"):str(cuts==2?"Trimmer":"Cutter");
measurementtext=thinning?str(originalbeltthickness,">",desiredbeltthickness,"mm"):str(originalbeltwidth,">",desiredbeltwidth,"mm");
versiontextsize=4.5;
textsize=7;
inouttextsize=thinning?5:6;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

// Adjust for blade positions for later calculations.
// XXX This is a kludge and causes the cut to be slightly off-center
beltcutadjust=(cuts==2?-bladeytolerance-bladew/2:-bladew/2+beltytolerance/2+bladeytolerance+0.05);//bladeytolerance/2);
//echo("beltcutadjust ",beltcutadjust);
beltcutw=(thinning?desiredbeltthickness+beltcutadjust:desiredbeltwidth+beltcutadjust);

belth=(thinning?originalbeltwidth:originalbeltthickness);

bladekantal=10.44;
bladekantah=5.83;

bladeholex=4.3;
bladeholel=4.75;
bladeholed=2.56;
bladeholemid=bladeholex+bladeholel/2;

bladebodyx=15;

bladebodynarrowingl=bladebodyx-bladekantal;
bladebodynarrowingx=bladekantal;

bladecutx=19.26;
bladecutl=bladel-bladecutx;
bladecutll=3.1;
bladecutextend=1.5; // Sharpening of the edge measured from blade at 90 degrees

bladebodyh=8;
bladebodyl=bladel-bladekantal-bladebodynarrowingl-bladecutl;

bladeangle=90+21.4;
bladeheight=belth/2-bladel*cos(bladeangle)+12;

beltcuttersidew=5;
beltcuttertoph=bladeheight+bladekantah/2*sin(bladeangle)-belth-beltztolerance;
beltcutterbottomh=10;
beltcutterw=beltcuttersidew+beltytolerance+beltwidew+beltytolerance+beltcuttersidew;
beltcutterl=thinning?46:(cuts==2?65:55);
beltcutterh=beltcutterbottomh+beltztolerance+belth+beltztolerance+beltcuttertoph;
beltcuttertrim=(beltwidew-beltcutw)/2;
beltcutterleftw=beltcuttersidew+beltytolerance+beltwidew;

beltcuttermidw=beltcutw-beltytolerance;

bladesideangle=thinning?0:0;//bladew/2,1.5
bladeverticalangle=thinning?10:0;//5.5:0;
bladex=beltcutterl-bladebodyh;//-sin(bladeangle)*bladel/2+2;
cutx=bladex-(sin(bladeangle-90)*(bladel-bladecutl)+sin(bladeangle)*bladebodyh/2);
angleyadjust=thinning?sin(bladeverticalangle)*(sin(bladeangle)*(bladel-bladecutl)+sin(bladeangle)*bladebodyh/2)/2:0;
//echo("bladeverticalangle ", bladesideangle);

bladepinw=ytolerance+1.5;
bladepinnarroww=0.5;

beltcuttertrimleft=(cuts==2?beltcuttertrim:beltcutw+(thinning?angleyadjust/2:0));
beltcuttertrimright=(cuts==2?beltcuttertrim:beltwidew-beltcutw+(thinning?-angleyadjust/2:0));

screwd=4.4; // M4
screwheadd=8.5; //8.6; // Round head
screwheadh=3.1;
screwheadspaceh=6;
screwl=22.6; // 23; // 23.15;
nutd=7.1;
nuth=2.3;

longclipl=beltcutterl-5;
longclipdepth=1;
longclipd=3;

upclipl=beltcuttertoph-4;
upclipdepth=1;
upclipd=3;

screwtable=thinning?[[min(beltcutterl/2,bladex-bladel/3-screwd+bladebodyh),-beltcutterbottomh+beltcutterh-screwheadd],
		     [beltcutterl/2,-beltcutterbottomh/2]]:
  [[cornerd+screwheadd,-beltcutterbottomh+beltcutterh-screwheadd],
   [beltcutterl/2,-beltcutterbottomh/2],
   [beltcutterl-sin(bladeangle)*bladel/2-screwd/2,-beltcutterbottomh+beltcutterh-screwheadd]
   ];

bladeytable=(cuts==2?[-beltcuttermidw/2-bladeytolerance-bladew/2,beltcuttermidw/2+beltytolerance/2]:[-beltwidew/2+beltcutw+beltytolerance]);

bottomleftextendx=screwtable[1][0];
bottomleftextendl=screwheadd+cornerd;

if (cuts==2) {
  //echo("Blade positions ",bladeytable[0],bladeytable[1]," blade distance ",bladeytable[1]-bladeytable[0]);
 } else {
  //echo("Blade position ",bladeytable[0]);
 }

module screwholes() {
  screwy=beltcutterw/2;
  for (xz=screwtable) {
    translate([xz[0],-beltcutterw/2-0.01,xz[1]]) rotate([-90,0,0]) cylinder(d=screwd,h=beltcutterw+0.02,$fn=90);
    hull() {
      difference=nutd-screwd;
      translate([xz[0],screwy-nuth+0.01,xz[1]]) rotate([-90,0,0]) cylinder(d=nutd/cos(180/6),h=nuth,$fn=6);
      translate([xz[0],screwy-nuth+0.01-difference/2,xz[1]]) rotate([-90,0,0]) cylinder(d=nutd-difference,h=nuth+difference/2,$fn=6);
    }
  }
}

// part 1 is kanta, part 2 is blade part. 0 is both.
module blade(part=0) {
  difference() {
    union() {
      if (part==1 || part==0) translate([0,-bladew/2,-bladekantah/2]) cube([bladekantal,bladew,bladekantah]);
      if (part==2 || part==0) hull() {
	translate([bladebodyx,-bladew/2,-bladebodyh/2]) cube([bladebodyl-bladecutll,bladew,bladebodyh]);
	translate([bladecutx-bladecutll,-bladew/2,-bladebodyh/2]) triangle(bladecutl,bladew,bladebodyh,1);
	translate([bladebodyx,-0.005,-bladebodyh/2]) cube([bladebodyl,0.01,bladebodyh]);
	translate([bladecutx,-0.005,-bladebodyh/2]) triangle(bladecutl,0.01,bladebodyh,1);
      }
      if (part==2 || part==0) hull() {
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

module bladepinspace(y) {
  ww=bladepinw+ytolerance;
  translate([bladex,y+bladew/2+bladeytolerance-0.01,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) {
#    hull() {
      translate([bladeholex+bladeholed/2,0,0]) rotate([-90,0,0]) cylinder(d=bladeholed,h=ww+ytolerance+1,$fn=90);
      translate([bladeholex+bladeholel-bladeholed/2,0,0]) rotate([-90,0,0]) cylinder(d=bladeholed,h=ww+ytolerance+1,$fn=90);
    }
  }
}

module bladepin(y) {
  dt=0.1;
  
  translate([bladex,y-bladew/2-beltytolerance+angleyadjust-0.01,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) {
    hull() {
      translate([bladeholex+bladeholed/2,-1,0]) rotate([-90,0,0]) cylinder(d=bladeholed-dt,h=bladepinw-bladepinnarroww+1,$fn=90);
      translate([bladeholex+bladeholel-bladeholed/2,-1,0]) rotate([-90,0,0]) cylinder(d=bladeholed-dt,h=bladepinw-bladepinnarroww+1,$fn=90);
      translate([bladeholex+bladeholed/2,-1,0]) rotate([-90,0,0]) cylinder(d=bladeholed/2-dt,h=bladepinw+1,$fn=90);
      translate([bladeholex+bladeholel-bladeholed/2,-1,0]) rotate([-90,0,0]) cylinder(d=bladeholed/2-dt,h=bladepinw+1,$fn=90);
    }
  }
}

module bladespace(ytolerance=bladeytolerance,part=0) {
  if (part==0 || part==1) {
    for (yy=bladeytable) {
      hull() {
	for (z=[-bladeztolerance,bladeztolerance]) {
	  for (y=[-bladeytolerance,bladeytolerance]) {
	    for (x=[-bladextolerance,bladextolerance]) {
	      translate([bladex,yy+angleyadjust,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) translate([x,y,z]) blade(part);
	    }
	  }
	}
      }
    }
  }
  
  if (part==0 || part==2) {
    for (yy=bladeytable) {
      hull() {
	for (z=[-bladeztolerance,bladeztolerance]) {
	  for (y=[-bladeytolerance,bladeytolerance]) {
	    for (x=[-bladextolerance,bladextolerance]) {
	      translate([bladex,yy+angleyadjust,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) translate([x,y,z]) blade(part);
	    }
	  }
	}
      }
    }
  }
}

module pullopening() {
  if (belth<beltwidew) {
    hull() {
    translate([beltcutterl,0,belth/2]) rotate([0,90,0]) cylinder(d=beltwidew,h=1,$fn=180);
    translate([cutx,0,belth/2]) rotate([0,90,0]) cylinder(d=belth,h=1,$fn=180);
    }
  } else {
    translate([beltcutterl,0,belth/2]) rotate([90,0,0]) cylinder(d=belth-2,h=beltcutterw+0.1,center=true,$fn=90);
  }
}

module blades() {
  for (yy=bladeytable) {
    translate([bladex,yy+angleyadjust,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) blade();
  }
}

module beltcutterbottom() {
  difference() {
    union() {
      x=bottomleftextendx;
      l=bottomleftextendl;
      
      translate([0,-beltcutterw/2+beltcuttersidew+xtolerance,-beltcutterbottomh-beltztolerance]) roundedbox(beltcutterl,beltcutterleftw-beltcuttersidew-xtolerance,beltcutterbottomh,cornerd,1);
      translate([0,-beltcutterw/2,-beltcutterbottomh-beltztolerance]) roundedbox(x-l/2-xtolerance,beltcutterleftw,beltcutterbottomh,cornerd,1);
      translate([x+l/2+xtolerance,-beltcutterw/2,-beltcutterbottomh-beltztolerance]) roundedbox(beltcutterl-x-l/2-xtolerance,beltcutterleftw,beltcutterbottomh,cornerd,1);
    }

    for (y=[0,bladeytolerance*2]) translate([0,y,0]) bladespace(ytolerance=bladeytolerance,part=2);

    pullopening();
    
    screwholes();
    if (thinning) {
      translate([1+cornerd/2,-beltcutterw/2+beltcutterleftw-textdepth+0.01,-beltcutterbottomh+textsize/2+1+cornerd/2]) rotate([-90,180,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="center",halign="right");
    } else {
      translate([cornerd/2+1,-beltcutterw/2+beltcutterleftw-cornerd/2-1,-beltcutterbottomh-beltztolerance+textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="bottom",halign="left");
      translate([beltcutterl-cornerd/2-1,-beltcutterw/2+beltcutterleftw-cornerd/2-1,-beltcutterbottomh-beltztolerance+textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="bottom",halign="right");
    }

    translate([beltcutterl-textlen("OUT",inouttextsize)-cornerd/2-1,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh/2]) rotate([90,0,0]) linear_extrude(textdepth) text("OUT",size=inouttextsize,font=textfont,valign="center",halign="left");
    translate([cornerd+1,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh/2]) rotate([90,0,0]) linear_extrude(textdepth) text("IN",size=inouttextsize,font=textfont,valign="center",halign="left");

  }
}

module beltcutterleft() {
  difference() {
    union() {
      translate([0,-beltcutterw/2,-beltztolerance/2]) roundedbox(beltcutterl,beltcuttersidew,beltcutterh-beltcutterbottomh-beltztolerance/2,cornerd,4);
      translate([bottomleftextendx-bottomleftextendl/2,-beltcutterw/2,-beltcutterbottomh-beltztolerance/2]) roundedbox(bottomleftextendl,beltcuttersidew,beltcutterbottomh+beltztolerance+cornerd,cornerd,4);
      translate([0,-beltcutterw/2,belth+beltztolerance]) roundedbox(beltcutterl,beltcuttersidew+beltcuttertrimleft+beltytolerance/2,beltcuttertoph,cornerd,4);

      intersection() {
	translate([0,-beltcutterw/2,belth+beltztolerance+cornerd/2]) cube([beltcutterl,beltcutterw,beltcuttertoph]);
	for (yy=bladeytable) {
	  for (part=[1,2]) {
	    hull() for (y=[-bladew-angleyadjust-bladeytolerance,-bladew+bladeytolerance]) {
	      translate([bladex,yy+angleyadjust,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) translate([0,y,0]) blade(part);
	    }
	  }
	}
      }

      if (thinning) translate([cornerd+upclipd/2,-beltcutterw/2+beltcuttersidew+beltcuttertrimleft+longclipdepth-longclipd/2,belth+beltcuttertoph/2]) rotate([0,90,0]) tubeclip(upclipl,upclipd,0);
    }

    hull() for (y=[0,angleyadjust]) translate([0,y,0]) bladespace(part=1);
    hull() for (y=[0,angleyadjust]) translate([0,y,0]) bladespace(part=2);

    pullopening();

    beltcutexpand();

    screwholes();

    if (thinning) {
      translate([1+cornerd/2+upclipd+1,-beltcutterw/2+beltcuttersidew+beltcuttertrimleft+beltytolerance/2-textdepth+0.01,belth+beltcuttertoph/2]) rotate([-90,-90,0]) linear_extrude(textdepth) text(str(versiontext),size=versiontextsize,font=textfont,valign="bottom",halign="center");
      translate([1+cornerd/2,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh-cornerd/2-1]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="top",halign="left");
    } else {
      translate([beltcutterl-cornerd/2-1,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh/2+versiontextsize/2]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="center",halign="right");
    }
    translate([cornerd/2+1,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh/2+textsize/2]) rotate([90,0,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="left");
    translate([cornerd/2+1,-beltcutterw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh/2-textsize/2-1]) rotate([90,0,0]) linear_extrude(textdepth) text(measurementtext,size=textsize-2,font=textfont,valign="center",halign="left");

    translate([beltcutterl/2,-beltcutterw/2+cornerd,-beltcutterbottomh-beltztolerance+beltcutterh-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) text("Belttool ",size=textsize-1,font=textfont,valign="bottom",halign="center");
  }
    
  bladepin(bladeytable[0]);
}

module beltcutexpand() {
  w=bladew*4+sin(bladeverticalangle)*bladebodyh+1.5;
  wextend=1.5;
  w3=bladew+bladecutextend*sin(bladeverticalangle)+beltytolerance+bladeytolerance;
  for (m=thinning?[1]:[0,1]) mirror([0,m,0]) {
      hull() {
	translate([cutx+bladecutextend+bladebodyh,-beltwidew/2-w/2-wextend,-beltztolerance]) cube([beltcutterl/2,w+wextend,belth+beltztolerance*2]);
	translate([cutx+bladecutextend,-beltwidew/2-w3/2,-beltztolerance]) cube([beltcutterl/2,w3,belth+beltztolerance*2]);
      }
      hull() {
	translate([cutx+bladecutextend,-beltwidew/2-w3/2,-beltztolerance]) cube([beltcutterl/2,w3,belth+beltztolerance*2]);
	translate([cutx+xtolerance,-beltwidew/2-beltytolerance,-beltztolerance]) cube([beltcutterl/2,beltytolerance*2,belth+beltztolerance*2]);
      }
  }
}

module beltcuttermid() {
  difference() {
    union() {
      translate([0,-beltcuttermidw/2,belth+beltztolerance]) roundedbox(beltcutterl,beltcuttermidw,beltcuttertoph,cornerd,4);
    }

    bladespace(part=1);
    bladespace(part=2);

    pullopening();
    
    bladepinspace(bladeytable[0]);

    screwholes();

    translate([cornerd/2+1,beltcuttermidw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2-0.01]) rotate([-90,180,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="right");
    translate([cornerd/2+1,-beltcuttermidw/2+textdepth-0.01,-beltcutterbottomh+beltcutterh/2-0.01]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="center",halign="left");
  }

  bladepin(bladeytable[1]);
}

module beltcutterright() {
  difference() {
    union() {
      translate([0,beltwidew/2+beltytolerance,-beltcutterbottomh-beltztolerance]) roundedbox(beltcutterl,beltcuttersidew,beltcutterh,cornerd,5);
      translate([0,beltwidew/2-beltcuttertrimright+beltytolerance/2,belth+beltztolerance]) roundedbox(beltcutterl,beltytolerance/2+beltcuttersidew+beltcuttertrimright,beltcuttertoph,cornerd,5);

      intersection() {
	translate([0,-beltcutterw/2,belth+beltztolerance+cornerd/2]) cube([beltcutterl,beltcutterw,beltcuttertoph]);
	union() {
	  for (yy=bladeytable) {
	    for (part=[1,2]) {
	      hull() {
		for (y=[bladeytolerance-bladew,bladew+0.01]) {
		  translate([bladex,bladew+yy+angleyadjust,bladeheight]) rotate([bladesideangle,bladeangle,bladeverticalangle]) translate([0,y,0]) blade(part);
		}
	      }
	    }
	  }
	}
      }
    }

    if (thinning)       translate([cornerd+upclipd/2,-beltcutterw/2+beltcuttersidew+beltcuttertrimleft+longclipdepth-longclipd/2,belth+beltcuttertoph/2]) rotate([0,90,0]) tubeclip(upclipl,upclipd,dtolerance);
    
    hull() for (y=[0,-angleyadjust]) translate([0,y,0]) bladespace(part=1);
    hull() for (y=[0,-angleyadjust]) translate([0,y,0]) bladespace(part=2);

    pullopening();
    
    bladepinspace(bladeytable[cuts==2?1:0]);

    beltcutexpand();

    screwholes();

    translate([beltcutterl-textlen("OUT",inouttextsize)-cornerd,beltcutterw/2-textdepth+0.01,-beltcutterbottomh/2]) rotate([-90,180,0]) linear_extrude(textdepth) text("OUT",size=inouttextsize,font=textfont,valign="center",halign="right");
    translate([textlen("IN",inouttextsize)+cornerd+1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh/2]) rotate([-90,180,0]) linear_extrude(textdepth) text("IN",size=inouttextsize,font=textfont,valign="center",halign="left");

    if (thinning) {
      translate([cornerd/2+1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2+textsize/2]) rotate([-90,180,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="right");
      translate([cornerd/2+1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh-cornerd-1]) rotate([-90,180,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="top",halign="right");
      translate([cornerd/2+1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2-textsize/2-1]) rotate([-90,180,0]) linear_extrude(textdepth) text(measurementtext,size=textsize-2,font=textfont,valign="center",halign="right");
    } else {
      translate([beltcutterl-cornerd/2-1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2+textsize/2]) rotate([-90,180,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="left");
      translate([cornerd/2+1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2+versiontextsize/2]) rotate([-90,180,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,font=textfont,valign="center",halign="right");
    translate([beltcutterl-cornerd/2-1,beltcutterw/2-textdepth+0.01,-beltcutterbottomh+beltcutterh/2-textsize/2-1]) rotate([-90,180,0]) linear_extrude(textdepth) text(measurementtext,size=textsize-2,font=textfont,valign="center",halign="left");
    }
  }
}

module beltthinner() {
}

if (print==0) {
  intersection() {
    //if (debug) translate([0,-beltcutterw/2,-beltztolerance-beltcutterbottomh]) cube([beltcutterl/2+5,beltcutterw,beltcutterh]);
    if (debug) translate([0,-beltcutterw/2,-beltztolerance-beltcutterbottomh]) cube([beltcutterl,beltcutterw,belth]);
    union() {
      difference() {
	union() {
	  beltcutterleft();
	  if (cuts==2) {
	    beltcuttermid();
	  }
	  beltcutterbottom();
	  #	  beltcutterright();
	  #    blades();
	}
	  
	#translate([-100,-beltwidew/2,0]) roundedbox(beltcutterl*3,thinning?originalbeltthickness:originalbeltwidth,belth,cornerd,0);
	if (cuts==2) {
	  %translate([-100,-bladeytable[1]-bladew+bladeytolerance/2,0]) roundedbox(beltcutterl*3,thinning?desiredbeltthickness:desiredbeltwidth,belth,cornerd,0);
	} else {
	  %translate([-100,-beltwidew/2,0]) roundedbox(beltcutterl*3,thinning?desiredbeltthickness:desiredbeltwidth,belth,cornerd,0);
	}
      }
    }
  }
 }

if (print==1 || print==4) {
  translate([beltcutterl,beltcutterbottomh-beltcutterh-beltztolerance-0.5,beltcutterw/2]) rotate([90,0,180]) {
    beltcutterleft();
  }
 }

if (print==2 || print==4) if (thinning==0) {
    if (cuts==2) translate([0,beltcutterh+beltwidew+beltcutterh-belth+beltztolerance+0.5,beltcuttermidw/2]) rotate([90,0,0]) beltcuttermid();
  }

if (print==3 || print==4) {
  translate([beltcutterl,beltcutterh-beltcutterbottomh-beltztolerance,beltcutterw/2]) rotate([-90,0,180]) beltcutterright();
 }

if (print==5) {
  translate([-0.5,0,bladew/2]) rotate([90,0,180]) blade();
 }

if (print==6 || print==4) {
  translate([0,beltcutterh+beltcutterbottomh+beltztolerance+0.5-beltcutterw/2-beltcuttersidew+beltcutterleftw,beltcutterbottomh+beltztolerance]) beltcutterbottom();
 }

