// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=2;

suihkuletkud=print==2?14:14;
suihkuletkuh=100;
suihkupaaconnect1d=21.3;
suihkupaaconnect2d=24; // measured? 23.3;
suihkupaaconnectl=30;
suihkupaabodyd=print==2?28:24;
suihkupaal=200; // Not measured, guess
suihkupaaheight=-10-2+8;
letkutolerance=1;

foo=12+2;
tukil=50-12+foo;
tukiind=print==2?32:28;
tukiinlowd=print==2?27:26;
tukioutd=tukiind+4;
tukioutoffset=4;
tukiinterfaced=28;
tukiinterfaceoffset=tukiind/2-9;
tukiinterfacel=14; // Not measured, guess
tukiinterfaceheight=5-12; // Not measured, guess
tukiheight=-10;

pidikeheight=-15;
pidikedtolerance=1;
pidikel=tukil+10;
pidiketopsupporth=5+foo;
pidikesupporth=pidikel-6+12;
pidikewall=3;
pidikeflangeh=0;
pidikeflangewall=pidikewall+2;

pidikereunaw=suihkuletkud+3;
pidikereunastart=0;
pidikereunah=pidikel;
pidikereunal=tukiind/2+0.5;

cornerd=0.5;

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
            scale([1,26/27,1]) cylinder(d2=tukiind,d1=tukiinlowd,h=pidikel);
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
		translate([-tukioutoffset,tukiinterfaceoffset,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced+pidikewall,h=tukiinterfacel+pidikeflangeh);
		translate([-tukioutoffset,tukiinterfaceoffset+tukiinterfacel,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced+pidikewall+pidikeflangewall,h=pidikeflangeh);
	      }
	      translate([-tukioutoffset-tukiinterfaced-4,tukiinterfaceoffset,tukiinterfaceheight+tukiinterfaced/2-pidikewall]) cube([tukiinterfaced+pidikewall,tukiinterfaced/2,tukiinterfaced+pidikewall*2]);
	    }
	    translate([-tukioutoffset,0,0]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidikesupporth);
	  }
	}
	translate([-tukioutoffset,0,pidikel-pidikesupporth-0.01]) scale([0.95,1.15,1]) cylinder(d=tukioutd,h=pidikesupporth+0.01);
	translate([0,0,tukiheight-pidikeheight]) difference() {
	  hull() {
	    translate([-tukioutoffset,0,tukiinterfaceheight+tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced,h=tukiind/2+tukiinterfacel+pidikeflangeh+0.01);
	    translate([-tukioutoffset,0,-tukiinterfaced/2]) rotate([-90,0,0]) cylinder(d=tukiinterfaced,h=tukiind/2+tukiinterfacel+pidikeflangeh+0.01);
	  }
	}
      }

      translate([0,-pidikereunaw/2,pidikereunastart]) roundedbox(pidikereunal,pidikereunaw,pidikereunah,cornerd);
    }
    translate([0,0,-pidikeheight+suihkupaaheight]) union() {
      hull() {
	translate([0,0,suihkupaaconnectl+(suihkupaaconnect1d+pidikedtolerance-suihkuletkud+pidikedtolerance)/2-0.01]) scale([26/27,1,1]) cylinder(d=suihkupaabodyd+pidikedtolerance,h=suihkupaal);
	intersection() {
	  translate([0,0,suihkupaaconnectl+(suihkupaaconnect1d+pidikedtolerance-suihkuletkud+pidikedtolerance)/2-(suihkupaabodyd-suihkupaaconnect2d)-0.01]) scale([26/27,1,1]) cylinder(d=suihkupaabodyd+pidikedtolerance,h=suihkupaal);
	  translate([0,0,(suihkupaaconnect1d+pidikedtolerance-suihkuletkud+pidikedtolerance)/2]) cylinder(h=suihkupaaconnectl,d1=suihkupaaconnect1d+pidikedtolerance,d2=suihkupaaconnect2d+pidikedtolerance);
	}
      
	//	#	translate([0,0,(suihkupaaconnect1d+pidikedtolerance-suihkuletkud+pidikedtolerance)/2-(suihkupaabodyd-suihkupaaconnect2d)]) cylinder(h=suihkupaabodyd-suihkupaaconnect2d,d1=suihkupaaconnect2d+pidikedtolerance,d2=suihkupaabodyd+pidikedtolerance);
      }
      translate([0,0,(suihkupaaconnect1d+pidikedtolerance-suihkuletkud+pidikedtolerance)/2]) cylinder(h=suihkupaaconnectl,d1=suihkupaaconnect1d+pidikedtolerance,d2=suihkupaaconnect2d+pidikedtolerance);
      translate([0,0,0]) cylinder(h=(suihkupaaconnect1d+pidikedtolerance-suihkuletkud+pidikedtolerance)/2+0.01,d1=suihkuletkud+pidikedtolerance,d2=suihkupaaconnect1d+pidikedtolerance);
      translate([0,0,-suihkuletkuh]) cylinder(d=suihkuletkud+pidikedtolerance,h=suihkuletkuh+0.01);
    }
    hull() {
      translate([0,0,-0.01]) cylinder(d=suihkuletkud+pidikedtolerance,h=pidikel-pidikeheight);
      translate([tukioutd/2,0,-0.01]) cylinder(d=suihkuletkud+pidikedtolerance,h=pidikel-pidikeheight);
    }

  }
}

//#translate([0,0,tukiheight]) oldpidike();
//#translate([0,0,suihkupaaheight]) suihkupaa();
translate([0,0,pidikel]) rotate([180,0,0]) pidike();
