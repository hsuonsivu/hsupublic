// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=0;

leakholes=0;
lidsnapinside=0;

$fn=90;
maxbridge=10;

versiontext="V1.2";
textdepth=0.8;
textsize=7;
text1="Pelilaatikko";

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

lidxtolerance=0.35;
lidytolerance=0.35;
lidcorneradjust=0.5;

// x = l, y=w
boxwall=2;

cardl=88.75;
cardw=58.8;
cardpilel=xtolerance+cardl+xtolerance;
cardpilew=ytolerance+cardw+ytolerance;
cardholdh=1;
cardpileh=5+ztolerance+cardholdh;
cardpilexycornerd=1;
cardpilezcornerd=0;
cardbaseh=1.5;
cardsloth=cardbaseh+cardpileh;
cardslotwall=1.6;
cardslotfinger=22;
cardslotfingercornerd=5;
cardslotadjust=3;

manualh=1;
manualw=137;
manuall=185;

powerholed=9;
powerholex=8;
powerholeh=9;
powerholeheight=6.5;
boxinw=manualw+1;
boxinl=manuall+1;
baseh=0;
boxinh=cardsloth+manualh;
boxoutw=boxinw+2*boxwall;
boxoutl=boxinl+2*boxwall;
boxouth=boxinh+boxwall; // Lid is separate piece
boxlidheight=boxwall+boxinh;
boxlidsnapd=1.5;
boxlidsnapsink=0.3; // sink a bit to make printing easier
boxlidraise=2;

lhole=0;
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
largecornerind=1;
largecorneroutd=largecornerind+boxwall*2;

bottomcutl=maxbridge;
bottomcutsll=boxoutl-largecorneroutd-boxwall;
bottomcuts=floor(bottomcutsll/(bottomcutl+boxwall));
bottomcutsl=bottomcuts*(bottomcutl+boxwall);
bottomcutsx=boxoutl/2-bottomcutsl/2;
bottomcuth=baseh;

boxlidsnapl=boxinl/2-largecornerind;
boxlidsnapx=boxwall+boxinl/2-boxlidsnapl/2;

lippa=0;
lippaxyadjust=boxwall*0.7;
lippaoutcornerd=largecorneroutd+(boxwall+lidxtolerance-lippaxyadjust)*2-lidcorneradjust; //largecorneroutd+lippa*2;
lippaincornerd=largecorneroutd+lippa*2-boxwall*2;

lidinl=boxoutl+lidxtolerance*2;
lidinw=boxoutw+lidxtolerance*2;

lidoutl=boxoutl+lidxtolerance*2+boxwall*2;
lidoutw=boxoutw+lidxtolerance*2+boxwall*2;
lidoutcornerd=largecorneroutd+(boxwall+lidxtolerance)*2-lidcorneradjust;

lippatopoutl=lidoutl-lippaxyadjust*2;
lippatopoutw=lidoutw-lippaxyadjust*2;

lippainl=boxoutl+lippa*2+lidxtolerance*2-boxwall*2;
lippainw=boxoutw+lippa*2+lidytolerance*2-boxwall*2;
  
lippaoutl=boxoutl+lippa*2+lippaxyadjust;
lippaoutw=boxoutw+lippa*2+lippaxyadjust;

baseextend=ytolerance+boxwall;
baseextendl=boxoutl+baseextend*2; //boxlidsnapl;
baseextendw=boxoutw+baseextend*2;
baseextendh=2;

lippah=boxouth-boxwall+ztolerance-baseextendh-baseextend;//5;//cableholeh+boxwall;

topangle=0;

bottomleakholew=2;
bottomleakholel=bottomcutl;

boxlidsnapheight=lidsnapinside?boxouth-3:boxouth-lippah-boxwall-ztolerance+boxsnapd/2;//boxwall+boxinh-lippah;

module cardslot() {
  difference() {
    translate([-cardpilel/2-cardslotwall,-cardpilew/2-cardslotwall,-0.01]) roundedboxxyz(cardslotwall+cardpilel+cardslotwall,cardslotwall+cardpilew+cardslotwall,0.01+cardsloth,cardpilexycornerd+cardslotwall*2,cardpilezcornerd,0,90);
    translate([-cardpilel/2,-cardpilew/2,cardbaseh]) roundedboxxyz(cardpilel,cardpilew,cardsloth+0.01,cardpilexycornerd,cardpilezcornerd,0,90);
    if (0) for (m=[0,1]) mirror([0,m,0]) translate([-cardslotfinger/2,-cardpilew/2-cardslotwall-cardslotfingercornerd/2,0]) roundedbox(cardslotfinger,cardslotfingercornerd/2+cardslotwall+cardslotfingercornerd/2,cardsloth+cardslotfingercornerd/2,cardslotfingercornerd,0);
    for (m=[0,1]) mirror([m,0,0]) translate([-cardpilel/2-cardslotwall-cardslotfingercornerd/2,-cardslotfinger/2,0]) roundedbox(cardslotfingercornerd/2+cardslotwall+cardslotfingercornerd/2,cardslotfinger,cardsloth+cardslotfingercornerd/2,cardslotfingercornerd,0);
  }
  for (m=[0,1]) mirror([0,m,0]) 
  hull() {
    translate([-cardpilel/2+cardpilexycornerd/2-0.5,-cardpilew/2+cardpilexycornerd/2-0.5,cardbaseh+cardpileh-cardholdh]) cylinder(d=1,h=cardholdh);
    translate([-cardpilel/2-cardslotwall/2,-cardpilew/2+maxbridge+cardslotwall/2,cardbaseh+cardpileh-cardholdh]) cylinder(d=cardslotwall,h=cardholdh);
    translate([-cardpilel/2+maxbridge+cardslotwall/2,-cardpilew/2-cardslotwall/2,cardbaseh+cardpileh-cardholdh]) cylinder(d=cardslotwall,h=cardholdh);
  }
}

module box() {
  difference() {
    union() {
      translate([-boxoutl/2,-boxoutw/2,0]) roundedboxxyz(boxoutl,boxoutw,boxouth,largecorneroutd,cornerd,1,90);
      hull() {
	translate([-baseextendl/2,-baseextendw/2,0]) roundedboxxyz(baseextendl,baseextendw,boxwall,largecorneroutd+(boxwall+lidxtolerance)*2-lidcorneradjust,cornerd,1,90);
	translate([-boxoutl/2,-boxoutw/2,0]) roundedboxxyz(boxoutl,boxoutw,boxwall+baseextend,largecorneroutd,cornerd,1,90);
      }
    }
    translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,baseh+boxwall]) roundedboxxyz(boxinl,boxinw,boxinh+cornerd,largecornerind,cornerd,0,90);

    if (lhole) {
      translate([-boxoutl/2,-boxoutw/2,0]) translate([-cornerd/2,boxoutw/2-cableholew/2,cableholeheight]) roundedbox(boxoutl+cornerd,cableholew,boxouth+cornerd/2-cableholeheight,cornerd);
    }

    if (lidsnapinside) {
      translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx,boxwall+boxlidsnapsink,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl);
      translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx,boxoutw-boxwall-boxlidsnapsink,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl);
    } else {
      for (m=[0,1]) mirror([0,m,0]) translate([0,-boxoutw/2-boxlidsnapd/2+boxlidsnapsink,boxlidsnapheight]) tubeclip(boxlidsnapl,boxlidsnapd,dtolerance);
    }

    translate([0,boxinw/2-boxwall-textsize/2-textsize,boxwall-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
    translate([0,boxinw/2-boxwall-textsize/2,boxwall-textdepth+0.01]) linear_extrude(height=textdepth) text(text1, size=textsize-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 

    if (leakholes) {
      for (x=[bottomcutsx:bottomcutl+boxwall:bottomcutsx+bottomcutsl-1]) {
	translate([-boxoutl/2+x+boxwall/2,-boxoutw/2-0.01,-0.01]) cube([bottomcutl,boxoutw+0.02,bottomcuth+0.01]);
	for (m=[0,1]) mirror([0,m,0]) translate([-boxoutl/2+x+boxwall/2,-boxoutw/2+boxwall,-0.01]) cube([bottomleakholel,bottomleakholew,bottomcuth+boxwall+0.02]);
      }
    }
  }

  if (0) for (x=[-boxoutl/4+cardslotadjust,boxoutl/4-cardslotadjust]) {
    for (y=[-boxoutw/4+cardslotadjust,boxoutw/4-cardslotadjust]) {
      translate([x,y,boxwall]) cardslot();
    }
  }

  for (x=[-cardpilew/2-cardslotwall-cardpilew/2,0,cardpilew/2+cardslotwall+cardpilew/2]) {
    translate([x,0,boxwall]) rotate([0,0,90]) cardslot();
  }
}

module boxlid() {
  difference() {
    union() {
      hull() {
	translate([-lidoutl/2,-lidoutw/2,boxlidheight]) rotate([topangle,0,0]) roundedboxxyz(lidoutl,lidoutw,boxwall,lidoutcornerd,cornerd,2,90);
	translate([-boxoutl/2,-boxoutw/2,0]) translate([-lidxtolerance-boxwall,-lidytolerance-boxwall,boxlidheight]) roundedboxxyz(boxoutl+lidxtolerance*2+boxwall*2,boxoutw+lidytolerance*2+boxwall*2,boxwall,largecorneroutd+(boxwall+lidxtolerance)*2-lidcorneradjust,cornerd,2,90);
      }
      hull() {
	translate([-lippatopoutl/2,-lippatopoutw/2,boxlidheight]) roundedboxxyz(lippatopoutl,lippatopoutw,cornerd,lippaoutcornerd,cornerd,2,90);
	translate([-lippaoutl/2,-lippaoutw/2,boxlidheight-lippah]) roundedboxxyz(lippaoutl,lippaoutw,boxwall,lippaoutcornerd,cornerd,2,90);
      }
      translate([-boxoutl/2,-boxoutw/2,0]) translate([-lidxtolerance-boxwall,-lidytolerance-boxwall,boxlidheight-boxwall-lippah]) roundedboxxyz(boxoutl+lidxtolerance*2+boxwall*2,boxoutw+lidytolerance*2+boxwall*2,boxwall*2+lippah+cornerd,largecorneroutd+(boxwall+lidxtolerance)*2-lidcorneradjust,cornerd,2,90);
      
      if (lhole) translate([-boxoutl/2,-boxoutw/2,0]) for (x=[0,boxwall+boxinl]) {
	translate([x,boxoutw/2-cableholew/2+lidytolerance,cableholeheight+cableholeh+ztolerance]) roundedbox(boxwall,cableholew-2*lidytolerance,boxouth-cableholeheight-cableholeh-ztolerance+boxwall,cornerd,2);
      }
      if (lidsnapinside) {
	for (m=[0,1]) mirror([m,0,0]) translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall+lidxtolerance,boxwall+largecornerind/2+lidytolerance,boxouth-boxlidraise]) roundedbox(boxwall,boxinw-largecornerind-ylidtolerance*2-lidcorneradjust,boxlidraise+boxwall,cornerd);
      }
    }
    
    intersection() {
      union() {
	hull() {
	  translate([-lidinl/2,-lidinw/2,boxlidheight-cornerd]) rotate([topangle,0,0]) roundedboxxyz(lidinl,lidinw/cos(topangle)-lidytolerance*2-boxwall,cornerd,largecornerind+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
	  translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight-boxwall]) roundedboxxyz(boxinl,boxinw,boxwall,largecornerind+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
	}
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight-boxwall]) roundedboxxyz(boxinl,boxinw,boxwall,largecornerind+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
      }
      union() {
	hull() {
	  translate([-lidinl/2,-lidinw/2,boxlidheight+boxwall+boxoutw*sin(topangle)]) roundedboxxyz(lidinl,lidinw,cornerd,largecornerind+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
	  translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight+boxwall]) roundedboxxyz(boxinl,boxinw,boxoutw*sin(topangle)+boxwall,largecornerind+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
	}
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxwall,boxwall,boxlidheight-boxwall]) roundedboxxyz(boxinl,boxinw,boxoutw*sin(topangle)+boxwall,largecornerind+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
      }
    }
    translate([-lidinl/2,-lidinw/2,boxlidheight-lippah-boxwall-ztolerance-cornerd/2]) roundedboxxyz(lidinl,lidinw,lippah+boxwall+ztolerance+cornerd/2,largecorneroutd+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
    hull() {
      translate([-lidinl/2,-lidinw/2,boxlidheight-boxwall-cornerd]) roundedboxxyz(lidinl,lidinw,boxwall,largecorneroutd+lidxtolerance*2-lidcorneradjust,cornerd,0,90);
      translate([-lippainl/2,-lippainw/2,boxlidheight-lippah-boxwall]) roundedboxxyz(lippainl,lippainw,boxwall,lippaoutcornerd+lidxtolerance*2+cornerd-lidcorneradjust,cornerd,0,90);
    }

    translate([0,boxinw/2-boxwall-textsize/2-textsize,boxlidheight+textdepth-0.01]) rotate([180,0,180]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
    translate([0,boxinw/2-boxwall-textsize/2,boxlidheight+textdepth-0.01]) rotate([180,0,180]) linear_extrude(height=textdepth) text(text1, size=textsize-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }

  if (lidsnapinside) {
    for (m=[0,1]) mirror([0,m,0]) {
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+lidxtolerance,boxwall+boxlidsnapsink+lidytolerance,boxlidsnapheight+boxlidsnapd/2]) rotate([0,90,0]) cylinder(d=boxlidsnapd,h=boxlidsnapl-2*lidxtolerance);
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+lidxtolerance,boxwall+lidytolerance,boxlidsnapheight]) roundedbox(boxlidsnapl-2*lidxtolerance,boxwall,boxouth+m*boxinw*sin(topangle)-boxlidsnapheight+boxwall,cornerd);
	translate([-boxoutl/2,-boxoutw/2,0]) translate([boxlidsnapx+lidxtolerance,0,boxouth]) roundedbox(boxlidsnapl-2*lidxtolerance,boxwall+boxwall+lidytolerance,boxwall,cornerd);
      }
  } else {
    for (m=[0,1]) mirror([0,m,0]) translate([0,-boxoutw/2-boxlidsnapd/2+boxlidsnapsink,boxlidsnapheight]) tubeclip(boxlidsnapl,boxlidsnapd,0);
  }
}

if (print==0) {
  intersection() {
    if (debug==1) translate([-100-boxoutl/2,-100-boxoutw/2,-100]) cube([boxoutl/2+100,boxoutw+200,boxouth+10+200]);
    if (debug==2) translate([-100-boxoutl/2,-100-boxoutw/2,-100]) cube([boxoutl+200,boxoutw/2+100,boxouth+10+200]);
    if (debug==3) translate([-100-boxoutl/2,-100-boxoutw/2,-100]) cube([boxoutl+200,boxoutw/2+200,100+boxouth-5]);
    union() {
      box();
      translate([0,0,ztolerance]) boxlid();
    }
  }
 }

if (print==1) {
  box();
  //  translate([-0.5,boxoutw/2+0.5+boxoutw/2+lippa,0]) rotate([0,180,0])
  //translate([0,boxoutw/2+lippa+boxwall,boxouth+boxwall*2]) rotate([0,180,0]) translate([0,0,boxlidheight+boxwall]) rotate([-topangle,0,0]) translate([0,boxoutw/2-xtolerance,-boxouth-ztolerance]) boxlid();
 }
if (print==2) {
  translate([0,boxoutw/2+lippa+boxwall,boxouth+boxwall*2]) rotate([0,180,0]) translate([0,0,boxlidheight+boxwall]) rotate([-topangle,0,0]) translate([0,boxoutw/2-xtolerance,-boxouth-ztolerance]) boxlid();
 }
