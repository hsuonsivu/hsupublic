
$fn=90;

final=1 ;

handledepth=35;
handlescrewnutdiameter=15.6;
handlescrewholediameter=8.7;
handlenutheight=10; // should be 6.2;
handlex=94.64; // 90+handlescrewholediameter/2;
handley=71.5; // 71.93; 71.49; 71.45; 71.56;

coverthickness=3.25;

handlexoffset=5;
handlexwidth=60;
handleheight=43;
handleywidth=21;
handleupperz=20;
handleywidthbase=18;
handleywidthtop=11;

extraholex=24; // 25.4; // 21.36 + 8/2 = 25.36; 21.5 + 8 / 2 = 25.5;
extraholey=106.7;
extraholediameter=8;

supportxwidth=100;
supportywidth=80;
supportthickness=7;
supportbasediameter=30;

headaxlediameter=8.5;
headaxlex= 43; // 44.99// 48-headaxlediameter/2; // 44.99; // 42.7 + 4.5 / 2 = 44.95; 42.66 + 4.5 / 2; 45.2
headaxley= 51.8; // 55.71-headaxlediameter/2; // 52.1; // 50.11 + 4.5 / 2;
diskaxlediameter=12.7;
diskaxlex=128.5; // 134.64 -12.28/2; // 128.5;  // 126.69 + 4.5/2; // 128.755; 128.45;
diskaxley=71.32; // 69.68;  // 76.4-diskaxlediameter/2; // 69.68 // 71.32;
diskdiameter=130;
axleholebelow=6;
axleholebelownarrowing=3;
axleholewall=2;
axleholewalllow=1;
belowthickness=2;
axlerecess=0.5;
axlerecessdiameter=12.9;
headaxlerecesslow=-0.7;
headaxlerecessheight=belowthickness-headaxlerecesslow-axlerecess;
diskaxlerecesslow=1.2;
diskaxlerecessheight=belowthickness-diskaxlerecesslow-axlerecess;

secondaryscrewholediameter=3.75;
secondaryscrewbasediameter=8.5;
secondaryscrewbasez=7.38;

handlescrewused = supportthickness+belowthickness+coverthickness;
handleholedepth = 21.63 - handlescrewused;

difference() {
  union() {
    linear_extrude(height=belowthickness,center=false) polygon(points=[[4.5,11.3],[13,2.8],[60.3,2.8],[60.3,20.25],[102,20.25],[120,5.5],[161,5.5],[160,13],[188,44.8],[200,44.8],[200,diskaxley],[185,110],[105,135],[61,135],[61,139],[30.4,139],[30.4,112],[4.5,112],[4.5,66.6],[6.2,66.6],[6.2,54.5],[4.5,54.5],[4.5,11.3]]);
    translate([diskaxlex,diskaxley,0]) cylinder(h=belowthickness,d=diskdiameter);
    intersection() {
      translate([diskaxlex,diskaxley,0]) cube([(200-diskaxlex)*2,diskdiameter,belowthickness]);
      translate([diskaxlex,diskaxley,0]) resize(newsize=[(199.5-diskaxlex)*2,diskdiameter,belowthickness]) cylinder(h=belowthickness,d=diskdiameter);
    }
    translate([headaxlex,headaxley,-axleholebelow]) cylinder(h=belowthickness+axleholebelow,d=headaxlediameter+2*axleholewall);
    translate([diskaxlex,diskaxley,-axleholebelow]) cylinder(h=belowthickness+axleholebelow,d=diskaxlediameter+2*axleholewall);

    translate([handlex,handley,-supportthickness]) hull() {
      translate([0,0,0]) cylinder(h=supportthickness,d=supportbasediameter);
      translate([-supportxwidth/2,-supportywidth/2,supportthickness]) cylinder(h=belowthickness, d=3);
      translate([-supportxwidth/2,supportywidth/2,supportthickness]) cylinder(h=belowthickness, d=3);
      translate([supportxwidth/2,-supportywidth/2,supportthickness]) cylinder(h=belowthickness, d=3);
      translate([supportxwidth/2,supportywidth/2,supportthickness]) cylinder(h=belowthickness, d=3);
    }
  }

  translate([headaxlex,headaxley,-axleholebelow+axleholebelownarrowing-0.01]) cylinder(h=belowthickness+axleholebelow,d=headaxlediameter);
  translate([headaxlex,headaxley,-axleholebelow-0.01]) cylinder(h=axleholebelownarrowing+0.02,d1=headaxlediameter+2*axleholewalllow,d2=headaxlediameter);
  translate([headaxlex,headaxley,belowthickness-axlerecess]) cylinder(h=axlerecess+0.01,d=axlerecessdiameter);
  translate([headaxlex,headaxley,headaxlerecesslow]) cylinder(h=headaxlerecessheight+0.01,d1=headaxlediameter,d2=axlerecessdiameter);

  translate([diskaxlex,diskaxley,-axleholebelow-0.01]) cylinder(h=axleholebelownarrowing+0.02,d1=diskaxlediameter+2*axleholewalllow,d2=diskaxlediameter);
  translate([diskaxlex,diskaxley,-axleholebelow+axleholebelownarrowing-0.01]) cylinder(h=belowthickness+axleholebelow,d=diskaxlediameter);
  translate([diskaxlex,diskaxley,belowthickness-axlerecess]) cylinder(h=axlerecess+0.1,d=axlerecessdiameter);
  translate([diskaxlex,diskaxley,diskaxlerecesslow]) cylinder(h=diskaxlerecessheight+0.01,d1=diskaxlediameter,d2=axlerecessdiameter);

  translate([handlex,handley,-supportthickness-0.01]) cylinder(h=belowthickness+supportthickness+1, d=handlescrewholediameter);

  if (final) {
    for (i=[1:1.5:9]) {
      difference() {
	translate([handlex,handley,-supportthickness+0.5]) cylinder(h=belowthickness+supportthickness-1.2, d=handlescrewholediameter+i+0.06, $fn=36);
	translate([handlex,handley,-supportthickness+0.5]) cylinder(h=belowthickness+supportthickness-1.2, d=handlescrewholediameter+i, $fn=36);
      }
    }
  }
  
  translate([extraholex,extraholey,-0.01]) cylinder(h=belowthickness+1, d=extraholediameter);
}

if (0) {
  
translate([0,63,belowthickness*2+coverthickness]) rotate([180,0,0]) 
difference() {
  translate([handlex,handley,coverthickness + belowthickness]) union() {
    hull() {
      translate([-handlexwidth/2+handlexoffset,0,handleupperz]) sphere(d=handleywidth);
      translate([handlexwidth/2+handlexoffset,0,handleupperz]) sphere(d=handleywidth);
    }

    hull() {
      translate([-handlexwidth/2+handlexoffset,0,0]) sphere(d=handleywidthbase);
      translate([handlexwidth/2+handlexoffset,0,0]) sphere(d=handleywidthbase);
      translate([-handlexwidth/2+handlexoffset,0,handleupperz]) sphere(d=handleywidthtop);
      translate([handlexwidth/2+handlexoffset,0,handleupperz]) sphere(d=handleywidthtop);
    }
  }

  translate([handlex,handley,coverthickness + belowthickness - 0.01]) cylinder(h=coverthickness + belowthickness + handleupperz + handleywidth + 0.02, d=handlescrewholediameter);

  if (final) {
    for (i=[1:1.5:9]) {
      difference() {
	translate([handlex,handley,coverthickness + belowthickness + 0.5]) cylinder(h=handleholedepth, d=handlescrewholediameter+i+0.06,$fn=36);
	translate([handlex,handley,coverthickness + belowthickness + 0.5]) cylinder(h=handleholedepth, d=handlescrewholediameter+i, $fn=36);
	translate([handlex,handley,coverthickness + belowthickness + handleholedepth]) cylinder(h=handlenutheight, d=handlescrewnutdiameter+i+0.06, $fn=6);
	translate([handlex,handley,coverthickness + belowthickness + handleholedepth]) cylinder(h=handlenutheight, d=handlescrewnutdiameter+i, $fn=6);
      }
    }
  }
    
  translate([handlex,handley,coverthickness + belowthickness + handleholedepth]) cylinder(h=belowthickness+supportthickness+handleupperz+1, d=handlescrewnutdiameter, $fn=6);

  translate([diskaxlex,diskaxley,coverthickness + belowthickness - 0.01]) cylinder(h=handleupperz+handleywidth,d=secondaryscrewholediameter);

  if (final) {
    for (i=[1:1.5:6]) {
      difference() {
	translate([diskaxlex,diskaxley,coverthickness + belowthickness + 0.5]) cylinder(h=coverthickness+belowthickness+secondaryscrewbasez - 1, d=secondaryscrewholediameter+i+0.06, $fn=36);
	translate([diskaxlex,diskaxley,coverthickness + belowthickness + 0.5]) cylinder(h=coverthickness+belowthickness+secondaryscrewbasez - 1, d=secondaryscrewholediameter+i, $fn=36);
      }
    }
  }
  
  translate([diskaxlex,diskaxley,coverthickness+belowthickness+secondaryscrewbasez]) cylinder(h=handleupperz+handleywidth,d=secondaryscrewbasediameter);
  
  translate([handlex,handley,coverthickness + belowthickness]) translate([-handlexwidth+handlexoffset,-handleywidth/2,-handleywidthbase-belowthickness-coverthickness]) cube([handlexwidth*2,handleywidth,handleywidthbase+belowthickness+coverthickness]);
}



 }
