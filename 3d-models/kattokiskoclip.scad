// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=2; // 1 print one, 2 print multiple

adhesion=1;
adhesionl=0.25;
adhesionh=0.5;
adhesionw=0.5;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

wall=1.8;
cornerd=1;

kiskoopeningw=10.5;
kiskooutsidetopw=30;
kiskooutsidebottomw=20;
kiskothickness=2;
kiskoinsideheight=0; // Bottom of inside is 0
kiskoinsideh=29-kiskothickness-ztolerance;
echo(kiskoinsideh);
kiskoinsidetopw=kiskooutsidetopw-kiskothickness*2;
kiskoinsidebottomw=kiskooutsidebottomw-kiskothickness*2;
echo("kiskoinsidebottomw ",kiskoinsidebottomw);

kiskoclipl=25;
cabled=kiskoopeningw-wall*2;
cableslotd=cabled+wall*2;

topsidew=0.5;

pullclipw=wall;
pullclipopeningw=2;
pullcliph=5;
pullclipd=20;
pullclipout=3+kiskothickness;;
pullclipgrabh=wall;

module kiskoclip() {
  sidew=ytolerance+kiskoinsidebottomw/2-kiskoopeningw/2+ytolerance;
  for (m=[0,1]) mirror([0,m,0]) {
      difference() {
	union() {
	  translate([0,-kiskoopeningw/2-sidew+wall,0]) roundedbox(kiskoclipl,sidew,wall,cornerd,7);
	  hull() {
	    translate([0,-kiskoopeningw/2-sidew+wall,0]) roundedbox(kiskoclipl,wall,wall,cornerd,7);
	    translate([0,-kiskoopeningw/2,kiskoinsideh/2-wall]) roundedbox(kiskoclipl,wall,wall,cornerd,7);
	  }
	  translate([0,-kiskoopeningw/2,-kiskothickness]) roundedbox(kiskoclipl,wall,kiskothickness+wall,cornerd,7);

	  intersection() {
	    translate([kiskoclipl/2-pullclipd/2,-kiskoopeningw/2,-kiskothickness-pullclipout]) cube([pullclipd,wall,pullclipout+kiskothickness-wall+cornerd/2]);
	    translate([kiskoclipl/2,-kiskoopeningw/2,-kiskothickness-pullclipout+pullclipd/2]) rotate([-90,0,0]) roundedcylinder(pullclipd,wall,cornerd,0,90);
	  }

	  hull() {
	    intersection() {
	      translate([kiskoclipl/2-pullclipd/2,-kiskoopeningw/2,-kiskothickness-pullclipout]) cube([pullclipd,wall,pullclipgrabh*2]);
	      translate([kiskoclipl/2,-kiskoopeningw/2,-kiskothickness-pullclipout+pullclipd/2]) rotate([-90,0,0]) roundedcylinder(pullclipd,wall,cornerd,0,90);
	    }
	    intersection() {
	      translate([kiskoclipl/2-pullclipd/2,-kiskoopeningw/2-wall/2,-kiskothickness-pullclipout]) cube([pullclipd,wall*2,pullclipgrabh]);
	      translate([kiskoclipl/2,-kiskoopeningw/2-wall/2,-kiskothickness-pullclipout+pullclipd/2]) rotate([-90,0,0]) roundedcylinder(pullclipd,wall*2,cornerd,0,90);
	    }
	  }
	  translate([0,-kiskoopeningw/2,kiskoinsideh/2-wall]) roundedbox(kiskoclipl,wall,kiskoinsideh/2+wall,cornerd,7);
	  translate([0,-kiskoopeningw/2,kiskoinsideh-wall]) roundedbox(kiskoclipl,kiskooutsidebottomw/2-cabled/2+cornerd/2,wall,cornerd,7);
	  intersection() {
	    translate([0,-cabled/2-wall,kiskoinsideh-cabled/2-cableslotd/2]) cube([kiskoclipl,cabled/2+wall,cabled+wall-cornerd/2]);
	    hull() {
	      for (z=[0,cableslotd/2]) {
		translate([0,0,kiskoinsideh-cabled/2+z]) rotate([0,90,0]) roundedcylinder(cabled+wall*2,kiskoclipl,cornerd,1,90);
	      }
	    }
	  }

	  if (adhesion) {
	    for (x=[cornerd/2:2:kiskoclipl-adhesionl-cornerd/2]) {
	      translate([x,-kiskoopeningw/2+wall/2-adhesionw/2,kiskoinsideh-0.01]) cube([adhesionl,adhesionw,adhesionh]);
	    }
	  }

	  //translate([0,-kiskoopeningw/2,-pullcliph]) roundedbox(kiskoclipl,wall,kiskoinsideh+pullcliph,cornerd,7);
	}
	
	hull() {
	  for (z=[0,cabled/2]) {
	    translate([-0.01,0,kiskoinsideh-cabled/2+z]) rotate([0,90,0]) cylinder(d=cabled,h=kiskoclipl+0.02,$fn=90);
	  }
	}

	translate([-0.01,-kiskooutsidetopw/2,-pullcliph-0.01]) cube([0.01+cornerd/2,kiskooutsidetopw,kiskoinsideh+pullcliph+0.02]);

	
      }
    }
  
  if (0) if (adhesion) {for (x=[cornerd/2:2:kiskoclipl-adhesionl-cornerd/2]) {
      translate([x,-kiskoinsidebottomw/2+wall/2,wall/2]) cube([adhesionl,adhesionw,adhesionh]);
    }
  }
}

if (print==0) {
  kiskoclip();
 }

if (print==1) {
  translate([0,0,-cornerd/2]) rotate([0,-90,90]) kiskoclip();
 }

if (print==2) {
  for (n=[0,1]) mirror([n,0,0]) for (m=[0,1]) mirror([0,m,0]) for (x=[0,kiskoinsidebottomw-wall-0.25]) translate([x,kiskoinsideh+0.3,-cornerd/2]) rotate([0,-90,90]) kiskoclip();
 }
