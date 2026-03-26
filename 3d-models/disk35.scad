// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// Box fitting to 3.5inch disk form. This is intended for use with various 3.5 inch

print=5;
debug=0;

xtolerance=0.30;
ytolerance=0.30;
ztolerance=0.20;
dtolerance=0.60;

maxbridge=10;
cornerd=1;

diskl=147;
diskw=xtolerance+101.6+xtolerance;
diskh=ztolerance+26.1+ztolerance;

// Generic disk screwd is about 3.5mm
diskscrewholed=3.6;
diskscrewheight=6.7;
diskscrewxtable=[diskl-118.19,diskl-76.71,diskl-16.52];
diskscrewd=3;
diskscrewpenetration=6.32;
// 2.5 inch disks may be up to 12.5 thick, though 9.5 is current standard.
smalldiskh=ztolerance+9.5+ztolerance;
smalldiskmaxh=ztolerance+12.5+ztolerance;
smalldiskl=100.45;
smalldiskw=ytolerance+69.82+max(0.25,ytolerance);
smalldiskscrewxtable=[smalldiskl-90.6,smalldiskl-14];
smalldisksmalldiskconnectory=15;
smalldiskscrewheight=3;
smalldiskscrewd=3;

wall=1.6;
incornerd=2;
outcornerd=2+wall*2;
basecornerd=3;
coverclipdepth=0.6;
coverclipd=wall+xtolerance+coverclipdepth;

belowcoverl=diskl-xtolerance*2-wall*2;
belowcoverw=diskw-xtolerance*2-wall*2;
belowcoverh=0.5+coverclipd+cornerd+0.5;
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

versiontext="V0.9";
textdepth=0.7;
textsize=7;
textfont="Liberation Sans:style=Bold";
versiontextl=textlen(versiontext,textsize)+2;

coverh=wall;
baseh=diskh-ztolerance-coverh;

coverclipheight=baseh-belowcoverh+coverclipd/2+dtolerance/2;

// This one I just ordered from aliexpress

pcbw=84;
pcbl=33;
pcbh=1;

pcbscrewholew=pcbw-6; // MEASURE?
pcbscrewholex=pcbl-5.5; // MEASURE
pcbscrewd=3;
pcbscrewholed=3;

powerconnectorw=24.5;
powerconnectorh=8;
powerconnectorl=10;
powerconnectory=0;

ideconnectorw=59.3;
ideconnectorh=8;
ideconnectorheight=0;
ideconnectorl=10;
ideconnectory=powerconnectorw+ytolerance;

smallideconnectorw=46;
smallideconnectorl=6;
smallideconnectorh=4.5;
smallideconnectory=pcbw/2+51.3/2-smallideconnectorw;

connectorcornerd=1;

//connectorpcby=wall+incornerd/2+ytolerance;
//pcby=-diskw/2+connectorpcby;
pcby=-pcbw/2;
// Connector opening
connectorpcby=-pcbw/2;//wall+incornerd/2+ytolerance;
pcbx=0;
tappih=ztolerance+pcbh+1;

smalldisky=pcby+pcbw/2;
smalldiskx=pcbl+1;

// Sides, should be higher than tallest potential disk (12.5mm + ztolerance*2)
smalldisksidewallh=wall+ztolerance+smalldiskmaxh+ztolerance+wall+1;

// Wall support height, just under cover
sidewallh=baseh-belowcoverh;

// At the disk end, this may not be high as disk needs to be inserted on top of this
smalldiskbasewallh=wall+ztolerance+1;

// Spring plate on top of disk
plateheight=wall+ztolerance+smalldiskh+ztolerance;
plateh=wall;
plateribh=5;
platel=smalldiskl;
platew=smalldiskw;
platesideslotl=-xtolerance+smalldiskl/3-xtolerance;
platesideslotw=wall+ytolerance+smalldiskw+ytolerance+wall;
platex=smalldiskx;
platey=0;

// Springs to put pressure on disk to keep it in place
springclipdepth=0.25;
springclipd=wall+springclipdepth*2;
springclipheight=wall+xtolerance+springclipd/2; // From plate bottom
springtowerw=6;
springtowerl=3;
springspacew=ytolerance+springtowerw+ytolerance;
springspacel=xtolerance+springtowerl+xtolerance;
springclipl=springspacel+cornerd*2;//springl+cornerd-1;
//springspaceh=diskh-plateheight-wall-ztolerance-ztolerance-wall;
springspaceh=wall+ztolerance+springclipd/2+cornerd+0.5;//diskh-plateheight-wall-ztolerance-ztolerance-wall;
springtensionh=ztolerance+springspaceh+(smalldiskmaxh-smalldiskh)+2+ztolerance;
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

springholell=springmidl-2-springl;
springholel=min(springholell,maxbridge);
springholex=(springmidl/2-springl/2)/2+springl/2-wall/2;
springholew=springw-5;

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

// Front (connector side
holefrontw=6;
holefrontheight=wall+ztolerance+powerconnectorh+ztolerance+2;
holefronth=diskh-holefrontheight-wall-belowcoverh;
holefrontystep=holew*2;
holefrontystart=holegap/2;
holefrontyend=diskw/2-outcornerd/2-holegap-holefrontw;

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
holediskbackheight=wall+smalldiskbasewallh+ztolerance+2;
holediskbackh=diskh-wall-holediskbackheight-2;
holediskbackystep=holew+holegap;
holediskbackystart=smalldisky+holegap/2;
holediskbackyend=smalldisky+smalldiskw/2-holegap;

module hole(w,h) {
  hull() {
    translate([0,-w/2+holecornerd/2,holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=wall*2+0.02,$fn=60);
    translate([0,w/2-holecornerd/2,holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=wall*2+0.02,$fn=60);
    translate([0,-w/2+holecornerd/2,h-holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=wall*2+0.02,$fn=60);
    translate([0,w/2-holecornerd/2,h-holecornerd/2]) rotate([0,90,0]) cylinder(d=holecornerd,h=wall*2+0.02,$fn=60);
  }
}

module flathole(l,w) {
  hull() {
    translate([-l/2+holecornerd/2,-w/2+holecornerd/2,-0.01]) cylinder(d=holecornerd,h=wall+0.02,$fn=60);
    translate([-l/2+holecornerd/2,w/2-holecornerd/2,-0.01]) cylinder(d=holecornerd,h=wall+0.02,$fn=60);
    translate([l/2-holecornerd/2,-w/2+holecornerd/2,-0.01]) cylinder(d=holecornerd,h=wall+0.02,$fn=60);
    translate([l/2-holecornerd/2,w/2-holecornerd/2,-0.01]) cylinder(d=holecornerd,h=wall+0.02,$fn=60);
  }
}

// At plate bottom
module springtower() {
  difference() {
    translate([-springtowerl/2,-springtowerw/2,0]) roundedbox(springtowerl,springtowerw,springspaceh,cornerd,0);
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
	translate([springholex-springholel/2,-springholew/2,0]) roundedbox(springholel,springholew,springheight+springtoph,cornerd,0);
      }

    translate([0,springw/2-cornerd/2,springheight+springtoph+wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext,size=(springw-springholew-cornerd)/2,valign="top",halign="center");
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

    translate([platel/2-cornerd/2-versiontextl/2,wall/2+0.5+textsize/2,plateh-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
  }
}

module smalldisk() {
  translate([0,0,0]) roundedbox(smalldiskl,smalldiskw,smalldiskh,cornerd,0);
}

module contactpcb() {
  difference() {
    union() {
      translate([0,powerconnectory,0]) roundedbox(powerconnectorl,powerconnectorw,powerconnectorh,connectorcornerd,0);
      translate([0,ideconnectory,0]) roundedbox(ideconnectorl,ideconnectorw,ideconnectorh,connectorcornerd,0);
      translate([powerconnectorl-xtolerance,0,0]) roundedbox(pcbl-powerconnectorl+xtolerance,pcbw,pcbh,connectorcornerd,0);
      translate([pcbl-smallideconnectorl,smallideconnectory,0]) roundedbox(smallideconnectorl+0.01,wall,smallideconnectorh,0);
      translate([pcbl-smallideconnectorl,smallideconnectory+smallideconnectorw-wall,0]) roundedbox(smallideconnectorl+0.01,wall,smallideconnectorh,0);
      if (debug) translate([pcbl,smallideconnectory,0]) roundedbox(smallideconnectorl+0.01,smallideconnectorw,smallideconnectorh,0);
    }

    translate([pcbscrewholex,pcbw/2-pcbscrewholew/2,-0.01]) cylinder(d=pcbscrewd+dtolerance,h=pcbh+0.02,$fn=60);
    translate([pcbscrewholex,pcbw/2+pcbscrewholew/2,-0.01]) cylinder(d=pcbscrewd+dtolerance,h=pcbh+0.02,$fn=60);

    translate([powerconnectorl+(pcbl-powerconnectorl)/2,pcbw/2,pcbh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
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
	
	//translate([wall,-diskw/2+wall,wall]) roundedbox(diskl-wall*2,diskw-wall*2,baseh+incornerd,incornerd,0);

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
	
	if (0) difference() {
	  translate([wall+xtolerance,-diskw/2+wall+ytolerance,diskh-belowcoverh-wall]) roundedboxxyz(belowcoverl,belowcoverw,belowcoverh+wall,belowcornerd,cornerd,0,90);
	  translate([covercutx,-diskw/2+covercuty,covercutheight]) roundedbox(covercutl,covercutw,covercuth,cornerd,0);
	}


	// Open connectorhole
	//translate([-0.01,-diskw/2+connectorpcby,wall]) cube([pcbl+0.02,ytolerance+pcbw+ytolerance,ztolerance+powerconnectorh+ztolerance]);
	translate([-0.01,connectorpcby,wall]) cube([pcbl+0.02,ytolerance+pcbw+ytolerance,diskh-wall-ztolerance]);

	coverclips(dtolerance);
      }

      // Pcb supports
      for (y=[-pcbscrewholew/2,pcbscrewholew/2]) {
	translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,0]) roundedcylinder(pcbscrewd,wall+ztolerance+pcbh+tappih,cornerd,0,60);
	//translate([pcbx+pcbscrewholex,pcby+pcbw/2+y,0]) roundedcylinder(pcbscrewd,wall+ztolerance+pcbh+tappih,cornerd,0,60);
      }
  
      // Structures around the dist to keep it in place
      translate([smalldiskx+smalldiskl+xtolerance,smalldisky-smalldiskw/2-ytolerance-wall,0]) roundedbox(wall,wall+ytolerance+smalldiskw+ytolerance+wall,wall+smalldiskbasewallh,cornerd,0);
      for (y=[smalldisky-smalldiskw/2-ytolerance-wall,smalldisky+smalldiskw/2+ytolerance]) {
	translate([smalldiskx,y,0]) roundedbox(smalldiskl/3,wall,smalldisksidewallh,cornerd,0);
	translate([smalldiskx+smalldiskl-smalldiskl/3,y,0]) roundedbox(smalldiskl/3+xtolerance+wall,wall,smalldisksidewallh,cornerd,0);
      }

      for (x=[smalldiskx,smalldiskx+smalldiskl-smalldiskl/3]) {
	hull() {
	  translate([x,-diskw/2+wall+ytolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	  translate([x,-diskw/2+0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	  translate([x,-diskw/2+outcornerd/2,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	  translate([x,smalldisky-smalldiskw/2-ytolerance-wall,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	}
	hull() {
	  translate([x,smalldisky+smalldiskw/2+ytolerance,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	  translate([x,diskw/2-outcornerd/2-wall,0]) roundedbox(wall,wall,smalldisksidewallh,cornerd,0);
	  translate([x,diskw/2-wall-0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	  translate([x,diskw/2-wall*2-xtolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	}
      }

      for (m=[0,1]) mirror([0,m,0]) for (xx=coverclipxtable) {
	  for (x=[-coverclipl/2+xx-wall,coverclipl/2+xx]) {
	    hull() {
	      translate([x,-diskw/2+wall+ytolerance,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	      translate([x,-diskw/2+0.01,outcornerd/2]) roundedbox(wall,wall,sidewallh-outcornerd,cornerd,0);
	      translate([x,-diskw/2+outcornerd/2,0]) roundedbox(wall,wall,sidewallh-outcornerd/2,cornerd,0);
	      translate([x,pcby-ytolerance-wall,0]) roundedbox(wall,wall,wall+pcbh,cornerd,0);
	    }
	  }
	}
    }
    
    for (m=[0,1]) mirror([0,m,0]) for (x=[smalldiskx+flatholelgap+flatholel/2:flatholexstep:smalldiskx+smalldiskl-flatholelgap]) {
	for (y=[holegap/2+flatholew/2:flatholeystep:smalldiskw/2-holegap/2-flatholew/2]) {
	  translate([x,y,0]) flathole(flatholel,flatholew);
	}
      }
    
    for (m=[0,1]) mirror([0,m,0]) for (y=[holebackystart:holebackystep:holebackyend]) {
	translate([diskl-wall*2-0.01,y+holebackw/2,holebackheight]) {
	  hole(holebackw,holebackh);
	}
      }

    screwholes();

    translate([textsize+2,0,textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
    translate([textsize+2,0,wall-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
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

      // Connector hole
      ch=wall+ztolerance+powerconnectorh+ztolerance;
      translate([0,connectorpcby+ytolerance,ch]) roundedbox(wall,pcbw,diskh-ch,cornerd,2);
      for (y=[connectorpcby+ytolerance,connectorpcby+ytolerance+pcbw-wall]) {
	hull() {
	  translate([0,y,ch]) roundedbox(wall,wall,diskh-ch,cornerd,2);
	  translate([10,y,diskh-wall]) roundedbox(wall,wall,wall,cornerd,2);
	}
      }
      
      // Cover clips
      coverclips(0);

      // Pcb supports
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

      // Back of disk wall
      h=wall+smalldiskbasewallh+ztolerance;
      translate([smalldiskx+smalldiskl+xtolerance,smalldisky-smalldiskw/2,h]) roundedbox(wall,smalldiskw,diskh-h,cornerd,0);
      for (y=[-smalldiskw/2,-wall/2,smalldiskw/2-wall]) {
	hull() {
	  translate([smalldiskx+smalldiskl+xtolerance,smalldisky+y,h]) roundedbox(wall*2,wall,diskh-h,cornerd,0);
	  translate([smalldiskx+smalldiskl+xtolerance+6,smalldisky+y,diskh-wall]) roundedbox(wall,wall,wall,cornerd,0);
	}
      }
    }

    // Ventilation holes on cover
    holesl=flatholel*4+holegap*3;
    for (m=[0,1]) mirror([0,m,0]) {
	for (i=[0,2,3]) {
	  for (j=[i>0?1:0:1:3]) {
	    x=diskl/2-holesl/2+flatholel/2+j*holesl/4;
	    y=holegap/2+flatholew/2+i*flatholeystep;
	    translate([x,y,diskh-wall]) flathole(flatholel,flatholew);
	  }
	}
      }

    for (m=[0,1]) mirror([0,m,0]) for (y=[holefrontystart:holefrontystep:holefrontyend]) {
	translate([-0.01,y+holefrontw/2,holefrontheight]) {
	  hole(holefrontw,holefronth);
	}
      }
    
    for (m=[0,1]) mirror([0,m,0]) for (y=[holediskbackystart:holediskbackystep:holediskbackyend]) {
	translate([smalldiskx+smalldiskl+xtolerance-0.01,y+holediskbackw/2,holediskbackheight]) {
	  hole(holediskbackw,holediskbackh);
	}
      }
    
    screwholes();

    translate([textsize+2,diskw/2-versiontextl-cornerd/2-2,diskh-textdepth+0.01]) rotate([0,0,90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
    translate([textsize+2,diskw/2-versiontextl-cornerd/2-2,diskh-wall+textdepth-0.01]) rotate([180,0,90]) linear_extrude(height=textdepth) text(versiontext,size=textsize,valign="center",halign="center");
  }
}

if (print==0) {
  intersection() {
    //if (debug) translate([-100,-100+30,-100]) cube([300,25,300]);
    if (debug) translate([-100,-100,-100]) cube([115,300,300]);
    //if (debug) translate([-100,-diskw/2,-100]) cube([300,diskw-10,300]);
    difference() {

      union() {
	disk35();
	translate([platex,platey,plateheight]) plate();
	cover();
      
	for (x=springxtable) {
	  for (y=springytable) {
	    translate([platex+x,platey+y,plateheight]) spring();
	  }
	}
      }
      translate([0,pcby,wall+ztolerance]) %contactpcb();
      //translate([smalldiskx,smalldisky,wall+ztolerance]) #smalldisk();
    }
  }
 }

if (print==1 || print==5) {
  translate([0,diskw/2,0]) disk35();
 }

if (print==2 || print==5) {
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

if (print==7 || print==5) 
  {
    translate([diskl+(springtoph+0.5+springh+1)*2+1,platel+0.5,0]) contactpcb();
  }


