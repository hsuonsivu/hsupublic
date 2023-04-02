levypaksuus=26; // poytalevyn paksuus
//kahvadiameter=30;
supportthickness=10;
kahvadiameter=levypaksuus+supportthickness;
kahvalength=180;
kahvax=40;
fingerspace=25;
kahvay=-fingerspace-kahvadiameter/2;
kahvaz=supportthickness-kahvadiameter/2;
supportlength=30;
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

$fn=90;

module ruuvikolo() {
  translate([0,0,ruuvibase]) cylinder(h=ruuvilength+kahvadiameter,d1=ruuvibasediameter,d2=ruuvibasediameter*1.2); // Ruuvin kolo
  translate([0,0,-0.01]) cylinder(h=ruuvilength+kahvadiameter,d=ruuviouterdiameter); // Ruuvin reika
  //translate([0,0,-cornerdiameter]) cylinder(h=ruuvilength+kahvadiameter,d=ruuviinnerdiameter); // Ruuvin porausohjausreika
}  

module kahvatuki() {
  difference() {
    hull() {
      translate([kahvax,kahvay,kahvaz]) sphere(kahvadiameter/2);
      translate([0,supporty-cornerdiameter/2,0]) sphere(d=cornerdiameter);
      translate([0,0,-levypaksuus+cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([supportlength,supporty-cornerdiameter/2,0]) sphere(d=cornerdiameter);
      translate([supportlength,0,-levypaksuus+cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([0,-supportthickness-cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([0,-supportthickness-cornerdiameter/2,-levypaksuus+cornerdiameter/2]) sphere(d=cornerdiameter);
      //translate([supportlength,-supportthickness-cornerdiameter/2,-levypaksuus+cornerdiameter/2]) sphere(d=cornerdiameter);
      //translate([supportlength,0,-levypaksuus+cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([0,supporty-cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
      translate([supportlength,supporty-cornerdiameter/2,supportthickness-cornerdiameter/2]) sphere(d=cornerdiameter);
    }

    translate([ruuvi1x,ruuvi1y,0]) ruuvikolo();
    translate([ruuvi2x,0,ruuvi2z]) rotate([90,0,0]) ruuvikolo();
    translate([ruuvi3x,0,ruuvi3z]) rotate([90,0,0]) ruuvikolo();
    
    translate([-cornerdiameter-0.01,0,-levypaksuus-0.01]) cube([kahvax+kahvadiameter/2,supporty+cornerdiameter,levypaksuus+0.01]);
  }
}

difference() {
  union() {
    translate([kahvax,kahvay,kahvaz]) rotate([0,90,0]) cylinder(h=kahvalength,d=kahvadiameter);
    kahvatuki();
    translate([kahvalength+kahvax*2,0,0]) mirror([1,0,0]) kahvatuki();
  }
}


