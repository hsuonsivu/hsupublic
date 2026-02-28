// Copyright 2023,2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=2;
debug=0;

// 0: Make a complex version with locking mechanism
// 1: Make a simple version, with no locking mechanism
simple=0;

// Full version, includes all material saving holes (very slow in openscad - render before rotating view)
full=1;

// Holes are through for better cooling.
throughholes=1;

// One of our cases has metal clips holding the drives. Replace outside locks with guides with clip
guideversion=1;

// Enable pushers and holder separately (pushers only print with non-simple version)
springpushers=1;
holder=1;

maxbridge=10;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

sidewall=2.4;

// 15,26,135 150
guideclipx=15;
guidex=26;
guidel=150-guidex;
guidenarrowingl=150-135;
guidesloty=-0.7;
guideh=20.6;
guidewall=1.6; // Measured about 0.8-1, metal
//guidel=123; //124
//guidenarrowingl=16;
guidenarrowingh=16.6;
guideclipw=7.75;
guidecliph=10;
guideclipl=13;//11.85;
guidecliphandlel=12;
guidecliphandled=3;
guideclipdepth=3.5;
//guidex=25;//24.45; // Not including clip
guidew=5;
guidecornerd=1;
guideclipwall=1.6;
guideclipattachx=guidex+guideclipwall;
guideclipattachl=30;
guideclipcornerd=guideclipwall;
guideclipcut=0.5;
guideclipcutl=20;
//guidecliplockdepth=1;
//guidecliplockd=guidecliplockdepth+guideclipwall;
guidecliplockh=6;
guidecliplockl=5;
//guidecliplockx=guidex+guideclipattachl-guidecliplockd/2;
guidecliplockx=guideclipattachx+guideclipattachl-8;
//guidecliplocky=guidesloty+guidecliplockd/2;
guidecliplocky=guidesloty+guideclipwall+ytolerance;
guidecliplockcutl=15;
guideslotoutw=guideclipwall+ytolerance+guideclipwall+ytolerance+guideclipwall;

// Short or long version
short=1;

// Width locking keys as multiple of screw diameter
keywidthmultiplier=1.60;

versiontext="V2.8";
textsize=8;

length=short?170:198; // Shorter version 17.05, long version 19.8;

outsideincornerd=6;
outsidecornerd=outsideincornerd+sidewall*2;
cornerd=2;
printable=7;
lockprintable=4;

width=146;
height=40;//41.8;
outscrewztable=[10,22.5];
outscrewxtable=[52.3,131.93];
outscrewdiameter=2.8;
outscrewbase=0.1;
outscrewspringlength=25;
outscrewspringheight=outscrewdiameter*keywidthmultiplier;
outscrewspringangle=simple?0:3;
springgap=0.7;

guideheight=(outscrewztable[0]+outscrewztable[1])/2; // Center of guide

disklength=147;
diskwidth=102.7;
diskheight=26; // max height can be up to 41.2 but that is also 5.25 max height - needs to be two separate parts in that case
diskxposition=length-disklength+2;
diskyposition=width/2-diskwidth/2;
diskentrywidth=diskwidth; //105;

bottomthickness=2.4;
bottomthin=0.8;
roofthickness=2.4;
roofthin=0.8;
sidebottomthickness=bottomthickness;
sideroofthickness=roofthickness;
diskscrewheight=bottomthickness+6.7;
olddiskscrewheight=6.7;
diskscrewxtable=[16.52,76.71,118.19];
diskscrewdiameter=3;
diskscrewbase=outscrewbase;
diskscrewspringlength=25;
diskscrewspringheight=diskscrewdiameter*keywidthmultiplier;
diskscrewspringangle=simple?0:3;

// Kludge: this is used for both angles even though they are
// independent. Likely best to simply remove independence.
keyanglel=sidewall*sin(diskscrewspringangle)+0.01;

//springpusherextra=5.3; // How much wider pusher needs to be to have strong enough sides at openings.
outlockextrah=5.5;
disklockextrah=6.0;
airholediameterx=35;
airholediametery=20;
airholedistancex=10;
airholedistancey=10;
airholesx=floor((length-airholedistancex)/(airholediameterx+airholedistancex));
airholesy=floor(diskwidth/(airholediametery+airholedistancey));
airholeslength=airholesx*airholediameterx+(airholesx-1)*airholedistancex;
airholeswidth=airholesy*airholediametery+(airholesy-1)*airholedistancey;
airholexstart=length/2-airholeslength/2;
airholeystart=width/2-airholeswidth/2;

sidecutwidth=width/2-diskwidth/2-2*sidewall;
sidecutheight=height-sidebottomthickness-sideroofthickness;

lockwall=2;

sideairholediameterx=38;
sideairholediametery=14;
sideairholedistancex=7;
sideairholedistancey=7;
sideairholesx=floor(length/(sideairholediameterx+sideairholedistancex));
sideairholesy=floor(diskwidth/(sideairholediametery+sideairholedistancey));
sideairholeslength=sideairholesx*sideairholediameterx+(sideairholesx-1)*sideairholedistancex;
sideairholeswidth=sideairholesy*sideairholediametery+(sideairholesy-1)*sideairholedistancey;
sideairholexstart=length/2-sideairholeslength/2;
sideairholeystart=width/2-sideairholeswidth/2;

sidetopairholediameterx=38;
sidetopairholediametery=11;
sidetopairholedistancex=7;
sidetopairholedistancey=7;
sidetopairholesx=floor(length/(sidetopairholediameterx+sidetopairholedistancex));
sidetopairholesy=floor(diskwidth/(sidetopairholediametery+sidetopairholedistancey));
sidetopairholeslength=sidetopairholesx*sidetopairholediameterx+(sidetopairholesx-1)*sidetopairholedistancex;
sidetopairholeswidth=sidetopairholesy*sidetopairholediametery+(sidetopairholesy-1)*sidetopairholedistancey;
sidetopairholexstart=length/2-sidetopairholeslength/2;
sidetopairholeystart=sidewall+sidecutwidth/2-sidetopairholediametery/2; //width/2-sidetopairholeswidth/2;

outlockl=outscrewxtable[1]+outscrewdiameter*2;//outscrewspringheight; //outscrew2position + outscrewspringheight;
disklockl=diskxposition+diskscrewxtable[2]+diskscrewdiameter*2;//diskscrewspringheight;
lockthickness=2.5;//5;
springpushergap=0.6;//1;
springpusherwall=2;
springpusherbottom=1.5;
springpusherroof=1.5;

lockhandlel=10;
lockhandlethickness=7;

outlockcuth=outscrewspringheight+outlockextrah+springpushergap;

outlockh=outscrewspringheight+outlockextrah;
outlockcutw=lockthickness+springpushergap;
  
disklockh=diskscrewspringheight+disklockextrah;
disklockcutw=lockthickness+springpushergap;
disklockcuth=diskscrewspringheight+disklockextrah+springpushergap;

outlockcoverbottom=outscrewztable[0]-outlockcuth/2-lockwall;

// this probably should be calculated from springpushergap; This adjusts steepness of raise behing screwhole insert.
keysupportadjust=0.5;

// Extra length for the hole to allow releasing springpusher in the wrong hole :/
keycutextra=4;
textdepth=0.5;

sidefreez=height-sideroofthickness-diskscrewheight-disklockcuth/2-lockwall;
sideairholezstart=height-sideroofthickness-sidefreez/2-sideairholediametery/2;

module tappi(screwdiameter,screwbase) {
  cylinder(h=screwbase,d=screwdiameter,$fn=30);
  translate([0,0,screwbase-0.01]) sphere(d=screwdiameter,$fn=30);
}

module key(keylength,keywidth,keythickness,keyscrewdiameter,keyscrewdepth) {
  translate([-keyanglel,-keywidth/2,0]) union () {
    cube([keylength+keyanglel,keywidth,keythickness]);
    translate([keylength+keyanglel,keywidth/2,0]) cylinder(h=keythickness,d=keywidth, $fn=30);
    translate([keylength+keyanglel,keywidth/2,keythickness]) tappi(keyscrewdiameter,keyscrewdepth);
    if (!simple) {
      translate([keylength+keyanglel,keywidth/2,0.5]) resize([0,0,springpushergap+sidewall-0.5]) sphere(d=keywidth,$fn=30);
    }
  }
}

// This is centered on key
module keycut(keycutlength,keycutwidth,keycutthickness) {
  translate([-0.01,-springgap-keycutwidth/2,-0.01]) cube([keycutlength+keycutextra+springgap*2+0.02,keycutwidth+springgap*2,keycutthickness+0.02]);
  translate([keycutlength+keycutextra+springgap*2,-springgap-keycutwidth/2,0]) intersection() {
    dia=keycutwidth+springgap;
    diaroot=sqrt(dia)*2;
    translate([0,0,-0.01]) rotate([0,0,45]) cube([diaroot,diaroot,keycutthickness+0.02]);
    translate([0,0,-0.01]) cube([keycutwidth/2+springgap*2,keycutwidth+0.02+springgap*2,keycutthickness+0.02]);
  }
}

module holvicut(x,y,z) {
  hull() {
    topw=y>maxbridge?maxbridge:y;
    toph=y>maxbridge?(y-topw)/2:0;
    
    translate([0,0,-0.01]) cube([x-toph,y,z+0.02]);
    translate([x-toph,y/2-topw/2,-0.01]) cube([toph,topw,z+0.02]);
  }
}

//tappi();

//rotate([0,outscrewspringangle,0]) translate([-30,0,0]) key(20,6,2,3,0.3);
//translate([-30,0,-3]) keycut(20,6,2);

module guideclipshape(p) {
  translate([0,0,-guidecliph/2]) roundedbox(guideclipwall,guideclipwall,guidecliph,guideclipcornerd,p);
}

module guideclip() {
  difference() {
    union() {
      hull() {
	translate([guideclipattachx-guideclipwall,guidesloty+guideclipwall+ytolerance,0]) guideclipshape(1);
	translate([guideclipattachx+guideclipattachl-guideclipwall,guidesloty+guideclipwall+ytolerance,0]) guideclipshape(1);
      }
      hull() {
	translate([guideclipattachx-guideclipwall,guidesloty+guideclipwall+ytolerance,0]) guideclipshape(1);
	translate([guideclipx,-guideclipw-guideclipwall,0]) guideclipshape(1);
      }
      hull() {
	translate([guideclipx,-guideclipw-guideclipwall,0]) guideclipshape(1);
	translate([guideclipx-guideclipdepth/3,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
      }
      hull() {
	translate([guideclipx-guideclipdepth/3,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
	translate([0,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
      }
      hull() {
	for (x=[-guideclipcornerd/2,0]) {
	  translate([x,guideclipdepth-guideclipw-guideclipwall,0]) guideclipshape(1);
	  translate([x,-guideclipw-guideclipwall,0]) guideclipshape(1);
	}
      }
    }

    //    translate([guidecliplockx,guidecliplocky,0]) sphere(d=guidecliplockd+dtolerance,$fn=90);
    translate([guidecliplockx-0.01,guidecliplocky-0.01,-guidecliplockh/2-0.01]) cube([guidecliplockl+0.02,guideclipwall+0.02,guidecliplockh+0.02]);

    translate([guideclipattachx+1,guidesloty+guideclipwall+ytolerance+textdepth-0.01,0]) rotate([90,0.0]) linear_extrude(height=textdepth) text(versiontext,size=min(textsize,guidecliph-guideclipcornerd-1)-1,halign="left",valign="center");
  }
}

module guide() {
  w=ytolerance+guideclipwall+ytolerance+guideclipwall;
  
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) {
	  hull() {
	    translate([guidex,-guidew,-guideh/2]) roundedbox(guidel-guidenarrowingl,guidew+guidewall,guidewall,guidecornerd);
	    translate([guidex-guidew,0,-guideh/2]) roundedbox(guidel-guidenarrowingl,guidewall,guidewall,guidecornerd);
	  }
	  hull() {
	    translate([guidex+guidel-guidenarrowingl-guidecornerd,-guidew,-guideh/2]) roundedbox(guidecornerd,guidew+guidewall,guidewall,guidecornerd);
	    translate([guidex+guidel-guidecornerd,-guidew,-guidenarrowingh/2]) roundedbox(guidecornerd,guidew+guidewall,guidewall,guidecornerd);
	  }
	}

      hull() {
	translate([guideclipattachx,guidesloty,-guidecliph/2-ztolerance-guideclipwall]) roundedbox(guideclipattachl+guideclipwall*2+xtolerance,guideslotoutw,guideclipwall+ztolerance+guidecliph+ztolerance+guideclipwall,guideclipcornerd,0);
	translate([guidex+guideclipwall-guideslotoutw/2,guidesloty+guideslotoutw/2-guideclipcornerd/2,-guidecliph/2-ztolerance-guideclipwall]) roundedbox(guideclipattachl,guideclipcornerd,guideclipwall+ztolerance+guidecliph+ztolerance+guideclipwall,guideclipcornerd,0);
      }

      translate([0,-1.2,-guidecliph/2-0.8]) cube([0.6,1.4,0.4]);
      translate([0,-1.2,-guidecliph/2-0.8]) cube([0.6,0.4,guidecliph+0.8*2]);
      translate([0,-1.2,guidecliph/2+0.4]) cube([0.6,1.4,0.4]);
    }
  }
}

module guidecut() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) {
	  translate([guideclipattachx+guideclipattachl-guideclipcutl,guidesloty-0.01,-guidecliph/2-guideclipcut]) cube([guideclipcutl+guideclipcut,guideclipwall+0.02,guideclipcut]);
	}
      hull() {
	h=guidecliph+guideclipcut*2;
	xd=h>maxbridge?(h-maxbridge)/2:0;
	
	translate([guideclipattachx+guideclipattachl,guidesloty-0.01,-guidecliph/2-guideclipcut]) cube([guideclipcut,guideclipwall+0.02,guideclipcut+guidecliph+guideclipcut]);
	translate([guideclipattachx+guideclipattachl+xd,guidesloty-0.01,-maxbridge/2]) cube([guideclipcut,guideclipwall+0.02,maxbridge]);
      }
      
      translate([-0.01,guidesloty-0.01,-guidecliph/2-ztolerance]) cube([guidex+guideclipwall,guideslotoutw+0.02,ztolerance+guidecliph+ztolerance]);
      translate([-0.01,guidesloty+guideclipwall,-guidecliph/2-ztolerance]) cube([guideclipattachx+guideclipwall+guideclipattachl,ytolerance+guideclipwall+ytolerance,ztolerance+guidecliph+ztolerance]);
    }
    //translate([guidecliplockx,guidecliplocky,0]) sphere(d=guidecliplockd,$fn=90);
    hull() {
      translate([guidecliplockx+xtolerance,guidesloty,-guidecliplockh/2+ztolerance]) cube([guidecliplockl-xtolerance*2,guideclipwall,guidecliplockh-ztolerance*2]);
      translate([guidecliplockx+xtolerance+guidecliplockl-xtolerance*2-1,guidesloty,-guidecliplockh/2+ztolerance+guideclipwall]) cube([1,guideclipwall+ytolerance+guideclipwall,guidecliplockh-ztolerance*2-guideclipwall*2]);
    }
  }
}

module halfholder() {
  disky = width/2-diskwidth/2-sidewall;

  union() {
    difference() {
      union() {
	difference() {
	  intersection() {
	    translate([-outsidecornerd/2,0,0]) roundedbox(length+outsidecornerd/2+cornerd,width,height,outsidecornerd,printable);
	    cube([length,width,height]);
	  }
	  translate([diskxposition-0.01,width/2-diskwidth/2,bottomthickness]) cube([disklength+0.02,diskwidth,height-bottomthickness-roofthickness]);
	  translate([-0.01,width/2-diskentrywidth/2,bottomthickness]) cube([diskxposition+0.02,diskentrywidth,height-bottomthickness-roofthickness]);
	  if (diskxposition+disklength>length) {
	    translate([diskxposition+disklength-0.01,width/2-diskentrywidth/2,bottomthickness]) cube([length-diskxposition-disklength+1,diskentrywidth,height-bottomthickness-roofthickness]);
	  } else {
	    echo("Disk is recessed in the case, this is bad for cabling.");
	  }

	  translate([-0.01-outsideincornerd,sidewall,sidebottomthickness]) roundedbox(length+outsideincornerd*2+0.02,sidecutwidth,sidecutheight,outsideincornerd,0);
	  translate([-0.01,sidewall+sidecutwidth-outsideincornerd,sidebottomthickness]) cube([length+outsideincornerd*2+0.02,outsideincornerd,outsideincornerd/2]);

	  if (full) {
	    zstart=throughholes?-0.01:bottomthin;
	    zend=throughholes?height+0.02:height-bottomthin-roofthin;
	    
	    for(x=[0:1:airholesx-1]) {
	      for(y=[0:1:floor((airholesy+1)/2)]) {
		translate([airholexstart+x*(airholediameterx+airholedistancex),airholeystart+y*(airholediametery+airholedistancey),zstart]) holvicut(airholediameterx, airholediametery, zend);
	      }
	    }

	    for(x=[0:1:sidetopairholesx-1]) {
	      translate([sidetopairholexstart+x*(sidetopairholediameterx+sidetopairholedistancex),sidetopairholeystart,height-sideroofthickness-0.01]) holvicut(sidetopairholediameterx,sidetopairholediametery,sideroofthickness+1);
	    }

	    for(x=[0:1:sideairholesx-1]) {
	      translate([sideairholexstart+x*(sideairholediameterx+sideairholedistancex),sidecutwidth+sidewall*2,sideairholezstart]) rotate([90,0,0]) holvicut(sideairholediameterx,sideairholediametery,sidecutwidth+sidewall-1);
	    }
	  }
	}

	if (guideversion) {
	  translate([0,0.01,guideheight]) guide();
	}

	if (!simple) {
	  if (!guideversion) {
	    translate([0,sidewall/2,outlockcoverbottom]) roundedbox(outlockl,sidewall/2+lockthickness+springpushergap+0.01+springpusherwall,outscrewztable[1]+outlockcuth/2+lockwall-outlockcoverbottom,cornerd,printable);
	  }
	  translate([0,sidewall+sidecutwidth-lockthickness-springpushergap-springpusherwall,diskscrewheight-disklockcuth/2-springpusherwall]) roundedbox(disklockl,lockwall+lockthickness+springpushergap+0.01+lockwall,lockwall+disklockcuth+lockwall,cornerd,printable);
	}
      }

      if (!simple) {
	if (!guideversion) for (z=outscrewztable) {
	  translate([-0.01,sidewall,z-outlockcuth/2]) cube([outlockl+0.02,lockthickness+springpushergap,outlockcuth]);
	  hull() {
	    translate([lockhandlel+lockthickness+lockwall,sidewall+lockthickness+springpushergap-0.01,z-outlockcuth/2]) triangle(outlockcuth+xtolerance,springpusherwall+0.02,outlockcuth,1);
	    translate([-0.01,sidewall+outlockcutw-0.01,z-outlockcuth/2]) cube([1,lockwall+0.02,outlockcuth]);
	  }
	}
	translate([-0.01,sidewall+sidecutwidth-lockthickness-springpushergap,diskscrewheight-disklockcuth/2]) cube([disklockl+0.02,lockthickness+springpushergap,disklockcuth]);
	hull() {
	  translate([lockhandlel,sidewall+sidecutwidth-disklockcutw-lockwall,diskscrewheight-disklockcuth/2]) triangle(disklockcuth+xtolerance,lockwall+0.02,disklockcuth,1);
	  translate([-0.01,sidewall+sidecutwidth-disklockcutw-lockwall,diskscrewheight-disklockcuth/2]) cube([1,lockwall+0.02,disklockcuth]);
	}
	h=min(outscrewztable[0],diskscrewheight);
	hull() {
	  translate([-0.01,sidewall,sidebottomthickness+h]) cube([0.01+lockhandlel-2,sidecutwidth,sidecutheight-h-outsideincornerd/2]);
	  translate([sidecutwidth/2+lockhandlel-1,sidewall+sidecutwidth/2,sidebottomthickness+h]) cube([0.01,0.01,sidecutheight-h-outsideincornerd/2]);
	}
      }
      
      translate([sidewall+diskxposition,width-(width/2-diskwidth/2-2*sidewall)-sidewall,sidebottomthickness]) cube([disklength-2*sidewall,width/2-diskwidth/2-2*sidewall,height-sidebottomthickness-sideroofthickness+20]);

      if (!guideversion) for (z=outscrewztable) {
	for (x=outscrewxtable) {
	  translate([x-outscrewspringlength,0,z]) rotate([270,0,0]) keycut(outscrewspringlength,outscrewspringheight,sidewall);
	}
      }
      
      if (guideversion) translate([0,0,guideheight]) guidecut();
      
      for (x=diskscrewxtable) {
	translate([diskxposition+x-diskscrewspringlength,disky,diskscrewheight]) rotate([270,0,0]) keycut(diskscrewspringlength,diskscrewspringheight,sidewall);
      }

      translate([-0.01,width/2+0.01,-0.01]) cube([length+0.02,width,height+0.02]);
    }

    if (!guideversion) {
      for (z=outscrewztable) {
	for (x=outscrewxtable) {
	  translate([x-outscrewspringlength,sidewall,z]) rotate([90,0,outscrewspringangle]) key(outscrewspringlength,outscrewspringheight,sidewall,outscrewdiameter,outscrewbase);
	}
      }
    }
    
    for (x=diskscrewxtable) {
      translate([diskxposition+x-diskscrewspringlength,sidecutwidth+sidewall,diskscrewheight]) rotate([270,0,-diskscrewspringangle]) key(diskscrewspringlength,diskscrewspringheight,sidewall,diskscrewdiameter,diskscrewbase);
    }
  }
}

module holder() {
  if (holder) {
    difference() {
      union() {
	halfholder();
	translate([0,width,0]) mirror([0,1,0]) halfholder();
      }
      translate([2,width-(width-diskwidth)/2-2,bottomthickness-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="left");
      translate([2,width-outsidecornerd,height-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="left");
      slotnumbersize=lockthickness+springpusherwall+1;

      if (!simple) {
	w=lockthickness+springpushergap+0.01+springpusherwall;
	translate([1,width-sidewall-w/2,outscrewztable[0]-outlockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("1",size=slotnumbersize,halign="center");
	translate([1,width-sidewall-sidecutwidth+w/2,diskscrewheight-disklockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("2",size=slotnumbersize,halign="center");
	translate([1,sidewall+sidecutwidth-w/2,diskscrewheight-disklockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("3",size=slotnumbersize,halign="center");
	translate([1,sidewall+w/2,outscrewztable[0]-outlockcuth/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("4",size=slotnumbersize,halign="center");
      }
    }
  }
}

locktable=[[0,1],
	   [1,0],
	   [0,0],
	   [1,1]
	   ];

module lockbody(i) {
  rotate=locktable[i][0];
  out=locktable[i][1];
  h=out?outlockh:disklockh;
  
  if (out) {
    hull() {
      translate([0,0,-h/2]) roundedbox(outlockl,lockthickness,h,cornerd,lockprintable);
      translate([0,lockthickness-1,-h/2+cornerd/2]) roundedbox(outlockl+lockthickness-0.5,1,h-cornerd,cornerd,lockprintable);
    }
  } else {
    hull() {
      translate([0,0,-h/2]) roundedbox(disklockl,lockthickness,h,cornerd,lockprintable);
      translate([0,lockthickness-1,-h/2+cornerd/2]) roundedbox(disklockl+lockthickness-0.5,1,h-cornerd,cornerd,lockprintable);
    }
  }
  translate([0,0,-h/2]) roundedbox(lockhandlel,lockhandlethickness,h,cornerd,lockprintable);
  hull() {
    translate([lockhandlel-0.01,lockthickness-0.01,-h/2+cornerd/2]) cube([0.8+0.01,lockwall+0.01,h-cornerd]);
    translate([lockhandlel+0.8,lockthickness-0.01,-h/2+cornerd/2]) triangle(h-cornerd,lockwall+0.01,h-cornerd,rotate==0?2:1);
  }
}

module lockspringcut(x,d,sl,sh) {
  hull() {
    translate([x+d*2+1,lockthickness,-sh/2-springpushergap]) cube([sl+d*2,0.1,sh+springpushergap*2]);
    translate([x+d*2,lockthickness-0.3,-sh/2-springpushergap]) cube([sl+d*2,0.51,sh+springpushergap*2]);
  }
  translate([x+d*2,-0.01,-sh/2-springpushergap]) cube([sl+d*2,lockthickness+0.02,sh+springpushergap*2]);
  hull() {
    translate([x+d*2-1,-0.01,-sh/2-springpushergap]) cube([sl+d*2,lockthickness+0.02,sh+springpushergap*2]);
    translate([x+d*2+sl+d+lockthickness-1,-0.01,-sh/2-springpushergap]) triangle(lockthickness*2+0.02,lockthickness+0.02,sh+springpushergap*2,5);
  }
}

module lock(i) {
  t=str(i+1);
  rotate=locktable[i][0];
  out=locktable[i][1];
  h=out?outlockh:disklockh;

  difference() {
    union() {
      lockbody(i);
    }

    translate([lockhandlethickness+lockhandlel+cornerd,lockthickness-textdepth+0.01,0]) rotate([90,rotate?0:180,180]) linear_extrude(height=textdepth) text(versiontext,size=h-4,halign=rotate?"right":"left",valign="center");
    if (out) {
      for (x=outscrewxtable) {
	if (x<outlockl-10) lockspringcut(x,outscrewdiameter,outscrewspringlength,outscrewspringheight);
      }
    } else {
      for (x=diskscrewxtable) {
	if (x<disklockl-diskxposition-10) lockspringcut(diskxposition+x,diskscrewdiameter,diskscrewspringlength,diskscrewspringheight);
      }
    }
    translate([lockhandlel/2,-0.1,-h/2-1]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([lockhandlel/2,-0.1,-h/2+1+h]) rotate([-90,0,0]) cylinder(h=lockhandlethickness+0.2,d=lockhandlethickness,$fn=30);
    translate([textdepth-0.01,lockhandlethickness/2,0]) rotate([90,rotate?0:180,-90]) linear_extrude(height=textdepth) resize([lockhandlethickness-3,0,0]) text(t,size=h-3,halign="center",valign="center");
  }
}

// springpushersticks
module springpushersticks() {
  if (!simple && springpushers) {
    //out
    for (i=(guideversion?[1:1:2]:[0:1:3])) {
      translate([0,0,height+outlockh/2+1+(guideversion?i-1:i)*(max(outlockh,disklockh)+1)]) lock(i);
    }
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([-100,-100,-100]) cube([1000,1000,100+guideheight]);
    union() {
      holder();
      if (!guideversion) {
	translate([0,sidewall+springpushergap,outscrewztable[0]]) rotate([0,0,0]) lock(3);
      }
      translate([0,sidewall+sidecutwidth-springpushergap,diskscrewheight]) rotate([180,0,0]) lock(2);
      translate([0,0,guideheight]) guideclip();
      //translate([0,-10,0]) lock(3);
    }
  }
 }

if (print==1 || print==3) {
  rotate([0,0,90]) {
    translate([width,0,0]) rotate([0,-90,90]) holder();
  }
 }

if (print==2 || print==3) {
  rotate([0,0,0]) {
    rotate([90,0,90]) springpushersticks();
  }
 }

if (guideversion) {
  if (print==4 || print==1) {
    translate([guidew+sidewall-guidesloty+guideslotoutw+0.5,sidewall+sidecutwidth+sidewall+0.5+guideclipwall,guidecliph/2]) rotate([0,0,90]) {
      translate([0,0,0]) guideclip();
      translate([0,guidew+0.5,0]) guideclip();
    }
  }
 }
