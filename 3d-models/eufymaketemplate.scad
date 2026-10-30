// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Template form for Eufymake UV printer, small. This is intended to
// be used as part from which you substract any parts you need to be
// stay fixed, not stand-alone.

// Note: This is centered to the print area, not edges of the base.
// Height is base height.

include <hsu.scad>

// 1 full size, non-split versionfor large printers, plain
// 2 plain 
// 3 round d=90mm + one rectangle 50x70mm
// 4 6 rectangles 50x70mm
// 5 thin squares 65mm
// 6 thin squares 55mm
// 7 thin rectangles 55x75mm
// 8 thin rectangles 55x95mm

print=3;
debug=0;

// This will make separate templates which can be installed on top of
// plain versions, this saves printing time.
separatetemplates=0;

maxbridge=10;
layerh=0.2;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

// Split, thickness, rounds,rectangles,diameter,x,y,splity,gapbetween
sizetable=[[1,1,1.8,1.8,0,0, 0, 0, 0,    0, 0], // 0, full model for development
	   [0,1,1.8,1.8,0,0, 0, 0, 0,    0, 0], // 1, no split
	   [1,1,1.8,1.8,0,0, 0, 0, 0,    0, 0], // 2, plain
	   [1,0,5,  1.8,3,1,90,70,50, -5, 5], // 3, round d=90mm + one rectangle 50x70mm
	   [1,0,5,  1.8,0,6, 0,70,50, 13.5, 5], //, 4 6 rectangles 50x70mm
	   [1,0,1.2,1.2,0,4, 0,65.3,65,    1,16], // 5 thin squares 65mm
	   [1,0,1.2,1.2,0,5, 0,55,55,-22,12], // 6 thin squares 55mm
	   [1,0,1.2,1.2,0,5, 0,75,55,-22.5,12], // 7 thin rectangles 55x75mm
	   [1,0,1.2,1.2,0,5, 0,95,55,-22.5,12] // 8 thin rectangles 55x95mm
	   ];

split=sizetable[print][0];
plain=sizetable[print][1];
coverwall=separatetemplates?1:1.8;
thickness=separatetemplates?coverwall:sizetable[print][2];
//mostlyround=print==3?1:0;
//mostlysquare=print==4?1:0;
roundmagnet=sizetable[print][4];
rectanglemagnets=sizetable[print][5];

roundmagnetrawd=sizetable[print][6];
roundmagnetd=roundmagnetrawd+dtolerance;
magnetrawl=sizetable[print][7];
magnetl=magnetrawl+xtolerance*2;
magnetx=-magnetl/2; // Relative
magnetraww=sizetable[print][8];
magnetw=magnetraww+ytolerance*2;
//magnety=-ytolerance;
magnetcornerd=0.5;
sidecovery=separatetemplates?0:sizetable[print][9];
gap=sizetable[print][10];

versiontext="V1.2";
textdepth=0.8;
textsize=7;
text1=str("UV template ",versiontext,roundmagnet>0?str(" d=",roundmagnetrawd):"",rectanglemagnets>0?str(" ",magnetrawl,"x",magnetraww):"");
text2=str("UV template ",versiontext,roundmagnet>0?str(" d=",roundmagnetrawd):"",rectanglemagnets>0?str(" ",magnetrawl,"x",magnetraww):"");
shorttext=str("ET ",versiontext);

cornerd=1;
wall=2;//1.6;

basew=374;
basel=101.3;
baseh=12.2;
//basecornerd=8.3*2;
basecornerd=5*2;
endholecornerd=8.3*2;

edgex=xtolerance+wall;
edgey=ytolerance+wall;

clipoverlap=1.5;
clipl=edgex+clipoverlap;
clipw=12;
cliph=cornerd+clipoverlap*1.5;
clipcut=0.6;

templatel=edgex+basel+edgex;
templatew=edgey+basew+edgey;
templaterightwall=1;
templaterightwallnarrowing=edgey-templaterightwall;
templatebelowh=baseh+ztolerance;
templatez=-templatebelowh;
templateh=baseh+ztolerance; // Plus thickness

clipheight=templatez-cliph;
  
printareay=36.1;
//printareal=90;
//printareax=6;
printareal=separatetemplates?96+xtolerance*2:90;
printareax=separatetemplates?3-xtolerance:6;
printareaw=335;

sideclipl=2;
sideclipw=50;
sidecliph=10;
sideclipspacel=xtolerance+sideclipl+xtolerance;
sideclipspacew=ytolerance+sideclipw+ytolerance;
sideclipspaceh=ztolerance+sidecliph+ztolerance;
sidecliplockl=2;
sidecliplockw=sidecliph-2;
sidecliplockkeyw=2;
sidecliplockh=6;
sidecliplockspacel=xtolerance+sidecliplockl+xtolerance;
sidecliplockspacew=ytolerance+sidecliplockw+ytolerance;
sidecliplockspaceh=ztolerance+sidecliplockh+ztolerance;
sidecliplocky=3;
sidecliplockspacey=sidecliplocky-ytolerance;
sidecliplockcutw=25;
cut=0.5;

sidecliphandlew=5;
sidecliphandlel=8;

sideclipztable=[wall+sideclipspaceh/2]; //,wall+sideclipspaceh+wall+sideclipspaceh/2
  
sidecoverl=sidecliplockspacel+wall;
sidecoverw=sideclipw+wall;
sidecoverh=wall+sideclipspaceh+wall;//-(thickness-coverwall); // +sideclipspaceh+wall;

addsidecoverh=sidecoverh<thickness-templatez?thickness-templatez-sidecoverh:0;

//sidecoverheight=-sidecoverh; // Plus thickness

// Split to two parts to fit in small printer
//cutx=-printareal/2-printareax-edgex+sidecliplocky+sideclipw+20;
splity=-printareaw/2-printareay-edgey;
splitw=printareaw/2+printareay+edgey+sidecovery+sidecoverw/2-sideclipw+8;
splitx=-500;
splitl=1000;
splith=1000;
splitbarh=coverwall; // Connect sides for plain model
splitbarw=3;
clipxtable=[-printareal/2-printareax-edgex+basel/3,-printareal/2-printareax+templatel-basel/3];
clipytable=[-printareaw/2-printareay-edgey+30,sidecovery-sidecoverw/2-clipw/2-ytolerance-sidecliphandlew-clipcut,-printareaw/2-printareay-edgey+templatew-30];

module clip() {
  translate([0,-clipw/2,clipheight]) roundedbox(wall,clipw,cliph+cornerd+1,cornerd,0);
  hull() {
    translate([0,-clipw/2,clipheight]) roundedbox(wall,clipw,cliph,cornerd,0);
    translate([0,-clipw/2,clipheight+clipoverlap*1.5]) roundedbox(clipl,clipw,cornerd,cornerd,0);
  }

  if (print>0) translate([edgex+cornerd/2,-clipw/2,clipheight+clipoverlap*1.5+cornerd]) supportbox(clipoverlap-cornerd/2,clipw,templatebelowh,0);
}

module clipcut() {
  for (m=[0,1]) mirror([0,m,0]) translate([-0.01,-clipw/2-clipcut,templatez-0.01]) cube([wall+0.02,clipcut,templatebelowh-cornerd/2]);
}

module sidecover() {
  translate([-sidecoverl,-sidecoverw/2,0]) roundedbox(sidecoverl+wall,sidecoverw,sidecoverh+addsidecoverh,cornerd,2);
}

module sidecovercut() {
  for (z=sideclipztable) {
    difference() {
      translate([-sidecoverl+wall,-sidecoverw/2-cornerd/2,z-sideclipspaceh/2]) roundedbox(sideclipspacel,sideclipspacew+cornerd/2,sideclipspaceh,cornerd,0);

      hull() {
	translate([-sidecoverl,-sidecoverw/2+sideclipw-sidecliplocky-sidecliplockw,z-sidecliplockh/2]) roundedbox(wall,sidecliplockw,sidecliplockh,cornerd,0);
	translate([-sidecoverl,-sidecoverw/2+sideclipw-sidecliplocky-sidecliplockkeyw,z-sidecliplockh/2+wall]) roundedbox(wall+wall,sidecliplockkeyw,sidecliplockh-wall*2,cornerd,0);
      }
    }
    
    for (zz=[-sidecliplockh/2-cut,sidecliplockh/2]) {
      difference() {
	translate([-sidecoverl-0.01,-sidecoverw/2+sidecoverw-sidecliplocky-sidecliplockcutw,z+zz]) cube([wall+wall/2+0.01,sidecliplockcutw,cut]);
	// Some support for printing
	for (y=[-sidecoverw/2+sidecoverw-sidecliplocky,-sidecoverw/2+sidecoverw-sidecliplocky-sidecliplockcutw/2]) {
	  translate([-sidecoverl,y-cut-0.4,z+zz]) cube([0.4,0.4,cut]);
	  translate([-sidecoverl+wall-0.4,y-cut-0.4,z+zz]) cube([0.4,0.4,cut]);
	  translate([-sidecoverl,y-cut-0.4,z+zz]) cube([wall,0.4,layerh]);
	}
      }
    }

    translate([-sidecoverl-0.01,-sidecoverw/2+sidecoverw-sidecliplocky-cut,z-sidecliplockh/2-cut]) cube([wall+wall/2,wall,cut+sidecliplockh+cut]);
  }
}

module sideclip() {
  difference() {
    union() {
      translate([-sidecoverl+wall,-sidecoverw/2-sidecliphandlew,-sidecliph/2]) roundedbox(sideclipl,sidecliphandlew+sideclipw,sidecliph,cornerd,4);
      translate([-sidecoverl+wall-sidecliphandlel,-sidecoverw/2-sidecliphandlew-ytolerance,-sidecliph/2]) roundedbox(sidecliphandlel+sideclipl,sidecliphandlew,sidecliph,cornerd,4);
    }

    translate([-sidecoverl+wall-cornerd/2,-sidecoverw/2+sideclipw-sidecliplockspacey-sidecliplockspacew,-sidecliplockspaceh/2]) roundedbox(sidecliplockl+cornerd,sidecliplockspacew,sidecliplockspaceh,cornerd,0);

    translate([-sidecoverl+wall+textdepth-0.01,sidecoverw/2-sidecliphandlew-wall-sidecoverw/2,0]) rotate([90,0,-90]) linear_extrude(height=textdepth) text(shorttext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

// Generate template.
module eufymaketemplate(thickness,shrinkfactor=1) {
  difference() {
    union() {
      difference() {
	union() {
	  translate([-printareal/2-printareax-edgex,-printareaw/2-printareay-edgey+templaterightwallnarrowing,0]) roundedboxxyz(templatel,templatew-templaterightwallnarrowing,thickness,basecornerd+edgex*2,cornerd,2,90);
	  translate([-printareal/2-printareax-edgex,-printareaw/2-printareay-edgey+templaterightwallnarrowing,templatez]) roundedboxxyz(templatel,templatew-templaterightwallnarrowing,templateh+thickness,basecornerd+edgex*2,cornerd,2,90);
	}

	// Cutout
	translate([-printareal/2-printareax-xtolerance,-printareaw/2-printareay-ytolerance,templatez-cornerd/2]) roundedboxxyz(basel+xtolerance*2,basew+ytolerance*2,templatebelowh+cornerd/2,basecornerd,cornerd,0,90);
	difference() {
	  translate([-printareal/2-printareax-xtolerance+wall,-printareaw/2-printareay-ytolerance+wall,templatez-cornerd/2]) roundedboxxyz(basel+xtolerance*2-wall*2,basew+ytolerance*2-wall*2,templatebelowh+cornerd/2+(thickness-coverwall),basecornerd,cornerd,0,90);
	  translate([-printareal/2-wall,-printareaw/2-printareay+endholecornerd/4-wall,-cornerd/2]) roundedboxxyz(printareal+wall*2,printareay-endholecornerd/2+wall*2,thickness+cornerd+cornerd/2,endholecornerd,cornerd,0,90);

	  if (!separatetemplates && roundmagnet) {
	    step=roundmagnetd+gap;
	    for (y=[roundmagnetd/2:step:printareaw-step/2]) {
	      translate([0,printareaw/2-y,-0.1]) cylinder(d=roundmagnetd+wall*2,h=thickness+0.2,$fn=180);
	    }
	  }

	  if (!separatetemplates && rectanglemagnets) {
	    step=magnetw+gap;
	    for (y=[-printareaw/2+1:step:-printareaw/2+1+step*(rectanglemagnets-1)]) {
	      translate([magnetx-wall,y-wall,-magnetcornerd/2]) roundedbox(magnetl+wall*2,magnetw+wall*2,thickness+magnetcornerd,magnetcornerd,0);
	    }
	  }
	}
	translate([-printareal/2,-printareaw/2-printareay+endholecornerd/4,-cornerd/2]) roundedboxxyz(printareal,printareay-endholecornerd/2,thickness+cornerd,endholecornerd,cornerd,0,90);

	translate([-printareal/2-printareax-edgex+textdepth-0.01,-printareaw/2,-templatebelowh/2]) rotate([90,0,-90]) linear_extrude(height=textdepth) text(text1, size=textsize-2, valign="center",halign="right",font="Liberation Sans:style=Bold");
	translate([-printareal/2-printareax-edgex+templatel-textdepth+0.01,-printareaw/2,-templatebelowh/2]) rotate([-90,180,-90]) linear_extrude(height=textdepth) text(text1, size=textsize-2, valign="center",halign="left",font="Liberation Sans:style=Bold");
	
	translate([-printareal/2-printareax-edgex+textdepth-0.01,clipytable[2]-clipw/2-clipcut-1,-templatebelowh/2]) rotate([90,0,-90]) linear_extrude(height=textdepth) text(text2, size=textsize-2, valign="center",halign="left",font="Liberation Sans:style=Bold");
	translate([-printareal/2-printareax-edgex+templatel-textdepth+0.01,clipytable[2]-clipw/2-clipcut-1,-templatebelowh/2]) rotate([-90,180,-90]) linear_extrude(height=textdepth) text(text2, size=textsize-2, valign="center",halign="right",font="Liberation Sans:style=Bold");
	
	translate([-printareal/2-printareax-edgex+templatel/2,-printareaw/2-printareay-edgey+textdepth-0.01,-templatebelowh/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
	translate([-printareal/2-printareax-edgex+templatel/2,-printareaw/2-printareay-edgey+templatew-textdepth+0.01,-templatebelowh/2]) rotate([90,0,180]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="center",halign="center",font="Liberation Sans:style=Bold");
	
	if (separatetemplates || plain) {
	  difference() {
	    translate([-printareal/2,-printareaw/2,-cornerd/2]) roundedbox(printareal,printareaw,thickness+cornerd,cornerd,0);
	    translate([splitx,splity+splitw-splitbarw,thickness-splitbarh]) cube([splitl,splitbarw-ytolerance,splitbarh+0.1]);
	  }
	}

	if (!separatetemplates && roundmagnet) {
	  step=gap+roundmagnetd;
	  for (y=[roundmagnetd/2:step:printareaw-step/2]) {
	    translate([0,printareaw/2-y,-0.1]) cylinder(d=roundmagnetd,h=thickness+0.2,$fn=180);
	    if (thickness != coverwall) hull() {
		translate([0,printareaw/2-y,thickness-coverwall]) cylinder(d=roundmagnetd,h=coverwall+0.1,$fn=180);
		translate([0,printareaw/2-y,thickness]) cylinder(d=roundmagnetd+coverwall,h=thickness+0.2,$fn=180);
	      }
	  }
	}

	if (!separatetemplates && rectanglemagnets) {
	  for (y=[-printareaw/2+1:magnetw+gap:-printareaw/2+1+(magnetw+gap)*(rectanglemagnets-1)]) {
	    translate([magnetx,y,-magnetcornerd/2]) roundedbox(magnetl,magnetw,thickness+magnetcornerd,magnetcornerd,0);
	    if (thickness != coverwall) hull() {
		translate([magnetx,y,thickness-coverwall]) roundedbox(magnetl,magnetw,thickness+magnetcornerd,magnetcornerd,0);
		translate([magnetx-coverwall/2,y-coverwall/2,thickness]) roundedbox(magnetl+coverwall,magnetw+coverwall,thickness+magnetcornerd,magnetcornerd,0);
	      }
	  }
	}
      }
      
      if (split) {
	for (m=[0,1]) mirror([m,0,0]) translate([-printareal/2-printareax-edgex,sidecovery,thickness-sidecoverh-addsidecoverh]) sidecover();
	//translate([-printareal/2-printareax-edgex+templatel,sidecovery,thickness-addsidecoverh]) rotate([180,0,180]) sidecover();
      }
      
      for (x=clipxtable) {
	//translate([x,-printareaw/2-printareay-edgey+0.06,0]) rotate([0,0,90]) clip();
	translate([x,-printareaw/2-printareay-edgex+templatew,0]) rotate([0,0,-90]) clip();
      }

      for (y=clipytable) {
	translate([-printareal/2-printareax-edgex,y,0]) clip();
	translate([-printareal/2-printareax-edgex+templatel,y,0]) rotate([0,0,180]) clip();
      }
    }

    if (split) {
      for (m=[0,1]) mirror([m,0,0]) translate([-printareal/2-printareax-edgex,sidecovery,thickness-sidecoverh]) sidecovercut();
      //translate([-printareal/2-printareax-edgex+templatel,sidecovery,thickness]) rotate([180,0,180]) sidecovercut();
    }
	
    for (x=clipxtable) {
      //translate([x,-printareaw/2-printareay-edgey,0]) rotate([0,0,90]) clipcut();
      translate([x,-printareaw/2-printareay-edgex+templatew,0]) rotate([0,0,-90]) clipcut();
    }
    
    for (y=clipytable) {
      translate([-printareal/2-printareax-edgex,y,0]) clipcut();
      translate([-printareal/2-printareax-edgex+templatel,y,0]) rotate([0,0,180]) clipcut();
    }
  }
}
		       
if (print==0) {
  intersection() {
    if (debug) translate([-1000,-1000,-1000]) cube([1000-54,2000,2000]);
    union() {
      eufymaketemplate(thickness);
      for (z=sideclipztable) translate([-printareal/2-printareax-edgex,sidecovery,2-sidecoverh+z]) sideclip();
    }
  }
 }
		       
if (print>0) {
  difference() {
    union() {
      translate([templatel/2+sidecoverl/2+0.5,-templatel,2]) rotate([0,0,0]) rotate([180,0,0]) {
	intersection() {
	  if (split) translate([splitx,splity,-500]) cube([splitl,splitw,splith]);
	  union() {
	    eufymaketemplate(thickness);
	    if (split) for (i=[-1,1]) rotate([0,-90,-90]) translate([sidecoverl-wall-wall+thickness,0,-printareaw/2-printareay/2+i*(sidecliph/2+0.25)]) sideclip();
	  }
	}
      }

      if (split) {
	translate([-templatel/2-sidecoverl/2-0.5,-templatel+splitw,2]) rotate([0,0,0]) rotate([180,0,0]) {
	  intersection() {
	    if (split) translate([splitx,splity+splitw,-500]) cube([splitl,1000,splith]);
	    eufymaketemplate(thickness);
	  }
	}
      }
    }

    #    translate([0,0,-thickness+coverwall]) printareacube("ankermake");
  }
 }
