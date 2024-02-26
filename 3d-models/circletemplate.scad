// Copyright 2023,2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

$fn=360;

printwidth=300;

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
  textposition=diameter<textsize+1?1:1-diameter/2.2;
  t=str("d",str(d[i]));
  tr=str("r",str(d[i]/2));
  l=max(textlength(t),textlength(tr))+diameter/2+textposition;
	  
  rotate=diameter>l+5?1:0;
  
  translate([x,y,0]) {
    intersection() {
      difference() {
	union() {
	  cylinder(d=diameter,h=thickness);
	  boxh=diameter>l+5?height:h;
	  translate([0,-boxh/2,0]) roundedbox(l-diameter/3,boxh,thickness,cornerd);
	}

	r=diameter>l+5?90:0;
	
	translate([textposition,0,thickness-textdepth+0.01]) rotate([0,0,rotate?r:0]) linear_extrude(height=textdepth+0.2) text(text=t,font="Liberation Sans:style=Bold",size=textsize,halign=rotate?"center":"left",valign=rotate?"top":"center");

	translate([textposition+(rotate?1:0),0,textdepth-0.01]) rotate([180,0,rotate?-r:0]) linear_extrude(height=textdepth) text(text=tr,font="Liberation Sans:style=Bold",size=textsize,valign=rotate?"top":"center",halign=rotate?"center":"left");

	translate([rotate?height*1.5:l,0,-0.1]) cylinder(d=diameter,h=thickness+0.2);
      }
      translate([-maxh,-maxh/2,0]) cube([maxh*2,maxh,thickness]);
    }
  }
  
  if (d[i+1] > 0) {
    newx=x+(rotate?height+diameter/8+10:l+diameter/3)+1;
    newy=y;
    if (newx+height+diameter/8+10 > printwidth) {
      circle(diameters,diameter/1.8,newy+h+1,h,i+1);
    } else {
      circle(diameters,newx,newy+(h>=maxh?0:(h-previoush)),h,i+1);
    }
  }
}

d=[4,6,8,10,12,14,16,18,20,22,25,30,35,40,45,50,60,70,80,90,100,0];

circle(d,0,0,height,0);
