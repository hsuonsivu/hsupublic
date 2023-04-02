pitch=5;
hole1=3.4;
hole2=2.36;
hole3=2.36;
hole4=3.4;
holepositionx=10+pitch/2;
ruuvireika=2.6;
mutterisyvennys=5.1;
mutterithickness=1.8;

depth=8;
thickness=8;
width=pitch*4+20;
ruuvireika1x=5;
ruuvireika2x=width-5;

difference() {
  cube([width,depth,thickness/2]);
  translate([ruuvireika1x,depth/2,-0.01]) cylinder(h=thickness+1,d=ruuvireika,$fn=60);
  translate([ruuvireika1x+0,depth/2,thickness/2-mutterithickness]) cylinder(h=mutterithickness+1,d=mutterisyvennys/cos(180/6),$fn=6);
  translate([ruuvireika2x,depth/2,-0.01]) cylinder(h=thickness+1,d=ruuvireika,$fn=60);
  translate([ruuvireika2x+0,depth/2,thickness/2-mutterithickness]) cylinder(h=mutterithickness+1,d=mutterisyvennys/cos(180/6),$fn=6);
  rotate(a=[90,0,0]) translate([holepositionx+0*pitch,0,-depth-0.01]) cylinder(h=depth+1,d=hole1,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+1*pitch,0,-depth-0.01]) cylinder(h=depth+1,d=hole2,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+2*pitch,0,-depth-0.01]) cylinder(h=depth+1,d=hole2,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+3*pitch,0,-depth-0.01]) cylinder(h=depth+1,d=hole1,$fn=60);
}

translate([0,depth+1,0]) difference() {
  cube([width,depth,thickness/2]);
  translate([ruuvireika1x,depth/2,-0.01]) cylinder(h=thickness+1,d=ruuvireika,$fn=60);
  translate([ruuvireika2x,depth/2,-0.01]) cylinder(h=thickness+1,d=ruuvireika,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+0*pitch,thickness/2,-depth-0.01]) cylinder(h=depth+1,d=hole1,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+1*pitch,thickness/2,-depth-0.01]) cylinder(h=depth+1,d=hole2,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+2*pitch,thickness/2,-depth-0.01]) cylinder(h=depth+1,d=hole2,$fn=60);
  rotate(a=[90,0,0]) translate([holepositionx+3*pitch,thickness/2,-depth-0.01]) cylinder(h=depth+1,d=hole1,$fn=60);
}

