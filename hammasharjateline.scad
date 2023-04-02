
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
toothpastewidth=35;
toothpastedepth=35;
slotwidth=60;
slotdepth=20;
roundholediameter=13;
betweenroundhole=15;
boxwidth=95;
boxdepth=80;
squareholewidth=15;
squareholedepth=16;
betweensquareholedepth=5;
betweenwidth=2;
thickness=35;
bottomthickness=1;
bottomthickness2=1.7;
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
screwholediameter=6.5;
screwholedistance=2*cornerdiameter;
screwholeyposition=1.6*screwholediameter;
anglesupportdepth=40;
cutheight=backplaneheight;
combwidth=45;
combdepth=5;
comb2width=55;
comb2depth=6;
combbetween = 5;

$fn=60;

x1width=max(razorwidth,betweentoothcleanerwidth);
x1=betweenwidth;
razory=betweenwidth;
x1ydistance=10;
betweentoothcleanery=betweenwidth+razordepth+x1ydistance;

x2width=max(toothbrushchargerwidth,toothpastewidth);
x2=betweenwidth+x1width+betweenwidth+x2width/2;
toothbrushchargerylow=betweenwidth+slotdepth+betweenwidth;
toothbrushchargery=toothbrushchargerylow+toothbrushchargerdepth/2;
cablecuty=toothbrushchargery+toothbrushchargerdepth/2+2;
cablecutx=x2+toothbrushcablecutwidth/2;

slotx=betweenwidth+x1width+betweenwidth;
sloty=betweenwidth;

toothpastex=betweenwidth+x1width+betweenwidth+x2width+betweenwidth+toothpastewidth/2-1;
toothpastey=betweenwidth+slotdepth+toothpastedepth/2+1;

x3width=slotwidth;
x3=betweenwidth+x1width+betweenwidth+x2width;
x3y=betweenwidth;

x3back=x2+x2width/2+betweenroundhole/4+roundholediameter/2;
x4back=x3back+betweenwidth+roundholediameter+betweenroundhole/3;
y3back=toothpastey+toothpastedepth/2+betweenwidth+roundholediameter;

xbox=max(toothpastex+toothpastewidth/2,x4back+roundholediameter/2)+betweenwidth;

x5=xbox+boxwidth+betweenwidth;
y51=betweenwidth+2;
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
totaldepth=101;
    
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

    translate([x1width+betweenwidth,totaldepth,0]) rotate([90,0,0]) hull() {
      translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
    }

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

    translate([totalwidth-cornerdiameter,totaldepth,0]) rotate([90,0,0]) hull() {
      translate([cornerdiameter/2,cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,backplaneheight-cornerdiameter/2,0]) cylinder(h=backplanedepth,d=cornerdiameter);
      translate([cornerdiameter/2,cornerdiameter/2,anglesupportdepth]) sphere(d=cornerdiameter);
    }
}

  translate([x1,razory,bottomthickness]) roundedbox(razorwidth,razordepth,cutheight,cornerdiametersmall);

  translate([x1,betweentoothcleanery,bottomthickness]) roundedbox(betweentoothcleanerwidth,betweentoothcleanerdepth,cutheight,cornerdiametersmall);

  translate([toothpastex,toothpastey,bottomthickness]) resize([toothpastewidth,toothpastedepth,cutheight]) cylinder(d1=10,d2=10.5,h=10);

  translate([slotx,betweenwidth,bottomthickness]) roundedbox(slotwidth,slotdepth,cutheight,cornerdiametersmall);

  translate([x2,toothbrushchargery,bottomthickness2]) resize([toothbrushchargerwidth,toothbrushchargerdepth,cutheight]) cylinder(d=10,h=10);
  translate([x2-toothbrushcablecutwidth/2,toothbrushchargery,bottomthickness2]) cube([toothbrushcablecutwidth,toothbrushchargerdepth/2+toothbrushcablecutdepth,thickness]);
  intersection() {
    translate([x2,toothbrushchargery,bottomthickness2]) cylinder(h=cutheight,d=toothbrushchargerfootdiameter);
    translate([x2-toothbrushchargerfootwidth/2,toothbrushchargery,bottomthickness2]) cube([toothbrushchargerfootwidth,toothbrushchargerfootdiameter,cutheight]);
  }
  intersection() {
    translate([cablecutx,cablecuty,bottomthickness2]) rotate([0,-20,0]) cube([cablecutwidth,cablecutdepth,cutheight]);
    translate([0,0,0]) cube([totalwidth,totaldepth-backplanedepth,thickness+0.01]);
    translate([x2,0,0]) cube([totalwidth-x2,totaldepth-backplanedepth,thickness+0.01]);
  }

  translate([x3back,y3back,bottomthickness]) cylinder(d=roundholediameter,h=cutheight);
  translate([x4back,y3back,bottomthickness]) cylinder(d=roundholediameter,h=cutheight);

  translate([xbox,betweenwidth,bottomthickness2]) roundedbox(boxwidth,boxdepth,cutheight,cornerdiametersmall);

  translate([slotx+slotwidth+betweenwidth+5,betweenwidth,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y51,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y52,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y53,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);
  translate([x5,y54,bottomthickness]) roundedbox(squareholewidth,squareholedepth,cutheight,cornerdiametersmall);

  translate([x6,betweenwidth,bottomthickness2]) roundedbox(protectorboxwidth,protectorboxdepth,cutheight,cornerdiametersmall);

  translate([x6 + 3,betweenwidth+protectorboxdepth+betweenwidth,bottomthickness]) cube([combwidth,combdepth,cutheight]);
  translate([x6 + 3 + combwidth+combbetween,betweenwidth+protectorboxdepth+betweenwidth,bottomthickness]) cube([combwidth,combdepth,cutheight]);
  translate([x6 + 3 + 2*(combwidth+combbetween),betweenwidth+protectorboxdepth+betweenwidth,bottomthickness]) cube([comb2width,comb2depth,cutheight]);
}

					     

															 
															 
 

