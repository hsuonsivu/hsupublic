// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO:
// weathercover screw attachment, underneath?
// reed switch/sensor, ESP32

include <hsu.scad>

print=13;
debug=0;
strong=0; // Add strengtening structures around screwholes. Slicer dependent.

adhesion=print?1:0;
adhesiongap=0.15/2;
adhesionwd=6;
adhesionh=0.2;

grid=1;
includepoleattach=0;
includeflatattach=1;
includewallattach=0;
includetweezers=1;
includemagnettool=1;
includehallsensortester=1;
weathercover=0;

$fn=(print>0)?120:60;

textdepth=0.8;
textsize=6;
copyrighttext="© Heikki Suonsivu CC-BY-NC-SA";
copyrighttextsize=textsize-3;
  
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
axledtolerance=0.7;
dtolerance=0.5;
wall=2;

cupwall=1.6;
cupwidth=20+cupwall*2;
cuph=20;
cupextrah=1; // Raise central structure a bit to make sure water exits from the outside in case of inbalance
cuplength=45;
cupaxled=7;
cupbaseh=5;
cupbasesupporth=cupbaseh;
cupbelowh=15;
cupsideraiseh=cuph/3+cupwall/2;;
cupsideraisel=cuplength*0.95;

baseaxlesupportwall=cupwall;

cupaxleheight=25+cupwall;
cupaxlew=baseaxlesupportwall+2;
cupaxlewidth=cupwidth;

cupangle=-atan(cuph/cuplength);
cornerd=0.5;
largecornerd=1;
smallcornerd=0.01;

basel=cuplength*cos(-cupangle)-cupbaseh*sin(-cupangle);
basew=cupaxlewidth+cupwall*3+ytolerance*2;
centerraise=3;

angle=(print>0) ? cupangle:0; //cupangle; //cupangle;
lowercupangle=cupangle+10;

towerw=cupaxled+1;

raincupd=90;
rainpiped=4; // Inside diameter
raincupbottomh=2*wall;
raincupmidd=rainpiped+raincupbottomh+wall*2;
raincupmidh=(raincupd-raincupmidd)/2.35; //30;
raincuptoph=5;
funneltoph=raincupbottomh+raincupmidh+raincuptoph;

stopperw=wall*3;
stopperh=wall;
stopperl=wall*3;
stopperheight = cupaxleheight+cupsideraisel*sin(-cupangle)+cupbaseh+cupsideraiseh-cupwall+ztolerance*2.5; //basetoph+wall;

//magnetd=6.36;
//magneth=3.2;
magnettoolxtolerance=0.2;
magnettoolytolerance=0.2;
magnettoolztolerance=0.15;
magnettooldtolerance=0.1;
magnetwall=1.5;
magnettoolwall=1.2;
magnetd=4.4;
magneth=1.6;
magnetholedepth=2*magnetd;
magnetdroph=1;
magnetlockd=1.4;
magnetlockh=magnetd*1.3;
magnettoolcaplockd=1.8;
magnettoolcapdtolerance=0.2;
magnettoolcaplockoffset=magnettoolwall-magnettoolcaplockd/2+magnettoolcapdtolerance;
magnettoolcaplockh=magnettoolcaplockd+magnettoolwall+magnettoolztolerance; // From top of feeder
magnettoolcaplockattachx=30;
magnettoolcaplockattachw=2.5;
magnetytolerance=0.2;
magnetdtolerance=dtolerance;
magnetspringcut=0.25;
magnetspringcutw=magnetlockd;
magnetspringcutl=magnetlockh;
magnetspringlow=cupbaseh+cuph+cupwall-magnetd/2; //-cupaxlewidth/2-cupwall/2+magnetwall-magnetdroph; // Center of the magnet
magnetspringhigh=magnetspringlow+magnetspringcutl;

magnettoolpusherposition=0; // 8, magnettoolfeedx to test
magnettoolfeedx=30; // Length to magnet feeding hole
magnettoolcontroll=20; // Length of finger place when pushed in
magnettoolcontrolw=10;
magnettoolhand=1; // 1 = right-handed, 0 = neutral, -1 left-handed
magnettoolhandshift=3;
magnettoolhandlel=80;
magnettoolhandled=25;
magnettoolhandleh=6;
magnettoolhandlecornerd=4;
magnettoolcontroloffset=magnettoolwall*3;
magnettoolplacerl=magnettoolfeedx+magnettoolcontroll+magnetd+magnettoolcontroloffset;//100; // Length to handle when pushed in
magnettoolcontrolslit=2.5;
magnettoolcontrolh=magnettoolcontrolslit/2;
magnettoolgrabberarmw=1.2;
magnettooltopdtolerance=0.35;
magnettooloutpositionw=magnetd*0.4; // How much grabber expands when not grabbing the magnet
magnettoolplacerh=magnettoolwall+magnettoolztolerance*2+magneth+magnettoolwall;
magnettoolpathnarrow=magnettoolytolerance+magnettoolgrabberarmw+magnetd+magnettoolgrabberarmw+magnettoolytolerance;
magnettoolpathwide=magnettoolpathnarrow+magnettooloutpositionw;
magnettoolplacerw=magnettoolpathwide+magnettoolwall*2;
magnettoolpathheight=magnettoolwall;
magnettoolpathh=magnettoolytolerance+magneth+magnettoolytolerance;
magnettoolmouthl=magnetd/2;
magnettoolgrabberl=magnetd+2;
magnettoolgrabberextensionl=magnetd;
magnettoolfeedholex=magnettoolfeedx-magnettoolgrabberl+magnettoolgrabberextensionl;
magnettoolcontrolstart=magnettoolplacerl-magnettoolcontroll;
magnettoolmovementl=magnettoolfeedx; // Amount of movement when grabbing a magnet and pushing it out
magnettooll=magnettoolfeedx+magnettoolmovementl+magnettoolcontroll+magnetd+magnettoolxtolerance+magnettoolwall+magnettoolcontroloffset;
magnettoolmagnetheight=magnettoolwall+magnettoolztolerance;
magnettoolpushercenterw=2.4;
magnettoolpushersidew=1.4;
magnettoolpushercutw=magnettoolztolerance;
magnettoolpusherw=magnettoolpushercenterw+magnettoolpushersidew*2+magnettoolpushercutw*2;
magnettoolpusherspringl=20;
magnettoolpusherl=magnettoolfeedx+magnettoolcontroll+magnetd+magnettoolwall;
magnettoolyopen=(magnettoolpusherposition==0||magnettoolpusherposition==magnettoolfeedx)?magnettooloutpositionw/2:0;
magnettoolclawd=magnetd+magnettoolwall*2+magnettooldtolerance;
magnettoolfeedh=10;
magnettoolfingerd=20;
magnettoolfingerheight=magnettoolplacerh+magnettoolcontrolw+magnettoolcontrolh+magnettoolfingerd/2+1;

funnelbasew=cupaxlewidth+(cupaxlew/2+wall+ytolerance)*2;
funnelh=cupbaseh+cupwall+cuph+max(stopperh,magnetd)+magnetd/2;
baselargerthancup=(basel*2>=90);
funneltopd=baselargerthancup?basel*2:raincupd;
funneloffset=0; //baselargerthancup?0:-funneltopd/2+basel;
  
funnelheight=cupaxleheight+funnelh;
basetoph=cupaxleheight+funnelh;

toph=funnelheight+funneltoph;

gridstep=8.7;
gridthickness=3;
gridh=7;

weathercoveroutd=-funneloffset*2+cuplength*2+cupwidth/2+wall*2; // cupwidth part could be calculated more accurately.
weathercoverringh=2;
weathercoverinsideh=raincuptoph-gridh-ztolerance;
weathercoverdroph=raincuptoph-gridh;
weathercoverstartnarrowing=toph-(weathercoveroutd-funneltopd);
weathercovertoph=toph-weathercoverstartnarrowing;

weathercovercliplength=30;
weathercoverclipd=1.7*2;
weathercoverclipheight=wall+weathercoverclipd/2+5;
weathercoverclipdistance=funneltopd/2-weathercoverclipd/2; //wall+0.6;
weathercoverclipdtolerance=0.3;
basesidew=basew;
baseguideh=20;
baseguidel=basel;
basesideoffset=5;

grillheight=toph-raincuptoph+ztolerance;

// Not printed, just used when debugging the model and cut out stuff
// 62mm standard pole
poled=62;
poleh=250;
poleheight=-150;
poledistance=funneltopd/2+20+poled/2; // From rain cover

screwd=3.5;
screwlength=35;
screwtowerd=3*screwd;
screwbasel=9;
screwbaselflat=6;
attachflatfeeth=1;

wallattachh=90;
wallattachheight=-wallattachh-20;
wallscrewoffset=screwtowerd/2+screwtowerd;
wallattachw=70;
wallattachd=20;
wallattachnarroww=wallattachw-screwtowerd/2-20;
walldistance=funneltopd/2+20; // From rain cover
wallattachthickness=8;
wallattachmidh=wallattachh-wallattachnarroww/4;
wallattachlowh=50;
wallattachlowfromwall=20;
wallattachlowd=5;

poleattachh=90;
poleattachheight=-poleattachh-20;
screwdistanceh=poleattachh-screwtowerd/2-screwtowerd;
attachthickeningh=screwtowerd;
attachthickeningd=poled+screwtowerd*2;
attachthickeningdh=screwtowerd*1.5;
attachd=poled+wall*2;
poleattachcut=2.5;
poleattachtopnarrowh=5; // Small angle to get water off
poleattachbased=20;
poleattachbaseh=poleattachh-10;
poleattachmetersupportmidh=poleattachheight+poleattachh/2;
attachplatew=60;
attachplatel=75;
attachplateh=10;
attachholeh=8+ztolerance;
attachmalel=attachplatel-6;
attachmaleh=8;
attachmaletopw=attachplatew-10;
attachmalebottomw=attachmaletopw-attachmaleh*2;

attachheight=-attachplateh-ztolerance-cornerd/2;

attachclipposition=basel-attachplatel+10;
attachclipl=attachplatew/2;
attachclipd=1.5*2;
attachclipflexspace=8;
attachclipdtolerance=0.3;
attachclipheight=-attachplateh+attachmaleh+attachclipd/4+attachclipdtolerance/2;

hallsensorh=4.4+ztolerance;
hallsensorw=4.4+xtolerance;
hallsensorfrontw=2.62;
hallsensorthickness=1.6+ytolerance;
hallsensorpinx=0.43+xtolerance;
hallsensorpiny=0.41+ytolerance;
hallsensorpind=max(hallsensorpinx,hallsensorpiny,1.2);
hallsensorpinstep=1.27;
hallsensorheight=basetoph-6;
hallsensorfeetl=15;
hallsensorpinfromback=hallsensorthickness/2-hallsensorpiny/2;

diodepind=0.6;
diodepinstep=2.5;
diodelegl=35;

buttoncellh=3.2;
buttoncelld=20;

versiontext=str("V1.7 d", funneltopd);
areatext=str("a=",floor(3.14159*(funneltopd/2)*(funneltopd/2)),"mm2");
textheight=basetoph-10;
areatextheight=textheight-textsize;

extensionflangew=adhesion?basesidew/2+wall:2*wall;

// Hallsensor sensor x=centered, sensorback y=0, z=0
module hallsensor() {
  difference() {
    union() {
      // Body
      hull() {
	translate([-hallsensorw/2,hallsensorthickness/2,-hallsensorh/2]) roundedbox(hallsensorw,hallsensorthickness/2,hallsensorh,cornerd);
	translate([-hallsensorfrontw/2,0,-hallsensorh/2]) roundedbox(hallsensorfrontw,hallsensorthickness/2,hallsensorh,cornerd);
      }
      // Feet
      for (i=[-1:1:1]) {
	translate([i*hallsensorpinstep-hallsensorpinx/2,hallsensorpinfromback,-hallsensorfeetl-hallsensorh/2]) cube([hallsensorpinx,hallsensorpiny,hallsensorfeetl+0.01]);
      }
    }

    for (i=[-1:1:1]) {
#      translate([i*hallsensorpinstep,hallsensorpinfromback+0.3-0.01,-hallsensorh/2-3]) rotate([-90,180,180]) linear_extrude(0.31) text(str(i+2),size=0.5,valign="center",halign="center");
    }
  }
}

hallsensortesterxsize=wall+diodepinstep+hallsensorpinx+buttoncellh+hallsensorpinx+xtolerance+wall;
hallsensortesterysize=wall+ytolerance+buttoncelld+ytolerance+wall;
hallsensortesteryshortening=buttoncelld/3;
hallsensortesterh=wall+ztolerance+buttoncelld+ztolerance+wall;
hallsensortesterbasey=funneltopd/2-basesidew-basesideoffset+cupwall+cupwall/2;//funnelbasew/2-basesidew/2;
hallsensortesterbaseh=cupaxleheight-wall;

hallsensortesterxposition=-wall-diodepinstep-hallsensorpinx/2-xtolerance/2+buttoncellh/2-hallsensorpinstep;
// -wall-hallsensorpinx/2-xtolerance-buttoncellh/2+hallsensorpinstep-hallsensorpinx/2

module hallsensortester() {
  translate([hallsensortesterxposition,0-funnelbasew/2+cupwall/2-2-hallsensortesterbasey,cupwall])  roundedbox(hallsensortesterxsize,hallsensortesterbasey,hallsensortesterbaseh,cornerd);
  translate([0,0-funnelbasew/2+cupwall/2-2,hallsensorheight]) {
    testerheight=-hallsensorh-wall-buttoncelld-wall;
    translate([hallsensortesterxposition,-hallsensortesterysize,testerheight]) {
      difference() {
	union() {
	  translate([0,hallsensortesteryshortening,0]) roundedbox(hallsensortesterxsize,hallsensortesterysize-hallsensortesteryshortening,hallsensortesterh,cornerd);
#	translate([wall+diodepinstep+diodepind+xtolerance/2,wall+ytolerance+buttoncelld/2,wall+ztolerance+buttoncelld/2]) rotate([0,90,0]) cylinder(d=buttoncelld,h=buttoncellh);
	}

	hull() {
	  translate([wall+diodepinstep+hallsensorpinx/2+xtolerance/2,wall+ytolerance+buttoncelld/2,wall+ztolerance+buttoncelld/2]) rotate([0,90,0]) cylinder(d=buttoncelld+dtolerance,h=buttoncellh+xtolerance);
	  translate([wall+diodepinstep+hallsensorpinx/2+xtolerance/2,wall+ytolerance+buttoncelld/2-buttoncelld,wall+ztolerance+buttoncelld/2]) rotate([0,90,0]) cylinder(d=buttoncelld+dtolerance,h=buttoncellh+xtolerance);
	}

	// Diode positive leg
	translate([wall+diodepind/2,wall+dtolerance+buttoncelld*0.7,hallsensortesterh-diodelegl]) cylinder(d=diodepind+dtolerance,h=diodelegl+0.1);

	// Diode negative leg
	translate([wall+diodepinstep+diodepind/2+xtolerance/2,wall+dtolerance+buttoncelld*0.7,hallsensortesterh-diodelegl]) cylinder(d=diodepind+dtolerance,h=diodelegl+0.1); //buttoncelld/2+dtolerance+wall+ztolerance

	// hall sensor Q, meeting diode
	hull() {
	  translate([-hallsensortesterxposition-hallsensorpinstep,hallsensortesterysize,hallsensortesterh-5]) sphere(d=hallsensorpind);
	  translate([wall+diodepind/2+xtolerance/2,wall+dtolerance+buttoncelld/2,hallsensortesterh-5]) sphere(d=hallsensorpind);
	}
	//      translate([-hallsensortesterxposition-hallsensorpinstep,hallsensortesterysize-hallsensorpinfromback-hallsensorpiny/2,hallsensortesterh-5]) cylinder(d=hallsensorpind,h=105);
	hull() {
	  translate([wall+diodepind/2+xtolerance/2,wall+dtolerance+buttoncelld/2,hallsensortesterh-5]) sphere(d=hallsensorpind);
	  translate([wall+diodepind/2,0,hallsensortesterh-5]) sphere(d=hallsensorpind);
	}

	// GND pin for hall sensor
	translate([-hallsensortesterxposition,hallsensortesterysize+0.1,hallsensortesterh-5]) rotate([90,0,2]) cylinder(d=hallsensorpind,h=hallsensortesterysize);
	//      translate([-hallsensortesterxposition,hallsensortesterysize-hallsensorpinfromback-hallsensorpiny/2,hallsensortesterh+hallsensorpiny/2-5]) cylinder(d=hallsensorpind,h=105);

	// Positive pin for hall sensor
	hull() {
	  translate([-hallsensortesterxposition+hallsensorpinstep,hallsensortesterysize+0.01,hallsensortesterh-5]) rotate([90,0,90]) sphere(d=hallsensorpind);
	  translate([-hallsensortesterxposition+hallsensorpinstep,hallsensortesterysize-wall-0.01,hallsensortesterh-5]) rotate([90,0,90]) sphere(d=hallsensorpind);
	  translate([wall+diodepinstep+diodepind+xtolerance/2+buttoncellh+xtolerance/2*3,hallsensortesterysize+0.1,hallsensortesterh-5]) rotate([90,0,-3]) cylinder(d=hallsensorpind,h=wall*2);
	}
	translate([wall+diodepinstep+diodepind+xtolerance/2+buttoncellh+xtolerance*3/2,hallsensortesterysize+0.1,hallsensortesterh-5]) rotate([90,0,-3]) cylinder(d=hallsensorpind,h=hallsensortesterysize+wall);

	// Open back to help with setting up pins
	hull() {
	  translate([-hallsensortesterxposition-hallsensorpinstep-hallsensorpind/2,hallsensortesterysize-hallsensorpinfromback-hallsensorpiny*2,hallsensortesterh-hallsensorpind/2-5]) roundedbox(hallsensorpinstep*3,hallsensorpinfromback+hallsensorpiny*4,7,hallsensorpind);
#	  translate([-hallsensortesterxposition-hallsensorpinstep-hallsensorpind/2+hallsensorpinstep*3/2,hallsensortesterysize-hallsensorpinfromback-hallsensorpiny*2-(hallsensorpinfromback+hallsensorpiny*4)/2,hallsensortesterh-hallsensorpind/2-5]) roundedbox(0.1,0.1,7,hallsensorpind);
	}

#translate([-hallsensortesterxposition,hallsensortesterysize,-testerheight]) rotate([0,0,180]) hallsensor();
      }
    }
  }
}

module magnetlock() {
  translate([0,0,cupaxleheight]) rotate([0,angle,0]) {
    //translate([0,-cupaxlewidth/2-cupwall/2+magnetwall-magnetdroph,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd,h=magneth);
    difference() {
      union() {
	hull() {
	  translate([0,-cupaxlewidth/2-cupwall/2+magnetwall+magnetytolerance,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd,h=magneth);          
	  translate([0,-cupaxlewidth/2-cupwall/2+magnetwall+magnetytolerance,cupbaseh+cuph+cupwall-magnetd/2+magnetlockh]) rotate([-90,0,0]) cylinder(d=magnetd,h=magneth);
	}

	translate([0,-cupaxlewidth/2-cupwall/2+magnetwall+magneth-magnetlockd/2+magnetytolerance,cupbaseh+cuph+cupwall+magnetd-magnetd/2]) sphere(d=magnetlockd);
      }
      translate([0,-cupaxlewidth/2-cupwall/2+magnetwall-magnetdroph+magnetytolerance,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth);

      // Cuts to allow springy action for magnetlock
      translate([-magnetspringcutw/2-magnetspringcut,-cupaxlewidth/2-cupwall/2+magnetwall,magnetspringlow]) cube([magnetspringcut,magneth+magnetytolerance+0.1,magnetspringcutl]);
      translate([-magnetspringcutw/2-magnetspringcut,-cupaxlewidth/2-cupwall/2+magnetwall,magnetspringlow+magnetspringcutl-magnetspringcut]) cube([magnetspringcutw+magnetspringcut*2,magneth+magnetytolerance+0.1,magnetspringcut]);
      translate([magnetspringcutw/2,-cupaxlewidth/2-cupwall/2+magnetwall,magnetspringlow]) cube([magnetspringcut,magneth+magnetytolerance+0.1,magnetspringcutl]);
    }
  }
}

module grill() {
  d=funneltopd-cupwall*3+dtolerance;

  difference() {
    union() {
      // Top grill
      if (grid) 
	translate([funneloffset,0,grillheight]) ring(d,wall/2,raincuptoph+wall*2+cupwall/2+ztolerance,1);

      labell=max(len(versiontext)*textsize,len(areatext)*textsize);
  
      hull() {
	translate([funneloffset-d/2+0.1,-gridthickness/2,grillheight]) cube([d-0.2,gridthickness,gridh]);
	translate([funneloffset-labell/2,-gridthickness/2,grillheight]) cube([labell,gridthickness,gridh+textsize+2]);
	translate([funneloffset-d/2+0.1,-0.05,grillheight]) cube([d-0.2,0.1,gridh+gridthickness/2]);
	translate([funneloffset-labell/2,-0.05,grillheight]) cube([labell,0.1,gridh+textsize+2+gridthickness/2]);
      }
    
      intersection() {
	translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh-cupwall]) cylinder(h=raincuptoph+wall*4,d=d);
	union() {
	  for (x=[0:gridstep:basel-1]) {
	    translate([x-gridthickness/2,-funneltopd/2,grillheight]) triangle(gridthickness,funneltopd-1,gridh,12);
	  }
	  for (x=[-gridstep:-gridstep:-basel-1]) {
	    translate([x-gridthickness/2,-funneltopd/2,grillheight]) triangle(gridthickness,funneltopd-1,gridh,12);
	  }
	  for (y=[gridstep:gridstep:funneltopd/2-1]) {
	    translate([-funneltopd/2,y-gridthickness/2,grillheight]) triangle(funneltopd,gridthickness,gridh,22);
	  }
	  for (y=[-gridstep:-gridstep:-funneltopd/2-1]) {
	    translate([-funneltopd/2,y-gridthickness/2,grillheight]) triangle(funneltopd,gridthickness,gridh,22);
	  }
	}
      }
    }
    translate([-funneloffset,-gridthickness/2+textdepth-0.01,grillheight+gridh+textsize/2+1]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([-funneloffset,gridthickness/2-textdepth+0.01,grillheight+gridh+textsize/2+1]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(areatext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module funneloutside() {
  union() {
    // Low part of pipe
    translate([0,0,funnelheight]) cylinder(h=raincupbottomh,d1=rainpiped+wall/2,d2=raincupmidd);

    // Mid part of funnel
    hull() {
      translate([0,0,funnelheight+raincupbottomh]) cylinder(h=0.1,d=raincupmidd);
      translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=0.1,d=funneltopd);
    }

    // Top part of funnel
    hull() {
      translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph,d=funneltopd);
    }

    translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph,d=funneltopd);
  }
}

module funnel() {
  difference() {
    funneloutside();
    
    // Cutout for funnel insides
    translate([0,0,funnelheight-0.01]) cylinder(h=raincupbottomh+0.02,d1=rainpiped,d2=rainpiped+raincupbottomh);
    hull() {
      translate([0,0,funnelheight+raincupbottomh-0.01]) cylinder(h=0.1,d=rainpiped+raincupbottomh);
      translate([funneloffset,0,funnelheight+raincupbottomh+raincupmidh]) cylinder(h=raincuptoph+0.1,d=funneltopd-wall*2);
    }

  }
}

module weathercover() {
  funnel();
  translate([0,-weathercoverclipdistance,weathercoverclipheight]) tubeclip(weathercovercliplength,weathercoverclipd,0);
  translate([0,weathercoverclipdistance,weathercoverclipheight]) tubeclip(weathercovercliplength,weathercoverclipd,0);
  
  difference() {
    union() {
      hull() {
	intersection() {
	  translate([funneloffset,0,0]) cylinder(d=weathercoveroutd,h=weathercoverstartnarrowing);
	  translate([funneloffset-weathercoveroutd/2,-funneltopd/2,0]) cube([weathercoveroutd,funneltopd,weathercoverstartnarrowing]);
	}
	translate([funneloffset,0,weathercoverstartnarrowing+weathercovertoph-raincuptoph-0.01]) cylinder(d=funneltopd,h=0.01);
      }
    }

    hull() {
      translate([-basel/2+funneloffset-xtolerance,-funneltopd/2-ytolerance,-cornerd]) roundedbox(basel+xtolerance*2,funneltopd+ytolerance*2,cupwall+ztolerance+cornerd,cornerd);
      translate([-basel/2+funneloffset-wall-xtolerance,-funneltopd/2+wall,-cornerd]) roundedbox(basel+wall*2+xtolerance*2,funneltopd-wall*2,cupwall+ztolerance+cornerd,cornerd);
    }
    
    hull() {
      intersection() {
	translate([funneloffset,0,-0.01]) cylinder(d=weathercoveroutd-wall*2,h=toph-(weathercoveroutd-funneltopd)+0.02);
	translate([funneloffset-weathercoveroutd/2+wall,-funneltopd/2+wall,-0.01]) cube([weathercoveroutd-wall*2,funneltopd-wall*2,weathercoverstartnarrowing+0.02]);
      }
      translate([funneloffset,0,weathercoverstartnarrowing+weathercovertoph-raincuptoph-0.01]) cylinder(d=funneltopd-wall*2,h=0.02);
    }


    translate([0,-funneltopd/2+textdepth-0.01,textheight]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([0,funneltopd/2-textdepth+0.01,textheight]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

    translate([0,-funneltopd/2+textdepth-0.01,areatextheight]) rotate([90,0,0]) linear_extrude(height=textdepth) text(areatext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([0,funneltopd/2-textdepth+0.01,areatextheight]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(areatext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
}
}

module sideguide(w) {
  difference() {
    intersection() {
      hull() {
	translate([-weathercoveroutd/2+funneloffset+w,-weathercoveroutd/2+w,0]) roundedbox(weathercoveroutd/2-funneloffset+basel-w*2,basesidew,cupwall,cornerd);
	translate([funneloffset-baseguidel/2,-basesidew-basesideoffset,baseguideh-w]) cube([baseguidel,wall+w,wall]);
      }
      translate([funneloffset,0,0]) cylinder(d=weathercoveroutd-wall*2-w*2-dtolerance,h=baseguideh+wall);
      translate([funneloffset-weathercoveroutd/2+wall+xtolerance+w,-funneltopd/2+wall+ytolerance+w,0]) cube([weathercoveroutd-wall*2-xtolerance*2-w*2,funneltopd-wall*2-ytolerance*2-w*2,weathercoverstartnarrowing]);
    }

    translate([0,-weathercoverclipdistance,weathercoverclipheight]) tubeclip(weathercovercliplength,weathercoverclipd,weathercoverclipdtolerance);
  }
}

module cups() {
  difference() {
    union() {
      translate([0,-cupaxlewidth/2,cupaxleheight]) onehinge(cupaxled,cupaxlew,baseaxlesupportwall,0,ytolerance,axledtolerance);
      translate([0,cupaxlewidth/2,cupaxleheight]) onehinge(cupaxled,cupaxlew,baseaxlesupportwall,0,ytolerance,axledtolerance);

      translate([0,0,cupaxleheight]) rotate([0,angle,0]) {
	lengthadjust=cupbaseh*sin(-cupangle);
	middleadjust=sin(45+cupangle);

	difference() {
	  union() {
	    // Cup side plates
	    for (y=[-cupaxlewidth/2,cupaxlewidth/2]) {
	      // Cup sideplates
	      hull() {
		translate([0,y-cupwall/2,0]) rotate([-90,0,0]) cylinder(d=cupaxled,h=cupwall);
		translate([-cuplength,y-cupwall/2,cupbaseh]) roundedbox(cuplength*2,cupwall,cupwall,cornerd);
		translate([0,y-cupwall/2,cupbaseh+cuph+cupextrah+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([-cupsideraisel,y-cupwall/2,cupbaseh+cupsideraiseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([cupsideraisel,y-cupwall/2,cupbaseh+cupsideraiseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
	      }
	    }

	    // Cup baseplate
	    translate([-cuplength,-cupaxlewidth/2,cupbaseh]) roundedbox(cuplength*2,cupwidth,cupwall,smallcornerd);

	    // Middle barrier separating cups. Needs an cupangle for printing (45-cupangle)
	    hull() {
	      translate([0,-cupaxlewidth/2,cupbaseh+cuph+cupwall+cupextrah-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	      translate([cuph*middleadjust,-cupaxlewidth/2,cupbaseh+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	      translate([-cuph*middleadjust,-cupaxlewidth/2,cupbaseh+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	      //	      translate([-cuph*middleadjust,-cupaxlewidth/2,cupbaseh+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
	    }

	    // Magnet holder
	    hull() {
	      outd=cupwall-magnetwall+magneth+dtolerance+magnetwall;
	      translate([0,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/3]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+dtolerance,h=magnetwall+magneth+magnetwall+ytolerance);
	      translate([0,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+dtolerance,h=magnetwall+magneth+magnetwall+ytolerance);
	      translate([magnetd*middleadjust,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/4-magnetwall-outd]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+outd,h=cupwall);
	      translate([-magnetd*middleadjust,-cupaxlewidth/2-cupwall/2,cupbaseh+cuph+cupwall-magnetd/4-magnetwall-outd]) rotate([-90,0,0]) cylinder(d=magnetd+magnetwall*2+outd,h=cupwall);
	    }
	
	    for (y=[-cupaxlewidth/2,cupaxlewidth/2]) {
	      hull() {
		translate([0,y-cupwall/2,cupbaseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([cuplength,y-cupwall/2,cupbaseh]) rotate([0,-cupangle,0]) {
		  translate([-0.1,0,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(0.1,cupwall,cupbelowh,smallcornerd);
		}
	      }
	    }
	
	    for (y=[-cupaxlewidth/2,cupaxlewidth/2]) {
	      hull() {
		translate([0,y-cupwall/2,cupbaseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([-cuplength,y-cupwall/2,cupbaseh]) rotate([0,cupangle,0]) {
		  translate([0,0,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(0.1,cupwall,cupbelowh,smallcornerd);
		}
	      }
	    }

	    if (adhesion) {
	      adhesionh=cupaxleheight-cupaxleheight+7;
	      translate([cuplength,0,cupbaseh]) rotate([0,-cupangle,0]) translate([-0.2,-cupaxlewidth/2-cupwall/2,-cupwall+cupwall+adhesiongap+cupwall*cos(-cupangle)]) cube([0.2,cupaxlewidth+cupwall,cupwall+cupwall+adhesiongap]);
	      translate([cuplength,0,cupbaseh]) rotate([0,-cupangle,0]) translate([-0.2,-cupaxlewidth/2-cupwall/2+stopperw/2,-cupwall+cupwall+adhesiongap+cupwall*cos(-cupangle)]) cube([0.2,cupaxlewidth+cupwall-stopperw,cupwall+adhesionh+cupwall+adhesiongap]);
	    }
	    
	    // End plates to support printing cups - this end printing to the bed
	    translate([cuplength,0,cupbaseh]) rotate([0,-cupangle,0]) {
	      hull() {
		translate([-cupwall/2,-cupaxlewidth/2-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([-cupwall/2,-cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	      hull() {
		translate([-cupwall/2,0-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([-cupwall/2,cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	    }
	
	    // End plates to support printing cups - this end printing away from the bed
	    translate([-cuplength,0,cupbaseh]) rotate([0,cupangle,0]) {
	      hull() {
		translate([0,-cupaxlewidth/2-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([0,-cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	      hull() {
		translate([0,-0-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([0,cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	    }
	  }
	  
	  // Magnet holder cutout
	  hull() {
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall-magnetdroph,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance);
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall-magnetd/2+magnetdroph]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance);
	  }
	  hull() {
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance);
	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall,cupbaseh+cuph+cupwall+magnetholedepth-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd+dtolerance,h=magneth+ytolerance);
	  }
	  // Magnet itself (for debugging)
	  #	    translate([0,-cupaxlewidth/2-cupwall/2+magnetwall-magnetdroph,cupbaseh+cuph+cupwall-magnetd/2]) rotate([-90,0,0]) cylinder(d=magnetd,h=magneth);

	  // Locking hole
	  translate([0,-cupaxlewidth/2-cupwall/2+magnetwall+magneth-magnetlockd/2+magnetytolerance,cupbaseh+cuph+cupwall+magnetd-magnetd/2]) sphere(d=magnetlockd+magnetdtolerance);
	}
      }

      // Sides
      difference() {
	union() {
	  translate([-basel,-funnelbasew/2,0]) roundedbox(basel*2,wall,weathercoverstartnarrowing,cornerd);
	  translate([-basel,funnelbasew/2-wall,0]) roundedbox(basel*2,wall,weathercoverstartnarrowing,cornerd);
	}
	translate([0,0,-ztolerance*1.5]) funneloutside();

	//	translate([0,-funnelbasew/2+cupwall/2-0.01,textheight]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	translate([0,funnelbasew/2+cupwall/2-textdepth*2+0.01,textheight]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

	//	translate([0,-funnelbasew/2+cupwall/2-0.01,areatextheight]) rotate([90,0,0]) linear_extrude(height=textdepth) text(areatext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
	translate([0,funnelbasew/2+cupwall/2-textdepth*2+0.01,areatextheight]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(areatext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
      }

      // Extension flanges to help with printing
      hull() {
	translate([basel-wall,-funnelbasew/2-2*wall,0]) roundedbox(wall,3*wall,weathercoverstartnarrowing,cornerd);
	if (adhesion) {
	  translate([basel-wall,-funnelbasew/2-extensionflangew,0]) roundedbox(wall,wall+extensionflangew,baseguideh,cornerd);
	}
      }

      hull() {
	translate([basel-wall,funnelbasew/2-wall,0]) roundedbox(wall,3*wall,weathercoverstartnarrowing,cornerd);
	if (adhesion) {
	  translate([basel-wall,funnelbasew/2-wall,0]) roundedbox(wall,wall+extensionflangew,baseguideh,cornerd);
	}
      }
      
      // Top stoppers to limit cup movement
      hull() {
	translate([basel-stopperl,-funnelbasew/2,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([basel-stopperl-stopperw,-funnelbasew/2,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }
      hull() {
	translate([basel-stopperl,funnelbasew/2-stopperw,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([basel-stopperl-stopperw,funnelbasew/2-cupwall,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }

      hull() {
	translate([-basel,-funnelbasew/2,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([-basel,-funnelbasew/2,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }
      hull() {
	translate([-basel,funnelbasew/2-stopperw,stopperheight]) roundedbox(stopperl,stopperw,stopperh,cornerd);
	translate([-basel,funnelbasew/2-cupwall,stopperheight]) roundedbox(stopperl+stopperw,cupwall,stopperh,cornerd);
      }
      
      // Bottom plate
      intersection() {
	union() {
	  translate([-basel,-weathercoveroutd/2,0]) roundedbox(2*basel,weathercoveroutd,cupwall,cornerd);
	  translate([-weathercoveroutd/2+funneloffset,weathercoveroutd/2-basesidew,0]) roundedbox(weathercoveroutd/2-funneloffset+basel,basesidew,cupwall,cornerd);
	  translate([-weathercoveroutd/2+funneloffset,-weathercoveroutd/2,0]) roundedbox(weathercoveroutd/2-funneloffset+basel,basesidew,cupwall,cornerd);
	}
	translate([funneloffset,0,0]) cylinder(d=weathercoveroutd-wall*2-dtolerance,h=wall);
	translate([funneloffset-weathercoveroutd/2+wall+xtolerance,-funneltopd/2+wall+ytolerance,0]) cube([weathercoveroutd-wall*2-xtolerance*2,funneltopd-wall*2-ytolerance*2,weathercoverstartnarrowing]);
      }

      // Raise center of base slightly to avoid water collecting there
      hull() {
	translate([-basel,-basew/2,0]) roundedbox(2*basel,basew,cupwall,cornerd);
	translate([-0.01,-basew/2,cupwall+centerraise]) cube([0.02,basew,0.1]);
      }

      // Support weather cover
      hull() {
	translate([-basel/2+funneloffset,-funneltopd/2,0]) roundedbox(basel,funneltopd,cupwall,cornerd);
	translate([-basel/2+funneloffset-wall,-funneltopd/2+wall+ytolerance,0]) roundedbox(basel+wall*2,funneltopd-wall*2-ytolerance*2,cupwall,cornerd);
      }
      
      // Guides at sides to help weathercover to drop neatly in place
      difference() {
	sideguide(0);
	sideguide(wall);
      }
      mirror([0,1,0]) difference() {
	sideguide(0);
	sideguide(wall);
      }

      // Center support to avoid hinge support flexing
      hull() {
	translate([0,-cupaxlewidth/2+cupwall*2+ytolerance,cupaxleheight]) rotate([-90,0,0]) cylinder(d=cupwall,h=cupaxlewidth/2-cupwall*2);
	translate([basel-cupwall,-cupaxlewidth/2+cupwall/2+cupwall+ytolerance,0]) roundedbox(cupwall,cupwall*2,cupwall,cornerd);
      }
      hull() {
	translate([0,cupaxlewidth/2-cupwall*2-ytolerance,cupaxleheight]) rotate([90,0,0]) cylinder(d=cupwall,h=cupaxlewidth/2-cupwall*2);
	translate([basel-cupwall,cupaxlewidth/2-cupwall/2-cupwall-ytolerance-cupwall*2,0]) roundedbox(cupwall,cupwall*2,cupwall,cornerd);
      }


      // Top of base structure
      difference() {
	translate([-rainpiped-wall*2,-funnelbasew/2,basetoph+wall]) roundedbox(basel+rainpiped+wall*2,funnelbasew,wall,cornerd);
	translate([0,0,funnelheight-0.01]) cylinder(h=raincupbottomh+0.02,d1=rainpiped+wall/2+dtolerance,d2=rainpiped+raincupbottomh+wall*2+dtolerance);
	hull() {
	  translate([0,0,funnelheight]) cylinder(d=raincupmidd-wall,h=wall*3);
	  translate([-raincupmidd/2,0,funnelheight]) cylinder(d=0.1,h=wall*3);
	}
      }
      
      // Hinge supports
      for (yy=[-cupaxlewidth/2, cupaxlewidth/2]) {
	difference() {
	  union() {
	    for (i=[0,1]) {
	      y=(i==0)?yy-cupwall*2-cupaxlew/2-ytolerance:yy+cupaxlew/2+ytolerance;
	      hull() {
		translate([-towerw/2,y,0]) roundedbox(towerw,2*cupwall,cupaxleheight,cornerd);
		translate([0,y,cupaxleheight]) rotate([-90,0,0]) cylinder(d=towerw,h=cupwall*2);
		translate([basel-cupwall,y+cupwall/2+cupwall/4,0]) roundedbox(cupwall,cupwall/2,cupwall,cornerd);
		translate([basel-cupwall,y+cupwall/2+cupwall/4,0]) roundedbox(cupwall,cupwall/2,cupwall,cornerd);
	      }
	    }
	  }
	}
      }
    }

    // Hinge cutouts
    for (yy=[-cupaxlewidth/2, cupaxlewidth/2]) {
      translate([0,yy,cupaxleheight]) onehinge(cupaxled,cupaxlew,baseaxlesupportwall+0.01,1,ytolerance,axledtolerance);
    }
  }

  // Attachment

  // clip
  intersection() {
    translate([attachclipposition,0,attachclipheight]) rotate([0,0,90]) tubeclip(attachclipl,attachclipd,0);
    translate([attachclipposition-attachclipd/2,-attachclipl/2,attachclipheight-attachclipd/2]) cube([attachclipd,attachclipl,attachclipd/2]);
  }

  difference() {
    union() {
      // Attachment body
      hull() {
	translate([basel-attachplatel,-attachplatew/2,-attachplateh]) roundedbox(attachplatel,attachplatew,attachplateh+cornerd,cornerd);
	translate([basel-attachplatel+attachplateh,-attachplatew/2-attachplateh,0]) roundedbox(attachplatel-attachplateh*2,attachplatew+attachplateh*2,cupwall,cornerd);
      }
    }
    
    // Attachment cutout
    hull() {
      translate([basel-attachplatel-xtolerance,-attachmalebottomw/2-ytolerance,-attachplateh-0.01]) cube([attachmalel+xtolerance*2,attachmalebottomw+ytolerance*2+0.02,0.01]);
      translate([basel-attachplatel-xtolerance,-attachmaletopw/2-ytolerance-ztolerance,-attachplateh+attachmaleh+ztolerance]) cube([attachmalel+xtolerance*2+0.01,attachmaletopw+ytolerance*2+ztolerance*2,0.01]);
    }

    // Open space above clip to allow some flex
    translate([attachclipposition-attachclipflexspace,-attachclipl/2-attachclipflexspace,-attachclipd/3]) cube([attachclipflexspace*2,attachclipl+attachclipflexspace*2,attachclipd/2]);

    // Screw hole for locking meter to base
    translate([basel-screwlength+0.01,0,-attachplateh+attachmaleh-screwtowerd/3]) rotate([0,90,0]) ruuvireika(screwlength,screwd,1,strong&&print>0,attachplatel-attachmalel);
  }
}

module attachmale() {
  difference() {
    union() {
      // make attachment part
      hull() {
	translate([basel-attachplatel,-attachmalebottomw/2,-attachplateh]) cube([attachmalel,attachmalebottomw+0.02,0.01]);
	translate([basel-attachplatel,-attachmaletopw/2,-attachplateh+attachmaleh-0.01]) cube([attachmalel,attachmaletopw,0.01]);
      }

      // bottom support plate
      translate([basel-attachplatel,-attachmalebottomw/2,attachheight+ztolerance-largecornerd/2-0.01]) cube([attachmalel,attachmalebottomw+0.02,ztolerance+largecornerd/2+0.02]);
    }

    // Make entry angle to make inserting a bit easier
    translate([basel-attachplatel+attachmalel-attachclipd/3+0.01,-attachmaletopw/2,-attachplateh+attachmaleh-attachclipd/3]) triangle(attachclipd/3,attachmaletopw,attachclipd/3+0.01,3);
    
    // Screwto to lock rainmeter to the poleattach
    translate([basel-screwlength+0.01,0,-attachplateh+attachmaleh-screwtowerd/3]) rotate([0,90,0]) ruuvireika(screwlength,screwd,1,strong&&print>0,screwlength);

    translate([0,0,-attachplateh+attachmaleh+0.01-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

    // clip cut
    translate([attachclipposition,0,attachclipheight]) rotate([0,0,90]) tubeclip(attachclipl,attachclipd,attachclipdtolerance);
  }
}

module flatattach() {
  difference() {
    union() {
      attachmale();

      for (x=[basel-attachplatel+screwtowerd/2+screwd/2,basel-attachplatel+attachmalel-screwtowerd/2-screwd/2]) {
	for (y=[-attachmalebottomw/2+screwtowerd/2,attachmalebottomw/2-screwtowerd/2]) {
	  translate([x,y,attachheight-attachflatfeeth]) cylinder(d=screwtowerd,h=attachflatfeeth+0.01);
	}
      }
    }

    for (x=[basel-attachplatel+screwtowerd/2+screwd/2,basel-attachplatel+attachmalel-screwtowerd/2-screwd/2]) {
      for (y=[-attachmalebottomw/2+screwtowerd/2,attachmalebottomw/2-screwtowerd/2]) {
	translate([x,y,attachheight+screwbaselflat]) cylinder(d1=countersinkd(screwd),d2=screwtowerd,h=attachmaleh+ztolerance-screwbaselflat+cornerd/2+0.02);
	translate([x,y,attachheight+screwbaselflat-screwlength+0.01]) ruuvireika(screwlength,screwd,1,strong&&print>0,attachmaleh+ztolerance-screwbaselflat+cornerd/2+0.02);
      }
    }
  }
}

module poleattach() {
  difference() {
    union() {
      // Lower part around the pole
      hull() {
	translate([0,-poledistance,poleattachheight]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight]) scale([1,0.4,1]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance,poleattachheight+attachthickeningh+attachthickeningdh-0.1]) cylinder(d=attachd,h=0.1);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+attachthickeningh+attachthickeningdh-0.1]) scale([1,0.4,1]) cylinder(d=attachd,h=0.1);
      }

      // Mid part around the pole
      hull() {
	translate([0,-poledistance,poleattachheight]) cylinder(d=attachd,h=poleattachh);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight]) scale([1,0.4,1]) cylinder(d=attachd,h=poleattachh);
      }

      // Upper part around the pole
      hull() {
	translate([0,-poledistance,poleattachheight+poleattachh-attachthickeningh]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+poleattachh-attachthickeningh]) scale([1,0.4,1]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance,poleattachheight+poleattachh-(attachthickeningh+attachthickeningdh-0.1)]) cylinder(d=attachd,h=0.1);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+poleattachh-(attachthickeningh+attachthickeningdh-0.1)]) scale([1,0.4,1]) cylinder(d=attachd,h=0.1);
	translate([0,-poledistance,poleattachheight+poleattachh]) cylinder(d1=attachthickeningd,d2=poled+dtolerance,h=poleattachtopnarrowh);
      }
      
      attachmale();
      
      // Structure between pole base
      hull() {
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+poleattachh-attachthickeningh]) scale([1,0.4,1]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([basel-attachplatel,-attachplatew/2,-attachplateh-ztolerance-largecornerd]) roundedbox(attachplatel,attachplatew,largecornerd,largecornerd);
	translate([0,0,poleattachmetersupportmidh]) cylinder(d=poleattachbased,h=1);
	translate([0,-poledistance+screwlength-screwbasel,poleattachmetersupportmidh]) cylinder(d=poleattachbased,h=1);
      }

      // Foot to keep the base in balance when testing on table etc
      hull() {
	translate([0,0,poleattachheight]) cylinder(d=poleattachbased,poleattachh-attachthickeningh);
	translate([0,-poledistance+screwlength,poleattachheight]) cylinder(d=poleattachbased,h=poleattachbaseh);
      }

      // Screw towers
      for (z=[poleattachheight+screwtowerd/2,poleattachheight+poleattachh-attachthickeningh+screwtowerd/2]) {
	for (x=[-poled/2-screwtowerd/2,poled/2+screwtowerd/2]) {
	  translate([x,-poledistance-screwbasel+screwlength,z]) rotate([90,0,0]) ruuvitorni(screwlength,countersinkd(screwd));
	}
      }
    }

    translate([0,-poledistance-poled/2-textsize/2-1,textdepth+poleattachheight-0.01]) rotate([180,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");

    translate([0,-poledistance,poleheight]) cylinder(d=poled,h=poleh);

    // Cut to split the part around pole
    translate([-attachthickeningd/2-0.1,-poledistance-poleattachcut/2-0.1,poleattachheight-0.1]) cube([attachthickeningd+0.2,poleattachcut,poleattachh+poleattachtopnarrowh+0.2]);

    // Screws to close the poleattach around the pole.
    for (z=[poleattachheight+screwtowerd/2,poleattachheight+poleattachh-attachthickeningh+screwtowerd/2]) {
      for (x=[-poled/2,poled/2]) {
	translate([x+sign(x)*screwtowerd/2,-poledistance-screwbasel+screwlength,z]) rotate([90,0,0]) ruuvireika(screwlength,screwd,1,strong&&print>0,screwlength);
	hull() {
	  translate([x+sign(x)*screwtowerd/2,-poledistance-screwbasel+0.01,z]) rotate([90,0,0]) cylinder(d1=countersinkd(screwd),d2=screwtowerd,h=poled/2);
	  translate([x+sign(x)*screwtowerd,-poledistance-screwbasel+0.01-screwtowerd/2,z+screwtowerd/2]) rotate([90,0,0]) cylinder(d1=countersinkd(screwd),d2=screwtowerd,h=poled/2);
	}
      }
    }
  }
}

module wallattach() {
  difference() {
    union() {
      attachmale();
      
      // Structure between wallplate and base
      hull() {
	translate([-wallattachnarroww/2,-walldistance,wallattachheight]) roundedbox(wallattachnarroww,wallattachthickness,wallattachh,cornerd);
	translate([-wallattachnarroww/2,-walldistance,wallattachheight]) roundedbox(wallattachnarroww,cornerd,wallattachh+cornerd*3,cornerd);
	//translate([0,0,poleattachmetersupportmidh]) cylinder(d=poleattachbased,h=1);
	translate([0,0,poleattachheight]) cylinder(d=poleattachbased,h=1);
      }

      // Wallplate
      hull() {
	translate([-wallattachw/2,-walldistance,wallattachheight]) roundedbox(wallattachw,wallattachthickness,wallattachh,cornerd);
	translate([-wallattachw/2,-walldistance,wallattachheight]) roundedbox(wallattachw,cornerd,wallattachh+cornerd*3,cornerd);
      }
	
      // Foot to keep the base in balance when testing on table etc
      translate([0,0,poleattachheight]) cylinder(d=wallattachd,wallattachh);
      hull() {
	translate([basel-attachplatel,-attachplatew/2,-attachplateh-ztolerance-largecornerd]) roundedbox(attachplatel,attachplatew,largecornerd,largecornerd);
	translate([0,-walldistance+wallattachlowfromwall+poleattachbased/2,poleattachheight+wallattachlowh]) cylinder(d=wallattachlowd,h=wallattachh-wallattachlowh);
	translate([0,-walldistance+wallattachd/2,wallattachheight+wallattachmidh]) scale([1,1,0.5]) rotate([90,0,0]) cylinder(d=wallattachnarroww,h=1);
      }

      hull() {
	translate([basel-attachplatel,-attachplatew/2,-attachplateh-ztolerance-largecornerd]) roundedbox(attachplatel,attachplatew,largecornerd,largecornerd);
      }
    }

    // Screws to close the poleattach around the pole.
    for (z=[wallattachheight+screwtowerd/2,wallattachheight+wallattachh-screwtowerd/2]) {
      for (x=[-wallattachw/2,wallattachw/2]) {
	translate([x-sign(x)*screwtowerd/2,-walldistance-screwlength+wallattachthickness+0.01,z]) rotate([-90,0,0]) ruuvireika(screwlength,screwd,1,strong&&print>0,screwlength);
	if (0) 	hull() {
	  translate([x+sign(x)*screwtowerd/2,-walldistance-screwbasel+0.01,z]) rotate([90,0,0]) cylinder(d1=countersinkd(screwd),d2=screwtowerd,h=poled/2);
	  translate([x+sign(x)*screwtowerd,-poledistance-screwbasel+0.01-screwtowerd/2,z+screwtowerd/2]) rotate([90,0,0]) cylinder(d1=countersinkd(screwd),d2=screwtowerd,h=poled/2);
	}
      }
    }
  }
}


module claw(y) {
  translate([0,y,0]) {
    intersection() {
      union() {
	difference() {
	  hull() {
	    cylinder(d=magnetd+magnettoolwall*2+magnettoolytolerance,h=magneth);
	  }

	  // Cut magnet insides
	  translate([0,0,-0.01]) cylinder(d=magnetd+magnettoolytolerance,h=magneth+0.02);
	}
      }

      translate([0-magnettoolclawd/2,-magnettoolpushercenterw/2-magnettoolpushercutw-magnettoolclawd/2,0]) cube([magnettoolclawd,magnettoolclawd/2,magneth]);
    }
  }

  hull() {
    translate([magnetd/2*0.95,-magnettoolpushercenterw/2-magnettoolpushersidew-magnettoolytolerance+y,0]) roundedbox(cornerd,magnettoolpushersidew,magneth,cornerd);
    translate([magnetd/2+magnettoolpusherspringl,-magnettoolpushercenterw/2-magnettoolpushersidew-magnettoolytolerance,0]) roundedbox(cornerd,magnettoolpushersidew,magneth,cornerd);
  }
}

module magnettoolpusher() {
  // Center of pusher
  translate([magnettoolpusherposition,0,0]) difference() {
    union() {
      translate([magnetd/2,-magnettoolpushercenterw/2,0]) roundedbox(magnettoolplacerl-magnetd/2,magnettoolpushercenterw,magneth,cornerd);
      translate([magnettoolcontrolstart,-magnettoolcontrolslit/2,magnettoolpathheight+magnettoolztolerance]) cube([magnettoolcontroll,magnettoolcontrolslit,magneth+magnettoolztolerance+magnettoolwall+magnettoolcontrolh]);
      difference() {
	translate([magnettoolcontrolstart,-magnettoolcontrolw/2,magnettoolpathheight+magnettoolztolerance+magneth+magnettoolztolerance+magnettoolwall-magnettoolcontrolh]) triangle(magnettoolcontroll,magnettoolcontrolw,magnettoolcontrolw-magnettoolcontrolh,21);
	translate([magnettoolcontrolstart+magnettoolcontroll*0.7,magnettoolhand*magnettoolhandshift,magnettoolfingerheight]) sphere(magnettoolfingerd);
      }
      intersection() {
	difference() {
	  hull() {
	    cylinder(d=magnettoolclawd,h=magneth);
	  }

	  // Cut magnet insides
	  translate([0,0,-0.01]) cylinder(d=magnetd+magnettooldtolerance,h=magneth+0.02);
	}
	translate([0,-magnettoolpushercenterw/2,0]) cube([magnettoolclawd,magnettoolpushercenterw,magneth]);
      }
    }
  }

  // Below (negativey) claw
  translate([magnettoolpusherposition,0,0]) difference() {
    union() {
      translate([0,0,0]) claw(-magnettoolyopen);
      translate([0,0,0]) mirror([0,1,0]) claw(-magnettoolyopen);
      translate([magnetd/2+magnettoolpusherspringl-1,-magnettoolpusherw/2,0]) roundedbox(magnettoolplacerl-magnettoolpusherspringl-magnetd/2+1,magnettoolpusherw,magneth,cornerd);
    }
  }
}

module magnettoolpathcut(start,l) {
  hull() {
    translate([start-magnettooloutpositionw,-magnettoolpathnarrow/2,magnettoolpathheight]) cube([l+magnettooloutpositionw*2,magnettoolpathnarrow,magnettoolpathh]);
    translate([start,-magnettoolpathwide/2,magnettoolpathheight]) cube([l,magnettoolpathwide,magnettoolpathh]);
  }
}

module magnettoolcap() {
  outd=magnetd+magnettooldtolerance+magnettoolwall*2+magnettoolcapdtolerance+magnettoolwall*2;
  ind=magnetd+magnettooldtolerance+magnettoolwall*2+magnettoolcapdtolerance;
  difference() {
    cylinder(d=outd,h=magnettoolfeedh-magnettoolplacerh);
    translate([0,0,magnettoolwall]) cylinder(d=ind,h=magnettoolfeedh-magnettoolplacerh-0.1);
    translate([ind/2-magnettoolcaplockoffset,0,magnettoolcaplockh-magnettoolztolerance]) sphere(d=magnettoolcaplockd+magnettooldtolerance);
  }

  translate([-magnettoolcaplockattachx,0,0]) ring(outd,magnettoolwall,0.6);
  translate([-magnettoolcaplockattachx+ind/2,-magnettoolcaplockattachw/2,0]) cube([magnettoolcaplockattachx-ind/2-ind/2,magnettoolcaplockattachw,0.4]);
}

module magnettool() {
  difference() {
    union() {
      hull() {
	translate([magnetd/2,-magnettoolplacerw/2,0]) roundedbox(magnettooll-magnetd/2,magnettoolplacerw,magnettoolplacerh,cornerd);

	translate([0,0,0]) cylinder(d=magnetd,h=magnettoolplacerh);
      }

      // Magnet feeder
      translate([magnettoolfeedx,0,magnettoolpathheight+magnettoolpathh]) cylinder(d=magnetd+magnettooldtolerance+magnettoolwall*2,h=magnettoolfeedh);

      // Cap lock for feeder
      translate([magnettoolfeedx+(magnetd+magnettooldtolerance+magnettoolwall*2+magnettooldtolerance)/2-magnettoolcaplockoffset,0,magnettoolpathheight+magnettoolpathh+magnettoolfeedh+magnettoolwall-magnettoolcaplockh]) sphere(d=magnettoolcaplockd);
    }

    // Open the path in the center
    translate([-magnetd-0.01,-magnettoolpathnarrow/2,magnettoolpathheight]) cube([magnetd+magnettooll-magnettoolwall+0.02,magnettoolpathnarrow,magnettoolpathh]);

    // Widening in the mouth
    magnettoolpathcut(0,magnettoolmouthl);

    // Widening in the magnet feed
    magnettoolpathcut(magnettoolfeedx-magnetd/2,magnettoolgrabberl+magnettoolgrabberextensionl);

    // Magnet feed
    translate([magnettoolfeedx,0,magnettoolpathheight]) cylinder(d=magnetd+magnettooldtolerance,h=magnettoolpathh+magnettoolfeedh+0.01);

    // Open top of the handle tunnel for handle
    translate([magnettoolcontrolstart-magnettoolxtolerance,-magnettoolcontrolslit/2-magnettoolytolerance,magnettoolpathheight+magnettoolpathh-0.02]) cube([magnettooll-(magnettoolcontrolstart-magnettoolwall),magnettoolcontrolslit+magnettoolytolerance*2,magnettoolpathheight+magnettoolpathh+magnettoolpathnarrow]);
    
    // Magnet at mounth, just for debugging
    translate([0,0,magnettoolwall+magnettoolztolerance]) #cylinder(d=magnetd,h=magneth);

    // Version text
    translate([magnettooll/2,0,magnettoolwall/2-0.01]) rotate([180,0,0]) linear_extrude(height=magnettoolwall/2) text(versiontext, size=6, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }

  // Raise below magnet to allow easier grabbing, pusher tends to get stuck to multiple magnets
  hull() {
    translate([magnettoolfeedx,0,magnettoolpathheight-0.01]) cylinder(d=magnetd+magnettooldtolerance+magnettoolwall*2,h=0.01);
    translate([magnettoolfeedx,0,magnettoolpathheight-0.01]) cylinder(d=magnetd+magnettooldtolerance,h=magnettoolztolerance);
  }
}

module magnettoolhandle() {
    translate([magnettooll-cornerd,-magnettoolplacerw/2,0]) roundedbox(magnettoolhandlel-cornerd,magnettoolplacerw,magnettoolplacerh-magnettoolwall,cornerd);
  hull() {
    translate([magnettooll,-magnettoolplacerw/2,0]) roundedbox(magnettoolhandlel,magnettoolplacerw,magnettoolplacerh-magnettoolwall,cornerd);
    translate([magnettooll+magnettoolhandlel,0,magnettoolhandlecornerd/2]) minkowski() {
      cylinder(d=magnettoolhandled,h=magnettoolhandleh-magnettoolhandlecornerd);
      sphere(d=magnettoolhandlecornerd);
    }
  }
}

tweezersl=120;
tweezersw=9;
tweezerswl=50;
tweezersjoin=26.55;
tweezersjoinh=4;
tweezersheadw=magnetd+magnettoolwall*2;
tweezersh=4;
tweezerslh=2;
tweezersangle=3;
tweezersend1h=2;
tweezersend2h=2;
tweezersendl=1.5*magnetd;
tweezersendslope=10;

module tweezer() {
  difference() {
    union() {
      hull() {
	translate([0,-tweezersw/2,0]) cylinder(d=tweezersw,h=tweezersh);
	translate([tweezersjoin,-tweezersw/2,0]) cylinder(d=tweezersw,h=tweezersjoinh);
      }

      hull() {
	translate([tweezersjoin,-tweezersw/2,0]) cylinder(d=tweezersw,h=tweezerslh);
	translate([tweezerswl,-tweezersw/2,0])  cylinder(d=tweezersw,h=tweezerslh);
      }
  
      hull() {
	translate([tweezerswl,-tweezersw/2,0])  cylinder(d=tweezersw,h=tweezerslh);
	translate([tweezersl-tweezersendl,-tweezersheadw/2,0])  cylinder(d=tweezersheadw,h=tweezerslh);
      }

      hull() {
	translate([tweezersl-tweezersendl,-tweezersheadw/2,0]) cylinder(d=tweezersheadw,h=tweezersend1h);
	translate([tweezersl,-tweezersheadw/2,0]) cylinder(d=tweezersheadw,h=tweezersend2h);
      }
    }

    translate([tweezersl,-tweezersheadw-0.01,-0.01]) cube([tweezersheadw,tweezersheadw+0.02,tweezersend2h+0.02]);
    translate([tweezersl-(tweezersheadw/2-magneth/2)/2,-tweezersheadw-0.01,-0.01]) triangle((tweezersheadw/2-magneth/2)/2+0.01,tweezersheadw+0.02,tweezersend2h-magneth/2+0.02,0);
    hull() {
      translate([tweezersl,-tweezersheadw/2,tweezersend2h-magneth/2]) rotate([0,tweezersangle/2,0]) cylinder(d=magnetd+magnettooldtolerance*2,h=magneth);
      translate([tweezersl,-tweezersheadw/2,tweezersend2h]) rotate([0,tweezersangle/2,0]) cylinder(d=magnetd+magneth+magnettooldtolerance*2,h=magneth+0.01);
    }
  }
}

module tweezers() {
  rotate([-90,0,0]) {
    hdiff=tweezersw/2*sin(tweezersangle);
    difference() {
      union() {
	tweezer();
	translate([0,0,tweezersh+hdiff]) mirror([0,0,1]) rotate([0,tweezersangle,0]) tweezer();
      }
      diameter1=tweezersjoin*sin(tweezersangle)+hdiff;
      diameter2=(tweezersjoin+tweezersw)*sin(tweezersangle);
      hull() {
	translate([tweezersjoin,0.1,tweezerslh+diameter1/2]) rotate([90,0,0]) cylinder(d=diameter1,h=tweezersw+0.2);;
	translate([tweezersjoin+tweezersw/2,0.1,tweezerslh+diameter2/2]) rotate([90,0,0]) cylinder(d=diameter2,h=tweezersw+0.2);
      }
    }
  }
}

module rainmeter() {
  cups();
}

if (print==0) {
  intersection() {
    union() {
      
      grill();
      //#weathercover();
      rainmeter();
      magnetlock();
      if (includepoleattach) poleattach();
      if (includeflatattach) flatattach();
      if (includewallattach) wallattach();
      if (includehallsensortester) hallsensortester();
    }
    if (0) hull() {
      //translate([-basel*2,-weathercoveroutd-100,-200]) cube([basel*2+100,weathercoveroutd+100,400]); //-9.05
      //      translate([0,-weathercoveroutd-100,-200]) cube([basel*2+100,weathercoveroutd+200,400]); //-9.05
    }
  }
 }

if (print==1 || print==6 || print==8) {
  translate([-basel-14,weathercoveroutd-27,basel]) rotate([0,90,0]) {
    intersection() {
      rainmeter();
      if (print==8) {
	w=24;
	translate([-basel*2,-w,0]) cube([basel*4,w*2,200]);
      }
    }
  }
 }

if (print==2 || print==6) {
  intersection() {
    translate([0,0,toph]) rotate([180,0,0]) weathercover();
    if (debug) translate([0,0,0]) cube([weathercoveroutd,weathercoveroutd,toph+100]);
  }
  if (adhesion) ring(funneltopd+adhesionwd*2+adhesiongap*2,adhesionwd,0.2,0);
 }

if (print==3 || print==6) {
  translate([-weathercoveroutd/2-funneltopd/2+2,0,0]) {
    if (adhesion) ring(funneltopd-cupwall*3+dtolerance+adhesionwd*2+adhesiongap*2,adhesionwd,0.2,0);
    translate([0,0,-grillheight]) grill();
  }
 }

if (print==4 || print==10) {
  translate([0,0,-poleattachheight]) rotate([0,0,0]) {
    poleattach();
    if (adhesion) {
      ringd=attachthickeningd+adhesionwd*2+adhesiongap*2;
      translate([0,-poledistance,poleattachheight]) {
	ring(poled-adhesiongap*2,adhesionwd,adhesionh,0);
	intersection() {
	  ring(ringd,adhesionwd,adhesionh,0);
	  translate([-ringd/2,-ringd/2,0]) cube([ringd,ringd/2,1]);
	}
      }
      outd=poleattachbased+adhesionwd*2;
      intersection() {
	translate([0,0,poleattachheight]) ring(outd+adhesiongap*2,adhesionwd,adhesionh,0);
	translate([-outd/2-adhesiongap,0,poleattachheight]) cube([outd+adhesiongap,outd+adhesiongap,adhesionh]);
      }

      l=-poledistance+screwlength-screwbasel+(ringd/2-adhesionwd)*0.4;
      difference() {
	translate([-outd/2-adhesiongap,l,poleattachheight]) cube([outd+adhesiongap,-l,adhesionh]);
	translate([-poleattachbased/2-adhesiongap,l,poleattachheight-0.01]) cube([poleattachbased+adhesiongap*2,-l,adhesionh+0.02]);
      }
    }
  }
 }

if (print==5 || print==6 || print==8) {
  translate([-weathercoveroutd-9+20,weathercoveroutd-attachplatew/2+gridstep+1,0]) {
    rotate([180,0,90]) {
      translate([0,0,attachplateh-attachmaleh]) flatattach();
    }

    rotate([0,0,90]) 
    difference() {
      translate([basel-attachplatel-adhesiongap-adhesionwd,-attachmaletopw/2-adhesiongap-adhesionwd,0]) cube([attachmalel+adhesiongap*2+adhesionwd*2,attachmaletopw+adhesiongap*2+adhesionwd*2,0.2]);    
      translate([basel-attachplatel-adhesiongap,-attachmaletopw/2-adhesiongap,-0.1]) cube([attachmalel+adhesiongap*2,attachmaletopw+adhesiongap*2,0.4]);
    }
  }
 }

if (print==7 || print==6) {
  translate([attachplatew/2,magnetholedepth/2,0]) rotate([90,180,cupangle]) translate([0,-(-cupaxlewidth/2-cupwall/2+magnetwall+magnetytolerance+magneth),-cupaxleheight-cupbaseh-cuph-cupwall+magnetd/2]) magnetlock();
 }

if (print==8) {
 }

if (print==9 || (print==6 && includemagnettool) || print==8) {
  translate([weathercoveroutd/2-14,weathercoveroutd/2+weathercoveroutd-18,0]) rotate([0,0,180]) {
    locktapd=1;
    locktapoffset=1.5;
    zcutlevel=magnettoolpathheight+magnettoolpathh-0.01;
    intersection() {
      magnettool();
      translate([-100,-100,0]) cube([100+magnettooll,400,zcutlevel]);
    }
    magnettoolhandle();
    translate([magnettooll-magnettoolwall,-magnettoolcontrolslit/2,0]) roundedbox(magnettoolwall,magnettoolcontrolslit,magnettoolplacerh,cornerd);
    for (x=[magnetd*2:18:magnettooll-magnettoolwall]) {
      for (y=[-magnettoolplacerw/2+locktapoffset,magnettoolplacerw/2-locktapoffset]) {
	translate([x,y,0]) cylinder(d=locktapd,h=magnettoolplacerh,$fn=30);
      }
    }

    translate([0,magnettoolplacerw+1,-zcutlevel]) intersection() {
      difference() {
	magnettool();
	for (x=[magnetd*2:18:magnettooll-magnettoolwall]) {
	  for (y=[-magnettoolplacerw/2+locktapoffset,magnettoolplacerw/2-locktapoffset]) {
	    translate([x,y,-0.01]) cylinder(d=locktapd+magnettooltopdtolerance,h=magnettoolplacerh+0.02,$fn=30);
	  }
	}
      }
      translate([-magnetd,-magnettoolplacerw/2,zcutlevel]) {
	cube([magnettooll+magnetd,magnettoolplacerw,100]);
      }
    }

    translate([0,magnettoolplacerw*2,0]) magnettoolpusher();
    translate([magnettoolfeedx,magnettoolplacerw*3-2,0]) magnettoolcap();
  }
 }

if (print==11 || print==10) {
  translate([wallattachw/2+attachthickeningd/2+1,0,-wallattachheight]) wallattach();
 }

if (print==12 || (print==6 && includetweezers) || print==8) {
  translate([-weathercoveroutd-44+190+5,weathercoveroutd/2+weathercoveroutd-10,0]) rotate([0,0,-90-tweezersangle/2]) tweezers();
 }

if (print==13) {
  rotate([-90,0,0]) translate([0,funnelbasew/2-cupwall/2+2,-hallsensorheight]) hallsensortester();
}
