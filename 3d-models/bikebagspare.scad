// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=print==0?1:0;
uselongerscrew=1;
fixw=1;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;

// Original bolt
screwl=uselongerscrew?28.6:23.77; // Including head
longerscrewldiff=screwl-23.77;
screwd=5.5;
boltheadd=7.8; // Hex
boltheadh=3.6;

screwextend=13.6;
boltheight=-screwextend;

bumpwheeld=26.21;
bumpwheelh=2.6+longerscrewldiff;

rootcutd=20;
rootcutdepth=7.5;
barrootangle=90;
barrootanglestep=5;

barcutd=length_and_depth_to_diameter(35,4);

allbumps=18;

bumpd=1.75;
bumps=4;// Times 2, 2 bumps between, opposite of bar
bumpringd=24.75-bumpd;
bumpstep=360/allbumps;

barw=fixw?bumpwheeld:20;
barendw=fixw?bumpwheeld:17;
barendh=3.4;
barxycornerd=5;
barendangle=27;
barendstep=1;

barl=55;
barh=4;
bartotalh=12.5;

handscrewd=26.5;
handscrewh=8.9;
handscrewboltsink=handscrewh-5.7;

cornerd=2;

module bar() {
  difference() {
    union() {
      translate([0,0,0]) roundedcylinder(bumpwheeld,bumpwheelh,cornerd,0,90);
      for (m=[0,1]) mirror([0,m,0]) for (a=[bumpstep+bumpstep/2:bumpstep:bumpstep*4.5]) rotate([0,0,a]) {
	    translate([-bumpringd/2,0,0]) sphere(d=bumpd,$fn=90);
      }

      translate([bumpwheeld/2+barl-barxycornerd,0,barcutd]) {
	for (a=[0:barendstep:barendangle-1]) {
	  w=barendw+a*(barw-barendw)/barendangle;
	  w2=barendw+(a+1)*(barw-barendw)/barendangle;
	  hull() {
	    rotate([0,a,0]) {
	      translate([0,-w/2,-barcutd]) roundedboxxyz(barxycornerd,w,barendh,barxycornerd,cornerd,0,90);
	    }
	    rotate([0,a+1,0]) {
	      translate([0,-w2/2,-barcutd]) roundedboxxyz(barxycornerd,w2,barendh,barxycornerd,cornerd,0,90);
	    }
	  }
	}
      }

      translate([bumpwheeld/2+rootcutd/2,0,0]) {
	for (a=[0:barrootanglestep:barrootangle]) {
	  hull() {
	    rotate([0,-a,0]) {
	      translate([0,-barw/2,bartotalh-barh]) roundedboxxyz(barxycornerd,barw,barendh,barxycornerd,cornerd,0,90);
	    }
	    rotate([0,-a+barrootanglestep,0]) {
	      translate([0,-barw/2,bartotalh-barh]) roundedboxxyz(barxycornerd,barw,barendh,barxycornerd,cornerd,0,90);
	    }
	  }
	}
      }

      hull() {
	translate([bumpwheeld/2+barl-barxycornerd,0,barcutd]) rotate([0,barendangle,0]) {
	  translate([0,-barw/2,-barcutd]) roundedboxxyz(barxycornerd,barw,barendh,barxycornerd,cornerd,0,90);
	}
	translate([bumpwheeld/2+rootcutd/2,0,0]) rotate([0,0,0]) {
	  translate([0,-barw/2,bartotalh-barh]) roundedboxxyz(barxycornerd,barw,barendh,barxycornerd,cornerd,0,90);
	}
      }

      hull() {
	intersection() {
	  union() {
	    hull() {
	      translate([bumpwheeld/2+rootcutd/2,0,0]) rotate([0,-barrootangle,0]) {
		translate([0,-barw/2,bartotalh-barh]) roundedboxxyz(barxycornerd,barw,barendh,barxycornerd,cornerd,0,90);
	      }
	      translate([bumpwheeld/2+rootcutd/2,0,0]) rotate([0,-barrootangle+barrootanglestep*4,0]) {
		translate([0,-barw/2,bartotalh-barh]) roundedboxxyz(barxycornerd,barw,barendh,barxycornerd,cornerd,0,90);
	      }
	    }
	    
	    translate([0,0,0]) roundedcylinder(bumpwheeld,bumpwheelh,cornerd,0,90);
	  }

	  translate([0,0,0]) roundedcylinder(bumpwheeld*2,barh*3,cornerd,0,90);
	  translate([fixw?0:bumpwheeld/4,-bumpwheeld/2,0]) cube([bumpwheeld,bumpwheeld,barh*3]);
	}
      }
    }

    translate([0,0,-0.01]) cylinder(d=screwd+dtolerance,h=bumpwheelh+0.02,$fn=90);

    translate([0,0,bumpwheelh]) cylinder(d=handscrewd+dtolerance,h=handscrewh+1,$fn=90);
  }
}

module handscrew() {
  difference() {
    translate([0,0,bumpwheelh+ztolerance]) roundedcylinder(handscrewd,handscrewh,cornerd,0,30);
    translate([0,0,bumpwheelh+ztolerance+handscrewboltsink]) cylinder(d=boltheadd/cos(180/6)+dtolerance,h=handscrewh,$fn=6);
  }
}

module bolt() {
  translate([0,0,boltheight]) cylinder(d=screwd,h=screwl,$fn=90);
  translate([0,0,boltheight+screwl-boltheadh]) cylinder(d=boltheadd/cos(180/6),h=boltheadh,$fn=6);
}

if (print==0) {
  intersection() {
    if (debug) translate([0,0,-100]) cube([100,100,200]);
    union() {
      difference() {
	union() {
	  bar();
	  handscrew();
	}

	#    bolt();
      }
    }
  }
 }

if (print==1) {
  translate([0,0,bumpwheeld/2]) rotate([90,0,90]) bar();
 }
