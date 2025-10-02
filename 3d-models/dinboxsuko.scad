// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debugon=0;
debug=(print==0)?debugon:0;

textdepth=0.7;
textsize=7;
versiontext="v1.1";
label="Schuko box";
textfont="Liberation Sans:style=Bold";

// 52*sin(a)=0.4
// sin(a)=0.4/52;
// a=arcsin(0.4/52);

boxld=1; //0.4;
halfw=96/2; //52
b=asin(boxld/halfw);
echo(b);
l=halfw/sin(b);
echo(l);

d=l+boxld;

wall=2;
maxbridge=8;
cornerd=3;
outcornerd=cornerd*2;

screwd=4.5;
screwl=23;
screwbased=10;
screwfromcorner=screwbased/2+cornerd/2;

sukow=75;
sukol=120;
sukoh=55;
sukobasew=75+screwbased*2+cornerd;//62*2;//92;
echo(sukobasew);
sukobasel=15;
sukobaseh=sukoh;

cableholeheight=15.7;
cableholed=19.7;

sukoholecornerd=cornerd;

sukoholel=53.3;
sukoholew=57.1;
sukoholeel=59.5;
sukoholeew=10+cornerd;
sukoboxl=84;

//sukoholex=sukol-15.2-cornerd/2-sukoholel;
sukoholex=sukol-72.5-cornerd/2;//
sukoholeex=sukol-75-cornerd/2; //

sukoholecx=sukoholex+sukoholel/2;

sukoholenw=50;
sukoholenl=50;

sukoholell=32;
sukoholeww=35;

sukoscreww=59.5;
sukoscrewl=59.5;
sukoscrewd=3;
sukoscrewx=sukoholex+sukoscrewd/2;

module sukohole(h) {
  hull() {
    translate([sukoholecx-sukoholell/2,-sukoholew/2,0]) roundedbox(sukoholell,sukoholew,h,sukoholecornerd);
    translate([sukoholecx-sukoholel/2,-sukoholeww/2,0]) roundedbox(sukoholel,sukoholeww,h,sukoholecornerd);
    translate([sukoholecx-sukoholenl/2,-sukoholenw/2,0]) roundedbox(sukoholenl,sukoholenw,h,sukoholecornerd);
  }
}

module sukobox() {
  difference() {
    union() {
      translate([0,-sukow/2,0]) roundedbox(sukol,sukow,sukoh,outcornerd,1);
      translate([0,-sukobasew/2,0]) roundedbox(sukobasel,sukobasew,sukobaseh,outcornerd,1);
    }
    translate([-d/2+boxld,0,-0.1]) cylinder(d=d,h=sukoh+0.2,$fn=360);
    hull() {
      translate([0,0,cableholeheight]) rotate([0,90,0]) cylinder(d=cableholed,h=wall*2);
      translate([0,-maxbridge/2,cableholeheight]) cube([wall*2,maxbridge,cableholed/2]);
    }

    //translate([boxld+wall,-sukow/2+wall,wall]) roundedbox(sukol-boxld-wall*2,sukow-wall*2,sukoh-wall*2);
    hull() {
      h=(sukow-maxbridge)/2+wall;
      translate([boxld+wall,-sukow/2+wall,wall]) roundedbox(sukol-boxld-wall*2,sukow-wall*2,sukoh-h,cornerd);
      translate([boxld+wall,-maxbridge/2,wall]) cube([sukol-boxld-wall*2,maxbridge,sukoh-wall*2]);
    }
    hull() {
      translate([boxld+wall,-sukow/2+wall,wall]) roundedbox(sukol-boxld-wall*2,sukow-wall*2,sukoh-wall*2-sukoholex,cornerd);
      wideh=(sukow-sukoholenw)/2+wall;
      translate([sukoholex-wideh/2,-sukow/2+wall,wall]) roundedbox(sukoholel+wideh,sukow-wall*2,sukoh-wideh,cornerd);
      toph=sukol-wall-(sukoholex+sukoholel)+wall;
      translate([sukoholex,-sukow/2+wall,wall]) roundedbox(sukoholel+toph-wall,sukow-wall*2,sukoh-toph,cornerd);
      translate([0,0,sukoh-wall-cornerd]) sukohole(cornerd);
    }
    translate([0,0,sukoh-wall-cornerd]) sukohole(cornerd/2+wall+cornerd);
    translate([sukoholeex,-sukoholeew/2,sukoh-wall-sukoholecornerd]) roundedbox(sukoholeel,sukoholeew,wall+sukoholecornerd*2,cornerd);


    // Screw holes for main box screws
    for (y=[-sukobasew/2+screwfromcorner,sukobasew/2-screwfromcorner]) {
      for (z=[screwfromcorner,sukoh-screwfromcorner]) {
	if (print==2) {
	  translate([0,y,z]) rotate([0,90,0]) cylinder(d1=2,d2=screwl*2,h=screwl,$fn=60);
	} else {
	  translate([sukobasel-screwl+0.01,y,z]) rotate([0,90,0]) render() ruuvireika(screwl,screwd,0,print==1?1:0,sukobasel-0.8);

	  hull() {
	    translate([sukobasel-screwl+0.01,y,z]) rotate([0,90,0]) cylinder(d=screwd,h=screwl,$fn=60);
	    translate([-0.01,y-screwd/4,z]) cube([sukobasel+0.02,screwd/2,screwd/2]);
	  }
	}
      }
    }

    // Screw holes for suko connector
    for (y=[-sukoscreww/2,sukoscreww/2]) {
      for (x=[sukoscrewx,sukoscrewx+sukoscrewl]) {
	translate([x,y,wall]) cylinder(d=sukoscrewd,h=sukoh-wall+0.1,$fn=60);
      }
    }

    translate([boxld+outcornerd/2+1+textsize/2,0,sukoh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-1,halign="center", valign="center");
    translate([boxld+outcornerd/2+1+textsize+1+textsize/2,0,sukoh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(label,font="Liberation Sans:style=Bold,Narrow",size=textsize,halign="center", valign="center");
  }
}

if (print==0) {
  intersection() {
    //if (debug) translate([0,0,0]) cube([200,100,100]); // Split at xz plane
    if (debug) translate([0,-100,0]) cube([200,100+sukobasew/2-screwfromcorner,100]); // Split at screw hole
    //if (debug) translate([0,0,0]) cube([100,100,100]);
    sukobox();
  }
 }

if (print==1) {
  sukobox();
 }

if (print==2) {
  intersection() {
    translate([0,-100,0]) cube([5,200,100]); // Split at screw hole
    sukobox();
  }
 }


     
