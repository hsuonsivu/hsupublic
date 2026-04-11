
include <hsu.scad>

debug=0;

l=14;
extral=1+1;
diameter=8.5; //9;
insided=6;
narrowd=7;

flangeh=1;
flanged=diameter+2;
clipx=1.5;
clipextendd=1;
clipmovementl=clipextendd/2+0.5;
clipcut=0.5;
clipy=(diameter-4)/2-clipcut;
clipmovementy=clipy-clipcut;
clipheight=10;
cliph=3;
clipcutheight=3;
clipcuth=l-1-clipcutheight;
wall=2;

clipangle=120;

td=1;
tsink=td*0.3;
  
module toroid(diameter,dt) {
  $fn=120;
  rotate_extrude() translate([diameter-dt/2,0,0]) circle(d=dt);
}

module plug9() {
  difference() {
    union() {
      hull() {
	cylinder(d=diameter,h=l+0.2,$fn=120);
	cylinder(d=narrowd,h=l+extral,$fn=120);
      }
      intersection() {
	cylinder(d=flanged,h=flangeh,$fn=120);
	translate([1,0,0]) cylinder(d=flanged,h=flangeh,$fn=120);
      }

      intersection() {
	union() {
	  for (a=[0:clipangle:359]) rotate([0,0,a]) {
	      translate([-clipx-clipcut+0.01,clipy,clipheight]) cube([(clipx+clipcut)*2-0.02,diameter+3,cliph]);
	    }
	}
      
	hull() {
	  translate([0,0,clipheight+cliph/3]) cylinder(d=diameter+clipextendd,h=cliph/3,$fn=120);
	  translate([0,0,clipheight]) cylinder(d=diameter,h=cliph,$fn=120);
	}
      }
    }

    translate([0,0,flangeh+td/2]) toroid(diameter/2+td-tsink,td);
  
    for (a=[0:clipangle:359]) rotate([0,0,a]) {
	ch=(a==90||a==270)?clipcuth+0.2:clipcuth;
	for (m1=[0,1]) mirror([m1,0,0]) translate([clipx,clipy,clipcutheight]) cube([clipcut,diameter+3,ch+clipcut]);
	translate([-clipx-clipcut,clipy,clipcutheight+ch]) cube([(clipx+clipcut)*2,diameter+3,clipcut]);
	translate([-clipx-clipcut,clipy,clipcutheight]) cube([(clipx+clipcut)*2,clipmovementl,ch+clipcut]);
	xr=sqrt((diameter/2)*(diameter/2)-(clipx+clipcut)*(clipx+clipcut));
	translate([-clipx-clipcut,xr,clipcutheight+ch+clipcut]) triangle((clipx+clipcut)*2,diameter/2,diameter/2,11);
	translate([-clipx-clipcut,xr,clipcutheight+ch+clipcut-0.01]) cube([(clipx+clipcut)*2,diameter/2,0.01]);
      }
  }
}

intersection() {
  if (debug) cube([100,100,clipheight+cliph/3+cliph/6]);
  plug9();
}


