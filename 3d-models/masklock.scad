// lock for cpap mask to replace broken one

// Print with snug or similar support

include <hsu.scad>

versiontext="V1.1";
textsize=4;
textdepth=0.8;

topwidth=26;
addheight=2;
strapholewidth=18;
strapholeheight=17.52+addheight;
fullwidthheight=0.75; // How large part is full width
strapholesize=4;
strapholeupperdiameter=5.6;
strapholeupperz=strapholeheight+strapholesize+strapholeupperdiameter/2;
strapholeside=3.5;
lockpinwidth=8.3; //6.6;
lockpinlowersupportwidth=16;//lockpinwidth+4;
lockpindiameter=5;
lockpinheight=8.7+addheight;
lockpiny=12.3+2.5;
lockpinysupport=3;
lockpinverticalsupporty=lockpiny-1;
lockpinverticalsupportysize=lockpinysupport+1;
lockbasey=3.77;
lockpinyl=2.5;
lockpincornerd=10;
lockpincornery=lockpiny-lockpincornerd/2;

lockh=10.2+0.5;

//maskpind=5;
maskpind=5.5;
//maskpiny=8-maskpind/2;
maskpiny=lockh-2-maskpind/2;
maskpinheight=3+maskpind/2;

basey=5.5;
$fn=90;
cornerd=1;

module masklock() {
  difference() {
    union() {
      hull() {
	translate([0,0,strapholeheight*fullwidthheight]) roundedbox(topwidth,4.2,strapholeheight*(1-fullwidthheight),cornerd);
	//	translate([0,0,strapholeheight*fullwidthheight]) roundedbox(topwidth,basey,strapholeheight*(1-fullwidthheight),cornerd);
	translate([topwidth/2-lockpinlowersupportwidth/2,0,0]) roundedbox(lockpinlowersupportwidth,3.08,lockpinysupport,cornerd);
      }
      translate([strapholeupperdiameter/2,strapholeupperdiameter/2,strapholeupperz]) rotate([0,90,0]) cylinder(h=topwidth-strapholeupperdiameter,d=strapholeupperdiameter);

      for (x=[0,topwidth-strapholeside]) {
	hull() {
	  translate([x,0,strapholeupperz-strapholeupperdiameter/2]) roundedbox(strapholeside,basey,strapholeupperdiameter,cornerd);
	  translate([x,0,strapholeheight*fullwidthheight]) roundedbox(strapholeside,4.2,strapholeupperz+strapholeupperdiameter/2-strapholeheight*fullwidthheight,cornerd);
	}
      }
      
      intersection() {
	translate([topwidth/2-lockpinwidth/2,lockh-lockpincornerd/2,lockpincornerd/2]) rotate([0,90,0]) roundedcylinder(lockpincornerd,lockpinwidth,cornerd,0,90);
	translate([topwidth/2-lockpinwidth/2,lockh-lockpincornerd,0]) cube([lockpinwidth,lockpincornerd,lockpincornerd/2]);
      }

      translate([topwidth/2-lockpinwidth/2,0,0]) roundedbox(lockpinwidth,lockh-lockpincornerd/2,lockh-lockpincornerd/2,cornerd);
      hull() {
	translate([topwidth/2-lockpinwidth/2,lockbasey-cornerd,0]) roundedbox(lockpinwidth,lockh-lockpincornerd/2-lockbasey,cornerd,cornerd);
	translate([topwidth/2-lockpinwidth/2,lockh-cornerd,lockpincornerd/2-cornerd]) roundedbox(lockpinwidth,cornerd,11-lockpincornerd/2+cornerd,cornerd);
	//translate([topwidth/2-lockpinwidth/2,0,0]) roundedbox(lockpinwidth,1,lockpinysupport+addheight,cornerd);
 
	// translate([topwidth/2-lockpinwidth/2,lockpiny-cornerd,0]) roundedbox(lockpinwidth,lockpinyl,3.7,cornerd);
      }

      hull() {
	//  translate([topwidth/2-lockpinwidth/2,lockpinverticalsupporty,0]) roundedbox(lockpinwidth,lockpinverticalsupportysize,lockpinheight+lockpinwidth/2,cornerd);
	//  translate([topwidth/2-lockpinwidth/2,lockpinverticalsupporty,0]) roundedbox(lockpinwidth,lockpinverticalsupportysize,lockpinysupport+lockpinwidth/2,cornerd);
      }
    }

    hull() {
      translate([topwidth/2-lockpinwidth/2-0.1,0,lockh-maskpind/2+cornerd]) rotate([0,90,0]) cylinder(d=maskpind,h=lockpinwidth+0.2,$fn=90);
      translate([topwidth/2-lockpinwidth/2-0.1,0,maskpinheight]) rotate([0,90,0]) cylinder(d=maskpind,h=lockpinwidth+0.2,$fn=90);
      translate([topwidth/2-lockpinwidth/2-0.1,maskpiny,maskpinheight]) rotate([0,90,0]) cylinder(d=maskpind,h=lockpinwidth+0.2,$fn=90);
    }

    translate([topwidth/2,4.2-textdepth+0.01,strapholeheight*fullwidthheight+strapholeheight*(1-fullwidthheight)/2]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

rotate([90,0,0])
masklock();

