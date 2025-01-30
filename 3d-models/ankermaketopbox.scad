// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=2;
howmany=2;

debug=print>0?0:1;

antiwarp=1;

cornerd=1;

topbarh=25.1;
topbardepth=18.1;
bartexts=["PLA", "ABS", "PETG", "TPU95", "GlowPETG"];
bartextsize=16;
versiontext="v1.2";
versiontextsize=7;
textdepth=0.8;
wall=2.5;
thinwall=1.6;
xtolerance=0.2;
ytolerance=0.2;
ztolerance=0.2;
dtolerance=0.7;

clipdepth=0.9;
clipd=clipdepth+2.5;

boxtoph=20;

tweezerboxdepth=5;
tweezerboxw=11;

labelthickness=1.8; //1.2;
labeledge=1;
labelclipl=40;
labelclipdepth=0.8;
labelclipd=labelclipdepth+2.0;
labelclipheight=wall;
  
boxw=wall*2+bartextsize*8;
boxdepth=thinwall+ytolerance+labelthickness+ytolerance+wall+ytolerance+topbardepth+ytolerance+wall+ytolerance+labelthickness+ytolerance+thinwall;
boxh=clipdepth+ztolerance+topbarh+boxtoph;
utilityboxheight=clipd+ztolerance+topbarh+wall;
utilityboxh=boxh-utilityboxheight+0.1; // This is cut

labelw=boxw-wall*2;
labelh=boxh-wall;

module label(t) {
  difference() {
    translate([wall,thinwall+ytolerance,0]) roundedbox(labelw,labelthickness,labelh,cornerd);
    
    // Clips to keep label in place
    for (y=[thinwall+ytolerance+labelthickness+ytolerance+labelclipd/2-labelclipdepth,boxdepth-thinwall-ytolerance-labelthickness-ytolerance-labelclipd/2+labelclipdepth]) {
      translate([boxw/2,y,labelclipheight+labelclipd/2]) tubeclip(labelclipl,labelclipd,dtolerance);
    }

    translate([boxw/2,thinwall+ytolerance+textdepth-0.01,boxh/2]) rotate([90,0,0]) linear_extrude(textdepth) text(t,size=bartextsize,valign="center",halign="center");
    translate([boxw/2,thinwall+ytolerance+textdepth-0.01,versiontextsize+wall]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,valign="center",halign="center");
  }
}

module ankermaketopbox() {
  difference() {
    translate([0,0,0]) roundedbox(boxw,boxdepth,boxh,cornerd);

    translate([-0.01,thinwall+ytolerance+labelthickness+ytolerance+wall,-0.01]) cube([boxw+0.02,ytolerance+topbardepth+ytolerance,clipd+ztolerance+ztolerance+topbarh+ztolerance]);

    for (y=[thinwall,thinwall+ytolerance+labelthickness+ytolerance+wall+ytolerance+topbardepth+ytolerance+wall]) {
      translate([wall-xtolerance,y,-0.01]) cube([boxw-wall*2+xtolerance*2,ytolerance+labelthickness+ytolerance,boxh-wall+ztolerance]);
    }

    translate([wall+labeledge,-0.01,-0.01]) cube([boxw-wall*2-labeledge*2,thinwall+ytolerance+0.02,labelh-labeledge+0.01]);
    translate([wall+labeledge,boxdepth-thinwall-0.01,-0.01]) cube([boxw-wall*2-labeledge*2,thinwall+ytolerance+0.02,labelh-labeledge+0.01]);
    
    translate([boxw/2,thinwall+ytolerance+labelthickness+ytolerance+textdepth-0.01,versiontextsize+wall]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,valign="center",halign="center");

    translate([cornerd/2+wall,boxdepth/2-tweezerboxdepth/2,utilityboxheight]) roundedbox(tweezerboxw,tweezerboxdepth,utilityboxh,cornerd);
    
    translate([boxw/2,boxdepth-thinwall-ytolerance-labelthickness-ytolerance-textdepth+0.01,versiontextsize+wall]) rotate([-90,180,0]) linear_extrude(textdepth) text(versiontext,size=versiontextsize,valign="center",halign="center");
  }

  // Clips to keep box attached to the top bar
  for (y=[thinwall+ytolerance+labelthickness+ytolerance+clipd/2,boxdepth-thinwall-ytolerance-labelthickness-ytolerance-clipd/2]) {
    translate([boxw/2,y,clipd/2]) tubeclip(boxw,clipd,0);
  }

  // Clips to keep label in place
  for (y=[thinwall+ytolerance+labelthickness+ytolerance+labelclipd/2-labelclipdepth,boxdepth-thinwall-ytolerance-labelthickness-ytolerance-labelclipd/2+labelclipdepth]) {
    translate([boxw/2,y,labelclipheight+labelclipd/2]) tubeclip(labelclipl,labelclipd,0);
  }
}


if (print==0) {
  intersection() {
    union() {
      ankermaketopbox();
      label(bartexts[0]);
    }

    cube([boxw/2,boxdepth,boxh]);
  }
 }

if (print==1) {
  for (i=[1:1:howmany]) {
    translate([(boxdepth+1)*(i-1),0,boxh]) rotate([180,0,90]) ankermaketopbox();
  }

  difference() {
    minkowski() {
      cube([(boxdepth+1)*howmany,boxw,boxh+2]);
      cylinder(d=10,h=1);
    }

    translate([0,0,-0.01]) minkowski() {
      cube([(boxdepth+1)*howmany,boxw,boxh+2+0.02]);
      cylinder(d=10-0.8*2,h=1);
    }

    translate([-10,boxw/2,-0.01]) cube([9.9,1,1.01]);
  }
 }

if (print==2) {
  for (i=[0:1:3]) {
    translate([0,i*(labelh+0.5),0]) rotate([-90,0,0]) translate([-wall-ytolerance,-thinwall-ytolerance-labelthickness,0]) label(bartexts[floor(i/2)]);
  }
  for (i=[4:1:5]) {
    translate([labelw+0.5+(i-4)*(labelh+0.5),labelw,0]) rotate([-90,0,-90]) translate([-wall-ytolerance,-thinwall-ytolerance-labelthickness,0]) label(bartexts[floor(i/2)]);
  }
 }

if (print==3) {
  for (i=[4:1:4+3]) {
    translate([0,(i-4)*(labelh+0.5),wall+ytolerance+labelthickness]) rotate([-90,0,0]) label(bartexts[floor(i/2)]);
  }
 }

if (print==4) {
  for (i=[8:1:8+3]) {
    translate([0,(i-8)*(labelh+0.5),wall+ytolerance+labelthickness]) rotate([-90,0,0]) label(bartexts[floor(i/2)]);
  }
 }

if (print==5) {
  for (i=[6:1:6+3]) {
    translate([0,(i-6)*(labelh+0.5),wall+ytolerance+labelthickness]) rotate([-90,0,0]) label(bartexts[floor(i/2)]);
  }
 }

