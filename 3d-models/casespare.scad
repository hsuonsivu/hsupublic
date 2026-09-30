// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=0;

wall=2;
cornerd=1.6;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;
maxbridge=10;

versiontext="V1.3";
textdepth=0.8;
textsize=6;
brandtext="Casespare";
longtext=str(brandtext," ",versiontext);


l=167;
w=39.13;

//6.13 measured. NOTE this may not be higher than clip space bottom
//(fingerbaseh) without modifications.
bodyh=wall+1;
loww=57.17;
lowl=14;
lowmergel=55;

barh=2.3;
barx=48;
barl=167-barx-wall;
bary=4.5;
barw=12-bary;

//roundxtable=[-8,-17,-17]; // From screwx;
roundxtable=[-17+4,-17+0.1,-17+0.1]; // From screwx;
roundy=26+0.1;
roundd=15;
roundh=0.8;

fixscrewholex=9;
fixscrewholey=w-30+0.5+0.1;
fixscrewholeh=5.3-2.55;
fixscrewholed=4+dtolerance;
fixscrewtopholed=9;

floppyholey=17.25;//.5;
floppyholex=24.5;
floppyholed=9;

piikkud=2.37;
piikkih=3.8;

piikkiscrewkantah=1.3;
piikkiscrewkantad=9;
piikkiscrewh=7+1.75-piikkiscrewkantah;
piikkiscrewd=2.1;

floppyscrewx=24.5;
floppyscrewy=46.8; //47;

diskscrewxtable=[66.6+0.2,111+0.2,154+0.2];
diskscrewytable=[-14,65];

frontnotchl=8.2;
frontnotchh=2.6;
frontnotchw=4;
frontnotchxtable=[68.5,105.04,146];
backnotchxtable=[41.66,89.12,132,167];
backnotchltable=[6.45,8.26,8.26,5.7];
backnotchw=4;
notchh=2.6;

tapeholderx=diskscrewxtable[1];
tapeholderfirstw=99;
tapeholderhumpheight=8;
tapeholderhumpw=109-tapeholderfirstw;
//tapeholderbackw=148-tapeholderfirstw-tapeholderhumpw;
tapeholderbackw=141-tapeholderfirstw-tapeholderhumpw;
tapeholdercatchh=13;
tapeholderbelowh=2.5;
tapeholdercatchw=3;

tapeholderl=16;

screwholderl=16;
screwholderhopw=12;
screwholderhoph=5.5;
screwholderscreww=14;
screwholderoutw=8;
screwholderraisew=19;
screwholderraiseh=25-wall;
screwholderfrontraiseh=12;
screwholderhandlew=10;
fingerl=14;
fingertopl=10;
fingercut=wall;

fingerbaseh=barh+wall;

fingerclipx=-fingerl/2;
fingerclipw=30;
fingerclipl=maxbridge-xtolerance*2;
fingerclipy=-screwholderhopw-screwholderscreww-fingerclipw;
fingercliplockw=6;
fingercliplockl=fingerclipl-cornerd/2;
fingercliplocky=fingerclipy+fingerclipw-fingercliplockw-wall-4;
fingercliplockh=ztolerance+wall+ztolerance*2;
fingerclipheight=barh+wall+ztolerance;
fingercliph=wall;

fingercoverx=-fingerl/2-xtolerance-wall;
fingercoverl=wall+xtolerance+fingerclipl+xtolerance+wall;
fingercovery=fingerclipy-ytolerance-wall;
fingercoverw=fingerclipw;

fingercoverspringbasew=8;
fingercoverspringw=13-fingercoverspringbasew+wall/2;
fingercoverspringbasel=fingercoverspringw;
fingercoverspringbasewiden=8;
fingercoverspringheight=bodyh+0.4;
fingercoverspringy=fingercovery-fingercoverspringw;
fingercoverspringtopheight=fingerclipheight+fingercliph+ztolerance*2;
fingercoverspringsideh=wall+1;
fingerlockl=fingercoverl+6;

module floppyfinger() {
  difference() {
    union() {
      hull() {
	translate([-fingerl/2,floppyscrewy-screwholderscreww-wall+screwholderhoph,0]) roundedbox(fingerl,wall+screwholderscreww+screwholderoutw-screwholderhoph,wall,cornerd,7);
	translate([-fingerl/2,floppyscrewy-screwholderscreww-wall+screwholderhoph,0]) roundedbox(fingerl,wall+screwholderscreww+screwholderoutw-screwholderhoph,wall,cornerd,7);
      }
      hull() {
	translate([-fingerl/2,floppyscrewy+screwholderoutw-wall,0]) roundedbox(fingerl,wall,wall,cornerd,7);
	translate([-fingerl/2,floppyscrewy+screwholderoutw-wall+screwholderraisew,screwholderraiseh]) roundedbox(fingerl,wall,wall,cornerd,7);
      }
      for (x=[-fingerl/2,fingerl/2-wall]) {
	hull() {
	  translate([x,floppyscrewy+screwholderoutw-wall,0]) roundedbox(wall,wall,wall,cornerd,7);
	  translate([x,floppyscrewy+screwholderoutw-wall+screwholderraisew-wall,screwholderraiseh]) roundedbox(wall,wall+wall,wall,cornerd,7);
	}
      }

      translate([0,floppyscrewy,wall-0.01]) cylinder(d1=piikkiscrewkantad+(piikkiscrewh-piikkih-wall)*2,d2=piikkiscrewkantad,h=piikkiscrewh-piikkih-wall+0.01,$fn=90);
    }
    translate([0,floppyscrewy,-0.01]) piikkihole(printability=0);
  }
}

module finger(y,l=fingerl,tapedriveholder=0,narrow=0) {
  ll=narrow?fingertopl:l;
  difference() {
    union() {
      translate([fingerclipx,y+fingerclipy,fingerclipheight]) roundedbox(fingerclipl,fingerclipw,fingercliph,cornerd,7);
      hull() {
	translate([fingerclipx+fingerclipl/2-fingercliplockl/2,y+fingercliplocky,fingerclipheight]) roundedbox(fingercliplockl,fingercliplockw,fingercliph,cornerd,0);
	translate([fingerclipx+fingerclipl/2-fingercliplockl/2+fingercliplockh,y+fingercliplocky+fingercliplockw-1,fingerclipheight]) cube([fingercliplockl-fingercliplockh*2,1,fingercliph+fingercliplockh]);
      }
    
      translate([-l/2,y-screwholderhopw-screwholderscreww-wall,fingerclipheight]) roundedbox(l,wall,screwholderhoph+wall-fingerclipheight,cornerd,7);
      translate([-l/2,y-screwholderhopw-screwholderscreww-wall,screwholderhoph]) roundedbox(l,wall+screwholderhopw,wall,cornerd,7);
      hull() {
	translate([-l/2,y-screwholderscreww-wall+screwholderhoph,0]) roundedbox(l,wall,wall,cornerd,7);
	translate([-l/2,y-screwholderscreww-wall,screwholderhoph]) roundedbox(l,wall,wall,cornerd,7);
      }
      
      if (tapedriveholder) {
	translate([-l/2,y-screwholderscreww-wall+screwholderhoph,0]) roundedbox(l,-diskscrewytable[1]+wall+tapeholderfirstw+screwholderoutw,wall,cornerd,7);
	translate([-l/2,tapeholderfirstw-wall,0]) roundedbox(l,wall,tapeholderhumpheight+wall,cornerd);
	translate([-l/2,tapeholderfirstw+tapeholderhumpw,-tapeholderbelowh]) roundedbox(l,wall,tapeholderhumpheight+wall+tapeholderbelowh,cornerd);
	translate([-l/2,tapeholderfirstw-wall,tapeholderhumpheight]) roundedbox(l,wall+tapeholderhumpw+wall,wall,cornerd,7);
	translate([-l/2,tapeholderfirstw+tapeholderhumpw,-tapeholderbelowh]) roundedbox(l,tapeholderbackw+wall,wall,cornerd,7);
	translate([-l/2,tapeholderfirstw+tapeholderhumpw+tapeholderbackw,-tapeholderbelowh-tapeholdercatchh-wall]) roundedbox(l,wall,wall+tapeholdercatchh+wall,cornerd,7);
	translate([-l/2,tapeholderfirstw+tapeholderhumpw+tapeholderbackw-tapeholdercatchw,-tapeholderbelowh-tapeholdercatchh-wall]) roundedbox(l,tapeholdercatchw+wall,wall,cornerd,7);
      } else {
	translate([-l/2,y+screwholderoutw-wall+screwholderraisew,screwholderraiseh]) roundedbox(ll,screwholderhandlew,wall,cornerd,7);
	hull() {
	  translate([-l/2,y-screwholderscreww-wall+screwholderhoph,0]) roundedbox(ll,wall+screwholderscreww+screwholderoutw-screwholderhoph,wall,cornerd,7);
	  translate([-l/2,y-screwholderscreww-wall+screwholderhoph,0]) roundedbox(l,wall+screwholderscreww+screwholderoutw-screwholderhoph-(l-ll),wall,cornerd,7);
	}
	hull() {
	  translate([-l/2,y+screwholderoutw-wall,0]) roundedbox(ll,wall,wall,cornerd,7);
	  translate([-l/2,y+screwholderoutw-wall+screwholderraisew,screwholderraiseh]) roundedbox(ll,wall,wall,cornerd,7);
	}
      }

      for (y=[diskscrewytable[1]]) {
	translate([0,y,wall-0.01]) cylinder(d1=piikkiscrewkantad+(piikkiscrewh-piikkih-wall)*2,d2=piikkiscrewkantad,h=piikkiscrewh-piikkih-wall+0.01,$fn=90);
      }
    }

    for (y=[diskscrewytable[1]]) {
      translate([0,y,-0.01]) piikkihole(printability=1);
    }

    translate([0,y-diskscrewytable[1]+w+screwholderhopw/2-wall/2,screwholderhoph+wall-textdepth+0.01]) rotate([0,0,0]) resize([l-cornerd-1,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module fingersupport() {
  translate([0,0,0]) cube([0.4,0.4,fingercoverspringtopheight-0.2]);
  translate([wall-0.40,0,0]) cube([0.4,0.4,fingercoverspringtopheight-0.2]);
  translate([0,0,fingercoverspringtopheight-0.4]) cube([wall,0.4,0.2]);
}

module fingercover(y,l=fingerl) {
  supportw=fingercoverspringw+fingercoverw-fingercoverspringbasew;
  supports=floor(supportw/maxbridge)+1;
  supportstep=supportw/supports;
  for (i=[0:1:supports-1]) {
    for (x=[fingercoverx,fingercoverx+fingercoverl-wall]) {
      translate([x,y+fingercovery+fingercoverw-0.4-i*supportstep,0]) fingersupport();
    }
  }

  for (x=[fingercoverx,fingercoverx+fingercoverl-wall]) {
    translate([x,y+fingercoverspringy+cornerd/2,fingercoverspringheight-0.2]) cube([wall,fingercoverspringw+fingercoverw-cornerd/2,fingercoverspringtopheight-0.4-fingercoverspringheight]);
    translate([x,y+fingercoverspringy+cornerd/2,fingercoverspringtopheight-0.2]) cube([wall,fingercoverspringw+fingercoverw-cornerd/2,0.4]);
  }
  hull() {
    translate([fingercoverx,y+fingercoverspringy,0]) roundedbox(fingercoverl,fingercoverspringbasew,fingercoverspringtopheight+wall,cornerd,0);
    translate([fingercoverx-fingercoverspringbasewiden,y+fingercoverspringy,0]) roundedbox(fingercoverl+fingercoverspringbasewiden*2,fingercoverspringbasew,barh+wall,cornerd,0);
  }
  difference() {
    union() {
      hull() {
	translate([fingercoverx,y+fingercoverspringy,fingercoverspringtopheight+0.2]) roundedbox(fingercoverl,fingercoverspringw+fingercoverw,wall,cornerd,0);
	translate([fingercoverx,y+fingercoverspringy+cornerd/2,fingercoverspringtopheight+0.2]) cube([fingercoverl,fingercoverspringw+fingercoverw-cornerd/2,0.01]);
      }
      for (x=[fingercoverx,fingercoverx+fingercoverl-wall]) {
	translate([x,y+fingercoverspringy,fingercoverspringtopheight]) roundedbox(wall,fingercoverspringw+fingercoverw,fingercoverspringsideh,cornerd,0);
      }
    }
  }
}

module fingercut(nohump=0) {
  if (nohump) {
    for (m=[0,1]) mirror([m,0,0]) translate([-fingerl/2-fingercut,-screwholderhopw-screwholderscreww+wall,-cornerd/2]) roundedbox(fingercut,screwholderhopw+screwholderscreww,bodyh+cornerd,cornerd,0);
    translate([-fingerl/2-fingercut,-screwholderhopw-screwholderscreww+wall,wall]) roundedbox(fingercut+fingerl+fingercut,screwholderhopw+screwholderscreww-wall-(floppyscrewy-w)+cornerd/2,wall+(bodyh-wall)+cornerd/2,cornerd,0);
  } else {
    translate([-fingerl/2-xtolerance,fingercliplocky-ytolerance,fingercoverspringtopheight-cornerd/2]) cube([fingerclipl+xtolerance*2,fingercliplockw+ytolerance*2,wall+cornerd]);
  }
}

module piikkihole(printability=0) {
  translate([0,0,-0.01]) {
    hull() {
      cylinder(d=piikkiscrewd,h=piikkiscrewh,$fn=90);
      if (printability) translate([0,-piikkiscrewd/4,0]) cube([piikkiscrewd/2,piikkiscrewd/2,piikkiscrewh]);
    }
  }
  translate([0,0,-piikkih+piikkiscrewh]) cylinder(d=piikkiscrewkantad-0.01,h=bodyh+0.02,$fn=90);
}

module casespare() {
  difference() {
    union() {
      translate([0,0,0]) roundedbox(l,w,bodyh,cornerd,1);
      hull() {
	translate([0,0,0]) roundedbox(lowmergel,w,bodyh,cornerd,1);
	translate([0,-(loww-w),0]) roundedbox(lowl,loww,bodyh,cornerd,1);
      }

      translate([floppyscrewx,0,0]) floppyfinger();

      for (i=[0:1:len(diskscrewxtable)-1]) {
	translate([diskscrewxtable[i]-fingerl/2+fingercoverx+fingercoverl/2,0,0]) roundedbox(fingercoverl,w,barh+wall,cornerd,1);
	translate([diskscrewxtable[i],0,0]) fingercover(diskscrewytable[1]);
      }

      for (i=[0:1:len(frontnotchxtable)-1]) {
	translate([frontnotchxtable[i]-frontnotchl,-frontnotchw,0]) roundedbox(frontnotchl,frontnotchw+cornerd,notchh,cornerd,1);
      }

      for (i=[0:1:len(backnotchxtable)-1]) {
	translate([backnotchxtable[i]-backnotchltable[i],w-cornerd,0]) roundedbox(backnotchltable[i],cornerd+backnotchw,notchh,cornerd,1);
      }

      translate([barx-wall,bary-wall,0]) {
	roundedbox(barl+wall*2,barw+wall*2,barh+wall,cornerd,0);
      }

      hull() {
	translate([0,diskscrewytable[0]-screwholderscreww/2,0]) roundedbox(diskscrewxtable[2]+cornerd,screwholderscreww,wall,cornerd,1);
	hull() {
	  translate([diskscrewxtable[2],diskscrewytable[0]-screwholderscreww/2,0]) roundedbox(cornerd,screwholderscreww,wall,cornerd,1);
	  translate([diskscrewxtable[2],diskscrewytable[0],0]) roundedcylinder(piikkiscrewkantad+(piikkiscrewh-piikkih-wall)*2,wall,cornerd,1,90);	  
	}
      }

      for (i=[0,1]) {
	x=(diskscrewxtable[i+1]+diskscrewxtable[i]-wall*2)/2;
	translate([x,diskscrewytable[0]-fingerl/2,0]) roundedbox(wall*2,fingerl,screwholderfrontraiseh,cornerd,1);
	hull() {
	  translate([x-wall,diskscrewytable[0]-fingerl/2,screwholderfrontraiseh-wall]) roundedbox(wall*2+wall*2,fingerl,wall,cornerd,1);
	  translate([x,diskscrewytable[0]-fingerl/2,screwholderfrontraiseh-wall-wall]) roundedbox(wall*2,fingerl,wall+wall,cornerd,1);
      }
      }
      
      for (x=diskscrewxtable) {
	for (y=[diskscrewytable[0]]) {
	  translate([x,y,wall-0.01]) cylinder(d1=piikkiscrewkantad+(piikkiscrewh-piikkih-wall)*2,d2=piikkiscrewkantad,h=piikkiscrewh-piikkih-wall+0.01,$fn=90);
	}
      }
    }

    translate([floppyholex,floppyholey,-0.01]) cylinder(d=floppyholed,h=bodyh+0.02,$fn=90);
    translate([fixscrewholex,fixscrewholey,-0.01]) cylinder(d=fixscrewholed,h=bodyh+0.02,$fn=90);
    translate([fixscrewholex,fixscrewholey,fixscrewholeh]) cylinder(d=fixscrewtopholed,h=bodyh+0.02,$fn=90);
    translate([floppyscrewx,floppyscrewy,0]) fingercut(nohump=1);

    for (i=[0:1:len(diskscrewxtable)-1]) {
      translate([diskscrewxtable[i],diskscrewytable[1],0]) fingercut();
      translate([diskscrewxtable[i]+roundxtable[i],roundy,-0.01]) cylinder(d1=roundd,d2=roundd-bodyh,h=bodyh+0.02,$fn=90);
    }

    for (x=diskscrewxtable) {
      for (y=[diskscrewytable[0]]) {
	//translate([x,y,wall-0.01]) cylinder(d1=piikkiscrewkantad+(piikkiscrewh-piikkih-wall)*2,d2=piikkiscrewkantad,h=piikkiscrewh-piikkih-wall+0.01,$fn=90);
	translate([x,y,0]) rotate([0,0,-90]) piikkihole(printability=1);
      }
    }
    
    translate([barx,bary,-cornerd/2]) {
      roundedboxxyz(barl,barw,barh+cornerd/2,cornerd,0,0,90);
    }

    translate([floppyscrewx,diskscrewytable[0]+fingerl/2,-cornerd/2]) roundedbox(diskscrewxtable[0]-floppyscrewx,fingercut,bodyh+cornerd,cornerd,0);
    translate([floppyscrewx,diskscrewytable[0]-fingerl/2-fingercut,wall]) roundedbox(lowmergel-floppyscrewx,fingerl+fingercut*2,wall,cornerd,0);
    
    translate([cornerd/2+1,0,bodyh-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(brandtext, size=textsize, valign="center",halign="left",font="Liberation Sans:style=Bold"); 
    translate([cornerd/2+1,-textsize,bodyh-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="left",font="Liberation Sans:style=Bold"); 
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([0,-100,-100]) cube([diskscrewxtable[2],125,300]);
    union() {
      casespare();

      for (i=[0,2]) {
	translate([diskscrewxtable[i],0,0]) finger(diskscrewytable[1],narrow=(i==2));
      }
      translate([diskscrewxtable[1],0,0]) finger(diskscrewytable[1],tapedriveholder=1);
    }
  }
 }

if (print==1 || print==4) {
  casespare();
 }

if (print==2 || print==4) {
  for (i=[0,1,2]) {
    translate([55+diskscrewytable[1],diskscrewytable[0]-wall-0.5-5-i*(wall+wall+1.1),fingerl/2]) rotate([0,-90,90]) finger(diskscrewytable[1],narrow=(i==0));
  }
 }

if (print==3 || print==4) {
  translate([110+diskscrewytable[1],w+tapeholderhumpheight+backnotchw,fingerl/2]) rotate([0,-90,90]) finger(diskscrewytable[1],tapedriveholder=1);
 }


