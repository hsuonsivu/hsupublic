width=8;
diameter=13*2;
thickness=1;
gap=0.5;
length=25;
$fn=90;
cabled=5;
screwd=4.25;
springl=length-2*screwd;
depth=8;
treethickness=5;
treex=50;
treey=50;
treez=100;

module tree() {
  color([0.6,0.3,0.3]) translate([diameter/2,0,0]) difference() { 
    cube([treex,treey,treez],center=true);
    translate([0,0,-treez/2-1]) cylinder(h=treez*2,d=diameter);
    translate([diameter/2+depth,0,-1]) cube([treex,treey*2,treez*2],center=true);
  }
}

module clip() {
  difference() {
    union() {
      intersection() {
	translate([diameter/2,0,0]) {
	  difference() {
	    cylinder(h=width,d=diameter);
	    translate([0,0,-0.01]) cylinder(h=width+0.02,d=diameter-thickness*2);
	  }
	}

	translate([-0.01,-length/2,0]) cube([depth,length/2-cabled/2,width]);
      }
      intersection() {
	difference() {
	  hull() {
	    translate([cabled/2,0,0]) cylinder(h=width,d=cabled+thickness*2);
	    cylinder(h=width,d=cabled+thickness*2);
	  }
	  hull() {
	    translate([cabled/2,0,0]) translate([0,0,-0.01]) cylinder(h=width+0.02,d=cabled);
	    translate([0,0,-0.01]) cylinder(h=width+0.02,d=cabled);
	  }
	}
	translate([diameter/2,0,0]) cylinder(h=width,d=diameter);
	translate([0,-length/2,0]) cube([cabled*2,length/2,width]);
      }

      translate([cabled,-0.01,0]) cube([thickness,cabled*.99,width]);
    }
    translate([diameter/2,0,width/2]) rotate([90,0,-90+40]) cylinder(d=screwd,h=diameter+1);
  }
}

//tree();
clip();
