// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;

debug=0;

holedistance=139.7; // Distance between outer holes
holew=17;
holeh=31.5;
boxthickness=2.5;
screwd=3.5;
lockbarw=6;
lockbarlw=8;
lockbarthickness=3;
lockbarh=holeh*2;
lockbarextend=10;
attachdepth=lockbarthickness+lockbarw/2+2.5;
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

textsize=12;
textgap=4;
textdepth=1;
thickness=2;
cornerd=2;

texts=["Company1 Oy", "Company2 Ltd", "Company3"];
textsizes=[textsize,textsize,textsize-3];

echo(len(texts));

height=len(texts)*(textsize+textgap)+textsize/2;
		 
		 width=max(holedistance+holew*2+holew,27.5*textsize*0.7);
		  
module hole() {
  difference() {
    translate([0,0,-boxthickness-attachdepth]) roundedbox(holew,holeh,boxthickness+attachdepth+cornerd,cornerd);
    hull() {
      translate([holew/2-lockbarw/2-xtolerance,-ytolerance,-boxthickness-lockbarthickness-ztolerance]) cube([lockbarw+xtolerance*2,holeh+ytolerance*2,lockbarthickness+ztolerance*2]);
      translate([holew/2-lockbarw/2-xtolerance,-ytolerance,-boxthickness-lockbarthickness-ztolerance-lockbarw/2]) triangle(lockbarw+xtolerance*2,holeh+ytolerance*2,lockbarw/2,15);
    }
  }
}

module lockbar() {
  translate([-holedistance/2-holew,0,-boxthickness-ztolerance-lockbarthickness]) roundedbox(holedistance+holew*2,lockbarlw,lockbarthickness,cornerd);
  for (x=[-holedistance/2-holew,-holew/2,holedistance/2]) {
    translate([x,-holeh,-boxthickness-0.01]) {
      hull() {
	translate([holew/2-lockbarw/2,-lockbarextend,-ztolerance-lockbarthickness]) cube([lockbarw,holeh+ytolerance+lockbarextend+cornerd,lockbarthickness]);
	translate([holew/2-lockbarw/2,-lockbarextend-lockbarthickness,-ztolerance-lockbarthickness]) cube([lockbarw,holeh+ytolerance+lockbarextend+cornerd+lockbarthickness,cornerd]);
	translate([holew/2-lockbarw/2,-lockbarextend,-lockbarthickness-lockbarw/2]) triangle(lockbarw,holeh+lockbarextend,lockbarw/2,15);
      }
    }
  }
}

module kyltti() {
  difference() {
    union() {
      translate([-width/2,textsize-height,0]) roundedbox(width,height,thickness,cornerd);
      for (x=[-holedistance/2-holew,-holew/2,holedistance/2]) {
	translate([x,-height/2,-0.01]) hole();
      }
    }
    if (!debug)    for (i=[0:1:4]) {
#      translate([0,-i*(textsize+textgap),thickness-textdepth+0.01]) linear_extrude(textdepth) text(texts[i], size=textsizes[i], valign="center",halign="center",font="Liberation Sans:style=Bold");
    }
  }
}

if (print==0) {
  kyltti();
  lockbar();
 }

if (print==1) {
  rotate([0,0,45]) { // z45
    intersection() {
      union() {
	translate([0,0,thickness]) rotate([180,0,0]) kyltti();
	translate([0,-textsize-lockbarlw-1,-boxthickness-ztolerance]) rotate([180,0,180]) lockbar();
      }
      if (debug)      translate([-12,-70,-100]) cube([24,70+60,200]);
    }
  }
 }
