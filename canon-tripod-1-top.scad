// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

length=101.2;
width=36.66;
thickness=4.9;
lengthinside=97.2;
widthinside=33.2;
thicknessinside=3.3;
xpositioninside=(length-lengthinside)/2;
ypositioninside=(width-widthinside)/2;
tappidiameter=2.9;
tappiwidthout=28.45 - tappidiameter;
tappiwidthin=13.40 - tappidiameter;
tappirowx1=length - 6.7 + tappidiameter/2;
tappirowx2=length - 17.6 + tappidiameter/2;
tappirowx3=length - 21.7 + tappidiameter/2;
tappirowx4=7.73 - tappidiameter/2;
tappirowx5=17.85 - tappidiameter/2;
tappih=11; //from 0 
screwholediameter=6;
screwholexposition=47.27;
outsidecornerdiameter1=1.2;
outsidecornerdiameter2=6;
insidecornerdiameter=2.6;

$fn=60;

union() {
  difference() {
    hull() {
      translate([outsidecornerdiameter1/2,outsidecornerdiameter1/2,0]) cylinder(h=thickness,d=outsidecornerdiameter1);
      translate([length-outsidecornerdiameter2/2,outsidecornerdiameter2/2,0]) cylinder(h=thickness,d=outsidecornerdiameter2);
      translate([outsidecornerdiameter1/2,width-outsidecornerdiameter1/2,0]) cylinder(h=thickness,d=outsidecornerdiameter1);
      translate([length-outsidecornerdiameter2/2,width-outsidecornerdiameter2/2,0]) cylinder(h=thickness,d=outsidecornerdiameter2);
    }
    translate([xpositioninside,ypositioninside,0]) hull() {
      translate([insidecornerdiameter/2,insidecornerdiameter/2,-0.001]) cylinder(h=thicknessinside+0.001);
      translate([lengthinside-insidecornerdiameter/2,insidecornerdiameter/2,-0.001]) cylinder(h=thicknessinside+0.001);
      translate([insidecornerdiameter/2,widthinside-insidecornerdiameter/2,-0.001]) cylinder(h=thicknessinside+0.001);
      translate([lengthinside-insidecornerdiameter/2,widthinside-insidecornerdiameter/2,-0.001]) cylinder(h=thicknessinside+0.001);
    }
    translate([screwholexposition,width/2,0]) cylinder(h=thickness+1,d=screwholediameter);
  }
  translate([tappirowx1,width/2-tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx1,width/2+tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx2,width/2-tappiwidthin/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx2,width/2+tappiwidthin/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx3,width/2-tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx3,width/2+tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx4,width/2-tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx4,width/2+tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx5,width/2-tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
  translate([tappirowx5,width/2+tappiwidthout/2,thickness-tappih]) cylinder(h=tappih,d=tappidiameter);
}
