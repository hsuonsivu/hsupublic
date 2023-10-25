// Kivinen original 0,1
// hsu patches, better printability.
rampshift=2;
rampwidth=0;
supportplatey=1;
supportplatez=2;

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

// One hole for the screws
module hole() {
  color("Blue")
    intersection() {
      cylinder(h=6, r=10.4/2, center=true);
      cube([7.5, 10, 7], center=true);
    }
}

// Set of 3 holes
module holes() {
  translate([43.5/2, 5+10.4/2, 2]) 
  union() {
    translate([-16, 0, 0]) hole();
    translate([+16, 0, 0]) hole();
    hole();
  }
}

// The rectangular cone, one quarter
module conepiece() {
  color("Green")
  linear_extrude(height = 10, center=true, scale=3.9/4)
  square(2);
}

// Half cone
module conehalf() {
  union() {
    mirror([1,0,0]) conepiece();
    conepiece();
  }
}

// Full cone
module cone() {
  rotate(-90, [1, 0, 0])
  union() {
    conehalf();
    rotate(180, [0, 0, 1]) conehalf();
  }
}

module ramp() {
  color("Yellow")
    translate([0, 32.1-10-3-rampshift, 3])
    rotate(90, [0, 0, 1])
    rotate(90, [1, 0, 0])
    // In original piece this was 40mm, but make printing easier
    // I extended it to full length (i.e. +3.5 was added because of that).
    linear_extrude(height=40+3.5, center=true)
    // Original piece was 3 mm x 2 mm ramp, but changed to 3mm x 3mm to
    // mke printing easier bu adding -1 to first point
      polygon([[0-rampwidth, 0], [2, 3], [2, 0]]);
}

module base() {
  color("red")
  union() {
    cube([43.5, 32.1-10, 3]);
    translate([0, 32.1-10-1-rampshift, 0]) cube([43.5, 1+rampshift, 6]);
  }
}

module base2() {
  translate([-43.5/2, 0, 0])
  difference() {
    base();
    holes();
  }
}

module piece() {
  base2();
  translate([-20+2, 32.1-10+5, 4]) cone();
  translate([20-2, 32.1-10+5, 4]) cone();
}

ramp();
piece();
translate([-43.5/2,0,-supportplatez]) cube([43.5,supportplatey,supportplatez+0.01]);
translate([-43.5/2,supportplatey-0.01,-supportplatez]) triangle(43.5,supportplatey,supportplatez+0.01,10);
