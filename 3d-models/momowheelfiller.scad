totalheight=80; // 83-8.47; // was 89
screwheight=40; // 44.69;
insideholediametertop=12.2; // 11.65;
insidetowerdiametertop=insideholediametertop+1;
insideholediameterbottom=15;
insidetowerdiameterbottom=insideholediameterbottom+1.5;
screwholediameter=7;
screwtowerdiametertop=screwholediameter+0.8; // was +1
screwtowerdiameterbottom=screwholediameter+1; // was +1
screwdiameter=4.5;
screwholeradius=13.5;
screwholeheight=42;
bottomsupportheight=screwholeheight;

$fn=360;

difference() {
union() {
cylinder(h=bottomsupportheight,r1=screwholeradius-2,r2=screwholeradius-screwholediameter);

cylinder(h=totalheight,d1=insidetowerdiameterbottom,d2=insidetowerdiametertop);

rotate([0,0,0]) translate([screwholeradius,0,0]) union() {
  cylinder(h=screwholeheight,d1=screwtowerdiameterbottom,d2=screwtowerdiametertop);
  translate([-screwholeradius,-screwtowerdiametertop/2,0]) cube([screwholeradius,screwtowerdiametertop,screwholeheight]);
  }
rotate([0,0,120]) 
  translate([screwholeradius,0,0]) union() {
  cylinder(h=screwholeheight,d1=screwtowerdiameterbottom,d2=screwtowerdiametertop);
  translate([-screwholeradius,-screwtowerdiametertop/2,0]) cube([screwholeradius,screwtowerdiametertop,screwholeheight]);
  };
rotate([0,0,240]) 
  translate([screwholeradius,0,0]) union() {
  cylinder(h=screwholeheight,d1=screwtowerdiameterbottom,d2=screwtowerdiametertop);
  translate([-screwholeradius,-screwtowerdiametertop/2,0]) cube([screwholeradius,screwtowerdiametertop,screwholeheight]);
  };
}
translate([0,0,-0.1]) cylinder(h=totalheight+0.2,d1=insideholediameterbottom,d2=insideholediametertop);

translate([screwholeradius,0,-1]) cylinder(h=screwholeheight+0.2,d=screwholediameter);
rotate([0,0,120]) translate([screwholeradius,0,-1]) cylinder(h=screwholeheight+0.2,d=screwholediameter);
rotate([0,0,240]) translate([screwholeradius,0,-1]) cylinder(h=screwholeheight+0.2,d=screwholediameter);

translate([screwholeradius,0,-0.1]) cylinder(h=screwholeheight+0.2,d=screwdiameter);
rotate([0,0,120]) translate([screwholeradius,0,-0.1]) cylinder(h=screwholeheight+0.2,d=screwdiameter);
rotate([0,0,240]) translate([screwholeradius,0,-0.1]) cylinder(h=screwholeheight+0.2,d=screwdiameter);
}

