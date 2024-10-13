// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO: weather cover
// reed switch/sensor, ESP32

include <hsu.scad>

print=0;
debug=0;
strong=0; // Add strengtening structures around screwholes. Slicer dependent.

adhesion=1;
adhesiongap=0.02;
adhesionwd=6;
adhesionh=0.2;

grid=1;
poleattach=1;
flatattach=0;
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

angle=(print>0) ? cupangle:cupangle; //cupangle; //cupangle;
lowercupangle=cupangle+10;

towerw=cupaxled+1;

raincupd=90;
rainpiped=3; // Inside diameter
raincupbottomh=2*wall;
raincupmidd=rainpiped+raincupbottomh+wall*2;
raincupmidh=(raincupd-raincupmidd)/2.35; //30;
echo(raincupmidh);
raincuptoph=5;
funneltoph=raincupbottomh+raincupmidh+raincuptoph;

stopperw=wall*3;
stopperh=wall;
stopperl=wall*3;

//magnetd=6.36;
//magneth=3.2;
magnetwall=1.5;
magnetd=4.4;
magneth=1.6;
magnetholedepth=2*magnetd;
magnetdroph=1;
magnetlockd=2;
magnetlockh=magnetd*2;
magnetytolerance=0.2;
magnetdtolerance=dtolerance;
magnetspringcut=0.25;
magnetspringcutw=magnetlockd;
magnetspringcutl=magnetlockh;
magnetspringlow=cupbaseh+cuph+cupwall-magnetd/2; //-cupaxlewidth/2-cupwall/2+magnetwall-magnetdroph; // Center of the magnet
magnetspringhigh=magnetspringlow+magnetspringcutl;

//funnelbasew=cupaxlewidth+(cupwall/2+wall+ytolerance)*2;
funnelbasew=cupaxlewidth+(cupaxlew/2+wall+ytolerance)*2;
funnelh=cupbaseh+cupwall+cuph+max(stopperh,magnetd);
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
weathercoverclipd=1.4;
weathercoverclipheight=wall+weathercoverclipd+5;
weathercoverclipdistance=funneltopd/2-weathercoverclipd; //wall+0.6;
weathercoverclipdtolerance=0.2;
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

poleattachh=90;
poleattachheight=-poleattachh-20;
screwdistanceh=poleattachh-screwtowerd/2-screwtowerd;
attachthickeningh=screwtowerd;
attachthickeningd=poled+screwtowerd*2;
attachthickeningdh=screwtowerd*1.5;
attachd=poled+wall*2;
poleattachcut=2.5;
poleattachtopnarrowh=5; // Small angle to get water off
poleattachbased=10;
poleattachbaseh=poleattachh-10;

attachplatew=60;
attachplatel=75;
attachplateh=10;
attachholeh=8+ztolerance;
attachmalel=attachplatel-6;
attachmaleh=8;
attachmaletopw=attachplatew-10;
attachmalebottomw=attachmaletopw-attachmaleh*2;

attachheight=-attachplateh-ztolerance-cornerd/2;


versiontext=str("V1.4 d", funneltopd);
areatext=str("a=",floor(3.14159*(funneltopd/2)*(funneltopd/2)),"mm2");
textheight=basetoph-10;
areatextheight=textheight-textsize;

extensionflangew=adhesion?basesidew/2+wall:2*wall;

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
		translate([0,y-cupwall/2,cupbaseh+cuph+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([-cupsideraisel,y-cupwall/2,cupbaseh+cupsideraiseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
		translate([cupsideraisel,y-cupwall/2,cupbaseh+cupsideraiseh]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwall);
	      }
	    }

	    // Cup baseplate
	    translate([-cuplength,-cupaxlewidth/2,cupbaseh]) roundedbox(cuplength*2,cupwidth,cupwall,smallcornerd);

	    // Middle barrier separating cups. Needs an angle for printing (45-cupangle)
	    hull() {
	      translate([0,-cupaxlewidth/2,cupbaseh+cuph+cupwall-0.1]) rotate([-90,0,0]) cylinder(d=0.1,h=cupwidth);
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
	
	    translate([-cuplength,0,cupbaseh]) rotate([0,cupangle,0]) {
	      hull() {
		translate([0,-cupaxlewidth/2-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
		translate([0,-cupaxlewidth/2-cupwall/2,-cupbelowh+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupwall,cupbelowh,smallcornerd);
	      }
	      hull() {
		translate([0,0-cupwall/2,-cupwall+cupwall*cos(-cupangle)]) roundedbox(cupwall/2,cupaxlewidth/2+cupwall,cupwall,smallcornerd);
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

	translate([0,-funnelbasew/2+cupwall/2-0.01,textheight]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	translate([0,funnelbasew/2+cupwall/2-textdepth*2+0.01,textheight]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

	translate([0,-funnelbasew/2+cupwall/2-0.01,areatextheight]) rotate([90,0,0]) linear_extrude(height=textdepth) text(areatext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
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
      stopperheight = cupaxleheight+cupsideraisel*sin(-angle)+cupbaseh+cupsideraiseh-cupwall+ztolerance*2.5; //basetoph+wall;
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
  difference() {
    hull() {
      translate([basel-attachplatel,-attachplatew/2,-attachplateh]) roundedbox(attachplatel,attachplatew,attachplateh+cornerd,cornerd);
      translate([basel-attachplatel+attachplateh,-attachplatew/2-attachplateh,0]) roundedbox(attachplatel-attachplateh*2,attachplatew+attachplateh*2,cupwall,cornerd);
    }
    hull() {
      translate([basel-attachplatel-xtolerance,-attachmalebottomw/2-ytolerance,-attachplateh-0.01]) cube([attachmalel+xtolerance*2,attachmalebottomw+ytolerance*2+0.02,0.01]);
      translate([basel-attachplatel-xtolerance,-attachmaletopw/2-ytolerance-ztolerance,-attachplateh+attachmaleh+ztolerance]) cube([attachmalel+xtolerance*2+0.01,attachmaletopw+ytolerance*2+ztolerance*2,0.01]);
    }
    translate([basel-screwlength+0.01,0,-attachplateh+attachmaleh-screwtowerd/3]) rotate([0,90,0]) ruuvireika(screwlength,screwd,1,strong&&print>0,attachplatel-attachmalel);
  }
}

module attachmale() {
  difference() {
    union() {
      // make attachment part
      hull() {
	translate([basel-attachplatel,-attachmalebottomw/2,-attachplateh-0.01]) cube([attachmalel,attachmalebottomw+0.02,0.01]);
	translate([basel-attachplatel,-attachmaletopw/2,-attachplateh+attachmaleh]) cube([attachmalel,attachmaletopw,0.01]);
      }

      // bottom support plate
      translate([basel-attachplatel,-attachmalebottomw/2,attachheight+ztolerance-largecornerd/2-0.01]) cube([attachmalel,attachmalebottomw+0.02,ztolerance+largecornerd/2+0.02]);
    }

    // Screwto to lock rainmeter to the poleattach
    translate([basel-screwlength+0.01,0,-attachplateh+attachmaleh-screwtowerd/3]) rotate([0,90,0]) ruuvireika(screwlength,screwd,1,strong&&print>0,screwlength);

    translate([0,0,-attachplateh+attachmaleh+0.01-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
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
      hull() {
	translate([0,-poledistance,poleattachheight]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance,poleattachheight+attachthickeningh+attachthickeningdh-0.1]) cylinder(d=attachd,h=0.1);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+attachthickeningh+attachthickeningdh-0.1]) cylinder(d=attachd,h=0.1);
      }
      hull() {
	translate([0,-poledistance,poleattachheight]) cylinder(d=attachd,h=poleattachh);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight]) cylinder(d=attachd,h=poleattachh);
      }
      hull() {
	translate([0,-poledistance,poleattachheight+poleattachh-attachthickeningh]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+poleattachh-attachthickeningh]) cylinder(d=attachthickeningd,h=attachthickeningh);
	translate([0,-poledistance,poleattachheight+poleattachh-(attachthickeningh+attachthickeningdh-0.1)]) cylinder(d=attachd,h=0.1);
	translate([0,-poledistance+screwlength-screwbasel,poleattachheight+poleattachh-(attachthickeningh+attachthickeningdh-0.1)]) cylinder(d=attachd,h=0.1);
	translate([0,-poledistance,poleattachheight+poleattachh]) cylinder(d1=attachthickeningd,d2=poled+dtolerance,h=poleattachtopnarrowh);
      }

      attachmale();
      
      // Structure between pole base
      hull() {
	translate([basel-attachplatel,-attachplatew/2,-attachplateh-ztolerance-largecornerd]) roundedbox(attachplatel,attachplatew,largecornerd,largecornerd);
	translate([0,-poledistance+screwlength-screwbasel+poled/2+poleattachbased/2,poleattachheight]) cylinder(d=poleattachbased,h=1);
	translate([0,-poledistance+screwlength,poleattachheight+attachthickeningh]) cylinder(d=poleattachbased,h=poleattachbaseh);
      }
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

module rainmeter() {
  cups();
}

if (print==0) {
  intersection() {
    union() {
      grill();
      //      weathercover();
      rainmeter();
#      magnetlock();
      if (poleattach) poleattach();
      if (flatattach) flatattach();
    }
    //            translate([-basel,-weathercoveroutd,0]) cube([basel,weathercoveroutd-9.05,200]);
  }
  if (0)  intersection() {
    rainmeter();
    translate([-basel,-10,0]) cube([basel,10,200]);
  }
 }

if (print==1 || print==6) {
  translate([-weathercoveroutd/2-1,weathercoveroutd/2+weathercoverstartnarrowing/2-17,basel]) rotate([0,90,0]) rainmeter();
 }

if (print==2 || print==6) {
  intersection() {
    translate([0,0,toph]) rotate([180,0,0]) weathercover();
    if (debug) translate([0,0,0]) cube([weathercoveroutd,weathercoveroutd,toph+100]);
  }
  if (adhesion) ring(funneltopd+adhesionwd*2+adhesiongap,adhesionwd,0.2,0);
 }

if (print==3 || print==6) {
  translate([-weathercoveroutd/2-funneltopd/2-gridstep*1.5+3,attachplatew+screwlength/2+gridstep+4-screwbasel,-grillheight]) grill();
 }

if (print==4 || print==6) {
  translate([-weathercoveroutd/2-attachthickeningd/2-1,attachplatew,-poleattachheight]) {
    poleattach();
    if (adhesion) {
      ringd=attachthickeningd+adhesionwd*2+adhesiongap;
      translate([0,-poledistance,poleattachheight]) {
	ring(poled-adhesiongap,adhesionwd,adhesionh,0);
	intersection() {
	  ring(ringd,adhesionwd,adhesionh,0);
	  translate([-ringd/2,-ringd/2,0]) cube([ringd,ringd/2,1]);
	}
      }
      translate([0,screwlength-screwbasel-poledistance,poleattachheight]) {      
	intersection() {
	  ring(ringd,adhesionwd,adhesionh,0);
	  translate([-ringd/2,0,0]) cube([ringd,ringd/2,1]);
	}
      }
    }
  }
 }

if (print==5 || print==6) {
  rotate([180,0,0]) translate([1.5,0,attachplateh-attachmaleh]) flatattach();
 }

if (print==7 || print==6) {
  translate([-10,weathercoveroutd/2+basel-magnetd/2,0]) rotate([90,180,cupangle]) translate([0,-(-cupaxlewidth/2-cupwall/2+magnetwall+magnetytolerance+magneth),-cupaxleheight-cupbaseh-cuph-cupwall+magnetd/2]) magnetlock();
 }
