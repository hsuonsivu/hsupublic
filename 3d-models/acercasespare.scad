// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;

l=92.25;
w=16.95;
h=12.45;
belowl=85;
sidel=91.25;
sidew=1.8;
minimumh=1.8;
endh=5;
wall=2;

xtable=[6.3,56.15];
slideholel=11.2;
slided=4;
slidelowh=2.88;
slidehighh=9.3;
raill=15.82;
railxtable=[0,75.6];
railw=20.57;
railh=2.2;
belownw=14;
belownh=5.57;
beloww=11;//10.84;
widenxtable=[15.8,65.2];
widel=23.9;
topholextable=[4,54.5];
topholeltable=[25.55,27.4];
topholebelowxtable=[2.3,52];
topholebelowh=11.25;
topholebelowltable=[29.48,31];
topholebeloww=10.8;
pressxtable=[25.8,65];
pressd=6;
pressl=57;//12;
pressw=6.4;
topholew=ytolerance+pressw+ytolerance; //7.8;
pressheight=0.5; // 1mm measured, 0.5 for pretension
presswall=1.6;
presscornerd=presswall;

toplowerxtable=[2.3,53];
toplowerztable=[7.7,9.5];

cutl=11;//32.4;//9;
closedcutx=47;//42;//67.5-9;
opencutx=64-cutl;
cutw=1.1;
cuth=5.5;

cornerd=0.5;

springprintable=5;

midsupportx=(pressxtable[0]+pressxtable[1])/2;
midsupportl=11;
midclipl=xtolerance*2+0.2;

module slidehole() {
  hull() {
    translate([0,-w/2-cornerd/2,slidehighh-slided/2]) rotate([-90,0,0]) cylinder(d=slided,h=w+cornerd,$fn=90);
    translate([-slided/2+slideholel-slided/2,-w/2-cornerd/2,slidehighh-slided/2]) rotate([-90,0,0]) cylinder(d=slided,h=w+cornerd,$fn=90);
    translate([-slided/2+slideholel-slided/2,-w/2-cornerd/2,slidelowh+slided/2]) rotate([-90,0,0]) cylinder(d=slided,h=w+cornerd,$fn=90);
  }
  hull() for (d=[0,2]) {
    translate([-slided/2+slideholel-slided/2,-belownw/2+d,slidelowh+slided/2+d]) rotate([-90,0,0]) roundedcylinder(slided,belownw-d*2,cornerd,0,90);
    translate([-slided/2+slideholel-slided/2+slided,-belownw/2+d,slidelowh+slided/2+d]) rotate([-90,0,0]) roundedcylinder(slided,belownw-d*2,cornerd,0,90);
  }
}

module springform() {
  translate([0,-pressw/2,0]) roundedbox(presswall,pressw,presswall,presscornerd,springprintable);
}

module spring() {
  dw=10;
  dl=(dw-cutw)/2;
  midx=(pressxtable[0]+pressxtable[1])/2;
  difference() {
    union() {
      for (x=pressxtable) {
	translate([x-pressd/2,-pressw/2,pressheight]) roundedbox(pressd,pressw,wall,cornerd,springprintable);
	
	hull() {
	  translate([x-pressd/2,0,pressheight]) springform();
	  translate([x-presswall/2,0,pressheight+cuth]) springform();
	}
	hull() {
	  translate([x+pressd/2-presswall,0,pressheight]) springform();
	  translate([x-presswall/2,0,pressheight+cuth]) springform();
	}
      }
      hull() for (x=[midsupportx-midsupportl/2-xtolerance-presswall,midsupportx+midsupportl/2+xtolerance]) {
	translate([x,0,topholebelowh-ztolerance-presswall]) springform();
      }
      for (x=[midsupportx-midsupportl/2-xtolerance-presswall,midsupportx+midsupportl/2+xtolerance]) {
	hull() {
	  translate([x,0,topholebelowh-ztolerance-presswall]) springform();
	  translate([x,0,h+ztolerance]) springform();
	}
      }
      for (x=[midsupportx-midsupportl/2-xtolerance-presswall,midsupportx+midsupportl/2+xtolerance-midclipl]) {
	hull() {
	  for (xx=[0,midclipl]) 
	    translate([x+xx,0,h+ztolerance]) springform();
	}
      }

      for (i=[0,1]) {
	hull() {
	  translate([pressxtable[i]-presswall/2,0,pressheight+cuth]) springform();
	  translate([i==0?midsupportx-midsupportl/2-presswall:midsupportx+midsupportl/2,0,topholebelowh-ztolerance-presswall]) springform();
	}
      }
    }

    //#    translate([closedcutx,-cutw/2,-0.01]) cube([opencutx+cutl-closedcutx,cutw,cuth+0.02]);
    hull() {
      translate([opencutx,-cutw/2,-0.01]) cube([cutl,cutw,cuth+0.02]);
      translate([opencutx+dl,-dw/2,-0.01]) cube([cutl-dl*2,dw,cuth+0.02]);
    }
    //translate([opencutx,-dw/2,-0.01]) cube([cutl-(pressw-cutw+0.1)/2+cornerd,dw,cuth+0.02]);
  }
}

module diskclip() {
  dw=(beloww-topholew)/2-0.5;
  difference() {
    union() {
     translate([0,-w/2,0]) roundedbox(l,w,h,cornerd,1);
      for (x=railxtable) {
	translate([x,-railw/2,0]) roundedbox(raill,railw,railh,cornerd,1);
      }
    }

    translate([topholextable[0],-topholew/2,-cornerd/2]) roundedbox(midsupportx-midsupportl/2-topholextable[0],topholew,h+cornerd,cornerd,3);
    translate([midsupportx+midsupportl/2,-topholew/2,-cornerd/2]) roundedbox(topholextable[1]+topholeltable[1]-(midsupportx+midsupportl/2),topholew,h+cornerd,cornerd,3);
    
    for (x=xtable) {
      translate([x,0,0]) slidehole();
    }
    
    hull() {
      translate([-cornerd/2,-beloww/2,-cornerd/2]) roundedbox(belowl+cornerd/2,beloww,toplowerztable[0]-dw+cornerd/2,cornerd,3);
      translate([-cornerd/2,-topholew/2,-cornerd/2]) cube([belowl+cornerd/2,topholew,toplowerztable[0]+cornerd/2]);
    }
    translate([-cornerd/2,-beloww/2,-cornerd/2]) roundedbox(l+cornerd,beloww,endh+cornerd/2,cornerd,3);
    for (m=[0,1]) mirror([0,m,0]) translate([-cornerd/2,-beloww/2,-cornerd/2]) roundedbox(sidel+cornerd/2,sidew+cornerd/2,toplowerztable[0]+cornerd/2,cornerd,3);

    hull() {
      translate([topholebelowxtable[0],-beloww/2,-cornerd/2]) roundedbox(topholebelowxtable[1]+topholebelowltable[1]-topholebelowxtable[0],beloww,topholebelowh-dw+cornerd/2,cornerd,3);
      translate([topholebelowxtable[0],-topholew/2,-cornerd/2]) cube([topholebelowxtable[1]+topholebelowltable[1]-topholebelowxtable[0],topholew,topholebelowh+cornerd/2]);
    }
      
    for (i=[0,1]) {
      for (m=[0,1]) mirror([0,m,0]) hull() {
	  translate([widenxtable[i],-belownw/2,-cornerd/2]) roundedbox(widel,belownw-beloww,belownh+cornerd/2,cornerd,3);
	  translate([widenxtable[i],-belownw/2+2,-cornerd/2]) roundedbox(widel,belownw-beloww,belownh+cornerd/2+2,cornerd,3);
	}
    }

    translate([topholebelowxtable[0],-beloww/2,-cornerd/2]) roundedbox(topholebelowxtable[1]+topholebelowltable[1]-topholebelowxtable[0],beloww,toplowerztable[1]-dw+cornerd/2,cornerd,3);
  }

  supportw=beloww-sidew*2;
#  translate([belowl,-supportw/2,0]) supportbox(l-belowl,supportw,endh,1);
}

if (print==0) {
  diskclip();
  spring();
 }

if (print==1 || print==3) {
  diskclip();
  translate([0,w/2,pressw/2]) rotate([-90,0,0]) spring();
 }


