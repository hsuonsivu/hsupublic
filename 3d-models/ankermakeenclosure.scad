// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// todo
// fingerclip
// 

include <hsu.scad>

print=1;

lightenthin=1; // Make various areas very thin to reduce printing time and material consumption.
lightenx=lightenthin?0.4:0;
lighteny=lightenthin?0.4:0;
lightenz=lightenthin?0.2:0;

lmargin=10;
lfill=8;

maxbridge=10;

b=800;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

maxy=240; // 250 really, but leave some space
wall=1.2; // Just wall to block airflow, no strength
mediumwall=2.0; // Thicker wall when structural strength may be needed

baseh=58; // Under z=0
baseheight=-baseh;
basew=426;
basel=434;
basey=-273;

towerh=416;//410;
towerw=64;
towerl=70;
towerdistance=272;
towerfreecap=16.5;
towerfreespaceabove=130;

maxh=394; // Only towers are higher than this
maxtotower=towerh-maxh;

topbarh=25.5;
topbarheight=towerh-18.8-topbarh; // measured 395 should be
echo(topbarheight);

topbarl=18.1; //19;
topbarfromtowerback=5.5;
topbary=towerl-topbarfromtowerback-topbarl;

topcoverh=150;
topcoverfrontl=160; // From back of towers
topcoverbackl=130; // From back of towers
topcoverfronty=towerl-topcoverfrontl;
topcoverbacky=towerl+topcoverbackl;
topcoverw=towerdistance+towerw;

backw=towerdistance+wall*2+2*9; // TARKISTA CORNER
backl=195-towerl;//190-towerl;
backbottomextension=15;
backmidflangew=2*mediumwall;
backmidflangel=8;
backflangew=5;
backflangel=wall;
backcornerfill=5;
backoverbase=towerl+backl-(basey+basel)+ytolerance-36;

spoolholderh=40;
spoolholderw=40;
spoolholderlength=244;
spoolholderl=8.3;
spoolholderheight=329;
spoolholderx=-towerdistance/2-towerw/2-spoolholderl/2+spoolholderw/2-spoolholderlength;

trayh=3.5;
lefttrayedgeh=45;
righttrayedgeh=25;

gantrymovement=305-55; // 333-85; //300; //250; // TARKISTA

//45 65
leftboxw=72;
leftboxl=65;
leftboxh=132;
leftboxx=-38-leftboxw-towerdistance/2; // TARKISTA
leftboxy=-49;//-leftboxl;

leftboxbottomheight=12;
leftboxtopheight=leftboxbottomheight+gantrymovement; // Including left box h

filamenty=42;
filamentd=10;
filamentw=1;
filamenttubed=4;
filamenttubew=10;
filamentheight=105;

rightboxw=81.5;//74;
rightboxl=94; // y size
rightboxh=128;
rightboxx=towerdistance/2+39;

cameray=14; // camera position y size (from back)
cameraw=10;
cameral=36;
camerah=45;
cameraheight=0; // TARKISTA relative to bottom of right box

rightboxbottomheight=12;
rightboxtopheight=rightboxbottomheight+gantrymovement;

rightboxy=-74;

printplateheight=25;
printplateh=5;
printplatew=250;
magnetplatetabl=17;
magnetplatetabw=153;
printplatel=250;
printplatefronty=-332+magnetplatetabl; // Print plate when in front position
printplatebacky=190-printplatel; // Print plate when in back position

gantryw=360;
gantryl=18.5;
gantryh=28.1;
gantrybottomheight=84.6-gantryh;
gantryy=-20.6;
gantrytopheight=gantrybottomheight+gantrymovement;

printheadw=97.5;
printheadl=65;
printheadh=101.5; // Including nozzle
printheadleftx=-35.5-towerdistance/2; // TARKISTA
printheadrightx=towerdistance/2-70.8;
printheady=gantryy-printheadl;
printheadbottomheight=printplateheight+printplateh;
printheadtopheight=printheadbottomheight+gantrymovement;

midcovery=printheady-10;

midcoverx=leftboxx-2;
midcoverrightx=towerdistance/2+towerw;
midcoverrightw=rightboxx+rightboxw+2-midcoverrightx;

frontw=300;
fronty=printplatefronty-magnetplatetabl-3;
fronth=printplateheight+printplateh+250;
frontflange=5;
frontunderflange=(frontw-printplatew)/2;

module leftbox() {
  cube([leftboxw,leftboxl,leftboxh]);
  translate([-filamentw,filamenty,filamentheight]) rotate([0,90,0]) cylinder(d=filamentd,h=filamentw);
  translate([0.01,filamenty,filamentheight]) rotate([0,-90,0]) cylinder(d=filamenttubed,h=filamenttubew+0.01);
}

module ankermakem5() {
  if (0) {
    translate([-basew/2,basey,baseheight]) cube([basew,basel,baseh]);

    translate([-towerdistance/2,topbary,topbarheight]) cube([towerdistance,topbarl,topbarh]);

    translate([spoolholderx,towerl,spoolholderheight]) cube([spoolholderlength,spoolholderl,spoolholderh]);
  
    translate([-towerw-towerdistance/2,0,0]) cube([towerw,towerl,towerh]);
    translate([towerdistance/2,0,0]) cube([towerw,towerl,towerh]);

    translate([-printplatew/2,printplatefronty,printplateheight]) cube([printplatew,printplatel,printplateh]);
    translate([-magnetplatetabw/2,printplatefronty-magnetplatetabl,printplateheight]) cube([magnetplatetabw,magnetplatetabl,printplateh]);

    translate([leftboxx,leftboxy,leftboxbottomheight]) leftbox();
  
    translate([rightboxx,rightboxy,rightboxbottomheight]) cube([rightboxw,rightboxl,rightboxh]);
    translate([rightboxx-cameraw,rightboxy+cameray,rightboxbottomheight+cameraheight]) cube([cameraw,cameral,camerah]);

    translate([-gantryw/2,gantryy,gantrybottomheight]) cube([gantryw,gantryl,gantryh]);

    translate([printheadleftx,printheady,printheadbottomheight]) cube([printheadw,printheadl,printheadh]);
  
    color("yellow") {
      translate([-printplatew/2,printplatebacky,printplateheight]) cube([printplatew,printplatel,printplateh]);
      translate([-magnetplatetabw/2,printplatebacky-magnetplatetabl,printplateheight]) cube([magnetplatetabw,magnetplatetabl,printplateh]);
  
      translate([leftboxx,leftboxy,leftboxtopheight]) leftbox();

      translate([rightboxx,rightboxy,rightboxtopheight]) cube([rightboxw,rightboxl,rightboxh]);
      translate([rightboxx-cameraw,rightboxy+cameray,rightboxtopheight+cameraheight]) cube([cameraw,cameral,camerah]);

      translate([-gantryw/2,gantryy,gantrytopheight]) cube([gantryw,gantryl,gantryh]);

      translate([printheadrightx,printheady,printheadbottomheight]) cube([printheadw,printheadl,printheadh]);
      translate([printheadleftx,printheady,printheadtopheight]) cube([printheadw,printheadl,printheadh]);
      translate([printheadrightx,printheady,printheadtopheight]) cube([printheadw,printheadl,printheadh]);
    }
  } else {
    translate([0.5,-62.5,-49.47]) import("M5-Printer.stl", convexity=3);
  }
}

module backcover() {
  // top bar
  translate([-towerdistance/2+xtolerance,topbary-mediumwall,topbarheight]) cube([towerdistance-xtolerance*2,mediumwall,topbarh+mediumwall]);
  translate([-towerdistance/2+xtolerance,topbary-mediumwall,topbarheight+topbarh]) cube([towerdistance-xtolerance*2,topbarl+mediumwall+topbarfromtowerback+mediumwall,mediumwall]);
  translate([-towerdistance/2+xtolerance,topbary+topbarl,topbarheight]) cube([towerdistance-xtolerance*2,mediumwall,topbarh+mediumwall]);

  for (x=[-towerdistance/2+xtolerance,towerdistance/2-xtolerance-mediumwall]) {
    translate([x,topbary+topbarl,topbarheight]) cube([mediumwall,topbarfromtowerback+ytolerance+mediumwall,topbarh+wall]);
  }
  
  for (x=[-backw/2-xtolerance,towerdistance/2-xtolerance-mediumwall]) {
    translate([x,topbary+topbarl+topbarfromtowerback+ytolerance,topbarheight]) cube([(backw-towerdistance)/2+mediumwall+xtolerance*2,mediumwall,topbarh+wall]);
  }
  
  translate([-backw/2-xtolerance-backflangew,topbary+topbarl+topbarfromtowerback+ytolerance,backbottomextension]) cube([backflangew,mediumwall,spoolholderheight-spoolholderh/2-backbottomextension]);
  translate([backw/2,topbary+topbarl+topbarfromtowerback+ytolerance,backbottomextension]) cube([backflangew,mediumwall,topbarheight+topbarh+mediumwall-backbottomextension]);    

  difference() {
    translate([-backw/2-wall/2,topbary+topbarl+topbarfromtowerback+ytolerance,topbarheight+topbarh+mediumwall-wall]) cube([backw+wall,backl+wall-ytolerance,wall]);
    translate([-backw/2-wall/2+lmargin,topbary+topbarl+topbarfromtowerback+ytolerance+lmargin,topbarheight+topbarh+mediumwall-wall-0.01]) cube([backw+wall-lmargin*2,backl+wall-ytolerance-lmargin*2,wall-lightenz+0.01]);
  }

  for (x=[-backw/2-wall/2,backw/2-wall/2]) {
    difference() {
      hull() {
	translate([x,towerl+ytolerance,backbottomextension]) cube([wall,wall,wall]);
	translate([x,towerl+backl,printplateheight]) cube([wall,wall,wall]);
	translate([x,towerl+ytolerance,topbarheight+topbarh]) cube([wall,backl+wall-ytolerance,wall]);
      }

      translate([x+((x<0)?lightenx:0),towerl+ytolerance,printplateheight]) lighten(backl,topbarheight+topbarh-printplateheight,wall-lightenx,lmargin,lfill,maxbridge,"down-yplane");
    }
  }
  difference() {
    translate([-backw/2-wall/2,towerl+backl,printplateheight]) cube([backw,wall,topbarheight+topbarh+wall-printplateheight]);
    translate([-backw/2-wall/2,towerl+backl,printplateheight]) lighten(backw,topbarheight+topbarh+wall-printplateheight,wall-lighteny,lmargin,lfill,maxbridge,"down-xplane");
  }

  //for (x=[-backw/2-wall/2,backw/2-wall/2-backbottomextension]) {

  hull() {
    translate([-backw/2-wall/2,towerl+ytolerance,backbottomextension]) cube([wall,wall,mediumwall]);
    translate([-backw/2-wall/2+backbottomextension,towerl+ytolerance,0]) cube([wall,wall,mediumwall]);
    translate([-backw/2-wall/2+backbottomextension,basey+basel-ytolerance-backoverbase,0]) cube([wall,wall,mediumwall]);
  }
  hull() {
    translate([-backw/2-wall/2,towerl+ytolerance,backbottomextension]) cube([wall,wall,mediumwall]);
    translate([-backw/2-wall/2,towerl+backl,printplateheight]) cube([wall,wall,mediumwall]);
    translate([-backw/2-wall/2+backbottomextension,basey+basel-ytolerance-backoverbase,0]) cube([wall,wall,mediumwall]);
  }
  hull() {
    translate([-backw/2-wall/2,towerl+backl,printplateheight]) cube([wall,wall,mediumwall]);
    translate([-backw/2-wall/2+backbottomextension,basey+basel-ytolerance-backoverbase,0]) cube([wall,wall,mediumwall]);
    translate([backw/2-wall/2,towerl+backl,printplateheight]) cube([wall,wall,mediumwall]);
    translate([backw/2-wall/2-backbottomextension,basey+basel-ytolerance-backoverbase,0]) cube([wall,wall,mediumwall]);
  }
  hull() {
    translate([backw/2-wall/2,towerl+ytolerance,backbottomextension]) cube([wall,wall,mediumwall]);
    translate([backw/2-wall/2,towerl+backl,printplateheight]) cube([wall,wall,mediumwall]);
    translate([backw/2-wall/2-backbottomextension,basey+basel-ytolerance-backoverbase,0]) cube([wall,wall,mediumwall]);
  }
  hull() {
    translate([backw/2-wall/2,towerl+ytolerance,backbottomextension]) cube([wall,wall,mediumwall]);
    translate([backw/2-wall/2-backbottomextension,towerl+ytolerance,0]) cube([wall,wall,mediumwall]);
    translate([backw/2-wall/2-backbottomextension,basey+basel-ytolerance-backoverbase,0]) cube([wall,wall,mediumwall]);
  }
}

module leftcover() {
  difference() {
    union() {
      // Left cover
      translate([midcoverx,midcovery,0]) cube([-towerdistance/2-towerw-midcoverx,towerl/2-midcovery,mediumwall]);
      translate([midcoverx,midcovery,0]) cube([-frontw/2-midcoverx-xtolerance,-ytolerance-midcovery,mediumwall]);
      translate([midcoverx,midcovery,0]) cube([-towerdistance/2-towerw-midcoverx,mediumwall,maxh]);
      translate([midcoverx,towerl/2,0]) cube([-towerdistance/2-towerw-midcoverx,mediumwall,maxh+mediumwall]);

      difference() {
	union() {
	  translate([midcoverx,midcovery,0]) cube([wall,towerl/2-midcovery,maxh]);
	  hull() {
	    translate([midcoverx,leftboxy+filamenty,leftboxbottomheight+filamentheight]) rotate([0,90,0]) cylinder(h=mediumwall,d=filamentd+4+wall*2);
	    translate([midcoverx,leftboxy+filamenty,leftboxtopheight+filamentheight]) rotate([0,90,0]) cylinder(h=mediumwall,d=filamentd+4+wall*2);
	    translate([midcoverx,leftboxy+filamenty,leftboxbottomheight+filamentheight]) rotate([0,90,0]) cylinder(h=wall,d=filamentd+6+wall*2);
	    translate([midcoverx,leftboxy+filamenty,leftboxtopheight+filamentheight]) rotate([0,90,0]) cylinder(h=wall,d=filamentd+6+wall*2);
	  }
	}

	hull() {
	  translate([midcoverx-2,leftboxy+filamenty,leftboxbottomheight+filamentheight]) rotate([0,90,0]) cylinder(h=mediumwall+3,d=filamentd+4);
	  translate([midcoverx-2,leftboxy+filamenty,leftboxtopheight+filamentheight]) rotate([0,90,0]) cylinder(h=mediumwall+3,d=filamentd+4);
	}
      }
      translate([midcoverx,midcovery,maxh]) cube([-topcoverw/2-midcoverx-mediumwall,-midcovery,mediumwall]);
      translate([midcoverx,midcovery,maxh]) cube([-towerdistance/2-towerw-midcoverx-0.1,towerl/2-midcovery+mediumwall,mediumwall]);
      echo(-topcoverw/2,midcoverx/2,-midcoverx/2-topcoverw/2,topcoverw/2+midcoverx/2);

      // Mid plate front
      difference() {
	translate([-basew/2,midcovery,0]) cube([basew/2-xtolerance/2,mediumwall,maxh]);
	translate([-frontw/2-xtolerance,midcovery-0.1,-0.1]) cube([frontw+xtolerance*2,mediumwall+0.2,fronth+ztolerance+0.1]);
      }
    }
    
    translate([midcoverx+lightenz,midcovery,0]) lighten(-leftboxy+filamenty-filamentd,maxh,wall-lightenz,lmargin,lfill,maxbridge,"flat-xplane");
    translate([midcoverx,towerl/2,0]) lighten(maxh,-towerdistance/2-towerw-midcoverx,mediumwall-lighteny,lmargin,lfill,maxbridge,"right-xplane");
    translate([midcoverx,midcovery+lighteny,0]) lighten(fronth,-midcoverx-frontw/2,mediumwall,lmargin,lfill,maxbridge,"right-xplane");
#   translate([midcoverx,midcovery+lighteny,fronth]) lighten(maxh-fronth,-midcoverx,mediumwall-lighteny,lmargin,lfill,maxbridge,"right-xplane");
  }
}

module rightcover() {
  // Right cover
  difference() {
    union() {
      translate([midcoverrightx,midcovery,0]) cube([midcoverrightw,towerl/2-midcovery,mediumwall]);
      translate([frontw/2+xtolerance,midcovery,0]) cube([midcoverrightx+midcoverrightw-frontw/2+mediumwall-xtolerance,-ytolerance-midcovery,mediumwall]);
      translate([midcoverrightx,midcovery,0]) cube([midcoverrightw,mediumwall,maxh]);
      translate([midcoverrightx,towerl/2,0]) cube([midcoverrightw,mediumwall,maxh]);
      translate([midcoverrightx+midcoverrightw,midcovery,0]) cube([mediumwall,towerl/2-midcovery+mediumwall,maxh]);
      translate([midcoverrightx,midcovery,maxh]) cube([midcoverrightw+mediumwall,towerl/2-midcovery+mediumwall,mediumwall]);
      translate([midcoverrightx-towerw/2+mediumwall,midcovery,maxh]) cube([midcoverrightw+mediumwall,-midcovery,mediumwall]);

      // Mid plate front
      difference() {
	translate([xtolerance/2,midcovery,0]) cube([basew/2,mediumwall,maxh]);
	translate([-frontw/2-xtolerance,midcovery-0.1,-0.1]) cube([frontw+xtolerance*2,mediumwall+0.2,fronth+ztolerance+0.1]);
      }
    }

    translate([midcoverrightx+midcoverrightw,midcovery,0]) lighten(towerl/2-midcovery+mediumwall,maxh,mediumwall-lightenz,lmargin,lfill,maxbridge,"flat-xplane");
    translate([midcoverrightx,towerl/2,0]) lighten(maxh,midcoverrightw,mediumwall-lighteny,lmargin,lfill/2,maxbridge,"left-xplane");
    translate([frontw/2,midcovery+lighteny,0]) lighten(fronth,midcoverrightx+midcoverrightw-frontw/2,mediumwall,lmargin,lfill/2,maxbridge,"left-xplane");
    translate([0,midcovery+lighteny,fronth]) lighten(maxh-fronth,midcoverrightx+midcoverrightw,mediumwall-lighteny,lmargin,lfill/2,maxbridge,"left-xplane");
  }
}

module topcover() {
  difference() {
    // caps of towers
    union() {
      intersection() {
	union() {
	  for (x=[-towerdistance/2-towerw,towerdistance/2]) {
	    difference() {
	      translate([x-mediumwall+0.1,-mediumwall,towerh-towerfreecap])  cube([towerw+mediumwall*2-0.2,towerl+mediumwall*2,towerfreecap+mediumwall]);
	      translate([x-xtolerance,-ytolerance,towerh-towerfreecap-0.1])  cube([towerw+xtolerance*2,towerl+ytolerance*2,towerfreecap+0.1]);
	    }
	  }
	}

	// Cut out outer parts to tower tops
	translate([-topcoverw/2-mediumwall+0.1,midcovery,maxh+0.1]) cube([topcoverw+mediumwall*2-0.2,towerl-midcovery+mediumwall,towerfreecap+towerfreespaceabove+mediumwall]);
      }

      // support for caps of towers
      for (x=[-towerdistance/2-towerw/2,towerdistance/2]) {
	difference() {
	  translate([x-mediumwall+0.1,-mediumwall,towerh])  cube([towerw/2+mediumwall*2-0.2,towerl+mediumwall*2,towerfreespaceabove + mediumwall]);
	  translate([x-xtolerance,-ytolerance,towerh+mediumwall])  cube([towerw/2+xtolerance*2,towerl+ytolerance*2,towerfreespaceabove + mediumwall]);
	}
      }

      difference() {
	translate([-topcoverw/2-mediumwall+0.1,midcovery,towerh+0.1]) cube([topcoverw+mediumwall*2-0.2,towerl-midcovery+mediumwall,towerfreespaceabove+mediumwall]);

	translate([-topcoverw/2,midcovery+mediumwall,towerh]) cube([topcoverw,towerl-midcovery-mediumwall,towerfreespaceabove+0.1]);
      }
 
      translate([-topcoverw/2-mediumwall+0.1,midcovery,maxh+0.1]) cube([topcoverw+mediumwall*2-0.2,mediumwall,maxtotower]);
      translate([-topcoverw/2-mediumwall+0.1,midcovery,maxh+0.1]) cube([mediumwall,-midcovery,maxtotower]);
      translate([topcoverw/2-0.1,midcovery,maxh+0.1]) cube([mediumwall,-midcovery,maxtotower]);
      
      // Connecting plate between tower caps
      translate([-towerdistance/2,towerl,towerh-towerfreecap+0.1]) cube([towerdistance,mediumwall,towerfreecap]);
    }
    
    for (x=[-towerdistance/2-0.1,towerdistance/2-mediumwall]) {
      translate([x,-mediumwall,towerh]) lighten(towerl+mediumwall*2,towerfreespaceabove-mediumwall,mediumwall,lmargin/2,lfill,maxbridge,"down-yplane");
    }

    translate([-towerdistance/2-mediumwall+0.1+lmargin,midcovery+lmargin,towerh+0.1+towerfreespaceabove-0.01]) cube([towerdistance+mediumwall*2-0.2-lmargin*2,towerl-midcovery+mediumwall-lmargin*2,mediumwall-lightenz+0.01]);
    translate([-topcoverw/2-mediumwall+0.1+lmargin,midcovery+lmargin,towerh+0.1+towerfreespaceabove-0.01]) cube([topcoverw+mediumwall*2-0.2-lmargin*2,-midcovery+mediumwall-lmargin*2,mediumwall-lightenz+0.01]);
    translate([-topcoverw/2-mediumwall+0.1,midcovery+lighteny,maxh+0.1]) lighten(topcoverw+mediumwall*2-0.2,towerfreespaceabove+mediumwall+maxtotower,mediumwall-lighteny,lmargin,lfill,maxbridge,"down-xplane");
    translate([-towerdistance/2,midcovery+towerl-midcovery,maxh+0.1]) lighten(towerdistance+mediumwall*2-0.2,towerfreespaceabove+mediumwall+maxtotower,mediumwall-lighteny,lmargin,lfill,maxbridge,"down-xplane");

    for (x=[-towerdistance/2-towerw/2-0.1-mediumwall+lightenx+0.1,towerdistance/2+towerw/2]) {
      translate([x,-mediumwall,towerh]) lighten(towerl+mediumwall*2,towerfreespaceabove-mediumwall,mediumwall-lightenx,lmargin/2,lfill,maxbridge,"down-yplane");
    }
    
    for (x=[-towerdistance/2-towerw/2-0.1-mediumwall+lightenx+0.1,towerdistance/2+towerw/2-0.1]) {
      translate([x,midcovery-mediumwall,maxh]) lighten(-midcovery+mediumwall,maxtotower+towerfreespaceabove-mediumwall,mediumwall-lightenx,lmargin,lfill,maxbridge,"down-yplane");
    }
  }
}

module frontcover() {
  // Front cover
  difference() {
    translate([-frontw/2,fronty,0]) cube([frontw,mediumwall,fronth]);
    translate([-frontw/2+lmargin,fronty+lightenz,lmargin]) cube([frontw-lmargin*2,mediumwall-lightenz+0.01,fronth-lmargin*2]);
  }

  //Sides
  difference() {
    for (x=[-frontw/2,frontw/2-mediumwall]) {
      translate([x,fronty,0]) cube([mediumwall,midcovery-fronty+mediumwall*2,fronth]);
    }
  
    for (x=[-frontw/2+lightenx,frontw/2-mediumwall]) {
      translate([x,fronty,0]) lighten(midcovery-fronty+mediumwall*2,fronth,mediumwall-lightenx,lmargin,lfill,maxbridge,"back-yplane");
    }
  }
  
  translate([-frontw/2,fronty,0]) cube([frontw,basey-fronty+frontflange,mediumwall]);
  for (x=[-frontw/2,frontw/2-frontunderflange]) {
    translate([x,fronty,0]) cube([frontunderflange,midcovery-fronty+mediumwall*2,mediumwall]);
  }
  difference() {
    translate([-frontw/2,fronty,fronth-mediumwall]) cube([frontw,midcovery-fronty+mediumwall*2,mediumwall]);
    translate([-frontw/2,fronty,fronth-mediumwall]) lighten(midcovery-fronty+mediumwall*2,frontw,mediumwall-lightenx,lmargin,lfill,maxbridge,"back-zplane");
  }
  // Flange
  difference() {
    hull() {
      translate([-frontw/2,midcovery-mediumwall-frontflange-ytolerance,0]) cube([frontw,mediumwall,fronth]);
      translate([-frontw/2-frontflange,midcovery-mediumwall-ytolerance,0]) cube([frontw+frontflange*2,mediumwall,fronth+frontflange]);
    }
    translate([-frontw/2+xtolerance,midcovery-0.1-frontflange*2,-0.1]) cube([frontw-xtolerance*2,mediumwall+frontflange*2+0.2,fronth+ztolerance+0.1]);
  }
}

if (print==0) {
  intersection() {
    union() {
      ankermakem5();
      #backcover();
      #leftcover();
      #rightcover();
      #topcover();
      #frontcover();
    }
    //    translate([0,-b,-b]) cube([b*2,b*2,b*2]);
  }
 }

if (print==1) {
  //backcover();
  //leftcover();
  //rightcover();
        topcover();
  //frontcover();
 }

if (print==2) {
  translate([0,0,topbarheight+mediumwall+topbarh]) rotate([180,0,0]) backcover();
 }

if (print==5) {
  difference() {
    translate([95,185,mediumwall+xtolerance+0.1-leftboxx]) rotate([0,-90,45]) translate([0,-towerl/2,0]) leftcover();
    #printareacube("anycubic");
  }
 }

if (print==6) {
  difference() {
    translate([-190+3,-85-8,0]) rotate([0,90,45]) translate([-rightboxx-rightboxw-mediumwall-wall-xtolerance,-towerl/2-mediumwall,0]) rightcover();
    #printareacube("anycubic");
  }
 }

if (print==7) {
  difference() {
    translate([-9,10,0]) rotate([0,180,0]) translate([0,0,-(towerh+0.1+towerfreespaceabove+mediumwall)]) topcover();
    #printareacube("anycubic");
  }
 }

if (print==8) {
  rotate([90,0,0]) translate([0,-fronty,0]) frontcover();
 }

