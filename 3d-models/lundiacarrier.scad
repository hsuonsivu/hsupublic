// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

levyleveys=296;
levypaksuus=20;

nauhawidth=32;
nauhathickness=3;
nauhacurvediameter=250;
//kahvadiameter=30;
supportthickness=15;
kahvadiameter=30; //levypaksuus+supportthickness;
kahvalength=200;
kahvax=40;
fingerspace=30;
kahvay=0; //-fingerspace-kahvadiameter/2;
kahvaz=fingerspace+kahvadiameter/2;
supportlength=65;
supporty=30;
cornerdiameter=5;
ruuvibase=10;
ruuviinnerdiameter=3.2;
ruuviouterdiameter=5;
ruuvibasediameter=11;
ruuvi1x=supportlength/2;
ruuvi1y=supporty-12;
ruuvilength=40;
ruuvi2x=ruuvibasediameter/2;
ruuvi2y=-10;
ruuvi2z=-levypaksuus/2-1;
ruuvi3x=supporty-ruuvibasediameter/2;
ruuvi3y=-10;
ruuvi3z=-levypaksuus/2;
nauhahardeningwidth=max(supportlength - 1,nauhawidth+1);

$fn=180;

module ruuvikolo() {
  translate([0,0,ruuvibase]) cylinder(h=ruuvilength+kahvadiameter,d1=ruuvibasediameter,d2=ruuvibasediameter*1.2); // Ruuvin kolo
  translate([0,0,-0.01]) cylinder(h=ruuvilength+kahvadiameter,d=ruuviouterdiameter); // Ruuvin reika
  //translate([0,0,-cornerdiameter]) cylinder(h=ruuvilength+kahvadiameter,d=ruuviinnerdiameter); // Ruuvin porausohjausreika
}  

module kahvatuki() {
  difference() {
    hull() {
      translate([kahvax,kahvay,kahvaz]) sphere(kahvadiameter/2);

      // bottom
      translate([cornerdiameter/2,supporty-cornerdiameter/2,0]) sphere(d=cornerdiameter);
      translate([supportlength-cornerdiameter/2,supporty-cornerdiameter/2,0]) sphere(d=cornerdiameter);
      translate([cornerdiameter/2,-supporty+cornerdiameter/2,0]) sphere(d=cornerdiameter);
      translate([supportlength-cornerdiameter/2,-supporty+cornerdiameter/2,0]) sphere(d=cornerdiameter);

      // medium
      if (0) {
      translate([cornerdiameter/2,supporty-cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([supportlength-cornerdiameter/2,supporty-cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([cornerdiameter/2,-supporty+cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([supportlength-cornerdiameter/2,-supporty+cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
      }
    }

    translate([-0.01,-supporty-0.01,-levypaksuus-0.01]) cube([supportlength+0.02,supporty*2+0.02,levypaksuus+0.01]);
    zet=sin(-acos(supporty/(nauhacurvediameter/2)))*nauhacurvediameter/2+supportthickness/2+1;
    translate([supportlength/2-nauhawidth/2,0,zet]) rotate([0,90,0]) difference() {
      cylinder(d=nauhacurvediameter,h=nauhawidth);
      translate([0,0,0]) cylinder(d=nauhacurvediameter-nauhathickness*2,h=nauhawidth);
    }

  for (i=[1:0.4:supportlength-1]) {
    translate([i,-(supporty-1),1]) cube([0.01,(supporty-1)*2,15]);
  }

  if (0) {
  #for (i=[1:0.4:15]) {
    translate([1,-(supporty-1),i]) cube([supportlength-2,(supporty-1)*2,0.01]);
  }
}
  
  if (0) {
    for (i=[-5:0.8:3]) {
      zetz=zet+1; //sin(-acos(supporty/((nauhacurvediameter+i)/2)))*(nauhacurvediameter+i)/2+supportthickness/2;
      translate([supportlength/2-nauhahardeningwidth/2,0,zetz]) rotate([0,90,0]) difference() {
	cylinder(d=nauhacurvediameter+i,h=nauhahardeningwidth);
	translate([0,0,0]) cylinder(d=nauhacurvediameter+i-0.01,h=nauhahardeningwidth);
	translate([-0.01,-supporty-0.01,0]) cube([supportlength+0.02,supporty*2+0.02,kahvaz+kahvadiameter]);
      }
    }
}
  }
}

difference() {
  union() {
    translate([kahvax,kahvay,kahvaz]) rotate([0,90,0]) cylinder(h=kahvalength,d=kahvadiameter);
    kahvatuki();
    translate([kahvalength+kahvax*2,0,0]) mirror([1,0,0]) kahvatuki();
  }
}


