// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

baseheight=7;
basexoffset=baseheight/2;
basewidth=6.1;

basediameter=12;
knobdiameter=25;
knobnarrowing=5;
diald=2;
diallength=knobdiameter/2*1.4-diald/2; // from center
knobh=10;
knobbaseh=6;
knobholedepth=11;
knobholez=knobbaseh+knobh-knobholedepth;

difference() {
  union() {
    hull() {
      cylinder(h=knobh,d1=knobdiameter-knobnarrowing,d2=knobdiameter);
      translate([0,diallength,knobh-diald/2]) sphere(d=diald,$fn=60);
      translate([0,diallength-knobnarrowing/2,diald/2]) sphere(d=diald,$fn=60);
    }
    translate([0,0,knobh]) cylinder(d=basediameter,h=knobbaseh);
  }
  translate([0,0,-0.01]) cylinder(h=knobholez-1,d1=knobdiameter*.5,d2=1,$fn=90);

  translate([0,0,knobholez]) cylinder(h=knobholedepth+0.01,d=basewidth/cos(180/6),$fn=6);
  translate([-basexoffset,-basewidth/2,knobholez]) cube([basewidth/2,basewidth,knobholedepth+0.01]);

}
