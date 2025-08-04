// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

$fn=90;

adhesion=1;
debug=0;

cornerd=1;
dtolerance=0.7;
xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;

textdepth=0.7;
textsize=7;
versiontext="v1.0";
textfont="Liberation Sans:style=Bold";

wall=2;

knobh=19.28+wall*3;
knobd=20+wall*2;

//knobshaftnarrowheight=7.15; //knobh-7.15; // 3.5;

knobshaftd=13+dtolerance;
knobshafth=knobh+0.1;

knobshaftbottomd=13.2+dtolerance;
knobshaftbottomh=2.5; //knobshaftbottomheight+3.5;
knobshaftbottomheight=0;

knobshaftnarrowingh=1.37;
knobshaftnarrowingheight=knobshaftbottomheight+knobshaftbottomh;

knobshaftnarrowd=10;
knobshaftnarrowh=1;
knobshaftnarrowheight=knobshaftnarrowingheight+knobshaftnarrowh;

knobshafttopheight=knobshaftnarrowheight+knobshaftnarrowh;
echo(knobshafttopheight);
knobshafttoph=14.5;//knobh-wall-knobshafttopheight;

knobshaftnarrowing=3.5; // What is this? Same as narrowheight?

  
knobspringin=1;
knobspringa=6;
knobspringh=12;

knobspringcutd=19+2;
knobspringcut=3; //(knobshaftd-knobshaftnarrowd)/2;

module knob() {
  difference() {
    union() {
      translate([0,0,]) roundedcylinder(knobd,knobh,cornerd,1,90);
    }

    // Cutout
    hull() {
      translate([0,0,knobshaftbottomheight-0.01]) cylinder(d=knobshaftbottomd,h=knobshaftbottomh+0.01);
      translate([0,0,knobshaftnarrowingheight]) cylinder(d1=knobshaftbottomd,d2=knobshaftnarrowd,h=knobshaftnarrowingh);
    }
    translate([0,0,knobshaftnarrowheight]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowh);

    intersection() {
      cylinder(d=knobshaftd,h=knobh-wall);
      hull() {
	translate([0,0,knobshafttopheight-0.01]) cylinder(d=knobshaftd,h=knobshafttoph-knobshaftd/2);
	translate([0,0,knobshafttopheight+knobshafttoph]) cylinder(d1=knobshaftd,d2=1,h=knobshafttoph-knobshaftd/2);
      }
    }

    translate([0,0,-0.1]) ring(knobspringcutd,(knobshaftd-knobshaftnarrowd)/2,knobspringh,1,90);
    
    for (a=[0:360/knobspringa:359]) {
      rotate([0,0,a]) translate([0.-0.1,-knobspringcut/2,-0.1]) {
	hull() {
	  cube([knobspringcutd/2,knobspringcut,knobspringh]);
	  translate([0,0,knobspringh]) triangle(knobspringcutd/2,knobspringcut,knobspringcut/2,22);
	}
      }
    }

    translate([0,0,knobh-textdepth+0.01]) linear_extrude(textdepth) text(versiontext,size=textsize-1,font=textfont,valign="center",halign="center");

  }

  if (adhesion) cylinder(d=knobshaftbottomd-0.1*2,h=0.2);
}

intersection() {
  if (debug) cube([100,100,100]);
  knob();
}
