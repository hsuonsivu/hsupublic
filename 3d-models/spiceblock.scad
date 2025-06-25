// Copyright 2022-2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// 0 all, 1 wide, 2 medium, 3 narrow, 4 rest, 5=boxtest, 6=wide and medium
print=0;

xtolerance=0.5;
wall=1.6;
endwall=2;
incornerd=1;
outcornerd=incornerd+wall*2;

depth=110;
maxheight=155;
height=maxheight-5;
saranaw=36+xtolerance*3;
maxw=565-saranaw;

openingh=depth*0.8;
openingheight=height-openingh;

wideslots=(print==5)?1:5;
mediumslots=(print==5)?1:6;
narrowslots=(print==5)?2:16;

widew=34;
mediumw=20;
narroww=12;
sidewall=wall;

handled=20;
handlemargin=8;

widetotalw=endwall+wideslots*widew+(wideslots-1)*sidewall+endwall;
mediumtotalw=endwall+mediumslots*mediumw+(mediumslots-1)*sidewall+endwall;
narrowtotalw=endwall+narrowslots*narroww+(narrowslots-1)*sidewall+endwall;
slotsw=widetotalw+mediumtotalw+narrowtotalw;
restw=(print==5)?102.05:maxw-slotsw;

widestart=0;
mediumstart=widestart+endwall+wideslots*widew+sidewall*(wideslots-1)+endwall;
narrowstart=mediumstart+endwall+mediumslots*mediumw+sidewall*(mediumslots-1)+endwall;
reststart=maxw-restw;

module spiceblock(w,n) {
  rotate([0,0,90]) {
    totalw=endwall+w*n+sidewall*(n-1)+endwall;
    start=endwall;
    difference() {
      roundedbox(totalw,depth,height,outcornerd,1);
      for (x=[start:w+sidewall:totalw-1]) {
	translate([x,wall,wall]) roundedbox(w,depth-wall*2,height+incornerd,incornerd,0);
      }

      difference() {
	translate([-0.1,-0.1,openingheight]) triangle(totalw+0.2,openingh,openingh+0.2,10);
	x=endwall+w*(floor(n/2))+sidewall*(floor(n/2)-1);
	translate([x-0.1,-0.2,-0.2]) cube([sidewall+0.2,depth+0.5,height+0.4]);
      }

      hull() {
	translate([-0.1,handlemargin+handled/2,height-handlemargin-handled/2]) rotate([0,90,0]) cylinder(d=handled,h=totalw+0.2);
	translate([-0.1,handlemargin+handled/4,height-handlemargin-1]) cube([totalw+0.2,handled/2,1]);
      }
    }
  }
}

if (print==0 || print==1 || print==5 || print==6) spiceblock(widew,wideslots);
if (print==0 || print==2 || print==5 || print==6) translate([depth+xtolerance,0,0]) spiceblock(mediumw,mediumslots);
if (print==0 || print==3 || print==5) translate([depth*2+xtolerance*2,0,0]) spiceblock(narroww,narrowslots);
if (print==0 || print==4) translate([depth*3+xtolerance*3,0,0]) spiceblock(restw,1);




