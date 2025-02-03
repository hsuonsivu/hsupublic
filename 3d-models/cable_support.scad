//	  Last Modification : 03:08 Mar  2 2022 kivinen
//	  Last check in     : $Date: $
//	  Revision number   : $Revision: $
//	  State             : $State: $
//	  Version	    : 1.306
//	  Edit time	    : 75 min

// further edits by hsu@iki.fi

$fn = 50;
THICKNESS=1.7; //1.4;

// if cutout is true, then make it bigger for cutout
module side_plate1(cutout) {
  t = cutout ? 5 : THICKNESS;
  a = cutout ? -20 : 0;
  
  hull() {
    translate([17/2, 0, 0])
      cylinder(h=t, d=0.1);
    translate([-17/2 + a, 0, 0])
      cylinder(h=t, d=0.1);
    translate([17/2-0.5-0.5, 6-0.5, 0])
      cylinder(h=t, d=1);
    translate([17/2-16-0.5, 14-0.5, 0])
      cylinder(h=t, d=1);
    translate([17/2-19+0.5 + a, 14-0.5, 0])
      cylinder(h=t, d=1);
  }
}

module side_circle() {
    translate([17/2-22, 14/2, THICKNESS])
      cylinder(h=THICKNESS, d=14);
}

module side_axle() {
  difference() {
    translate([17/2-22, 14/2, -2+THICKNESS*2])
      cylinder(h=2, d=4.5);
    translate([17/2-22, 14/2, -20/2-0.7])
      rotate([-30, 10, 0])
      cube([20, 20, 20], center=true);
  }
}

module side_plate2() {
  hull() {
    // Big circle
    side_circle();
    // Lower left corner
    translate([17/2-22+16, 0, THICKNESS])
      cylinder(h=THICKNESS, d=0.1);
    // Lower right corner
    translate([17/2-15, 0.5, THICKNESS])
      cylinder(h=THICKNESS, d=1);
    // Lower right corner widener
    translate([17/2-15, 1.5, THICKNESS])
      cylinder(h=0.01, d=3);
    // Upper right corner
    translate([17/2-15+5, 14-0.5, THICKNESS])
      cylinder(h=THICKNESS, d=1);
    // Upper right corner widener
    translate([17/2-15, 14-1.5, THICKNESS])
      cylinder(h=0.01, d=3);
    // Upper left corner
    translate([17/2-22, 14, THICKNESS])
      cylinder(h=THICKNESS, d=0.1);
  }
}

module side_plate() {
  difference() {
    union() {
      side_plate1(false);
      intersection() {
	side_plate2();
	side_plate1(true);
      }
    }
    translate([0, 0, -THICKNESS-0.01])
      side_circle();
  }
  translate([0, 0, -THICKNESS])
    side_axle();
}

module cable_support() {
  difference() {
    // Base plate
    translate([0, 0, 1.9/2])
      cube([17, 20, 1.9], center=true);
    // Hole 1
    translate([17/2-5, 20/2-4, -0.05])
      cylinder(h=2, d=4);
    // Sink 1
    translate([17/2-5, 20/2-4, 1.01])
      cylinder(h=1, d1=5, d2=6);
    // Hole 2
    translate([-(17/2-5), 20/2-4, -0.05])
      cylinder(h=2, d=4);
    // Sink 2
    translate([-(17/2-5), 20/2-4, 1.01])
      cylinder(h=1, d1=5, d2=6);
    // Hole 3
    translate([0, 20/2-12.5, -0.05])
      cylinder(h=2, d=3.5);
    // Sink 3
    translate([0, 20/2-12.5, 0.51])
      cylinder(h=1.5, d1=3.5, d2=5);
    // Side plate 1
    translate([-17/2, 1.5, 0])
      rotate([0, 0, 90])
      rotate([90, 0, 0])
      translate([0, 0, -THICKNESS-0.01])
      side_circle();
    // Side plate
    translate([17/2, 1.5, 0])
      rotate([0, 0, 90])
      rotate([90, 0, 0])
      mirror([0, 0, 1])
      translate([0, 0, -THICKNESS-0.011])
      side_circle();
  }
  // Side plate 1
  translate([-17/2, 1.5, 0])
    rotate([0, 0, 90])
    rotate([90, 0, 0])
    side_plate();
  // Side plate
  translate([17/2, 1.5, 0])
    rotate([0, 0, 90])
    rotate([90, 0, 0])
    mirror([0, 0, 1])
    side_plate();
}

cable_support();

