// Copyright 2022-2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
include <text_on_OpenSCAD/text_on.scad>

print=0; // 0 test and debug, 1 print - version, 2 print + version, 3 print both
debug=1;
count=7; // How many to print: Note max count is 8+12=20

if (count>20) {
  echo("ERROR: count max is 20");
 }
  
textdepth=0.7;
textsize=7;
versiontext="v1.0";
textfont="Liberation Sans:style=Bold";

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;
cornerd=2;

wall=1.6;
topwall=2.5; // Needs to accommodate version text depth

terminald=22.36;
terminalnarrowd=21.15-dtolerance;
terminalnarrowh=2.14;
terminalnarrowheight=3.26;
terminalclipdepth=(terminald-terminalnarrowd)/2;

terminalminh=7.5;
terminalmaxh=11.3;

covertop=10;

coverd=terminald+dtolerance+wall*2+terminalclipdepth*2+dtolerance+wall*2+0.6; // 0.6 is to workaround a bug in eufymake slicer

signsize=coverd-cornerd-5;
signw=4;

coverbottomd=terminald+dtolerance+1.6*2;

coveroutgapd=terminald+dtolerance+wall*2+terminalclipdepth*2+dtolerance;
covercliph=ztolerance+terminalnarrowheight+terminalnarrowh;
coverclipspringa=6;
coverclipspringcut=5;
coverclipspringh=covercliph-ztolerance;
coverhandled=6.5;

boltd=8;
boltheadh=5.2;
boltheadd=12.65;

boltclipspringa=6;
boltclipdepth=0.9;
boltclipgapd=boltheadd+dtolerance+wall*2+dtolerance+boltclipdepth*2+dtolerance;
boltclipspringcut=1;

boltcliph=2;
boltcliptotalh=ztolerance+boltheadh+ztolerance+boltcliph+ztolerance;

terminalheight=topwall+ztolerance+boltheadh+ztolerance+boltcliph;
boltclipspringh=ztolerance+boltheadh+ztolerance+boltcliph+ztolerance;
coverminh=topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalminh-ztolerance;

module bolt() {
  cylinder(d=boltd,h=30,$fn=90);
  cylinder(d=boltheadd/cos(180/6),h=boltheadh,$fn=6);
}

module screwterminalcover(sign) {
  difference() {
    union() {
      difference() {
	union() {
	  roundedcylinder(coverd,coverminh,cornerd,1,90);
	  roundedcylinder(coverbottomd,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalmaxh-ztolerance,cornerd,0,90);
	  hull() {
	    cylinder(d=coverbottomd,h=topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalminh-ztolerance+dtolerance,$fn=90);
	    cylinder(d=coverbottomd+dtolerance*2,h=topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalminh-ztolerance,$fn=90);
	  }

	  hull() {
	    
	    for (a=[0:360/6:359]) {
	      roundedcylinder(coverd,coverhandled,cornerd,1,90);
	      rotate([0,0,a]) translate([coverd/2,0,0]) {
		hull() {
		  translate([0,0,coverhandled/2]) sphere(d=coverhandled,$fn=90);
		  cylinder(d=coverhandled/2,h=coverhandled/2,$fn=90);
		}
	      }
	    }
	  }
	}

	// Cut for terminal
	union() {
	  translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance]) cylinder(d=terminald+dtolerance,h=terminalnarrowheight,$fn=90);

	  hull() {
	    translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight-0.1]) cylinder(d=terminald+dtolerance,h=0.1,$fn=90);
	    translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight-0.1]) cylinder(d=terminalnarrowd+dtolerance,h=0.1+(terminald-terminalnarrowd)/2,$fn=90);
	  }

	  translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight-0.1]) cylinder(d=terminalnarrowd+dtolerance,h=terminalnarrowh+0.2,$fn=90);
	  hull() {
	    translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight+terminalnarrowh]) cylinder(d=terminald+dtolerance,h=0.1,$fn=90);
	    translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight+terminalnarrowh-(terminald-terminalnarrowd)/2]) cylinder(d=terminalnarrowd+dtolerance,h=0.1+(terminald-terminalnarrowd)/2,$fn=90);
	  }
	  translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight+terminalnarrowh]) cylinder(d=terminald+dtolerance,h=terminalmaxh-terminalnarrowheight-terminalnarrowh,$fn=90);
	}

	// Cut for terminal clip
	for (a=[0:360/coverclipspringa:359]) {
	  rotate([0,0,a]) translate([-0.1,-coverclipspringcut/2,terminalheight+ztolerance]) {
	    cube([coveroutgapd/2-terminalclipdepth/2,coverclipspringcut,coverclipspringh+0.1]);
	  }
	}

	// Space for clip to extend to
	translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph+ztolerance+terminalnarrowheight+terminalnarrowh]) cylinder(d1=coveroutgapd,d2=terminald-0.01,h=(coveroutgapd-terminald)/2,$fn=90);
	translate([0,0,topwall+ztolerance+boltheadh+ztolerance+boltcliph]) ring(coveroutgapd,terminalclipdepth+dtolerance/2,covercliph+0.01,0,90);

	// Bolt hole
	union() {
	  hull() {
	    translate([0,0,topwall]) cylinder(d=boltheadd/cos(180/6)+dtolerance,h=ztolerance+boltheadh+ztolerance+ztolerance+0.01,$fn=6);
	    translate([0,0,topwall]) cylinder(d=boltheadd/cos(180/6)+dtolerance-boltclipdepth*2,h=ztolerance+boltheadh+ztolerance+ztolerance+boltclipdepth+0.01,$fn=6);
	  }
	  translate([0,0,topwall]) cylinder(d=boltheadd/cos(180/6)+dtolerance-boltclipdepth*2,h=ztolerance+boltheadh+ztolerance+ztolerance+boltcliph+0.01,$fn=6);
	  translate([0,0,topwall+boltcliptotalh-boltclipdepth]) cylinder(d1=boltheadd/cos(180/6)+dtolerance-boltclipdepth*2,d2=boltheadd/cos(180/6)+dtolerance,h=boltclipdepth+0.01,$fn=6);
	}
	
	// Cut for bolt clip
	translate([0,0,topwall]) ring(boltclipgapd/cos(180/6),boltclipdepth+dtolerance,boltcliptotalh+0.01,0,6);
	intersection() {
	  translate([0,0,topwall]) cylinder(d=boltclipgapd/cos(180/6),h=boltcliptotalh+0.01,$fn=6);
	  for (a=[0:360/boltclipspringa:359]) {
	    rotate([0,0,a]) translate([-0.1,-boltclipspringcut/2,topwall]) {
	      cube([boltclipgapd/cos(180/6)/2-boltclipdepth/2,boltclipspringcut,boltclipspringh+0.1]);
	    }
	  }
	}

	for (a=(sign?[0,90]:[0])) rotate([0,0,a]) translate([-signsize/2,-signw/2,-0.01]) cube([signsize,signw,textdepth+(a?0.2:0)+0.01]);
	
	translate([0,0,coverminh-textsize/2+1]) rotate([0,180,90]) text_on_cylinder(t=versiontext,r=coverd/2-textdepth/2+0.01,h=1,updown=2,size=textsize,font=textfont,extrusion_height=textdepth);
      }
    }

    //#translate([0,0,topwall+ztolerance]) bolt();
  }
}

if (print==0) {
  intersection() {
    if (debug) cube([100,100,100]);
    screwterminalcover(1);
  }
 }

if (print==1 || print==2) {
  translate([coverd+0.5,0,0]) screwterminalcover(print-1);
  for (i=[0:1:min(5,count-2)]) { //count-1
    d=coverd+coverhandled/2;
    translate([coverd+0.5+d*sin(0+60*i),d*cos(0+60*i),0]) screwterminalcover(print-1);
  }
  if (count>7) {
    for (i=[8:2:min(7+12,count)]) { //count-1
      d=(coverd+coverhandled/2)*2;
      translate([coverd+0.5+d*sin(0+30*(i-8)),d*cos(0+30*(i-8)),0]) screwterminalcover(print-1);
    }
    for (i=[9:2:min(7+12,count)]) { //count-1
      d=(coverd+coverhandled/2)*2*cos(30);
      translate([coverd+0.5+d*sin(30+30*(i-9)),d*cos(30+30*(i-9)),0]) screwterminalcover(print-1);
    }
  }
 }

if (print==3) {
  translate([coverd+0.5,0,0]) screwterminalcover(1);
  d=coverd+coverhandled/2;
  translate([coverd+0.5+d*sin(0+60),d*cos(0+60),0]) screwterminalcover(0);
 }
