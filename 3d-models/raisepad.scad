// Pads to set below furniture to raise them a bit

include <hsu.scad>

diameter=50; // INside diameter
height=8; // How much to raise
edgewidth=4;
edgeheight=height+5;
$fn=90;

module pad() {
  cylinder(d=diameter+1,h=height);
  difference() {
    cylinder(d2=diameter+2*edgewidth,d1=diameter+2*edgewidth+edgeheight,h=edgeheight);
    translate([0,0,-0.01]) cylinder(d=diameter,h=edgeheight+0.02);
  }
}

for (i=[0:1:1]) {
  for (j=[0:1:1]) {
    translate([i*(diameter+edgewidth*2+edgeheight+1),j*(diameter+edgewidth*2+edgeheight+1),0]) pad();
  }
 }

