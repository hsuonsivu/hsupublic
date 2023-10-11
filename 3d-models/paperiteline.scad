// Paper towel roll holder

// Copyright 2022 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679


// height=x
// depth=y
// width=z

print=3; // 1=left, 2=right, 3=both
$fn=90;
versiontext="V3.2";
font = "Liberation Sans";
textdepth = 0.5;

rollwidth=226;
rolldiameteroutside=200;
rolldiameterinside=35; //3;
rollextra=5; // Distance from backplate to roll
rollborediameter=26;
screwdistance=166.5;

backplateheight=200;
backplatedepth=10;
holdersupportdepth=rolldiameteroutside/2+backplatedepth;
holdersupportwidth=10;
holdersupportupdepth=25;
backplatewidth=rollwidth+holdersupportwidth*2;

rollaxisdepth=rolldiameteroutside/2+backplatedepth+rollextra;
rollaxisheight=rolldiameterinside/2; // rolldiameteroutside/2;
rollborewidth=40; // rollwidth + 2*holdersupportwidth + 10;

screwrecessdiameter=30;
screwrecessdepth=5;
screwrecessmid=backplatewidth/2;
screwrecessheight=backplateheight-screwrecessdiameter/2-10;
screwrecessleft=screwrecessmid-screwdistance/2;
screwrecessright=screwrecessmid+screwdistance/2;

screwholediameter=6.5;

fingerwidth=30;
fingerdepth=5;
fingerdepthposition=1.5;
fingerheight=20;
fingerupper=backplateheight - 45 - fingerheight; // rollaxisheight*2+backplatedepth/2-10-fingerheight;
fingerlower=10;
fingernotchdepth=1; //backplatedepth;
fingernotchmalediameter=1.5;
fingernotchwidth=3;
fingerholediameter=4;

tolerance=0.5;
tolerancedepth=0.5;
diametertolerance=0.96; // 97;
  
holeedge=63;
roundholediameter=40;
holezadjust=6;

module holder() {
  difference() {
    union() {
      cube([backplateheight,backplatedepth,backplatewidth],center=false);

      hull() {
	translate([backplatedepth/2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
	translate([rollaxisheight,rollaxisdepth,0]) cylinder(h=holdersupportwidth,d=rolldiameterinside);
	translate([backplateheight-backplatedepth/2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
      };

      translate([0,0,backplatewidth-holdersupportwidth])
	hull() {
	translate([backplatedepth/2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
	translate([rollaxisheight,rollaxisdepth,0]) cylinder(h=holdersupportwidth,d=rolldiameterinside);
	translate([backplateheight-backplatedepth/2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
      };

      translate([rollaxisheight,rollaxisdepth,holdersupportwidth])
	cylinder(h=rollwidth+1,d=rolldiameterinside);
      
    }

    translate([5,10-textdepth+0.01,holdersupportwidth+10]) rotate([-90,270,0]) linear_extrude(height = textdepth+0.02) text(text = str(versiontext), font = font, size = 10, valign="baseline");
    
    translate([rollaxisheight,rollaxisdepth,-0.01])
      cylinder(h=rollwidth+holdersupportwidth*2+1,d=rollborediameter);

    translate([screwrecessheight,screwrecessdepth,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);
    translate([screwrecessheight,screwrecessdepth,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);

    translate([screwrecessheight,-0.01,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter);
    translate([screwrecessheight,-0.01,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter);

    // Lightening holes

hull() {
  translate([backplatedepth/2+rolldiameterinside+(rolldiameterinside-rollborewidth),backplatedepth+0.01,backplatedepth*2]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
  translate([backplateheight*0.7-backplatedepth/2,backplatedepth+0.01,backplatedepth*2]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
  translate([backplateheight*0.85-backplatedepth/2,backplatedepth+0.01,backplatedepth*2+rollwidth/4]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
  translate([backplateheight*0.85-backplatedepth/2,backplatedepth+0.01,backplatedepth*2+rollwidth/2]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
  translate([backplateheight*0.5-backplatedepth/2,backplatedepth+0.01,backplatedepth*2+rollwidth-backplatedepth*2.5]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
  translate([backplatedepth*2,backplatedepth+0.01,backplatedepth*2+rollwidth/4]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
  translate([backplatedepth*2,backplatedepth+0.01,backplatedepth*2+rollwidth*(2/4)]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
}

// Lightening holes in roll supports
hull() {
  translate([backplatedepth/2+rolldiameterinside+(rolldiameterinside-rollborewidth),backplatedepth/2+backplatedepth,-0.01]) cylinder(h=holdersupportwidth+0.02,d=backplatedepth);
	translate([backplatedepth/2+rolldiameterinside+(rolldiameterinside-rollborewidth),rollaxisdepth-rolldiameterinside,-0.01]) cylinder(h=holdersupportwidth+0.02,d=backplatedepth);
	translate([backplateheight*0.7-backplatedepth/2,backplatedepth/2+backplatedepth,-0.01]) cylinder(h=holdersupportwidth+0.02,d=backplatedepth);
}

hull() {
	translate([backplatedepth/2+rolldiameterinside,backplatedepth/2+backplatedepth,rollwidth+backplatedepth-0.01]) cylinder(h=holdersupportwidth+0.02,d=backplatedepth);
	translate([backplatedepth/2+rolldiameterinside,rollaxisdepth-rolldiameterinside,rollwidth+backplatedepth-0.01]) cylinder(h=holdersupportwidth+0.02,d=backplatedepth);
	translate([backplateheight*0.7-backplatedepth/2,backplatedepth/2+backplatedepth,rollwidth+backplatedepth-0.01]) cylinder(h=holdersupportwidth+0.02,d=backplatedepth);
}

if (0) {
    for (x=[57:roundholediameter*1.1:160]) {
      y = 35;
      translate([x,y,-0.1]) cylinder(h=rollwidth + holdersupportwidth * 2 + 1, d=roundholediameter);
    }

    for (x=[57+roundholediameter/2:roundholediameter*1.1:160]) {
      y = 75;
      translate([x,y,-0.1]) cylinder(h=rollwidth + holdersupportwidth * 2 + 1, d=roundholediameter * 0.8);
    }

  }
}

}

module left() {
  difference() {
    holder();
    translate([-0.01,-0.01,holdersupportwidth+rollwidth-0.01]) cube([backplateheight+20+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+1],center=false);
    translate([fingerupper,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+tolerance,fingerwidth+tolerance],center=false);
    translate([fingerupper,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+fingernotchdepth+tolerance,fingernotchwidth+tolerance]);
    translate([fingerupper+fingerheight/2,-0.01,holdersupportwidth+rollwidth-fingerwidth+1.5]) rotate([0,90,90]) cylinder(h=holdersupportwidth+1,d=fingerholediameter,$fn=30);
    translate([fingerlower,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+tolerance,fingerwidth+tolerance],center=false);
    translate([fingerlower,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+fingernotchdepth+tolerance,fingernotchwidth+tolerance]);
    translate([fingerlower+fingerheight/2,-0.01,holdersupportwidth+rollwidth-fingerwidth+1.5]) rotate([0,90,90]) cylinder(h=holdersupportwidth+1,d=fingerholediameter,$fn=30);
  }
 }

module right() {
  difference() {
    holder();
    translate([-0.01,-0.01,-0.01]) cube([backplateheight+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+rollwidth+0.01],center=false);
    translate([fingerlower-2,backplatedepth+5,backplatewidth-holdersupportwidth+textdepth-0.01]) rotate([0,180,0]) linear_extrude(height = textdepth) text(text = str(versiontext), font = font, size = 8, valign="baseline", halign="right");
  }
  translate([fingerupper+tolerance/2,fingerdepthposition,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight-tolerance,fingerdepth-tolerancedepth,fingerwidth-tolerance+1],center=false);
  translate([fingerupper+tolerance/2,fingerdepthposition+fingerdepth-fingernotchmalediameter/2,holdersupportwidth+rollwidth-fingerwidth+fingernotchwidth/2]) rotate([0,90,0]) cylinder(h=fingerheight-tolerance,d=2*fingernotchmalediameter,$fn=30);
  translate([fingerlower+tolerance/2,fingerdepthposition,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight-tolerance,fingerdepth-tolerancedepth,fingerwidth-tolerance+1],center=false);
  translate([fingerlower+tolerance/2,fingerdepthposition+fingerdepth-fingernotchmalediameter/2,holdersupportwidth+rollwidth-fingerwidth+fingernotchwidth/2]) rotate([0,90,0]) cylinder(h=fingerheight-tolerance,d=2*fingernotchmalediameter,$fn=30);
  translate([rollaxisheight,rollaxisdepth,rollwidth+holdersupportwidth*2-rollborewidth]) cylinder(h=rollborewidth,d=rollborediameter*diametertolerance);
  translate([rollaxisheight,rollaxisdepth,rollwidth+holdersupportwidth*2-holdersupportwidth]) cylinder(h=holdersupportwidth,d=rollborediameter);
 }


 if (print == 1 || print == 0) {
   left();
 }


 if (print == 2 || print == 0) {
   right();
 }

if (print == 3) {
  left();
  
  translate([rollaxisheight*2+rolldiameterinside+70,backplatewidth-rolldiameterinside-9,backplatewidth]) rotate([180,0,-69]) right();
 }
