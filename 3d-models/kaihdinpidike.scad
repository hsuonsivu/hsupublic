include <hsu.scad>

$fn=90;

strong=0;

ruuvioutd=12.65;
ruuvireika=3.5;//3.2;
lfromreika=13.2;
paksuus=3.5;
pidikepaksuus=4.2;
pidikew=9.8;
pidikereikah=13.32;
pidikereikad=5.4;
pidikereikaopeningld=3.2;
pidikereikaopeninghd=5.2;
pidikereikaopningh=20.3;
pidikeh=19.63;
cornerd=1;
tukiw=ruuvioutd-cornerd-1;
tukih=5; // on top of thicknesses

module kaihdinpidike() {
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
	translate([lfromreika-pidikepaksuus,-pidikew/2,pidikeh-1]) roundedbox(pidikepaksuus,pidikew,1,cornerd);
      }
    }

    translate([0,0,-0.01]) ruuvireika(paksuus+0.02,ruuvireika,1);

    translate([lfromreika-pidikepaksuus,0,pidikereikah]) rotate([0,90,0]) {
      translate([0,0,-0.01]) {
	cylinder(h=pidikepaksuus+0.02,d=pidikereikad);
	hull() {
	  cylinder(h=pidikepaksuus+0.02,d=pidikereikaopeningld);
	  translate([pidikereikaopeninghd-pidikereikah,0,0]) cylinder(h=pidikepaksuus+0.02,d=pidikereikaopeninghd);
	}
      }
    }
  }
}

kaihdinpidike();
