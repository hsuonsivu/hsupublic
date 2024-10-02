// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

suihkuletkud=14;
suihkuletkuh=100;
suihkupaaconnect1d=21.3;
suihkupaaconnect2d=25; // measured? 23.3;
suihkupaaconnectl=30;
suihkupaabodyd=25;
suihkupaal=200; // Not measured, guess
suihkupaaheight=-10;
letkutolerance=1;

tukil=50;
tukiind=32;
tukioutd=37;
tukioutoffset=3;
tukiinterfaced=28;
tukiinterfacel=10; // Not measured, guess
tukiinterfaceheight=5; // Not measured, guess
tukiheight=-10;

pidikeheight=-15;
pidikedtolerance=1;
pidikel=tukil+10;
pidiketopsupporth=5;
pidikesupporth=pidikel-6;
pidikewall=3;
pidikeflangeh=1;
pidikeflangewall=pidikewall+2;
echo(pidiketopsupporth);
  
module suihkupaa() {
  translate([0,0,0]) cylinder(h=suihkupaaconnectl,d1=suihkupaaconnect1d,d2=suihkupaaconnect2d);
  translate([0,0,suihkupaaconnectl-0.01]) cylinder(d=suihkupaabodyd,h=suihkupaal);
  translate([0,0,-suihkuletkuh]) cylinder(d=suihkuletkud,h=suihkuletkuh);
}

module oldpidike() {
  difference() {
    translate([-tukioutoffset,0,0]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=tukil);
    translate([0,0,-0.01]) cylinder(d=tukiind,h=tukil+0.02);
  }
  translate([-tukioutoffset,tukiind/2,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced,h=tukiinterfacel);
}

module pidike() {
  difference() {
    union() {
      cylinder(d=tukiind,h=pidikel);
      hull() {
	translate([-tukioutoffset,0,pidikel-pidiketopsupporth]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidiketopsupporth);
	translate([-tukioutoffset-(tukioutd-tukiind),0,pidikel-pidiketopsupporth]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidiketopsupporth);
      }
      difference() {
	union() {
	  translate([-tukioutoffset-(tukioutd-tukiind),0,pidikel-pidikesupporth]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidikesupporth);
	  translate([0,0,tukiheight-pidikeheight]) difference() {
	    intersection() {
	      union() {
		translate([-tukioutoffset,tukiind/2,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced+pidikewall,h=tukiinterfacel+pidikeflangeh);
		translate([-tukioutoffset,tukiind/2+tukiinterfacel,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced+pidikewall+pidikeflangewall,h=pidikeflangeh);
	      }
	      translate([-tukioutoffset-tukiinterfaced-4,tukiind/2,tukiinterfaceheight-pidikewall]) cube([tukiinterfaced+pidikewall,tukiinterfaced/2,tukiinterfaced+pidikewall*2]);
	    }
	    translate([-tukioutoffset,0,0]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidikesupporth);
	  }
	}
	translate([-tukioutoffset,0,pidikel-pidikesupporth-0.01]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidikesupporth+0.01);
    translate([0,0,tukiheight-pidikeheight]) difference() {
      translate([-tukioutoffset,0,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced,h=tukiind/2+tukiinterfacel+pidikeflangeh+0.01);
    }
      }
    }
    translate([0,0,-pidikeheight+suihkupaaheight]) union() {
      translate([0,0,0]) cylinder(h=suihkupaaconnectl,d1=suihkupaaconnect1d+pidikedtolerance,d2=suihkupaaconnect2d+pidikedtolerance);
      translate([0,0,suihkupaaconnectl-0.01]) cylinder(d=suihkupaabodyd+pidikedtolerance,h=suihkupaal);
      translate([0,0,-suihkuletkuh]) cylinder(d=suihkuletkud+pidikedtolerance,h=suihkuletkuh);
    }
    hull() {
      translate([0,0,-suihkuletkuh]) cylinder(d=suihkuletkud+pidikedtolerance,h=suihkuletkuh);
      translate([tukioutd/2,0,-0.01]) cylinder(d=suihkuletkud+pidikedtolerance,h=pidikel*2);
    }

  }
}

//#translate([0,0,tukiheight]) oldpidike();
//#translate([0,0,suihkupaaheight]) suihkupaa();
translate([0,0,pidikeheight]) pidike();
