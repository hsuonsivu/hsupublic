// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

tolpat44=0;

kattokulma=20;
vajatakah=2000;
vajaw=1020;
vajal=1230;
vajakattoextend=300;
vajaetuh=vajatakah+sin(kattokulma)*vajal;

nelonen=100;
kakkonen=50;

sivutukiangle=atan((vajal-nelonen)/(vajatakah-nelonen*4));
takatukiangle=atan((vajaw)/(vajatakah-nelonen*5));

vajaoutw=tolpat44?nelonen+vajaw+nelonen:kakkonen+vajaw+kakkonen;

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
    translate([nelonen,-vajaoutw/2,nelonen]) rotate([0,sivutukiangle,0]) rotate([0,0,90]) kakkosnelonen((vajatakah-nelonen*4)/cos(sivutukiangle)+nelonen/tan(sivutukiangle));
    translate([nelonen,-vajaoutw/2,nelonen]) cube([vajal-nelonen,vajaoutw,vajatakah-nelonen]);
  }
}

module takavinotuki() {
  x=vajal+(tolpat44?nelonen:kakkonen);
  render() color("blue") intersection() {
    translate([x,vajaw/2,nelonen]) rotate([takatukiangle,0,0]) rotate([0,0,0]) kakkosnelonen((vajatakah-nelonen*5)/cos(takatukiangle)+nelonen/tan(takatukiangle));
    translate([x,-vajaw/2,nelonen]) cube([kakkonen,vajaw,vajatakah-nelonen]);
  }
}

module halkovaja() {
  for (m=[0,1]) mirror([0,m,0]) {
      // Front verticals
      translate([0,-vajaw/2-(tolpat44?nelonen:0),0]) if (tolpat44) neljanelonen(vajaetuh); else rotate([0,0,-90]) kakkosnelonen(vajaetuh);
      // Back verticals
      translate([vajal,-vajaw/2-(tolpat44?nelonen:0),0]) if (tolpat44) neljanelonen(vajatakah); else rotate([0,0,-90]) kakkosnelonen(vajatakah);
      // Side bottom
      color("red") translate([kakkonen,-vajaw/2,0]) rotate([90,0,90]) kakkosnelonen(vajal);
      // Top bottom
      color("red") translate([0,-vajaw/2,vajatakah-nelonen*2]) rotate([90,0,90]) kakkosnelonen(vajal+nelonen);
      // Vinotuet
      sivuvinotuki();
    }
  takavinotuki();
  color("green") translate([0,-vajaw/2,nelonen]) rotate([-90,0,0]) kakkosnelonen(vajaw);
  color("green") translate([vajal+kakkonen,-vajaw/2,nelonen]) rotate([-90,0,0]) kakkosnelonen(vajaw);
  color("green") translate([vajal-kakkonen,-vajaoutw/2,vajatakah]) rotate([-90,0,0]) kakkosnelonen(vajaoutw);
  color("green") translate([-kakkonen,-vajaoutw/2,vajaetuh]) rotate([-90,0,0]) kakkosnelonen(vajaoutw);
}

halkovaja();



