// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <threadlib/threadlib.scad>

print=0;
debug=1;

versiontext="1.1";

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

bottomd=140;
bottomh=7;

bottomtopd=120;
bottomtoph=15;

holderd=29;
holderh=bottomtoph+225; 

handled=50;
handleh=20;
handlel=60; // This will be plus handlew
handlew=30; 
handlecornerd=15;
axisd=holderd;
axish=20;
topd=50;
toph=(topd-axisd);//25;
handleraise=toph+axish;

cornerd=2;

m20div=1.3;
m20drext=1.5830/m20div;
m20drint=1.5330/m20div+0.1;
MY_THREAD_TABLE=[
		 ["M20-ext", [2.5, 8.3120+(1.1583-m20drext)+0.1, 16.9380+(1.5830-m20drext)*2, [[0, -1.0929], [0, 1.0929], [m20drext+0.1, 0.1790], [m20drext+0.1, -0.1790]]]],
		 ["M20-int", [2.5, -10.2925, 20.2925, [[0, 1.2304], [0, -1.2304], [m20drint, -0.3453], [m20drint, 0.3453]]]]
		 ];

topboltholespecs=thread_specs("M20-int",table=MY_THREAD_TABLE);
topboltholepitch=topboltholespecs[0];
topboltholed=topboltholespecs[2];
topboltholeturns=6;
topboltturns=5;
topboltholel=(topboltturns+1)*topboltholespecs[0];
topboltspecs=thread_specs("M20-ext",table=MY_THREAD_TABLE);
topboltpitch=topboltspecs[0];
topboltd=topboltspecs[2];
topboltl=(topboltturns+1)*topboltpitch;
topboltbasel=7;

topboltheight=holderh-topboltl+topboltpitch;

brandtext="Paper roll holder";
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

module base() {
  difference() {
    union() {
      hull() {
	roundedcylinder(bottomd,bottomh,cornerd,1,180);
	roundedcylinder(bottomtopd,bottomtoph,cornerd,1,180);
      }
      roundedcylinder(holderd,holderh,cornerd,1,180);
    }

    translate([0,0,holderh-topboltholepitch/2]) cylinder(d=topboltholed,h=topboltholepitch*2,$fn=180);
    translate([0,0,holderh-topboltholel-topboltholepitch*2]) cylinder(d=topboltholed,h=topboltholepitch/2+0.01,$fn=180);
    translate([0,0,holderh-topboltholel-topboltholepitch*2-cornerd/2]) roundedcylinder(topboltholed,topboltholepitch/2+cornerd/2+0.01,cornerd,0,180);
    translate([0,0,holderh-topboltholel-topboltholepitch]) tap("M20", turns=topboltholeturns,table=MY_THREAD_TABLE);

    translate([0,0,textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text(str(brandtext," ",versiontext),size=textsize,font=textfont,valign="center",halign="center");
  }
}

module top() {
  difference() {
    union() {
      translate([0,0,topboltheight]) bolt("M20",turns=topboltturns,table=MY_THREAD_TABLE);
      hull() {
	translate([0,0,topboltheight-topboltpitch+ztolerance]) roundedcylinder(topboltd,topboltpitch+1,cornerd,0,180);
	translate([0,0,topboltheight-topboltpitch-topboltpitch*1.5+ztolerance]) roundedcylinder(topboltd-topboltpitch,topboltpitch+1,cornerd,0,180);
      }
      translate([0,0,holderh+ztolerance+handleraise]) {
	hull() {
	  for (y=[-handlel/2,handlel/2]) translate([0,y,0]) roundedcylinder(handlew,handleh,handlecornerd,2,180);
	}
      }
      translate([0,0,holderh+ztolerance]) {
	hull() {
	  roundedcylinder(topd,cornerd,cornerd,0,180);
	  translate([0,0,toph-cornerd]) scale([1,0.8,1]) roundedcylinder(axisd,cornerd,cornerd,0,180);
	}
	translate([0,0,toph-cornerd]) scale([1,0.8,1]) roundedcylinder(axisd,axish+cornerd+handlecornerd/2,cornerd,0,180);
      }
    }

    translate([0,-holderd/2,holderh+ztolerance+textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="bottom",halign="center");
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([0,-100,0]) cube([200,200,1000]);
    union() {
      base();
      top();
    }
  }
 }

if (print==1 || print==3) {
  base();
 }

if (print==2 || print==3) {
  translate([bottomd/2+0.5+handlew/2,0,holderh+ztolerance+toph+axish+handleh]) rotate([180,0,0]) top();
 }

