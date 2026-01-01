
include <hsu.scad>

l=13;
extral=1;
diameter=9;
insided=6;
narrowd=7;

flangeh=1;
flanged=diameter+2;
clipx=2;
clipmovementl=1;
clipcut=0.5;
clipy=(diameter-4)/2-clipcut;;
clipmovementy=clipy-clipcut;
clipheight=8;
cliph=3;
clipcutheight=3;
clipcuth=l-1-clipcutheight;
clipextendd=1;
wall=2;

td=1;
tsink=td*0.3;
  
module toroid(diameter,dt) {
  $fn=120;
  rotate_extrude() translate([diameter-dt/2,0,0]) circle(d=dt);
}

difference() {
  union() {
    hull() {
      cylinder(d=diameter,h=l,$fn=120);
      cylinder(d=narrowd,h=l+extral,$fn=120);
    }
    intersection() {
      cylinder(d=flanged,h=flangeh,$fn=120);
      translate([1,0,0]) cylinder(d=flanged,h=flangeh,$fn=120);
    }

    hull() {
      translate([0,0,clipheight+cliph/3]) cylinder(d=diameter+clipextendd,h=cliph/3,$fn=120);
      translate([0,0,clipheight]) cylinder(d=diameter,h=cliph,$fn=120);
    }
  }

  translate([0,0,flangeh+td/2]) toroid(diameter/2+td-tsink,td);
  
  for (m=[0,1]) mirror([0,m,0]) {
      for (m1=[0,1]) mirror([m1,0,0]) translate([clipx,clipy,clipcutheight]) cube([clipcut,diameter+3,clipcuth+clipcut]);
      translate([-clipx-clipcut,clipy,clipcutheight+clipcuth]) cube([(clipx+clipcut)*2,diameter+3,clipcut]);
      translate([-clipx-clipcut,clipmovementy,clipcutheight]) cube([(clipx+clipcut)*2,clipmovementl+clipcut,clipcuth+clipcut]);
    }
}


