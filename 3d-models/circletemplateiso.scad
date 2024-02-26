// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

$fn=180;

printwidth=450;

versiontext="V1.0";
textdepth=1;
textsize=10;

height=textsize+2.5;

thickness=2.5;
gap=2;
charw=textsize*7/8;
maxh=400;

cornerd=0.1;

arcx=textsize+12;

strapholed=8.5;
strapholeangle=65;

straphookthickness=4;

strapwidth=16.8;
strapthickness=7;
strapholecornerd=3;
strapholedx=2.5;

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

module straphook() {
  difference() {
    hull() {
      cylinder(d=strapholed*strapholedx,h=straphookthickness);
      translate([strapholed*3,-strapwidth/6,0]) cylinder(d=strapwidth+10,h=straphookthickness);
      translate([strapholed*3,strapwidth/6,0]) cylinder(d=strapwidth+10,h=straphookthickness);
    }

    translate([0,0,-0.1]) cylinder(d=strapholed,h=straphookthickness+0.2);
    translate([strapholed*3-strapthickness/2+1,-strapwidth/2,-strapholecornerd]) roundedbox(strapthickness,strapwidth,straphookthickness+2*strapholecornerd,strapholecornerd);

    translate([strapholed+1,0,straphookthickness-textdepth+0.01]) rotate([0,0,90]) linear_extrude(height=textdepth+0.2) text(text=versiontext,font="Liberation Sans:style=Bold",size=6,halign="center",valign="top");  }
}


module circle(diameters,x,y,previoush,i) {
  echo(d[i]);
  diameter=d[i];

  h=diameter>height?diameter:height;
  textposition=-diameter/2 + 5;
  t=str("d",str(d[i]));
  tr=str("r",str(d[i]/2));
  l=max(textlength(t),textlength(tr))+diameter/2+textposition;
	  
  rotate=1; //diameter>l+5?1:0;
  
  echo("d ",diameter, " x ", x, " y ", y, " h ",h, " textposition ", textposition);
	
  translate([x,y,0]) {
    difference() {
      union() {
	intersection() {
	  cylinder(d=diameter,h=thickness);
	  union() {
	    translate([arcx,0,0]) rotate([0,0,strapholeangle]) translate([-diameter,0,0]) cube([diameter,diameter,thickness]);
	    translate([arcx,0,0]) rotate([0,0,-strapholeangle]) translate([-diameter,-diameter,0]) cube([diameter,diameter,thickness]);
	  }
	}
	boxh=diameter>l+5?height:h;

	translate([arcx,0,0]) rotate([0,0,strapholeangle]) translate([-diameter/2-strapholed*strapholedx/2,0,0]) cylinder(d=strapholed*strapholedx,h=thickness);
	//translate([arcx,0,0]) rotate([0,0,-strapholeangle]) translate([-diameter/2-strapholed*strapholedx/2,0,0]) cylinder(d=strapholed*strapholedx,h=thickness);
      }

      r=90; //diameter>l+5?90:0;
	
      translate([textposition,0,thickness-textdepth+0.01]) rotate([0,0,rotate?r:0]) linear_extrude(height=textdepth+0.2) text(text=t,font="Liberation Sans:style=Bold",size=textsize,halign=rotate?"center":"left",valign=rotate?"top":"center");

      translate([textposition+(rotate?1:0),0,textdepth-0.01]) rotate([180,0,rotate?-r:0]) linear_extrude(height=textdepth) text(text=tr,font="Liberation Sans:style=Bold",size=textsize,valign=rotate?"top":"center",halign=rotate?"center":"left");

      translate([arcx,0,-0.1]) cylinder(d=diameter,h=thickness+0.2);

      translate([arcx,0,-0.1]) rotate([0,0,strapholeangle]) translate([-diameter/2-strapholed*strapholedx/2,0,0]) cylinder(d=strapholed,h=thickness+0.2);
      //translate([arcx,0,-0.1]) rotate([0,0,-strapholeangle]) translate([-diameter/2-strapholed*strapholedx/2,0,0]) cylinder(d=strapholed,h=thickness+0.2);
    }
  }
  
  if (d[i+1] > 0) {
    newx=x+arcx-(diameter-d[i+1])/2+2;
    newy=y+3;
    circle(diameters,newx,newy,h,i+1);
  } else {
    translate([x+arcx-(diameter-strapholed*strapholedx)/2+1,y,0]) straphook();
  }
}

d=[400,300,250,200,170,150,120,100,80,60,50,0];

circle(d,0,0,height,0);
