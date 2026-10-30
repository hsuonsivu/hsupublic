// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;

$fn=90;

versiontext="V1.0";
textdepth=0.8;
textsize=7;
text1="Pentium";
text2="100MHz?";

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

// x = l, y=w
connectorpcbw=53;
connectorpcbl=51;
boxwall=2;

// cpu fan attachment opening
fanclipw=14;
fanclipheight=8;
fancliph=10;

switchholed=6.7;
switchholex=23.5;
switchholey=11;
powerholed=9;
powerholex=8;
powerholeh=9;
powerholeheight=6.5;
pcbthickness=1.8;
pcbcomponents=24.5-pcbthickness;
pcbwirespace=5;
pcbh=boxwall+pcbwirespace+pcbthickness;
wirespacew=48;
wirespacex=connectorpcbw/2-wirespacew/2;
wirespacel=48;
wirespacey=connectorpcbl/2-wirespacel/2;
pcbcableholew=23;
pcbcableholey=6;
pcbcableholeheight=1; // from pcb
pcbcableholeh=10; // from pcb not used...
boxinw=connectorpcbw;
boxinl=connectorpcbl;
boxinh=pcbwirespace+pcbthickness+pcbcomponents;
boxoutw=boxinw+2*boxwall;
boxoutl=boxinl+2*boxwall;
boxouth=boxinh+boxwall; // Lid is separate piece
boxlidheight=boxwall+boxinh;
boxlidsnapheight=boxouth-3;
boxlidsnapd=1.5;
boxlidsnapsink=0.3; // sink a bit to make printing easier
boxlidsnapl=10;
boxlidraise=2;
boxlidsnapx=boxwall+boxinl/2-boxlidsnapl/2;

boxsnapheight=boxwall+5;
boxsnapw=boxoutw-8;
boxsnapd=2;
boxsnapsink=boxlidsnapsink;

boxx=0;//frontscrewbased/2-1;
boxheight=0; //filterheight-boxouth-boxwall;
boxbasemidw=0;//frontattachw+12;
cornerd=1;

module box() {
  difference() {
    roundedbox(boxoutl,boxoutw,boxouth,cornerd);
    translate([boxwall,boxwall,boxwall+pcbwirespace]) roundedbox(boxinl,boxinw,boxinh-pcbwirespace+cornerd,cornerd);
    translate([boxwall+wirespacey,boxwall+wirespacex,boxwall]) roundedbox(wirespacel,wirespacew,pcbwirespace+cornerd,cornerd);

    translate([-cornerd/2,boxoutw/2-fanclipw/2,fanclipheight]) roundedbox(boxoutl+cornerd,fanclipw,boxouth+cornerd/2-fanclipheight,cornerd);
    
    translate([boxlidsnapx,boxwall+boxlidsnapsink,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl);
    translate([boxlidsnapx,boxoutw-boxwall-boxlidsnapsink,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl);

    translate([powerholex+powerholed/2+5,textdepth-0.01,pcbh]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
  }
}

module boxlid() {
  difference() {
    union() {
      translate([0,0,boxlidheight]) roundedbox(boxoutl,boxoutw,boxwall,cornerd,2);
      for (x=[0,boxwall+boxinl]) {
	translate([x,boxoutw/2-fanclipw/2+ytolerance,fanclipheight+fancliph+ztolerance]) roundedbox(boxwall,fanclipw-2*ytolerance,boxouth-fanclipheight-fancliph-ztolerance+boxwall,cornerd,2);
      }
      //      translate([boxwall+boxinl,boxwall+pcbcableholey+ytolerance,pcbh+pcbcableholeheight+pcbcableholeh]) roundedbox(boxwall,pcbcableholew-2*ytolerance,boxouth-pcbh-pcbcableholeheight-pcbcableholeh+cornerd,cornerd);
      translate([boxwall+xtolerance,boxwall+ytolerance,boxouth-boxlidraise]) roundedbox(boxwall,boxinw-ytolerance*2,boxlidraise+boxwall,cornerd);
      translate([boxoutl-boxwall-boxwall-xtolerance,boxwall+ytolerance,boxouth-boxlidraise]) roundedbox(boxwall,boxinw-ytolerance*2,boxlidraise+boxwall,cornerd);

      translate([boxlidsnapx+xtolerance,boxwall+boxlidsnapsink+ytolerance,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl-2*xtolerance);
      translate([boxlidsnapx+xtolerance,boxwall+ytolerance,boxlidsnapheight]) roundedbox(boxlidsnapl-2*xtolerance,boxwall,boxouth-boxlidsnapheight+boxwall,cornerd);
      translate([boxlidsnapx+xtolerance,boxoutw-boxwall-boxlidsnapsink-ytolerance,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl-2*xtolerance);
      translate([boxlidsnapx+xtolerance,boxoutw-boxwall-ytolerance-boxwall,boxlidsnapheight]) roundedbox(boxlidsnapl-2*xtolerance,boxwall,boxouth-boxlidsnapheight+boxwall,cornerd);
    }
    
    translate([5,boxwall,boxouth+boxwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
    translate([5,boxwall+(textsize+1)*2,boxouth+boxwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(text1, size=textsize, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
    translate([5,boxwall+textsize+1,boxouth+boxwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(text2, size=textsize, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
  }
}

if (print==0) {
  box();
#  boxlid();
 }

if (print==1) {
  box();
  translate([-0.5,0,boxlidheight+boxwall]) rotate([0,180,0]) boxlid();
 }
