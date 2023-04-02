$fn=30;
diskdiameter=130;
slotdiameter=diskdiameter*1.05;
diskthickness=1.9;
slotthickness=diskthickness+0.6;
diskbetween=5;
outedge=7;
endsize=5;
disks=7;
xspread=8; // could be calculated from disk spread angle...
belowslot=5;
diskcenterz=belowslot+diskdiameter/2;

holderxsize=outedge/2+disks*slotthickness+diskbetween*6+outedge/2;
holderysize=slotdiameter+outedge*2;
holderzsize=diskcenterz + diskdiameter/5;

diskaxisy=holderysize/2;

basey=holderysize;
basex=holderxsize*2;
basetopz=10;

holediameter=diskdiameter/2;
upperholediameter=diskdiameter*0.7;

difference() {
  union() {
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
    hull() {
      translate([-(basex-holderxsize)/2 + outedge/2,outedge/2,0]) sphere(d=outedge);
      translate([-(basex-holderxsize)/2 + outedge/2,holderysize + (basey-holderysize)/2 - outedge/2,0]) sphere(d=outedge);
      translate([holderxsize/2,outedge/2,basetopz]) sphere(d=outedge);
      translate([holderxsize/2,holderysize + (basey-holderysize)/2 - outedge/2,basetopz]) sphere(d=outedge);
      translate([holderxsize + (basex-holderxsize)/2 - outedge/2,outedge/2,0]) sphere(d=outedge);
      translate([holderxsize + (basex-holderxsize)/2 - outedge/2,holderysize + (basey-holderysize)/2 - outedge/2,0]) sphere(d=outedge);
    }
  }

  #for (i=[0:1:disks-1]) translate([outedge-xspread/2+i*(diskbetween+slotthickness) + slotthickness/4, diskaxisy, diskcenterz]) rotate([0,90 + 3*(i - disks/2),0]) hull() { cylinder(d=slotdiameter,h=slotthickness); translate([-diskdiameter/2,0,0]) cylinder(d=slotdiameter,h=slotthickness); }

  translate([-(basex - holderxsize)/2,holderysize/2,0]) rotate([0,90,-0.01]) cylinder(d=holediameter,h=basex);

  translate([-(basex - holderxsize)/2,holderysize/2,holderzsize]) rotate([0,90,-0.01]) cylinder(d=upperholediameter,h=basex);

  translate([-(basex-holderxsize)/2,-0.01,-outedge]) cube([basex+1,basey+1,outedge]);
}
