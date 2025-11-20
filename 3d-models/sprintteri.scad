
include <hsu.scad>

cornerd=1;

boxl=40;
boxh=20;
boxw=21.7;
mirrorw=30;
boxcutw=21;
l=63;

boxheight=7.80;
boxx=-5;
alustaheight=4;
alustah=boxheight-alustaheight;

scalefactor=1;//10;  //304.8;

module sprinteroriginal() {
  render() import("sprinteroriginal.stl",convexity=10);
}

slicel=10;

module sprintterisliced() {
  translate([30,0,0]) scale([scalefactor,scalefactor,scalefactor]) for (x=[0:slicel:63]) {
    hull() {
      intersection() {
	translate([x,-boxw/2,0]) cube([slicel,boxw,boxheight+boxh]);
	rotate([0,0,90]) sprinteroriginal();
      }
    }
  }
}

module sprintteri() {
  intersection() {
    translate([0,-boxcutw/2,0]) cube([l,boxcutw,alustaheight+alustah+boxh]);
    hull() translate([30,0,0]) rotate([0,0,90]) sprinteroriginal();
  }
  intersection() {
    translate([47,-mirrorw/2,0]) cube([1,mirrorw,alustaheight+alustah+boxh]);
    hull() translate([30,0,0]) rotate([0,0,90]) sprinteroriginal();
  }
}

sprintteri();

if (1) hull() {
  scale([scalefactor,scalefactor,scalefactor]) translate([boxx,-boxw/2,boxheight]) roundedbox(boxl,boxw,boxh,cornerd);
  translate([boxx+alustah,-boxw/2+alustah,alustaheight]) roundedbox(boxl-alustah*2,boxw-alustah*2,alustaheight,cornerd);
  }
