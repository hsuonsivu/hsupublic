//	  Last Modification : 10:45 Feb 20 2022 kivinen
//	  Last check in     : $Date: $
//	  Revision number   : $Revision: $
//	  State             : $State: $
//	  Version	    : 1.318
//	  Edit time	    : 86 min

use <powerstrip2.scad>;
  
ALPHA=0.8;

WIDTH_TOP=54;
WIDTH_MAX=58;
WIDTH_BOTTOM=54;

LEN=360;

HEIGHT=44;
HEIGHT_TO_MAX=22;

CABLE_HOLE_DIA=21;//10;
CABLE_HOLE_Z=HEIGHT/2;//10;

BULGE=55-49;
POWER_LEN=360;

SCREW_DIA=6;
HEAD_DIA=11;

CAP_THICKNESS=24;

// Verson
VERSION="v5";

// Fonts
FONT="Liberation Sans Bold";
FONT_SIZE=6;

$fn=50;


module powerbar() {
  powerstrip_solid();
}

module end_cap(cablehole) {
  difference() {
    intersection() {
      // Outer intersection with 1.1 scale, do not translate, as we want
      // flat bottom
      scale([1.1, 1.1, 1.1])
	translate([0, 0, 0])
	powerbar();
      difference() {
	translate([-5, 0, 0])
	  // End piece cube
	  cube([CAP_THICKNESS, WIDTH_MAX * 2, HEIGHT * 2], center=true);
	// Remove powerstrip from it
	translate([LEN/2, 0, 0])
	  powerbar();
      }
    }
    // Make hole for cable
    if (cablehole) {
      translate([0, 0, -HEIGHT/2+CABLE_HOLE_Z])
	rotate([0, 90, 0])
	cylinder(h=CAP_THICKNESS * 2, d=CABLE_HOLE_DIA, center=true);
      // Widen it to the bottom of holder
      translate([0, 0, -HEIGHT/2 + CABLE_HOLE_Z/2-1])
	cube([CAP_THICKNESS * 2, CABLE_HOLE_DIA, CABLE_HOLE_Z+2], center=true);
      // Remove bottom section
      translate([0, 0, -HEIGHT/2 - 20/2])
	cube([CAP_THICKNESS * 2, WIDTH_MAX * 2, 20], center=true);
    }

    // Make holes for the screws
    if (0) {translate([-10, -WIDTH_MAX/2+10, 0])
	union() {
	cylinder(h=HEIGHT*2, d=SCREW_DIA, center=true);
	translate([0, 0, HEIGHT/2-15])
	  cylinder(h=HEIGHT, d=HEAD_DIA, center=true);
      }
    }
    
    for (y=[-WIDTH_MAX/2+10, WIDTH_MAX/2-10]) {
      translate([-10,y, 0])
	union() {
	cylinder(h=HEIGHT*2, d=SCREW_DIA, center=true);
	hull() {
	  translate([0, 0, HEIGHT/2-15])
	    cylinder(h=HEIGHT, d=HEAD_DIA, center=true);
	  translate([HEAD_DIA/2-0.1,-HEAD_DIA/4,-(HEIGHT/2-15)-8]) cube([0.1,HEAD_DIA/2,HEIGHT]);
	}
      }
    }

    // Version text
    //      translate([BACKPLATE_THICKNESS + 10, +30, THICKNESS_UPPER])
    translate([-1.5+0.2, 0, HEIGHT/3])
      rotate([0, 7.8, 0])
      rotate([90, 0, 0])
      rotate([0, 90, 0])
      linear_extrude(0.5)
      text(text=VERSION, font = FONT, size = FONT_SIZE,
	   valign = "center", halign = "center");
  }
}

//#powerstrip_solid();
//translate([-POWER_LEN/2-0.5,0,0])
rotate([0,-90,0])
end_cap(0);
translate([HEIGHT+2,0,0]) rotate([0,-90,0])
#end_cap(1);
