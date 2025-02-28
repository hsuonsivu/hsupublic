// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

debug=0;
cornerd=1;
badweldworkaround=0;

versiontext="V1.1";
textdepth=0.8;
textsize=7;

wall=2;

module polecover(xsize,ysize,footh,inserth,polewall,tubecornerd,height,stepdepth) {
  insidecornerd=tubecornerd-polewall;
  insidex=xsize-polewall*2;
  insidey=ysize-polewall*2;
  stepreduction=0.005*min(xsize,ysize);
  notchdepth=polewall;
  notchh=1.5;

  difference() {
    union() {
      intersection() {
	roundedbox(50,50,footh*2,tubecornerd,1);
	cube([50,50,footh]);
      }

      steps=floor(inserth/stepdepth/2);

      translate([polewall+stepdepth,polewall+stepdepth,footh-insidecornerd/2]) roundedbox(insidex-stepdepth*2,insidey-stepdepth*2,inserth+insidecornerd/2,insidecornerd);
  
      for (i=[0:1:steps-1]) {
	z=footh+inserth-stepdepth*2*(i+1);
	depthreduction=(steps-i)*stepreduction;
	hull() {
	  translate([polewall+stepdepth,polewall+stepdepth,z-0.01]) roundedboxxyz(insidex-stepdepth*2,insidey-stepdepth*2,stepdepth*2+0.01,insidecornerd,1,0,30);
	  translate([polewall+depthreduction,polewall+depthreduction,z+stepdepth-0.01]) roundedboxxyz(insidex-depthreduction*2,insidey-depthreduction*2,0.2,insidecornerd,0.1,0,30);
	}
      }
    }

    translate([polewall+stepdepth+wall,polewall+stepdepth+wall,wall]) roundedbox(insidex-stepdepth*2-wall*2,insidey-stepdepth*2-wall*2,footh+inserth-wall+insidecornerd+0.1,insidecornerd-wall*2);

    for (x=[0,xsize]) {
      translate([x-notchdepth,ysize/2-notchdepth*2,footh-notchh]) cube([notchdepth*2,notchdepth*4,notchh+0.01]);
    }
    for (y=[0,ysize]) {
      translate([xsize/2-notchdepth*2,y-notchdepth,footh-notchh]) cube([notchdepth*4,notchdepth*2,notchh+0.01]);
    }

    translate([xsize/2,ysize/2+textsize,wall-textdepth+0.02]) linear_extrude(height = textdepth) text(text = str(versiontext), font="Liberation Sans:style=Bold", size = textsize, valign="center", halign="center");
    if (xsize==ysize) {
      translate([xsize/2,ysize/2,wall-textdepth+0.02]) linear_extrude(height = textdepth) text(text = str("size ",xsize), font="Liberation Sans:style=Bold", size = textsize-2, valign="center", halign="center");
    } else {
      translate([xsize/2,ysize/2,wall-textdepth+0.02]) linear_extrude(height = textdepth) text(text = str(xsize," x ",ysize), font="Liberation Sans:style=Bold", size = textsize-2, valign="center", halign="center");
    }
    translate([xsize/2,ysize/2-textsize,wall-textdepth+0.02]) linear_extrude(height = textdepth) text(text = str("wall ",polewall), font="Liberation Sans:style=Bold", size = textsize-2, valign="center", halign="center");

    rangle=5;
    rlf=1.1;
    if (badweldworkaround) {
      translate([0,-sin(rangle)*footh,footh]) rotate([-90,0,rangle]) cylinder(d=footh*2,h=xsize*rlf,$fn=30);
      translate([-sin(rangle)*footh,0,footh]) rotate([0,90,-rangle]) cylinder(d=footh*2,h=xsize*rlf,$fn=30);
    }
  }
}

intersection() {
  polecover(50,50,6,20,4,15,25,2);
  if (debug) cube([50/2,50/2,30]);
}
