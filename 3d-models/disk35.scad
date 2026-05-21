// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// Box fitting to 3.5inch disk form. This is intended for use with various 3.5 inch

print=0;
debug=0;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;

maxbridge=10;
cornerd=1;

diskl=147;
diskw=xtolerance+101.6+xtolerance;
diskh=ztolerance+26.1+ztolerance;

// Pcbversion 1 is LGH-IDE-K, Pcbversion 2 is 120-3803, pcbversion 3 is gc100-30822.
// I did not have LGH-IDE-K so it has only been designed based on given measurements and may need adjusting.
pcbversion=3;

// Disk needs to be raised slightly
diskbaseh=(pcbversion==1||pcbversion==3)?0:2;

// Generic disk screwd is about 3.5mm
diskscrewholed=3.6;
diskscrewheight=6.7;
diskscrewxtable=[diskl-118.19,diskl-76.71,diskl-16.52];
diskscrewd=3;
diskscrewpenetration=6.32;
// 2.5 inch disks may be up to 12.5 thick, though 9.5 is current standard.
smalldiskh=ztolerance+9.5+ztolerance;
smalldiskmaxh=ztolerance+12.5+ztolerance;
smalldiskl=100.5; // 100.45;
smalldiskw=ytolerance+69.82+max(0.25,ytolerance);
smalldiskscrewxtable=[smalldiskl-90.6,smalldiskl-14];
smalldisksmalldiskconnectory=15;
smalldiskscrewheight=3;
smalldiskscrewd=3;

wall=1.6;
incornerd=2;
outcornerd=2+wall*2;
basecornerd=4;
coverclipdepth=0.6;
coverclipd=wall+xtolerance+coverclipdepth;

belowcoverl=diskl-xtolerance*2-wall*2;
belowcoverw=diskw-xtolerance*2-wall*2;
//belowcoverh=0.5+coverclipd+cornerd+0.5;
belowcoverh=1+coverclipd+cornerd+1;
belowcornerd=incornerd-xtolerance*2;

belowcovercutl=diskl-wall*2;
belowcovercutw=diskw-wall*2;
belowcovercuth=0.5+coverclipd+0.5;
//belowcornerd=incornerd-xtolerance*2;

coverclipl=15;
coveryclips=2;
coverxclips=3;
//coverclipsl=belowcoverl-cornerd*2-xtolerance*2-wall*2-coverclipl*2;
//coverclipsw=belowcoverw-cornerd*2-ytolerance*2-wall*2-coverclipl*2;
coverclipsl=belowcoverl-basecornerd*2-xtolerance*2-wall*2-coverclipl;
coverclipsw=belowcoverw-basecornerd*2-ytolerance*2-wall*2-coverclipl;
coverclipxtable=[diskl/2-coverclipsl/2,diskl/2-diskscrewd,diskl-(diskl/2-coverclipsl/2)-1];
covercutl=belowcoverl-wall*2;
covercutw=belowcoverw-wall*2;
covercuth=belowcoverh+cornerd;
covercutheight=diskh-wall-covercuth;
covercutx=diskl/2-covercutl/2;
covercuty=diskw/2-covercutw/2;

versiontext="V1.4";
textdepth=0.6;
textsize=7;
textfont="Liberation Sans:style=Bold";
versiontextl=textlen(versiontext,textsize)+2;

coverh=wall;
baseh=diskh-ztolerance-coverh;

coverclipheight=baseh-belowcoverh+coverclipd/2+dtolerance/2;

// This one I just ordered from aliexpress

pcbw=pcbversion==1?84:pcbversion==2?58:84.4;
pcbl=pcbversion==1?33-10:pcbversion==2?2.3:26.35+xtolerance;
pcbh=pcbversion==1?1:pcbversion==2?20:1.6;
pcbx=pcbversion==1?10:pcbversion==2?10:1.2;
pcbbelowspace=pcbversion<3?0:1.7;
pcbheight=wall+(pcbversion==1?ztolerance:pcbversion==2?ztolerance:ztolerance+pcbbelowspace);
pcbsupporth=2;
pcbtopsupporth=1.5;
pcbscrewholew=pcbw-6; // MEASURE?
pcbscrewholex=pcbl-5.5; // Relative to pcbx
pcbscrewd=3;
pcbscrewholed=3;

powerconnectorw=pcbversion==1?24.5:pcbversion==2?23.7:23.85;
powerconnectorwidew=pcbversion==1?24.5:pcbversion==2?25.5:23.85;
powerconnectorh=pcbversion<3?8.7:9.2;
powerconnectorlowh=pcbversion<3?7:9.2;
powerconnectorloww=20.5; // 20 measured
powerconnectorl=pcbversion==1?10:pcbversion==2?8.2:13;
powerconnectorx=pcbversion==1?-pcbx:pcbversion==2?-pcbx:-0.15;
powerconnectorwidel=pcbversion==1?0:pcbversion==2?2:0;
powerconnectorwidex=powerconnectorx+powerconnectorl;
powerconnectorbackw=21.5;
powerconnectorbackl=17;
powerconnectorbackx=powerconnectorwidex+powerconnectorwidel;
// This is relative to pcb
powerconnectorheight=pcbversion==1?0:pcbversion==2?-pcbheight+diskh-wall-ztolerance-powerconnectorh-ztolerance:pcbh;
powerconnectortotall=pcbversion==3?powerconnectorl:powerconnectorl+(pcbversion==2?powerconnectorwidel+powerconnectorbackl:0);
cablewayw=5;

ideconnectorw=pcbversion<3?55:58.2;//59.3;
ideconnectornotchw=5;
ideconnectornotchh=2.1;
ideconnectorh=pcbversion<3?8.2:9.2;
// This is relative to pcbx
ideconnectorx=pcbversion==1?-pcbx:pcbversion==2?-pcbx:-1.27;
// This is relative to pcbheight
ideconnectorheight=pcbversion==1?0:pcbversion==2?12:pcbh;
ideconnectorl=10;
ideconnectorcutl=wall+1;
smallideconnectorw=46;
smallideconnectorl=6;
smallideconnectorh=4.5;
smallideconnectory=pcbw/2+51.3/2-smallideconnectorw;

connectorcornerd=1;

// pcbversion3
belownotchxytable=[[2,17],
		   [2,7],
		   [10,22],
		   [10,2.5]
		   ];
belownotchd=5;
belownotchh=2.3+ztolerance; // Under pcb

belowsupporth=pcbbelowspace+ztolerance;
belowsupportsize=2;
belowbacksupportw=63;
belowcornersupportl=3;
belowcornersupportw=3;
belowcornersupportx=0;
belowcornersupporty=0;//pcbw-3;
belowmidsupportx=15;
belowmidsupportl=3;
belowmidsupportw=61;
belowsidesupportl=14;
belowsidesupportx=pcbl-belowsidesupportl;
belowsidesupporth=pcbh+4;

//connectorpcby=wall+incornerd/2+ytolerance;
//pcby=-diskw/2+connectorpcby;
pcbyfromdisky=9;
powerconnectortopcby=4;
pcby=pcbversion==1?-pcbw/2:pcbversion==2?-diskw/2+wall+powerconnectortopcby+powerconnectorwidew+wall:-pcbw/2;
powerconnectory=pcbversion==1?0:pcbversion==2?-4.5+wall-powerconnectorwidew/2-powerconnectorw/2:0.77;
powerconnectorwidey=powerconnectory+powerconnectorw/2-powerconnectorwidew/2;
powerconnectorlowy=powerconnectory+powerconnectorw/2-powerconnectorloww/2;
powerconnectorbacky=powerconnectory+powerconnectorw/2-powerconnectorbackw/2;
ideconnectory=pcbversion==1?powerconnectorw+ytolerance:pcbversion==2?-1:powerconnectory+powerconnectorw+2;
// Connector opening
connectorpcby=pcbversion==1?-pcbw/2:pcbversion==2?pcby:-pcbw/2;
tappih=ztolerance+pcbh+1;

smalldisky=pcbversion==1?-smalldiskw/2:pcbversion==2?pcby-9:-smalldiskw/2;
smalldiskx=pcbversion==1?pcbx+pcbl+1:pcbversion==2?13.4:pcbx+pcbl;//+0.5

// Sides, should be higher than tallest potential disk (12.5mm + ztolerance*2)
smalldisksidewallh=wall+ztolerance+smalldiskmaxh+ztolerance+wall+1;

// Wall support height, just under cover
sidewallh=baseh-belowcoverh;

// At the disk end, this may not be high as disk needs to be inserted on top of this
smalldiskbasewallh=wall+ztolerance+1;

// Spring plate on top of disk
plateheight=wall+diskbaseh+ztolerance+smalldiskh+ztolerance;
plateh=wall;
plateribh=5;
platel=smalldiskl;
platew=smalldiskw;
platesideslotl=-xtolerance+smalldiskl/3-xtolerance;
platesideslotw=wall+ytolerance+smalldiskw+ytolerance+wall;
platex=smalldiskx;
platey=smalldisky+platew/2;

// Springs to put pressure on disk to keep it in place
springclipdepth=0.25;
springclipd=wall+springclipdepth*2;
springclipheight=wall+xtolerance+springclipd/2; // From plate bottom
springtowerw=6;
springtowerl=3;
springtowerh=4.35;
springspacew=ytolerance+springtowerw+ytolerance;
springspacel=xtolerance+springtowerl+xtolerance;
springclipl=springspacel+cornerd*2;//springl+cornerd-1;
//springspaceh=diskh-plateheight-wall-ztolerance-ztolerance-wall;
springspaceh=wall-diskbaseh+ztolerance+springclipd/2+cornerd+0.5;//diskh-plateheight-wall-ztolerance-ztolerance-wall;
//springtowerh=wall+ztolerance+springclipd/2+cornerd+0.5;//diskh-plateheight-wall-ztolerance-ztolerance-wall;
//echo(springtowerh);
springtensionh=ztolerance+springspaceh+(smalldiskmaxh-smalldiskh)+2.5+ztolerance;
springclipy=springtowerw/2+ytolerance+wall-springclipd/2;

springl=4+xtolerance+springtowerl+xtolerance+4;
springw=4+ytolerance+springtowerw+ytolerance+2;
springheight=wall+xtolerance;
springprintable=4;
springh=0.8;

springxtable=[smalldiskl/4,smalldiskl-smalldiskl/4];
springytable=[-smalldiskw/4,smalldiskw/4];

springmidl=47;
springmidh=springtensionh/2;

springholell=springmidl/2-springl/2-2;
springholel=min(springholell,maxbridge);
springholex=(springmidl/2-springl/2)/2+springl/2-wall/2;
springholew=springw-4;

springtopl=springl;
springtoph=springtensionh;

springtappid=5;
springtappih=ztolerance+wall+ztolerance;
springtappinarrowingh=2;

springcornerd=0.5;

// Ventilation holes
holecornerd=1;
holew=6;
holegap=6;

// Back wall
holebackw=holew;
holebackh=sidewallh-wall-outcornerd/2-2;
holebackheight=outcornerd/2+2;
holebackystep=holew+holegap;
holebackystart=holegap/2;
holebackyend=diskw/2-outcornerd/2-holegap;

// Front (connector side)
holefrontw=6;
//holefrontheight=wall+ztolerance+powerconnectorh+ztolerance+2;
holefrontheight=pcbheight+powerconnectorheight+powerconnectorh+ztolerance+3;
holefronth=diskh-holefrontheight-wall-1;
holefrontystep=holew*2;
holefrontystart=holegap/2;
holefrontyend=diskw/2-outcornerd/2-holegap-holefrontw;

// Front lower (for pcbversion 2)
holefrontloww=6;
holefrontlowheight=wall+ztolerance+incornerd/2;
holefrontlowh=diskh-ideconnectorheight-wall-holefrontlowheight-1;
holefrontlowystep=holew*2;
holefrontlowholes=8;
holefrontlowholesw=holefrontlowholes*holew+(holefrontlowholes-1)*holegap;
holefrontlowystart=-holefrontlowholesw/2+holew/2; //holegap/2;
holefrontlowyend=holefrontlowholesw/2-holew/2;

// Bottom and top holes
smalldiskventilationholes=3;
flatholel=(smalldiskl-holegap*2-(smalldiskventilationholes-1)*holegap)/smalldiskventilationholes;
flatholew=holew;
flatholelgap=holegap;
flatholewgap=4;
flatholeystep=holew+flatholewgap;
flatholexstep=flatholel+flatholelgap;

// Back small disk support plate
holediskbackw=holew;
holediskbackheight=wall+diskbaseh+smalldiskbasewallh+ztolerance+2;
holediskbackh=diskh-wall-holediskbackheight-2;
holediskbackystep=holew+holegap;
holediskbackystart=smalldisky+holegap/2;
holediskbackyend=smalldisky+smalldiskw/2-holegap;

module hole(w,h,lin) {
  l=is_undef(lin)?wall*2:lin;
  hull() {
    translate([0,-w/2+holecornerd/2,holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=l+0.02,$fn=60);
    translate([0,w/2-holecornerd/2,holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=l+0.02,$fn=60);
    translate([0,-w/2+holecornerd/2,h-holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=l+0.02,$fn=60);
    translate([0,w/2-holecornerd/2,h-holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=l+0.02,$fn=60);
  }
}

module flathole(l,w,hin) {
  h=is_undef(hin)?wall:hin;
  hull() {
    translate([-l/2+holecornerd/2,-w/2+holecornerd/2,-0.01]) cylinder(d=holecornerd,h=h+0.02,$fn=60);
    translate([-l/2+holecornerd/2,w/2-holecornerd/2,-0.01]) cylinder(d=holecornerd,h=h+0.02,$fn=60);
    translate([l/2-holecornerd/2,-w/2+holecornerd/2,-0.01]) cylinder(d=holecornerd,h=h+0.02,$fn=60);
    translate([l/2-holecornerd/2,w/2-holecornerd/2,-0.01]) cylinder(d=holecornerd,h=h+0.02,$fn=60);
  }
}

// At plate bottom
module springtower() {
  difference() {
    translate([-springtowerl/2,-springtowerw/2,0]) roundedbox(springtowerl,springtowerw,springtowerh,cornerd,0);
    for (m=[0,1]) mirror([0,m,0]) translate([0,-springclipy,springclipheight]) tubeclip(springclipl,springclipd,dtolerance);
  }
}

module springbar() {
  translate([0,-springw/2,0]) roundedbox(springh,springw,springh,springcornerd,springprintable);
}

module spring() {
  difference() {
    union() {
      difference() {
	translate([-springl/2,-springw/2,springheight]) roundedbox(springl,springw,wall,springcornerd,springprintable);
	translate([-springspacel/2,-springspacew/2,springheight-0.01]) cube([springspacel,springspacew,wall+0.02]);
      }

      for (m=[0,1]) mirror([m,0,0]) {
	hull() {
	  translate([-springl/2,0,springheight]) springbar();
	  translate([-springmidl/2,0,springheight+springmidh]) springbar();
	}
	hull() {
	  translate([-springmidl/2,0,springheight+springmidh]) springbar();
	  translate([-springl/2,0,springheight+springtoph+wall-springh]) springbar();
	}
      }

      difference() {
	translate([-springl/2,-springw/2,springheight+springtoph]) roundedbox(springl,springw,wall,springcornerd,springprintable);
	translate([0,0,springheight+springtoph-0.01]) hull() {
	  d=springtappid+dtolerance;
	  cylinder(d=d,h=wall+0.02,$fn=30);
	  translate([-d/4,0,0]) cube([d/2,d/2,wall+0.02]);
	}
      }

      for (m=[0,1]) mirror([0,m,0]) translate([0,-springclipy,springclipheight]) tubeclip(springclipl,springclipd,0);
    }

    for (m=[0,1]) mirror([m,0,0]) {
	translate([springholex-springholel/2,-springholew/2,0]) roundedbox(springholel,springholew,springheight+springtoph+wall,cornerd,0);
      }

    translate([0,springw/2-cornerd/2,springheight+springtoph+wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext,size=(springw-springtappid-dtolerance-springcornerd-2)/2,valign="top",halign="center");
  }
}

ribytable=[-smalldiskw/2,springytable[0]-springw/2-ytolerance-wall,springytable[0]+springw/2+ytolerance,-wall/2];

module plate() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([0,-smalldiskw/2,0]) roundedbox(platel,platew,plateh,cornerd,1);
	  translate([platel/2-platesideslotl/2,-platesideslotw/2,0]) roundedbox(platesideslotl,platesideslotw,plateh,cornerd,1);

	  for (x=springxtable) {
	    for (y=springytable) {
	      translate([x,y,0]) springtower();
	    }
	  }

	  // Ribs to make it more stiff
	  for (m=[0,1]) mirror([0,m,0]) for (y=ribytable) {
	      hull() {
		translate([0,y,0]) roundedbox(wall,wall,plateh,cornerd,1);
		translate([springxtable[0]-wall/2,y,0]) roundedbox(wall,wall,plateribh,cornerd,1);
		translate([springxtable[1]-wall/2,y,0]) roundedbox(wall,wall,plateribh,cornerd,1);
		translate([smalldiskl-wall,y,0]) roundedbox(wall,wall,plateh,cornerd,1);
	      }
	    }

	  for (m=[0,1]) mirror([0,m,0]) {
	    hull() {
	      translate([smalldiskl/2-wall/2,-smalldiskw/2,0]) roundedbox(wall,wall,plateribh,cornerd,1);
	      translate([smalldiskl/2-wall/2,springytable[0]-springw/2-ytolerance-wall,0]) roundedbox(wall,wall,plateribh,cornerd,1);
	      translate([smalldiskl/2-wall/2,0,0]) roundedbox(wall,wall,plateribh,cornerd,1);
	    }
	
	    for (x=[smalldiskl/4-wall/2,smalldiskl-smalldiskl/4-wall/2]) {
	      hull() {
		translate([x,springytable[0]+springw/2+ytolerance,0]) roundedbox(wall,wall,plateribh,cornerd,1);
		translate([x,0,0]) roundedbox(wall,wall,plateribh,cornerd,1);
	      }
	      hull() {
		translate([x,springytable[0]-springw/2-ytolerance-wall,0]) roundedbox(wall,wall,plateribh,cornerd,1);
		translate([x,-platew/2,0]) roundedbox(wall,wall,plateribh,cornerd,1);
	      }
	    }
	  }
	}

	// Cut ventilation holes to the plate
	for (m=[0,1]) mirror([0,m,0]) {
	    for (x=[smalldiskl/4:smalldiskl/4:smalldiskl]) {
	      for (y=[(ribytable[0]+ribytable[1]+wall)/2,(ribytable[2]+ribytable[3]+wall)/2]) {
		translate([x-smalldiskl/8,y,0]) flathole(platel/5,platew/12);
	      }
	    }
	    translate([platel/2,0,0]) for (n=[0,1]) mirror([n,0,0]) translate([platel/4,0,0]) for (m=[0,1]) mirror([m,0,0]) for (y=[(ribytable[1]+ribytable[2]+wall)/2]) {
		  translate([-platel/8-springl/4,y,0]) flathole(platel/4-springl,springw-2);
		}
	  }

      }
      translate([platel/2-versiontextl-cornerd/2,cornerd/2,0]) roundedbox(versiontextl+cornerd/2,textsize+1+wall/2,plateh,cornerd,1);
    }

    // Open connectorhole
    // XXX what was this for?
    // translate([-platex,-platey+pcby,-plateheight+wall+pcbheight]) connectorcuts();
    translate([-platex+powerconnectorbackx,-platey+pcby+powerconnectorbacky-ytolerance,-plateheight+powerconnectorheight-10]) roundedbox(powerconnectorbackl+xtolerance,powerconnectorbackw+ytolerance*2,10+powerconnectorh,0);
    
    translate([platel/2-cornerd/2-versiontextl/2,wall/2+0.5+textsize/2,plateh-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
  }
}

module smalldisk() {
  translate([0,0,0]) roundedbox(smalldiskl,smalldiskw,smalldiskh,cornerd,0);
}

module contactpcb() {
  difference() {
    union() {
      hull() {
	translate([powerconnectorx,powerconnectory,powerconnectorheight]) roundedbox(powerconnectorl+0.01,powerconnectorw,powerconnectorlowh,connectorcornerd,0);
	translate([powerconnectorx,powerconnectorlowy,powerconnectorheight]) roundedbox(powerconnectorl+0.01,powerconnectorloww,powerconnectorh,connectorcornerd,0);
      }
      if (pcbversion==2) {
	translate([powerconnectorx+powerconnectorl-0.01,powerconnectory-(powerconnectorwidew-powerconnectorw)/2,powerconnectorheight]) roundedbox(powerconnectorwidel+0.01,powerconnectorwidew,powerconnectorh,connectorcornerd,0);
	translate([powerconnectorx+powerconnectorl+powerconnectorwidel-connectorcornerd/2.01,powerconnectory-(powerconnectorbackw-powerconnectorw)/2,powerconnectorheight]) roundedbox(powerconnectorbackl+connectorcornerd/2.01,powerconnectorbackw,powerconnectorh,connectorcornerd,0);
      }
      translate([ideconnectorx,ideconnectory,ideconnectorheight]) roundedbox(ideconnectorl,ideconnectorw,ideconnectorh,connectorcornerd,0);
      translate([-(pcbversion==1?xtolerance:pcbversion==2?0:0),0,0]) roundedbox(pcbl+(pcbversion==1?xtolerance:pcbversion==2?0:0),pcbw,pcbh,connectorcornerd,0);
      if (pcbversion==1 || pcbversion==3) {
	translate([pcbl-smallideconnectorl,smallideconnectory,0]) roundedbox(smallideconnectorl+0.01,wall,smallideconnectorh,0);
	translate([pcbl-smallideconnectorl,smallideconnectory+smallideconnectorw-wall,0]) roundedbox(smallideconnectorl+0.01,wall,smallideconnectorh,0);
      }
      if (debug) translate([pcbl,smallideconnectory,0]) roundedbox(smallideconnectorl+0.01,smallideconnectorw,smallideconnectorh,0);
    }

    if (pcbversion==1) {
      translate([pcbscrewholex,pcbw/2-pcbscrewholew/2,-0.01]) cylinder(d=pcbscrewd+dtolerance,h=pcbh+0.02,$fn=60);
      translate([pcbscrewholex,pcbw/2+pcbscrewholew/2,-0.01]) cylinder(d=pcbscrewd+dtolerance,h=pcbh+0.02,$fn=60);
    }
    
    if (pcbversion==1 || pcbversion==3) {
      translate([(pcbl-(pcbversion==1?powerconnectorl:0))/2,pcbw/2,pcbh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
    }
  }
}

module connectorcuts(base) {
  translate([ideconnectorx-connectorcornerd/2.01,ideconnectory-ytolerance,ideconnectorheight-ztolerance]) roundedbox(ideconnectorcutl+connectorcornerd,ideconnectorw+ytolerance*2,ideconnectorh+ztolerance*2,connectorcornerd,0);
  translate([ideconnectorx-connectorcornerd/2,ideconnectory+ideconnectorw/2-ideconnectornotchw/2,ideconnectorheight-ztolerance]) roundedbox(ideconnectorcutl+connectorcornerd,ideconnectornotchw+ytolerance*2,ideconnectorh+ideconnectornotchh+ztolerance*2,connectorcornerd,0);
  hull() {
    translate([powerconnectorx-0.01,powerconnectory-ytolerance,powerconnectorheight-ztolerance]) cube([powerconnectorl+(pcbversion==2?powerconnectorwidel:0)+0.01,powerconnectorw+ytolerance*2,powerconnectorlowh+ztolerance*2+(base?cornerd/2:0)]);
    translate([powerconnectorx-0.01,powerconnectorlowy-ytolerance,powerconnectorheight-ztolerance]) cube([powerconnectorl+(pcbversion==2?powerconnectorwidel:0)+0.01,powerconnectorloww+ytolerance*2,powerconnectorh+ztolerance*2+(base?cornerd/2:0)]);
  }

  if (pcbversion==3) {
    for (i=[0:1:len(belownotchxytable)-1]) {
	translate([belownotchxytable[i][0],belownotchxytable[i][1],-belownotchh]) roundedcylinder(belownotchd,belownotchh,connectorcornerd,0,90);
    }
  }
  
  if (pcbversion==2) {
    translate([powerconnectorx+powerconnectorl-xtolerance,powerconnectory-(powerconnectorwidew-powerconnectorw)/2-ytolerance,powerconnectorheight-ztolerance]) roundedbox(powerconnectorwidel+xtolerance*2,powerconnectorwidew+ytolerance*2,powerconnectorh+ztolerance*2+(base?cornerd/2:0),connectorcornerd,0);
    translate([powerconnectorx+powerconnectorl-xtolerance+powerconnectorwidel-connectorcornerd/2.01,powerconnectory-(powerconnectorbackw-powerconnectorw)/2-ytolerance,powerconnectorheight-ztolerance]) roundedbox(powerconnectorbackl+connectorcornerd/2+xtolerance*2,powerconnectorbackw+ytolerance*2,powerconnectorh+ztolerance*2+(base?cornerd/2:0),connectorcornerd,0);

    // Space for cable
    translate([powerconnectorx+powerconnectorl+powerconnectorwidel-wall,-pcby+smalldisky-ytolerance-wall-cablewayw,-pcbheight+wall]) roundedbox(powerconnectorbackl,cablewayw,-wall+powerconnectorheight+powerconnectorh,connectorcornerd,0);
    hull() {
      translate([powerconnectorx+powerconnectorl+powerconnectorwidel-wall,-pcby+smalldisky-cablewayw,-pcbheight+wall+powerconnectorheight/2]) roundedbox(cablewayw,cablewayw*2-wall,-wall+powerconnectorheight/2+wall+connectorcornerd/2,connectorcornerd,0);
      translate([powerconnectorx+powerconnectorl+powerconnectorwidel-wall,-cablewayw-wall-ytolerance,-pcbheight+wall]) roundedbox(cablewayw,cablewayw,wall,connectorcornerd,0);
    }
    hull() {
      translate([powerconnectorx+powerconnectorl+powerconnectorwidel-wall,-pcby+smalldisky-cablewayw,-pcbheight+wall+powerconnectorheight/2]) roundedbox(cablewayw,cablewayw*2-wall,-wall+powerconnectorheight/2+wall+connectorcornerd/2,connectorcornerd,0);
      translate([powerconnectorx+powerconnectorl+powerconnectorwidel-wall,-pcby+smalldisky-cablewayw,-pcbheight+wall+powerconnectorheight-wall]) roundedbox(cablewayw*2,cablewayw*2-wall,wall+connectorcornerd/2,connectorcornerd,0);
    }
  }
}

module screwholes() {
  // Open screw holes
  for (x=diskscrewxtable) {
    for (m=[0,1]) mirror([0,m,0]) {
	translate([x,-diskw/2-0.01,wall+diskscrewheight]) {
	  hull() {
	    rotate([-90,0,0]) cylinder(d=diskscrewholed,h=diskscrewpenetration+0.02,$fn=30);
	    translate([-diskscrewholed/4,0,0]) cube([diskscrewholed/2,diskscrewpenetration+0.02,diskscrewholed/2]);
	  }
	}
      }
  }
}

module coverclips(t) {
  // Cover clips
  for (y=[-coverclipsw/2,0,coverclipsw/2]) {
    for (x=[diskl-coverclipd/2]) {
      translate([x,y,coverclipheight]) rotate([0,0,90]) tubeclip(coverclipl,coverclipd,t);
    }
  }

  for (x=coverclipxtable) {
    for (y=[coverclipd/2,diskw-coverclipd/2]) {
      translate([x,-diskw/2+y,coverclipheight]) tubeclip(coverclipl,coverclipd,t);
    }
  }
}


module disk35() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([diskl/2-belowcoverl/2,-belowcoverw/2,0]) roundedboxxyz(belowcoverl,belowcoverw,baseh,outcornerd,cornerd,1,90);
	  translate([0,-diskw/2,0]) roundedboxxyz(diskl,diskw,baseh-belowcoverh,outcornerd,basecornerd,1,90);
	}
	
	translate([wall,-diskw/2+wall,wall]) roundedbox(diskl-wall*2,diskw-wall*2,baseh-belowcoverh-wall*2-coverh,incornerd,0);
	translate([wall,-diskw/2+wall,wall+incornerd/2]) roundedboxxyz(diskl-wall*2,diskw-wall*2,baseh-belowcoverh-wall*2-coverh-incornerd/2,incornerd,0,0,90);
	hull() {
	  translate([wall,-diskw/2+wall,baseh-belowcoverh-wall*2-0.1]) roundedboxxyz(diskl-wall*2,diskw-wall*2,0.1,incornerd,0,0,90);
	  translate([diskl/2-belowcoverl/2+wall,-belowcoverw/2+wall,baseh-belowcoverh]) roundedboxxyz(belowcoverl-wall*2,belowcoverw-wall*2,0.1,incornerd,0,0,90);
	}
	translate([diskl/2-belowcoverl/2+wall,-belowcoverw/2+wall,baseh-belowcoverh]) roundedboxxyz(belowcoverl-wall*2,belowcoverw-wall*2,belowcoverh+0.01,incornerd,0,0,90);

	difference() {
	  translate([-0.01,-diskw/2-0.01,baseh-belowcoverh]) roundedboxxyz(diskl+0.02,diskw+0.02,belowcoverh+coverh,incornerd,0,0,90);
	  translate([diskl/2-belowcoverl/2,-belowcoverw/2,baseh-belowcoverh]) roundedboxxyz(belowcoverl,belowcoverw,belowcoverh,incornerd,0,0,90);
	}

	// Space for pcb
	if (pcbversion==1) {
	  translate([pcbx-0.01,connectorpcby,pcbheight-ztolerance]) cube([pcbl+0.02,ytolerance+pcbw+ytolerance,diskh-wall-ztolerance]);

	  // Power connector
	  translate([-0.01,pcby+powerconnectory-ytolerance,pcbheight+powerconnectorheight-ztolerance]) cube([powerconnectorl,powerconnectorw+ytolerance*2,diskh+powerconnectorh-powerconnectorheight]);
	  // Ide Connector
	  translate([-0.01,pcby+ideconnectory-ytolerance,pcbheight+ideconnectorheight-ztolerance]) cube([ideconnectorl,ideconnectorw+ytolerance*2,diskh+ideconnectorh-powerconnectorheight]);
	}
	
	if (pcbversion==2) {
	  // Power connector
	  translate([-0.01,pcby+powerconnectory-ytolerance,pcbheight+powerconnectorheight-ztolerance]) cube([powerconnectorl,powerconnectorw+ytolerance*2,diskh+powerconnectorh-powerconnectorheight]);
	  // Ide Connector
	  translate([-0.01,pcby+ideconnectory-ytolerance,pcbheight+ideconnectorheight-ztolerance]) cube([ideconnectorl,ideconnectorw+ytolerance*2,diskh+ideconnectorh-powerconnectorheight]);
	}

	if (pcbversion==3) {
	  hull() {
	    translate([pcbx-0.01,connectorpcby,pcbheight-ztolerance]) cube([pcbl+0.02,ytolerance+pcbw+ytolerance,pcbh+powerconnectorh]);
	    translate([pcbx+wall-0.01,connectorpcby+wall,pcbheight-ztolerance]) cube([pcbl-wall+0.02,ytolerance+pcbw+ytolerance-wall*2,pcbh+powerconnectorh+wall*2]);
	  }

	  // Power connector
	  translate([-0.01,pcby+powerconnectory-ytolerance,pcbheight+powerconnectorheight-ztolerance]) cube([powerconnectorl,powerconnectorw+ytolerance*2,diskh+powerconnectorh-powerconnectorheight]);
	  // Ide Connector
	  translate([-0.01,pcby+ideconnectory-ytolerance,pcbheight+ideconnectorheight-ztolerance]) cube([ideconnectorl,ideconnectorw+ytolerance*2,diskh+ideconnectorh-powerconnectorheight]);
	  // Cut of small spike between power and ide connectors
	  translate([-0.01,pcby+powerconnectory-ytolerance,pcbheight+powerconnectorheight-ztolerance+2]) cube([powerconnectorl,pcbw,diskh]);
	}
	
	coverclips(dtolerance);
      }

      // Disk base raise
      translate([smalldiskx,smalldisky-xtolerance-wall,0]) roundedbox(smalldiskl+xtolerance+wall,smalldiskw+xtolerance*2+wall*2,wall+diskbaseh,cornerd,0);
      
      // Pcb supports
      if (pcbversion==1) {
	for (y=[-pcbscrewholew/2,pcbscrewholew/2]) {
	  translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,0]) roundedcylinder(pcbscrewd,wall+ztolerance+pcbh+tappih,cornerd,0,60);
	}
      }

      if (pcbversion==2) {
	translate([pcbx-xtolerance-wall,pcby-ytolerance-wall,0]) roundedbox(wall,wall+ytolerance+pcbw+ytolerance+wall,wall+pcbsupporth,cornerd,0);
	for (y=[pcby-ytolerance-wall,pcby+pcbw+ytolerance]) translate([pcbx-xtolerance-wall,y,0]) roundedbox(wall+xtolerance+pcbl,wall,wall+pcbsupporth,cornerd,0);
      }

      if (pcbversion==3) {
	translate([pcbx,pcby+pcbw-belowsupportsize,0]) roundedbox(pcbl,belowsupportsize,wall+belowsupporth,cornerd,0);
	translate([pcbx,pcby+pcbw-belowbacksupportw,0]) roundedbox(belowsupportsize,belowbacksupportw,wall+belowsupporth,cornerd,0);
	for (x=[pcbx,pcbx+pcbl-belowmidsupportl]) translate([x,pcby+belowcornersupporty,0]) roundedbox(belowcornersupportl,belowcornersupportw,wall+belowsupporth,cornerd,0);
	translate([belowmidsupportx,pcby+pcbw-belowmidsupportw,0]) roundedbox(belowmidsupportl,belowmidsupportw,wall+belowsupporth,cornerd,0);
	for (y=[pcby-ytolerance-belowsupportsize,pcby+pcbw+ytolerance]) {
	  translate([pcbx+belowsidesupportx,y,0]) roundedbox(belowsidesupportl,belowsupportsize,pcbheight+belowsidesupporth,cornerd,0);
	}
      }
      
      // Structures around the disk to keep it in place
      translate([smalldiskx+smalldiskl+xtolerance,smalldisky-ytolerance-wall,0]) roundedbox(wall,wall+ytolerance+smalldiskw+ytolerance+wall,wall+diskbaseh+smalldiskbasewallh,cornerd,0);
      for (y=[smalldisky-ytolerance-wall,smalldisky+smalldiskw+ytolerance]) {
	translate([smalldiskx,y,0]) roundedbox(smalldiskl/3,wall,smalldisksidewallh,cornerd,0);
	translate([smalldiskx+smalldiskl-smalldiskl/3,y,0]) roundedbox(smalldiskl/3+xtolerance+wall,wall,smalldisksidewallh,cornerd,0);
      }

      for (x=[smalldiskx,smalldiskx+smalldiskl-smalldiskl/3]) {
	difference() {
	  union() {
	    hull() {
	      translate([x,-diskw/2+wall+ytolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	      translate([x,-diskw/2+0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	      translate([x,-diskw/2+outcornerd/2,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	      translate([x,smalldisky-ytolerance-wall,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	    }
	
	    hull() {
	      translate([x,smalldisky+smalldiskw+ytolerance,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	      translate([x,diskw/2-outcornerd/2-wall,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	      translate([x,diskw/2-wall-0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	      translate([x,diskw/2-wall*2-xtolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	    }
	  }
	  
	  if (pcbversion==1 || pcbversion==3 || x>smalldiskx) {
	    for (m=[0,1]) mirror([0,m,0]) translate([x-holecornerd/2,smalldisky-ytolerance-wall-2-holew,wall+1]) roundedbox(wall+holecornerd,holew,sidewallh-wall-1-4,holecornerd,0);
	  }
	}
      }

      for (i=[0:1:len(coverclipxtable)-1]) {
	xx=coverclipxtable[i];
	for (x=[-coverclipl/2+xx-wall,coverclipl/2+xx]) {
	  hull() {
	    translate([x,-diskw/2+wall+ytolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	    translate([x,-diskw/2+0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	    translate([x,-diskw/2+outcornerd/2,0]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	    if (x>smalldiskx) {
	      if (pcbversion==2 && x<powerconnectorbackx+powerconnectorbackl) {
		translate([x,smalldisky-ytolerance-wall-wall,0]) roundedbox(wall,wall,sidewallh,cornerd,0);
	      } else {
		translate([x,smalldisky-ytolerance-wall-wall,0]) roundedbox(wall,wall,wall,cornerd,0);
	      }
	    } else {
	      translate([x,pcbversion==2?smalldisky-ytolerance-wall-cablewayw:pcby-ytolerance-wall,0]) roundedbox(wall,wall,wall+(pcbversion==1?pcbh:0),cornerd,0);
	    }
	  }
	  
	  hull() {
	    translate([x,diskw/2-wall-wall+ytolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	    translate([x,diskw/2-wall-0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	    translate([x,diskw/2-wall-outcornerd/2,0]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	    if (x>smalldiskx) {
	      translate([x,smalldisky+smalldiskw+ytolerance+wall,0]) roundedbox(wall,wall,wall,cornerd,0);
	    } else {
	      translate([x,pcby+pcbw+ytolerance,0]) roundedbox(wall,wall,wall+(pcbversion==1?pcbh:0),cornerd,0);
	    }
	  }
	}
      }

      if (pcbversion==2) {
	h=pcbheight+powerconnectorheight-wall;
	hull() {
	  translate([outcornerd/2,-diskw/2+outcornerd/2,0]) roundedbox(wall,powerconnectorw,wall,cornerd,0);
	  translate([wall,-diskw/2+wall+ytolerance,h]) roundedboxxyz(powerconnectorl+powerconnectorwidel+wall,y+powerconnectorw+ytolerance,diskh-wall-belowcoverh-h-ztolerance,outcornerd,cornerd,0,90);
	}
	y=pcby+diskw/2+powerconnectory;
	translate([wall+xtolerance,-diskw/2+wall+ytolerance,h]) roundedboxxyz(powerconnectorl+powerconnectorwidel+wall-xtolerance,y+powerconnectorw+ytolerance,diskh-wall-h-ztolerance,outcornerd,cornerd,0,90);
      }
    }

    // Ventilation holes in bottom
    yholes=floor((smalldiskw-holegap-flatholew/2)/flatholeystep);
    w=yholes*flatholew+(yholes-1)*holegap/2;
    for (x=[smalldiskx+flatholelgap+flatholel/2:flatholexstep:smalldiskx+smalldiskl-flatholelgap]) {
	for (y=[holegap/2+flatholew/2:flatholeystep:smalldiskw/2]) {
	  translate([x,smalldisky+smalldiskw/2+y,0]) flathole(flatholel,flatholew,wall+diskbaseh);
	  translate([x,smalldisky+smalldiskw/2-y,0]) flathole(flatholel,flatholew,wall+diskbaseh);
	}
      }

    // Ventilation holes in back
    for (m=[0,1]) mirror([0,m,0]) for (y=[holebackystart:holebackystep:holebackyend]) {
	translate([diskl-wall*2-0.01,y+holebackw/2,holebackheight]) {
	  hole(holebackw,holebackh);
	}
      }

    // Ventilation holes in front
    if (pcbversion==2) {
      for (i=[0:1:holefrontlowholes-1]) {
	y=holefrontlowystart+i*holefrontlowystep;
	l=(i==0)?smalldiskx+wall*2:(i==1)?powerconnectorl+powerconnectorwidel:wall;
	translate([-0.01,y,holefrontlowheight]) hole(holefrontloww,holefrontlowh,l);
      }
    }

    // Open connectorhole
    translate([pcbx,pcby,pcbheight]) connectorcuts(1);
	
    screwholes();

    translate([textsize+2,0,textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
    translate([pcbversion==1?textsize+2:diskl-textsize-2,0,wall-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
  }
}

module cover() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([0,-diskw/2,diskh-wall-belowcoverh]) roundedboxxyz(diskl,diskw,belowcoverh+wall,outcornerd,cornerd,2,90);
	}

	translate([diskl/2-belowcovercutl/2,-belowcovercutw/2,diskh-wall-belowcoverh-0.01]) roundedboxxyz(belowcovercutl,belowcovercutw,belowcoverh+0.01,belowcornerd,0,0,90);
      }
  
      for (x=springxtable) {
	for (y=springytable) {
	  hull() {
	    translate([platex+x,platey+y,diskh-wall-springtappih]) roundedcylinder(springtappid,springtappih+wall,cornerd,2,30);
	    translate([platex+x,platey+y,diskh-wall-springtappih-springtappinarrowingh]) cylinder(d1=springtappid/2,d2=springtappid,h=springtappinarrowingh,$fn=30);
	  }
	}
      }

      if (pcbversion==2) {
	h=pcbheight+pcbh+ztolerance-pcbtopsupporth;
	for (x=[pcbx-xtolerance-wall,pcbx+pcbl+xtolerance]) translate([x,pcby-xtolerance-wall,h]) roundedbox(wall,wall+xtolerance+pcbw+xtolerance+wall,diskh-h,cornerd,0);
	for (y=[pcby-xtolerance-wall,pcby+pcbw+ytolerance]) translate([pcbx-xtolerance-wall,y,h]) roundedbox(wall+xtolerance+pcbl+xtolerance+wall,wall,diskh-h,cornerd,0);
	translate([pcbx-xtolerance-wall,pcby-ytolerance-wall,h+pcbtopsupporth]) roundedbox(wall+xtolerance+pcbl+xtolerance+wall,wall+ytolerance+pcbw+ytolerance+wall,diskh-h-pcbtopsupporth,cornerd,0);
      }
      
      // Connector hole
      if (pcbversion==1) {
	ch=wall+ztolerance+powerconnectorh+ztolerance;
	//translate([0,connectorpcby+ytolerance,ch]) roundedbox(wall,pcbw,diskh-ch,cornerd,2);
	translate([0,pcby+powerconnectory,ch]) roundedbox(wall,powerconnectorw+2,diskh-ch,cornerd,2);
	translate([0,pcby+ideconnectory-2,ch]) roundedbox(wall,ideconnectorw+2,diskh-ch,cornerd,2);
	for (y=[pcby+powerconnectory,-wall/2,pcby+ideconnectory+ideconnectorw-wall]) {
	  hull() {
	    translate([0,y,ch]) roundedbox(wall,wall,diskh-ch,cornerd,2);
	    translate([10,y,diskh-wall]) roundedbox(wall,wall,wall,cornerd,2);
	  }
	}
      }
      
      if (pcbversion==3) {
	ch=pcbheight+ztolerance+powerconnectorheight+powerconnectorh+ztolerance;
	translate([0,pcby+powerconnectory,ch]) roundedbox(wall,powerconnectorw+2,diskh-ch,cornerd,2);
	translate([0,pcby+ideconnectory-2,ch]) roundedbox(wall,ideconnectorw+2,diskh-ch,cornerd,2);
	for (y=[pcby+powerconnectory,-wall/2,pcby+ideconnectory+ideconnectorw-wall]) {
	  hull() {
	    translate([0,y,ch]) roundedbox(wall,wall,diskh-ch,cornerd,2);
	    translate([10,y,diskh-wall]) roundedbox(wall,wall,wall,cornerd,2);
	  }
	}
      }
      
      // Cover clips
      coverclips(0);

      // Pcb supports
      if (pcbversion==1) {
	for (y=[-pcbscrewholew/2,pcbscrewholew/2]) {
	  ph=wall+ztolerance+pcbh+ztolerance;
	  h=wall+ztolerance+pcbh+tappih+ztolerance;
	  difference() {
	    union() {
	      hull() {
		translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,h]) roundedcylinder(wall,diskh-h,cornerd,0,60);
		translate([pcbx+pcbscrewholex-(diskh-h)/2,pcby+pcbw/2+y,diskh-wall]) roundedcylinder(wall,wall,cornerd,0,60);
	      }
	      hull() {
		translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,h]) roundedcylinder(wall,diskh-h,cornerd,0,60);
		translate([pcbx+pcbscrewholex,pcby+pcbw/2+y-sign(y)*(diskh-h)/2,diskh-wall]) roundedcylinder(wall,wall,cornerd,0,60);
	      }
	      translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,ph]) roundedcylinder(pcbscrewd+wall*2,diskh-ph,cornerd,0,60);
	    }
	    translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,0]) roundedcylinder(pcbscrewd+dtolerance,h+ztolerance,cornerd,0,60);
	  }
	}
      }

      // Back of disk wall
      h=wall+diskbaseh+smalldiskbasewallh+ztolerance;
      translate([smalldiskx+smalldiskl+xtolerance,smalldisky,h]) roundedbox(wall,smalldiskw,diskh-h,cornerd,0);
      for (y=[0,smalldiskw/2-wall/2,smalldiskw-wall]) {
	hull() {
	  translate([smalldiskx+smalldiskl+xtolerance,smalldisky+y,h]) roundedbox(wall*2,wall,diskh-h,cornerd,0);
	  translate([smalldiskx+smalldiskl+xtolerance+6,smalldisky+y,diskh-wall]) roundedbox(wall,wall,wall,cornerd,0);
	}
      }
    }

    // Ventilation holes on cover
    holesl=flatholel*4+holegap*3;
    yholes=floor((diskw-flatholeystep)/flatholeystep)-1;
    yholesw=yholes*flatholew+(yholes-holegap)*holegap;
    
    difference() {
      for (i=[0:1:yholes-1]) {
	for (j=((pcbversion==1||pcbversion==3)?[(i>0?0:0):1:3]:[(i<2?1:0):1:3])) {
	  x=diskl/2-holesl/2+flatholel/2+j*holesl/4;
	  y=-yholesw/2-flatholeystep/2+i*flatholeystep;
	  translate([x,y,diskh-wall]) flathole(flatholel,flatholew);
	}
      }

      translate([smalldiskx+smalldiskl-wall,-diskw/2+wall,diskh-wall-0.01]) roundedbox(6+wall+wall,diskw-wall*2,wall+0.02,cornerd,0);
      
      for (x=springxtable) {
	for (y=springytable) {
	  translate([platex+x,platey+y,diskh-wall-0.01]) roundedcylinder(springl+holegap,wall+0.02,cornerd,2,90);
	}
      }

      if (pcbversion==1) {
	for (m=[0,0]) mirror([0,m,0]) {
	    hull() {
	      translate([pcbx+pcbscrewholex,pcbscrewholew/2,diskh-wall]) roundedcylinder(pcbscrewd+wall*2+dtolerance+cornerd,wall,cornerd,0,60);
	      translate([pcbx+pcbscrewholex,diskw/4,diskh-wall]) roundedcylinder(pcbscrewd+wall*2+dtolerance+cornerd,wall,cornerd,0,60);
	    }
	  }
      }
    }

    if (pcbversion==1) {
      for (m=[0,1]) mirror([0,m,0]) for (y=[holefrontystart:holefrontystep:holefrontyend]) {
	  translate([-0.01,y+holefrontw/2,holefrontheight]) {
	    hole(holefrontw,holefronth);
	  }
	}
    }

    if (pcbversion==3) {
      for (m=[0,1]) mirror([0,m,0]) for (y=[holefrontystart:holefrontystep:holefrontyend]) {
	  translate([-0.01,y+holefrontw/2,holefrontheight]) {
	    hole(holefrontw,holefronth);
	  }
	}
    }

    backyholes=floor((smalldiskw/2-flatholeystep)/flatholeystep)-1;
    w=backyholes*flatholew+(backyholes-1)*holegap/2;
    translate([0,smalldisky+smalldiskw/2,0]) for (y=[holegap/2:flatholeystep:smalldiskw/2-holegap/2]) {
      translate([smalldiskx+smalldiskl+xtolerance-0.01,y+holediskbackw/2,holediskbackheight]) hole(holediskbackw,holediskbackh);
      translate([smalldiskx+smalldiskl+xtolerance-0.01,-y-holediskbackw/2,holediskbackheight]) hole(holediskbackw,holediskbackh);
    }

    if (0) for (m=[0,1]) mirror([0,m,0]) for (y=[holediskbackystart:holediskbackystep:holediskbackyend]) {
	translate([smalldiskx+smalldiskl+xtolerance-0.01,y+holediskbackw/2,holediskbackheight]) {
	  hole(holediskbackw,holediskbackh);
	}
      }
    
    screwholes();

    // Open connectorhole
    translate([pcbx,pcby,pcbheight]) connectorcuts();
	
    translate([textsize+2,-diskw/2+versiontextl+cornerd/2-2,diskh-textdepth+0.01]) rotate([0,0,90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
    translate([(pcbversion==1||pcbversion==3)?textsize+2:diskl-textsize-2,diskw/2-versiontextl-cornerd/2-2,diskh-wall+textdepth-0.01]) rotate([180,0,90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
  }
}

if (print==0) {
  intersection() {
    //if (debug) translate([-100,-100+30,-100]) cube([300,25,300]);
    //if (debug) translate([-100,-100,-100]) cube([130,300,300]);
    if (debug) translate([-100,-diskw/2,-100]) cube([300,diskw-10,300]);
    difference() {
      union() {
	disk35();
	translate([platex,platey,plateheight]) plate();
	//cover();
      
	for (x=springxtable) {
	  for (y=springytable) {
	    translate([platex+x,platey+y,plateheight]) spring();
	  }
	}
      }
      //%      translate([pcbx,pcby,pcbheight]) contactpcb();
      //translate([smalldiskx,smalldisky,wall+ztolerance]) #smalldisk();
    }
  }
 }

if (print==1 || print==5 || print==8) {
  translate([0,diskw/2,0]) disk35();
 }

if (print==2 || print==5 || print==8) {
  translate([0,diskw+diskw/2+0.5,diskh]) rotate([180,0,0]) cover();
 }

if (print==3 || print==5) {
  translate([diskl+0.5+platesideslotw/2,0,0]) rotate([0,0,90]) plate();
 }

if (print==4 || print==5) {
  step=springtoph+0.5+springh+1;
  
  translate([diskl-wall+0.5,platel+springmidl/2+0.5,springw/2]) {
    for (y=[0,springmidl+1]) {
      for (x=[0:step:2*step-1]) {
	translate([x,y,0]) rotate([90,0,90]) spring();
      }
    }
  }
 }

// Test print for springs
if (print==6) {
  intersection() {
    translate([springxtable[0]-10,springytable[0]-10,0]) cube([20,20,20]);
    plate();
  }

  translate([0,0,springw/2]) {
    translate([0,springmidl/2,0]) rotate([90,0,90]) spring();
  }
 }

if (0 && (pcbversion==1 || pcbversion==3) && (print==5)) 
  {
    translate([diskl+(springtoph+0.5+springh+1)*2+2,platel+0.5,0]) contactpcb();
  }

if (print==7) {
  contactpcb();
 }

if (print==9) {
  intersection() {
    disk35();
    translate([platex,platey,plateheight]) plate();
    cover();
  }
 }
