// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

kulmad=14;
kulmatopd=11;
reunal=42;
reunah=12;
reunaw=10;
reunad=10;
reunatopd=6;
rakobottomw=2.2;
rakotopw=2.1;
rakoheight=3;
rakocornerbottomw=3.1;
rakocornertopw=3;
cornerd=2;
baseh=2.5;
endx=reunal-kulmad/2-reunad/2;

module hyllynjalka() {
  difference() {
    union() {
      hull() {
	for (m=[0,1]) mirror([m,m,0]) {
	    roundedcylinder(kulmad,baseh,cornerd,1,90);
	    translate([endx,0,0]) roundedcylinder(reunad,baseh,cornerd,1,90);
	  }
	}
  
      for (m=[0,1]) mirror([m,m,0]) {
	  hull() {
	    roundedcylinder(kulmad,baseh,cornerd,1,90);
	    translate([0,0,reunah-cornerd]) roundedcylinder(kulmatopd,cornerd,cornerd,1,90);
	    translate([endx,0,0]) roundedcylinder(reunad,baseh,cornerd,1,90);
	    translate([endx,0,0]) roundedcylinder(reunatopd,reunah,cornerd,1,90);
	  }
	}
    }

    for (m=[0,1]) mirror([m,m,0]) {
	// Kulmalaajennus
	hull() {
	  translate([0,0,rakoheight]) roundedcylinder(rakocornerbottomw,cornerd,cornerd,0,90);
	  translate([0,0,reunah]) roundedcylinder(rakocornertopw,cornerd,cornerd,0,90);
	  translate([kulmad/2,0,rakoheight]) roundedcylinder(rakobottomw,cornerd,cornerd,0,90);
	  translate([kulmad/2,0,reunah]) roundedcylinder(rakotopw,cornerd,cornerd,0,90);
	}
	
	// Rako
	hull() {
	  translate([0,0,rakoheight]) roundedcylinder(rakobottomw,cornerd,cornerd,0,90);
	  translate([0,0,reunah]) roundedcylinder(rakotopw,cornerd,cornerd,0,90);
	  translate([endx+reunad,0,rakoheight]) roundedcylinder(rakobottomw,cornerd,cornerd,0,90);
	  translate([endx+reunad,0,reunah]) roundedcylinder(rakotopw,cornerd,cornerd,0,90);
	}
      }
  }
}


hyllynjalka();

