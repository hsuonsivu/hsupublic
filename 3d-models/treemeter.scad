// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

use <hsu.scad>

versiontext="v1.0";

$fn=360;
esikarsinta=60;
harvennus=120;
hakkuu=270;
thickness=3;
strapwidth=16.2;
strapholea=-45;
strapholecornerd=2;
strapthickness=6;
offset=50;
textsize=8;
textdepth=0.8;

function textlength(text) = len(str(text)) * charw;

function charwidth(c) = search(c,"mM@") ? 1.1 : (search(c,"CBYNSAH") ? 0.95 : (search(c,"fiIl") ? 0.6 : (search(c, ".,") ? 0.5 : 0.8)));

module arc_text_r(radius, chars, i, fontsize, previousangle) {
  PI = 3.14159;
  chars_len = len(chars);
  circumference = 2 * PI * radius;
  step_angle = radius / (0.5*fontsize + radius) * fontsize / circumference * 360 * charwidth(chars[i]) - 0.30;
  echo(step_angle, chars[i], previousangle);
  adjust=(search(chars[i],"l") ? 0.5 : (search(chars[i],"m@") ? -0.55 : 0));
  rotate(previousangle+adjust) {
    translate([0, radius + fontsize/2 - 3, 0]) {
      text(
      chars[i], 
      font = "Liberation Sans", 
      size = fontsize, 
      valign = "bottom", halign = "center"
      );
  }
}
if (chars[i+1]) arc_text_r(radius, chars, i+1, fontsize, previousangle - step_angle);
}

module arc_text(radius, chars, fontsize, angle) {
  arc_text_r(radius,chars,0,fontsize,angle);
}

module treemeter() {
  intersection() {
    union() {
      translate([offset,0,0]) rotate([0,0,-strapholea]) translate([-hakkuu/2-strapwidth,0,0]) cylinder(h=thickness,d=strapwidth*2);
      translate([offset,0,0]) rotate([0,0,strapholea]) translate([-hakkuu/2-strapwidth,0,0]) cylinder(h=thickness,d=strapwidth*2);

      difference() {
	union() {
	  cylinder(h=thickness,d=hakkuu);
	}

	translate([offset,0,-0.02]) cylinder(h=thickness+0.04,d=hakkuu);
	translate([-hakkuu/1.8,harvennus*0.6,-0.02]) cylinder(h=thickness+0.04,d=harvennus);
	translate([-hakkuu/2,-esikarsinta*0.6,-0.02]) cylinder(h=thickness+0.04,d=esikarsinta);

	translate([offset,0,thickness-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(hakkuu/2+1,"Hakkuuvalmis 27cm",textsize,120);
	rotate([0,180,180]) translate([offset,0,-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(hakkuu/2+1,"Hakkuuvalmis 27cm",textsize,100);
	translate([-hakkuu/1.8,harvennus*0.6,thickness-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(harvennus/2+1,"Harvennus 12cm",textsize-1,-80);
	translate([-hakkuu/1.8,harvennus*0.6,textdepth-0.01]) rotate([180,0,0]) linear_extrude(height=textdepth) arc_text(harvennus/2+1,"Harvennus 12cm",textsize-1,-35);
	translate([-hakkuu/2,-esikarsinta*0.6,thickness-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(esikarsinta/2+1,"Esikarsinta 6cm",textsize-2,-20);
	translate([-hakkuu/2,-esikarsinta*0.6,textdepth-0.01]) rotate([180,0,0]) linear_extrude(height=textdepth) arc_text(esikarsinta/2+1,"Esikarsinta 6cm",textsize-2,-55);
      }
    }
    difference() {
      union() {
	translate([-hakkuu/2-strapthickness,0,0]) cylinder(h=thickness,d=hakkuu,$fn=360);
	translate([offset,0,0]) rotate([0,0,-strapholea]) translate([-hakkuu/2-strapwidth,0,0]) cylinder(h=thickness,d=strapwidth*2);
	translate([offset,0,0]) rotate([0,0,strapholea]) translate([-hakkuu/2-strapwidth,0,0]) cylinder(h=thickness,d=strapwidth*2);
      }
      translate([offset,0,-strapholecornerd]) rotate([0,0,-strapholea+2]) translate([-hakkuu/2-strapwidth*1.5,0,0]) roundedbox(strapwidth,strapthickness,thickness+2*strapholecornerd,strapholecornerd);

    translate([-hakkuu/2.1,0,thickness-textdepth+0.01]) rotate([0,0,-strapholea]) translate([hakkuu/2-strapthickness,0,0]) linear_extrude(height=textdepth) text(text=versiontext,font="Liberation Sans:style=Bold",size=6,halign="center",valign="center"); 
    translate([-hakkuu/2.1,0,-0.01]) rotate([0,0,-strapholea]) translate([hakkuu/2-strapthickness,0,0]) linear_extrude(height=textdepth) rotate([180,0,180]) text(text=versiontext,font="Liberation Sans:style=Bold",size=6,halign="center",valign="center");

    translate([0,0,thickness-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(hakkuu/2-textsize+1,"hsu@iki.fi",textsize-3,140);
    translate([0,0,thickness-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(hakkuu/2-textsize*2+2,"CC-BY-NC-SA",textsize-3,140);

    rotate([0,180,180]) translate([0,0,-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(hakkuu/2-textsize+1,"hsu@iki.fi",textsize-3,54);
    rotate([0,180,180]) translate([0,0,-textdepth+0.01]) linear_extrude(height=textdepth) arc_text(hakkuu/2-textsize*2+2,"CC-BY-NC-SA",textsize-3,54);
    }
  }
}

treemeter();
