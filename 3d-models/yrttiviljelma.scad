// -*-mode: C; coding: latin-1;-*-
// yrttiviljelma.scad  -  Ritila Yrttiviljelijään
// Copyright (c) 2022 Sampo Kellomaki (sampo@iki.fi), All Rights Reserved.
//
// 20221011 Aloitettu --Sampo
//
// Last Modified: 13:15 Oct 12 2022 sampo
// Version: 1.723
// Edit time: 766 min
//
// - Kaikki mitat millimetreinä (mm), yksi scad yksikkö on yksi millimetri tosielämässä
// - x y z  (leveys, syvyys, korkeys)
//
// Special prefix characters: !show only this, #red, %transparent, *do not show
// union() is the default and often need not be mentioned (except as first item of difference()).

use <libmac.scad>   // ln -s ../lib/libmac.scad
use <hsu.scad>

//use <librobo.scad>
//use <ISOThread.scad>   // from https://www.thingiverse.com/thing:311031/comments
//use <MCAD/metric_fastners.scad>  // see /usr/share/openscad/libraries/MCAD/
//use <MCAD/screw.scad>
//use <MCAD/hardware.scad>  // has rot(len, threaded), screw() and nut()
//use <MCAD/screw.scad>
//use <MCAD/nuts_and_bolts.scad>
//use <fonts.scad>
//include <MCAD/fonts.scad>
//include <Arial.scad>

PRINT=9;   // 0=normal model, 1=full top, 2=end top, 3=round cup, 4=square cover, 5=square cup, 6=round cover, 7=top with square and round holes, 8=top with two square holes, 9=storage for covers
XRAY=0;

BRIM=1;    // Include support structures for horizontal printing
VBRIM=0;   // Include support structures for vertical printing
LEGEND=0;  // Helpful legends and labels
CID=.4;

D_PIPE=6;
T_PIPE=1.5;

versiontext="v1.4";
textsize=7;
textdepth=0.7;

pyoreareika=70;
pyoreakansimaxd=pyoreareika+10+1;
nelioreuna=70;
neliokansimaxd=nelioreuna+10+1;;
kansimaxd=max(pyoreakansimaxd,neliokansimaxd);
handlewall=1.5;
handled=30;
handleoutd=handled+handlewall;
handlewt=2;
handlewl=3;
handleflat=15;
handlestart=5;
handlehadjust=handleflat/2-handlestart;

kansithickness=3+1.0+0.5;
kansigap=kansithickness+handleflat/2;
kansiwidth=kansimaxd;
kansitelinecornerd=2;
kansitelinel=kansithickness*10+9*kansigap+kansitelinecornerd+2;
kansitelinew=kansiwidth+kansitelinecornerd*2+1;
kansitelineh=1+kansiwidth/2-handleoutd/2-1;

$fn=50;
$fs=0.5;     // Make small round objects appear a bit more round
CIDZ=0.4;    // Correction of Inner diameter for holes drilled in Z direction
CIDY=0.4;
CIDX=0.4;
TPIL=0.4;      // Support pillar thickness

module T(x=0,y=0,z=0,rx=0,ry=0,rz=0) { translate([x,y,z]) rotate([rx,ry,rz]) children(0); }

module pyorea_kori() {
  difference() {
    union() {  
      tube(70,1,6);
      T(0,0,30) tube(59,60);
      T(0,0,65) hollow_cone(59,10,10);
      T(0,0,65) symxy(19,19) cyl(3,20);
    }
    for (a=[0:15:180]) {
      T(0,0,16,rz=a) cubint(5,70,20);
      T(0,0,26,ry=90,rz=a) hole(5,70);
      T(0,0,43,rz=a) cubint(5,70,20);
      T(0,0,53,ry=90,rz=a) hole(5,70);
    }
    for (a=[0:26:360]) {
      rz(a) T(12,0,65) cubint(7,2,20);
    }
    for (a=[0:15:360]) {
      rz(a) T(21,0,65) cubint(7,2,20);
    }
  }
}

module pyorea_kartio_kori() {
  difference() {
    union() {  
      tube(pyoreareika + 10,1,6);
      T(0,0,27.75) hollow_cone(pyoreareika - 1,pyoreareika - 5,56.5);
      //T(0,0,65) hollow_cone(55,5,18);  // pohja
      T(0,0,56-0.01) cylinder(h=18,d1=pyoreareika - 5,d2=5);
      T(0,0,55) cylinder(h=1,d=pyoreareika - 5);
      //T(0,0,65.5) symxy(pyoreareika/2 - 13.3,pyoreareika/2 - 13.3) cyl(3.5,19);
      T(0,0,65.5) symxy(pyoreareika/2 - 14.5,pyoreareika/2 - 14.5) cylinder(d1=7,d2=4,h=19,center=true);
    }
    T(0,0,55-0.02) cylinder(h=18.5,d1=pyoreareika - 6.8,d2=2);
    T(0,0,56+10) cylinder(h=10,d=10);
    for (a=[0:15:180]) {
      T(0,0,12,rz=a) cubint(3,70,19);
      T(0,0,21,ry=90,rz=a) hole(3,70);
      T(0,0,37,rz=a) cubint(4,70,19);
      T(0,0,46,ry=90,rz=a) hole(4,70);
    }
    for (a=[0:26:360]) {
      rz(a) T(12,0,61) cubint(7,1.5,20);
    }
    for (a=[5:15:360]) {
      rz(a) T(21,0,61) cubint(7,2,20);
    }
    translate([0,-45+textsize+2,textdepth-0.6]) rotate([180,0,180]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-2,valign="center",halign="center");
  }
}

module nelio_kartio_kori() {
  difference() {
    union() {  
      sq_tube(nelioreuna+10,nelioreuna+10,1,6,roundness=15);
      T(0,0,0) hull() {
	sq_tube(nelioreuna - 1,nelioreuna - 1,1,roundness=15);
	T(0,0,55) sq_tube(nelioreuna - 5,nelioreuna - 5,1,roundness=15);
	T(0,0,70) sq_tube(5,5,9,roundness=1);
      }
    T(0,0,65) symxy(nelioreuna/2 - 7.2,nelioreuna/2 - 7.2) cylinder(d1=7,d2=4,h=20,center=true);
    }
    T(0,0,-1) hull() {
      sq_tube(nelioreuna - 3,nelioreuna - 3,1,roundness=15);
      T(0,0,55) sq_tube(nelioreuna - 7,nelioreuna - 7,1,roundness=15);
      T(0,0,70) sq_tube(3,3,8,roundness=1);
    }
  for (y=[-21:7:21]) {
      T(0,y,16) cubint(nelioreuna+10,4,20);
      T(0,y,26,ry=90) hole(4,nelioreuna+10);
      T(0,y,40) cubint(nelioreuna+10,4,20);
      T(0,y,50,ry=90) hole(4,nelioreuna+10);
      T(y,0,16,rz=90) cubint(nelioreuna+10,4,20);
      T(y,0,26,ry=90,rz=90) hole(4,nelioreuna+10);
      T(y,0,40,rz=90) cubint(nelioreuna+10,4,20);
      T(y,0,50,ry=90,rz=90) hole(4,nelioreuna+10);
    }
  for (y=[-14:7:14]) {
    T(16+abs(y)/2,y,65) cubint(17-abs(y),2,15);    
    T(-16-abs(y)/2,y,65) cubint(17-abs(y),2,15);    
    T(y,16+abs(y)/2,65) cubint(2,17-abs(y),15);    
    T(y,-16-abs(y)/2,65) cubint(2,17-abs(y),15);    
  }
  hole(7);
  translate([0,-45+textsize+1.5,textdepth-0.6]) rotate([180,0,180]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-2,valign="center",halign="center");
}
}

module handle() {
  difference() {
    //    sphere(d=handleoutd);
    hull() {
      translate([0,0,-0.51]) cylinder(d=handleoutd+handlewall/2,h=handlestart);
      translate([0,0,handleoutd/2-handlehadjust-0.51]) cylinder(d=handleflat+handlewall,h=1);
    }
    hull() {
      translate([0,0,-0.51]) cylinder(d=handled,h=handlestart-handlewall/2);
      translate([0,0,handled/2-handlehadjust-0.51]) cylinder(d=handleflat,h=1);
    }
    translate([-handleoutd/2-0.01,-handleoutd/2-0.01,-handleoutd/2-0.51]) cube([handleoutd+0.02,handleoutd+0.02,handleoutd/2+0.51]);
  }

  hull() {
    translate([-handleoutd/2,-handlewt/2,-0.5]) cube([handleoutd,handlewl,1]);
    translate([-handleoutd/2,-handlewt/2,handlestart-0.5]) cube([handleoutd,handlewt,0.1]);
    translate([-handleflat/2,-handlewt/2,handled/2-handlehadjust-0.5]) cube([handleflat,handlewt,1]);
  }
}

module pyorea_kansi() {
  difference() {
    union() {  
      cyl(pyoreareika + 10,1);
      T(0,0,1) tube(pyoreareika-4,3);
    }
    translate([0,0,-1]) cylinder(d=handled,h=handlewall+0.1);
    translate([0,nelioreuna/2-2,0.19]) rotate([180,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
  }

  handle();
}

module nelio_kansi() {
  difference() {
    union() {
      difference() {
	union() {  
	  cub(nelioreuna + 10,nelioreuna + 10,1,roundness=15);
	  T(0,0,1.5) sq_tube(nelioreuna - 4,nelioreuna - 4,3,roundness=15);
	}
	translate([0,0,-1]) cylinder(d=handled,h=handlewall+0.1);
	translate([0,nelioreuna/2-1,0.19]) rotate([180,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
      }

      handle();
    }

    if (XRAY) {
      translate([0,0,-1]) cube([nelioreuna,nelioreuna,handleoutd]);
    }
  }
}

module ritila() {
  difference() {
    union() {
      cub(460,178,2,roundness=60);
      T(0,0,4) sq_tube(83,172,10,roundness=5);
      T(0,0,4) sq_tube(80,12,10,roundness=5);
      T(0,-nelioreuna/2 + -10,4) sq_tube(nelioreuna+5,nelioreuna + 5,6,roundness=5);
      T(0,nelioreuna/2 + 10,4) sq_tube(nelioreuna+5,nelioreuna + 5,6,roundness=5);
      T(0,0,4) symx(85) union() {
	sq_tube(83,172,10,roundness=5);
	sq_tube(80,12,10,roundness=5);
	T(0,-nelioreuna/2 + -10,0) sq_tube(nelioreuna+5,nelioreuna + 5,6,roundness=5);
	T(0,nelioreuna/2 + 10,0) sq_tube(nelioreuna+5,nelioreuna + 5,6,roundness=5);
      }
      //T(0,0,4) symx(166) sq_tube(75,172,10,roundness=5);
      T(0,0,4) symx(170) union() {
	sq_tube(83,172,10,roundness=5);
	sq_tube(80,12,10,roundness=5);
	T(0,-nelioreuna/2 + -10,0) sq_tube(nelioreuna+5,nelioreuna + 5,6,roundness=5);
	T(0,nelioreuna/2 + 10,0) sq_tube(nelioreuna+5,nelioreuna + 5,6,roundness=5);
      }
      //rulerx(0,240);
    }
    symx(230) cubint(24,51,3);
    T(0,-45,0) cubint(nelioreuna,nelioreuna,3,roundness=15);
    T(0,45,0) hole(pyoreareika,3);
    T(85,45,0) cubint(nelioreuna,nelioreuna,3,roundness=15);
    T(85,-45,0) cubint(nelioreuna,nelioreuna,3,roundness=15);
    T(-85,45,0)  hole(pyoreareika,3);
    T(-85,-45,0)  hole(pyoreareika,3);
    T(0,0,0) symxy(170,45) hole(pyoreareika,3);

    translate([200,0,-textdepth+0.3]) rotate([180,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");

    translate([80,0,-textdepth+0.3]) rotate([180,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");

    translate([0,0,-textdepth+0.3]) rotate([180,0,]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
  }
}

module kansiteline() {
  difference() {
    roundedbox(kansitelinel,kansitelinew,kansitelineh,kansitelinecornerd);
    for (i=[0:1:9]) {
      translate([kansitelinecornerd+i*(kansithickness+kansigap),kansitelinecornerd+1/2,1]) cube([kansithickness,kansiwidth,kansiwidth]);
#      translate([kansitelinecornerd+i*(kansithickness+kansigap)+1,kansitelinew/2,1+kansiwidth/2]) rotate([0,90,0]) nelio_kansi();

    }
    translate([kansitelinel/2,textdepth-0.01,kansitelineh/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,valign="center");
  }
}

rotate([0,0,0]) {
  if (PRINT==0) {
    ritila();
#      T(0,45,-1.5) pyorea_kartio_kori();
#      T(-85,46,-2) pyorea_kansi();
# T(0,-45,-1.5) nelio_kartio_kori();
#    T(85,-45,-2) nelio_kansi();
  }
  
  if (PRINT==1) {
    ritila();
  }

  if (PRINT==2) {
    intersection() {
      ritila();
      //cub(85,180,20);  // keski nelio ympyra
      //T(85,0,0) cub(85,180,20); // keski nelio nelio
      //T(-85,0,0) cub(85,180,20);
      T(180,0,0) cub(105,180,20);  // paaty
    }
  }

  if (PRINT==7) {
    intersection() {
      ritila();
      cub(85,180,20);  // keski nelio ympyra
      //T(85,0,0) cub(85,180,20); // keski nelio nelio
      //T(180,0,0) cub(105,180,20);  // paaty
    }
  }

  if (PRINT==8) {
    intersection() {
      ritila();
      //cub(85,180,20);  // keski nelio ympyra
      T(85,0,0) cub(85,180,20); // keski nelio nelio
      //T(-85,0,0) cub(85,180,20);
      //T(180,0,0) cub(105,180,20);  // paaty
    }
  }

  if (PRINT==3) {
    difference() {
      T(0,45,0) pyorea_kartio_kori();
      if (XRAY) {
	cub(100,100,300);
      }
    }
  }

  if (PRINT==4) {
    // T(0,45,0) pyorea_kansi();
    T(0,-45,0) nelio_kansi();
  }

  if (PRINT==5) {
    difference() {
      T(0,-45,0) nelio_kartio_kori();
      if (XRAY) {
	cub(90,90,300);
      }
    }
  }

  if (PRINT==6) {
    T(0,-45,0) pyorea_kansi();
  }

  if (PRINT==0) {
    difference() {
      union() {
	ritila();
      }
      if (XRAY) {
	// Y-Z plane cut off for x-ray
	T(101.1,0,140) cub(150,150,300);
	//T(0,50,140) cub(100,100,300);
      }
    }
  }
}

if (PRINT==9) {
  kansiteline();
 }


//EOF - yrttiviljelma.scad
