// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

print=0;
strong=0;

countersinkheightmultiplier=0.63;
countersinkdiametermultiplier=2.4;

function countersinkd(diameter) = diameter*countersinkdiametermultiplier;

module ruuvireika(height,diameter,countersink,strong) {
  makestrong=(strong=="")?1:strong;
  
  hull() {
    translate([0,0,diameter/2]) cylinder(h=height-diameter/2,d=diameter-0.1,$fn=90); // Slightly smaller hole
    translate([0,0,0]) cylinder(h=diameter/2,d2=diameter-0.1,d1=1,$fn=90); // screw head
  }

  if (makestrong) {
    maxd=diameter*countersinkdiametermultiplier-(diameter+0.3)+1;
    for (d=[diameter+0.8:0.9:diameter*3-0.6]) {
      di=d;
      bottom=(d<diameter*3*0.6-0.8)?-diameter/3*3+0.4:-diameter/3*3+(d-diameter)*1-diameter*0.6+0.4;
      top=(d>countersinkd(diameter))?height-0.4:height-0.8-diameter+d/2-0.4;
      translate([0,0,0])
	difference() {
	translate([0,0,bottom]) cylinder(h=top-bottom,d=di+0.03,$fn=20);
	translate([0,0,bottom-0.01]) cylinder(h=top-bottom+0.02,d=di,$fn=20);
      }
    }
  }

  if (countersink) {
    translate([0,0,height-diameter*countersinkheightmultiplier]) cylinder(h=diameter*countersinkheightmultiplier,d1=diameter-0.1,d2=diameter*countersinkdiametermultiplier,$fn=90);
  }
}

module ruuvitorni(height,diameter) {
  cylinder(h=height,d=diameter);
  translate([0,0,-diameter/3+0.01]) cylinder(h=diameter/3,d2=diameter,d1=diameter*0.6,$fn=90);
}

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

module roundedbox(x,y,z,c) {
  corner=(c > 0) ? c : 1;
  //scd = ((x < 1 || y < 1 || z < 1) ? min(x,y,z) : corner);
  scd = min(x,y,z,corner);
  f=(print > 0) ? 90 : 30;
  
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
  }
}

module tassu(direction,size) {
  s=(size?size:7);
  $fn=30;
  rotate([0,0,direction]) {
    hull() {
      cylinder(d=3,h=0.31);
      translate([s/2-1,0,0]) cylinder(d=1.5,h=0.35);
      translate([s/2-1,0,0]) cylinder(d1=s,d2=s-1,h=0.35);
    }
  }
}

module ring(diameter,wall,height) {
  difference() {
    cylinder(d=diameter,h=height);
    translate([0,0,-0.1]) cylinder(d=diameter-wall*2,h=height+0.2);
  }
}

// Make a spring. Springs generated are not very reliable, and need to be put inside a tube to work.
springangle=1.2;
module spring(h,d,plateh,thickness) {
  $fn=120;

  s=1;

  // Need to raise height pi*d for 360 degrees
  degrees=360*h/(d*3.14159)*springangle;
  
  platetwist=degrees*(d/2)/(h/2);
  twist=degrees;

  translate([0,0,h]) rotate([180,0,0]) {
    for (t=[1,-1]) {
      translate([0,0,t==1?0:h/2-plateh/2]) {
	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([d/2-s-thickness/2,0,0]) circle(d=thickness);
	  intersection() {
	    translate([0,-d/2,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([d/2-s-thickness/2,0,0]) circle(d=thickness);

	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([-d/2+s+thickness/2,0,0]) circle(d=thickness);
	  intersection() {
	    translate([-d/2,0,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([-d/2+s+thickness/2,0,0]) circle(d=thickness);

	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([0,d/2-s-thickness/2,0]) circle(d=thickness);
	  intersection() {
	    translate([0,0,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([0,d/2-s-thickness/2,0]) circle(d=thickness);

	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([0,-d/2+s+thickness/2,0]) circle(d=thickness);
	  intersection() {
	    translate([-d/2,-d/2,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([0,-d/2+s+thickness/2,0]) circle(d=thickness);
      }
    }
  
    // Top
    translate([0,0,h-plateh]) cylinder(h=plateh,d=d);
  }
}

