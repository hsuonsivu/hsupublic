// Copyright 2023,2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

$fn=360;

printwidth=225;

versiontext="V1.0";
textdepth=0.8;
textsize=8;

height=textsize+2.5;

thickness=2;
gap=2;
charw=textsize*7/8;
maxh=50;

cornerd=0.1;

module roundedbox(x,y,z,c) {
  corner=(c && (c > 0)) ? c : 1;
  scd = ((x < corner || y < corner || z < corner) ? min(x,y,z) : corner);
  f=30;
  
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
  }
}

function textlength(text) = len(str(text)) * charw;

module circle(diameters,x,y,previoush,i) {
  echo(d[i]);
  diameter=d[i];

  h=diameter>height?diameter:height;
  textposition=diameter<textsize+1?1:diameter-textsize;
  t=str("d",str(d[i]));
  tr=str("r",str(d[i]/2));
  l=max(textlength(t),textlength(tr))+diameter/2+textposition;

  translate([x,y,0]) {
    intersection() {
      difference() {
union() {
	  cylinder(d=diameter,h=thickness);
	}

	translate([-diameter/2+textsize/2+2,0,thickness-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth+0.2) text(text=t,font="Liberation Sans:style=Bold",size=textsize,halign="center",valign="center");

	translate([-diameter/2+textsize/2+2,0,textdepth-0.01]) rotate([180,0,90]) linear_extrude(height=textdepth) text(text=tr,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");

	translate([textsize+3,0,-0.1]) cylinder(d=diameter,h=thickness+0.2);
      }
      translate([-diameter/2,-maxh/2,0]) cube([diameter/2,maxh,thickness]);
    }
  }
  
  if (d[i+1] > 0) {
    newx=x+(textsize+4)*2;
    newy=y;
    circle(diameters,newx,newy+(h>=maxh?0:(h-previoush)),h,i+1);
  }
}

d=[100,120,140,160,180,200,0];//,120,140,150,170,0];

circle(d,0,0,height,0);
