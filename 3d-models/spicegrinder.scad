// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <text_on_OpenSCAD/text_on.scad>

$fn=60;

// 1=body, 2=bottom, 3=knob, 4=all;

print=0;

abs=0;

debug=1;

knobangle=(print>0?0:180); // 180

dtolerance=0.5;
axledtolerance=0.3;
axletolerance=0.25;
bearingaxledtolerance=0.8;
bearingaxletolerance=0.5;
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

wall=2;
cornerd=2;

screwd=4.4; // M5
screwheadd=8.5; //8.6; // Round head
screwheadh=3.1;
screwheadspaceh=6;
screwl=23.15;
nutd=7;
nuth=2.3;

upperadjust=2;

uppermaxd=49.6; // 49.3;
uppermind=47.2; //46.5;
upperh=18.5; //19.70;
uppernotchd=12; // estimate
uppernotches=15;
upperfingerholes=4;
upperfn=90;
upperfingerholew=21;
kaulad=44; // 46;// 43.4;
kaulah=12.5; // 4.42;
kaulanarrowd=39.3;// 38.6;
kaulanarrowh=2.7+0.3;
upperfingerholesh=kaulanarrowh;

handlekaulanarrowstart=2.1; // To be able to print, need to start higher.
handlekaulanarrowd=(kaulad+kaulanarrowd)/2;

topd=51; // 50.72;
toph=24.7;
topstraighth=7;
lowd=50.40;
lowbased=35;
lowh=26-3.1;
lowstraighth=15.3-3.1;
lownotches=40;
lownotchdepth=0.6;
lownotchd=3;
bodyh=102.7-0.3;
middled=44.8;//45.15;
middleh=bodyh-toph-lowh;
middleheight=lowh;
topheight=lowh+middleh;
kaulanarrowheight=topheight+toph;
kaulaheight=kaulanarrowheight+kaulanarrowh;

upperheight=kaulaheight+kaulah;
upperfingerholeh=kaulah-(uppermaxd-kaulad)/2;
upperfingerholeheight=kaulaheight-ztolerance;

totalheight=136.4; // 137.6; // Does not include cap 
bottomd=140;
bottomraise=3.38;

echo("middleheight ",middleheight," topheight ",topheight," kaulanarrowheight ", kaulanarrowheight, " kaulaheight ",kaulaheight," upperheight ",upperheight);

baseheight=-wall-ztolerance;

versiontext=str("V1.5");
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

knobdistance=53;
knobd=20;
knobh=30;
knobshaftnarrowing=0.5;
knobshaftd=15;
knobshaftnarrowd=knobshaftd-knobshaftnarrowing*2;
knobheight=20+ztolerance;
knobshaftnarrowh=2;
knobshaftnarrowheight=knobheight+1.5;
knobshafth=20+ztolerance+knobh; // knobheight+knobh;
knobbodyw=knobshaftd+10;
knobaxled=7;
knobaxleheight=1+knobaxled/2; // From base
knobaxledepth=2;
knobsupportwall=4;
knobsupporth=15;// knobaxleheight+knobaxled/2+knobsupportwall;
knobstopperh=knobsupporth-cornerd; // knobheight-cornerd;
knobstoppermovingh=knobstopperh-knobaxleheight;
knobspringin=1;
knobspringa=10;
knobspringcut=1;
knobspringh=6.5;

bearings=8;
bearingaxled=6;
bearingdepth=1.5;
bearingl=5;
bearingspace=0.5;
bearingsink=bearingaxletolerance/2+dtolerance/2;
totalbearingh=bearingdepth+bearingl+bearingdepth;

handleh=topheight+toph-middleheight-totalbearingh;
handleheight=middleheight+totalbearingh;

knobclipd=4;
knobclipsink=0.6+axledtolerance/2; //1.3;
knobclipheight=baseheight+knobaxled/2+0.7;//+knobclipd/2;
knobclipyoffset=knobaxled/2+5+knobclipd/2;
knobcliptolerance=0.3;

echo("totalheight ", totalheight, " upperheight + upperh ",upperheight+upperh);

module millbody() {
  difference() {
    hull() {
      translate([0,0,0]) roundedcylinder(lowd,lowstraighth,cornerd,1,90);
      translate([0,0,0]) cylinder(d=middled,h=lowh);
    }

    translate([0,0,bottomraise-bottomd/2]) sphere(d=bottomd);

    for (a=[0:360/lownotches:359]) {
      rotate([0,0,a]) translate([0,0,-lownotchd/2+lownotchdepth]) rotate([0,90,0]) cylinder(d=lownotchd,h=lowd);
    }
  }

  translate([0,0,lowh-0.1]) cylinder(d=middled,h=middleh+0.2);

  hull() {
    translate([0,0,topheight]) cylinder(d=middled,h=toph);
    translate([0,0,topheight+toph-topstraighth]) cylinder(d=topd,h=topstraighth);
  }

  translate([0,0,kaulanarrowheight-0.1]) cylinder(d=kaulanarrowd,h=kaulanarrowh+0.2);
  translate([0,0,kaulaheight]) cylinder(d=kaulad,h=kaulah+0.1);
  
  difference() {
    translate([0,0,upperheight]) cylinder(d=uppermaxd,h=upperh);

    for (a=[0:360/uppernotches:359]) {
      rotate([0,0,a]) translate([uppermind/2+uppernotchd/2,0,upperheight-0.1]) cylinder(d=uppernotchd,h=upperh+0.2);
    }
  }
}

module millhandle() {
  difference() {
    union() {
      translate([0,0,kaulanarrowheight]) cylinder(d=topd+wall*2+dtolerance,h=kaulanarrowh-ztolerance);
      translate([0,0,kaulaheight-ztolerance]) ring(kaulad+wall*2+dtolerance,wall,kaulah,0,90);
      translate([0,0,upperheight-wall-ztolerance+upperadjust]) ring(uppermaxd+wall*2+dtolerance,wall,upperh+wall+ztolerance-upperadjust,0,upperfn);
      translate([0,0,upperheight-wall-ztolerance+(kaulad-uppermaxd)/2+upperadjust]) cylinder(d1=kaulad+wall*2+dtolerance,d2=uppermaxd+wall*2+dtolerance,h=(uppermaxd-kaulad)/2,$fn=upperfn);
      intersection() {
	for (a=[0:360/uppernotches:359]) {
	  rotate([0,0,a]) translate([uppermind/2+uppernotchd/2+dtolerance/2,0,upperheight-wall-ztolerance]) cylinder(d=uppernotchd,h=upperh+wall+ztolerance);
	}
	translate([0,0,upperheight-wall-ztolerance+upperadjust]) cylinder(d=uppermaxd+wall*2+dtolerance,h=upperh+wall+ztolerance-upperadjust,$fn=upperfn);
      }
      hull() {
	//translate([0,0,handleheight]) ring(topd+wall*2+dtolerance,wall,handleh,0,90);
	translate([0,0,handleheight]) cylinder(d=topd+wall*2+dtolerance,h=handleh);
	for (a=[0:360/bearings:359]) {
	  rotate([0,0,a]) translate([topd/2+bearingaxled/2-bearingsink,0,handleheight]) cylinder(d=bearingaxled+wall+bearingspace*2,h=bearingdepth+bearingl+bearingdepth);
	}
      }
    }

    rotate([0,0,90]) translate([0,0,upperheight-wall-ztolerance+upperadjust]) text_on_cylinder(t=versiontext,r=(uppermaxd+wall*2+dtolerance)/2-textdepth/2+0.01,h=upperh+wall+ztolerance-upperadjust,size=textsize,font=textfont,extrusion_height=textdepth);
    
    translate([0,0,handleheight-0.01]) cylinder(d=topd+dtolerance,h=kaulanarrowheight-handleheight+0.02);
    
    union() {
      translate([0,0,kaulanarrowheight-0.01]) cylinder(d1=topd+dtolerance,d2=handlekaulanarrowd+dtolerance,h=handlekaulanarrowstart+0.02);
      translate([0,0,kaulanarrowheight+handlekaulanarrowstart-0.1]) cylinder(d=handlekaulanarrowd+dtolerance,h=kaulanarrowh-handlekaulanarrowstart+0.2);
      translate([0,0,kaulaheight-0.1]) cylinder(d=kaulad+dtolerance,h=kaulah+0.2);
    }

    for (a=[0:360/upperfingerholes:359]) {
      rotate([0,0,a]) translate([0,-upperfingerholew/2,upperfingerholeheight]) {
	hull() {
	  intersection() {
	    triangle(uppermaxd+wall,upperfingerholew,upperfingerholew,22);
	    cube([uppermaxd+wall,upperfingerholew,upperfingerholeh]);
	  }
	  translate([0,0,-upperfingerholesh+0.01]) roundedbox(uppermaxd+wall,upperfingerholew,upperfingerholesh+cornerd/2,cornerd);
	}
      }
    }

    for (a=[0:360/bearings:359]) {
      rotate([0,0,a]) translate([topd/2+bearingaxled/2-bearingsink,0,handleheight+bearingl/2+bearingdepth]) rotate([90,0,0]) hull() onehinge(bearingaxled,bearingl,bearingdepth,2,bearingaxletolerance,bearingaxledtolerance);
      hull() {
	rotate([0,0,a]) translate([topd/2+bearingaxled/2-bearingsink,0,handleheight+bearingdepth]) cylinder(d=bearingaxled+bearingaxledtolerance,h=bearingl);
	rotate([0,0,a]) translate([topd/2+bearingaxled/2-bearingsink,0,handleheight+bearingdepth+bearingspace]) cylinder(d=bearingaxled+bearingspace*2+bearingaxledtolerance,h=bearingl-bearingspace*2);
      }
    }
  }

  for (a=[0:360/bearings:359]) {
    rotate([0,0,a]) translate([topd/2+bearingaxled/2-bearingsink,0,handleheight+bearingl/2+bearingdepth]) rotate([90,0,0]) hull() onehinge(bearingaxled,bearingl,bearingdepth,0,bearingaxletolerance,bearingaxledtolerance);
  }
}

rotormiddlethickness=max(topd-middled-wall,wall);

module knobaxleandclip(cutout) {
  translate([knobdistance,0,baseheight+knobaxleheight]) rotate([0,0,90]) onehinge(knobaxled,knobshaftd,knobaxledepth,cutout?2:0,axletolerance,axledtolerance);
  translate([0,0,baseheight+knobaxleheight]) rotate([cutout?180:knobangle,0,0]) {
    for (x=[-knobshaftd/2-knobclipsink+knobclipd/2,knobshaftd/2+knobclipsink-knobclipd/2]) {
      translate([knobdistance+x,-knobclipyoffset,knobclipheight]) sphere(d=knobclipd+(cutout?dtolerance:0));
    }
  }
}

module millrotor() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([0,0,middleheight]) cylinder(d=middled+dtolerance+rotormiddlethickness,h=middleh*2/3);
	  difference() {
	    hull() {
	      hull() {
		translate([0,0,middleheight]) cylinder(d=middled+dtolerance+rotormiddlethickness,h=0.01);
		translate([0,0,lowstraighth]) ring(lowd+dtolerance+wall*2,wall,0.01,0,90);
		translate([0,0,middleheight]) cylinder(d=middled+dtolerance+rotormiddlethickness,h=totalbearingh); //middleh*1/3
		for (y=[-middled/2+wall/2-screwheadd/2,middled/2+screwheadd/2-wall/2]) {
		  translate([-screwl/2,y,middleheight]) rotate([0,90,0]) cylinder(d=screwheadd+wall*2,h=screwl);
		}
	      }
	      hull() {
		translate([0,0,baseheight]) roundedcylinder(lowd+dtolerance+wall*2,lowstraighth+ztolerance+wall,cornerd,1,90); //ring(lowd+dtolerance+wall*2,wall,lowstraighth,0,90);
		translate([knobdistance-knobshaftd/2-dtolerance/2-knobsupportwall,-knobaxled/2-knobsupportwall,baseheight]) roundedbox(knobsupportwall,knobaxled+knobsupportwall+cornerd/2+knobstopperh,knobsupporth,cornerd,1);
	      }
	    }

	    knobaxleandclip(1);
	  }

	  // Knob rotating shaft
	  translate([0,0,baseheight+knobaxleheight]) rotate([knobangle,0,0]) union() {
	    difference() {
	      union() {
		hull() {
		  translate([knobdistance,0,-knobaxleheight]) roundedcylinder(knobshaftd,knobshaftnarrowheight-knobshaftnarrowing,cornerd,1,90);
		  translate([knobdistance,0,-knobaxleheight]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowheight);
		}

		translate([knobdistance,0,-knobaxleheight+knobshaftnarrowheight-0.1]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowing+knobshaftnarrowh+0.2);
		hull() {
		  translate([knobdistance,0,-knobaxleheight+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=knobshaftd,h=knobshafth-knobshaftnarrowheight-knobshaftnarrowh*2);
		  translate([knobdistance,0,-knobaxleheight+knobshaftnarrowheight+knobshaftnarrowh]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowing);
		}
	      }
	    }

	    // Stopper
	    hull() {
	      translate([knobdistance-knobshaftd/2,-knobshaftd/2,-knobaxleheight]) roundedbox(knobshaftd,knobshaftd/2+cornerd/2,cornerd,cornerd,1);
	      translate([knobdistance-knobshaftd/2,-knobshaftd/2-knobstoppermovingh,-knobaxleheight+knobstoppermovingh]) roundedbox(knobshaftd,knobshaftd/2+knobstoppermovingh+cornerd/2,cornerd,cornerd,1);
	      translate([knobdistance-knobshaftd/2,-knobshaftd/2,-knobaxleheight+knobstopperh]) roundedbox(knobshaftd,knobshaftd/2+cornerd/2,cornerd,cornerd,1);
	    }
	  }

	  knobaxleandclip(0);

	  // Knob axle support

	  // Sides
	  difference() {
	    for (x=[-knobshaftd/2-dtolerance/2-knobsupportwall,knobshaftd/2+dtolerance/2]) {
	      translate([knobdistance+x,-knobaxled/2-knobsupportwall,baseheight]) roundedbox(knobsupportwall,knobaxled+knobsupportwall+cornerd/2+knobstopperh+dtolerance/2,knobsupporth,cornerd,1);
	    }

	    if (0) {
	      translate([knobdistance,0,baseheight+knobaxleheight]) rotate([0,0,90]) onehinge(knobaxled,knobshaftd,knobaxledepth,2,axletolerance,axledtolerance);
	      for (x=[-knobshaftd/2-knobclipsink+knobclipd/2,knobshaftd/2+knobclipsink-knobclipd/2]) {
		translate([knobdistance+x,0,knobclipheight]) sphere(d=knobclipd+dtolerance);
	      }
	    }
	    knobaxleandclip(1);
	  }

	  // Stopper counter face
	  difference() {
	    hull() {
	      w=knobsupportwall+dtolerance/2+knobshaftd+dtolerance/2+knobsupportwall;
	      translate([knobdistance-w/2,knobshaftd+cornerd/2,baseheight]) roundedbox(w,cornerd,cornerd,cornerd,1);
	      translate([knobdistance-w/2,knobshaftd+cornerd/2-knobstopperh,baseheight+knobstopperh]) roundedbox(w,knobstopperh+cornerd,cornerd,cornerd,1);
	    }

	    translate([knobdistance,0,baseheight]) cylinder(d=knobshaftd+dtolerance,h=knobsupporth+ztolerance);
	  }
	}

	for (y=[-middled/2-screwheadd/2,middled/2+screwheadd/2]) {
	  hull() {
	    translate([-screwl/2-middled/4,y,middleheight]) rotate([0,90,0]) cylinder(d=screwd,h=screwl+middled/2);
	    translate([-screwl/2-middled/4,y-screwd/4,middleheight]) cube([screwl+middled/2,screwd/2,screwd/2]);
	  }

	  translate([-screwl/2,y,middleheight]) rotate([0,90,0]) cylinder(d=nutd/cos(180/6),h=nuth,$fn=6); //;screwheadh);
	  hull() {
	    translate([-screwl/2-middled/4,y,middleheight]) rotate([0,90,0]) cylinder(d=nutd/cos(180/6),h=middled/4+0.01,$fn=6); //;screwheadh);
	    translate([-screwl/2-middled/4-middled/2,y,middleheight+middled/2]) rotate([0,90,0]) cylinder(d=nutd/cos(180/6),h=middled/4+nuth,$fn=6); //;screwheadh);
	  }
	  hull() {
	    translate([screwl/2-screwheadh,y,middleheight]) rotate([0,90,0]) cylinder(d=screwheadd,h=screwheadd+middled/4);
	    translate([screwl/2-screwheadh+middled/2,y,middleheight+middled/2]) rotate([0,90,0]) cylinder(d=screwheadd,h=screwheadd+middled/4);
	  }
	}


	hull() {
	  translate([0,0,baseheight-0.1]) cylinder(d=lowd+dtolerance,h=lowstraighth+wall+ztolerance+0.2);
	  translate([0,0,lowstraighth-0.1]) cylinder(d=middled+dtolerance,h=lowh-lowstraighth+0.2);
	}
      }
     
      translate([0,0,-wall-ztolerance]) roundedcylinder(lowd+dtolerance+wall*2,wall,cornerd,1,90);// cylinder(d=lowd+dtolerance+wall*2,h=wall);
      difference() {
	translate([0,0,-wall-ztolerance]) roundedcylinder(lowd+dtolerance+wall*2,wall+wall,cornerd,1,90);
	translate([0,0,-wall-ztolerance-0.1]) cylinder(d=lowd+dtolerance+wall,h=wall+wall+0.2);
      }

      intersection() {
	for (a=[0:360/lownotches:359]) {
	  rotate([0,0,a]) translate([0,0,-lownotchd/2+lownotchdepth-ztolerance]) rotate([0,90,0]) cylinder(d=lownotchd-dtolerance,h=lowd/2+wall-cornerd/2);
	}

	translate([0,0,-wall-ztolerance]) cylinder(d=lowd+dtolerance+wall*2,h=lownotchd+wall);
      }
    }

    translate([knobdistance+knobshaftd/2+dtolerance/2+knobsupportwall-textdepth+0.01,-knobaxled/2-knobsupportwall+(knobaxled+knobsupportwall+cornerd/2+knobstopperh)/2,baseheight+knobsupporth/2]) rotate([90,0,90]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");

    translate([0,0,middleheight-0.1]) cylinder(d=middled+dtolerance,h=middleh);

    translate([0,0,-wall-ztolerance-0.1]) cylinder(d=lowbased,h=wall+lownotchd+0.2);
  }
}

module knob() {
  difference() {
    union() {
      translate([0,0,-knobaxleheight+knobshaftnarrowheight]) roundedcylinder(knobd,knobh,cornerd,2,90);
    }
    
    translate([0,0,-knobaxleheight+knobshaftnarrowheight+knobspringin-0.1]) cylinder(d=knobshaftnarrowd+dtolerance,h=knobshaftnarrowh-knobspringin+0.2);
    translate([0,0,-knobaxleheight+knobshaftnarrowheight-0.1]) cylinder(d1=knobshaftd+dtolerance*2,d2=knobshaftnarrowd+dtolerance,h=knobshaftnarrowh-knobspringin+0.2);
    hull() {
      translate([0,0,-knobaxleheight+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=knobshaftd+dtolerance,h=knobshafth-knobshaftnarrowheight-knobshaftnarrowh*2+ztolerance);
      translate([0,0,-knobaxleheight+knobshaftnarrowheight+knobshaftnarrowh]) cylinder(d=knobshaftnarrowd+dtolerance,h=knobshaftnarrowing);
    }
    translate([0,0,-knobaxleheight+knobshaftnarrowheight-0.1]) ring(knobd-2,knobshaftnarrowing,knobspringh,0,90);
    for (a=[0:360/knobspringa:359]) {
      rotate([0,0,a]) translate([0,-knobspringcut/2,-knobaxleheight+knobshaftnarrowheight-0.1]) cube([(knobd-2)/2,knobspringcut,knobspringh]);
    }

    translate([0,0,-knobaxleheight+knobshaftnarrowheight+knobh-textdepth+0.01]) linear_extrude(textdepth) text(versiontext,size=textsize-1,font=textfont,valign="center",halign="center");

  }
}

module mill()  {
  millbody();
}

if (print==0) {
  #mill();

  intersection() {
    union() {
      millhandle();
      millrotor();
      translate([knobdistance,0,baseheight+knobaxleheight]) rotate([knobangle,0,0]) knob();
    }
  
    if (debug) translate([-100,knobclipyoffset,-100]) cube([200,200,300]);
  }
 }

if (print==1 || print==4) {
  translate([0,0,-handleheight]) millhandle();
 }

if (print==2 || print==4) {
  rotorx=lowd/2+wall+(lowd+dtolerance+wall)/2+bearingspace+bearingaxled;
  translate([rotorx+0.5,0,-baseheight]) intersection() {
    millrotor();
    translate([-200,-200,-200]) cube([200,400,400]);
  }
  translate([rotorx+1,0,-baseheight]) intersection() {
    millrotor();
    translate([0,-200,-200]) cube([200,400,400]);
  }
 }

if (print==3 || print==4) {
  translate([0,0,knobh]) rotate([180,0,0]) translate([0,0,knobaxleheight-knobshaftnarrowheight]) knob();
 }

if (print==4) {
  if (abs) antiwarpwall(-27,-32,95,144,64,95);
 }

