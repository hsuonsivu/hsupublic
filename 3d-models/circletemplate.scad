// Copyright 2023,2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
include <text_on_OpenSCAD/text_on.scad>

$fn=360;

printwidth=230;

versiontext="V1.0";
textdepth=0.6;
textsize=8;
textfont="Liberation Sans:style=Bold";
height=textsize+2.5;

thickness=2;
h=2;
gap=2;
charw=textsize*7/8;
maxh=50;
maxw=50;

cornerd=0.95;

module template(x,y,i) {
  d=dtable[i];
  if (d>0) {
    t=str("d",str(d));
    tr=str("r",str(d/2));
    textl=max(textlen(t),textlen(tr));
    textspacel=textl>d-5?textl:textsize+3;
    rotatetext=textl>d-5?0:1;
    textx=2;
    w=d>maxw?maxw:d;
    //a=atan((d/2+cornerd)/(d/2));
    a=atan((d/2+cornerd/2)/(d/2-cornerd/2));
    //echo("a tan(a)",a, tan(a));
    //xreduction=(tan(a)*d/2*(cornerd/2))/(d/2);
    s=((tan(a)*cornerd/2+cornerd/2+d/2)/(d/2));
    //xreduction=(tan(a)*d/2*(cornerd/2))/(d/2);
    //xreduction=0;//s*cornerd/2+cornerd/2;
    xreduction=sin(25)*d/2;
    //echo("xreduction ",xreduction);

    nextxx=x+textspacel+(d>maxw?textsize:d/2-xreduction);
    nexty=nextxx>printwidth-maxw?y+maxw+0.5:y;
    nextx=nextxx>printwidth-maxw?0:nextxx;
    echo("d ",d," x ",x," y ",y," nextx ",nextx," nexty ",nexty);
    
    translate([x,y,0]) {
      intersection() {
	union() {
	  difference() {
	    translate([d/2,0,0]) {
	      hull() {
		roundedcylinder(d,h,cornerd,1,360);
		translate([d/2,-w/2,0]) roundedbox(textspacel-d/2-xreduction,w,h,cornerd,1);
		translate([d/2,-w/2,0]) roundedbox(textspacel-d/2-xreduction,w,h,cornerd,1);
	      }
	    }
    
	    //	translate([textspacel+xreduction+cornerd/2,0,-0.01]) cylinder(d=d,h=h+0.02,$fn=360);
	    translate([textspacel+d/2,0,-0.1]) cylinder(d=d,h=h+0.2,$fn=360);
    
	    if (rotatetext) {
	      translate([textx+d/2+textsize/2,0,h-textdepth/2+0.01]) text_on_circle(t,rotate=-90,r=d/2,size=textsize,font=textfont,extrusion_height=textdepth);//text(text=t,font=textfont,size=textsize,halign="center",valign="top");
	      translate([textx+d/2+textsize/2,0,textdepth/2-0.01]) rotate([0,180,180]) text_on_circle(tr,rotate=-90,r=d/2,size=textsize,font=textfont,extrusion_height=textdepth);//text(text=t,font=textfont,size=textsize,halign="center",valign="top");
	    } else {
	      translate([textx,0,h-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(text=t,font=textfont,size=textsize,halign="left",valign="center");
	      translate([textx,0,textdepth-0.01]) rotate([0,180,180]) linear_extrude(height=textdepth) text(text=tr,font=textfont,size=textsize,halign="left",valign="center");
	    }
	  }
	}

	translate([0,-maxw/2,0]) roundedbox(maxw,maxw,h,cornerd,1);
      }
    }

    template(nextx,nexty,i+1);
  }
}

dtable=[10,12,14,16,18,20,22,25,30,35,40,45,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,0];
d=dtable;

template(0,0,0); //circle(d,0,0,height,0);
