// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <threadlib/threadlib.scad>

print=1;
debug=0;

versionstring="1.0";

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

module base() {
  difference() {
    union() {
      hull() {
	roundedcylinder(bottomd,bottomh,cornerd,1,180);
	roundedcylinder(bottomtopd,bottomtoph,cornerd,1,180);
      }
      roundedcylinder(holderd,holderh,cornerd,1,180);
    }

    translate([0,0,holderh-topboltholel]) tap("M20", turns=topboltholeturns,table=MY_THREAD_TABLE);
  }
}

module top() {
  translate([0,0,topboltheight]) bolt("M20",turns=topboltturns,table=MY_THREAD_TABLE);
  translate([0,0,holderh+ztolerance+handleraise]) {
    //cylinder(d=10,h=10,$fn=180);
    hull() {
      for (y=[-handlel/2,handlel/2]) translate([0,y,0]) roundedcylinder(handlew,handleh,handlecornerd,2,180);
      //roundedcylinder(holderd+handlecornerd,handleh,handlecornerd,2,180);
    }
  }
  translate([0,0,holderh+ztolerance]) {
    hull() {
      roundedcylinder(topd,cornerd,cornerd,0,180);
      translate([0,0,toph-cornerd]) scale([0.8,1,1]) roundedcylinder(axisd,cornerd,cornerd,0,180);
    }
    translate([0,0,toph-cornerd]) scale([0.8,1,1]) roundedcylinder(axisd,axish+cornerd+handlecornerd/2,cornerd,0,180);
  }
}

if (print==0) {
  intersection() {
    if (debug) cube([200,200,1000]);
    union() {
      base();
      top();
    }
  }
 }

if (print==1) {
  base();
  translate([bottomd/2+0.5+handlew/2,0,holderh+ztolerance+toph+axish+handleh]) rotate([180,0,0]) top();
 }

