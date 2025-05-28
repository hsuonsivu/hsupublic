// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

tekstit=["Nauris", "Kukka", "Kukka", ""];
// "Parsakaali","Rosmariini","Pinaatti","Retiisi"

fontsize=12;
fontwidthmultiplier=0.72;
basewidth=15;
baselength=140;
textdepth=1.5;
thickness=2*textdepth+0.7;
labelwidthextra=6;
labelheightextra=5;
textoffset=0.5;
cornerd=1.5;

spikestart=45;
spikedistance=20;
spikeend=baselength+5;
spikeh=10;
spikelength=12;
spikewidth=2;

between=0.5;

module triangle(x,y,z,mode) {
  if (mode==0) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x,z],[x,0]]);
  } else if (mode==1) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z]]);
  } else if (mode==2) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,0]]);
  } else if (mode==3) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x,0]]);
  } else if (mode==4) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y,x],[y,0]]);
  } else if (mode==5) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x]]);
  } else if (mode==6) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,0]]);
  } else if (mode==7) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y,0]]);
  } else if (mode==8) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z,y],[z,0]]);
  } else if (mode==9) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y]]);
  } else if (mode==10) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,0]]);
  } else if (mode==11) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z,0]]);
  }
}

module kasvimerkki(t, w) {
  //echo("text ", t, " w ", w);

  difference() {
    union() {
      roundedbox(w,fontsize+labelheightextra,thickness,cornerd,1);
      hull() {
	translate([w/2-basewidth/2,0,0]) roundedbox(basewidth,baselength+fontsize+labelheightextra,thickness,cornerd,1);
	translate([w/2,baselength+fontsize+labelheightextra+basewidth,thickness/2]) {
	  hull() {
	    sphere(d=thickness,$fn=60);
	    translate([0,0,-thickness/2]) cylinder(d=thickness/3,h=thickness/2,$fn=60);
	  }
	}
      }
      for (level=[spikestart:spikedistance:spikeend]) {
	for (wposition=[w/2-basewidth/2+thickness/2,w/2+basewidth/2-thickness/2-spikewidth]) {
	  translate([wposition,level,thickness/2]) {
	    triangle(spikewidth,spikelength,spikeh,8);
	  }
	}
      }
    }

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,thickness-textdepth+0.01]) rotate([0,0,180]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,halign="center");

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,textdepth-0.01]) rotate([0,180,180]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,halign="center");
  }
  
}

module r(tekstit,x,i) {
  tm=textmetrics(text=tekstit[i],font="Liberation Sans:style=Bold",size=fontsize,valign="top",halign="center");
  width=tm.size[0] + labelwidthextra;

  offsetleft = width / 2 - basewidth / 2;
  echo("offsetleft ", offsetleft);
  
  translate([x-offsetleft,-i*(fontsize+labelheightextra+between),0]) kasvimerkki(tekstit[i],width);
  
  translate([x+offsetleft+2*basewidth+between,baselength+fontsize+labelheightextra+basewidth+fontsize+labelheightextra+thickness/2+between-i*(fontsize+labelheightextra+between),0]) rotate([0,0,180]) kasvimerkki(tekstit[i],width);

  if (tekstit[i+1] != "") {
    xoffset = (width > width/2-basewidth/2+basewidth) ? width : width/2-basewidth/2+basewidth;
    r(tekstit,x-offsetleft+xoffset+1,i+1);
  }
}

r(tekstit,0,0);

	  
