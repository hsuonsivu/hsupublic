// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

debug=0;

maxbridge=10;
barometerh=18;//22;
barometerd=131;

versiontext="V1.1";
brandtext="Barometerstand";
fulltext=str(brandtext," ",versiontext);
textdepth=0.7;
textsize=6.5;
textfont="Liberation Sans:style=Bold";

//nuppiangle=35;
nuppih=7.39;
nuppid=8.5;
wall=1.6;
cornerd=2;
catch=1.0;

framew=14;

nuppiangle=nuppid*4/3.14159;
lowangle=360-nuppiangle;//nuppid*2/3.14159;//nuppiangle*2;
lowanglestart=180+nuppiangle/2;//nuppiangle;

topangle=15;

angle=10;

based=45;//barometerh*2;
basew=20;

cut=1;
cutstep=10;

//function pointz(x) = -(barometerd+wall*2)*sin(angle)-(x-barometerd/2-wall)*sin(angle);
function pointz(x) = -(barometerd+wall*2)*tan(angle)-(x-barometerd/2-wall)*tan(angle)-wall;

module side(d,h,in,start,angle) {
  rotate_extrude(start=start,angle=angle,convexity=10,$fn=180) {
    hull() {
      translate([d/2+wall/2,wall/2,0]) circle(d=wall,$fn=30);
      translate([d/2+wall/2,wall+h+wall/2,0]) circle(d=wall,$fn=30);
    }
    hull() {
      translate([d/2+wall/2,wall+h+wall/2,0]) circle(d=wall,$fn=30);
      translate([d/2+wall/2-in,wall+h+wall/2+in,0]) circle(d=wall,$fn=30);
    }
  }
}

module sphereform()
{
  rotate([0,angle,0]) hull() {
    sphere(d=wall,$fn=30);
    translate([0,0,-wall/2]) cylinder(d=wall/2,h=wall/2,$fn=30);
  }
}

module barometerframe() {
  d=barometerd/2+wall/2;
  ind=barometerd/2-maxbridge;
  steps=180;
  step=360/steps;
  for (a=[-180:step:180+360/2]) {
    hull() {
      translate([d*sin(a),d*cos(a),wall/2+pointz(d*sin(a))]) sphereform();
      translate([d*sin(a+step),d*cos(a+step),wall/2+pointz(d*sin(a+step))]) sphereform();

      translate([d*sin(a),d*cos(a),wall/2]) sphere(d=wall,$fn=30);
      translate([d*sin(a+step),d*cos(a+step),wall/2]) sphere(d=wall,$fn=30);
    }
    hull() {
      translate([ind*sin(a),ind*cos(a),wall/2+pointz(ind*sin(a))]) sphereform();
      translate([ind*sin(a+step),ind*cos(a+step),wall/2+pointz(ind*sin(a+step))]) sphereform();

      translate([ind*sin(a),ind*cos(a),wall/2]) sphere(d=wall,$fn=30);
      translate([ind*sin(a+step),ind*cos(a+step),wall/2]) sphere(d=wall,$fn=30);
    }
    hull() {
      translate([ind*sin(a),ind*cos(a),wall/2+pointz(ind*sin(a))]) sphereform();
      translate([ind*sin(a+step),ind*cos(a+step),wall/2+pointz(ind*sin(a+step))]) sphereform();
      translate([d*sin(a),d*cos(a),wall/2+pointz(d*sin(a))]) sphereform();
      translate([d*sin(a+step),d*cos(a+step),wall/2+pointz(d*sin(a+step))]) sphereform();
    }
    hull() {
      translate([d*sin(a),d*cos(a),wall/2]) sphere(d=wall,$fn=30);
      translate([d*sin(a+step),d*cos(a+step),wall/2]) sphere(d=wall,$fn=30);
      translate([ind*sin(a),ind*cos(a),wall/2]) sphere(d=wall,$fn=30);
      translate([ind*sin(a+step),ind*cos(a+step),wall/2]) sphere(d=wall,$fn=30);
    }
  }

  inwallstep=maxbridge/barometerd*(360/3.14159);
  for (a=[0:inwallstep:359]) {
    hull() {
      translate([ind*sin(a),ind*cos(a),wall/2+pointz(ind*sin(a))]) sphereform();
      translate([d*sin(a),d*cos(a),wall/2+pointz(d*sin(a))]) sphereform();
      translate([d*sin(a),d*cos(a),wall/2]) sphere(d=wall,$fn=30);
      translate([ind*sin(a),ind*cos(a),wall/2]) sphere(d=wall,$fn=30);
    }
  }
	  
  //echo(cos(angle),1/cos(angle));
  //  basex=d-pointz(d*sin(90))*(1/cos(angle));//+pointz(d*sin(90))*cos(90);
  basex=d-sin(angle)*pointz(d*sin(90))-wall/2;
  dd=d;//+wall/2;
  astep=0.2;

  difference() {
    union() {
      hull() {
	sphere(d=wall,$fn=30);
	translate([basex,0,-wall]) rotate([0,90+angle,0]) scale([1,1.7,1]) roundedcylinder(based+wall+wall/2,wall,cornerd,1,90);

	for (a=[90-basew*2/3:step:90+basew*2/3-step]) {
	  hull() {
	    translate([d*sin(a),d*cos(a),wall/2+pointz(d*sin(a))]) sphereform();
	    translate([d*sin(a+step),d*cos(a+step),wall/2+pointz(d*sin(a+step))]) sphereform();
	  }
	}
      }
    }
      
    translate([0,0,-barometerd]) cylinder(d=barometerd,h=barometerd*2,$fn=180);
    
    translate([basex,0,-wall]) rotate([0,90+angle,0]) rotate([0,0,90]) translate([0,0,wall-textdepth+0.01]) linear_extrude(textdepth) text(text=brandtext,size=textsize,font=textfont,valign="center",halign="center");
    translate([basex,0,-wall]) rotate([0,90+angle,0]) rotate([0,0,90]) translate([0,-textsize-1,wall-textdepth+0.01]) linear_extrude(textdepth) text(text=versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }

  difference() {
    union() {
      side(barometerd,barometerh,catch,lowanglestart,lowangle);
    }

    starta=270+nuppiangle/2+cutstep;
    for (m=[0,1]) mirror([0,m,0]) {
	for (a=[starta:cutstep:starta+130]) rotate([0,0,a]) {
	    hull() {
	      translate([0,0,cut/2+wall]) rotate([90,0,0]) cylinder(d=cut,h=barometerd+wall+0.1,$fn=30);
	      translate([0,0,cut/2+wall+barometerh+catch+cut]) rotate([90,0,0]) cylinder(d=cut,h=barometerd+wall+0.1,$fn=30);
	    }
	  }
      }
  }
}

intersection() {
  if (debug) translate([-200,0,0]) cube([200,200,200]);
  translate([0,0,-pointz(0)-0.1676]) rotate([0,-angle,0]) barometerframe();
}
