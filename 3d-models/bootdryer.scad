// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// TODO: tuulettimen tuet ja ritila, tuben ylapaan muotoilu.

print=0;
debug=1;
adhesion=1;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;

maxbridge=10;
cornerd=1;
largecornerd=10;

versiontext="V1.1";
brandtext="Boot dryer";
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

wall=2;

fantype=2;

fansizetable=[[40,32,10],     //0
	      [50,40,10],     //1
	      [60,50,15],     //2
	      [70,60,15],     //3
	      [80,71.5,25],   //4
	      [92,82.5,25],   //5
	      [120,105,25.4],   //6
	      //[140,124.5,28], //7
	      //[200,154,30],   //8
	      //[220,170,30]    //9
	      ];

fanl=fantype!=-1?fansizetable[fantype][0]:0;
fanw=fanl;
fand=min(fanl,fanw)-wall;
fanscrewl=(fantype!=-1)?fansizetable[fantype][1]:0;
fanscreww=fanscrewl;
fanh=fantype!=-1?fansizetable[fantype][2]:0;
fanzcornerd=fanw-fanscreww;
fany=0;

lockclipd=10;
lockcliph=10+wall+10;
lockh=9;
lockw=3;
lockcutw=2;
lockclips=4;
lockclipsink=5;
lockclipbase=lockclipsink+wall;
lockx=largecornerd+wall+lockclipd/2;
locky=wall+lockclipd/2;
lockclipspring=1.5;

hosed=21;
hoseh=18.5;
hosedistance=10;
edge=5+wall;

hoseoutd=29;

coverclipd=1.5;
coverclipsink=0.3;

if (fantype!=-1) echo("Fan type ",fantype," size ",fanw," screws ",fanscrewl," thickness ",fanl);

fansupportl=wall+xtolerance+fanl+xtolerance+wall;
fansupportw=wall+ytolerance+fanw+ytolerance+wall;
fansupportsidew=10;

electronicsspacel=21;
basel=edge+electronicsspacel+hosed+hosedistance+hosed+edge+wall+xtolerance+fanl+xtolerance+wall;
basew=max(wall+ytolerance+wall+coverclipsink+hoseoutd+hosedistance+hoseoutd+coverclipsink+wall+ytolerance+wall,largecornerd/2+fansupportw+largecornerd/2);
baseh=wall+fanw+ztolerance+fanh+wall+wall+ztolerance;
baseheight=0;

fanx=basel/2-wall-xtolerance-wall-xtolerance-fanl/2-wall/2-xtolerance;
fanbaseh=2; // Leave some space for grill
fancoverh=fanh+ztolerance+wall+fanbaseh+ztolerance;
fansupporth=wall+ztolerance+fanh+fanbaseh;
topheight=baseh+ztolerance;
fanheight=baseh-fansupporth;
fanbaseheight=topheight-wall-fanbaseh-ztolerance;
fanbasesupporth=fanbaseh+wall+ztolerance+ztolerance+fanh;
fanscrewxtable=[fanx-fanscrewl/2,fanx+fanscrewl/2];
fanscrewytable=[fany-fanscreww/2,fany+fanscreww/2];

fancableholel=6;
fancableholex=13-fancableholel/2;

fansupporttopd=fanl-fanscrewl;
fansupportheight=fanheight-(basew-fanscreww);

fanscrewd=3.9;

fantunneld=fand-2;

fansupportx=basel/2-fansupportl;

pcbbelowl=12.5;
pcbbeloww=27.45;
pcbbelowh=3.5;
pcbheight=wall+pcbbelowh;
pcbsupportheight=fanheight-pcbbelowh-wall*4;

pcbl=13.5;
pcbw=32.5;
pcbh=1.7;

pcbx=-basel/2+wall+largecornerd/2+1;
pcbfromwall=4.3;
pcby=-basew/2+pcbfromwall;
pcbbelowy=pcby;
pcbbelowx=pcbx+pcbl/2-pcbbelowl/2;

pcbsupportbar=5;
pcbsupportbarxh=(pcbx+basel/2)+pcbl;
pcbsupportbaryh=pcbw+pcbfromwall;

pcbclipwall=1.6;
pcbclipxtolerance=xtolerance/2;
pcbclipcornerd=pcbclipwall;
pcbclipx=pcbx-xtolerance-wall-pcbclipxtolerance-pcbclipwall;
pcbclipl=pcbl+xtolerance*2+wall*2+pcbclipxtolerance*2+pcbclipwall*2;
pcbclipy=pcby+11.5;
pcbclipw=21;
pcbcliph=pcbheight+pcbh+ztolerance-wall+pcbclipwall-ztolerance;
pcbclipholey=5;
pcbclipholew=8;
pcbclipholel=pcbl-2;
pcbclipholex=pcbx+pcbl/2-pcbclipholel/2;

hosex=edge+hosed/2+electronicsspacel;
hoseytable=[edge+hosed/2,basew-edge-hosed/2];
hoselaippah=3;

socketw=8.82;
socketh=11.2;//10.65;
socketl=14.22; //16.82;
socketbarrelh=10.55;
socketbarreld=7.88;
socketheadl=3.43;
socketbarrelheight=6.4;
socketpinend=11.4;
socketpinstart=9;
socketpinl=2.45;
socketpinh=7.85;
socketpinheight=-3.7;
socketpinouty=0.8;
socketholed=6.15;
socketholel=9.5;

socketx=4.6;
sockety=-4.3;

coverclipl=basel-largecornerd-10;
coverclipw=basew-largecornerd-10;
coveroverlap=fanh+fanbaseh;
coveroverlapoutl=basel-wall*2-xtolerance*2;
coveroverlapoutw=basew-wall*2-ytolerance*2;
coveroverlapoutx=-basel/2+wall+xtolerance;
coveroverlapouty=-basew/2+wall+ytolerance;
coveroverlapoutcornerd=largecornerd-wall*2-xtolerance*2;

coveroverlapinl=coveroverlapoutl-wall*2;
coveroverlapinw=coveroverlapoutw-wall*2;
coveroverlapinx=coveroverlapoutx+wall;
coveroverlapiny=coveroverlapouty+wall;
coveroverlapincornerd=largecornerd-wall*2-xtolerance*2-wall*2;

coverclipheight=baseh-coveroverlap+cornerd+coverclipd/2;

module fantappi(d,h) {
  hull() {
    cylinder(h=h+0.4,d=d,$fn=30);
    translate([0,0,h+0.1+(d-d/2)/2]) sphere(d=d/2,$fn=30);
  }
}

module fan() {
  difference() {
    translate([-fanl/2,-fanw/2,0]) roundedbox(fanl,fanw,fanh,cornerd,0);
    translate([0,0,-0.1]) rotate([0,00,0]) cylinder(d=fanw-2,h=fanh+0.2,$fn=90);
    for (x=[-fanscrewl/2,fanscrewl/2]) {
      for (y=[-fanscreww/2,fanscreww/2]) {
	translate([x,y,-0.1]) cylinder(d=fanscrewd,h=fanh+0.2,$fn=90);
      }
    }
  }
}

module hoseconnector() {
  union() {
    translate([0,0,-hoseh-wall]) cylinder(d=hoseoutd+wall*2,h=wall+hoseh,$fn=180);
    translate([0,0,-hoseh-wall-hoselaippah]) cylinder(d=hosed,h=hoselaippah+0.01,$fn=180);
  }
}

module hoseconnectorcut() {
  translate([0,0,-hoseh-wall-hoselaippah-0.1]) cylinder(d=hosed-wall*2,h=wall+hoseh+hoselaippah+0.2,$fn=180);
  difference() {
    translate([0,0,-hoseh]) cylinder(d=hoseoutd,h=hoseh+0.1,$fn=180);
    translate([0,0,-hoseh-0.1]) cylinder(d=hosed,h=hoseh+0.2,$fn=180);
  }
  intersection() {
    difference() {
      difference() {
	translate([0,0,-hoseh-0.2]) cylinder(d=hoseoutd,h=hoseh+0.2+0.1,$fn=180);
	translate([0,0,-hoseh-0.2-0.1]) cylinder(d=hosed,h=hoseh+0.2+0.2,$fn=180);
      }
      union() {
	translate([-hoseoutd/2,-hoseoutd/4,-hoseh-0.2]) cube([hoseoutd,hoseoutd/2,hoseh+0.2+0.2]);
	translate([-hoseoutd/4,-hoseoutd/2,-hoseh-0.2]) cube([hoseoutd/2,hoseoutd,hoseh+0.2+0.2]);
      }
    }
  }
}

module base() {
  difference() {
    translate([-basel/2,-basew/2,baseheight]) roundedboxxyz(basel,basew,baseh,largecornerd,cornerd,1,90);
    translate([-basel/2+wall,-basew/2+wall,baseheight+wall]) roundedboxxyz(basel-wall*2,basew-wall*2,baseh-wall+0.1,largecornerd-wall*2,cornerd,1,90);
    for (m=[0,1]) mirror([0,m,0]) translate([0,-basew/2+wall+ytolerance+coverclipd/2-coverclipsink,coverclipheight]) tubeclip(coverclipl,coverclipd,dtolerance);
    for (m=[0,1]) mirror([m,0,0]) translate([-basel/2+wall+xtolerance+coverclipd/2-coverclipsink,0,coverclipheight]) rotate([0,0,90]) tubeclip(coverclipw,coverclipd,dtolerance);
  }
}

module socket(t) {
  difference() {
    union() {
      translate([-t,0,socketbarrelheight]) rotate([0,90,0]) roundedcylinder(socketbarreld+t*2,socketl+t*2,cornerd,0,90);
      translate([-t-(t?wall+xtolerance:0),-socketw/2-t,-t]) roundedbox(socketheadl+t*2+(t?wall+xtolerance+wall:0),socketw+t*2,socketh+t*2,cornerd,0);
      translate([-t,-socketw/2-t,-t]) roundedbox(socketl+t*2,socketw+t*2,socketbarrelheight+t*2,cornerd,0);
      translate([socketpinstart-t,-socketw/2-socketpinouty-t,socketpinheight-t]) roundedbox(socketpinl+t*2,socketpinouty+socketw/2+t*2,socketpinh+t*2,cornerd,0);
    }
    if (!t) translate([-0.01,0,socketbarrelheight]) rotate([0,90,0]) roundedcylinder(socketholed,socketholel+0.01,cornerd,0,90);
  }
}

module pcb() {
  translate([0,0,0]) cube([pcbl,pcbw,pcbh]);
  translate([socketx,sockety,pcbh]) rotate([0,0,90]) socket(0);
}

module roundedring(d,w,angle=360) {
  rotate_extrude(convexity=10,angle,$fn=90) {
    translate([d-w/2,0,0]) circle(d=w,$fn=90);
  }
}


module pcbsupportform(t) {
  hull() {
    n=pcbheight-wall;
    translate([pcbx-wall-xtolerance-t,-basew/2,pcbheight-wall-t]) roundedbox(pcbl+xtolerance*2+wall*2+t*2,pcbfromwall+pcbw+xtolerance*2+wall+t,wall+wall+t*2,cornerd,0);
    translate([pcbx-wall-xtolerance+n-t,pcby-wall-ytolerance+n-t,0-t]) roundedbox(pcbl+xtolerance*2+wall*2-n*2+t*2,pcbw+xtolerance*2+wall*2-n*2+t*2,wall+t*2,cornerd,0);
  }
}

module pcbsupportclip() {
  difference() {
    translate([pcbclipx,pcbclipy,wall+ztolerance]) roundedbox(pcbclipl,pcbclipw,pcbcliph,pcbclipcornerd,2);
    pcbsupportform(pcbclipxtolerance);
    belowcut=pcbclipwall+pcbclipwall/2;
    translate([pcbclipx+belowcut,pcbclipy,wall]) cube([pcbclipl-belowcut*2,pcbclipw,wall]);
    translate([pcbclipholex,pcbclipy+pcbclipholey,wall+ztolerance+pcbcliph-pcbclipwall-0.1]) cube([pcbclipholel,pcbclipholew,pcbclipwall+0.2]);
  }
}

module tubeform(y,out) {
  w=out?wall*2:0;
  hull() {
    translate([-basel/2+hosex,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2]) cylinder(d=hosed+w-(out?0:wall*2+xtolerance*2),h=ztolerance/2,$fn=90);
    translate([-basel/2+hosex,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-5]) rotate([0,-10,0]) {
      hull() {
	translate([0,-maxbridge/4,0]) cube([hosed/2+w/2,maxbridge/2,0.1]);
	cylinder(d=hosed+w,h=0.1,$fn=90);
      }
    }
  }
  hull() {
    translate([-basel/2+hosex,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-5]) rotate([0,-10,0]) {
      hull() {
	translate([0,-maxbridge/4,0]) cube([hosed/2+w/2,maxbridge/2,0.1]);
	cylinder(d=hosed+w,h=0.1,$fn=90);
      }
    }
    translate([-basel/2+hosex+5,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-22]) rotate([0,-55,0]) scale([out?1.7:1.8,1,1]) {
      hull() {
	translate([0,-maxbridge/2,0]) cube([hosed/2+w/2,maxbridge,0.1]);
	cylinder(d=hosed+w,h=0.1,$fn=90);
      }
    }
  }
  hull() {
    translate([-basel/2+hosex+5,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-22]) rotate([0,-55,0]) {
      scale([out?1.7:1.8,1,1]) {
	hull() {
	  translate([0,-maxbridge/2,0]) cube([hosed/2+w/2,maxbridge,0.1]);
	  cylinder(d=hosed+w,h=0.1,$fn=90);
	}
      }
    }
    translate([-basel/2+hosex+hosed,y-2,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-30]) rotate([0,-80,0]) {
      scale([out?2:2.2,1.3,1]) {
	hull() {
	  translate([0,-maxbridge/2,0]) cube([hosed/2+w/2,maxbridge,0.1]);
	  cylinder(d=hosed+w,h=0.1,$fn=90);
	}
      }
    }
    if (out) {
      translate([-basel/2+hosex+(5+hosed)/2,y-1,0]) cylinder(d=fand/6,h=wall);
    }
  }
  hull() {
    translate([-basel/2+hosex+hosed,y-2,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-30]) rotate([0,-80,0]) {
      scale([out?2:2.2,1.3,1]) {
	hull() {
	  translate([0,-maxbridge/2,0]) cube([hosed/2+w/2,maxbridge,0.1]);
	  cylinder(d=hosed+w,h=0.1,$fn=90);
	}
      }
    }
    hull() {
      translate([fanx-wall-fand/2-0.1,wall/2,fanheight-fand/2]) cube([fand/2,maxbridge,fand/2-wall+w/2-(out?ztolerance:0)]);
      intersection() {
	translate([fanx-wall-fand/2-0.1,fany,fanheight-ztolerance-fand/2-wall]) rotate([0,90,0]) cylinder(d=fand+w,h=0.1,$fn=90);
	translate([fanx-wall-fand/2-0.1,fany+wall/2-w/2-0.1,wall]) cube([0.1,fand+wall+0.1-(wall/2-w/2),fand+w]);
      }
    }
    if (out) {
      hull() {
	translate([fanx-(fand+wall)/2,fany+10,0]) cylinder(d=fand/6,h=wall);
	translate([-basel/2+hosex+(5+hosed)/2,y-1,0]) cylinder(d=fand/6,h=wall);
      }
    }
  }
}

module bootdryer() {
  difference() {
    union() {
      base();

      translate([0,0,pcbsupportheight]) pcbsupportform(0);
      hull() {
	intersection() {
	  translate([0,0,pcbsupportheight]) pcbsupportform(0);
	  translate([-basel/2,-basew/2,pcbsupportheight]) cube([basel,basew,cornerd]);
	}

	translate([-basel/2,pcby+pcbw/2-pcbsupportbar/2,pcbsupportheight-pcbsupportbarxh]) roundedbox(wall,pcbsupportbar,pcbsupportbarxh,cornerd,0);
      }
      
      for (x=fanscrewxtable) {
	for (m=[0,1]) mirror([0,m,0]) {
	    y=fany-fanscreww/2;
	    translate([x,y,fanheight-ztolerance-wall]) fantappi(fanscrewd,wall+ztolerance+4);
	    hull() {
	      translate([x,y,fanheight-ztolerance-wall]) roundedcylinder(fansupporttopd,wall,cornerd,1,90);
	      translate([x,-basew/2,fansupportheight]) rotate([-90,0,0]) cylinder(d=fansupporttopd,h=wall,$fn=90);
	    }
	    if (x>fanx) {
	      hull() {
		translate([x,y,fanheight-ztolerance-wall]) roundedcylinder(fansupporttopd,wall,cornerd,1,90);
		translate([basel/2-wall,y,fansupportheight]) rotate([0,90,0]) cylinder(d=fansupporttopd,h=wall,$fn=90);
	      }
	      hull() {
		translate([x-wall/2,y,fanheight-ztolerance-wall]) roundedbox(wall,wall,wall,cornerd,0);
		translate([basel/2-wall,y-wall/2,fansupportheight]) roundedbox(wall,wall,fanheight-fansupportheight-ztolerance,cornerd,0);
	      }
	    }
	    hull() {
	      translate([x,y,fanheight-ztolerance-wall]) roundedcylinder(fansupporttopd,wall,cornerd,1,90);
	      translate([fanx,fany,fanheight-ztolerance-wall]) roundedcylinder(fansupporttopd,wall,cornerd,1,90);
	    }
	    hull() {
	      translate([x-wall/2,y,fanheight-ztolerance-wall]) roundedbox(wall,wall,wall,cornerd,0);
	      translate([x-wall/2,-basew/2,fansupportheight]) roundedbox(wall,wall,fanheight-fansupportheight-ztolerance,cornerd,0);
	    }
	  }
      }

      hull() {
	h=15;
	translate([fanx-fansupportl/2,fany-fansupportw/2,fanheight-ztolerance-wall]) roundedbox(fansupportl,fansupportw,wall,cornerd,0);
	intersection() {
	  translate([fanx-fanl/2-wall/2,fany,fanheight-ztolerance]) rotate([90,90,0]) toroid(fand+wall*2,fand+wall*2,90);
	  translate([fanx-fansupportl/2,fany-fansupportw/2,fanheight-ztolerance-h]) cube([fansupportl,fansupportw,ztolerance+h]);
	}
      }
      
      hull() {
	translate([fanx-fanl/2-wall/2,fany,fanheight-ztolerance]) rotate([90,90,0]) toroid(fand+wall*2,fand+wall*2,90);
	translate([fanx-fanl/2-wall/2,fany-wall/2-maxbridge,fanheight-fand/2-wall]) cube([fand/2,maxbridge*2+wall,fand/2+wall-ztolerance]);
      }
      hull() {
	intersection() {
	  translate([fanx-fanl/2-wall/2,fany,fanheight-ztolerance]) rotate([90,90,0]) toroid(fand+wall*2,fand+wall*2,90);
	  translate([fanx-fanl/2-wall/2,-basew/2,0]) cube([fand+wall*2,basew,(fand+wall*2)/2]);
	}
	translate([fanx-fanl/2-wall/2,fany-fand/4,0]) roundedbox(fand/4,fand/2,wall,cornerd,0);
	translate([fanx-fanl/2-wall/2+fand/4,fany,0]) cylinder(d=fand/2,h=wall,$fn=90);
      }

      for (m=[0,1]) mirror([0,m,0]) {
	  y=hoseytable[0];
	  translate([-basel/2+hosex,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2]) cylinder(d=hosed+wall*2,h=hoselaippah,$fn=90);
	  tubeform(y,1);
	}
    }

    hull() {
      translate([fanx-fanl/2+wall/2-0.01,fany,fanheight-ztolerance-wall]) rotate([90,90,0]) toroid(fand,fand,91);
      translate([fanx-fanl/2-wall/2,fany-wall/2-maxbridge,fanheight-fand/2-wall]) cube([fand/2,maxbridge*2+wall,fand/2]);
    }
    translate([fanx,fany,fanheight-ztolerance-wall]) cylinder(d=fand,h=wall+0.2,$fn=90);
    translate([fanx-wall-fand/2-0.1,fany,fanheight-ztolerance-fand/2-wall]) rotate([0,90,0]) cylinder(d=fand,h=wall+0.2,$fn=90);
    translate([fanx-fand/2,fany-maxbridge-wall/2,fanheight-fand/2-wall]) cube([fand/2,maxbridge*2+wall,fand/2]);

    translate([pcbx-xtolerance,pcby-ytolerance,pcbsupportheight+pcbheight-ztolerance]) roundedbox(pcbl+xtolerance*2,pcbw+xtolerance*2,pcbh+cornerd,cornerd,0);
    translate([pcbbelowx-xtolerance,pcbbelowy-ytolerance,pcbsupportheight+pcbbelowh-ztolerance]) roundedboxxyz(pcbbelowl+xtolerance*2,pcbbeloww+xtolerance*2,pcbbelowh+ztolerance+cornerd,5,cornerd,0,90);
    translate([pcbx+socketx,pcby+sockety,pcbsupportheight+pcbheight+pcbh]) rotate([0,0,90]) socket(xtolerance);

    for (m=[0,1]) mirror([0,m,0]) {
	y=hoseytable[0];
	translate([-basel/2+hosex,y,baseh+ztolerance+wall-hoseh-wall-hoselaippah-ztolerance/2-0.01]) cylinder(d=hosed+dtolerance,h=hoselaippah+0.02,$fn=90);
	tubeform(y,0);
      }

    for (a=[0,180]) rotate([0,0,a]) translate([0,-basew/2+textdepth-0.01,baseh/2+textsize/2+1]) rotate([90,0,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="center");
    for (a=[0,180]) rotate([0,0,a]) translate([0,-basew/2+textdepth-0.01,baseh/2-textsize/2-1]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }

  hull() for (x=[0,-wall]) translate([fanx-fand/2-wall/2+x,fany,0]) cylinder(d=wall,h=fand+wall+wall/2,$fn=90);
  //hull() for (x=[0,-wall]) translate([fanx-fand/2-wall/2+x,fany,0]) cylinder(d=wall,h=fand+wall*2,$fn=90);
}

module bootdryertop() {
  difference() {
    union() {
      difference() {
	union() {
	  difference() {
	    union() {
	      translate([-basel/2,-basew/2,topheight]) roundedboxxyz(basel,basew,wall,largecornerd,cornerd,2,90);
	      translate([-coveroverlapoutl/2,-coveroverlapoutw/2,topheight-coveroverlap]) roundedboxxyz(coveroverlapoutl,coveroverlapoutw,coveroverlap+wall,coveroverlapoutcornerd,cornerd,2,90);
	    }

	    translate([-coveroverlapinl/2,-coveroverlapinw/2,topheight-coveroverlap-cornerd/2]) roundedboxxyz(coveroverlapinl,coveroverlapinw,coveroverlap+cornerd/2,coveroverlapincornerd,cornerd,2,90);
	  }
	  translate([fanx-fansupportl/2,fany-fansupportw/2,topheight-wall-fanbaseh-ztolerance]) roundedbox(fansupportl,fansupportw,fanbaseh+wall+wall+ztolerance,cornerd,0);
	  for (a=[0,90,180,270]) translate([fanx,fany,topheight-fanbasesupporth]) rotate([0,0,a]) {
	      difference() {
		translate([-fansupportl/2,-fansupportw/2,0]) roundedbox(fansupportl,wall,fanbasesupporth+wall,cornerd,0);
		translate([-fanl/2+fancableholex,-fansupportw/2-cornerd/2,-cornerd/2]) roundedbox(fancableholel,wall+cornerd,fanh+cornerd,cornerd,0); // fansupportl/2-wall-xtolerance-fancablehole
	      }
	      translate([-fanscrewl/2,fanscreww/2,fanh+ztolerance+wall]) rotate([180,0,0]) fantappi(fanscrewd,wall+ztolerance+4);
	    }
	}
	translate([fanx,fany,fanbaseheight-0.1]) cylinder(d=fand,h=wall+fanbaseh+wall+ztolerance+0.2,$fn=90);
      }

      for (m=[0,1]) mirror([0,m,0]) translate([0,-basew/2+wall+ytolerance+coverclipd/2-coverclipsink,coverclipheight]) tubeclip(coverclipl,coverclipd,0);
      for (m=[0,1]) mirror([m,0,0]) translate([-basel/2+wall+xtolerance+coverclipd/2-coverclipsink,0,coverclipheight]) rotate([0,0,90]) tubeclip(coverclipw,coverclipd,0);

      for (m=[0,1]) mirror([0,m,0]) {
	  y=hoseytable[0];
	  translate([-basel/2+hosex,y,baseh+ztolerance+wall]) hoseconnector();
	}

      translate([fanx,fany,topheight]) grill(fand+1,thickness=wall);
    }

    translate([pcbx+socketx,pcby+sockety,pcbsupportheight+pcbheight+pcbh]) rotate([0,0,90]) socket(xtolerance);
    
    for (m=[0,1]) mirror([0,m,0]) {
	y=hoseytable[0];
	translate([-basel/2+hosex,y,baseh+ztolerance+wall]) hoseconnectorcut();
      }

    textx=(fanx-fanl/2-basel/2+hosex+hoseoutd/2)/2;
    translate([textx-textsize/2-1,0,topheight+wall-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="center");
    translate([textx+textsize/2+1,0,topheight+wall-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module bootdryerprint() {
  translate([0,0,-baseheight]) bootdryer();
}

module bootdryertopprint() {
  translate([0,basew/2+0.5+basew/2,0]) rotate([180,0,0]) translate([0,0,-topheight-wall]) bootdryertop();
}

module pcbsupportclipprint() {
  translate([0,-basew/2-2-pcbclipl,pcbcliph]) rotate([180,0,0]) translate([0,0,-wall-ztolerance]) pcbsupportclip();
}

if (print==0) {
  intersection() {
    if (debug) translate([-200,-200,-200]) cube([400,200+20,400]);
    difference() {
      union() {
	bootdryer();
	bootdryertop();
	translate([0,0,pcbsupportheight]) pcbsupportclip();
      }
      
      #      translate([fanx,fany,fanheight]) fan();
      #      translate([0,0,pcbsupportheight]) translate([pcbx,pcby,pcbheight]) pcb();
    }
  }
 }


if (print==1 || print==4 || print==8) {
  intersection() {
    if (print==8) translate([-basel/2,-basew/2,0]) cube([pcbl+12,pcbw+10,pcbheight+15]);
    
    bootdryerprint();
  }
 }

if (print==2 || print==4) {
  bootdryertopprint();
 }

if (print==3 || print==4) {
  pcbsupportclipprint();
 }

if (adhesion) {
  difference() {
    union() {
      if (print==1 || print==4) brim() bootdryerprint();
      if (print==2 || print==4) brim() bootdryertopprint();
      if (print==3 || print==4) brim() pcbsupportclipprint();
    }

    if (print==1 || print==4) brimcut() bootdryerprint();
    if (print==2 || print==4) brimcut() bootdryertopprint();
    if (print==3 || print==4) brimcut() pcbsupportclipprint();
  }
 }
