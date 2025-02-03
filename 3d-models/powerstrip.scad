//	  Last Modification : 07:18 Feb 20 2022 kivinen
//	  Last check in     : $Date: $
//	  Revision number   : $Revision: $
//	  State             : $State: $
//	  Version	    : 1.85
//	  Edit time	    : 44 min


use <doublefrustum.scad>

POWER_HEIGHT=44;
POWER_LEN=360;
POWER_WIDTH=54;
POWER_WIDTH_BULGE=2;
POWER_LEN_BULGE=3;

POWER_PLUG_DIA=39;
POWER_PLUG_DEPTH=18;
POWER_PLUG_GAP=13.5;
POWER_PLUG_FIRST_GAP=7;

POWER_ROUNDING_R=2;

$fn=50;

module powerstrip(sockets, cable) {
  difference() {
    translate([0, 0, -POWER_HEIGHT/2])
      doublefrustum(0, POWER_HEIGHT/2, POWER_HEIGHT, // z0, z1, z2
		  POWER_LEN/2, POWER_WIDTH/2, // x0, y0
		    POWER_LEN/2 + POWER_LEN_BULGE,  // x1
		    POWER_WIDTH/2 + POWER_WIDTH_BULGE, //y1
		    POWER_LEN/2, POWER_WIDTH/2); // x2, y2
    if (sockets) { 
      for(i=[0:1:5]) {
	translate([POWER_LEN/2 - POWER_PLUG_FIRST_GAP - POWER_PLUG_DIA/2 -
		   i * (POWER_PLUG_DIA + POWER_PLUG_GAP), 0, 0])
	  translate([0, 0, POWER_HEIGHT/2 - POWER_PLUG_DEPTH/2+1])
	  cylinder(h=POWER_PLUG_DEPTH+1, d=POWER_PLUG_DIA, center=true);
      }
    }
  }
  if (cable) {
    translate([-POWER_LEN/2 - 20/2, 0, -11])
      rotate([0, 90, 0])
      cylinder(h=20, d=8, center=true);
  }
}

module powerstrip_solid(sockets, cable) {
  difference() {
    translate([0, 0, -POWER_HEIGHT/2])
      hull() {
      translate([0, 0, 0])
	cube([POWER_LEN, POWER_WIDTH, 0.01], center=true);
      translate([0, 0, POWER_HEIGHT/2])
	cube([POWER_LEN + POWER_LEN_BULGE * 2,
	      POWER_WIDTH + POWER_WIDTH_BULGE * 2, 0.01], center=true);
      translate([0, 0, POWER_HEIGHT])
	cube([POWER_LEN, POWER_WIDTH, 0.01], center=true);
    }
    if (sockets) {
      for(i=[0:1:5]) {
	translate([POWER_LEN/2 - POWER_PLUG_FIRST_GAP - POWER_PLUG_DIA/2 -
		   i * (POWER_PLUG_DIA + POWER_PLUG_GAP), 0, 0])
	  translate([0, 0, POWER_HEIGHT/2 - POWER_PLUG_DEPTH/2+1])
	  cylinder(h=POWER_PLUG_DEPTH+1, d=POWER_PLUG_DIA, center=true);
      }
    }
  }
  if (cable) {
    translate([-POWER_LEN/2 - 20/2, 0, -11])
      rotate([0, 90, 0])
      cylinder(h=20, d=8, center=true);
  }
}

module rcube(size, r) {
  hull() {
    translate([size[0]/2-r, size[1]/2-r, 0])
      sphere(r=r);
    translate([-(size[0]/2-r), size[1]/2-r, 0])
      sphere(r=r);
    translate([size[0]/2-r, -(size[1]/2-r), 0])
      sphere(r=r);
    translate([-(size[0]/2-r), -(size[1]/2-r), 0])
      sphere(r=r);
  }
}

module powerstrip_solid_rounded(sockets, cable) {
  difference() {
    translate([0, 0, -POWER_HEIGHT/2])
      hull() {
      translate([0, 0, POWER_ROUNDING_R])
	rcube([POWER_LEN, POWER_WIDTH], POWER_ROUNDING_R);
      translate([0, 0, POWER_HEIGHT/2])
	rcube([POWER_LEN + POWER_LEN_BULGE * 2,
	       POWER_WIDTH + POWER_WIDTH_BULGE * 2],
	      POWER_ROUNDING_R);
      translate([0, 0, POWER_HEIGHT-POWER_ROUNDING_R])
	rcube([POWER_LEN, POWER_WIDTH], POWER_ROUNDING_R);
    }
    if (sockets) {
      for(i=[0:1:5]) {
	translate([POWER_LEN/2 - POWER_PLUG_FIRST_GAP - POWER_PLUG_DIA/2 -
		   i * (POWER_PLUG_DIA + POWER_PLUG_GAP), 0, 0])
	  translate([0, 0, POWER_HEIGHT/2 - POWER_PLUG_DEPTH/2+1])
	  cylinder(h=POWER_PLUG_DEPTH+1, d=POWER_PLUG_DIA, center=true);
      }
    }
  }
  if (cable) {
    translate([-POWER_LEN/2 - 20/2, 0, -11])
      rotate([0, 90, 0])
      cylinder(h=20, d=8, center=true);
  }
}

powerstrip_solid_rounded(true, true);
