// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679


razorwidth=32;
razordepth=35;
betweentoothcleanerwidth=33;
betweentoothcleanerdepth=36.5;
toothbrushchargerwidth=49;
toothbrushchargerdepth=64;
toothbrushcablecutwidth=12;
toothbrushcablecutdepth=10;
toothbrushchargerfootdiameter=70;
toothbrushchargerfootwidth=34;
toothpastewidth=36;
toothpastedepth=36;
smallboxwidth=21;
smallboxdepth=30;
slotwidth=60;
slotdepth=20;
roundholediameter=13;
betweenroundhole=15;
boxwidth=95;
boxdepth=87;
squareholewidth=15;
squareholedepth=16;
betweensquareholedepth=2;
betweenwidth=2;
thickness=35;
bottomthickness=1.5;
bottomthickness2=2;
leakholediameter=2;
maxdepth=101;
backplanedepth=5;
backplaneheight=thickness+50;
cornerdiameter=10;
cornerdiametersmall=5;
cablecutwidth=300;
cablecutdepth=8;
protectorboxwidth=150+19;
protectorboxdepth=82;
protectorboxcornerdiameter=60;
screwholediameter=6.5;
screwholedistance=2*cornerdiameter;
screwholeyposition=1.6*screwholediameter;
anglesupportdepth=40;
cutheight=backplaneheight;
combwidth=45;
combdepth=6;
comb2width=55;
comb2depth=7;
combbetween = 5;
versiontext="V2.2";
versionwidth=20;
font="Liberation Sans";

$fn=60;

x1width=razorwidth; //max(razorwidth,betweentoothcleanerwidth);
x1=betweenwidth;
razory=betweenwidth+slotdepth+betweenwidth;
x1ydistance=10;
//betweentoothcleanery=betweenwidth+slotdepth+razordepth+betweenwidth*2;

smallboxx=cornerdiameter;
smallboxy=betweenwidth+slotdepth+betweenwidth+razordepth+betweenwidth;
  
x2width=max(toothbrushchargerwidth,toothpastewidth);
x2=betweenwidth+x1width+betweenwidth+x2width/2;
toothbrushchargerx=betweenwidth+x1width+betweenwidth;
toothbrushchargerylow=betweenwidth+slotdepth+betweenwidth;
toothbrushchargery=toothbrushchargerylow+toothbrushchargerdepth/2;
cablecuty=toothbrushchargery+toothbrushchargerdepth/2+2;
cablecutx=x2+toothbrushcablecutwidth/2;

slotx=betweenwidth;
sloty=betweenwidth;

toothpastex=betweenwidth+slotwidth+betweenwidth+squareholewidth+toothpastewidth/2+1;
toothpastey=betweenwidth+toothpastedepth/2 - 0.5;

x3width=slotwidth;
x3=betweenwidth+x1width+betweenwidth+x2width;
x3y=betweenwidth;

x3back=betweenwidth+x1width+betweenwidth+toothbrushchargerwidth+betweenwidth+roundholediameter/2-1;
x4back=x3back+betweenwidth+roundholediameter+4;
y3back=toothpastey+toothpastedepth/2+betweenwidth+roundholediameter/2-1.5;
y4back=toothpastey+toothpastedepth/2+betweenwidth+roundholediameter/2-3;
betweentoothcleanerx=toothbrushchargerx+toothbrushchargerwidth+betweenwidth;
betweentoothcleanery=y3back+roundholediameter/2+betweenwidth - 0.5;

xbox=max(toothpastex+toothpastewidth/2,x4back+roundholediameter/2,betweentoothcleanerx+betweentoothcleanerwidth)+betweenwidth;

x5=xbox+boxwidth+betweenwidth;
y51=betweenwidth;
y52=y51+squareholedepth+betweensquareholedepth;
y53=y52+squareholedepth+betweensquareholedepth;
y54=y53+squareholedepth+betweensquareholedepth;

x6=x5+squareholewidth+betweenwidth;

module roundedbox(width,depth,height,cornerdiameter) {
  hull() {
    translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(d=cornerdiameter,h=height);
    translate([width-cornerdiameter/2,cornerdiameter/2,0]) cylinder(d=cornerdiameter,h=height);
    translate([width-cornerdiameter/2,depth-cornerdiameter/2,0]) cylinder(d=cornerdiameter,h=height);
    translate([cornerdiameter/2,depth-cornerdiameter/2,0]) cylinder(d=cornerdiameter,h=height);
  }
}

// totaldepth=2*betweenwidth+max(razordepth+x1ydistance+betweentoothcleanerwidth,toothbrushchargerdepth+toothbrushcablecutdepth+betweenwidth+toothpastedepth,slotdepth,roundholediameter*3+betweenroundhole*2,boxdepth,squareholedepth*3+betweensquareholedepth*2);
totaldepth=102;
    
//totalwidth=betweenwidth+x1width+betweenwidth+x2width+betweenwidth+slotwidth+betweenwidth+roundholediameter+betweenwidth+boxwidth+squareholewidth+betweenwidth;
totalwidth=x6+protectorboxwidth+betweenwidth;

difference() {
  union() {
    translate([0,cornerdiameter/2,0]) cube([totalwidth,totaldepth-cornerdiameter/2,thickness]);
    hull() {
      translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=thickness,d=cornerdiameter);
      translate([totalwidth-cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=thickness,d=cornerdiameter);
    }

    //translate([0,totaldepth-backplanedepth,0]) cube([totalwidth,backplanedepth,thickness+backplaneheight]);
    translate([0,totaldepth,0]) rotate([90,0,0]) difference() {
      hull() {
	translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([totalwidth-cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([totalwidth-cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      }
      translate([screwholedistance,backplaneheight-screwholeyposition,-0.01]) cylinder(h=backplanedepth+1,d=screwholediameter);
      translate([totalwidth/2,backplaneheight-screwholeyposition,-0.01]) cylinder(h=backplanedepth+1,d=screwholediameter);
      translate([totalwidth-screwholedistance,backplaneheight-screwholeyposition,-0.01]) cylinder(h=backplanedepth+1,d=screwholediameter);
    }

    translate([0,totaldepth,0]) rotate([90,0,0]) hull() {
      translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
    }

    translate([x1width+betweenwidth-3,totaldepth,0]) rotate([90,0,0]) hull() {
      translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
    }

    hull() {
      translate([x5-betweenwidth,totaldepth,0]) rotate([90,0,0]) hull() {
	translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
      }

      translate([x6-cornerdiameter,totaldepth,0]) rotate([90,0,0]) hull() {
	translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
	translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
      }
    }
    
    translate([totalwidth-cornerdiameter,totaldepth,0]) rotate([90,0,0]) hull() {
      translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
    }
  }

  translate([x1,razory,bottomthickness]) roundedbox(razorwidth,razordepth,cutheight,cornerdiametersmall);

  translate([smallboxx,smallboxy,bottomthickness]) roundedbox(smallboxwidth,smallboxdepth,cutheight,cornerdiametersmall);

  translate([betweentoothcleanerx,betweentoothcleanery,bottomthickness]) roundedbox(betweentoothcleanerwidth,betweentoothcleanerdepth,cutheight,cornerdiametersmall);

  translate([toothpastex,toothpastey,bottomthickness]) resize([toothpastewidth,toothpastedepth,cutheight]) cylinder(d1=10,d2=10.5,h=10);

  translate([slotx,betweenwidth,bottomthickness]) roundedbox(slotwidth,slotdepth,cutheight,cornerdiametersmall);

  translate([toothbrushchargerx+toothbrushchargerwidth/2,toothbrushchargery,bottomthickness2]) resize([toothbrushchargerwidth,toothbrushchargerdepth,cutheight]) cylinder(d=10,h=10);
  translate([toothbrushchargerx+toothbrushchargerwidth/2-toothbrushcablecutwidth/2,toothbrushchargery,bottomthickness2]) cube([toothbrushcablecutwidth,toothbrushchargerdepth/2+toothbrushcablecutdepth,thickness]);
  intersection() {
    translate([toothbrushchargerx+toothbrushchargerwidth/2,toothbrushchargery,bottomthickness2]) cylinder(h=cutheight,d=toothbrushchargerfootdiameter);
    translate([toothbrushchargerx+toothbrushchargerwidth/2-toothbrushchargerfootwidth/2,toothbrushchargery,bottomthickness2]) cube([toothbrushchargerfootwidth,toothbrushchargerfootdiameter,cutheight]);
  }
  intersection() {
    translate([cablecutx,cablecuty,bottomthickness2]) rotate([0,-20,0]) cube([cablecutwidth,cablecutdepth,cutheight]);
    translate([0,0,0]) cube([totalwidth,totaldepth-backplanedepth,thickness+0.01]);
    translate([toothbrushchargerx,0,0]) cube([totalwidth-toothbrushchargerx,totaldepth-backplanedepth,thickness+0.01]);
  }

  translate([x3back,y3back,bottomthickness]) cylinder(d=roundholediameter,h=cutheight);
  translate([x4back,y4back,bottomthickness]) cylinder(d=roundholediameter*1.2,h=cutheight);

  translate([xbox,betweenwidth,bottomthickness2]) roundedbox(boxwidth,boxdepth,cutheight,cornerdiametersmall);

  //translate([xbox+boxwidth-versionwidth,betweenwidth+boxdepth+betweenwidth,thickness-0.5]) linear_extrude(height = 0.51) text(text = str(versiontext), font = font, size = 5, valign=110, halign=90);
  translate([xbox+boxwidth-versionwidth,betweenwidth+boxdepth+betweenwidth,thickness-0.5]) linear_extrude(height = 0.51) text(text = str(versiontext), font = font, size = 5, valign="baseline", halign="left");

  translate([slotx+slotwidth+betweenwidth,betweenwidth,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y51,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y52,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y53,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y54,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);

  union() {
    translate([x6,betweenwidth,bottomthickness2]) roundedbox(protectorboxwidth,protectorboxdepth-protectorboxcornerdiameter/2,cutheight,cornerdiametersmall);
    translate([x6,betweenwidth+protectorboxdepth-protectorboxcornerdiameter,bottomthickness2])
      hull() {
      translate([cornerdiameter/2,protectorboxcornerdiameter/2,0]) cylinder(h=cutheight,d=cornerdiameter);
      translate([cornerdiameter/2,protectorboxcornerdiameter-cornerdiameter/2,0]) cylinder(h=cutheight,d=cornerdiameter);
      translate([protectorboxwidth-protectorboxcornerdiameter/2,protectorboxcornerdiameter-protectorboxcornerdiameter/2,0]) cylinder(h=cutheight,d=protectorboxcornerdiameter);
    }
  }

  translate([x6 + 3,betweenwidth+protectorboxdepth+betweenwidth,bottomthickness]) cube([combwidth,combdepth,cutheight]);
  translate([x6 + 3 + combwidth+combbetween,betweenwidth+protectorboxdepth+betweenwidth,bottomthickness]) cube([combwidth,combdepth,cutheight]);
  translate([x6 + 3 + 2*(combwidth+combbetween),betweenwidth+protectorboxdepth+betweenwidth,bottomthickness]) cube([comb2width,comb2depth,cutheight]);
}

					     

															 
															 
 

