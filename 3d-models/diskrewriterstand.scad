// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=0;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;

maxbridge=10;
cornerd=1.5;
largecornerd=10;

versiontext="V1.1";
brandtext="Diskstand";
fulltext=str(brandtext," ",versiontext);
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

wall=2;

diskl=xtolerance+147+xtolerance;
diskw=ytolerance+101.6+ytolerance;
diskh=ztolerance+26.1+ztolerance;

diskbaseh=10;
diskbasew=3;

smalldiskh=ztolerance+9.5+ztolerance;
smalldiskmaxh=ztolerance+12.5+ztolerance;
smalldiskl=100.5; // 100.45;
smalldiskw=ytolerance+69.82+max(0.25,ytolerance);

fantype=4;

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
fand=fanl-wall-2;
fanscrewl=(fantype!=-1)?fansizetable[fantype][1]:0;
fanscreww=fanscrewl;
fanh=fantype!=-1?fansizetable[fantype][2]:0;
fanzcornerd=fanw-fanscreww;

basetowerd=10;
basetoweroutd=10+wall*2;

//lockclipd=10;
lockclipoverhang=1.5;
lockclipw=7;
lockclipl=9;
lockclipbodyh=4;
lockcliph=20;
lockclipoutl=lockclipl+wall*2+dtolerance*2+lockclipoverhang*2;
lockclipoutw=lockclipw+wall*2+dtolerance*2;
lockclipcut=lockclipoverhang*2+xtolerance*2;
lockclipoverhangh=8;
lockclipcuth=lockcliph-lockclipbodyh/2+lockclipoverhangh;
lockh=9;
lockw=3;
lockcutw=2;
lockclips=4;
lockclipsink=5;
lockclipbase=lockcliph;//lockclipsink+wall;
lockx=largecornerd+wall+basetowerd/2;
locky=wall+basetowerd/2;
lockclipspring=1.5;
  
basel=diskl+20+wall+fanh+wall;
basew=wall+basetowerd+wall+wall+diskw+wall+wall+basetowerd+wall;
baseh=wall;
baseheight=100;

basefrontgapl=5;
basefrontl=wall+xtolerance+diskl/2-fanw/2-xtolerance-basefrontgapl;
basefrontx=-basel/2+basefrontgapl;

if (fantype!=-1) echo("Fan type ",fantype," size ",fanw," screws ",fanscrewl," thickness ",fanl);

fansupportl=wall+xtolerance+fanh+0.5+xtolerance+wall;
fansupportx=basel/2-wall-xtolerance-fansupportl-wall-xtolerance;;
fansupportw=wall+ytolerance+fanw+ytolerance+wall;
fansupportsidew=10;

grillsupportl=xtolerance+wall+xtolerance+wall;
grillsupportx=fansupportx-xtolerance-wall-xtolerance-wall;
grillsupportw=wall+2;
grillxtable=[fansupportx-xtolerance-wall,fansupportx+fansupportl+xtolerance];

module grillsupport() {
  difference() {
    for (m=[0,1]) mirror([0,m,0]) {
	translate([0,-fanw/2-ytolerance-wall,0]) roundedbox(wall,grillsupportw,wall+fanw,cornerd,0);
	translate([0,-fanw/2-ytolerance-wall,0]) roundedbox(grillsupportl+wall,wall,wall+fanw,cornerd,0);
      }
    
    translate([-0.1,0,wall+fanw/2+ztolerance]) rotate([0,90,0]) cylinder(d=fand,h=wall+0.2,$fn=180);
  }
}

module fangrill() {
  difference() {
    translate([-fanw/2,-fanw/2,0]) roundedbox(fanw,fanw,wall,cornerd,1);
    translate([0,0,-0.01]) cylinder(d=fand,h=wall+0.2,$fn=180);
  }

  translate([0,0,0]) grill(fand+wall,thickness=wall);
}

module lockclip(l,w,h,overhang,cornerd,cut=0) {
  t=cut?max(xtolerance,ytolerance):0;
  lcut=lockclipcut+xtolerance*4;
  
  difference() {
    union() {
      translate([-l/2-t,-w/2-t,-h/2-cornerd-t]) roundedbox(l+t*2,w+t*2,h+cornerd*2+t*2,cornerd,6);
      for (m=[0,1]) mirror([0,0,m]) {
	  hull() {
	    translate([-l/2-lockclipoverhang-t,-w/2-t,h/2-t]) roundedbox(l+lockclipoverhang*2+t*2,w+t*2,wall+t*2,0.1,6); //cornerd/2
	    ll=min(wall+lockclipcut+wall,l-xtolerance*2);
	    translate([-ll/2-t,-w/2-t,h/2+lockclipoverhangh-wall-t]) roundedbox(ll+t*2,w+t*2,wall+t*2,cornerd,6);
	  }
	}
    }

    if (!cut) {
      for (m=[0,1]) mirror([0,0,m]) {
	  translate([-lcut/2,-w/2-cornerd/2,lockclipbodyh/2]) roundedbox(lcut,w+cornerd,lockclipcuth+cornerd,cornerd,0);
	  hull() {
	    translate([-lcut/2,-w/2-cornerd/2,lockcliph/2]) roundedbox(lcut,w+cornerd,lockclipoverhangh,cornerd,0);
	    translate([-lcut/2-xtolerance*2,-w/2-cornerd/2,lockcliph/2+lockclipoverhangh]) roundedbox(lcut+xtolerance*4,w+cornerd,wall,cornerd,0);
	  }
	}

      translate([0,w/2-textdepth+0.01,0]) rotate([-90,0,0]) resize([l-1,lockclipbodyh-1,textdepth]) linear_extrude(textdepth) text(versiontext,size=lockclipbodyh-1,font=textfont,valign="center",halign="center");
    }
  }
}

module roundlockclip(based,baseh,d,h,w,cornerd) {
  difference() {
    union() {
      difference() {
	union() {
	  roundedcylinder(based,baseh,cornerd,1,90);
	  roundedcylinder(d,baseh+h+2*wall-lockclipsink+wall/2+cornerd/2,cornerd,1,lockclips);
	}
	difference() {
	  translate([0,0,baseh-lockclipsink]) cylinder(d=d+dtolerance,h=lockclipsink+wall*2,$fn=90);
	  translate([0,0,baseh-lockclipsink]) cylinder(d=d,h=lockclipsink+wall*2+cornerd,$fn=lockclips);
	}
      }
  
	translate([0,0,baseh]) {
      hull() {
	  translate([0,0,wall]) roundedcylinder(d-wall*2,h+3*wall,cornerd,1,90);
	  translate([0,0,h-ztolerance]) cylinder(d=d,h=wall*2,$fn=lockclips);
	  translate([0,0,h-ztolerance+wall/2]) cylinder(d=d,h=wall*2-wall/2,$fn=90);
	  translate([0,0,wall+wall/2]) roundedcylinder(d+wall,cornerd,cornerd,1,90);
	  translate([0,0,wall+wall/2-cornerd/2+wall-cornerd]) roundedcylinder(d+wall,cornerd,cornerd,1,90);
	}
      }
    }
      
    translate([0,0,baseh-lockclipsink]) cylinder(d=d-wall*2-wall,h=wall+lockclipsink+4*wall+0.2,$fn=90);
    hull() {
      translate([0,0,baseh-lockclipsink]) cylinder(d=d-wall*2-wall,h=wall+lockclipsink+3*wall+0.2,$fn=lockclips);
      translate([0,0,baseh-lockclipsink]) roundedcylinder(d-lockclipspring*2,wall+lockclipsink+wall+0.2,cornerd,0,lockclips);
    }
	  
    for (a=[0:360/lockclips:360]) rotate([0,0,a]) {
	translate([0,-lockcutw/2,baseh-lockclipsink]) roundedbox(d/2+lockcutw/4-cornerd/2,lockcutw,wall+h+4*wall+0.2+cornerd/2,cornerd,0);
	translate([0,-lockcutw/2+cornerd/2,baseh-lockclipsink]) cube([d/2+lockcutw/4-cornerd/2,lockcutw-cornerd,wall+h+4*wall+0.2+cornerd/2]);
	translate([0,-lockcutw/2,baseh]) roundedbox(d/2+wall+cornerd/2,lockcutw,wall+h+4*wall+0.2+cornerd/2,cornerd,0);
      }
  }
}

module base() {
  difference() {
    union() {
      w=(basew-ytolerance-fanw-ytolerance)/2;
      for (m=[0,1]) mirror([0,m,0]) translate([-basel/2,-basew/2,baseheight]) roundedboxxyz(basel,w,wall,largecornerd,cornerd,1,90);
      translate([-basel/2+basefrontgapl,-basew/2,baseheight]) roundedboxxyz(basefrontl,basew,wall,largecornerd,cornerd,1,90);
      fangrillprintspacel=fanw>61?xtolerance+fanw+xtolerance:xtolerance+fanw+xtolerance+fanw+xtolerance;
      x=basefrontgapl+basefrontl;
      echo(basel,x,fangrillprintspacel);
      translate([-basel/2+x+fangrillprintspacel,-basew/2,baseheight]) roundedboxxyz(basel-x-fangrillprintspacel,basew,wall,largecornerd,cornerd,1,90);
    }
    for (x=[-basel/2+lockx,basel/2-lockx]) {
      for (y=[-basew/2+locky,basew/2-locky]) {
	translate([x,y,baseheight+wall-lockcliph/2+ztolerance]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,1);
	//#	translate([x-lockclipl/2-xtolerance,y-lockclipw/2-xtolerance,baseheight-0.1]) roundedboxxyz(lockclipl+xtolerance*2,lockclipw+ytolerance*2,wall+0.2,cornerd/2,0,0,90);
      }
    }
  }
}

module rewriterstand35() {
  base();

  difference() {
    union() {
      // Disk side supports
      for (m=[0,1]) mirror([0,m,0]) {
	  hull() {
	    translate([-basel/2+wall+diskl,-diskw/2-wall,baseheight]) roundedbox(wall,wall,wall+diskbaseh+diskh,cornerd,0);
	    translate([grillsupportx,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,wall,wall+fanw,cornerd,0);
	  }
	  translate([-basel/2,-diskw/2-wall,baseheight]) roundedbox(wall+diskl+wall,wall,wall+diskbaseh+diskh,cornerd,0);
	  //translate([-basel/2,-diskw/2-wall,baseheight]) roundedbox(wall+diskl+wall,diskbasew+wall,wall+diskbaseh,cornerd,0);
	  hull() {
	    translate([-basel/2,-diskw/2-wall,baseheight+wall+diskbaseh-wall]) roundedbox(wall+diskl+wall,diskbasew+wall,wall,cornerd,0);
	    translate([-basel/2,-diskw/2-wall,baseheight+diskbaseh-wall-wall]) roundedbox(wall+diskl+wall,wall,wall,cornerd,0);
	  }
	  for (x=[-basel/2,-basel/2+wall+diskl]) {
	    translate([x,-diskw/2-wall,baseheight]) roundedbox(wall,diskbasew+wall,wall+diskbaseh+diskh,cornerd,0);
	  }
	  for (x=[-basel/2+largecornerd/2,-basel/2+wall+diskl+wall-largecornerd/2-wall]) {
	    hull() {
	      translate([x,-diskw/2-wall,baseheight]) roundedbox(wall,wall,wall+diskbaseh+diskh,cornerd,0);
	      translate([x,-basew/2,baseheight]) roundedbox(wall,wall,wall,cornerd,0);
	    }
	  }
	}

      // Fan support front and back
      for (x=[fansupportx+fansupportl-wall,fansupportx]) {
	difference() {
	  union() {
	    translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,fansupportw,wall+fanw/2,cornerd,0);
	    for (m=[0,1]) mirror([0,m,0]) {
		translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,fanw/4,wall+fanw,cornerd,0);
	      }
	  }
	  translate([x-0.1,0,baseheight+wall+fanw/2+ztolerance]) rotate([0,90,0]) cylinder(d=fand,h=wall+0.2,$fn=180);
	}
      }

      // Fan sides
      for (m=[0,1]) mirror([0,m,0]) {
	  difference() {
	    translate([fansupportx,-fanw/2-ytolerance-wall,baseheight]) roundedbox(fansupportl,wall,wall+fanw,cornerd,0);
	    translate([fansupportx+fansupportl/2,-fanw/2-ytolerance-wall-0.1,baseheight+wall+fanw]) rotate([-90,0,0]) cylinder(d=fansupportl*0.8,h=wall+0.2,$fn=90);
	  }

	  for (x=[fansupportx+fansupportl-wall,fansupportx]) {
	    hull() {
	      translate([x,-fanw/2-ytolerance-wall-fansupportsidew,baseheight]) roundedbox(wall,fansupportsidew+wall,wall+fanw/2,cornerd,0);
	      translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,wall,wall+fanw,cornerd,0);
	    }
	  }
	}
  
      // Fan grill supports
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([grillsupportx,0,baseheight]) grillsupport();
	  translate([basel/2,0,baseheight]) rotate([0,0,180]) grillsupport();
	
	  if (0) for (x=[basel/2-wall,fansupportx]) {
	      hull() {
		translate([x,-fanw/2-ytolerance-wall-fansupportsidew,baseheight]) roundedbox(wall,fansupportsidew+wall,wall+fanw/2,cornerd,0);
		translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,wall,wall+fanw,cornerd,0);
	      }
	    }
	}
    }

    translate([-basel/2+(wall+diskl+wall)/2,-diskw/2-wall+textdepth-0.01,baseheight+wall+wall+(diskbaseh+diskh)/2]) rotate([90,0,0]) linear_extrude(textdepth) text(fulltext,size=textsize,font=textfont,valign="center",halign="center");
    translate([-basel/2+(wall+diskl+wall)/2,diskw/2+wall-textdepth+0.01,baseheight+wall+wall+(diskbaseh+diskh)/2]) rotate([90,0,180]) linear_extrude(textdepth) text(fulltext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module rewriterstandbase() {
  difference() {
    union() {
      for (x=[-basel/2+lockx,basel/2-lockx]) {
	for (m=[0,1]) mirror([0,m,0]) {
	    y=-basew/2+locky;
	    translate([x,y,0]) roundedcylinder(basetowerd+wall*2,baseheight,cornerd,1,90);
	    hull() {
	      h=lockclipbase+wall+lockclipl*sqrt(2);
	      translate([x,y,baseheight-h]) roundedcylinder(basetoweroutd,h,cornerd,0,90);
	      translate([x-lockclipoutl/2,y-lockclipoutw/2,baseheight-lockclipbase-wall]) roundedboxxyz(lockclipoutl,lockclipoutw,wall+lockclipbase,cornerd+dtolerance+wall,cornerd,0,90);
	    }
	  }
      }

      for (x=[-basel/2+lockx,basel/2-lockx]) {
	hull() {
	  for (m=[0,1]) mirror([0,m,0]) translate([x,-basew/2+locky,0]) roundedcylinder(basetowerd+wall*2,wall,cornerd,1,90);
	}
      }

      for (y=[-basew/2+locky,basew/2-locky]) {
	hull() {
	  for (x=[-basel/2+lockx,basel/2-lockx]) {
	    translate([x,y,0]) roundedcylinder(basetowerd+wall*2,wall,cornerd,1,90);
	  }
	}
      }
      
      supportl=basel-lockx*2-basetowerd-wall;
      supportw=basew-locky*2-basetowerd-wall;

      for (x=[-basel/2+lockx-wall/2,basel/2-lockx-wall/2]) {
	difference() {
	  translate([x,-supportw/2,0]) roundedbox(wall,supportw,baseheight,cornerd,1);
	  translate([x+wall+0.01,-basew/2+locky,0]) rotate([0,0,90]) lighten(basew-locky*2,baseheight,wall+0.02,15,10,maxbridge,"up",cornerd=cornerd);
	}
      }
      for (m=[0,1]) mirror([0,m,0]) {
	  difference() {
	    translate([-supportl/2,-basew/2+locky-wall/2,0]) roundedbox(supportl,wall,baseheight,cornerd,1);
	    translate([-supportl/2,-basew/2+locky-wall/2,0]) lighten(supportl,baseheight,wall+0.02,15,10,maxbridge,"up",cornerd=cornerd);
	  }
	}
    }

    for (x=[-basel/2+lockx,basel/2-lockx]) {
      for (y=[-basew/2+locky,basew/2-locky]) {
	translate([x,y,baseheight+wall-lockcliph/2+ztolerance]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,1);
	}
      }

    for (a=[0,180]) rotate([0,0,a]) {
	translate([-basel/2+lockx-wall/2+textdepth-0.01,0,wall+2+textsize/2]) rotate([90,0,-90]) linear_extrude(textdepth) text(fulltext,size=textsize,font=textfont,valign="center",halign="center");
      }
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([-200,-200,-200]) cube([400,200+basew/2-locky,400]);
    union() {
      translate([0,0,ztolerance/2]) rewriterstand35();
      rewriterstandbase();
      for (x=grillxtable) {
	translate([x,0,baseheight+wall+ztolerance+fanw/2]) rotate([0,90,0]) fangrill();
      }

      for (x=[-basel/2+lockx,basel/2-lockx]) {
	for (y=[-basew/2+locky,basew/2-locky]) {
#	  translate([x,y,baseheight+wall-lockcliph/2+ztolerance]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,0);
	}
      }
    }
  }
 }

if (print==1) {
  translate([-basel/2+basefrontgapl+basefrontl+xtolerance+fanw/2,0,0]) fangrill();
  translate([-basel/2+basefrontgapl+basefrontl+xtolerance+fanw/2,-basew/2-0.5-fanw/2,0]) fangrill();
  translate([0,0,-baseheight]) rewriterstand35();
 }

if (print==2) {
  rewriterstandbase();
 }

if (print==3) {
  intersection() {
    if (debug) translate([-200,-200,-200]) cube([200,400,400]);
    union() {
      hull() {
	roundedcylinder(basetowerd*2,wall,cornerd,1,90);
	roundedcylinder(basetoweroutd,10+cornerd,cornerd,1,90);
	cylinder(d=basetoweroutd,h=10,$fn=90);
      }
      translate([0,0,10]) {
	//roundlockclip(lockclipd+wall*2,wall,lockclipd,wall,wall,cornerd);
	//roundlockclip(lockclipd+wall*2,wall+lockclipsink,lockclipd,wall,wall,cornerd);	
      }
    }
  }
 }

if (print==4) {
  if (fanw<61) {
    translate([-fanw/2-0.25,0,0]) fangrill();
  }
  translate([fanw/2+0.25,0,0]) fangrill();
 }

if (print==5 || print==2) {
  for (a=[0,180]) rotate([0,0,a]) {
      translate([-lockclipl/2-lockclipoverhang-0.25,0,lockclipw/2]) rotate([90,0,0]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,0);
      translate([-lockclipl-0.5-lockclipoverhang*2-lockclipl/2-lockclipoverhang-0.25,0,lockclipw/2]) rotate([90,0,0]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,0);
    }
 }
