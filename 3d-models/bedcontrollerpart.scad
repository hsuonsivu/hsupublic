// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

versiontext="V1.0";
font="Liberation Sans:style=Bold";
textdepth=0.5;
textheight=10;

width=24.45;
thickness=3.18;
length=65;
notchwidth=2.17-0.8;
notchlength=1.67;
slotwidth=1.9;
slotposition=2.67;
slotlength=9.6;
slotendholex=((slotposition+slotwidth) + 2.11) / 2;
slotenddiameter=2.83;
hangthickness=43;
hangwidth=width;
hanglength=8;
hangback=13;
hangposition=length-0;
hangsupportposition=length-hanglength;
hangsupportthickness=8;
cornerdiameter=1;//thickness;

$fn=36;

module triangle(x,y,z,mode) {
  if (mode==0) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x,z],[x,0]]);
  } else if (mode==1) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z]]);
  } else if (mode==2) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,0]]);
  } else if (mode==3) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x,0]]);
  } else if (mode==4) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y,x],[y,0]]);
  } else if (mode==5) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x]]);
  } else if (mode==6) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,0]]);
  } else if (mode==7) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y,0]]);
  } else if (mode==8) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z,y],[z,0]]);
  } else if (mode==9) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y]]);
  } else if (mode==10) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,0]]);
  } else if (mode==11) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z,0]]);
  }
}

module roundedbox(x,y,z) {
  smallcornerdiameter=1;
  f=30;
  hull() {
    translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
  }
}

union() {
  difference() {
    union() {
      roundedbox(length,width,thickness);
      //translate([hangsupportposition,0,0]) roundedbox(hanglength,hangwidth,hangsupportthickness);
      //translate([hangposition,0,0]) rotate([0,-15,0]) roundedbox(hanglength,hangwidth,hangthickness);
     hull() {
	for (y=[0,width-cornerdiameter]) {
	  translate([hangsupportposition,y+cornerdiameter/2,cornerdiameter/2]) sphere(d=cornerdiameter);
	  translate([hangsupportposition+hanglength,y+cornerdiameter/2,cornerdiameter/2]) sphere(d=cornerdiameter);
	  translate([hangsupportposition+hanglength/2,y+cornerdiameter/2,hangsupportthickness]) sphere(d=cornerdiameter);
	  translate([hangsupportposition+hanglength,y+cornerdiameter/2,cornerdiameter/2]) sphere(d=cornerdiameter);
	}
      }
      hull() {
	for (y=[0,width-cornerdiameter]) {
	  translate([hangsupportposition+hanglength/2,y+cornerdiameter/2,cornerdiameter/2]) sphere(d=cornerdiameter);
	  translate([hangsupportposition+hanglength+1,y+cornerdiameter/2,cornerdiameter/2]) sphere(d=cornerdiameter);
	  translate([hangsupportposition+hanglength/2-hangback,y+cornerdiameter/2,hangthickness]) sphere(d=cornerdiameter);
	  translate([hangsupportposition+hanglength-hangback,y+cornerdiameter/2,hangthickness]) sphere(d=cornerdiameter);
	}
      }
    }
    translate([-0.01,slotposition,-0.01]) cube([slotlength,slotwidth,thickness+0.02]);
    translate([-0.01,width-slotposition-slotwidth,-0.01]) cube([slotlength,slotwidth,thickness+0.02]);
    translate([slotlength,slotendholex,-0.01]) cylinder(h=thickness+0.01,d=slotenddiameter);
    translate([slotlength,width-slotendholex,-0.01]) cylinder(h=thickness+0.01,d=slotenddiameter);
  }
  translate([0,-notchwidth,0]) roundedbox(notchlength,notchwidth+1,thickness);
  translate([0,width-1,0]) roundedbox(notchlength,notchwidth+1,thickness);
}
