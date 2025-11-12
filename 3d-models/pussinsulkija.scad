// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

debug=0;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
dtolerance=0.6;
wall=3;
cornerd=1;

bagw=0.5;

l=200;
w=7;
h=12;
depth=1; // Depth of groove
axled=8;
angle=40;
printangle=(debug>0)?0:20; // Print angle. Thus must be open when printing due to curved grab part
axledepth=2.2;
springw=1.6;
springhook=3;
springcutd=-(springw-(w-bagw));
springcutw=1;
springl=10;
springoutd=springcutd+springw*2;
outsided=axled+dtolerance+wall*2;
axlel=h-axledepth*2;
hingelength=max(w,outsided/2)+wall+1;
hingew=wall+1;
rootl=outsided*1.5;

textdepth=0.7;
textsize=w;
versiontext="v1.0";
textfont="Liberation Sans:style=Bold";
labelsize=5;

grabdepth=1.8;
grabstart=outsided+dtolerance/2+cornerd/2;
//grabl=l-(outsided+xtolerance)*2-grabdepth*2;
grabl=l-grabstart-outsided/2-xtolerance;
grabconcave=0.5;

grabr=grabconcave/2+grabl*grabl/8/grabconcave;
grabd=2*grabr;
echo(grabd);

module pussinsulkija() {
  if (1) difference() {
    union() {
      translate([0,0,-h/2]) roundedcylinder(outsided,h,cornerd,1,90);

      hull() {
	intersection() {
	  translate([0,0,-h/2]) roundedcylinder(outsided,h,cornerd,1,90);
	  translate([-outsided/2,ytolerance+cornerd/2,-h/2]) cube([outsided,outsided/2-ytolerance,h]);
	}
	translate([-outsided/2,hingelength-hingew,-h/2]) roundedbox(outsided*1.5,hingew,h,cornerd,1);
	translate([outsided/2+xtolerance,ytolerance,-h/2]) roundedbox(rootl,w-ytolerance,h,cornerd,1);
      }

      translate([0,bagw/2,-h/2]) roundedbox(l+xtolerance+springw-springoutd/2+cornerd/2,w-bagw/2,h,cornerd);
      translate([0,bagw/2,-h/2]) roundedbox(l,w-bagw/2-springw-springcutw,h,cornerd);
      
      intersection() {
	translate([l+xtolerance+springw-springoutd/2,w-springoutd/2,-h/2]) roundedcylinder(springoutd,h,cornerd,1,90);
	translate([l+xtolerance+springw-springoutd/2,w-springoutd/2,-h/2]) cube([springoutd/2,springoutd/2,h]);
      }
      translate([l+xtolerance,-w-springhook,-h/2]) roundedbox(springw,w*2+springhook-springoutd/2+cornerd/2,h,cornerd);
      hull() {
	translate([l+xtolerance,-w-springhook-springw-ytolerance,-h/2]) roundedbox(springw,springhook+springw,h,cornerd);
	translate([l+xtolerance-springhook,-w-cornerd-ytolerance,-h/2]) roundedbox(springw,cornerd,h,cornerd);
      }
    }

    translate([axled/2,hingelength/2,h/2-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-2,halign="left", valign="center");
    
    difference() {
      hull() {
	translate([l+xtolerance-springcutd/2,bagw/2,-h/2-0.01]) cylinder(d=springcutd,h=h+0.02,$fn=90);
	translate([l+xtolerance-springcutd/2,w-springw-springcutd/2,-h/2-0.01]) cylinder(d=springcutd,h=h+0.02,$fn=90);
      }

      hull() {
	for (x=[l-springcutd+springcutw/2,l+xtolerance-springcutw]) {
	  translate([x,bagw/2,-h/2-0.01]) cylinder(d=springcutw,h=h+0.02,$fn=90);
	  translate([x,w-springw-springcutw-springcutw/2,-h/2-0.01]) cylinder(d=springcutw,h=h+0.02,$fn=90);
	}
      }
    }

    hull() {
      translate([l+xtolerance-springcutd/2,w-springw-springcutw/2,-h/2-0.01]) cylinder(d=springcutw,h=h+0.02,$fn=90);
      translate([l+xtolerance-springcutd/2-springl,w-springw-springcutw/2,-h/2-0.01]) cylinder(d=springcutw,h=h+0.02,$fn=90);
    }
    
    hull() {
      translate([grabstart+grabdepth-xtolerance,-bagw/2-0.01,-grabdepth-ztolerance]) triangle(grabl-grabdepth*2+xtolerance*2,grabdepth+bagw/2+ytolerance,grabdepth*2+ztolerance*2,20);
      translate([grabstart-xtolerance,-bagw/2-0.01,-grabdepth-ztolerance]) cube([grabl+xtolerance*2,0.01,grabdepth*2+ztolerance*2]);
    }

    rotate([90,0,0]) onehinge(axled,axlel,axledepth,2,ytolerance,dtolerance);

    hull() for (a=[0,angle]) rotate([0,0,-a]) {
	hull() {
	  translate([-axled/2-dtolerance/2,-hingelength,-h/2+axledepth+axlel-axled/2]) triangle(axled+dtolerance,hingelength,axled/2+ztolerance,12);
	  translate([-axled/2-dtolerance/2,-hingelength,-h/2+axledepth-ztolerance]) cube([axled+dtolerance,hingelength,axlel-axled/2]);
	}
      }
    
    for (a=[0:1:angle]) rotate([0,0,-a]) {
	translate([-outsided/2,-hingelength,-h/2-cornerd/2]) roundedbox(outsided+xtolerance+cornerd,hingew+dtolerance/2,h+cornerd,cornerd,1);
      }

    hull() for (a=[0,angle]) rotate([0,0,-a]) {
	translate([-0.01,-hingelength,axlel/2+ztolerance]) triangle(0.02,hingew+dtolerance/2,h/2+0.01,8);
      }
  }
  if (1) rotate([0,0,-printangle]) {
    rotate([90,0,0]) onehinge(axled,axlel,axledepth,0,ytolerance,dtolerance);
    hull() {
      translate([-axled/2,-hingelength,-h/2+axledepth+axlel-axled/2]) triangle(axled,hingelength,axled/2,12);
      translate([-axled/2,-hingelength,-h/2+axledepth]) cube([axled,hingelength,axlel-axled/2]);
    }
    if (1) hull() {
      translate([grabstart+grabdepth,-bagw/2-0.01,-grabdepth]) triangle(grabl-grabdepth*2,grabdepth+bagw/2,grabdepth*2,20);
      translate([grabstart,-bagw/2-0.01,-grabdepth]) cube([grabl,0.01,grabdepth*2]);
    }
    intersection() {
      translate([grabstart+grabdepth,-w,-h/2]) cube([grabl-grabdepth*2,w*2,h]);
      union() {
	hull() {
	  translate([grabstart+grabl/2,grabconcave-grabd/2,-grabdepth]) cylinder(d=grabd,h=grabdepth*2,$fn=2*360);
	  translate([grabstart+grabl/2,grabconcave-grabd/2,-grabdepth-grabdepth]) cylinder(d=grabd-grabdepth*2,h=grabdepth*2+grabdepth*2,$fn=2*360);
	}
	hull() {
	  translate([grabstart+grabl/2,grabconcave-grabd/2,-grabdepth]) cylinder(d=grabd,h=grabdepth*2,$fn=2*360);
	  translate([grabstart+grabl/2,grabconcave-grabd/2,-0.05]) cylinder(d=grabd+grabconcave*2*2*2,h=0.1,$fn=2*360);
	}
      }
    }
    
    translate([outsided/2+xtolerance,-w,-h/2]) roundedbox(l-(outsided/2+xtolerance),w-bagw/2,h,cornerd,1);
    translate([-outsided/2,-hingelength,-h/2]) roundedbox(outsided*1.5,hingew,h,cornerd,1);
    difference() {
      hull() {
	translate([outsided/2+xtolerance,-w,-h/2]) roundedbox(rootl,w-bagw/2,h,cornerd,1);
	translate([0,-hingelength,-h/2]) roundedbox(outsided,hingew,h,cornerd,1);
      }
      translate([0,0,-h/2-0.01]) cylinder(d=outsided+dtolerance,h=h+0.02,$fn=90);
    }
  }
}

intersection() {
  //if (debug) translate([l/2,-100,-h]) cube([1000,1000,1000]);
  if (debug) translate([-100,-100,0]) cube([1000,1000,1000]);
  pussinsulkija();
}
