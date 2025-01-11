// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=2;

b=800;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

maxy=240; // 250 really, but leave some space
wall=0.8; // Just wall to block airflow, no strength
mediumwall=1.6; // Thicker wall when structural strength may be needed

baseh=58; // Under z=0
baseheight=-baseh;
basew=426;
basel=434;
basey=-273;

towerh=410;
towerw=64;
towerl=70;
towerdistance=272;
towerfreecop=19;
towerfreespaceabove=130;

echo(2*towerw+towerdistance);

topbarh=25.5;
topbarheight=towerh-18-topbarh;
topbarl=18.1; //19;
topbarfromtowerback=6;
topbary=towerl-topbarfromtowerback-topbarl;

topcoverh=150;
topcoverfrontl=160; // From back of towers
topcoverbackl=130; // From back of towers
topcoverfronty=towerl-topcoverfrontl;
topcoverbacky=towerl+topcoverbackl;
  
backw=towerdistance+wall*2+2*2; // TARKISTA CORNER
backl=195-towerl;//190-towerl;

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

leftboxw=72;
leftboxl=52;
leftboxh=132;
leftboxx=-35-leftboxw-towerdistance/2; // TARKISTA
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
echo(rightboxtopheight);

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

module ankermakem5() {
  translate([-basew/2,basey,baseheight]) cube([basew,basel,baseh]);

  translate([-towerdistance/2,topbary,topbarheight]) cube([towerdistance,topbarl,topbarh]);

  translate([spoolholderx,towerl,spoolholderheight]) cube([spoolholderlength,spoolholderl,spoolholderh]);
  
  translate([-towerw-towerdistance/2,0,0]) cube([towerw,towerl,towerh]);
  translate([towerdistance/2,0,0]) cube([towerw,towerl,towerh]);

  translate([-printplatew/2,printplatefronty,printplateheight]) cube([printplatew,printplatel,printplateh]);
  translate([-magnetplatetabw/2,printplatefronty-magnetplatetabl,printplateheight]) cube([magnetplatetabw,magnetplatetabl,printplateh]);

  translate([leftboxx,leftboxy,leftboxbottomheight]) cube([leftboxw,leftboxl,leftboxh]);
  
  translate([rightboxx,rightboxy,rightboxbottomheight]) cube([rightboxw,rightboxl,rightboxh]);
  translate([rightboxx-cameraw,rightboxy+cameray,rightboxbottomheight+cameraheight]) cube([cameraw,cameral,camerah]);

  translate([-gantryw/2,gantryy,gantrybottomheight]) cube([gantryw,gantryl,gantryh]);

  translate([printheadleftx,printheady,printheadbottomheight]) cube([printheadw,printheadl,printheadh]);
  
  color("yellow") {
    translate([-printplatew/2,printplatebacky,printplateheight]) cube([printplatew,printplatel,printplateh]);
  translate([-magnetplatetabw/2,printplatebacky-magnetplatetabl,printplateheight]) cube([magnetplatetabw,magnetplatetabl,printplateh]);
    
    translate([leftboxx,leftboxy,leftboxtopheight]) cube([leftboxw,leftboxl,leftboxh]);

    translate([rightboxx,rightboxy,rightboxtopheight]) cube([rightboxw,rightboxl,rightboxh]);
    translate([rightboxx-cameraw,rightboxy+cameray,rightboxtopheight+cameraheight]) cube([cameraw,cameral,camerah]);

    translate([-gantryw/2,gantryy,gantrytopheight]) cube([gantryw,gantryl,gantryh]);

    translate([printheadrightx,printheady,printheadbottomheight]) cube([printheadw,printheadl,printheadh]);
    translate([printheadleftx,printheady,printheadtopheight]) cube([printheadw,printheadl,printheadh]);
    translate([printheadrightx,printheady,printheadtopheight]) cube([printheadw,printheadl,printheadh]);
  }
}

module backcovertop() {
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
  
  translate([-backw/2-wall/2,topbary+topbarl+topbarfromtowerback+ytolerance,topbarheight+topbarh+mediumwall-wall]) cube([backw+wall,backl+wall-ytolerance,wall]);

  for (x=[-backw/2-wall/2,backw/2-wall/2]) {
    translate([x,towerl+ytolerance,maxy]) cube([wall,backl+wall-ytolerance,topbarheight+topbarh-maxy+wall]); //printheadtopheight
  }
  translate([-backw/2-wall/2,towerl+backl,maxy]) cube([backw,wall,topbarheight+topbarh-maxy+wall]);
}

module backcoverlow() {
  for (x=[-backw/2-wall/2,backw/2-wall/2]) {
    translate([x,towerl+ytolerance,0]) cube([wall,backl+wall-ytolerance,maxy]); //printheadtopheight
  }
  translate([-backw/2-wall/2,towerl+backl,0]) cube([backw,wall,maxy]);
  translate([-backw/2,basey+basel-ytolerance,0]) cube([backw,towerl+backl-(basey+basel)+ytolerance,wall]);
}

module frontcover() {
}

if (print==0) {
  ankermakem5();
  #backcovertop();
  #backcoverlow();
 }

if (print==2) {
  intersection() {
    translate([0,0,topbarheight+mediumwall+topbarh]) rotate([180,0,0]) backcovertop();
    translate([0,-b,-b]) cube([b*2,b*2,b*2]);
  }
 }

if (print==3) {
  intersection() {
    translate([0,0,topbarheight+mediumwall+topbarh]) rotate([180,0,0]) backcovertop();
    translate([-b,-b,-b]) cube([b,b*2,b*2]);
  }
 }
