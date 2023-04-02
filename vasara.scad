// vasara
hammerlength=60;
hammerdiameter=20;
hammerposition=30;
hammerheadlength=10;
hammerheadpartdiameter=10;
hammerheadedge=10;
hammerpulldiameter=5;
hammerpulllength=hammerdiameter+10;
hammerpullposition=hammerpulldiameter/2;
casediameter=30;
caseinsidediameter=23;
handlediameter=40;
motorheight=40.8;
motorwidth=42;
motortopdiameter=25;
motortopheight=3.1;
motorholediameter=10;
motorholediameterdepth=2.8;
motoraxleheight=motortopheight+19.33;
motoraxlediameter=5;
motordiameter=51.73;
pulldiskdiameter=hammerposition*2+hammerpulldiameter*4;
pulldiskthickness=hammerpulldiameter*2;
springloadedposition=10;

$fn=90;

module bldcmotor() {
  intersection() {
    union() {
      difference() {
	union () {
	  cube([motorwidth,motorwidth,motorheight]);
	  translate([motorwidth/2,motorwidth/2,motorheight-0.01]) cylinder(h=motortopheight+0.01,d=motortopdiameter);
	}
	translate([motorwidth/2,motorwidth/2,motorheight+motortopheight-motorholediameterdepth]) cylinder(h=motorholediameterdepth+1,d=motorholediameter);
      }
      translate([motorwidth/2,motorwidth/2,motorheight-0.01]) cylinder(h=motoraxleheight+0.01,d=motoraxlediameter);
    }
    translate([motorwidth/2,motorwidth/2,-0.01]) cylinder(h=motorheight+motoraxleheight+1,d=motordiameter);
  }
}

module hammer() {
  union() {
    cylinder(h=hammerlength,d=hammerdiameter+0.01);
    hull() {
      translate([hammerheadedge/2,hammerheadedge/2,hammerlength])
	cylinder(h=hammerheadlength,d=hammerheadpartdiameter);
      translate([-hammerheadedge/2,-hammerheadedge/2,hammerlength])
	cylinder(h=hammerheadlength,d=hammerheadpartdiameter);
      translate([-hammerheadedge/2,hammerheadedge/2,hammerlength])
	cylinder(h=hammerheadlength,d=hammerheadpartdiameter);
      translate([hammerheadedge/2,-hammerheadedge/2,hammerlength])
	cylinder(h=hammerheadlength,d=hammerheadpartdiameter);
      translate([0,0,hammerlength-hammerheadlength]) cylinder(h=hammerheadlength,d=hammerheadpartdiameter);
    }
    translate([0,0,hammerpullposition]) rotate([90,0,0]) cylinder(h=hammerpulllength,d=hammerpulldiameter,center=true);
  }
}

// bldcmotor();

translate([0,-hammerposition,0])
rotate([90,0,0]) hammer();
      

translate([0,hammerposition,0])
rotate([-90,0,0]) hammer();

//hammer();

difference() {
  translate([0,0,-hammerdiameter]) cylinder(h=pulldiskthickness,d=pulldiskdiameter);
  hull() {
    translate([0,hammerposition+hammerpulldiameter/2,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
    translate([-springloadedposition,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
  }
  hull() {
    translate([-springloadedposition,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
    translate([-hammerposition-hammerpulldiameter/2,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
  }
  intersection() {
    translate([0,0,-hammerdiameter+pulldiskthickness/2]) cube([pulldiskdiameter+0.01,pulldiskdiameter+0.01,pulldiskthickness/2+0.01]);
    translate([0,0,-hammerdiameter+pulldiskthickness/2]) cylinder(d=pulldiskdiameter+0.01,h=pulldiskthickness/2+0.01);
  }
  
  hull() {
    translate([0,-hammerposition-hammerpulldiameter/2,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
    translate([springloadedposition,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
  }
  hull() {
    translate([springloadedposition,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
    translate([hammerposition+hammerpulldiameter/2,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2+0.01,d=hammerpulldiameter+1);
  }
}

//translate([0,0,-hammerdiameter+pulldiskthickness/2]) cylinder(h=pulldiskthickness/2,d=pulldiskdiameter);

