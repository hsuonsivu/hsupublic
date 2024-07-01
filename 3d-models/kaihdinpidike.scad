// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// 1=holder 2=plastic ring for hole 3=both 4=test set of holders with
// different diameters
print=4;

use <hsu.scad>

$fn=90;

strong=0;

ruuvioutd=12.65;
ruuvireika=3.5;//3.2;
lfromreika=13.2;
paksuus=3.5;
pidikepaksuus=4.2;
pidikew=9.8;
pidikereikah=13.32;
pidikereikad=6; // 5.4;
pidikereikaopeningld=5;//3.2;
pidikereikaopeninghd=pidikereikad+1;
pidikereikaopningh=20.3;
pidikeh=19.63;
cornerd=1;
tukiw=ruuvioutd-cornerd-1;
tukih=5; // on top of thicknesses

module kaihdinpidike(adjust) {
  difference() {
    union() {
      hull() {
	cylinder(h=paksuus, d=ruuvioutd);
	translate([lfromreika-pidikepaksuus,-ruuvioutd/2,0]) roundedbox(pidikepaksuus,ruuvioutd,paksuus,cornerd);
      }

      hull() {
	translate([lfromreika-pidikepaksuus-tukih,-tukiw/2,0]) roundedbox(pidikepaksuus,tukiw,paksuus,cornerd);
	translate([lfromreika-pidikepaksuus,-tukiw/2,0]) roundedbox(pidikepaksuus,tukiw,paksuus+tukih,cornerd);
      }

      hull() {
	translate([lfromreika-pidikepaksuus,-ruuvioutd/2,0]) roundedbox(pidikepaksuus,ruuvioutd,paksuus,cornerd);
	translate([lfromreika-pidikepaksuus,-(pidikew+adjust)/2,pidikeh-1]) roundedbox(pidikepaksuus,pidikew+adjust,1,cornerd);
      }
    }

    translate([0,0,-0.01]) ruuvireika(paksuus+0.02,ruuvireika,1);

    translate([lfromreika-pidikepaksuus,0,pidikereikah]) rotate([0,90,0]) {
      translate([0,0,-0.01]) {
	cylinder(h=pidikepaksuus+0.02,d=pidikereikad+adjust);
	hull() {
	  cylinder(h=pidikepaksuus+0.02,d=pidikereikaopeningld+adjust);
	  translate([pidikereikaopeninghd-pidikereikah,0,0]) cylinder(h=pidikepaksuus+0.02,d=pidikereikaopeninghd+adjust);
	}
      }
    }
  }
}

suojaholkkimaxd=15;
suojaholkkitoph=2;
suojaholkkiholed=10;
suojaholkkiind=11.6;
//suojaholkkiinw=(suojaholkkiind-suojaholkkid)/2;
suojaholkkiinh=6;

module suojaholkki() {
  difference() {
    union() {
      cylinder(d=suojaholkkimaxd,h=suojaholkkitoph);
      translate([0,0,suojaholkkitoph-0.01]) cylinder(d=suojaholkkiind,h=suojaholkkiinh+0.01);
    }

    translate([0,0,-0.01]) cylinder(d=suojaholkkiholed,h=suojaholkkitoph+suojaholkkiinh+0.02);
  }
}

if (print==1) kaihdinpidike(0);

if (print==2) suojaholkki();

if (print==3) {
  kaihdinpidike(0);
  translate([lfromreika+1+suojaholkkimaxd/2,0,0]) suojaholkki();
 }

if (print==4) {
  for (adjust=[[0,-0.5],[1,0],[2,0.5],[3,1]]) {
    echo(adjust[0], adjust[1]);
    translate([0,adjust[0]*(ruuvioutd+1),0]) kaihdinpidike(adjust[1]);
  }
 }
