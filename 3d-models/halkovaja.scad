// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO: make model parts for testing
// TODO: screwhole and end cut templates
// TODO: side covering strips
// TODO: center in x (allows mirroring screw holes)
include <hsu.scad>

tolpat44=0;

nelonen=100;
kakkonen=50;

laval=1230;
lavaw=1020;
lavah=120;
  
kattokulma=15;
vajatakah=2000;
vajaw=1020;
vajal=1230;
vajakattoextend=300;
vajaetuh=vajatakah+sin(kattokulma)*(-nelonen+vajal);

sivutukiangle=atan((-nelonen+vajal-nelonen)/(vajatakah-nelonen*4));
takatukiangle=atan((vajaw)/(vajatakah-nelonen*5));

vajaoutw=tolpat44?nelonen+vajaw+nelonen:kakkonen+vajaw+kakkonen;

right=0;
left=1;
forward=2;

ruuvirotatetable=[[0,-90,-90],
		  [0,-90,90],
		  [-90,0,-90]
		  ];


ruuvivara=3;
ruuvikakkonenkakkonen=kakkonen+kakkonen-ruuvivara;
ruuvitolppakakkonen=(tolpat44?nelonen:kakkonen)+kakkonen-ruuvivara;
ruuvinelonenkakkonen=nelonen+kakkonen-ruuvivara;

ruuvitaulu=[[-vajal/2+nelonen/3,-vajaoutw/2,nelonen/2,right,ruuvitolppakakkonen,0,1], // Tolpan reunasta
	    [-vajal/2+nelonen*2/3,-vajaoutw/2,nelonen/2,right,ruuvitolppakakkonen,0,1], 
	    [-vajal/2,-vajaw/2+kakkonen/2,nelonen*3/4,forward,ruuvikakkonenkakkonen,0,1], // Front bottom
	    [-vajal/2,-vajaw/2+kakkonen/2,nelonen/4,forward,ruuvikakkonenkakkonen,0,1],
	    [-vajal/2,-vajaw/2-kakkonen/2,nelonen+nelonen/sin(sivutukiangle)/2.5,forward,ruuvinelonenkakkonen,0,1], // Edesta vinotukeen
	    [-vajal/2,-vajaw/2-kakkonen/2,nelonen+nelonen/sin(sivutukiangle)*2/3,forward,ruuvinelonenkakkonen,0,1],
	    ];

ruuvid=5.5;  //M6
ruuvibased=ruuvid*2;

module lava() {
  roundedbox(laval,lavaw,lavah,10,1);
}

module ruuvireika(l) {
  translate([0,0,-0.01]) cylinder(d1=ruuvibased,d2=ruuvid,h=ruuvibased-ruuvid);
  translate([0,0,-0.01]) cylinder(d=ruuvid,h=l+0.01);
}

module screwholes() {
  for (i=[0:1:len(ruuvitaulu)-1]) {
    rotation=ruuvitaulu[i][3];
    for (m=[0,ruuvitaulu[i][6]]) mirror([0,m,0]) for (n=[0,ruuvitaulu[i][5]]) mirror([n,0,0]) translate([ruuvitaulu[i][0],ruuvitaulu[i][1],ruuvitaulu[i][2]]) rotate(ruuvirotatetable[rotation]) ruuvireika(ruuvitaulu[i][4]);
  }
}

module kakkosnelonen(l) {
  echo(str("kakkosnelonen(",l,")"));
  cube([kakkonen,nelonen,l]);
}

module neljanelonen(l) {
  echo(str("neljanelonen(",l,")"));
  cube([nelonen,nelonen,l]);
}

module rima(l) {
  cube([kakkonen,kakkonen,l]);
}

module sivuvinotuki() {
  render() color("blue") intersection() {
    translate([-vajal/2+nelonen,-vajaoutw/2,nelonen]) rotate([0,sivutukiangle,0]) rotate([0,0,90]) kakkosnelonen((vajatakah-nelonen*4)/cos(sivutukiangle)+nelonen/tan(sivutukiangle));
    translate([-vajal/2+nelonen,-vajaoutw/2,nelonen]) cube([-nelonen+vajal-nelonen,vajaoutw,vajatakah-nelonen]);
  }
}

module takavinotuki() {
  x=-vajal/2+vajal+(tolpat44?nelonen:-kakkonen);
  render() color("blue") intersection() {
    translate([x,vajaw/2,nelonen]) rotate([takatukiangle,0,0]) rotate([0,0,0]) kakkosnelonen((vajatakah-nelonen*5)/cos(takatukiangle)+nelonen/tan(takatukiangle));
    translate([x,-vajaw/2,nelonen]) cube([kakkonen,vajaw,vajatakah-nelonen]);
  }
}

module katto() {
  for (m=[0,1]) mirror([0,m,0]) {
      translate([-vajakattoextend-vajal-kakkonen,-vajaw/2,kakkonen]) rotate([0,90,0]) kakkosnelonen(vajakattoextend+vajal+vajakattoextend);
    }
  translate([-(vajal)/cos(kattokulma)-kakkonen/cos(kattokulma)-kakkonen,-vajaoutw/2,0]) rotate([-90,0,0]) kakkosnelonen(vajaoutw);
  translate([-(kakkonen)/cos(kattokulma)-nelonen-kakkonen,-vajaoutw/2,0]) rotate([-90,0,0]) kakkosnelonen(vajaoutw);
}

module halkovaja() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,m,0]) {
	  // Front verticals
	  translate([-vajal/2,-vajaw/2-(tolpat44?nelonen:0),0]) if (tolpat44) neljanelonen(vajaetuh); else rotate([0,0,-90]) kakkosnelonen(vajaetuh);
	  // Back verticals
	  translate([-vajal/2+vajal-nelonen,-vajaw/2-(tolpat44?nelonen:0),0]) if (tolpat44) neljanelonen(vajatakah); else rotate([0,0,-90]) kakkosnelonen(vajatakah);
	  // Side bottom
	  color("red") translate([-vajal/2+kakkonen,-vajaw/2,0]) rotate([90,0,90]) kakkosnelonen(vajal-nelonen);
	  // Side top
	  color("red") translate([-vajal/2,-vajaw/2,vajatakah-nelonen*2]) rotate([90,0,90]) kakkosnelonen(vajal);
	  // Vinotuet
	  sivuvinotuki();
	}
      takavinotuki();
      color("green") translate([-vajal/2,-vajaw/2,nelonen]) rotate([-90,0,0]) kakkosnelonen(vajaw);
      color("green") translate([vajal/2-kakkonen,-vajaw/2,nelonen]) rotate([-90,0,0]) kakkosnelonen(vajaw);
      color("green") translate([vajal/2-nelonen-kakkonen,-vajaoutw/2,vajatakah]) rotate([-90,0,0]) kakkosnelonen(vajaoutw);
      color("green") translate([-vajal/2-kakkonen,-vajaoutw/2,vajaetuh]) rotate([-90,0,0]) kakkosnelonen(vajaoutw);
    }
    screwholes();
  }
}

halkovaja();
translate([-vajal/2+vajal,0,vajatakah-sin(kattokulma)*(kakkonen+nelonen)]) rotate([0,kattokulma,0]) katto();
 translate([-vajal/2,-vajaw/2,nelonen]) %lava();
