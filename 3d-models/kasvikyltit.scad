// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

tekstit=["Talviporkkana", "Vahapapu", "Herne", ""];
// "Parsakaali","Rosmariini","Pinaatti","Retiisi"

fontsize=10;
fontwidthmultiplier=0.72;
basewidth=15;
baselength=110;
textdepth=1.5;
thickness=2*textdepth+0.7;
labelwidthextra=8;
labelheightextra=6;
textoffset=1;

between=0.5;

module roundedbox(x,y,z) {
  smallcornerdiameter=1.5;
  f=30;
  hull() {
    translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
  }
}

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
      roundedbox(w,fontsize+labelheightextra,thickness);
      hull() {
	translate([w/2-basewidth/2,0,0]) roundedbox(basewidth,baselength+fontsize+labelheightextra,thickness);
	translate([w/2,baselength+fontsize+labelheightextra+basewidth,thickness/2]) sphere(d=thickness,$fn=60);
      }
    }

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,thickness-textdepth+0.01]) rotate([0,0,180]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,halign="center");

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,textdepth-0.01]) rotate([0,180,180]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,halign="center");
  }
  
}

//echo("0 ",tekstit[0], "1 ",tekstit[1], "2 ",tekstit[2]);
//echo(tekstit);
//echo(tekstit);

module r(tekstit,x,i) {
  //echo("tekstit[i] ", tekstit[i], " x ", x, " i ", i);
  
  width=len(tekstit[i])*fontsize*fontwidthmultiplier + labelwidthextra;

  
  //  offsetleft = (i>0) ? (width/2 - basewidth/2) : 0;
  offsetleft = width / 2 - basewidth / 2;
  echo("offsetleft ", offsetleft);
  
  translate([x-offsetleft,-i*(fontsize+labelheightextra+between),0]) kasvimerkki(tekstit[i],width);
  
  translate([x-offsetleft+basewidth+between,baselength+fontsize+labelheightextra+basewidth+fontsize+labelheightextra+thickness/2+between-i*(fontsize+labelheightextra+between),thickness]) rotate([180,0,0]) kasvimerkki(tekstit[i],width);

  if (tekstit[i+1] != "") {
    xoffset = (width > width/2-basewidth/2+basewidth) ? width : width/2-basewidth/2+basewidth;
    r(tekstit,x-offsetleft+xoffset+1,i+1);
  }
}

r(tekstit,0,0);

	  
