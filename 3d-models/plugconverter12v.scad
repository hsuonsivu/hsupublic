// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=print==0?1:0;

versiontext=str("V1.0");
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

clipwall=1.6;
wall=1.8; //1.2+clipwall;

socketw=8.87;
socketh=10.65;
socketl=14.22; //16.82;
socketbarrelh=10.55;
socketbarreld=7.88;
socketheadl=3.43;
socketbarrelheight=6.4;
socketpinend=11.4;
socketpinstart=9;
socketpinl=2.45;
socketpinh=7.85;
socketpinheight=-3.7;
socketpinouty=0.8;
socketholed=6.15;
socketholel=9.5;

plugd=9.35;
plugbarrelextendd=7.15;
plugstraighth=7;
plugstraightw=plugd;
plugoutd=7.25;
plugbodywided=11.5;
plugbodyendd=10.54;
plugbodynarroww=6.6;
plugbodywidew=plugd;
plugbodywideh=5;
plugbodyh=8.83;
plugl=28;
plugcontactd=5.6;
plugsocketl=7.25;
plugbarrelh=14-plugbodyh;//6.8;
plugbarrelextendh=16.5-plugbarrelh-plugbodyh;//3;

plugsocketinterfacex=-2.91;
plugsocketinterfacel=9;
plugsocketinterfaceh=7.2; //8.2;
plugsocketinterfacew=6;


plugsocketangle=1;

cornerd=1;

tolerance=0.25;

socketcoverw=max(plugbodywided,socketw+socketpinouty*2)+tolerance*2+wall*2;;
socketcoverh=socketh-socketpinheight+tolerance*2+wall*2;
socketcoverl=socketl+tolerance+wall*2+2.5;
socketcoverx=-wall-tolerance;
socketcoverheight=socketpinheight-tolerance-wall;

plugcoverh=wall+plugbodyh+plugbarrelh+plugbarrelextendh+tolerance+cornerd;
plugcoverw=socketcoverw;
plugcoverl=plugbodywided+tolerance*2+wall*2;
plugcoverheight=-wall-tolerance-cornerd;

;
$fn=90;

clipdepth=-cornerd;
clipl=4;
clipw=socketcoverw/2-cornerd;
//clipwall=wall/2;
clipcornerd=1;//clipwall;
tubeclipdepth=0.6;
tubeclipd=clipwall+tubeclipdepth;
tubeclipl=clipl;

module clip(t) {
  translate([-clipl/2-t,-cornerd-t,-clipwall-t]) roundedbox(clipl+t*2,clipw+cornerd+t*2,clipwall+t*4,clipcornerd,0);
  hull() {
    translate([-clipl/2-t,clipw-tubeclipd,-clipwall-t]) roundedbox(clipl+t*2,tubeclipd+t,clipwall+t*2,clipcornerd,0);
    translate([0,clipw-tubeclipd/2,-tubeclipd/2]) tubeclip(tubeclipl+t*2,tubeclipd,t/10);
  }
}

module plug(t)
{
  intersection() {
    hull() {
      translate([-plugbodywided/2-t,-plugbodynarroww/2-t,-t]) cube([plugbodywided+t*2,plugbodynarroww+t*2,plugbodyh+t*2]);
      translate([-plugbodywided/2-t,-plugbodywidew/2-t,plugbodyh-t-0.01]) cube([plugbodywided+t*2,plugbodywidew+t*2,t*2+0.01]);
    }

    hull() {
      translate([0,0,-t]) cylinder(d1=plugbodyendd,d2=plugbodywided,h=plugbodywideh+t*2);
      translate([0,0,plugbodywideh-t]) cylinder(d1=plugbodywided,d2=plugd,h=plugbodyh-plugbodywideh+t*2);
    }
  }

  translate([0,0,-t]) cylinder(d=plugcontactd+t*2,h=plugl+t*2);
  translate([0,0,plugbodyh-t-0.01]) cylinder(d=plugd+t*2,h=plugbarrelh+t*2+0.01);
  translate([0,0,plugbodyh+plugbarrelh-t-0.01]) cylinder(d=plugbarrelextendd+t*2,h=plugbarrelextendh+t*2+0.01);

  translate([-plugstraighth/2-t,-plugd/2-t,plugbodyh-t]) roundedbox(plugstraighth+t*2,plugd+t*2,plugbarrelh+t*2,cornerd,0);
}

module socket(t) {
  difference() {
    union() {
      translate([-t,0,socketbarrelheight]) rotate([0,90,0]) roundedcylinder(socketbarreld+t*2,socketl+t*2,cornerd,0,90);
      translate([-t,-socketw/2-t,-t]) roundedbox(socketheadl+t*2,socketw+t*2,socketh+t*2,cornerd,0);
      translate([-t,-socketw/2-t,-t]) roundedbox(socketl+t*2,socketw+t*2,socketbarrelheight+t*2,cornerd,0);
      translate([socketpinstart-t,-socketw/2-socketpinouty-t,socketpinheight-t]) roundedbox(socketpinl+t*2,socketpinouty+socketw/2+t*2,socketpinh+t*2,cornerd,0);
    }
    if (!t) translate([-0.01,0,socketbarrelheight]) rotate([0,90,0]) roundedcylinder(socketholed,socketholel+0.01,cornerd,0,90);
  }
}

module plugsocket(t) {
  translate([0,0,-plugsocketinterfaceh]) rotate([180,plugsocketangle,0]) plug(t);
  translate([plugsocketinterfacex+socketl,0,0]) rotate([0,0,180]) socket(t);
  translate([-plugsocketinterfacel/2,-plugsocketinterfacew/2,-plugsocketinterfaceh-cornerd/2]) roundedbox(plugsocketinterfacel,plugsocketinterfacew,plugsocketinterfaceh+cornerd+1,cornerd,0); // +1 for solder blob
}

module cover(bottom) {
  y=bottom?socketcoverw/2:0;
  difference() {
    union() {
      translate([plugsocketinterfacex+socketl,0,0]) rotate([0,0,180]) translate([0,-y,socketcoverheight]) {
	difference() {
	  union() {
	    roundedbox(socketcoverl,socketcoverw/2,socketcoverh,cornerd,0);
	    if (bottom) {
	      translate([socketcoverl/2, y,socketcoverh]) clip(0);
	      translate([0,y,clipl/2+cornerd]) rotate([0,-90,0]) clip(0);
	      translate([socketcoverl,y,socketh/2+clipl/2+cornerd]) rotate([0,90,0]) clip(0);
	    }
	  }

	  if (bottom) {
	    translate([socketcoverl/2,textdepth-0.01,socketcoverh/2]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize-1,font=textfont,valign="center",halign="center");
	  } else {
	    translate([socketcoverl/2,socketcoverw/2-textdepth+0.01,socketcoverh/2]) rotate([-90,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize-1,font=textfont,valign="center",halign="center");
	  }
      
	  if (!bottom) {
	    translate([socketcoverl/2, y,socketcoverh]) clip(tolerance);
	    translate([0,y,clipl/2+cornerd]) rotate([0,-90,0]) clip(tolerance);
	    translate([socketcoverl,y,socketh/2+clipl/2+cornerd]) rotate([0,90,0]) clip(tolerance);
	  }
	}
      }
      
      translate([0,-socketcoverw/2+y,-plugsocketinterfaceh]) rotate([180,-plugsocketangle,180]) {
	difference() {
	  union() {
	    translate([-plugcoverl/2,0,plugcoverheight]) roundedbox(plugcoverl,plugcoverw/2,plugcoverh,cornerd,0);

	    if (bottom) {
	      translate([plugcoverl/2,0,plugbodyh+plugbarrelh+-cornerd-clipl/2]) rotate([0,-90,180]) clip(0);
	      translate([-plugcoverl/2,0,plugbodyh+plugbarrelh+-cornerd-clipl/2]) rotate([0,90,180]) clip(0);
	    }
	  }
      
	  if (!bottom) {
	    translate([plugcoverl/2,socketcoverw/2,plugbodyh+plugbarrelh+-cornerd-clipl/2]) rotate([0,-90,180]) clip(tolerance);
	    translate([-plugcoverl/2,socketcoverw/2,plugbodyh+plugbarrelh+-cornerd-clipl/2]) rotate([0,90,180]) clip(tolerance);
	  }
	}
      }
    }
    
#    plugsocket(tolerance);
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([1,-100,-100]) cube([100,200,200]);
    union() {
      cover(1);
      cover(0);
    }
  }
 }

if (print==1) {
  intersection() {
    if (debug) translate([1,0,0]) cube([100,100,100]);
    union() {
      translate([0,0,socketcoverw/2]) rotate([-90,0,0]) cover(1);
      translate([0,socketh*2+tolerance*2+wall*2+0.5,socketcoverw/2]) rotate([90,0,0]) cover(0);
    }
  }
 }

//socket();

//plug();
