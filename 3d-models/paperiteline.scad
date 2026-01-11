// Paper towel roll holder

// Copyright 2022 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// height=x
// depth=y
// width=z

print=5; // 1=left, 2=right, 3=both, 4=lockpin, 5=cutter
debug=0;
dodebug=print>0?0:debug;

$fn=90;
versiontext="V3.12";
font = "Liberation Sans";
textdepth = 0.5;
textsize=8;

wall=2;
maxbridge=10;

xtolerance=0.30;
ytolerance=0.30;
ztolerance=0.30;
dtolerance=0.70;
cornerd=1;

rollwidth=226;
rolldiameteroutside=200;
rolldiameterinside=35; //3;
rollextra=5; // Distance from backplate to roll
rollborediameter=25;
screwdistance=166.5;

rolltubew=40;
rolltubenarrowing=10;
  
backplateheight=200;
backplatedepth=10;
holdersupportdepth=rolldiameteroutside/2+backplatedepth;
holdersupportwidth=10;
holdersupportupdepth=25;
backplatewidth=rollwidth+holdersupportwidth*2;

rollaxisdepth=rolldiameteroutside/2+backplatedepth+rollextra;
rollaxisheight=rolldiameterinside/2; // rolldiameteroutside/2;
rollborewidth=45; // rollwidth + 2*holdersupportwidth + 10;

rollnarrowingh=10;
rollnarrowingd=rolldiameterinside-8;

rolloverlapd=rollborediameter-dtolerance;
rolloverlaph=40;
rolloverlapheight=rollwidth-rolloverlaph;//*2/3;
rolloverlapnarrowingh=10;
rolloverlapnarrowingd=rolloverlapd-10;

rolllockcut=0.5;
rolllockd=5;
rolllockdepth=rolllockd/3;

screwrecessdiameter=30;
screwrecessdepth=6;
screwrecessmid=backplatewidth/2;
screwrecessheight=backplateheight-screwrecessdiameter/2-10;
screwrecessleft=screwrecessmid-screwdistance/2;
screwrecessright=screwrecessmid+screwdistance/2;

screwholediameter=6.5;

lockpinw=9;
lockpinfromedge=5;
lockpinfrombottom=10;
lockpinh=3;
lockpinextendl=10;
lockpinextendw=lockpinw+4;
lockpinextendh=lockpinh+2;

fingerwidth=lockpinfromedge+lockpinw+lockpinfromedge+ztolerance; //30;
fingerdepth=5;
fingerdepthposition=1.5;
fingerheight=20;
fingerupper=backplateheight - 45 - fingerheight; // rollaxisheight*2+backplatedepth/2-10-fingerheight;
fingerlower=20;
fingernotchdepth=1; //backplatedepth;
fingernotchmalediameter=1.5;
fingernotchwidth=3;
fingerholediameter=4;
fingernarrowing=3;

tolerance=0.3;
tolerancedepth=0.5;
diametertolerance=0.97; // 97;
  
holeedge=63;
roundholediameter=40;
holezadjust=6;

lockpinhandleh=17;
lockpinhandlew=30;
lockpinhandlethickness=backplatedepth+10;
lockpinhandlecornerd=5;
lockpinhandlefingerd=20;
lockpinhandlefingersink=5;

lockpinl=backplateheight-lockpinfrombottom+lockpinhandlecornerd;
lockpinheight=lockpinfrombottom;
lockpinhandleheight=lockpinl-lockpinhandlecornerd+xtolerance;

cutteraxled=10;
cutteraxleoutd=cutteraxled+wall*2;
cutteraxleind=cutteraxled;
  
cutteraxlecylinderd=cutteraxled+6;

cutteraxleheight=backplateheight-45;
cutteraxledepth=backplatedepth+20;

cutterslitw=rollwidth+4;
cutterwidth=cutterslitw+9;
cutterthickness=2;
cutterheadthickness=4;
cutterslith=10;
cutterslitheight=5;
cutterbodyh=cutterslith+16;
cutterattachw=50;
cutteraxlel=cutterattachw+(cutteraxled/2);
cutterlength=145;

cutterfrictionh=10;
cuttertoothh=10;
cuttertoothdepth=4;
cuttertoothd=1;
cuttertoothcut=2;
cuttertoothcutdepth=1.5;
cuttertoothcutfromedge=-cuttertoothcut;

cutteraxlesupportl=(rollwidth-cutteraxlel)/2-ztolerance;

cutterld=cutteraxled;

cutterheadcornerd=3;

cutterupsupport=cutteraxled/2+40;

module cutter() {
  sd=cutterld*(cutterattachw/cutterwidth);
  widecut=cutterlength-cutterld/2;
  narrowcut=cutteraxled+cutterld+sd/2+textsize+2;
      
  zfactor=narrowcut/widecut;
  yfactor=cutteraxlel/cutterattachw;
  factor=(cutterattachw/cutterwidth)*yfactor*1.4;
  
  difference() {
    union() {
      translate([0,0,-cutteraxlel/2]) cylinder(d=cutteraxleoutd+2,h=cutteraxlel);

      hull() {
	translate([0,0,-cutterattachw/2]) cylinder(d=cutteraxled,h=cutterattachw);
	translate([cutterupsupport,cutteraxled,-cutterattachw/2]) roundedbox(cutterthickness,cutteraxled,cutterattachw,cornerd,8);
      }

      hull() {
	translate([cutterupsupport-wall,cutteraxled,-cutterattachw/2]) roundedbox(cutterthickness+wall,cutteraxled+cutterld,cutterattachw,cornerd,8);
	translate([cutterupsupport,cutterlength,-cutterwidth/2]) roundedbox(cutterthickness,cutterbodyh,cutterwidth,cutterheadcornerd,8);
      }
      hull() {
	translate([cutterupsupport,cutterlength,-cutterwidth/2]) roundedbox(cutterthickness,cutterbodyh,cutterwidth,cutterheadcornerd,8);
	translate([cutterupsupport-cutterheadthickness+cutterthickness,cutterlength,-cutterwidth/2]) roundedbox(cutterheadthickness,cutterbodyh,cutterwidth,cutterheadcornerd,8);
      }

      for (m=[0,1]) mirror([0,0,m]) {
	  for (z=[0:cuttertoothh:cutterwidth/2-cuttertoothh]) {
	    hull() {
	      translate([cutterupsupport+cutterthickness,cutterlength+cutterbodyh+cuttertoothdepth,z+cuttertoothh/2]) rotate([0,-90,0]) cylinder(d=cuttertoothd,h=cuttertoothd+2);
	      translate([cutterupsupport-cutterheadthickness+cutterthickness,cutterlength+cutterbodyh-cutterheadcornerd,z]) roundedbox(cutterheadthickness,cutterheadcornerd,cuttertoothh,cornerd,8);
	    }
	  }
	}
    }
    
    for (m=[0,1]) mirror([0,0,m]) {
	for (z=[0:cuttertoothh:cutterwidth/2-cuttertoothh]) {
	  for (fromedge=[-cuttertoothcut]) { //,2.5-cuttertoothcut]) {
	    for (m=[0,1]) translate([cutterupsupport+cutterthickness-cuttertoothcutdepth+0.01,cutterlength+cutterbodyh+fromedge,z+cuttertoothh/2]) mirror([0,0,m]) hull() for (a=[-23,-45]) rotate([a,0,0]) cube([cuttertoothcutdepth,cuttertoothcut,cuttertoothh/2+1]);//triangle(cuttertoothcutdepth,cuttertoothcut,cuttertoothh/2,4);
	  }
	}
      }
    
    translate([cutterupsupport-cutterheadthickness+cutterthickness-0.1,cutterlength+cutterbodyh/2-cutterslith/2,-cutterslitw/2]) cube([cutterheadthickness+0.2,cutterslith,cutterslitw]);
    hull() {
      for (x=[-cutterheadthickness-0.1,0.01]) {
	xx=cutterthickness+cutterupsupport;
	translate([xx+x,cutterlength+cutterbodyh/2-cutterslith/3+x,-cutterslitw/2]) cube([0.1,cutterslith+cutterheadthickness+(cutterheadthickness-cutterthickness)-4,cutterslitw]);
      }
    }
    hull() {
      translate([cutterupsupport+1-0.1,cutterlength+cutterbodyh/2-cutterslith/2,-cutterslitw/2]) cube([1+0.1,cutterslith,cutterslitw]);
      translate([cutterupsupport+cutterthickness,cutterlength+cutterbodyh/2-cutterslith/2,-cutterslitw/2]) cube([0.1,cutterslith+1,cutterslitw]);
    }

    for (z=[0:cutterld*2:cutterwidth/2-cutterld]) {
      hull() {
	translate([cutterupsupport-cutterheadthickness+cutterthickness-0.1,widecut,z]) rotate([0,90,0]) cylinder(d=cutterld,h=cutterheadthickness+0.2);
	translate([cutterupsupport-0.1-wall,narrowcut,z*factor]) rotate([0,90,0]) cylinder(d=sd,h=cutterthickness+wall+0.2);
      }

      hull() {
	translate([cutterupsupport-cutterheadthickness+cutterthickness-0.1,widecut,-z]) rotate([0,90,0]) cylinder(d=cutterld,h=cutterheadthickness+0.2);
	translate([cutterupsupport-0.1-wall,narrowcut,-z*factor]) rotate([0,90,0]) cylinder(d=sd,h=cutterthickness+wall+0.2);
      }
    }

    hull() {
      translate([0,0,-cutteraxlel/2-0.1]) cylinder(d=cutteraxleind+dtolerance,h=cutteraxlel+0.2);
      translate([-(cutteraxleind+dtolerance)/2,-cutteraxleind/4,-cutteraxlel/2-0.1]) cube([0.1,cutteraxleind/2,cutteraxlel+0.2]);
    }

    translate([cutteraxleoutd/2+wall,-cutteraxleoutd/2,-(cutterattachw-wall*2)/2+wall]) lighten(cutterattachw/2-wall*3,cutterupsupport-cutteraxleoutd/2-wall*2,cutterattachw-wall,0,5,maxbridge,"left-xplane");
    translate([cutteraxleoutd/2+wall,-cutteraxleoutd/2,wall]) lighten(cutterattachw/2-wall*3,cutterupsupport-cutteraxleoutd/2-wall*2,cutterattachw-wall,0,5,maxbridge,"left-xplane");

    translate([cutterupsupport+textdepth-wall-0.01,cutteraxled*2+cornerd+textsize/2,0]) rotate([180,90,0]) linear_extrude(height = textdepth) text(text = str(versiontext), font = font, size = textsize, valign="center", halign="center");
  }
}
  
module roll() {
  translate([rollaxisheight,rollaxisdepth,holdersupportwidth]) difference() {
    cylinder(d=rolldiameteroutside,h=rollwidth);
    translate([0,0,-0.1]) cylinder(d=rolldiameterinside+wall*2,h=rollwidth+0.2);
  }
}

module holder() {
  difference() {
    union() {
      difference() {
	roundedbox(backplateheight,backplatedepth,backplatewidth,cornerd,3);

	// Lightening holes
	hull() {
	  translate([backplatedepth/2+rolldiameterinside+(rolldiameterinside-rollborewidth),backplatedepth+0.01,backplatedepth*2]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
	  translate([backplateheight*0.7-backplatedepth/2,backplatedepth+0.01,backplatedepth*2]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
	  for (x=[backplatedepth*2,backplateheight*0.85-backplatedepth/2]) 
	    for (z=[backplatedepth*2+rollwidth/4,backplatedepth*2+rollwidth*(2/4)])
	      translate([x,backplatedepth+0.01,z]) rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);

	  translate([backplateheight*0.5-backplatedepth/2-maxbridge/2,-0.01,backplatedepth*2+rollwidth-backplatedepth*2.5-1]) cube([maxbridge,backplatedepth+0.02,1]);// rotate([90,0,0]) cylinder(h=backplatedepth+0.02,d=backplatedepth);
	}
      }

      hull() {
	translate([backplatedepth/2,backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,0,$fn);
	translate([rollaxisheight,rollaxisdepth,0]) roundedcylinder(rolldiameterinside,holdersupportwidth,cornerd,0,$fn);
	translate([backplateheight-backplatedepth/2,backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,0,$fn);
      };

      translate([0,0,backplatewidth-holdersupportwidth])
	hull() {
	translate([backplatedepth/2,backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,1,$fn);
	translate([rollaxisheight,rollaxisdepth,0]) roundedcylinder(rolldiameterinside,holdersupportwidth,cornerd,1,$fn);
	translate([backplateheight-backplatedepth/2,backplatedepth/2,0]) roundedcylinder(backplatedepth,holdersupportwidth,cornerd,1,$fn);
      };

      // Left roll holder (female)
      translate([rollaxisheight,rollaxisdepth,0]) {
	difference() {
	  roundedcylinder(rolldiameterinside,holdersupportwidth+rolloverlapheight+rollnarrowingh-ztolerance*2,cornerd,1,$fn);
	  hull() {
	    translate([0,0,rolloverlapheight+rollnarrowingh-ztolerance]) roundedcylinder(rollnarrowingd,rollnarrowingh,cornerd,1,$fn);
	    translate([0,0,holdersupportwidth+rolloverlapheight+rollnarrowingh-ztolerance]) roundedcylinder(rolldiameterinside,rollnarrowingh,cornerd,1,$fn);
	  }
	}
      }

      translate([cutteraxleheight,cutteraxledepth,holdersupportwidth-cornerd]) roundedcylinder(cutteraxleoutd,cutteraxlesupportl+cornerd,cornerd,1,$fn);

      hull() {
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+cutteraxlesupportl-backplatedepth/2-0.1]) sphere(d=backplatedepth);
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+cutteraxlesupportl/2-cutteraxleoutd/2-0.1]) sphere(d=backplatedepth);
	translate([backplateheight-cutteraxleoutd/2,backplatedepth/2,holdersupportwidth+cutteraxlesupportl-cutteraxleoutd/2-0.1]) sphere(d=backplatedepth);
      }
  
      hull() {
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth-0.1]) roundedcylinder(cutteraxleind,cutteraxlesupportl+cutteraxlel-cutteraxleind/3-10,cornerd,1,$fn);
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth-0.1]) roundedcylinder(cutteraxleind/2,cutteraxlesupportl+cutteraxlel-10,cornerd,1,$fn);
      }
    }

    translate([2,10-textdepth+0.01,holdersupportwidth+2]) rotate([-90,270,0]) linear_extrude(height = textdepth+0.02) text(text = str(versiontext), font = font, size = textsize, valign="baseline");
    
    translate([2,holdersupportwidth+2-textdepth+0.01,holdersupportwidth+rollwidth+textdepth-0.01]) rotate([0,180,-90]) linear_extrude(height = textdepth) text(text = str(versiontext), font = font, size = textsize, valign="bottom", halign="left");
    
    translate([rollaxisheight,rollaxisdepth,-0.1]) {
      hull() {
	cylinder(h=holdersupportwidth+rolloverlapheight+0.2,d=rollborediameter);
	//	translate([0,0,rollwidth-rolltubew-holdersupportwidth-wall*2]) cylinder(h=rolltubenarrowing,d=rollborediameter-wall*2);
      }
    }
    if (0) translate([rollaxisheight,rollaxisdepth,-0.01]) {
      hull() {
	cylinder(h=rollwidth-holdersupportwidth-rolltubew-wall*2,d=rollborediameter);
	translate([0,0,rollwidth-rolltubew-holdersupportwidth-wall*2]) cylinder(h=rolltubenarrowing,d=rollborediameter-wall*2);
      }
    }

    translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph+rolloverlapnarrowingh+rolllockd/2]) rotate([0,0,90]) tubeclip(rolloverlapd+rolllockdepth,rolllockd,xtolerance);

    hull() {
      translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight]) rotate([0,0,90]) tubeclip(rolloverlapd+rolllockdepth,rolllockd,xtolerance*2);
      translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolllockd]) rotate([0,0,90]) tubeclip(rolloverlapd,rolllockd,xtolerance);
    }
    
    translate([screwrecessheight,screwrecessdepth,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);
    translate([screwrecessheight,screwrecessdepth,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);

    translate([screwrecessheight,-0.01,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter);
    translate([screwrecessheight,-0.01,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter);

    // Lightening holes in roll supports
    for (z=[0,rollwidth+backplatedepth]) {
      hull() {
	translate([backplatedepth/2+rolldiameterinside+(rolldiameterinside-rollborewidth),backplatedepth/2+backplatedepth,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
	translate([backplatedepth/2+rolldiameterinside+(rolldiameterinside-rollborewidth),rollaxisdepth-rolldiameterinside/2-backplatedepth/2,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
	translate([backplateheight*0.7,backplatedepth/2+backplatedepth,z-0.1]) cylinder(h=holdersupportwidth+0.2,d=backplatedepth);
      }
    }

    translate([cutteraxleheight,cutteraxledepth,0]) cylindervoids(cutteraxleind,cutteraxleind,holdersupportwidth+cutteraxlesupportl+cutteraxlel-cutteraxleind/3-10,0,0,1);
  }
}

module lockpin() {
  difference() {
    union() {
      hull() {
	translate([lockpinh/1.5,0,0]) roundedbox(lockpinl-lockpinh/1.5,lockpinh,lockpinw,cornerd);
	translate([lockpinh/3,0,lockpinw/4]) roundedbox(lockpinl-lockpinh/3,lockpinh,lockpinw-lockpinw/2,cornerd);
	translate([0,lockpinh/4,lockpinw/4]) roundedbox(lockpinl,lockpinh/2,lockpinw/2,cornerd);
      }
      minkowski(convexity=10) {
	render() union() {
	  difference() {
	    translate([lockpinhandleheight+lockpinhandlecornerd/2,lockpinhandlecornerd/2,lockpinw/2-lockpinhandlew/2+lockpinhandlecornerd/2]) cube([lockpinhandleh-lockpinhandlecornerd,lockpinhandlethickness-lockpinhandlecornerd,lockpinhandlew-lockpinhandlecornerd]);

	    translate([lockpinhandleheight+lockpinhandleh+lockpinhandlefingerd/2-lockpinhandlefingersink,lockpinhandlethickness/2,lockpinw/2-lockpinhandlew/2]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlew,$fn=30);
	    translate([lockpinhandleheight-lockpinhandlefingerd/2+lockpinhandlefingersink,lockpinhandlethickness/2,lockpinw/2-lockpinhandlew/2]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlew,$fn=30);
	    translate([lockpinhandleheight,lockpinhandlethickness/2,lockpinw/2-lockpinhandlew/2-lockpinhandlefingerd/2+lockpinhandlefingersink]) rotate([0,90,0]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlethickness,$fn=30);
	    translate([lockpinhandleheight,lockpinhandlethickness/2,lockpinw/2+lockpinhandlew/2+lockpinhandlefingerd/2-lockpinhandlefingersink]) rotate([0,90,0]) cylinder(d=lockpinhandlefingerd,h=lockpinhandlethickness,$fn=30);
	  }
	}

	sphere(d=lockpinhandlecornerd,$fn=30);
      }
    }
  
  translate([lockpinhandleheight+lockpinhandleh/2,lockpinhandlethickness-textdepth+0.01,lockpinw/2]) rotate([-90,270,0]) linear_extrude(height = textdepth) text(text = "Open", font = font, size = textsize - 1, valign="center", halign="center");

  translate([fingerlower,lockpinh-textdepth+0.01,lockpinw/2]) rotate([-90,180,0]) linear_extrude(height = textdepth) text(text = versiontext, font = font, size = max(textsize-2,lockpinw-2), valign="center", halign="center");
  }
}

module left() {
  difference() {
    holder();
    translate([-0.01,-0.01,holdersupportwidth+rollwidth-0.01]) cube([backplateheight+20+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+1],center=false);
    for (x=[fingerupper,fingerlower]) {
      // Finger holes
      hull() {
	translate([x-xtolerance,-0.01,holdersupportwidth+rollwidth-fingerwidth-ztolerance]) cube([fingerheight+xtolerance*2,0.01,fingerwidth+tolerance],center=false);
	translate([x-(backplatedepth-lockpinh)/2-xtolerance,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-fingerwidth-ztolerance]) cube([fingerheight+backplatedepth-lockpinh+xtolerance*2,lockpinh+ytolerance*2,fingerwidth+tolerance],center=false);
	translate([x-xtolerance,backplatedepth,holdersupportwidth+rollwidth-fingerwidth-ztolerance]) cube([fingerheight+xtolerance*2,0.01,fingerwidth+tolerance],center=false);
      }

      // Space for lock pin
      hull() {
	translate([backplateheight-lockpinextendl,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw-ztolerance]) cube([lockpinextendl+0.01,lockpinh+ytolerance*2,lockpinw+ztolerance*2]);
	translate([backplateheight,backplatedepth/2-lockpinextendh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw/2-lockpinextendw/2-ztolerance]) cube([0.01,lockpinextendh+ytolerance*2,lockpinextendw+ztolerance*2]);
      }
      translate([lockpinheight-xtolerance,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw-ztolerance]) cube([lockpinl+xtolerance*2,lockpinh+ytolerance*2,lockpinw+ztolerance*2]);

      // Temprary space for lock pin to put into while changing rolls
      z=screwrecessright-screwrecessdiameter/2-screwrecessdepth-lockpinw-ztolerance;
      translate([lockpinheight-xtolerance+z/2+screwrecessdepth,backplatedepth/2-lockpinh/2-ytolerance,z/2]) rotate([0,-45,0]) {
	cube([lockpinl+xtolerance*2,lockpinh+ytolerance*2,lockpinw+ztolerance*4]);
	hull() {
	  translate([lockpinl*2/3,0,0]) cube([lockpinextendl*2,lockpinh+ytolerance*2,lockpinw+ztolerance*4]);
	  translate([lockpinl*2/3+lockpinextendl*2,lockpinh/2-lockpinextendh/2,lockpinw/2-lockpinextendw/2-2]) cube([0.01,lockpinextendh+ytolerance*2,lockpinextendw+3]);
	}
      }
    }
  }
}

module right() {
  difference() {
    union() {
      difference() {
	holder();
	translate([-0.01,-0.01,-0.01]) cube([backplateheight+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+rollwidth+0.01],center=false);
      }

      for (x=[fingerupper,fingerlower]) {
	hull() {
	  translate([x,0,holdersupportwidth+rollwidth-fingerwidth+fingernarrowing]) roundedbox(fingerheight,cornerd,fingerwidth-fingernarrowing+cornerd,cornerd);
	  translate([x-(backplatedepth-lockpinh)/2,backplatedepth/2-lockpinh/2,holdersupportwidth+rollwidth-fingerwidth+fingernarrowing]) roundedbox(fingerheight+backplatedepth-lockpinh,lockpinh,fingerwidth-fingernarrowing+cornerd,cornerd);
	  translate([x,backplatedepth-cornerd,holdersupportwidth+rollwidth-fingerwidth+fingernarrowing]) roundedbox(fingerheight,cornerd,fingerwidth-fingernarrowing+cornerd,cornerd);

	  translate([x+1,0,holdersupportwidth+rollwidth-fingerwidth]) roundedbox(fingerheight-2,backplatedepth,fingernarrowing,cornerd);
	}
	
	// right roll holder (male)
	union() {
	  translate([rollaxisheight,rollaxisdepth,rolloverlapheight+ztolerance+rollnarrowingh]) {
	    hull() {
	      translate([0,0,rollnarrowingh]) roundedcylinder(rolldiameterinside,backplatewidth-rolloverlapheight-rollnarrowingh-ztolerance-holdersupportwidth,cornerd,2,$fn);
	      roundedcylinder(rollnarrowingd,rollnarrowingh,cornerd,0,$fn);
	    }
	  }

	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph]) {
	    hull() {
	      translate([0,0,rolloverlapnarrowingh]) roundedcylinder(rolloverlapd,rolloverlaph+wall,cornerd,1,$fn);
	      roundedcylinder(rolloverlapnarrowingd,rolloverlaph+wall,cornerd,1,$fn);
	    }
	  }

	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph+rolloverlapnarrowingh+rolllockd/2]) rotate([0,0,90]) tubeclip(rolloverlapd+rolllockdepth,rolllockd,0);
	  //	  translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rollwidth-rolltubew]) {
	  //translate([rollaxisheight,rollaxisdepth,rollwidth-holdersupportwidth]) {
	  //	    hull() {
	  //	      roundedcylinder(rolldiameterinside,rolltubew+cornerd,cornerd,0,$fn);
	  //	      translate([0,0,-holdersupportwidth]) roundedcylinder(rollborediameter,rolltubenarrowing,cornerd,0,$fn);
	  //	    }
	  //	  }
	}
    
      }

      translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-cutteraxlesupportl]) roundedcylinder(cutteraxleoutd,cutteraxlesupportl+cornerd,cornerd,0,$fn);

      hull() {
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-cutteraxlesupportl-0.1]) cylinder(d=backplatedepth,h=0.1);
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-0.1]) sphere(d=backplatedepth);
	translate([fingerupper+fingerheight/2-cornerd,backplatedepth-0.01,holdersupportwidth+rollwidth-fingerwidth+cornerd]) roundedbox(fingerheight/2,0.01,fingerwidth,cornerd);
      }
  
  
      hull() {
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-cutteraxlesupportl+cutteraxleind/3-10+ztolerance]) roundedcylinder(cutteraxleind,cutteraxlesupportl+10+0.1,cornerd,0,$fn);
	translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-cutteraxlesupportl-10+ztolerance]) roundedcylinder(cutteraxleind/2,cutteraxlesupportl+10+0.1,cornerd,0,$fn);
      }
    }
  
    // Space for lock pin
    translate([lockpinheight-xtolerance,backplatedepth/2-lockpinh/2-ytolerance,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw-ztolerance]) cube([lockpinl+xtolerance*2,lockpinh+ytolerance*2,lockpinw+ztolerance*2]);

    // Right roll insides cut
    union() {
      translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight+rollnarrowingh]) {
	hull() {
	  translate([0,0,wall]) cylinder(h=rollwidth+holdersupportwidth-rolloverlapheight-rollnarrowingh-wall+0.1,d=rollborediameter);
	  translate([0,0,-holdersupportwidth+rolltubenarrowing/2]) cylinder(h=rolltubenarrowing-wall,d=rolloverlapd-wall*2);
	}
      }

      translate([rollaxisheight,rollaxisdepth,holdersupportwidth+rolloverlapheight-rolloverlaph]) {
	hull() {
	  translate([0,0,rolloverlapnarrowingh]) roundedcylinder(rolloverlapd-wall*2,rolloverlaph+0.1,cornerd,1,$fn);
	  translate([0,0,wall]) roundedcylinder(rolloverlapnarrowingd-wall,rolloverlaph,cornerd,1,$fn);
	}
      }
    }

    translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth-cutteraxlesupportl+cutteraxleind/3-10+ztolerance]) cylindervoids(cutteraxleind,cutteraxleind,holdersupportwidth+cutteraxlesupportl-cutteraxleind/3+10-ztolerance,0,0,1);

    translate([rollaxisheight-rolllockd/2,rollaxisdepth-rolloverlapd/2,holdersupportwidth+rolloverlapheight-rolloverlaph+rolloverlapnarrowingh-0.1]) {
      for (x=[-rolllockcut,rolllockd]) {
	translate([x,0,0]) cube([rolllockcut,rolloverlapd,rolloverlaph-rolloverlapnarrowingh]);
      }
      hull() {
	translate([-rolllockcut,0,0]) cube([rolllockcut,rolloverlapd,rolllockcut]);
	translate([rolllockd/2-rolllockcut/2,0,-rolllockd/2]) cube([rolllockcut,rolloverlapd,rolllockcut]);
      }
      hull() {
	translate([rolllockd,0,0]) cube([rolllockcut,rolloverlapd,rolllockcut]);
	translate([rolllockd/2-rolllockcut/2,0,-rolllockd/2]) cube([rolllockcut,rolloverlapd,rolllockcut]);
      }
    }
  }
}

if (print==0) {
  intersection() {
    difference() {
      union() {
	left();
	right();
	translate([lockpinheight,backplatedepth/2-lockpinh/2,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw]) lockpin();

	//cutangles=[20,30,40,48];
	cutangles=[65,38]; // 38
	for (cutterangle=cutangles) {
	  translate([cutteraxleheight,cutteraxledepth,holdersupportwidth+rollwidth/2]) rotate([0,0,cutterangle]) cutter();
	}
      }

      //      roll();
    }
    
    //if (dodebug) translate([0,backplatedepth/2,0]) cube([1000,1000,1000]);
    if (dodebug) translate([0,0,0]) cube([rollaxisheight,1000,1000]);
    //if (dodebug) translate([0,0,0]) cube([cutteraxleheight,cutteraxledepth,1000]);
    //if (dodebug) translate([0,0,0]) cube([1000,1000,holdersupportwidth+rollwidth-lockpinfromedge-lockpinw/2]);
  }
 }

if (print == 1) {
  rotate([0,0,90]) left();
 }


if (print == 2 || print == 3) {
  rotate([0,0,90]) translate([-backplateheight/2,-rolldiameteroutside/2,0]) union() {
  
    translate([rollaxisheight*2+rolldiameterinside+70,backplatewidth-rolldiameterinside-9+lockpinw,backplatewidth]) rotate([180,0,-70.5]) right();
  }
 }

if (print == 3) {
  rotate([0,0,90]) {
    difference() {
      union() {
	translate([-backplateheight/2,-rolldiameteroutside/2,0]) union() {
	  left();
  
	  translate([rollaxisheight*2+rolldiameterinside+70,backplatewidth-rolldiameterinside-9+lockpinw,backplatewidth]) rotate([180,0,-70.5]) right();
	}
      }
    
      #    printareacube("ankermake");
    }
  }
 }

if (print==3 || print==4) {
  rotate([0,0,90]) translate([-20,-7,0]) rotate([90,0,0]) rotate([0,75+70-0.3,0]) translate([-102,0,0]) lockpin();
 }

if (print==5) {
  shift=90;//89;
  difference() {
    translate([shift,-shift,0]) rotate([0,0,45]) translate([0,0,cutterupsupport+cutterheadthickness-cutterthickness]) rotate([0,90,0]) {
      intersection() {
	cutter();
	if (debug) cube([1000,1000,1000]);
      }
    }
#    printareacube("ankermake");
  }
 }
