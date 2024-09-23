// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0; // 0=model, 1=base only, 2=top only, 3=single shield, 4=set of towers, 5=base, bugscreen, 6=top, shield and 3 towers, 7=2 shields and 6 towers, 8=one tower, 9=pair of 62mm pipe attachment, 10 bug shield

$fn=60;

shields=3; // Not including top
forceinfill=1;

// Turn on bug protection
bugprotection=1;

// Make a tunnel for cables
cabletunnel=0;

versiontext="v1.2";
copyrighttext="© Heikki Suonsivu CC-BY-NC-SA";

textsize=7;
copyrighttextsize=5;
smalltextsize=textsize-2;
textdepth=1;

wall=2;

plated=100;
incircled=plated-24;
ind=plated-30;
towerpositiond=(ind+plated)/2;
topplated=plated;
topbottomd=plated*1.34;
topmidd=plated*1.16;
bottomd=plated*1.28;
midd=plated*1.13;
shieldbottom=0;
shieldmidh=29;
shieldh=40;
shieldinh=30;
shielddistance=30;
shieldoverlap=10;

baseh=40;
cornerd=1;
componentplateoffset=plated/5;
componentw=40;
componentplateh=shielddistance*shields+shieldoverlap;
componentholeedge=6;
componentholed=4.5;
componentholes=4;
componentholedistance=(componentw-componentholeedge*2)/componentholes;
componentholestart=componentholeedge+componentholedistance/2;
componentsquareholed=7;
componentsquareholes=2;
componentsquareholedistance=(componentw-componentholeedge*2)/componentsquareholes;
componentsquareholestart=componentholeedge+componentsquareholedistance/2-componentsquareholed/2;

attachmentdistance=topbottomd/2+50;
attachmentdistancew=65;

barh=(shields+1)*shielddistance;
barw=15;
bardepth=8;

topdtable=[topbottomd/2,topmidd/2,topplated/2,0];
tophtable=[shieldbottom,shieldmidh,shieldh,shieldh];
dtable=[bottomd/2,midd/2,plated/2,incircled/2,ind/2];
htable=[shieldbottom,shieldmidh,shieldh,shieldh,shieldinh];

ztolerance=0.3;
xtolerance=0.2;
ytolerance=0.2;
dtolerance=0.2*2;

towerclipdepth=1.5;
towerdtolerance=0.35;
towerbodyd=(plated-incircled)/2-2;
towerscaling=2; // Stretch towers along the circumference
towerclipd=8;
towerclipheight=17;
towercliph=4;
towerclipth=1; // Vertical transition for diameter
towerclipparth=towerclipth+towercliph+towerclipth;
towerclipholedepth=towerclipheight+towerclipparth+ztolerance;
towerind=towerclipd-towerclipdepth;
toweryscaling=towerclipd/towerind*2;
towerholed=towerind;
totalh=(shields+1)*shielddistance+baseh+shieldoverlap+shieldh;
towerclipcut=1.5;
towerclipcutheight=1;
screwd=3.5;
screwlength=30;
screwtowerd=3*screwd;

pipeattachh=screwtowerd+cornerd*2;
pipeattachw=attachmentdistancew;
pipeattachthickness=screwtowerd+cornerd;
pipeattachcut=1;
pipeattachscrewdepth=13;
pipeattachscrewlength=35;

cablemaxdiameter=10;
cabletunnelw=cablemaxdiameter+2*wall;
cabletunnelyoffset=componentplateoffset+cablemaxdiameter/2;
cabletunnelxstart=componentplateoffset+wall/2;
cabletunnelslide=4; // Slight slide towards outside.
cabletunnelyslide=cablemaxdiameter/2+wall*2;
cabletunnelzstart=baseh-wall+cablemaxdiameter/2;
cabletunnell=plated/2-componentplateoffset+cabletunnelw+wall*2;
cabletunnelthinning=0;

bugscreend=ind-wall-dtolerance;
bugscreenwall=1.2;
bugscreenwallh=0.6;
bugscreenh=(shields+1)*shielddistance-wall*2;
bugscreendensity=3.6;
bugscreenclipangle=10;
bugscreencliph=3;
bugscreenclipshift=-0.7;

// Weaken bugsheet structure in places to make clipping cable holes easier
bugscreenweakenangle=20;
bugscreenweakenh=20;
bugscreenweakcut=bugscreenwallh*2;
bugscreenweaksnapwidth=3;

module line(x1,y1,x2,y2,diameter) {
  hull() {
    translate([x1,y1,0]) circle(d=diameter,$fn=60);
    translate([x2,y2,0]) circle(d=diameter,$fn=60);
  }
}

module towerbody() {
  // body
  difference() {
    union() {
      scale([1,towerscaling,1]) cylinder(d=towerbodyd,h=shielddistance-wall-ztolerance);
      hull() {
	scale([1,towerscaling,1]) cylinder(d=towerbodyd,h=towerbodyd);
	scale([1,towerscaling*1.5,0.3]) cylinder(d=towerbodyd,h=wall/2);
      }
      // text plate
      translate([towerbodyd/2-towerclipdepth/2-xtolerance,-smalltextsize/2-1,0]) roundedbox(textdepth+towerclipdepth/2,smalltextsize+2,len(versiontext)*smalltextsize,cornerd);
    }

    translate([0,0,-0.01]) union() {
      hull() {
	translate([0,0,-wall-ztolerance]) scale([1,towerscaling,1]) cylinder(d=towerclipd+towerdtolerance,h=wall*2+ztolerance);
	translate([0,0,-wall-ztolerance]) scale([1,toweryscaling,1]) cylinder(d=towerind+towerdtolerance,h=wall*3+ztolerance);
      }
      scale([1,toweryscaling,1]) cylinder(d=towerind+towerdtolerance,h=towerclipheight+ztolerance);
      hull() {
	translate([0,0,towerclipheight-towerclipparth]) scale([1,toweryscaling,1]) cylinder(d=towerind+towerdtolerance,h=towerclipparth);
	translate([0,0,towerclipheight-towerclipparth+towerclipth]) scale([1,towerscaling,1]) cylinder(d=towerclipd+towerdtolerance,h=towercliph);
      }
    }

    translate([towerbodyd/2-towerclipdepth/2-xtolerance+towerclipdepth/2+0.01,0,len(versiontext)*smalltextsize/2]) rotate([-90,90,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=smalltextsize,halign="center", valign="center");
  }
}

module towerclip() {
  translate([0,0,-wall-ztolerance]) scale([1,towerscaling,1]) cylinder(d=towerclipd,h=wall*2);
  scale([1,towerscaling,1]) difference() {
    union() {
      translate([0,0,-0.01]) {
	translate([0,0,-wall-ztolerance]) cylinder(d=towerind,h=towerclipheight+wall+ztolerance);
	hull() {
	  translate([0,0,towerclipheight-towerclipparth]) cylinder(d=towerind,h=towerclipparth);
	  translate([0,0,towerclipheight-towerclipparth+towerclipth]) cylinder(d=towerclipd,h=towercliph);
	}
      }
    }

    translate([-towerclipcut/2,-towerclipd/2-cornerd/2,towerclipcutheight]) roundedbox(towerclipcut,towerclipd+cornerd,towerclipheight-towerclipcutheight+cornerd/2,cornerd);
  }
}

module tower() {
  towerclip();
  translate([0,0,-shielddistance]) towerbody();
}

module setoftowers(count) {
  // Only 3 or 6 supported now.
  translate([-towerbodyd/sqrt(2)-2,(count==6)?-towerbodyd*1.5+2:0,0]) {
    ylist=(count==6)?[0,(towerbodyd*2)*1.5-4.5]:[0];
    echo(ylist);
    for (y=ylist) {
      for (i=[0:1:2]) {
	translate([(y==0?-towerbodyd/2-0.5:0)+(towerbodyd+textdepth)*i+0.5,y,shielddistance]) tower();
	for (z=[cornerd/2,len(versiontext)*smalltextsize-0.4-cornerd/2]) {
	  if (i<2) translate([(y==0?-towerbodyd/2-0.5:0)+(towerbodyd+textdepth)*i+0.5+towerbodyd/2,y,z]) cube([wall/2+0.4,0.4,0.4]);
	}
      }
    }
  }
}

module towerbar() {
  difference() {
    hull() {
      translate([-towerbarw/2,-towerbarl/2,0]) cube([towerbarw,towerbarl,towerbarh-towerbard/2]);
      translate([0,-towerbarl/2,towerbarh-towerbard/2]) rotate([-90,0,0]) cylinder(h=towerbarl,d=towerbard);
    }
    translate([0,0,-0.01]) cylinder(h=towerbarh+ztolerance+0.02,d=towerholed+towerdtolerance);
  }
}

module shieldtop() {
  difference() {
    union() {
      rotate_extrude(convexity=10) {
	intersection() {
	  for (i=[0,1,2]) {
	    line(topdtable[i],tophtable[i],topdtable[i+1],tophtable[i+1],wall);
	  }
	  translate([0,0,0]) square([plated*2,shieldh+wall]);
	}
      }

      // Tower attach
      for (a=[0,120,240]) {
	rotate([0,0,a]) {
	  translate([plated/2-(plated/2-incircled/2)/2,0,shieldh-wall-ztolerance-0.1]) scale([1,towerscaling,1]) cylinder(h=wall+0.2,d=towerbodyd);
	  translate([plated/2-(plated/2-incircled/2)/2,0,-shielddistance+shieldh+wall/2+ztolerance/2]) towerbody();
	}
      }
    }

    translate([-plated/2+wall+textsize/2,0,baseh+wall/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
  }
}

module shield() {
  difference() {
    union() {
      rotate_extrude(convexity=10) {
	intersection() {
	  for (i=[0,1,2,3]) {
	    line(dtable[i],htable[i],dtable[i+1],htable[i+1],wall);
	  }
	  translate([0,0,0]) square([plated*2,shieldh+wall]);
	}
      }
    }

    // Tower holes
    for (a=[0,120,240]) {
      rotate([0,0,a]) {
	translate([plated/2-(plated/2-incircled/2)/2,0,shieldh-wall/2-0.1]) scale([1,towerscaling,1]) cylinder(h=wall+0.2,d=towerclipd+towerdtolerance);
      }
    }

    translate([-plated/2+wall+textsize/2,0,baseh+wall/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
  }
}

module bugscreen() {
  astep=360/(3.14159*bugscreend/bugscreendensity);
  wider=bugscreend/2-bugscreenwall+(incircled-ind+wall)/2;
  bottomr=bugscreend/2-bugscreenwall;
  hdiff=shielddistance-shieldoverlap-wall;
  
  difference() {
    union() {
      translate([0,0,bugscreenh-wall*2]) cylinder(d=len(versiontext)*textsize,h=bugscreenwallh+wall);
      
      for (zz=[0:bugscreendensity:bugscreenh-wall]) {
	z=(zz>bugscreenh-wall?bugscreenh-wall:zz);
	dd=(incircled-ind)/shielddistance*(shielddistance-wall-z*2)+bugscreend;
	d=(z<(shielddistance-shieldoverlap-wall)?dd+wall:bugscreend);
	translate([0,0,z]) ring(d,bugscreenwall,bugscreenwallh);
      }

      for (a=[0:astep:359]) {
	rotate([0,0,a]) {
	  translate([bottomr,0,shielddistance-shieldoverlap-wall]) cube([bugscreenwall,bugscreenwall,bugscreenh-(shielddistance-shieldoverlap)]);

	  difference() {
	    hull() {
	      translate([wider,0,0]) cube([bugscreenwall,bugscreenwall,bugscreenwallh]);
	      translate([bottomr,0,hdiff]) cube([bugscreenwall,bugscreenwall,bugscreenwallh]);
	    }
	  }
	}
      }

      for (a=[0:astep:bugscreenweakenangle]) {
	rotate([0,0,a]) {
	  hull() {
	    translate([wider-bugscreenwall/2,((a==0)?-bugscreendensity/2:0)-bugscreenweaksnapwidth/2+bugscreenwall+0.5,0]) cube([bugscreenwall,bugscreenweaksnapwidth+((a==0)?bugscreendensity/2:0),bugscreenwallh]);
	    translate([wider-bugscreenweaksnapwidth/2,-bugscreenweaksnapwidth/2+bugscreenwall*2+0.5/2,0]) cube([bugscreenwall,bugscreenwall,bugscreenwallh]);
	    translate([wider+bugscreenwall-bugscreenwall*1.5,0,bugscreenweaksnapwidth]) cube([bugscreenwall/2,bugscreenwall,bugscreenwallh]);
	  }
	}
      }

      translate([0,0,bugscreenh-wall]) {
	for (dd=[bugscreendensity:bugscreendensity*2:bugscreend+bugscreendensity]) {
	  previousd=dd-bugscreendensity*2;
	  d=(dd>bugscreend?bugscreend:dd);
	  ring(d,bugscreenwall,bugscreenwallh);
	  for (a=[0:360/(3.14159*d/bugscreendensity):359]) {
	    rotate([0,0,a]) {
	      translate([previousd/2-bugscreenwall/2.1,-bugscreenwall/2,0]) cube([d/2-previousd/2+0.1,bugscreenwall,bugscreenwallh]);
	    }
	  }
	}
      }

      translate([0,0,bugscreenh-bugscreenwallh*2-wall]) ring(bugscreend,bugscreenwall*2,bugscreenwallh*3);
    }

    // Weaken part to allow easily make cable holes
    for (a=[0:astep:359]) {
      rotate([0,0,a]) {
	wider=bugscreend/2-bugscreenwall+(incircled-ind+wall)/2;
	bottomr=bugscreend/2-bugscreenwall;
	hdiff=shielddistance-shieldoverlap-wall;
	if (a<bugscreenweakenangle) {
	  ddiff=wider-bottomr;
	  for (z=[0:bugscreendensity:bugscreenweakenh]) {
	    offset=ddiff/hdiff*(z-bugscreenwallh);
	    translate([wider+bugscreenwall-offset-bugscreenwall/2,-0.1,z-bugscreenwallh*2]) triangle(bugscreenweakcut,bugscreenwall+0.2,bugscreenweakcut,3);
	    rotate([0,0,astep-bugscreenwall*2]) {
	      translate([wider+bugscreenwall-offset-bugscreenwall/2-bugscreenwall/3,0,z-bugscreenwallh*2+bugscreenwall-0.1]) triangle(bugscreenweakcut,bugscreenwall+0.2,bugscreenweakcut+0.2,4);
	    }
	    if (a==0) {
	      rotate([0,0,bugscreenwall*2-astep]) {
			      translate([wider+bugscreenwall-offset-bugscreenwall/2-bugscreenwall/3,0,z-bugscreenwallh*2+bugscreenwall-0.1]) triangle(bugscreenweakcut,bugscreenwall+0.2,bugscreenweakcut+0.2,6);
	      }
	    }
	  }
	}
      }
    }

    translate([0,0,bugscreenh-wall+bugscreenwallh-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
  }
}

module base(strong) {
  difference() {
    union() {
      translate([0,0,baseh]) cylinder(d=plated,wall);

      // Clips to hold bugscreen in place
      for (a=[60-bugscreenclipangle/2:120:359]) {
	for (b=[0:360/(3.14159*(bugscreend+bugscreenwall)/(bugscreenwall/2)):bugscreenclipangle]) {
	  d=((incircled-ind)/shielddistance*(shielddistance-wall)+bugscreend)/2+bugscreenwall+dtolerance/2;
	  	    rotate([0,0,a+b]) {
	    translate([d,-bugscreenwall/2,baseh+wall-0.01]) cube([bugscreenwall*2,bugscreenwall,bugscreenwallh+ztolerance*2+0.01]);
	    hull() {
	      translate([d,-bugscreenwall/2,baseh+wall+bugscreenwallh+ztolerance*2-0.01]) cube([bugscreenwall*2,bugscreenwall,0.1]);
	      translate([d+bugscreenclipshift,-bugscreenwall/2,baseh+wall+bugscreenwallh+ztolerance*2+bugscreencliph-0.01]) cube([bugscreenwall,bugscreenwall,0.1]);
	    }
	  }
	}
      }
      
      difference() {
	hull() {
	  translate([0,0,0]) cylinder(d1=plated-baseh*2,d2=plated,h=baseh);
	  translate([plated/4,0,0]) cylinder(d=plated/2,h=baseh);
	  translate([bottomd/2-plated/4,0,0]) cylinder(d=plated/2,h=baseh-shieldoverlap-2-1/2);
	}
	difference() {
	  hull() {
	    translate([0,0,wall]) cylinder(d1=plated-baseh*2-2*wall,d2=plated-2*wall,h=baseh-wall);
	    translate([plated/4,0,wall]) cylinder(d=plated/2-2*wall,h=baseh-wall);
	    translate([bottomd/2-plated/4,0,wall]) cylinder(d=plated/2-2*wall,h=baseh-shieldoverlap-2-1/2-wall);
	  }

	  // Tunnel for cables
	  if (cabletunnel) {
	    for (y=[-cabletunnelyoffset]) {
	      intersection() {
		union() {
		  hull() {
		    translate([cabletunnelxstart,y,cabletunnelzstart]) sphere(d=cabletunnelw);
		    translate([cabletunnelxstart+cabletunnell-cabletunnelw/2,y+cabletunnelyslide,baseh]) sphere(d=cabletunnelw-cabletunnelthinning);
		    translate([cabletunnelxstart+cabletunnell-cabletunnelw/2,y+cabletunnelyslide,baseh-cabletunnelslide]) sphere(d=cabletunnelw-cabletunnelthinning);
		  }
		  hull() {
		    translate([cabletunnelxstart,y,cabletunnelzstart]) sphere(d=cabletunnelw-wall);
		    translate([cabletunnelxstart+cabletunnell-cabletunnelw/2,y+cabletunnelyslide,baseh-cabletunnelslide]) sphere(d=cabletunnelw-wall);
		    translate([componentplateoffset,y+wall,baseh/2]) cube([plated/2-componentplateoffset,wall,0.1]);
		  }
		  translate([componentplateoffset,y+wall,wall-0.01]) cube([plated/2-componentplateoffset,wall,baseh/2]);
		}
	      }
	    }
	  }
	}
      }

      difference() {
	translate([componentplateoffset,-componentw/2,baseh]) roundedbox(wall,componentw+wall,componentplateh,cornerd);
	for (y=[-componentw/2+componentholestart:componentholedistance:componentw/2-componentholed-componentholedistance/2]) {
	  for (z=[baseh+componentholestart:componentholedistance:baseh+componentplateh-componentholed-componentholeedge]) {
	    translate([componentplateoffset-0.1,y,z]) rotate([0,90,0]) cylinder(d=componentholed,h=wall+0.2);
	  }
	}
      }
      translate([componentplateoffset,-componentw/2,0]) roundedbox(wall,componentw,baseh,cornerd);
      
      difference() {
	translate([-componentplateoffset,componentplateoffset,baseh]) roundedbox(componentplateoffset*2+wall,wall,componentplateh,cornerd);
	for (x=[-componentw/2+componentsquareholestart:componentsquareholedistance:componentw/2-componentsquareholed-componentsquareholedistance/2]) {
	  for (z=[baseh+componentsquareholestart:componentsquareholedistance:baseh+componentplateh-componentsquareholed]) {
	    translate([x,componentw/2-0.1,z]) cube([componentsquareholed,wall+0.2,componentsquareholed]);
	  }
	}
      }
      
      hull() {
	translate([-componentplateoffset,componentplateoffset,baseh]) roundedbox(componentplateoffset*2+wall,wall,wall,cornerd);
	translate([0,0,0]) roundedbox(componentplateoffset+wall,wall,wall,cornerd);
      }

      difference() {
	translate([attachmentdistance,-attachmentdistancew/2-barw/2,0]) roundedbox(bardepth,attachmentdistancew+barw,barh,cornerd);
	translate([attachmentdistance+wall,-attachmentdistancew/2-barw/2+wall,wall]) roundedbox(bardepth-wall*2,attachmentdistancew+barw-wall*2,barh-wall*2,cornerd);
      }

      difference() {
	hull() {
	  translate([componentplateoffset,-plated/4+wall,0]) roundedbox(cornerd,barw,1,cornerd);
	  translate([componentplateoffset,-plated/4+barw/2+wall,baseh-shieldoverlap-1-1/2]) sphere(1);
	  translate([attachmentdistance+cornerd/2,-attachmentdistancew/2,0]) roundedbox(cornerd+bardepth-wall,barw,1,cornerd);
	  translate([attachmentdistance+cornerd/2+bardepth-wall,-attachmentdistancew/2+barw/2,baseh-shieldoverlap-1-1/2]) sphere(1);
	}
	hull() {
	  translate([componentplateoffset,-plated/4+wall+wall,wall]) roundedbox(cornerd,barw-2*wall,1,cornerd);
	  translate([componentplateoffset,-plated/4+barw/2+wall,baseh-shieldoverlap-1-1/2-wall*3]) sphere(1);
	  translate([attachmentdistance+cornerd/2,-attachmentdistancew/2+wall*2,wall]) roundedbox(cornerd+bardepth-wall,barw-wall*3,1,cornerd);
	  translate([attachmentdistance+cornerd/2+bardepth-wall,-attachmentdistancew/2+barw/2,baseh-shieldoverlap-1-1/2-wall*3]) sphere(1);
	}
      }

      difference() {
	hull() {
	  translate([componentplateoffset,plated/4-barw-wall,0]) roundedbox(cornerd,barw,1,cornerd);
	  translate([componentplateoffset,plated/4-barw/2-wall,baseh-shieldoverlap-1-1/2]) sphere(1);
	  translate([attachmentdistance+cornerd/2,attachmentdistancew/2-barw,0]) roundedbox(cornerd+bardepth-wall,barw,1,cornerd);
	  translate([attachmentdistance+cornerd/2+bardepth-wall,attachmentdistancew/2-barw/2,baseh-shieldoverlap-1-1/2]) sphere(1);
	}
	hull() {
	  translate([componentplateoffset,plated/4-barw-wall+wall,wall]) roundedbox(cornerd,barw-2*wall,1,cornerd);
	  translate([componentplateoffset,plated/4-barw/2-wall,baseh-shieldoverlap-1-1/2-wall*3]) sphere(1);
	  translate([attachmentdistance+cornerd/2,attachmentdistancew/2-barw+wall,wall]) roundedbox(cornerd+bardepth-wall,barw-wall*3,1,cornerd);
	  translate([attachmentdistance+cornerd/2+bardepth-wall,attachmentdistancew/2-barw/2,baseh-shieldoverlap-1-1/2-wall*3]) sphere(1);
	}
      }

      difference() {
	hull() {
	  translate([bottomd/2-plated/4,-barw/2,0]) roundedbox(attachmentdistance-bottomd/2+plated/4+cornerd+bardepth-wall,barw,cornerd,cornerd);
	  translate([bottomd/2,0,baseh-shieldoverlap-1-1/2-2]) sphere(1);
	  translate([attachmentdistance+bardepth-wall,0,barh/2]) sphere(1);
	}
	hull() {
	  translate([bottomd/2-plated/4+wall*2,-barw/2+wall,wall]) roundedbox(attachmentdistance-bottomd/2+plated/4+bardepth-wall+cornerd,barw-wall*2,cornerd,cornerd);
	  translate([bottomd/2,0,baseh-shieldoverlap-1-1/2-2-wall*2]) sphere(1);
	  translate([attachmentdistance+bardepth-wall+1,0,barh/2-wall*4]) sphere(1);
	}
      }

      difference() {
	hull() {
	  translate([bottomd/2-wall,-barw/2,0]) roundedbox(attachmentdistance-bottomd/2+cornerd+bardepth-wall,barw,cornerd,cornerd);
	  translate([bottomd/2+wall,0,baseh-shieldoverlap-1-1/2-2]) sphere(1);
	  translate([attachmentdistance+1+bardepth-wall,0,barh-wall]) sphere(1);
	}
	hull() {
	  translate([bottomd/2-wall+wall*2,-barw/2+wall,wall]) roundedbox(attachmentdistance-bottomd/2+cornerd+bardepth-wall*2,barw-wall*2,cornerd,cornerd);
	  translate([bottomd/2+wall,0,baseh-shieldoverlap-1-1/2-2-wall*3]) sphere(1);
	  translate([attachmentdistance+1+bardepth-wall,0,barh-wall*6]) sphere(1);
	}
      }

      for (z=[screwtowerd/2+cornerd,barh-screwtowerd/2-cornerd]) {
	for (y=[-attachmentdistancew/2-barw/2+screwtowerd/2+cornerd,attachmentdistancew/2+barw/2-screwtowerd/2-cornerd]) {
	  translate([attachmentdistance+bardepth,y,z]) rotate([0,-90,0]) cylinder(h=bardepth,d=screwtowerd);
	}
      }

      // Most slicers seem to get confused on what is inside and what
      // is outside, and thus will not generate infill.  This is a
      // workaround, generate internal support structures manually. It
      // did manage print the base by bridging over wide gaps, but
      // this will add more support to make it more likely to be
      // successful.
      
      if (forceinfill) {
	for (d=[20:20:plated-20]) {
	  difference() {
	    translate([0,0,0]) cylinder(d1=plated-baseh*2,d2=d,h=baseh);
	    translate([0,0,0]) cylinder(d1=plated-baseh*2-0.8,d2=d-0.8,h=baseh);
	  }
	}

	for (a=[0:30:359]) {
	  rotate([0,0,a]) {
	    hull() {
	      translate([0,-0.2,0]) cube([(plated-baseh*2-wall)/2,0.4,0.1]);
	      translate([0,-0.2,baseh]) cube([(plated-wall)/2,0.4,0.1]);
	    }
	  }
	}
      }
      
      for (a=[0,120,240]) {
	rotate([0,0,a]) {
	  translate([plated/2-(plated/2-incircled/2)/2,0,baseh-shieldoverlap-shielddistance+shieldh+wall/2+ztolerance/2+wall/2]) {
	    towerclip();
	  }

	  // Support towers. Not needed if forceinfill is used or slicer does what it is doing..
	  if (!forceinfill) difference() {
	    hull() {
	      translate([plated/2-(plated/2-incircled/2)/2,0,baseh]) cylinder(d=towerbodyd,h=0.1);
	      translate([a==0?plated/2-(plated/2-incircled/2)/2:(plated-baseh*2-towerbodyd)/2,0,0]) cylinder(d=towerbodyd,h=0.1);
	    }
	    hull() {
	      translate([plated/2-(plated/2-incircled/2)/2,0,baseh+0.01]) cylinder(d=towerbodyd-wall*2,h=0.1);
	      translate([a==0?plated/2-(plated/2-incircled/2)/2:(plated-baseh*2-towerbodyd)/2,0,0]) cylinder(d=towerbodyd-wall*2,h=0.1);
	    }
	  }
	}
      }
    }

    // Tunnel for cables
    if (cabletunnel) {
      for (y=[-cabletunnelyoffset]) {
	intersection() {
	  hull() {
	    translate([cabletunnelxstart,y,cabletunnelzstart]) sphere(d=cablemaxdiameter);
	    translate([cabletunnelxstart+cabletunnell-cabletunnelw/2,y+cabletunnelyslide,baseh]) sphere(d=cablemaxdiameter-cabletunnelthinning);
	    translate([cabletunnelxstart+cabletunnell-cabletunnelw/2,y+cabletunnelyslide,baseh-cabletunnelslide]) sphere(d=cablemaxdiameter-cabletunnelthinning);
	  }
	}
      }
    }
    
    for (z=[screwtowerd/2+cornerd,barh-screwtowerd/2-cornerd]) {
      for (y=[-attachmentdistancew/2-barw/2+screwtowerd/2+cornerd,attachmentdistancew/2+barw/2-screwtowerd/2-cornerd]) {
	translate([attachmentdistance+screwlength-0.01,y,z]) rotate([0,-90,0]) ruuvireika(screwlength,screwd,1,strong);
	translate([attachmentdistance,y,z]) rotate([0,-90,0]) cylinder(h=attachmentdistance-plated/2,d=screwtowerd);
      }
    }
    
    translate([-plated/2+wall+textsize/2,0,baseh+wall-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
    translate([attachmentdistance+textdepth-0.01,0,barh-textsize+wall]) rotate([90,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
    translate([-plated/2+baseh+2,0,-0.01]) mirror([1,0,0]) rotate([0,0,180]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="left",font="Liberation Sans:style=Bold");
  }
}

module pipeattach(pipediameter, strong) {
  ringoutd=pipediameter+pipeattachthickness*2;
  
  difference() {
    union() {
      hull() {
	translate([attachmentdistance+bardepth+xtolerance,-attachmentdistancew/2-barw/2,0])  roundedbox(cornerd,attachmentdistancew+barw,pipeattachh,cornerd);
	translate([attachmentdistance+bardepth+xtolerance+pipeattachthickness+pipediameter/2,0,0]) ring(ringoutd,pipeattachthickness,pipeattachh);
      }

      // Towers for screws to close around pipe with pipediameter diameter
      for (z=[screwtowerd/2+cornerd]) {
	for (y=[-pipediameter/2-screwtowerd/2,pipediameter/2+screwtowerd/2]) {
	  translate([attachmentdistance+bardepth+xtolerance+ringoutd/2+pipeattachscrewdepth-pipeattachscrewlength+0.01,y,z]) rotate([0,90,0]) ruuvitorni(pipeattachscrewlength,screwtowerd);
	}
      }
    }

    translate([attachmentdistance+bardepth+xtolerance+pipeattachthickness/2,0,pipeattachh-textdepth+0.01]) rotate([0,0,90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
    translate([attachmentdistance+bardepth+xtolerance+pipeattachthickness+pipediameter+pipeattachthickness/2,0,pipeattachh-textdepth+0.01]) rotate([0,0,90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
    
    translate([attachmentdistance+bardepth+xtolerance+pipeattachthickness+pipediameter/2,0,-0.1]) cylinder(d=pipediameter,h=pipeattachh+0.2);

    translate([attachmentdistance+bardepth+xtolerance+pipeattachthickness+pipediameter/2-pipeattachcut/2,-ringoutd/2-0.1,-0.1]) cube([pipeattachcut,ringoutd+0.2,pipeattachh+0.2]);

    // Screws to attach to the base
    for (z=[screwtowerd/2+cornerd]) {
      for (y=[-attachmentdistancew/2-barw/2+screwtowerd/2+cornerd,attachmentdistancew/2+barw/2-screwtowerd/2-cornerd]) {
	translate([attachmentdistance+screwlength-0.01,y,z]) rotate([0,-90,0]) ruuvireika(screwlength,screwd,1,strong);
	translate([attachmentdistance,y,z]) rotate([0,-90,0]) cylinder(h=attachmentdistance-plated/2,d=screwtowerd);
      }
    }

    // Screws to close around the pipe
    for (z=[screwtowerd/2+cornerd]) {
      for (y=[-pipediameter/2-screwtowerd/2,pipediameter/2+screwtowerd/2]) {
	translate([attachmentdistance+bardepth+xtolerance+ringoutd/2+pipeattachscrewdepth-pipeattachscrewlength+0.01,y,z]) rotate([0,90,0]) ruuvireika(pipeattachscrewlength,screwd,1,strong);
	translate([attachmentdistance+bardepth+xtolerance+ringoutd/2+pipeattachscrewdepth,y,z]) rotate([0,90,0]) cylinder(h=ringoutd/2,d=screwtowerd);
      }
    }
  }
}

module stevensonscreen() {
  base(0);
  
  if (bugprotection) translate([0,0,baseh+wall+ztolerance]) rotate([0,0,-bugscreenweakenangle-towerbodyd*2]) bugscreen();
  
  for (z=[baseh-shieldoverlap+wall/2:shielddistance:shields*shielddistance+baseh-shieldoverlap]) {
    translate([0,0,z]) shield();
  }
  
  translate([0,0,shields*shielddistance+baseh-shieldoverlap+wall/2]) shieldtop();
  
  for (z=[baseh-shieldoverlap+shielddistance+wall/2:shielddistance:shields*shielddistance+shieldh]) {
    for (a=[0,120,240]) {
      rotate([0,0,a]) {
	translate([plated/2-(plated/2-incircled/2)/2,0,z-shielddistance+shieldh+wall/2+ztolerance/2]) towerclip();
      }
    }
  }

  for (z=[baseh-shieldoverlap+wall/2:shielddistance:shields*shielddistance+wall/2]) {
    for (a=[0,120,240]) {
      rotate([0,0,a]) {
	translate([plated/2-(plated/2-incircled/2)/2,0,z-shielddistance+shieldh+wall/2+ztolerance/2]) towerbody();
      }
    }
  }

  pipeattach(62,0);
  translate([0,0,barh-pipeattachh]) pipeattach(62,0);
}

if (print==0) {
  intersection() {
    stevensonscreen();
    translate([-plated*2,-30,0]) cube([plated*6-56,plated*2,(shields+2)*shieldh+shieldh+baseh]);
  }
 }

if (print==1) {
  base(1);
 }

if (print==2 || print==6) {
  translate([topbottomd/sqrt(2)-0.5,topbottomd/sqrt(2)-0.5,shieldh+wall/2]) rotate([180,0,0]) shieldtop();
 }

if (print==6) {
  setoftowers(3);
 }

if (print==3 || print==6 || print==7) {
  translate([0,0,shieldh+wall/2]) rotate([180,0,0]) shield();
 }

if (print==7) {
  translate([bottomd/sqrt(2)+sqrt(2.5),bottomd/sqrt(2)+sqrt(2.5),shieldh+wall/2]) rotate([180,0,0]) shield();
  setoftowers(6);
 }

if (print==4) {
  setoftowers(6);
 }

if (print==5) {
  translate([-barw,plated/2-bugscreend/2+barw/2+5,bugscreenh+bugscreenwallh]) rotate([180,0,0]) bugscreen();

  translate([-plated/1.5-7,plated-attachmentdistancew/2+65/2-10,0]) base(1);
 }

if (print==8) {
  translate([0,0,shielddistance]) tower();
 }

if (print==9) {
  render() pipeattach(62,1);
  translate([attachmentdistance*2+bardepth*2-1,0,pipeattachh]) rotate([0,180,0]) pipeattach(62,1);
 }

if (print==10) {
  translate([0,0,bugscreenh+bugscreenwallh]) rotate([180,0,0]) bugscreen();
 }
