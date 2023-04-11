// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// One of our office plants was about to collapse and needed
// support. This is very specific to size of planter and plant.

$fn=360;
plantdiameter=55;
planthuggerdiameter=plantdiameter*1.3;
planthuggerthickness=50;

plantsupportdiameter=15;
plantsupportheight=160;
plantunderground=80;
plantbacksupport=76;

bucketthickness=9;
bucketdiameterinside=300-bucketthickness/2;
bucketdiameteroutside=bucketdiameterinside+bucketthickness;
  
edgesupportheight=70;
edgesupportthicknessinside=30;
edgesupportthicknessoutside=15;
edgetoplant=70;
edgesupporttopheight=4;
edgesupportoutsidethickness=1;
edgesupportbackheight=20;

edgesupportx=edgetoplant-plantsupportdiameter;
bucketxinside=edgetoplant-plantsupportdiameter/2;

edgecutx=plantsupportdiameter/2+25;

extrasupportdiameter=8;
extrasupportlength=30;

union() {
  cylinder(d=plantsupportdiameter,h=plantsupportheight);
  translate([0,0,-plantunderground+0.01]) cylinder(h=plantunderground,d1=3,d2=plantsupportdiameter);
  translate([-plantdiameter/2-plantsupportdiameter/2,0,plantsupportheight-planthuggerthickness]) difference() {
    cylinder(h=planthuggerthickness,d=planthuggerdiameter);
    translate([0,0,-0.01]) cylinder(d=plantdiameter,h=planthuggerthickness+0.02);
    translate([-plantsupportdiameter/2-planthuggerdiameter/2,-planthuggerdiameter/2 - 0.01,-0.01]) cube([planthuggerthickness+0.02,planthuggerdiameter + 0.02,planthuggerdiameter]);
  }

  difference() {
    translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight-edgesupportthicknessinside]) cylinder(h=edgesupportthicknessinside,d=bucketdiameterinside);
    translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight-edgesupportthicknessinside-0.01]) cylinder(h=edgesupportthicknessinside+1,d=bucketdiameterinside-bucketthickness);
    translate([-bucketdiameteroutside+edgecutx,-(bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness)/2,0])
      cube([bucketdiameteroutside,bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness,edgesupportheight+edgesupporttopheight+1]);
    //translate([-bucketdiameterinside+edgesupportx+plantsupportdiameter/2,-bucketdiameterinside/2,0]) cube([bucketdiameteroutside-edgesupportx,bucketdiameteroutside,edgesupportheight+0.01]);
  }

  difference() {
    translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight-edgesupportthicknessoutside]) cylinder(h=edgesupporttopheight+edgesupportthicknessoutside,d=bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness);
    translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight-edgesupportthicknessoutside-0.01]) cylinder(h=edgesupporttopheight+edgesupportthicknessoutside+1,d=bucketdiameterinside-bucketthickness);
    translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight-edgesupportthicknessoutside-0.01]) cylinder(h=edgesupportthicknessoutside,d=bucketdiameteroutside);
    translate([-bucketdiameteroutside+edgecutx,-(bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness)/2-0.01,0])
      cube([bucketdiameteroutside,bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness+0.02,edgesupportheight+edgesupporttopheight+1]);
  }

  difference() {
    hull() {
      difference() {
	translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight]) cylinder(h=edgesupporttopheight,d=bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness);
        translate([-bucketdiameteroutside+edgecutx,-(bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness)/2-0.01,0])
        cube([bucketdiameteroutside,bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness+0.02,edgesupportheight+edgesupporttopheight+1]);
      }
      translate([extrasupportlength,0,plantsupportheight-edgesupporttopheight]) cylinder(h=edgesupporttopheight,d=extrasupportdiameter);
    }
    hull() {
      difference() {
	translate([edgesupportx+plantsupportdiameter/2-bucketdiameterinside/2,0,edgesupportheight-0.01]) cylinder(h=edgesupporttopheight,d=bucketdiameterinside-bucketthickness);
        translate([-bucketdiameteroutside+edgecutx-1,-(bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness)/2-0.01,0])
        cube([bucketdiameteroutside,bucketdiameteroutside+bucketthickness+edgesupportoutsidethickness+1.02,edgesupportheight+edgesupporttopheight+1]);
      }
      translate([extrasupportlength-1,0,plantsupportheight-edgesupporttopheight]) cylinder(h=edgesupporttopheight-3,d=extrasupportdiameter);
    }
  }

  hull() {
    translate([0,0,plantsupportheight-1]) cylinder(h=1,d=extrasupportdiameter);
    translate([extrasupportlength,0,plantsupportheight-1]) cylinder(h=1,d=extrasupportdiameter);
    translate([0,0,plantsupportheight-planthuggerthickness]) sphere(d=extrasupportdiameter);
    translate([extrasupportlength+extrasupportlength*planthuggerthickness/(plantsupportheight-edgesupportheight),0,plantsupportheight-planthuggerthickness]) sphere(d=extrasupportdiameter);
  }

if (0) {
  hull() {
    translate([0,0,edgesupportheight]) cylinder(h=edgesupporttopheight,d=plantsupportdiameter);
    translate([0,0,plantsupportheight-edgesupporttopheight]) cylinder(h=edgesupporttopheight,d=plantsupportdiameter);
    translate([edgesupportx,-edgesupportx,edgesupportheight]) cylinder(h=edgesupporttopheight,d=plantsupportdiameter);
    translate([edgesupportx,edgesupportx,edgesupportheight]) cylinder(h=edgesupporttopheight,d=plantsupportdiameter);
  }
 }
}
