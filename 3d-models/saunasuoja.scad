// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Protect sauna thermostat from unauthorized tampering

include <hsu.scad>

debug=0;

$fn=60;

w=225;
h=119;
t=1.4;

textdepth=0.8;
teksti="Sauna tamperprotect V1.1";
textsize=8;
textheight=h-textsize-4;
textfromleft=textsize;

wall=2;

screwd=4.5;
screwfromwall=7;
screwheight=53;

thermostatknobd=35;
thermostatknobh=21;
thermostatknobheight=screwheight;
thermostatknobfromrightwall=102;

selectionbuttonw=38;
selectionbuttonh=24;
selectionbuttonfromrightwall=61.5;
selectionbuttonfromtop=9.5+selectionbuttonh;

timerknobd=62.53;
timerknobfromrightwall=43.4-0.5-1;
timerknobheight=thermostatknobheight+1-0.25;

cornerd=1;

logow=38.5;
logoh=64-29;//33;
logofromtop=63.5;
logofromleft=12;

brandw=51;
brandh=9;
brandheight=12.5;//13-brandh;
brandfromleft=8;

originw=50;
originh=6.5;
originheight=3.5;
originfromright=22;

module saunasuoja() {
  difference() {
    union() {
      roundedbox(w,h,t,cornerd);
      intersection() {
	minkowski() {
    	  sphere(d=cornerd);
	  translate([w-thermostatknobfromrightwall,thermostatknobheight,0]) cylinder(d=thermostatknobd+wall*2-cornerd,h=thermostatknobh+wall-cornerd/2);
	}
	translate([w-thermostatknobfromrightwall,thermostatknobheight,0]) cylinder(d=thermostatknobd+wall*2,h=thermostatknobh+wall);
      }
    }

    translate([w-thermostatknobfromrightwall,thermostatknobheight,-0.01]) cylinder(d=thermostatknobd,h=thermostatknobh+0.02);
    translate([w-timerknobfromrightwall,timerknobheight,-0.1]) cylinder(d=timerknobd,h=t+0.2);
    translate([w-selectionbuttonfromrightwall,h-selectionbuttonfromtop,-cornerd/2-0.01]) roundedbox(selectionbuttonw,selectionbuttonh,t+cornerd+0.02,cornerd);
    translate([logofromleft,h-logofromtop,-cornerd/2-0.01]) roundedbox(logow,logoh,t+cornerd+0.02,cornerd);
    translate([brandfromleft,brandheight,-cornerd/2-0.01]) roundedbox(brandw,brandh,t+cornerd+0.02,cornerd);
    translate([w-originfromright-originw,originheight,-cornerd/2-0.01]) roundedbox(originw,originh,t+cornerd+0.02,cornerd);
    for (x=[screwfromwall,w-screwfromwall]) {
      translate([x,screwheight,-0.1]) cylinder(d=screwd,h=t+0.2);
    }

    translate([textfromleft,textheight,t-textdepth+0.01]) linear_extrude(height=textdepth) text(text=teksti,size=textsize,"halign=left","valign=bottom");
  }
  difference() {
    translate([w-timerknobfromrightwall,timerknobheight,0]) cylinder(d=timerknobd+wall,h=t);
    translate([w-timerknobfromrightwall,timerknobheight,-0.1]) cylinder(d=timerknobd,h=t+0.2);
  }
}

intersection() {
  saunasuoja();
  if (debug) {
    translate([0,thermostatknobheight,0]) cube([w,h,t+thermostatknobheight+wall+cornerd]);
  }
}
