// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// version 1, 90.5 long, 20.2 wide
// version 2, 95.5 long, 21.2 wide, 2mm higher mid part
barversion=2;
howmany=4;

wall=2.5;

versiontext=(barversion==1) ? "V1.7 S" : "V1.7 L";
	     
textfont="Liberation Sans:style=Bold";
textdepth=wall/4;
textheight=10;
  
length=(barversion == 1) ? 90.5 : 95.5;
width=(barversion == 1) ? 20.2 : 21.7;
height=21;
holediameter=6;
holestart=5+holediameter/2;
holeend=15-holediameter/2;

cablecut=5;
cablecutwidth=6;
cablecutgap=1;
cableposition=1;
snapwidth=wall/5;

platethickness=2.5;

lockcut=length/2;
locklength=15;
lockcutsize=1;
locknotchdiameter=wall+0.75;
locknotchheight=(barversion == 1) ? 13 : 11;

xspread=length+wall+wall+1;
yspread=width+wall+wall+1;

$fn=90;

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

module cablecutsnap(x) {
  translate([wall+x-cablecutgap,-1,wall+cableposition]) cube([cablecutgap,width+wall*2+2,height+1]);
  translate([wall+x+cablecutwidth,-1,wall+cableposition]) cube([cablecutgap,width+wall*2+2,height+1]);

  translate([wall+x-0.01,wall-snapwidth,wall+cableposition]) triangle(cablecutwidth+0.02,snapwidth+0.02,snapwidth,11);
  translate([wall+x-0.01,wall+width-0.01,wall+cableposition]) triangle(cablecutwidth+0.02,snapwidth+0.02,snapwidth,8);
  
  translate([wall+x-0.01,-0.01,wall+cableposition]) triangle(cablecutwidth+0.02,snapwidth+0.02,snapwidth,8);
  translate([wall+x-0.01,wall+width+wall-snapwidth+0.01,wall+cableposition]) triangle(cablecutwidth+0.02,snapwidth+0.02,snapwidth,11);
}

module batterycover() {
  difference() {
    union() {
      difference() {
	union() {
	  difference() {
	    roundedbox(length+wall*2,width+wall*2,height+wall);
	    translate([wall,wall,wall]) roundedbox(length,width,height+1);
	  }
	}

	hull() {
	  translate([wall+holestart,wall+width/2,wall/2]) cylinder(h=wall+1,d=holediameter);
	  translate([wall+holeend,wall+width/2,wall/2]) cylinder(h=wall+1,d=holediameter);
	}
	hull() {
	  translate([wall+length-holestart,wall+width/2,wall/2]) cylinder(h=wall+1,d=holediameter);
	  translate([wall+length-holeend,wall+width/2,wall/2]) cylinder(h=wall+1,d=holediameter);
	}

	cablecutsnap(cablecut);
	cablecutsnap(cablecut+cablecutwidth+cablecutgap);
	cablecutsnap(cablecut+2*(cablecutwidth+cablecutgap));
	cablecutsnap(cablecut+3*(cablecutwidth+cablecutgap));
	//	cablecutsnap(cablecut+4*(cablecutwidth+cablecutgap));
    
	cablecutsnap(length-cablecut-cablecutwidth);
	cablecutsnap(length-cablecut-cablecutwidth-cablecutwidth-cablecutgap);
	cablecutsnap(length-cablecut-cablecutwidth-2*(cablecutwidth+cablecutgap));
	cablecutsnap(length-cablecut-cablecutwidth-3*(cablecutwidth+cablecutgap));
	//	cablecutsnap(length-cablecut-cablecutwidth-4*(cablecutwidth+cablecutgap));
    
	translate([wall+lockcut-locklength/2-lockcutsize,-1,wall]) cube([lockcutsize,wall+width+wall+1,height+1]);
	translate([wall+lockcut+locklength/2,-1,wall]) cube([lockcutsize,wall+width+wall+1,height+1]);
      }

      translate([wall+lockcut-locklength/2,locknotchdiameter/2,wall+locknotchheight+locknotchdiameter/2]) rotate([0,90,0]) cylinder(h=locklength,d=locknotchdiameter);
      translate([wall+lockcut-locklength/2,wall*2+width-locknotchdiameter/2,wall+locknotchheight+locknotchdiameter/2]) rotate([0,90,0]) cylinder(h=locklength,d=locknotchdiameter);

      difference() {
	union() {
	  translate([wall+length/2-locklength/2-cablecutgap-wall,wall*1.5,0]) roundedbox(locklength+2*cablecutgap+2*wall,width-wall,wall+locknotchheight-platethickness);
	  translate([wall+length/2-locklength/2-cablecutgap-wall,0,0]) roundedbox(wall,wall+width+wall,wall+locknotchheight-platethickness);
	  translate([wall+length/2+locklength/2+cablecutgap,0,0]) roundedbox(wall,wall+width+wall,wall+locknotchheight-platethickness);
	}
	translate([length/2-locklength/2-cablecutwidth,wall*2.5,wall]) roundedbox(locklength+2*cablecutwidth+2*wall,width-3*wall,wall+locknotchheight-platethickness);
      }
    }
    translate([wall+length/2,wall+width/2,textdepth-0.01]) rotate([0,180,0]) linear_extrude(height=textdepth) text(text = str(versiontext), font = textfont, size=textheight, valign="center");
  }
}

batterycover();
if (howmany > 1) translate([0,yspread,0]) batterycover();
if (howmany > 2) translate([0,yspread*2,0]) batterycover();
if (howmany > 3) translate([0,yspread*3,0]) batterycover();
if (howmany > 4) translate([0,yspread*4,0]) batterycover();
if (howmany > 5) translate([0,yspread*5,0]) batterycover();
if (howmany > 6) translate([0,yspread*6,0]) batterycover();
if (howmany > 7) translate([0,yspread*7,0]) batterycover();
if (howmany > 8) translate([xspread,0,0]) batterycover();
if (howmany > 9) translate([xspread,yspread,0]) batterycover();
if (howmany > 10) translate([xspread,yspread*2,0]) batterycover();
if (howmany > 11) translate([xspread,yspread*3,0]) batterycover();
if (howmany > 12) translate([xspread,yspread*4,0]) batterycover();
if (howmany > 13) translate([xspread,yspread*5,0]) batterycover();
if (howmany > 14) translate([xspread,yspread*6,0]) batterycover();
if (howmany > 15) translate([xspread,yspread*7,0]) batterycover();


