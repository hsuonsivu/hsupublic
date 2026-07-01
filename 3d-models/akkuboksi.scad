// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=0;

$fn=90;
maxbridge=10;

versiontext="V1.0";
textdepth=0.8;
textsize=7;
text1="Akkuboxi";

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

// x = l, y=w
boxwall=2;

// cpu fan attachment opening
//fanclipw=14;
//fanclipheight=8;
//fancliph=10;
powerholed=9;
powerholex=8;
powerholeh=9;
powerholeheight=6.5;
boxinw=85;
boxinl=190;
baseh=5;
boxinh=150+baseh;
boxoutw=boxinw+2*boxwall;
boxoutl=boxinl+2*boxwall;
boxouth=boxinh+boxwall; // Lid is separate piece
boxlidheight=boxwall+boxinh;
boxlidsnapheight=boxouth-3;
boxlidsnapd=1.5;
boxlidsnapsink=0.3; // sink a bit to make printing easier
boxlidraise=2;

cableholeheight=boxinh-15;
cableholeh=15;
cableholew=15;

boxsnapheight=boxwall+5;
boxsnapw=boxoutw-8;
boxsnapd=2;
boxsnapsink=boxlidsnapsink;

boxx=0;//frontscrewbased/2-1;
boxheight=0; //filterheight-boxouth-boxwall;
boxbasemidw=0;//frontattachw+12;
cornerd=1;
largecorneroutd=20;
largecornerind=largecorneroutd-boxwall*2;

bottomcutl=maxbridge;
bottomcutsll=boxoutl-largecorneroutd-boxwall;
bottomcuts=floor(bottomcutsll/(bottomcutl+boxwall));
bottomcutsl=bottomcuts*(bottomcutl+boxwall);
bottomcutsx=boxoutl/2-bottomcutsl/2;
bottomcuth=baseh;

boxlidsnapl=boxinl-largecornerind-10;
boxlidsnapx=boxwall+boxinl/2-boxlidsnapl/2;

lippa=13;
lippah=cableholeh+boxwall;
lippaoutcornerd=largecorneroutd+lippa*2;
lippaincornerd=largecorneroutd+lippa*2-boxwall*2;
lippaxyadjust=boxwall*0.7;

topangle=5;

bottomleakholew=2;
bottomleakholel=bottomcutl;

module box() {
  difference() {
    translate([-boxoutl/2,-boxoutw/2,0]) roundedboxxyz(boxoutl,boxoutw,boxouth,largecorneroutd,cornerd,1,90);
    translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,baseh+boxwall]) roundedboxxyz(boxinl,boxinw,boxinh+cornerd,largecornerind,cornerd,0,90);
      //translate([boxwall+wirespacey,boxwall+wirespacex,boxwall]) roundedbox(wirespacel,wirespacew,pcbwirespace+cornerd,cornerd,90);

    translate([-boxoutl/2,-boxoutw/2,0]) translate([-cornerd/2,boxoutw/2-cableholew/2,cableholeheight]) roundedbox(boxoutl+cornerd,cableholew,boxouth+cornerd/2-cableholeheight,cornerd);
    
    translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx,boxwall+boxlidsnapsink,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl);
    translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx,boxoutw-boxwall-boxlidsnapsink,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl);

    translate([-boxoutl/2,-boxoutw/2,0]) translate([powerholex+powerholed/2+5,textdepth-0.01,baseh+textsize/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
    translate([-boxoutl/2,-boxoutw/2,0]) translate([powerholex+powerholed/2+5,textdepth-0.01,baseh+textsize/2+textsize+1]) rotate([90,0,0]) linear_extrude(height=textdepth) text(text1, size=textsize-1, valign="bottom",halign="left",font="Liberation Sans:style=Bold");

    for (x=[bottomcutsx:bottomcutl+boxwall:bottomcutsx+bottomcutsl-1]) {
      translate([-boxoutl/2+x+boxwall/2,-boxoutw/2-0.01,-0.01]) cube([bottomcutl,boxoutw+0.02,bottomcuth+0.01]);
      for (m=[0,1]) mirror([0,m,0]) translate([-boxoutl/2+x+boxwall/2,-boxoutw/2+boxwall,-0.01]) cube([bottomleakholel,bottomleakholew,bottomcuth+boxwall+0.02]);
    }
  }
}

module boxlid() {
  difference() {
    union() {
      hull() {
	translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance-boxwall,-boxwall,boxlidheight]) rotate([topangle,0,0]) roundedboxxyz(boxoutl+xtolerance*2+boxwall*2,boxoutw+boxwall*2,boxwall,largecorneroutd+(boxwall+xtolerance)*2,cornerd,2,90);
	translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance-boxwall,-ytolerance-boxwall,boxlidheight]) roundedboxxyz(boxoutl+xtolerance*2+boxwall*2,boxoutw+ytolerance*2+boxwall*2,boxwall,largecorneroutd+(boxwall+xtolerance)*2,cornerd,2,90);
      }
      hull() {
	translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance-boxwall+lippaxyadjust,-ytolerance-boxwall+lippaxyadjust,boxlidheight]) roundedboxxyz(boxoutl+xtolerance*2+boxwall*2-lippaxyadjust*2,boxoutw+ytolerance*2+boxwall*2-lippaxyadjust*2,cornerd,largecorneroutd+(boxwall+xtolerance-lippaxyadjust)*2,cornerd,2,90);
	translate([-boxoutl/2,-boxoutw/2,0]) translate([-lippa+lippaxyadjust,-lippa+lippaxyadjust,boxlidheight-lippah]) roundedboxxyz(boxoutl+lippa*2-lippaxyadjust*2,boxoutw+lippa*2-lippaxyadjust*2,boxwall,lippaoutcornerd,cornerd,2,90);
      }
      translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance-boxwall,-ytolerance-boxwall,boxlidheight-boxwall*2]) roundedboxxyz(boxoutl+xtolerance*2+boxwall*2,boxoutw+ytolerance*2+boxwall*2,boxwall*2+cornerd,largecorneroutd+(boxwall+xtolerance)*2,cornerd,2,90);
      
      translate([-boxoutl/2,-boxoutw/2,0]) for (x=[0,boxwall+boxinl]) {
	translate([x,boxoutw/2-cableholew/2+ytolerance,cableholeheight+cableholeh+ztolerance]) roundedbox(boxwall,cableholew-2*ytolerance,boxouth-cableholeheight-cableholeh-ztolerance+boxwall,cornerd,2);
      }
      for (m=[0,1]) mirror([m,0,0]) translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall+xtolerance,boxwall+largecornerind/2+ytolerance,boxouth-boxlidraise]) roundedbox(boxwall,boxinw-largecornerind-ytolerance*2,boxlidraise+boxwall,cornerd);
      
      //      translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+xtolerance,boxoutw-boxwall-boxlidsnapsink-ytolerance,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl-2*xtolerance);
      //translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+xtolerance,boxoutw-boxwall-ytolerance-boxwall,boxlidsnapheight]) roundedbox(boxlidsnapl-2*xtolerance,boxwall,boxouth-boxlidsnapheight+boxwall,cornerd);
    }
    
    intersection() {
      union() {
	hull() {
	  translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance,-ytolerance,boxlidheight-cornerd]) rotate([topangle,0,0]) roundedboxxyz(boxoutl+xtolerance*2,(boxoutw+ytolerance*2)/cos(topangle)-ytolerance*2-boxwall,cornerd,largecornerind+xtolerance*2,cornerd,0,90);
	  translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight-boxwall]) roundedboxxyz(boxinl,boxinw,boxwall,largecornerind+xtolerance*2,cornerd,2,90);
	}
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight-boxwall]) roundedboxxyz(boxinl,boxinw,boxwall,largecornerind+xtolerance*2,cornerd,2,90);
      }
      union() {
	hull() {
	  translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance,-ytolerance,boxlidheight+boxwall+boxoutw*sin(topangle)]) roundedboxxyz(boxoutl+xtolerance*2,boxoutw+ytolerance*2,cornerd,largecornerind+xtolerance*2,cornerd,2,90);
	  translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight+boxwall]) roundedboxxyz(boxinl,boxinw,boxoutw*sin(topangle)+boxwall,largecornerind+xtolerance*2,cornerd,2,90);
	}
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight-boxwall]) roundedboxxyz(boxinl,boxinw,boxoutw*sin(topangle)+boxwall,largecornerind+xtolerance*2,cornerd,2,90);
      }
    }
    translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance,-ytolerance,boxlidheight-boxwall]) roundedboxxyz(boxoutl+xtolerance*2,boxoutw+ytolerance*2,boxwall,largecorneroutd+xtolerance*2,cornerd,2,90);
    hull() {
      translate([-boxoutl/2,-boxoutw/2,0]) translate([-xtolerance,-ytolerance,boxlidheight-boxwall-cornerd]) roundedboxxyz(boxoutl+xtolerance*2,boxoutw+ytolerance*2,boxwall,largecorneroutd+xtolerance*2,cornerd,2,90);
      translate([-boxoutl/2,-boxoutw/2,0]) translate([-lippa-xtolerance+boxwall,-lippa-ytolerance+boxwall,boxlidheight-lippah-boxwall]) roundedboxxyz(boxoutl+xtolerance*2-boxwall*2+lippa*2,boxoutw+ytolerance*2-boxwall*2+lippa*2,boxwall,lippaoutcornerd+cornerd,cornerd,2,90);
    }
  }

  for (m=[0,1]) mirror([0,m,0]) {
      translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+xtolerance,boxwall+boxlidsnapsink+ytolerance,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl-2*xtolerance);
      translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+xtolerance,boxwall+ytolerance,boxlidsnapheight]) roundedbox(boxlidsnapl-2*xtolerance,boxwall,boxouth+m*boxinw*sin(topangle)-boxlidsnapheight+boxwall,cornerd);
      translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+xtolerance,0,boxouth]) roundedbox(boxlidsnapl-2*xtolerance,boxwall+boxwall+ytolerance,boxwall,cornerd);
    }
}

if (print==0) {
  intersection() {
    if (debug==1) translate([-100-boxoutl/2,-100-boxoutw/2,-100]) cube([boxoutl/2+100,boxoutw+200,boxouth+10+200]);
    if (debug==2) translate([-100-boxoutl/2,-100-boxoutw/2,-100]) cube([boxoutl+200,boxoutw/2+100,boxouth+10+200]);
    union() {
      box();
      translate([0,0,ztolerance]) boxlid();
    }
  }
 }

if (print==1) {
  box();
  //  translate([-0.5,boxoutw/2+0.5+boxoutw/2+lippa,0]) rotate([0,180,0])
  translate([0,boxoutw/2+lippa+boxwall,boxouth+boxwall*2]) rotate([0,180,0]) translate([0,0,boxlidheight+boxwall]) rotate([-topangle,0,0]) translate([0,boxoutw/2-xtolerance,-boxouth-ztolerance]) boxlid();
 }
