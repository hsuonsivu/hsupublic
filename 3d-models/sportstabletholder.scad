// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
include <hsubolt.scad>

print=0;
debug=0;

// Faster printing for debugging
fullslope=0;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;
maxbridge=10;
wall=2; // Testing
thickwall=4;
cornerd=1.2;

tunturicrosstrainerversion=1;
waterrowerversion=0;

versiontext="V1.0";
brandtext1=tunturicrosstrainerversion?"Crosstrainer":waterrowerversion?"Waterrower":"Basic";;
brandtext2="Bookstand";
brandtext=str(brandtext1," ",brandtext2);
fulltext=str(brandtext," ",versiontext);
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

topw=210; // 208
topl=49-6; //49
topdepth=2;
toph=26.5;
nayttow=150;
sideh=90;
backangle=90-63;
bottomshortenh=tan(backangle)*(toph+wall);
backw=topw+6;
bottomw=222;
bottomheight=-175;
slopeytable=[-topw/2+20,-topw/5+10,topw/5-10,topw/2-20];

tabletfront=1;

tabletw=245;
tableth=187.5;
tabletl=10;
tabletheight=-5;
tabletcornerd=20;
tabletzcornerd=7;

tankod=34;
tankow=288+tankod;
tankotoph=182;
tankotopw=100;
tankoturnw=270;
tankobottomw=360+tankod;
tankoturnh=tankotoph-55;

tableta=waterrowerversion?0:tabletfront?-5:0;
tankox=-20-tankod/2;
tabletx=-20-tankod-5-sin(tableta)*tableth;//tabletfront?-20-tankod+sin(tableta)*tableth+sin(tableta)*tankod:topl+90;
urageight=tabletheight+tableth-cos(tableta)*tableth+sin(tableta)*tankod;
ural=20;
urafrontl=5;
urah=5;
holderthickness=5+urah;
holderl=wall-tabletx+tabletl+ural+sin(tableta)*tableth;
urax=-holderl+urafrontl;//tabletx+sin(tableta)*tableth;//-sin(tableta)*tableth-ural;

coverclipw=4;
coverclipl=8;
covercliph=20;
coverclipbodyh=4;
coverclipoverhangh=6.5;
coverclipoverhang=1.4;
coverclipoutl=coverclipl+wall*2+dtolerance*2+coverclipoverhang*2;
coverclipoutw=coverclipw+wall*2+dtolerance*2;
coverclipytable=[-topw/2+thickwall+wall,-topw/4+wall,0];
coverclipxtable=[urax+urafrontl+ural+thickwall+coverclipoutl/2,topl-wall-coverclipoutl/2-thickwall];
covercliptotalh=covercliph+(coverclipoverhangh+wall)*2;// coverclipbodyh*2+coverclipoverhangh;
coverclipz=wall+ztolerance+covercliph/2-wall-ztolerance;
coverclipcoverh=covercliptotalh-coverclipz;

supportw=topw+wall*2;
supportheight=wall+ztolerance;
supporth=tunturicrosstrainerversion?tankoturnh-10:tableth+tabletheight;
supportcenterw=tankotopw-tankod/2;
supportcenterh=tunturicrosstrainerversion?tankotoph-tankod/2-10:supporth;
supportcornerd=tankod;
supportx=urax+ural;

// Lightening holes
margin=10;
bar=10;

// Rowing machine
rowingmachinex=0;
rowingmachineheight=-210;//-170;//-130;

rowingtopplatew=114.5;//115;
rowingtopplateh=26.6;
rowingtopplatel=500;

rowingfrontplatea=-44.15;
rowingsideflange=5;
rowingfrontplated=200; // Curve below
rowingfrontplatew=rowingtopplatew+rowingfrontplated/2;
rowingfrontplateh=25.7;
rowingfrontplatetoph=rowingfrontplateh+1.5;
rowingfrontplatetopl=15;
rowingfrontplatel=100; // Goes below, just for curve part
rowingfrontplatecurvel=65;
rowingadapteryextend=wall+14;
rowingadapterw=rowingtopplatew+ytolerance+rowingadapteryextend*2;
rowingadapterboltheight=rowingmachineheight+wall+boltbased()/2+7;
rowingadapterboltx=rowingmachinex+15+wall+boltbased()/2;

rowingsidel=130;
rowingsideh=rowingtopplateh+wall*2;
rowingsidewall=wall;

adjustknobd=3;
adjustknobdepth=1;
adjustknobs=30;

adjustcircled=50;
//adjustcircledepth=4;
//adjustcircleangles=60;
adjustcirclewall=2+adjustknobd-adjustknobdepth;

adjustx=rowingmachinex+2;
adjustw=rowingadapterw;
adjustheight=wall-holderthickness-5-40-adjustcircled/2;
adjustwall=4;
adjustboltl=20;
adjustboltbaseh=20;

bindboltw=rowingtopplatew+5;
bindboltl=18;
bindboltbaseh=15;

bindcoverhumpw=70;
bindcoverhumpd=18+1;
bindcoverhumph=2+ztolerance;
bindcoverhumpx=35;

basex=-cornerd/2-holderl;
basefrontl=urafrontl+ural+thickwall;
baseplatel=coverclipxtable[1]+coverclipoutl/2-basex;

// Margin for lightening holes in rowerattach
attachxmargin=20;
attachzmargin=15;

module frontform(l,w,h,depth) {
  d=length_and_depth_to_diameter(w,depth);
  intersection() {
    difference() {
      translate([d/2-depth,0,-h]) roundedcylinder(d,h+wall,cornerd,2,360);
      translate([d/2-depth+wall,0,-h-cornerd/2]) roundedcylinder(d,cornerd/2+h,cornerd,2,360);
    }
    translate([-wall-depth,-w/2-wall,-h]) roundedbox(wall+depth+wall,w+wall*2,h+wall,cornerd,2);    
  }
}

module tablet() {
  translate([0,-tabletw/2,0]) rotate([0,-90,0]) roundedboxxyz(tableth,tabletw,tabletl,tabletcornerd,tabletzcornerd,0,90);
}

module tanko() {
  hull() {
    translate([tankox,-tankotopw/2,tankotoph]) sphere(d=tankod);
    translate([tankox,-tankoturnw/2,tankoturnh]) sphere(d=tankod);
  }
  hull() {
    translate([tankox,-tankoturnw/2,tankoturnh]) sphere(d=tankod);
    translate([tankox,-tankobottomw/2,bottomheight]) sphere(d=tankod);
  }
}

module baseplate() {
  // Holder body
  translate([-cornerd/2-holderl,-topw/2-wall,wall-holderthickness]) roundedbox(urafrontl+ural+thickwall,topw+wall*2,holderthickness,cornerd,0);
  translate([basex,-topw/2-wall,0]) roundedbox(baseplatel,topw+wall*2,wall,cornerd,2);
}

module baseplatecut() {
  translate([urax,-topw/2-wall-cornerd/2,wall-urah]) roundedbox(ural,topw+wall*2+cornerd,urah+cornerd,cornerd,0);
    
  translate([-holderl+0.01,0,wall-holderthickness/2]) rotate([-90,180,90]) linear_extrude(textdepth) text(fulltext,size=textsize,font=textfont,valign="center",halign="center");
    
  for (y=coverclipytable) for (x=coverclipxtable) for (m=[0,1]) mirror([0,m,0]) translate([x-coverclipl/2-xtolerance,y-coverclipw/2-ytolerance,-cornerd/2]) roundedbox(coverclipl+xtolerance*2,coverclipw+ytolerance*2,wall+cornerd,0);
}

module topattach() {
  difference() {
    union() {
      // Front plate
      for (m=[0,1]) mirror([0,m,0]) {
	  hull() {
	    translate([-wall,-topw/2-wall,0]) roundedbox(wall,wall,wall,cornerd,2);
	    translate([topl,-topw/2-wall,0]) roundedbox(wall,wall,wall,cornerd,2);
	    translate([topl,-backw/2-wall,-sideh]) roundedbox(wall,wall,wall,cornerd,2);
	  }
	  hull() {
	    translate([-wall,-topw/2-wall,-sideh]) roundedbox(wall,wall,wall,cornerd,2);
	    translate([-wall,-topw/2-wall,0]) roundedbox(wall,wall,wall,cornerd,2);
	    translate([topl,-backw/2-wall,-sideh]) roundedbox(wall,wall,wall,cornerd,2);
	  }
	  hull() {
	    translate([-wall-wall/2,-topw/2-wall,-sideh]) roundedbox(wall,thickwall,wall,cornerd,2);
	    translate([-wall-wall/2,-topw/2-wall,0]) roundedbox(wall,thickwall,wall,cornerd,2);
	    translate([-holderl,-topw/2-wall,wall-holderthickness]) roundedbox(wall,thickwall,holderthickness,cornerd,2);
	  }
	}

      difference() {
	translate([-wall,0,0]) frontform(wall,topw,sideh,topdepth);
	translate([-topdepth-wall-0.01,-nayttow/2,-sideh-0.01]) roundedbox(topdepth+wall+0.02,nayttow,sideh-bottomshortenh,cornerd,$fn=90);
      }

      baseplate();
      
      // Back plate
      hull() {
	translate([topl,-topw/2-wall,]) roundedbox(wall,topw+wall*2,wall,cornerd,2);
	translate([topl,-backw/2-wall,-sideh]) roundedbox(wall,backw+wall*2,wall,cornerd,2);
      }

      // Top plate
      hull() {
	translate([-wall,-topw/2-wall,0]) roundedbox(wall,topw+wall*2,wall,cornerd,2);
	if (fullslope) {
	  translate([topl,-topw/2-wall,-bottomshortenh]) roundedbox(wall,topw+wall*2,wall,cornerd,2);
	}
	translate([topl,-topw/2-wall,0]) roundedbox(wall,topw+wall*2,wall,cornerd,2);
      }
      if (!fullslope) {
	for (y=slopeytable) {
	  hull() {
	    translate([-wall,y-wall/2,0]) roundedbox(wall,wall,wall,cornerd,2);
	    translate([topl,y-wall/2,-bottomshortenh]) roundedbox(wall,wall,wall,cornerd,2);
	    translate([topl,y-wall/2,0]) roundedbox(wall,wall,wall,cornerd,2);
	  }
	}
      }
    }

    w=slopeytable[2]-slopeytable[1]+margin*2-wall*2;
    translate([topl+wall,slopeytable[1]+w-margin+wall,0]) rotate([0,180,90]) lighten(w,sideh,wall,margin,bar,maxbridge,"up",cornerd=wall);
    sw=slopeytable[1]-(-topw/2);
    for (m=[0,1]) mirror([0,m,0]) translate([topl+wall,-topw/2+sw,-bottomshortenh+margin-cornerd]) rotate([0,180,90]) lighten(sw,sideh-bottomshortenh+margin-cornerd,wall,margin,bar,maxbridge,"up",cornerd=wall);
    
    for (m=[0,1]) mirror([0,m,0]) {
	wll=(backw-topw)+wall;
	rotate([0,180,0]) translate([-topl,backw/2+wall-wll,0]) lighten(topl,sideh,wll,margin,bar,maxbridge,"up",cornerd=wll);
      }

    baseplatecut();
  }
}

module backattach() {
  difference() {
    union() {
    
      hull() {
	x=supportx+wall;
	translate([x,-supportw/2,supportheight]) rotate([0,-90,0]) roundedboxxyz(supporth,supportw,wall,supportcornerd,cornerd,0,90);
	translate([x,-supportw/2,supportheight]) rotate([0,-90,0]) roundedboxxyz(supporth-supportcornerd/2,supportw,wall,cornerd,cornerd,0,90);
	translate([x,-supportcenterw/2,supportheight]) rotate([0,-90,0]) roundedboxxyz(supportcenterh,supportcenterw,wall,supportcornerd,cornerd,0,90);
      }

      translate([supportx,-supportw/2,supportheight]) roundedbox(coverclipxtable[1]+coverclipoutl/2-supportx,supportw,wall,cornerd,0);
      difference() {
	hull() {
	  x=supportx+thickwall;
	  translate([x,-supportw/2,supportheight]) rotate([0,-90,0]) roundedboxxyz(supporth,supportw,thickwall,supportcornerd,cornerd,0,90);
	  translate([x,-supportw/2,supportheight]) rotate([0,-90,0]) roundedboxxyz(supporth-supportcornerd/2,supportw,thickwall,cornerd,cornerd,0,90);
	  translate([x,-supportcenterw/2,supportheight]) rotate([0,-90,0]) roundedboxxyz(supportcenterh,supportcenterw,thickwall,supportcornerd,cornerd,0,90);
	}

	hull() {
	  x=supportx+thickwall+wall;
	  translate([x,-supportw/2+thickwall,supportheight+thickwall]) rotate([0,-90,0]) roundedboxxyz(supporth-thickwall*2,supportw-thickwall*2,thickwall,supportcornerd,cornerd,0,90);
	  translate([x,-supportw/2+thickwall,supportheight+thickwall]) rotate([0,-90,0]) roundedboxxyz(supporth-supportcornerd/2-thickwall*2,supportw-thickwall*2,thickwall,cornerd,cornerd,0,90);
	  translate([x,-supportcenterw/2+thickwall,supportheight+thickwall]) rotate([0,-90,0]) roundedboxxyz(supportcenterh-thickwall*2,supportcenterw-thickwall*2,thickwall,supportcornerd,cornerd,0,90);
	}
      }

      intersection() {
	for (x=coverclipxtable) for (m=[0,1]) mirror([0,m,0]) {
	      hull() {
		translate([x-coverclipoutl/2,coverclipytable[0]-coverclipoutw/2,supportheight]) roundedbox(coverclipoutl,coverclipoutw,coverclipcoverh,0);
		translate([x-coverclipoutl/2-coverclipcoverh,-supportw/2,supportheight]) roundedbox(coverclipoutl,cornerd,wall,0);
	      }

	      hull() {
		translate([x-coverclipoutl/2,-coverclipoutw/2,supportheight]) roundedbox(coverclipoutl,coverclipoutw,coverclipcoverh,0);
		translate([x-coverclipoutl/2-coverclipcoverh,-cornerd/2,supportheight]) roundedbox(coverclipoutl,cornerd,wall,0);
	      }
	    }
	
	translate([supportx,-supportw/2,supportheight]) cube([coverclipxtable[1]+coverclipoutl/2-supportx,supportw,supporth]);
      }
      
      for (m=[0,1]) mirror([0,m,0]) {
	  hull() {
	    translate([supportx,-supportw/2,supportheight]) roundedbox(thickwall,thickwall,supporth-supportcornerd/2,cornerd,0);
	    translate([coverclipxtable[1]+coverclipoutl/2-thickwall,-supportw/2,supportheight]) roundedbox(thickwall,thickwall,coverclipcoverh,cornerd,0);
	  }
	  hull() {
	    translate([supportx,-thickwall/2,supportheight]) roundedbox(thickwall,thickwall,supportcenterh,cornerd,0);
	    translate([coverclipxtable[1]+coverclipoutl/2-thickwall,-thickwall/2,supportheight]) roundedbox(thickwall,thickwall,coverclipcoverh,cornerd,0);
	  }
	}
    }

    x=supportx+thickwall-wall;
    for (m=[0,1]) mirror([0,m,0]) {
	w=(supportw-supportcenterw)/4;
	y=-supportw/2;
	x=supportx+wall;
	translate([x,y,supportheight]) rotate([0,0,90]) lighten(w+margin,supporth,wall,margin,bar,maxbridge,"up",cornerd=wall);
	translate([x,y+w,supportheight]) rotate([0,0,90]) lighten(w+margin,(supporth+supportcenterh)/2,wall,margin,bar,maxbridge,"up",cornerd=wall);
	translate([x,y+w*2,supportheight]) rotate([0,0,90]) lighten(w+margin,supportcenterh,wall,margin,bar,maxbridge,"up",cornerd=wall);
      }

    for (y=[coverclipytable[0],coverclipytable[2]]) for (x=coverclipxtable) for (m=[0,1]) mirror([0,m,0]) {
	    translate([x,y,coverclipz]) {
	      rotate([0,0,0]) lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,1,text=versiontext,textdepth=0.7);
	    }
	  }

    translate([(coverclipxtable[1]+coverclipxtable[0])/2-textsize-1,-supportw/4,supportheight+wall-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text(brandtext1,size=textsize,font=textfont,valign="center",halign="center");
    translate([(coverclipxtable[1]+coverclipxtable[0])/2,-supportw/4,supportheight+wall-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text(brandtext2,size=textsize,font=textfont,valign="center",halign="center");
    translate([(coverclipxtable[1]+coverclipxtable[0])/2+textsize+1,-supportw/4,supportheight+wall-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module rowingmachine() {
  translate([rowingmachinex,-rowingtopplatew/2,rowingmachineheight-rowingtopplateh]) roundedbox(rowingtopplatel,rowingtopplatew,rowingtopplateh,cornerd,0);

  translate([rowingmachinex,0,rowingmachineheight]) {
    rotate([0,rowingfrontplatea,0]) {
      difference() {
	union() {
	  translate([-rowingfrontplatetopl,-rowingtopplatew/2,-rowingfrontplateh]) roundedbox(rowingfrontplatetopl,rowingtopplatew,rowingfrontplatetoph,cornerd,0);
	  translate([-rowingfrontplatel,-rowingfrontplatew/2,-rowingfrontplateh]) roundedbox(rowingfrontplatel-rowingfrontplatetopl+cornerd,rowingfrontplatew,rowingfrontplateh,cornerd,0);
	}
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([-rowingfrontplatetopl,-rowingtopplatew/2-rowingfrontplated/2,-rowingfrontplateh-0.1]) cylinder(d=rowingfrontplated,h=rowingfrontplateh+0.2,$fn=180);
	  }
      }
    }
  }
}

module attachlightencylinder() {
  rotate([90,0,0]) cylinder(d=cornerd,h=adjustw+ytolerance*2+adjustcirclewall*2+0.2,$fn=30,center=true);
}

module rowerattach() {
  difference() {
    adjusty=-adjustw/2-ytolerance-adjustcirclewall;
   
    union() {
      baseplate();
      
      for (m=[0,1]) mirror([0,m,0]) {
	  hull() {
	    translate([adjustx,-adjustw/2-ytolerance-adjustcirclewall,adjustheight]) rotate([-90,0,0]) adjustplatebody();//-90
	    translate([basex,adjusty,wall-holderthickness]) roundedbox(basefrontl,adjustcirclewall,holderthickness,cornerd,0);
	    x=-cornerd/2-holderl;
	    translate([x,adjusty,0]) roundedbox(coverclipxtable[1]+coverclipoutl/2-x,adjustcirclewall,wall,cornerd,2);
	  }
	  translate([adjustx,adjusty,adjustheight]) rotate([-90,0,0]) adjustplate();//-90
	}
    }

    baseplatecut();

    for (m=[0,1]) mirror([0,m,0]) {
	translate([adjustx,adjusty-0.01,adjustheight]) rotate([-90,0,0]) cylinder(d=boltholed()+dtolerance,h=adjustwall+0.02,$fn=90);
      }

    // Lightening holes. This may be too weak due to printing
    // direction of layer lines, so disabled at the moment.
    if (0) {
      hull() {
	translate([adjustx+boltholed()/2,0,adjustheight+adjustcircled/2]) attachlightencylinder();
	translate([adjustx+boltholed()/2-maxbridge,0,adjustheight+adjustcircled/2]) attachlightencylinder();
	translate([adjustx+boltholed()/2-maxbridge,0,-attachzmargin]) attachlightencylinder();
	translate([basex+baseplatel-attachxmargin,0,-attachzmargin]) attachlightencylinder();
      }

      hull() {
	barw=12;
	translate([adjustx+boltholed()/2-maxbridge-barw,0,adjustheight+adjustcircled/2]) attachlightencylinder();
	translate([adjustx+boltholed()/2-maxbridge-barw,0,-attachzmargin]) attachlightencylinder();
	translate([adjustx+boltholed()/2-maxbridge-barw-maxbridge,0,adjustheight+adjustcircled/2]) attachlightencylinder();
	translate([urax+urafrontl+ural+barw,0,-attachzmargin]) attachlightencylinder();
      }
    }
    
    x=-(holderl-urafrontl-ural);
    l=coverclipxtable[1]+coverclipoutl/2-x;
    margin=10;
    x2=coverclipxtable[0]+coverclipl/2+margin;
    l2=coverclipxtable[1]-coverclipxtable[0]-coverclipl-margin*2;
    y2=-adjustw/2+margin/2;
    w2=coverclipytable[1]+coverclipw/2-y2;
    y3=-topw/2-wall*2+margin;
    w3=-adjustw/2-adjustwall-margin/2-y3;
    for (m=[0,1]) mirror([0,m,0]) {
	translate([x+margin,coverclipytable[1]+coverclipw/2+margin,-cornerd/2]) roundedbox(l-margin*2,coverclipytable[2]-coverclipytable[1]-coverclipw-margin*2,wall+cornerd,cornerd,0);
	translate([x2,y2,-cornerd/2]) roundedbox(l2,w2,wall+cornerd,cornerd,0);
	translate([x2,y3,-cornerd/2]) roundedbox(l2,w3,wall+cornerd,cornerd,0);
      }
  }
}

module adjustcylinder() {
  roundedcylinder(adjustcircled,adjustcirclewall,cornerd,1,180);
}

module adjustcylindercut() {
  for (a=[0:360/adjustknobs:360-1]) {
    rotate([0,0,a]) {
      translate([adjustcircled/2-cornerd/2-1-adjustknobd/2,0,-adjustknobd/2+adjustknobdepth]) sphere(d=adjustknobd+dtolerance,$fn=90);
    }
  }
}

module adjustplatebody() {
  roundedcylinder(adjustcircled,adjustcirclewall,cornerd,1,180);
}

module adjustplate() {
  adjustplatebody();
  
  for (a=[0:360/adjustknobs:360-1]) {
    rotate([0,0,a]) {
      translate([adjustcircled/2-cornerd/2-1-adjustknobd/2,0,adjustcirclewall-adjustknobd/2+adjustknobdepth]) sphere(d=adjustknobd,$fn=90);
    }
  }
}

// Part between rowerattachsideparts.
module rowerattachbinder() {
  difference() {
    union() {
      y=-rowingadapterw/2+adjustcirclewall+ytolerance;
      w=-bindboltw/2+ytolerance+wall-y;
      d=boltholecoverd()+dtolerance+wall*2;
      l=rowingadapterboltx-rowingmachinex+d;
      x=rowingmachinex+wall;
      h=rowingadapterboltheight+d/4-(rowingmachineheight+wall+ztolerance);
      for (m=[0,1]) mirror([0,m,0]) {
	  difference() {
	    union() {
	      hull() {
		translate([rowingadapterboltx,y,rowingadapterboltheight]) rotate([-90,0,0]) roundedcylinder(d,w,cornerd,0,90);
		translate([x,y,rowingmachineheight+wall+ztolerance]) roundedbox(wall,w,h,cornerd,7);
		translate([x,y,rowingmachineheight+wall+ztolerance]) roundedbox(l,w,wall,cornerd,7);
	      }
	      hull() {
		translate([x,-bindboltw/2,rowingmachineheight+xtolerance+wall]) roundedbox(wall,wall,h,cornerd,7);
		translate([x,-bindboltw/2,rowingmachineheight+xtolerance+wall]) roundedbox(wall,20,wall,cornerd,7);
	      }
	    }
	    
	    translate([rowingadapterboltx,y-cornerd/2,rowingadapterboltheight]) rotate([-90,0,0]) roundedcylinder(boltholecoverd()+dtolerance,w-wall+cornerd/2,cornerd,0,90);
	    translate([rowingadapterboltx,y-cornerd/2,rowingadapterboltheight]) rotate([-90,0,0]) roundedcylinder(boltholed()+dtolerance,w+wall+cornerd,cornerd,0,90);
	  }
	}

      midw=rowingtopplatew-rowingsideflange*2-ytolerance*2;
      translate([x,-midw/2,rowingmachineheight+xtolerance]) roundedbox(l,midw,wall*2,cornerd,7);
      translate([x,-bindboltw/2,rowingmachineheight+xtolerance+wall]) roundedbox(l,bindboltw,wall,cornerd,7);
    }

    // Rower body has some bolts we need to leave space for.
    for (m=[0,1]) mirror([0,m,0]) {
	hull() {
	  translate([bindcoverhumpx,-bindcoverhumpw/2,rowingmachineheight-0.01]) cylinder(d=bindcoverhumpd+bindcoverhumph*2,h=0.01,$fn=90);
	  translate([bindcoverhumpx,-bindcoverhumpw/2,rowingmachineheight-0.01]) cylinder(d=bindcoverhumpd,h=0.01+bindcoverhumph,$fn=90);
	}
      }
    
    translate([rowingadapterboltx+textsize+2,0,rowingmachineheight+xtolerance+wall*2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text(brandtext1,size=textsize,font=textfont,valign="center",halign="center");
    translate([rowingadapterboltx,0,rowingmachineheight+xtolerance+wall*2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text(brandtext2,size=textsize,font=textfont,valign="center",halign="center");
    translate([rowingadapterboltx-textsize-2,0,rowingmachineheight+xtolerance+wall*2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module rowerattachsidepart(left=0) {
  difference() {
    mirror([0,left,0]) {
      hull() {
	translate([rowingmachinex,-rowingtopplatew/2-ytolerance-wall,rowingmachineheight]) roundedbox(rowingsidel,rowingsidewall,wall,cornerd,0);
	translate([rowingmachinex+rowingsideh/2,-rowingtopplatew/2-ytolerance-wall,rowingmachineheight-rowingtopplateh-wall]) roundedbox(rowingsidel-rowingsideh/2,rowingsidewall,rowingsideh,cornerd,0);
      }

      // Adjust ring
      hull() {
	translate([adjustx,-adjustw/2,adjustheight]) rotate([-90,0,0]) adjustcylinder();//-90
	translate([rowingmachinex,-rowingadapterw/2,rowingmachineheight]) roundedbox(rowingsidel,adjustcirclewall,wall,cornerd,4);
      }
      // Adjust bolt cover
      translate([adjustx,-adjustw/2,adjustheight]) rotate([-90,0,0]) roundedcylinder(boltholecoverd(),adjustboltl,cornerd,0,90);;//m20boltcover(threadlength=adjustboltl-ytolerance-adjustwall);
      

      // Binding bolt hole cover
      translate([rowingadapterboltx,-bindboltw/2,rowingadapterboltheight]) rotate([90,0,0]) roundedcylinder(boltholecoverd(),(rowingadapterw-bindboltw)/2,cornerd,0,90);
      
      translate([rowingmachinex,-rowingadapterw/2,rowingmachineheight]) roundedbox(rowingsidel,rowingadapteryextend+rowingsideflange,wall,cornerd,4);
      translate([rowingmachinex,-rowingadapterw/2,rowingmachineheight-rowingtopplateh-wall]) roundedbox(rowingsidel,wall,rowingsideh,cornerd,4);
      hull() {
	translate([rowingmachinex,-rowingadapterw/2,rowingmachineheight-rowingtopplateh-wall]) roundedbox(wall,wall,rowingsideh,cornerd,4);
	translate([rowingmachinex,0,rowingmachineheight]) {
	  rotate([0,rowingfrontplatea,0]) {
	    translate([-rowingfrontplatetopl-cornerd/2-wall,-rowingadapterw/2,ztolerance+rowingfrontplatetoph-rowingfrontplateh]) roundedbox(wall+cornerd/2+rowingfrontplatetopl+wall,wall,wall,cornerd,4);
	    translate([-rowingfrontplatetopl-cornerd/2,-rowingadapterw/2,-rowingfrontplateh-ztolerance-wall]) roundedbox(cornerd/2+rowingfrontplatetopl+wall,wall,wall,cornerd,4);
	  }
	}
      }
      hull() {
	translate([rowingmachinex,-rowingadapterw/2,rowingmachineheight]) roundedbox(wall,rowingadapteryextend+rowingsideflange,wall,cornerd,4);
	translate([rowingmachinex,0,rowingmachineheight]) {
	  rotate([0,rowingfrontplatea,0]) {
	    translate([-rowingfrontplatetopl-cornerd/2-wall+wall+cornerd/2+rowingfrontplatetopl,-rowingadapterw/2,ztolerance+rowingfrontplatetoph-rowingfrontplateh]) roundedbox(wall,rowingadapteryextend+rowingsideflange,wall,cornerd,4);
	  }
	}
      }

      translate([rowingmachinex+rowingsideh/2,-rowingadapterw/2,rowingmachineheight-rowingtopplateh-wall]) roundedbox(rowingsidel-rowingsideh/2,rowingadapteryextend+rowingsideflange,wall,cornerd,4);
      translate([rowingmachinex,-rowingadapterw/2,rowingmachineheight-rowingtopplateh-wall]) roundedbox(rowingsidel,rowingadapteryextend-ytolerance,wall,cornerd,4);
  
      translate([rowingmachinex,0,rowingmachineheight]) {
	rotate([0,rowingfrontplatea,0]) {

	  translate([-rowingfrontplatetopl-cornerd/2-wall,-rowingadapterw/2,ztolerance+rowingfrontplatetoph-rowingfrontplateh]) roundedbox(wall+cornerd/2+rowingfrontplatetopl+wall,rowingadapteryextend+rowingsideflange,wall,cornerd,4);
	  translate([-rowingfrontplatetopl-cornerd/2-wall,-rowingadapterw/2,ztolerance]) roundedbox(wall,rowingadapteryextend+rowingsideflange,rowingfrontplatetoph-rowingfrontplateh+wall,cornerd,4);
	  translate([-rowingfrontplatecurvel,-rowingadapterw/2,-rowingfrontplateh-ztolerance-wall]) roundedbox(rowingfrontplatecurvel-rowingfrontplatetopl-xtolerance,wall,rowingfrontplateh+wall*2+ztolerance*2,cornerd,4);
	  difference() {
	    union() {
	      translate([-rowingfrontplatetopl-cornerd/2-xtolerance,-rowingtopplatew/2-ytolerance-wall,-rowingfrontplateh-wall]) roundedbox(xtolerance+cornerd/2+rowingfrontplatetopl+wall,wall,rowingfrontplatetoph+wall*2,cornerd,0);
	      translate([-rowingfrontplatetopl-cornerd/2,-rowingadapterw/2,-rowingfrontplateh-ztolerance-wall]) roundedbox(cornerd/2+rowingfrontplatetopl+wall,rowingadapteryextend-ytolerance,wall,cornerd,4);

	      intersection() {
		union() {
		  translate([-rowingfrontplatetopl,-rowingtopplatew/2-rowingfrontplated/2,-rowingfrontplateh-ztolerance-wall]) cylinder(d=rowingfrontplated-dtolerance,h=rowingfrontplateh+wall*2,$fn=180);
		  for (z=[-rowingfrontplateh-ztolerance-wall,ztolerance]) {
		    translate([-rowingfrontplatetopl,-rowingtopplatew/2-rowingfrontplated/2,z]) roundedcylinder(rowingfrontplated-dtolerance+rowingsideflange*2,wall,cornerd,0,180);
		  }
		}
		translate([-rowingfrontplatecurvel,-rowingadapterw/2,-rowingfrontplateh-ztolerance-wall]) cube([rowingfrontplatecurvel-rowingfrontplatetopl-xtolerance,rowingfrontplatew,rowingfrontplateh+wall*2+ztolerance*2]);
	      }
	    }
	    for (m=[0,1]) mirror([0,m,0]) {
		translate([-rowingfrontplatetopl,-rowingtopplatew/2-rowingfrontplated/2,-rowingfrontplateh-ztolerance]) cylinder(d=rowingfrontplated-dtolerance-wall*2,h=rowingfrontplateh+ztolerance*2,$fn=180);
	      }
	  }
	}
      }
    }
    
    // Binding bolt tap
    if (left) {
      translate([rowingadapterboltx,bindboltw/2,rowingadapterboltheight]) rotate([90,0,180]) m20boltcut(threadlength=(rowingadapterw-bindboltw)/2);
    } else {
      translate([rowingadapterboltx,-bindboltw/2,rowingadapterboltheight]) rotate([90,0,0]) m20boltcut(threadlength=(rowingadapterw-bindboltw)/2);
    }

    // Adjust bolt tap
    if (left) {
      translate([adjustx,adjustw/2+ytolerance,adjustheight]) rotate([-90,0,180]) m20boltcut(threadlength=adjustboltl);
    } else {
      translate([adjustx,-adjustw/2-ytolerance,adjustheight]) rotate([-90,0,0]) m20boltcut(threadlength=adjustboltl);
    }
    
    if (left) {
      translate([adjustx,adjustw/2,adjustheight]) rotate([-90,0,180]) adjustcylindercut();//-90
    } else {
      translate([adjustx,-adjustw/2,adjustheight]) rotate([-90,0,0]) adjustcylindercut();//-90
    }

    translate([rowingmachinex+rowingsidel/2,0,0]) rotate([0,0,left?180:0]) {
      translate([0,-rowingadapterw/2+textdepth-0.01,rowingmachineheight-rowingsideh/2+textsize/2+1]) rotate([90,0,0]) linear_extrude(textdepth) text(brandtext,size=textsize,font=textfont,valign="center",halign="center");
      translate([0,-rowingadapterw/2+textdepth-0.01,rowingmachineheight-rowingsideh/2-textsize/2-1]) rotate([90,0,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
    }
  }
}

if (print==0) {
  intersection() {
    //if (debug) translate([-200,-coverclipytable[0],-200]) cube([400,400,400]);
    if (debug) translate([adjustx+2,-200,-200]) cube([200+adjustx+2,400,400]);
    union() {
      if (tunturicrosstrainerversion) topattach();
      if (waterrowerversion) {
	rowerattach();
	for (lft=[0,1]) rowerattachsidepart(left=lft);
	rowerattachbinder();
	if (1) {
	  #	translate([rowingadapterboltx,-bindboltw/2+wall,rowingadapterboltheight]) rotate([90,0,0]) m20bolt(threadlength=bindboltl,boltbaseh=bindboltbaseh,text=versiontext);
	  #	translate([rowingadapterboltx,bindboltw/2-wall,rowingadapterboltheight]) rotate([90,0,180]) m20bolt(threadlength=bindboltl,boltbaseh=bindboltbaseh,text=versiontext);
	  #	translate([adjustx,-adjustw/2-ytolerance-adjustwall,adjustheight]) rotate([-90,0,0]) m20bolt(threadlength=adjustboltl,nothreadlength=adjustwall,boltbaseh=adjustboltbaseh,text=versiontext);
	  #	translate([adjustx,adjustw/2+ytolerance+adjustwall,adjustheight]) rotate([-90,0,180]) m20bolt(threadlength=adjustboltl,nothreadlength=adjustwall,boltbaseh=adjustboltbaseh,text=versiontext);
	}
      }
      
      backattach();
      translate([urax+ural,0,urah-wall-wall/2]) translate([0,0,tabletheight]) rotate([0,tableta,0]) #tablet();
      
      if (tunturicrosstrainerversion) for (m=[0,1]) mirror([0,m,0]) %tanko();

      if (waterrowerversion) %rowingmachine();
      
      for (y=[coverclipytable[0],coverclipytable[2]]) for (x=coverclipxtable) for (m=[0,1]) mirror([0,m,0]) {
	      translate([x,y,coverclipz]) {
		#	    rotate([0,0,0]) lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,0,text=versiontext,textdepth=0.7,xtolerance=xtolerance,ytolerance=ytolerance);
	      }
	    }
    }
  }
  translate([230/2,0,-248]) %printareacube("ankermake");
 }

if (print==1 || print==3) {
  translate([0,0,wall]) rotate([0,180,0]) topattach();
 }

if (print==2 || print==3) {
  translate([-topl-wall-1,0,0]) {
    rotate([0,-90,0]) translate([-supportx,0,-wall-xtolerance])  backattach();
    for (i=[0:1:5]) {
      translate([-margin-covercliptotalh/2-wall-0.5,(i-3)*topw/6+topw/12,coverclipw/2]) rotate([90,0,90]) lockclip(coverclipl,coverclipw,covercliph,coverclipoverhang,cornerd,0,text=versiontext,textdepth=0.7,xtolerance=xtolerance,ytolerance=ytolerance);
    }
  }
 }


if (print==4 || print==7) {
  translate([9.8,0,0]) rotate([180,0,0]) translate([supportx,0,-wall]) rowerattach();
 }

if (print==5 || print==7) {
  translate([0,0,0]) {
    for (y=[-boltbased()-0.5,boltbased()+0.5]) {
      translate([0,y-boltbased/2-0.25,bindboltbaseh]) m20bolt(threadlength=bindboltl,boltbaseh=bindboltbaseh,text=versiontext);  
      translate([0,y+boltbased/2+0.25,adjustboltbaseh]) m20bolt(threadlength=adjustboltl,nothreadlength=adjustwall,boltbaseh=adjustboltbaseh,text=versiontext);
    }
  }
 }

if (print==6 || print==7) {
  translate([boltbased()+rowingadapterboltx-17,0,0]) rotate([0,-90,0]) translate([-rowingmachinex-wall,0,-rowingmachineheight-ztolerance]) rowerattachbinder();
 }

    
if (print==8 || print==10) {
  rotate([90,0,0]) translate([0,rowingadapterw/2,-rowingmachineheight]) rowerattachsidepart();
 }

if (print==9 || print==10) {
  translate([156,-20,0]) rotate([-90,0,215.5]) translate([0,-rowingadapterw/2,-rowingmachineheight]) rowerattachsidepart(left=1);
 }

if (print==20) {
  translate([-9,9,0]) intersection() {
    translate([23,-40,0]) cube([25,25,30]); 
    rotate([90,0,0]) translate([0,rowingadapterw/2,-rowingmachineheight]) rowerattachsidepart();
  }
  translate([0,0,bindboltbaseh]) m20bolt(threadlength=bindboltl,nothreadlength=adjustwall,boltbaseh=bindboltbaseh,text=versiontext);  
 }
