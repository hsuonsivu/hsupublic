// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

$fn=90;
diskdiameter=130;
slotdiameter=diskdiameter*1.03;
diskthickness=1.9;
slotthickness=diskthickness+0.8;
diskbetween=7;
outedge=10;
endsize=5;
disks=8;
xspread=3; // could be calculated from disk spread angle...
belowslot=5;
diskcenterz=belowslot+diskdiameter/2;

holderxsize=outedge+disks*slotthickness+diskbetween*(disks-1);
holderysize=slotdiameter+outedge;
holderzsize=diskcenterz + diskdiameter/10;

diskaxisy=holderysize/2;

basey=holderysize;
basex=holderxsize*1+30;
basetopz=10;

holediameter=diskdiameter/1.7;
holezposition=-10;
upperholediameter=diskdiameter*0.9;

difference() {
  union() {
    if (0) {
    hull() {
      translate([outedge/2,outedge/2,0]) sphere(d=outedge);
      translate([outedge/2,holderysize - outedge/2,0]) sphere(d=outedge);
      translate([holderxsize - outedge/2,holderysize - outedge/2,0]) sphere(d=outedge);
      translate([holderxsize - outedge/2,outedge/2,0]) sphere(d=outedge);
      translate([outedge/2 - xspread,outedge/2,holderzsize - outedge/2]) sphere(d=outedge);
      translate([outedge/2 - xspread,holderysize - outedge/2,holderzsize - outedge/2]) sphere(d=outedge);
      translate([holderxsize + xspread - outedge/2,holderysize - outedge/2,holderzsize - outedge/2]) sphere(d=outedge);
      translate([holderxsize + xspread - outedge/2,outedge/2,holderzsize - outedge/2]) sphere(d=outedge);
    }
  }
    hull() {
      translate([-(basex-holderxsize)/2 + outedge/2,outedge/2,0]) sphere(d=outedge);
      translate([-(basex-holderxsize)/2 + outedge/2,holderysize + (basey-holderysize)/2 - outedge/2,0]) sphere(d=outedge);
      translate([holderxsize/2,outedge/2,basetopz]) sphere(d=outedge);
      translate([holderxsize/2,holderysize + (basey-holderysize)/2 - outedge/2,basetopz]) sphere(d=outedge);
      translate([holderxsize + (basex-holderxsize)/2 - outedge/2,outedge/2,0]) sphere(d=outedge);
      translate([holderxsize + (basex-holderxsize)/2 - outedge/2,holderysize + (basey-holderysize)/2 - outedge/2,0]) sphere(d=outedge);
    }
    hull() {
      for (i=[0:1:disks-1]) translate([holderxsize/2+(0.5 + i-disks/2)*(diskbetween+slotthickness), diskaxisy, diskcenterz]) {
	  echo("Angle ", 90+3*(0.5 + i - disks/2));
	  rotate([0,90 + 3*(0.5 + i - disks/2),0]) rotate([0,0,-90]) hull() { rotate_extrude(angle=180,convexity=10,$fn=90) hull() { translate([diskdiameter/2,0,0]) circle(d=outedge); translate([slotdiameter/2,0,0]) circle(d=outedge); }}
	}
      //cylinder(d=slotdiameter,h=slotthickness); cylinder(d=slotdiameter/2,h=slotthickness*2); translate([-diskdiameter/4,0,0]) cylinder(d=slotdiameter,h=slotthickness); }
    }
  }

#for (i=[0:1:disks-1]) translate([holderxsize/2+(0.5 + i-disks/2)*(diskbetween+slotthickness), diskaxisy, diskcenterz]) rotate([0,90 + 3*(0.5 + i - disks/2),0]) translate([0,0,-slotthickness/2]) hull() { cylinder(d=slotdiameter,h=slotthickness); translate([0,0,-slotthickness/2]) cylinder(d=slotdiameter/2,h=slotthickness*2); translate([-diskdiameter/4,0,0]) cylinder(d=slotdiameter,h=slotthickness); }

//translate([-(basex - holderxsize)/2,holderysize/2,holezposition]) rotate([0,90,-0.01]) cylinder(d=holediameter,h=basex);
hull() {
  translate([-(basex - holderxsize)/2, holderysize/2,belowslot+slotdiameter/2/4]) rotate([0,90,-0.01]) cylinder(d=outedge,h=basex);
  translate([-(basex - holderxsize)/2,basey/2-(belowslot+slotdiameter/2/4),0]) rotate([0,90,-0.01]) cylinder(d=outedge,h=basex);
  translate([-(basex - holderxsize)/2,basey/2+(belowslot+slotdiameter/2/4),0]) rotate([0,90,-0.01]) cylinder(d=outedge,h=basex);
}

translate([-(basex - holderxsize)/2,holderysize/2,holderzsize*1.2]) rotate([0,90,-0.01]) cylinder(d=upperholediameter,h=basex);

translate([-(basex-holderxsize)/2,-0.01,-outedge]) cube([basex+1,basey+1,outedge]);
}
