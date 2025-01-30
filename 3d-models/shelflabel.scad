// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
absmode=0;

textarea=20;
shelfthickness=19;//.75;
labelheight=shelfthickness+textarea; // text is below shelf, as letter label may be on top
textdepth=1.2;
wall=1.8;
topwall=2;
shelfdepth=38;
shelfw=8;
shelfgap=6;
cornerd=1;
margin=3;//textsize/2;
textheight=margin; //5.6;
textsize=textarea-2*margin;
arrowwidth=labelheight/3;
bedx=230;
bedy=230;
bedz=249;

//texts=["SCI-FI", "BIO", ""];
//texts=["NOVEL", "COMICS", "HISTORY", "LAW", "SEAFARING", "AVIATION", "PERIODICALS", ""];
//texts=["BUSINESS", "SOCIETY", "SELF IMPROVEMENT","TECHNOLOGY", "PERIODICALS",""];
texts=["DICTIONARY", "CS", "TRAVEL", "DATABOOK", "PERIODICALS", "HSU", "ARCHITECTURE", "COOKING", "THESIS",""];

module shelflabel(t,width) {
  echo(width);
  difference() {
    union() {
      hull() {
	roundedbox(width,labelheight,wall,cornerd);
	translate([width+arrowwidth,labelheight/2,wall/2]) scale([1,1,wall/cornerd]) sphere(d=cornerd,$fn=30);
      }
      if (absmode) {
	for (x=[0,width-shelfw]) {
	  translate([x,topwall+shelfthickness,0]) roundedbox(shelfw,topwall,shelfdepth,cornerd);
	  hull() {
	    translate([x,0,0]) roundedbox(shelfw,topwall,shelfdepth,cornerd);
	    translate([x,topwall-cornerd,shelfdepth]) roundedbox(shelfw,cornerd,topwall*2+cornerd,cornerd);
	  }
	}
      } else {
	translate([0,topwall+shelfthickness,0]) roundedbox(width,topwall,shelfdepth,cornerd);
	hull() {
	  translate([0,0,0]) roundedbox(width,topwall,shelfdepth,cornerd);
	  translate([0,topwall-cornerd,shelfdepth]) roundedbox(width,cornerd,topwall*2+cornerd,cornerd);
	}
      }


      if (absmode) {
	for (z=[0, shelfdepth/2, shelfdepth-3]) {
	  translate([0,0,z]) roundedbox(width,topwall,2,cornerd);
	}

	shelfopening=width-shelfw*2;
	shelfsupportmidtowers=floor(shelfopening/(shelfgap+shelfw));
	step=shelfopening/shelfsupportmidtowers;
	for (x=[shelfw+step/2-shelfw/2:step:width-shelfw-1]) {
	  translate([x,topwall+shelfthickness,0]) roundedbox(shelfw,topwall,shelfdepth,cornerd);
	  hull() {
	    translate([x,0,0]) roundedbox(shelfw,topwall,shelfdepth,cornerd);
	    translate([x,topwall-cornerd,shelfdepth]) roundedbox(shelfw,cornerd,topwall*2+cornerd,cornerd);
	  }
	}
	translate([0,topwall+shelfthickness,shelfdepth-3]) roundedbox(width,topwall,2,cornerd);
      }
    }

    translate([width/2,labelheight-textheight,-0.02]) linear_extrude(textdepth) rotate([180]) text(text=t,font="Liberation Sans:style=Bold",size=textsize,valign="bottom",halign="center");
  }
}

module printlabels(x,y,i) {
  echo(x,y,texts[i]);
  if (texts[i] != "") {
    tm=textmetrics(text=texts[i],font="Liberation Sans:style=Bold",size=textsize,valign="top",halign="center");
    width=tm.size[0]+margin*2;
    newy=(x+width+arrowwidth>bedx)?y+labelheight+1:y;
    newx=(x+width+arrowwidth>bedx)?0:x;
    translate([newx,newy,0]) shelflabel(texts[i],width);
    printlabels(newx+width+arrowwidth+1,newy,i+1);
  }
}

//rotate([0,0,00]) printlabels(0,0,0);
rotate([0,0,0]) printlabels(0,0,0);
