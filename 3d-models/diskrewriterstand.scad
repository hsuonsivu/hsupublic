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
cornerd=1;
largecornerd=10;

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
fanscrewl=(fantype!=-1)?fansizetable[fantype][1]:0;
fanscreww=fanscrewl;
fanh=fantype!=-1?fansizetable[fantype][2]:0;
fanzcornerd=fanw-fanscreww;
  
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
  
basel=diskl+20+wall+fanh+wall;
basew=wall+lockclipd+wall+wall+diskw+wall+wall+lockclipd+wall;
baseh=wall;
baseheight=100;

if (fantype!=-1) echo("Fan type ",fantype," size ",fanw," screws ",fanscrewl," thickness ",fanl);

fansupportl=wall+xtolerance+fanh+0.5+xtolerance+wall;
fansupportx=basel/2-fansupportl;
fansupportw=wall+ytolerance+fanw+ytolerance+wall;
fansupportsidew=10;

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
    translate([-basel/2,-basew/2,baseheight]) roundedboxxyz(basel,basew,wall,largecornerd,cornerd,1,90);
    for (x=[-basel/2+lockx,basel/2-lockx]) {
      for (y=[-basew/2+locky,basew/2-locky]) {
	translate([x,y,baseheight-0.1]) cylinder(d=lockclipd+dtolerance,h=wall+0.2,$fn=90);
      }
    }
  }
}

module rewriterstand35() {
  base();

  // Disk side supports
  for (m=[0,1]) mirror([0,m,0]) {
      translate([-basel/2,-diskw/2-wall,baseheight]) roundedbox(wall+diskl+wall,wall,wall+diskbaseh+diskh,cornerd,0);
      translate([-basel/2,-diskw/2-wall,baseheight]) roundedbox(wall+diskl+wall,diskbasew+wall,wall+diskbaseh,cornerd,0);
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

  // Fan support
  for (x=[basel/2-wall,fansupportx]) {
    difference() {
      union() {
	translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,fansupportw,wall+fanw/2,cornerd,0);
	for (m=[0,1]) mirror([0,m,0]) {
	    	  translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,fanw/4,wall+fanw,cornerd,0);
	  }
      }
      translate([x-0.1,0,baseheight+wall+fanw/2+ztolerance]) rotate([0,90,0]) cylinder(d=fanw-wall,h=wall+0.2,$fn=180);
    }
  }

  for (m=[0,1]) mirror([0,m,0]) {
      translate([fansupportx,-fanw/2-ytolerance-wall,baseheight]) roundedbox(fansupportl,wall,wall+fanw,cornerd,0);

      for (x=[basel/2-wall,fansupportx]) {
	hull() {
	  translate([x,-fanw/2-ytolerance-wall-fansupportsidew,baseheight]) roundedbox(wall,fansupportsidew+wall,wall+fanw/2,cornerd,0);
	  translate([x,-fanw/2-ytolerance-wall,baseheight]) roundedbox(wall,wall,wall+fanw,cornerd,0);
	}
      }
    }
}

module rewriterstandbase() {
  for (x=[-basel/2+lockx,basel/2-lockx]) {
    for (m=[0,1]) mirror([0,m,0]) {
	y=-basew/2+locky;
	translate([x,y,baseheight-wall-lockclipsink]) roundlockclip(lockclipd+wall*2,wall+lockclipsink,lockclipd,wall,wall,cornerd);
	translate([x,y,0]) roundedcylinder(lockclipd+wall*2,baseheight-lockclipbase+wall,cornerd,1,90);
      }
  }

  for (x=[-basel/2+lockx,basel/2-lockx]) {
    hull() {
      for (m=[0,1]) mirror([0,m,0]) translate([x,-basew/2+locky,0]) roundedcylinder(lockclipd+wall*2,wall,cornerd,1,90);
    }
  }

  for (y=[-basew/2+locky,basew/2-locky]) {
    hull() {
      for (x=[-basel/2+lockx,basel/2-lockx]) {
	translate([x,y,0]) roundedcylinder(lockclipd+wall*2,wall,cornerd,1,90);
      }
    }
  }

  supportl=basel-lockx*2-lockclipd-wall;
  supportw=basew-locky*2-lockclipd-wall;

  for (x=[-basel/2+lockx-wall/2,basel/2-lockx-wall/2]) {
    difference() {
      translate([x,-supportw/2,0]) roundedbox(wall,supportw,baseheight,cornerd,1);
      translate([x+wall+0.1,-basew/2+locky,0]) rotate([0,0,90]) lighten(basew-locky*2,baseheight,wall+0.2,15,10,maxbridge,"up");
    }
  }
  for (m=[0,1]) mirror([0,m,0]) {
      difference() {
	translate([-supportl/2,-basew/2+locky-wall/2,0]) roundedbox(supportl,wall,baseheight,cornerd,1);
	translate([-supportl/2,-basew/2+locky-wall/2,0]) lighten(supportl,baseheight,wall+0.2,15,10,maxbridge,"up");
      }
    }
}

if (print==0) {
  intersection() {
    if (debug) translate([-200,-200,-200]) cube([400,200+basew/2-locky,400]);
    union() {
      translate([0,0,ztolerance/2]) rewriterstand35();
      rewriterstandbase();
    }
  }
 }

if (print==1) {
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
	roundedcylinder(lockclipd*2,wall,cornerd,1,90);
	roundedcylinder(lockclipd+wall*2,10+cornerd,cornerd,1,90);
	cylinder(d=lockclipd+wall*2,h=10,$fn=90);
      }
      translate([0,0,10]) {
	//roundlockclip(lockclipd+wall*2,wall,lockclipd,wall,wall,cornerd);
	roundlockclip(lockclipd+wall*2,wall+lockclipsink,lockclipd,wall,wall,cornerd);	
      }

      if (0) translate([lockclipd*2/2+0.5+lockclipd*3/2,0,0]) {
	difference() {
	  roundedcylinder(lockclipd*3,wall,cornerd,1,90);
	  translate([0,0,-0.1]) cylinder(d=lockclipd+dtolerance,h=wall+0.2,$fn=90);
	}
      }
    }
  }
 }
