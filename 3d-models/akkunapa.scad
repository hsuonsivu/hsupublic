print=3;

$fn=180;

plustopd=17.8; //17.6;
pluslowd=19.2; //19.4; //19.22;
plush=18.55;

miinustopd=16.4; //16.1;
miinuslowd=17.8; //17.79;
miinush=plush;

brim=8;
wall=2;

textdepth=1;

module plusnapa() {
  difference() {
    union() {
      cylinder(h=plush+wall,d2=plustopd+wall*2,d1=pluslowd+wall*2);
      hull() {
	cylinder(h=wall,d=pluslowd+wall+brim);
	cylinder(h=plush,d=plush/2);
      }
      hull() {
	translate([0,0,plush]) cylinder(h=wall,d=plustopd+wall+brim);
	cylinder(h=plush,d=plush/2);
      }
    }

    translate([0,0,-0.01]) cylinder(h=plush,d2=plustopd,d1=pluslowd);
    translate([0,0,plush+wall-textdepth+0.01]) linear_extrude(height=textdepth) text("+",size=plustopd+2*wall,halign="center",valign="center");
  }
}

module miinusnapa() {
  difference() {
    union() {
      cylinder(h=miinush+wall,d2=miinustopd+wall*2,d1=miinuslowd+wall*2);
      hull() {
	cylinder(h=wall,d=miinuslowd+wall+brim);
	cylinder(h=miinush,d=miinush/2);
      }
      hull() {
	translate([0,0,miinush]) cylinder(h=wall,d=miinustopd+wall+brim);
	cylinder(h=miinush,d=miinush/2);
      }
    }

    translate([0,0,-0.01]) cylinder(h=miinush,d2=miinustopd,d1=miinuslowd);
    translate([0,0,miinush+wall-textdepth+0.01]) linear_extrude(height=textdepth) text("-",size=miinustopd+2*wall,halign="center",valign="center");
  }
}

if (print==0) {
  plusnapa();
  translate([(pluslowd+miinuslowd+2*wall+brim*2)/2+1,0,0]) miinusnapa();
 }

if (print==1) {
  rotate([180,0,0]) plusnapa();
 }

if (print==2) {
  rotate([180,0,0]) miinusnapa();
 }

if (print==3) rotate([180,0,0]){
  plusnapa();
  translate([(pluslowd+miinuslowd+2*wall+brim*2)/2+1,0,0]) miinusnapa();
 }

