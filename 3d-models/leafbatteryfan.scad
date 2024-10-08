// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

print=0; // 1=print all parts except filter, 2=filter and lock bars, 3=connectorbox, 4=body only, 5=print everything including filter, 6=body only
strong=0; // Add strengtening stuff to screwholes
$fn=90;

lockbarwithscrew=0;

use <hsu.scad>

versiontext="V1.2";
textdepth=0.8;
textsize=8;
copyrighttext="© Heikki Suonsivu CC-BY-NC-SA";
copyrighttextsize=textsize-3;
baseheight=5;
basethickness=3;
baseshaped=60; // curve diameter
basewidthmax=129;
basewidel=115;
basenarrowwidth=100;
basenarrowl=40;

frontscrewd=11;
frontscrewbased=20;
frontbaseh=2; // metal is thinner but this will must be stronger
frontbased=25;

frontattachw=35;
frontattachh=12;
frontattachl=5;
frontbelowsupportx=5;
frontbelowsupporty=frontattachw;

backscrewd=7.6;
backscrewbased=18;
backbaseh=frontbaseh;
backbased=23;
backscrewstretch=1.5; // Right hole is wider
backbelowsupportx=3;
backbelowsupporty=backbased-backbelowsupportx*2;

backattachw=backbased;
backattachh=frontattachh;
backattachl=5;

openingfrontx=29+frontscrewd/2;
openingfrontw=65;
openingwidthmax=87;
openingwidel=100-openingfrontx;;
openingl=173;
openingshaped=30;

// screws to bind parts together
screwholed=3.5;
screwtowerd=screwholed*3;
screwholebase=1;
screwlength=19;

// Fan
screwnutslot=0;
fanscrewdistance=82;
fanscrewd=5.2; // likely 5 mm
fanscrewnuth=3.5; // nut height
fanscrewsinkspace=4; // Enough space for countersink to fit
fanscrewbased=7.1;
fandiameter=92; // Fan hole diameter. This is truncated at edges, so it is closer to 90 in some places.
fansquarediameter=90; // Fan hole is not completely round.
fancorner=92;
fanedge=93; // Fan square edge. Used by filter to make the fan-sized hole
fanheight=50; // Fan position above the opening
fanbasethickness=2;
fanbaseedgewidth=10; // Width of fan holder edges
fanbaseedge=fandiameter+fanbaseedgewidth;
fancenterx=openingfrontx+openingl/2;
fanh=25.5;

// Filter cover for the fan
filterw=fandiameter*1.6;
filterl=160; //fandiameter*1.5;
filterh=fandiameter*1.5;
filterwall=1.6;
filterheight=fanheight+fanbasethickness;
filtertopd=20;
filtertopzscale=15;
filtersupportdistance=40;
filtersupportdownw=(filterw/2-fanedge/2)/3+2;
cabletunnelposition=14;
cabletunnelwidth=7;
cabletunnelheight=8;

// Lock bars for filter
lockbarscrewsupportthickness=5;
lockbarl=filterl+2*5+2*lockbarscrewsupportthickness-2; // -2 to add spring effect
lockbartofilter=lockbarl/2-filterl/2;
lockbarw=screwtowerd;
lockbarh=4;
lockbarpind=3;
lockbarpinh=10;
lockbarpindistance=20;
lockbarnarrowing=6;
lockbartopd=1;
filterthickness=13;
lockscrewdistance=filterthickness+screwtowerd/2;
lockscrewbasex=5;

// Fan duct wall thickness
fanductwall=2;

// These are used to cut parts
width=basewidthmax+1;
height=baseheight+basethickness+200;

// Connectorbox
// x = l, y=w
connectorpcbw=34;
connectorpcbl=48;
connectorboxwall=2;
switchholed=6.7;
switchholex=23.5;
switchholey=11;
powerholed=9;
powerholex=8;
powerholeh=9;
powerholeheight=6.5;
pcbthickness=1.8;
pcbcomponents=15;
pcbwirespace=7;
pcbh=connectorboxwall+pcbwirespace+pcbthickness;
wirespacew=28;
wirespacex=connectorpcbw/2-wirespacew/2;
wirespacel=connectorpcbl;
wirespacey=connectorpcbl/2-wirespacel/2;
pcbcableholew=23;
pcbcableholey=6;
pcbcableholeheight=1; // from pcb
pcbcableholeh=10; // from pcb not used...
connectorboxinw=connectorpcbw;
connectorboxinl=connectorpcbl;
connectorboxinh=pcbwirespace+pcbthickness+pcbcomponents;
connectorboxoutw=connectorboxinw+2*connectorboxwall;
connectorboxoutl=connectorboxinl+2*connectorboxwall;
connectorboxouth=connectorboxinh+connectorboxwall; // Lid is separate piece
connectorboxlidheight=connectorboxwall+connectorboxinh;
connectorboxlidsnapheight=connectorboxouth-3;
connectorboxlidsnapd=1.5;
connectorboxlidsnapsink=0.3; // sink a bit to make printing easier
connectorboxlidsnapl=10;
connectorboxlidraise=2;
connectorboxlidsnapx=connectorboxwall+connectorboxinl/2-connectorboxlidsnapl/2;

connectorboxsnapheight=connectorboxwall+5;
connectorboxsnapw=connectorboxoutw-8;
connectorboxsnapd=2;
connectorboxsnapsink=connectorboxlidsnapsink;

connectorboxx=frontscrewbased/2-1;
connectorboxheight=filterheight-connectorboxouth-connectorboxwall;
connectorboxbasemidw=frontattachw+12;
cornerd=1;

backscrewdistance=96+backscrewd;
frontbackscrewdistance=227; //223.5+frontscrewd/2+backscrewd/2; // calculated from screw centers
screwholeheight=baseheight+basethickness;
backattachsupportw=(backbased-backscrewbased)/2;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;

module outline() {
  hull() {
    translate([frontbackscrewdistance-backscrewbased/2-backattachl-backattachl,-backscrewdistance/2-backbased/2,baseheight]) roundedbox(backattachl,2*backbased/2+backscrewdistance,basethickness,cornerd);
    translate([frontbackscrewdistance-backscrewbased/2-backattachl-backattachl-backbased/2-baseshaped/2,-basewidthmax/2+baseshaped/2,baseheight]) cylinder(d=baseshaped,h=basethickness);
    translate([frontbackscrewdistance-backscrewbased/2-backattachl-backattachl-backbased/2-baseshaped/2,basewidthmax/2-baseshaped/2,baseheight]) cylinder(d=baseshaped,h=basethickness);
    translate([basewidel,-basewidthmax/2+baseshaped/2,baseheight]) cylinder(d=baseshaped,h=basethickness);
    translate([basewidel,basewidthmax/2-baseshaped/2,baseheight]) cylinder(d=baseshaped,h=basethickness);
    translate([basenarrowl+baseshaped/4,-basenarrowwidth/2+baseshaped/2,baseheight]) cylinder(d=baseshaped,h=basethickness);
    translate([basenarrowl+baseshaped/4,basenarrowwidth/2-baseshaped/2,baseheight]) cylinder(d=baseshaped,h=basethickness);
    difference() {
      translate([5+baseshaped/2,0,baseheight]) cylinder(d=baseshaped,h=basethickness);
      translate([0,-basewidthmax/2,0]) cube([frontscrewbased/2+frontattachl,basewidthmax,baseheight+basethickness+1]);
    }
  }
}

module opening(thickness) {
  hull() {
    translate([openingshaped/2,openingfrontw/2-openingshaped/2,0]) cylinder(d=openingshaped,h=thickness);
    translate([openingshaped/2,-openingfrontw/2+openingshaped/2,0]) cylinder(d=openingshaped,h=thickness);
    translate([openingwidel,openingwidthmax/2-openingshaped/2,0]) cylinder(d=openingshaped,h=thickness);
    translate([openingwidel,-openingwidthmax/2+openingshaped/2,0]) cylinder(d=openingshaped,h=thickness);
    translate([openingl-openingshaped/2,-openingwidthmax/2+openingshaped/2,0]) cylinder(d=openingshaped,h=thickness);
    translate([openingl-openingshaped/2,openingwidthmax/2-openingshaped/2,0]) cylinder(d=openingshaped,h=thickness);
  }
}

module leafbatteryfan() {
  difference() {
    union() {
      cylinder(d=frontscrewbased,h=frontbaseh);
     
      difference() {
	cylinder(d=frontbased,h=baseheight);
	translate([0,0,frontbaseh]) cylinder(d=frontscrewbased,h=baseheight);
      }

      translate([frontbackscrewdistance,0,0]) {
	for (y=[-backscrewdistance/2,backscrewdistance/2]) {
	  translate([0,y,0]) {
	    cylinder(d=backscrewbased,h=backbaseh);
      
	    difference() {
	      cylinder(d=backbased,h=baseheight);
	      translate([0,0,backbaseh]) cylinder(d=backscrewbased,h=baseheight);
	    }
	  }
	}
      }

      translate([0,-frontbased/2,0]) roundedbox(frontscrewbased/2+frontattachl,frontbased,baseheight,cornerd);
      translate([frontscrewbased/2+frontattachl-cornerd,-frontbelowsupporty/2,0]) roundedbox(frontbelowsupportx+cornerd,frontbelowsupporty,baseheight,cornerd);
      translate([cornerd/2,-frontbased/2,baseheight-cornerd/2]) triangle(frontscrewbased/2,backattachsupportw,frontattachh+cornerd/2,0);
      translate([cornerd/2,frontbased/2-backattachsupportw,baseheight-cornerd/2]) triangle(frontscrewbased/2,backattachsupportw,frontattachh+cornerd/2,0);
      translate([frontscrewbased/2,-frontattachw/2,0]) roundedbox(frontattachl,frontattachw,baseheight+frontattachh,cornerd);

      translate([frontbackscrewdistance,0,0]) {
	for (y=[-backscrewdistance/2,backscrewdistance/2]) {
	  translate([0,y,0]) {
	    translate([-backscrewbased/2-backattachl,-backbased/2,0]) roundedbox(backattachl+backscrewbased/2,backattachw,baseheight,cornerd);
	    translate([-backscrewbased/2-backattachl-backbelowsupportx,-backbelowsupporty/2,0]) roundedbox(backattachl+backscrewbased/2+backbelowsupportx,backbelowsupporty,baseheight,cornerd);
	    translate([-backscrewbased/2-backattachl,-backbased/2,baseheight-cornerd]) roundedbox(backattachl,backattachw,backattachh+cornerd,cornerd);
	    for (yy=[-backbased/2,backbased/2-backattachsupportw-cornerd/2]) {
	      translate([-backscrewbased/2-cornerd/2,yy,baseheight-cornerd/2]) triangle(backscrewbased/2+1,backattachsupportw,backattachh,2);
	    }
	    hull() {
	      translate([backscrewbased/2-2*screwlength,0,baseheight+screwtowerd/2+0.1]) rotate([90,0,90]) ruuvitorni(screwlength,screwtowerd);
	      translate([backscrewbased/2-2*screwlength-backattachl,-screwtowerd/2,baseheight+0.1]) cube([screwlength+backattachl,screwtowerd,basethickness]);
	    }
	  }
	}
      }
      translate([frontbackscrewdistance-backscrewbased/2-backattachl-cornerd,-backscrewdistance/2+backbased/2+ytolerance,baseheight]) roundedbox(backattachl+cornerd,-2*backbased/2+backscrewdistance-2*ytolerance,basethickness,cornerd);

      outline();

      // Connectorbox base

      hull() {
	translate([frontscrewbased/2+frontattachl,-frontattachw/2,baseheight+basethickness-cornerd/2]) roundedbox(5+frontscrewbased/2+frontattachl,frontattachw,connectorboxwall,cornerd);
	translate([frontscrewbased/2+frontattachl,-connectorboxbasemidw/2,basethickness+frontattachh+connectorboxwall]) roundedbox((connectorboxoutl-frontscrewbased/2-2*frontattachl)*((baseheight+basethickness+frontattachh+connectorboxwall)/connectorboxheight),connectorboxbasemidw,connectorboxwall,cornerd);
      }
      hull() {
	translate([frontscrewbased/2+frontattachl,-connectorboxbasemidw/2,basethickness+frontattachh+connectorboxwall]) roundedbox((connectorboxoutl-frontscrewbased/2-2*frontattachl)*((baseheight+basethickness+frontattachh+connectorboxwall)/connectorboxheight),connectorboxbasemidw,connectorboxwall,cornerd);
	translate([connectorboxx,-connectorboxoutl/2-connectorboxwall-ytolerance,filterheight-connectorboxouth-connectorboxwall*2]) roundedbox(connectorboxoutw+connectorboxwall,connectorboxoutl+connectorboxwall*2+ytolerance*2,connectorboxwall,cornerd);
      }
      translate([connectorboxx,-connectorboxoutl/2-connectorboxwall-ytolerance,connectorboxheight-connectorboxwall]) roundedbox(connectorboxoutw+connectorboxwall+xtolerance,connectorboxwall,pcbh+pcbcableholeheight+connectorboxwall,cornerd);
      translate([connectorboxx+connectorboxsnapw,-connectorboxoutl/2-connectorboxsnapsink-ytolerance,connectorboxheight+connectorboxsnapheight]) sphere(d=connectorboxsnapd);
      translate([connectorboxx,connectorboxoutl/2+ytolerance,connectorboxheight-connectorboxwall]) roundedbox(connectorboxoutw+connectorboxwall+xtolerance,connectorboxwall,pcbh+pcbcableholeheight+connectorboxwall,cornerd);
      translate([connectorboxx+connectorboxsnapw,connectorboxoutl/2+connectorboxsnapsink+ytolerance,connectorboxheight+connectorboxsnapheight]) sphere(d=connectorboxsnapd);
      translate([connectorboxx+connectorboxoutw+xtolerance,-connectorboxoutl/2-connectorboxwall-ytolerance,connectorboxheight-connectorboxwall]) roundedbox(connectorboxwall,connectorboxoutl+2*connectorboxwall+2*ytolerance,pcbh+pcbcableholeheight+connectorboxwall,cornerd);
      
      // Fan holder
      difference() {
	hull() {
	  translate([fancenterx-fanbaseedge/2,-fanbaseedge/2,fanheight]) cube([fanbaseedge,fanbaseedge,fanbasethickness]);
	  translate([fancenterx-fanscrewdistance/2,-fanscrewdistance/2,fanheight-(fanbaseedge-fanscrewdistance)]) cube([fanscrewdistance,fanscrewdistance,fanbasethickness]);
	}
	hull() {
	  intersection() {
	    translate([fancenterx,0,fanheight+fanbasethickness-0.1]) cylinder(d=fandiameter,h=fanbasethickness+0.2);
	    translate([fancenterx-fansquarediameter/2,-fansquarediameter/2,fanheight+fanbasethickness-0.1]) cube([fansquarediameter,fansquarediameter,fanbasethickness+0.2]);
	  }
	}
      }

      // Air duct
      hull() {
	translate([openingfrontx-fanductwall,0,baseheight]) resize([openingl+fanductwall*2,openingwidthmax+fanductwall*2,0.01]) opening(0.01);
	intersection() {
	  translate([fancenterx,0,fanheight+fanbasethickness-0.1]) cylinder(d=fandiameter+fanductwall*2,h=0.1);
	  translate([fancenterx-fansquarediameter/2-fanductwall,-fansquarediameter/2-fanductwall,fanheight+fanbasethickness-0.1]) cube([fansquarediameter+2*fanductwall,fansquarediameter+2*fanductwall,0.1+0.01]);
	}
      }

      for (x=[-fanscrewdistance/2,fanscrewdistance/2]) {
	for (y=[-fanscrewdistance/2,fanscrewdistance/2]) {
	  if (screwnutslot) {
	    translate([fancenterx+x,y,baseheight]) cylinder(h=fanheight-baseheight,d=fanscrewd+fanductwall);
	  } else {
	    translate([fancenterx+x,y,baseheight]) cylinder(d=countersinkd(fanscrewd)+fanductwall*2,h=fanheight-baseheight+0.01);
	    //translate([fancenterx+x,y,baseheight]) linear_extrude(fanheight-fanscrewnuth-baseheight) circle((fanscrewbased+fanductwall)/2/cos(180/6), $fn=6);
	  }
	}
      }
      

      translate([frontscrewbased/2+screwlength,0,baseheight+screwtowerd/2+0.1]) rotate([90,0,-90]) ruuvitorni(screwlength,screwtowerd);
    }

    // front screwhole
    hull() {
      translate([0,0,-0.1]) cylinder(d=frontscrewd,h=screwholeheight+baseheight);
      translate([-frontbased,0,-0.1]) cylinder(d=frontscrewd,h=screwholeheight+baseheight);
    }
    translate([frontbackscrewdistance,-backscrewdistance/2,-0.1]) cylinder(d=backscrewd,h=screwholeheight);
    // Right screwhole is wider to accommodate inaccuracy
    hull() {
      translate([frontbackscrewdistance,backscrewdistance/2,-0.1]) cylinder(d=backscrewd,h=screwholeheight);
      translate([frontbackscrewdistance,backscrewdistance/2+backscrewstretch,-0.1]) cylinder(d=backscrewd,h=screwholeheight);
    }

    translate([0,0,frontbaseh]) cylinder(d=frontscrewbased,h=baseheight+basethickness+1);

    // Air duct
    hull() {
      translate([openingfrontx,0,baseheight-0.1]) opening(0.1); //
      intersection() {
	translate([fancenterx,0,fanheight+fanbasethickness-0.01]) cylinder(d=fandiameter,h=0.1+0.01);
	translate([fancenterx-fansquarediameter/2,-fansquarediameter/2,fanheight+fanbasethickness-0.01]) cube([fansquarediameter,fansquarediameter,0.1+0.01]);
      }
    }
    
    translate([frontbackscrewdistance,0,0]) {
      for (y=[-backscrewdistance/2,backscrewdistance/2]) {
	translate([0,y,0]) {
	  translate([0,0,backbaseh]) cylinder(d=backscrewbased,h=baseheight);

	  translate([-backscrewbased/2-screwlength+0.01,0,baseheight+screwtowerd/2+0.1]) rotate([90,0,90]) ruuvireika(screwlength,screwholed,1);

	  translate([-backscrewbased/2+3,0,textdepth-0.01]) rotate([0,180,90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
	}
      }
    }

    translate([frontscrewbased/2+screwlength-0.01,0,baseheight+screwtowerd/2+0.1]) rotate([90,0,-90]) ruuvireika(screwlength,screwholed,1);
    translate([frontscrewbased/2+1,0,textdepth-0.01]) rotate([0,180,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="bottom",halign="center",font="Liberation Sans:style=Bold"); 

    for (x=[-fanscrewdistance/2,fanscrewdistance/2]) {
      for (y=[-fanscrewdistance/2,fanscrewdistance/2]) {
	translate([fancenterx+x,y,fanheight-fanscrewnuth-0.01]) cylinder(d=fanscrewd,h=fanscrewnuth+fanbasethickness+0.2,$fn=90);
	if (screwnutslot) {
	  hull() {
	    translate([fancenterx,0,fanheight-fanscrewnuth]) linear_extrude(fanscrewnuth) circle(fanscrewbased/2/cos(180/6), $fn=6);
	    translate([fancenterx+x,y,fanheight-fanscrewnuth]) linear_extrude(fanscrewnuth) circle(fanscrewbased/2/cos(180/6), $fn=6);
	  }
	  translate([fancenterx+x,y,baseheight+basethickness]) cylinder(h=fanheight-baseheight-basethickness,d=fanscrewd);
	} else {
	  translate([fancenterx+x,y,fanheight]) rotate([180,0,0]) ruuvireika(fanscrewsinkspace,fanscrewd,1);
	  translate([fancenterx+x,y,baseheight+basethickness]) cylinder(d=countersinkd(fanscrewd),h=fanheight-baseheight-basethickness-fanscrewsinkspace+0.01);
	}
      }
    }

    translate([fancenterx,-width/2+5,baseheight+basethickness-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    translate([frontbackscrewdistance-backscrewbased/2-backattachl-screwlength-2,width/2-9,baseheight+basethickness-textdepth+0.01]) rotate([0,0,180]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="bottom",halign="left",font="Liberation Sans:style=Bold");
  }
}

module filter() {
  difference() {
    union() {
      translate([fancenterx-filterl/2,-filterw/2,filterheight]) roundedbox(filterl,filterw,filterwall,cornerd);
      translate([fancenterx-fanedge/2-filterwall,-fanedge/2-filterwall,filterheight]) cube([fanedge+filterwall*2,fanedge+filterwall*2,fanh]);

      /// Tunnel for fan cable
      intersection() {
	hull() {
	  translate([fancenterx-filterl/2,-fanedge/2+cabletunnelposition+cabletunnelwidth/2,filterheight]) rotate([0,90,0]) cylinder(d=cabletunnelwidth+filterwall,h=filterl/2-fanedge/2);
	  translate([fancenterx-filterl/2,-fanedge/2+cabletunnelposition+cabletunnelwidth/2,filterheight+filterwall+cabletunnelheight-cabletunnelwidth/2-0.01]) rotate([0,90,0]) cylinder(d=cabletunnelwidth+filterwall,h=filterl/2-fanedge/2);
	}
	translate([fancenterx-filterl/2,-fanedge/2+cabletunnelposition-filterwall,filterheight]) cube([filterl/2-fanedge/2,cabletunnelwidth+2*filterwall,cabletunnelheight+2*filterwall]);
      }


      for (x=[fancenterx-filterl/2+filterwall/2,fancenterx+filterl/2-filterwall/2]) {
	translate([x+filterwall/2,0,filterheight+filterwall/2]) resize([filterwall,filterw,filterh-filterwall/2]) rotate([0,-90,0]) resize([filterh*2,filterw,filterwall]) intersection() { cylinder(d=100,h=filterwall); translate([0,-50,0]) cube([200,200,200]); };
      }

      if (lockbarwithscrew) {
	for (y=[-filterw/2+lockscrewdistance-filterthickness,filterw/2-lockscrewdistance+filterthickness]) {
	  hull() {
	    translate([fancenterx-filterl/2,y,filterheight+lockbarw/2]) rotate([0,90,0]) ruuvitorni(screwlength-lockscrewbasex,screwtowerd);
	    translate([fancenterx-filterl/2,y-screwtowerd/2,filterheight]) roundedbox(screwlength,screwtowerd,filterwall,cornerd);
	  }
	  hull() {
	    translate([fancenterx+filterl/2,y,filterheight+lockbarw/2]) rotate([0,-90,0]) ruuvitorni(screwlength-lockscrewbasex,screwtowerd);
	    translate([fancenterx+filterl/2-screwlength,y-screwtowerd/2,filterheight]) roundedbox(screwlength,screwtowerd,filterwall,cornerd);
	  }
	}
      }
	
      for (x=[fancenterx-filterl/2+filtersupportdistance:filtersupportdistance:fancenterx+filterl/2-filtersupportdistance]) {
	hull() {
	  translate([x,-filterw/2+filterwall/2,filterheight+filterwall/2]) sphere(d=filterwall);
	  translate([x,filtersupportdownw-filterw/2+filterwall/2,filterheight+filterwall/2]) sphere(d=filterwall);
	  translate([x,0,filterheight+filterh-filtertopzscale/2]) rotate([0,90,0]) resize([filtertopzscale,0,0]) translate([0,0,-filterwall/2]) cylinder(d=filtertopd,h=filterwall);
	}
	hull() {
	  translate([x,filterw/2-filterwall/2,filterheight+filterwall/2]) sphere(d=filterwall);
	  translate([x,-filtersupportdownw+filterw/2-filterwall/2,filterheight+filterwall/2]) sphere(d=filterwall);
	  translate([x,0,filterheight+filterh-filtertopzscale/2]) rotate([0,90,0]) resize([filtertopzscale,0,0]) translate([0,0,-filterwall/2]) cylinder(d=filtertopd,h=filterwall);
	}
	translate([x+filterwall/2,0,filterheight+filterwall/2]) resize([filterwall,filterw,filterh-filterwall/2]) rotate([0,-90,0]) resize([filterh*2,filterw,filterwall]) intersection() { difference() { cylinder(d=100,h=filterwall); translate([0,0,-0.01]) cylinder(d=80,h=filterwall+0.01); } translate([0,-50,0]) cube([200,200,200]); };
      }

      translate([fancenterx-filterl/2+cornerd/2,-filterwall/2,filterheight]) roundedbox(filterl/2-fanedge/2,filterwall,filterh,cornerd);
      translate([fancenterx+filterl/2-filterl/2+fanedge/2,-filterwall/2,filterheight]) roundedbox(filterl/2-fanedge/2,filterwall,filterh,cornerd);
      hull() {
	translate([fancenterx-filterl/2+filterwall/2,0,filterheight+filterh-filterwall/2]) sphere(d=filterwall);
	translate([fancenterx-filterl/2+filterwall/2,0,filterheight+filterh-filterl*5/6]) sphere(d=filterwall);
	translate([fancenterx+filterl/6,0,filterheight+filterh-filterwall/2]) sphere(d=filterwall);
      }
      hull() {
	translate([fancenterx+filterl/2-filterwall/2,0,filterheight+filterh-filterwall/2]) sphere(d=filterwall);
	translate([fancenterx+filterl/2-filterwall/2,0,filterheight+filterh-filterl*5/6]) sphere(d=filterwall);
	translate([fancenterx-filterl/6,0,filterheight+filterh-filterwall/2]) sphere(d=filterwall);
      }
    }

// Fan
    translate([fancenterx-fanedge/2,-fanedge/2,filterheight-0.1]) cube([fanedge,fanedge,fanh+filterwall+0.2]);

    /// Tunnel for fan cable
    hull() {
      translate([fancenterx-filterl/2-0.01,-fanedge/2+cabletunnelposition+cabletunnelwidth/2,filterheight-0.01]) rotate([0,90,0]) cylinder(d=cabletunnelwidth,h=filterl/2-fanedge/2+0.02);
      translate([fancenterx-filterl/2-0.01,-fanedge/2+cabletunnelposition+cabletunnelwidth/2,filterheight+filterwall+cabletunnelheight-cabletunnelwidth/2-0.01]) rotate([0,90,0]) cylinder(d=cabletunnelwidth,h=filterl/2-fanedge/2+0.02);
    }

    // Screwholes for lockbars
    for (y=[-filterw/2+lockscrewdistance-filterthickness,filterw/2-lockscrewdistance+filterthickness]) {
      if (lockbarwithscrew) {
	translate([fancenterx-filterl/2-lockscrewbasex+screwlength-lockscrewbasex,y,filterheight+lockbarw/2]) rotate([0,-90,0]) ruuvireika(screwlength-lockscrewbasex,screwholed,1);
	translate([fancenterx+filterl/2-screwlength+lockscrewbasex+lockscrewbasex,y,filterheight+lockbarw/2]) rotate([0,90,0]) ruuvireika(screwlength-lockscrewbasex,screwholed,1);
      } else {
	translate([fancenterx-filterl/2-0.1,y,filterheight+lockbarw/2]) rotate([0,90,0]) cylinder(d=screwholed,h=filterwall+0.2);
	translate([fancenterx+filterl/2-filterwall-0.1,y,filterheight+lockbarw/2]) rotate([0,90,0]) cylinder(d=screwholed,h=filterwall+0.2);
      }
    }

    translate([fancenterx-filterl/2+5,-filterw/2+5,filterheight+filterwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="left",font="Liberation Sans:style=Bold");    
  }
}

module connectorbox() {
  difference() {
    roundedbox(connectorboxoutl,connectorboxoutw,connectorboxouth,cornerd);
    translate([connectorboxwall,connectorboxwall,connectorboxwall+pcbwirespace]) roundedbox(connectorboxinl,connectorboxinw,connectorboxinh-pcbwirespace+cornerd,cornerd);
    translate([connectorboxwall+wirespacey,connectorboxwall+wirespacex,connectorboxwall]) roundedbox(wirespacel,wirespacew,pcbwirespace+cornerd,cornerd);

    translate([connectorboxwall+powerholex,-0.01,pcbh+powerholeheight]) rotate([-90,0,0]) cylinder(h=connectorboxwall+0.2,d=powerholed);
    translate([connectorboxwall+connectorboxinl-0.1,connectorboxwall+pcbcableholey,pcbh+pcbcableholeheight]) cube([connectorboxwall+0.2,pcbcableholew,connectorboxinh-connectorboxwall-pcbcableholey]);

    translate([connectorboxlidsnapx,connectorboxwall+connectorboxlidsnapsink,connectorboxlidsnapheight+connectorboxlidsnapd/2]) rotate([0,90,0]) cylinder(d=connectorboxlidsnapd,h=connectorboxlidsnapl);
    translate([connectorboxlidsnapx,connectorboxoutw-connectorboxwall-connectorboxlidsnapsink,connectorboxlidsnapheight+connectorboxlidsnapd/2]) rotate([0,90,0]) cylinder(d=connectorboxlidsnapd,h=connectorboxlidsnapl);

    translate([-connectorboxsnapsink,connectorboxsnapw,connectorboxsnapheight]) sphere(d=connectorboxsnapd);
    translate([connectorboxoutl+connectorboxsnapsink,connectorboxsnapw,connectorboxsnapheight]) sphere(d=connectorboxsnapd);
    translate([powerholex+powerholed/2+5,textdepth-0.01,pcbh]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
  }
}

module connectorboxlid() {
  difference() {
    union() {
      translate([0,0,connectorboxlidheight]) roundedbox(connectorboxoutl,connectorboxoutw,connectorboxwall,cornerd);
      translate([connectorboxwall+connectorboxinl,connectorboxwall+pcbcableholey+ytolerance,pcbh+pcbcableholeheight+pcbcableholeh]) roundedbox(connectorboxwall,pcbcableholew-2*ytolerance,connectorboxouth-pcbh-pcbcableholeheight-pcbcableholeh+cornerd,cornerd);
      translate([connectorboxwall+xtolerance,connectorboxwall+ytolerance,connectorboxouth-connectorboxlidraise]) roundedbox(connectorboxwall,connectorboxinw-ytolerance*2,connectorboxlidraise+connectorboxwall,cornerd);
      translate([connectorboxoutl-connectorboxwall-connectorboxwall-xtolerance,connectorboxwall+ytolerance,connectorboxouth-connectorboxlidraise]) roundedbox(connectorboxwall,connectorboxinw-ytolerance*2,connectorboxlidraise+connectorboxwall,cornerd);

      translate([connectorboxlidsnapx+xtolerance,connectorboxwall+connectorboxlidsnapsink+ytolerance,connectorboxlidsnapheight+connectorboxlidsnapd/2]) rotate([0,90,0]) cylinder(d=connectorboxlidsnapd,h=connectorboxlidsnapl-2*xtolerance);
      translate([connectorboxlidsnapx+xtolerance,connectorboxwall+ytolerance,connectorboxlidsnapheight]) roundedbox(connectorboxlidsnapl-2*xtolerance,connectorboxwall,connectorboxouth-connectorboxlidsnapheight+connectorboxwall,cornerd);
      translate([connectorboxlidsnapx+xtolerance,connectorboxoutw-connectorboxwall-connectorboxlidsnapsink-ytolerance,connectorboxlidsnapheight+connectorboxlidsnapd/2]) rotate([0,90,0]) cylinder(d=connectorboxlidsnapd,h=connectorboxlidsnapl-2*xtolerance);
      translate([connectorboxlidsnapx+xtolerance,connectorboxoutw-connectorboxwall-ytolerance-connectorboxwall,connectorboxlidsnapheight]) roundedbox(connectorboxlidsnapl-2*xtolerance,connectorboxwall,connectorboxouth-connectorboxlidsnapheight+connectorboxwall,cornerd);
    }

    translate([connectorboxwall+switchholex,connectorboxwall+switchholey,connectorboxouth-0.01]) cylinder(d=switchholed,h=connectorboxwall+0.02);

    translate([5,connectorboxwall+switchholey+switchholed,connectorboxouth+connectorboxwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="bottom",halign="left",font="Liberation Sans:style=Bold"); 
  }
}

module lockbar() {
  difference() {
    union() {
      roundedbox(lockbarl,lockbarw,lockbarh,cornerd);
      hull() {
	translate([lockbartofilter - lockscrewbasex,screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,90,0]) cylinder(d=screwtowerd,h=lockscrewbasex);
	translate([lockbarscrewsupportthickness/2/2,screwtowerd/2,lockscrewdistance+lockbarh-lockscrewbasex]) rotate([0,90,0]) cylinder(d=screwtowerd,h=0.01);
      }

      translate([lockbarl-lockbarscrewsupportthickness,0,0]) roundedbox(lockbarscrewsupportthickness,lockbarw,lockscrewdistance+lockbarh,cornerd);
      roundedbox(lockbarscrewsupportthickness,lockbarw,lockscrewdistance+lockbarh,cornerd);
      
      hull() {
	translate([lockbarl-(lockbartofilter - lockscrewbasex)-lockscrewbasex,screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,90,0]) cylinder(d=screwtowerd,h=lockscrewbasex);
	translate([lockbarl-(lockbarscrewsupportthickness/2/2),screwtowerd/2,lockscrewdistance+lockbarh-lockscrewbasex]) rotate([0,90,0]) cylinder(d=screwtowerd,h=0.01);
      }

      if (!lockbarwithscrew) {
	translate([lockbarl-lockbartofilter+0.01,screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,-90,0]) cylinder(d1=screwholed,d2=0.1,h=screwholed);
	translate([lockbartofilter-0.01,screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,90,0]) cylinder(d1=screwholed,d2=0.1,h=screwholed);
      }
      
      for (x=[lockbartofilter+lockbarpindistance:lockbarpindistance:lockbarl-lockbartofilter-lockbarpindistance]) {
	translate([x,lockbarw/2,lockbarh-0.01]) cylinder(d=lockbarpind,h=lockbarnarrowing);
	translate([x,lockbarw/2,lockbarh+lockbarnarrowing+0.01]) cylinder(d1=lockbarpind,d2=lockbartopd,h=lockbarpinh-lockbarnarrowing);
      }
    }
    
    if (lockbarwithscrew) {
      translate([-0.01,screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,90,0]) cylinder(d=countersinkd(screwholed),h=lockbartofilter-lockscrewbasex+0.02);
      translate([lockbartofilter + screwlength - lockscrewbasex-0.01,screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,-90,0]) ruuvireika(screwlength,screwholed,1);
    }
    if (lockbarwithscrew) {
      translate([lockbarl+0.01-(lockbartofilter-lockscrewbasex+0.02),screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,90,0]) cylinder(d=countersinkd(screwholed),h=lockbartofilter-lockscrewbasex+0.02);
      translate([lockbarl-screwlength-(lockbartofilter - lockscrewbasex-0.01),screwtowerd/2,lockscrewdistance+lockbarh]) rotate([0,90,0]) ruuvireika(screwlength,screwholed,1);
    }
    translate([5,2,textdepth-0.01]) rotate([0,180,180]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="top",halign="left",font="Liberation Sans:style=Bold"); 
  }
}

cutpoint2=frontscrewbased/2+frontattachl;
cutlen2=frontbackscrewdistance-backscrewbased/2-backattachl-backattachl-frontscrewbased/2;
cutpoint3=frontscrewbased/2+frontattachl;
cutlen3=100;

if (print==0) {
  leafbatteryfan();
  filter();
  translate([connectorboxx,connectorboxoutl/2,connectorboxheight]) rotate([0,0,-90]) connectorbox();
  translate([connectorboxx,connectorboxoutl/2,connectorboxheight]) rotate([0,0,-90]) connectorboxlid();
  translate([fancenterx-filterl/2-lockbartofilter,-filterw/2-lockscrewdistance-lockbarh+screwtowerd/2,filterheight+lockbarw]) rotate([-90,0,0]) lockbar();
  translate([fancenterx-filterl/2-lockbartofilter,filterw/2+lockscrewdistance+lockbarh-screwtowerd/2,filterheight]) rotate([90,0,0]) lockbar();
 }

if (print==1 || print==5) {
  // Connectorbox
  translate([81,0,0]) {
    connectorbox();
    translate([0,-1,connectorboxouth+connectorboxwall]) rotate([180,0,0]) connectorboxlid();
  }

  // Front attachment
  translate([98-frontbased-3-frontattachl-frontbelowsupportx,0,0]) intersection() {
    leafbatteryfan();
    union() {
      translate([-frontbased/2,-width/2,0]) cube([frontbased/2+frontscrewbased/2+frontattachl-0.01,width,baseheight+frontattachh]);
      translate([frontscrewbased/2+frontattachl-0.02,-frontbelowsupporty/2,0]) cube([frontbelowsupportx+0.02,frontbelowsupporty,baseheight-0.01]);
    }
  }

  // Body
  translate([1,0,-baseheight]) intersection() {
    leafbatteryfan();
    union() {
      translate([0,-width/2,baseheight+frontattachh]) cube([cutpoint2+1,width,height-frontattachh]);
      translate([cutpoint2+0.01,-width/2,baseheight]) cube([cutlen2-0.02,width,height]);
      translate([cutpoint2+cutlen2-cornerd+0.01,-backscrewdistance/2+backbased/2+ytolerance,0]) cube([backbased+cornerd-0.02,backscrewdistance-backbased-ytolerance*2,height]);
    }
  }

  // Aft attachment
  translate([-frontbackscrewdistance+backscrewbased/2+backattachl+81+connectorboxoutl+backbelowsupportx+1,backscrewdistance/2-backbased/2-1,0]) intersection() {
    leafbatteryfan();
    union() {
      translate([cutpoint2+cutlen2+0.01,-backscrewdistance/2-backbased/2,0]) cube([cutlen3-0.02,backbased,height]);
      translate([cutpoint2+cutlen2-backbelowsupportx,-backscrewdistance/2-backbelowsupporty/2,0]) cube([backbelowsupportx+0.01,backbelowsupporty,baseheight]);
    }
  }

  translate([-frontbackscrewdistance+backscrewbased/2+backattachl+81+connectorboxoutl+backbelowsupportx+1,-backscrewdistance/2+backbased/2+1,0]) intersection() {
    leafbatteryfan();
    union() {
      translate([cutpoint2+cutlen2+0.01,backscrewdistance/2-backbased/2,0]) cube([cutlen3-0.02,backbased,height]);
      translate([cutpoint2+cutlen2-backbelowsupportx,backscrewdistance/2-backbelowsupporty/2,0]) cube([backbelowsupportx+0.01,backbelowsupporty,baseheight]);
    }
  }

  if (print==5) {
    translate([-fancenterx+filterl/2+lockbarw*2+2,basewidthmax/2+filterw/2+1,-filterheight]) filter();
  
    translate([lockbarw,35,0]) rotate([0,0,90]) lockbar();
    translate([lockbarw*2+1,35,0]) rotate([0,0,90]) lockbar();
  }
 }


if (print==2) {
  lockbar();
  translate([0,-lockbarw-1,0]) lockbar();
  translate([-fancenterx+filterl/2,filterw/2+lockbarw+1,-filterheight]) filter();
 }

if (print==3) {
  connectorbox();
  translate([0,-1,connectorboxouth+connectorboxwall]) rotate([180,0,0]) connectorboxlid();
 }

if (print==4) {
  // Body
  translate([1,0,-baseheight]) intersection() {
    leafbatteryfan();
    union() {
      translate([0,-width/2,baseheight+frontattachh]) cube([cutpoint2+1,width,height-frontattachh]);
      translate([cutpoint2+0.01,-width/2,baseheight]) cube([cutlen2-0.02,width,height]);
      translate([cutpoint2+cutlen2-cornerd+0.01,-backscrewdistance/2+backbased/2+ytolerance,0]) cube([backbased+cornerd-0.02,backscrewdistance-backbased-ytolerance*2,height]);
    }
  }
 }
