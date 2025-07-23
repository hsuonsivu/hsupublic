// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// todo:
// +Back opening mechanism needs too much for - maybe change angle
// +remove sphere thing from plunger
// +add garbage slits to the sotrage area.
// +Add wall to storage area to prevent berries escaping
// -make more space for slide parts, it seems to get stuck
// -Slide spring breaks after some use, make it separate so that that breaking does not change function.
// +Side walls are thin and have broken once, add strengtening to the edges.
include <hsu.scad>

print=0; // 0=full model, 1=body, 2=plunger, 3=all parts, 4=smaller debug model, 5=spring test, 6=spring

adhesion=1; // Additional bits to allow using skirt when printing.

flatspring=1;
plungerdown=print==0?0:0;

debug=print==0?1:0;

$fn=120;

testhreduction=(print==4)?20:0;
testwreduction=(print==4)?50:0;
testlreduction=(print==4)?0:0; // testlreduction=(print==4)?58:0;
testslreduction=(print==4)?50:0;

length=228-testlreduction;
height=75-testhreduction; // 125;

versiontext="v1.11"; // str("v1.10",(print==4)?"D":"");;

textsize=(print==4)?4:7;
smalltextsize=3;
textdepth=0.7;

wall=2.0;
strengthd=3.2;//2.5;

topl=190-testlreduction;
bottoml=160-testlreduction;

fingerl=70;
fingerw=9;
fingers=(print==4)?4:8;
fingerh=6; //3*1.5;
fingerdistance=15.5;// width/fingers; // This should be diameter of a full grown blueberry, need to test
width=fingerdistance*fingers; //140;
fingerendheight=8;
fingertoph=height-10;
fingertopl=topl+20;
fingerstart=bottoml-8;
fingernarrowl=6;
fingercuth=0.1;
fingercutw=fingerw-5;

preventerh=25;
preventers=(floor(fingers/4)*2);
preventerdistance=width/preventers;

storagel=176-2*preventerh-preventerdistance-testslreduction;

handled=23.5+2*wall;
handleattachd=30;
handlex=42.5;
handlefrontattach=topl-handleattachd;
handlel=topl-handlex-10;
cornerd=wall/2;
fingercornerd=wall*2;
plungecornerd=4;
lcornerd=20;

cutw=0.5;
cliph=50;
clipsidew=15;
clipsideh=15;
clipw=handled-2*wall;
clipdepth=6;
clipheight=wall;
clippullh=wall+3;

clipslided=clipw-2*cutw;
clipplungerzmovement=clipdepth*2;

xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;

bridgey=5; // Maximum bridge in y direction

plungerx=plungerdown?clipdepth+xtolerance:0; //clipplungerzmovement/2:0;
plungerz=plungerdown?-clipplungerzmovement-ztolerance:0;

plungerh=handlel-clippullh-clipplungerzmovement+clipslided; // height;
plungerd=clipslided;
plungerangledh=clipslided*2;

plungeclipshelfdepth=2;
plungeclipshelfh=2;
plungeclipcut=0.5;
plungeclipdepth=3;
plungeclipd=3.5;
plungeclipnotchd=2.5; // to allow unclipping
plungeclipl=1.5;
plungeclipw=clipslided/3;
plungecliph=25-2;
plungeclipfingerd=12;
plungecliptopadjust=2; // More space to place notch
plungecliptopadjusth=plungecliph-20;
plungercountersupporth=plungerangledh+clipplungerzmovement;
plungercountersupportw=2;
plungercountersupportheight=clipplungerzmovement+plungercountersupportw;
plungeclipshelfw=plungeclipw+3*wall+0.01;//clipslided;
longhandlel=500;
longhandled=handled;

plungespringcut=0.5;
plungespringdepth=plungerd/2-3.5;
plungespringbaseh=plungespringdepth;
plungespringbaseheight=clipslided;
plungerheight=clippullh+clipplungerzmovement+ztolerance;
plungerzposition=plungerheight+plungerz;
plungespringsteps=7;
plungespringsteph=2;
plungespringendh=4;

plungespringthickness=flatspring?1.5:2.8;
plungespringplatethickness=2;

plungespringsupportw=9; // Round spring
plungespringw=11; // Flat spring
plungespringl=11; // Flat spring
plungespringspacew=plungespringw+1; // Flat spring
plungespringspacel=plungespringl+1; // Flat spring
plungespringd=13; // Round spring diameter
plungespringspaced=plungespringd+1;

plungespringtension=1.5; // Spring is printed slightly longer to pretension it
plungespringxoffset=flatspring?plungerd/3/2-2.5:plungerd/3/2-1;
plungespringcenteringxoffset=plungespringxoffset;
plungespringcenteringh=2.5; // 3;
plungespringcenteringd=6;
plungespringbottomheight=plungerangledh-11+ztolerance; // Spring starts here relative to plunger start
plungespringtopheight=plungerh-25-2; // spring ends here
plungespringh=plungespringtopheight-plungespringbottomheight-ztolerance*2;
plungespringspaceh=plungespringtopheight-plungespringbottomheight;
plungespringstep=plungespringh/plungespringsteps;
plungespringstopperh=plungespringbaseh*1.9;

hingew=4;
axledsmall=5;
axledlarge=axledsmall+wall;;
axleoutd=axledlarge+2;
axleh=axleoutd/2+wall/2;
axlefrombottom=axleh; //dlarge/2+wall;
axledtolerance=0.7;
hingeh=axleh+axleoutd/2;
backopening=axlefrombottom+4.5;
backcornersupport=10;
//hinged=axledlargeout-axledtolerance;
handlelowh=clippullh+clipplungerzmovement+3+handled-plungespringbaseh*2+wall;

plungespringheight=handlelowh-wall; //clipslided+clipplungerzmovement; // From start of the plunger

slitd=fingerdistance-fingerw;
slitstart=backopening+axleoutd+wall;
slitl=storagel-1-slitstart-slitd/2-2;
slitsw=width-fingerw;
slitwall=3;
  
//versiontext=str("piikki ",fingerw,"  rako ",fingerdistance-fingerw,"  ",versiontextb);

module axletappi(r) {
  hull() {
    translate([0,(r==180)?-wall-ytolerance:wall+ytolerance,0]) rotate([90,0,r]) cylinder(d1=axledsmall,d2=axledlarge,h=wall+ytolerance,$fn=90);
  }
}

module axlehole(r) {
  hull() {
    translate([0,(r==0)?wall+ytolerance*2:-ytolerance-0.01,0]) rotate([90,0,r]) cylinder(d1=axledsmall+axledtolerance,d2=axledlarge+ytolerance+axledtolerance,h=wall+ytolerance+ytolerance+0.01,$fn=90);
  }
}

module plunger() {
  // Plunger for clip mechanism
  difference() {
    union() {
      translate([0,0,0]) roundedcylinder(plungerd,plungerh,plungecornerd,2,60);
      hull() {
	translate([-plungerd/2-plungeclipd+1,-plungeclipw/2+plungeclipcut,plungerh-plungeclipd*2]) triangle(plungeclipd,plungeclipw-plungeclipcut*2,plungeclipd*2,3);
	translate([-plungerd/2-plungeclipd+1+plungecornerd/2,-plungeclipw/2+plungeclipcut,plungerh-plungeclipd*2]) triangle(plungeclipd,plungeclipw-plungeclipcut*2,plungeclipd*2,3);
      }

      if (adhesion) {
	w=plungeclipw+plungeclipcut+1;
	translate([-plungerd/2-plungeclipd,-w/2,plungerh-0.2]) cube([0.4,w,0.2]);
	translate([-plungerd/2-plungeclipd,-w/2,plungerh-0.2]) cube([plungerd/3,0.4,0.2]);
	translate([-plungerd/2-plungeclipd,w/2-0.4,plungerh-0.2]) cube([plungerd/3,0.4,0.2]);
      }
    }

    translate([-plungespringcenteringxoffset,0,plungespringtopheight-0.01]) cylinder(h=plungespringcenteringh/2+0.01,d2=plungespringcenteringd/3,d1=plungespringcenteringd*1.5,$fn=90);
    translate([-plungespringcenteringxoffset,0,plungespringtopheight+ztolerance]) cylinder(h=plungespringcenteringh+0.01,d2=plungespringcenteringd/3+xtolerance,d1=plungespringcenteringd+xtolerance,$fn=90);
      
    // Spring support cut
    union() {
      if (flatspring) {
	//	  translate([-plungerd/2-0.01,-plungespringspacew/2-plungespringcut,-0.01]) cube([plungespringdepth+plungespringcut+0.02,plungespringw+plungespringcut*2,plungespringbottomheight+plungespringbaseh*2+0.02]);
	  translate([-plungerd/2-0.01,-plungespringsupportw/2-plungespringcut,-0.01]) cube([plungespringdepth+plungespringcut+0.02,plungespringsupportw+plungespringcut*2,plungespringbottomheight+plungespringbaseh*2+0.02]);
      } else {
	hull() {
	  translate([-plungerd/2-0.01,-plungespringsupportw/2-plungespringcut,-0.01]) cube([plungespringdepth+plungespringcut+0.02,plungespringsupportw+plungespringcut*2,plungespringbottomheight+plungespringbaseh*2+0.02]);
	  translate([-plungespringxoffset,0,-0.01]) cylinder(d=plungespringsupportw+xtolerance,h=plungespringbottomheight+plungespringbaseh*2);
	}
      }

      hull() {
	if (flatspring) {
	  translate([-plungespringxoffset-plungespringspacel/2,-plungespringspacew/2,-0.01]) cube([plungespringspacel,plungespringspacew,plungespringbottomheight+plungespringbaseh*2+0.02]);
	} else {
	  translate([-plungespringxoffset,0,plungespringbottomheight-4-0.01]) cylinder(d2=plungespringspaced,d1=plungespringsupportw+xtolerance,h=4+0.02,$fn=90);
	}
      }
    }

    if (flatspring) {
      translate([-plungespringxoffset-plungespringspacel/2,-plungespringspacew/2,plungespringbottomheight-0.01]) cube([plungespringspacel,plungespringspacew,plungespringspaceh+0.02]);
    } else {
      // Round spring space inside the plunger
      translate([-plungespringxoffset,0,plungespringbottomheight-0.01]) cylinder(d=plungespringspaced,h=plungespringspaceh+0.02,$fn=90);
    }
    
    // text cut
    tlx=len(versiontext)*(textsize-1);
    tl=(print==4)?tlx/2:tlx;
    
   hull() {
      translate([plungerd-0.01,-plungerd/2,plungerangledh+ztolerance+4-plungerd*2/3]) cube([0.02,plungerd,tl]);
      translate([plungerd/3,-plungerd/2,plungerangledh+ztolerance+4]) cube([plungerd/3,plungerd,tl]);
    }
    translate([plungerd/3-textdepth+0.01,0,plungerangledh+ztolerance+4+tl/2]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=((print==4)?textsize/2:textsize),halign="center", valign="center");

    // Create angled bottom
    translate([-plungerd/2,-plungerd/2-0.1,-0.02]) triangle(plungerd+0.01,plungerd+0.2,plungerangledh+0.02,0);

    // Cut off sharp edges
    translate([-plungerd/2,-plungerd/2,-0.02]) cube([plungerd+0.01,plungerd,5]);

    // Cut for plunge clip
    union() {
      translate([plungeclipdepth-plungerd/2,-plungeclipw/2,plungerh-plungecliph]) cube([plungeclipcut+plungeclipd/2+0.01,plungeclipw,plungecliph-plungecliptopadjusth+0.1]);
      translate([-plungerd/2,-plungeclipw/2,plungerh-plungecliph]) cube([plungeclipdepth+plungeclipcut+plungecliptopadjust,plungeclipcut,plungecliph+0.1]);
      translate([-plungerd/2,plungeclipw/2-plungeclipcut,plungerh-plungecliph]) cube([plungeclipdepth+plungeclipcut+plungecliptopadjust,plungeclipcut,plungecliph+0.1]);

      translate([plungeclipdepth-plungerd/2+plungecliptopadjust,-plungeclipw/2,plungerh-plungecliph]) cube([plungeclipcut+plungeclipd/2+plungecliptopadjust,plungeclipw,plungecliph+0.1]);
    
      translate([-plungerd/2+plungeclipdepth-plungeclipnotchd+plungecliptopadjust,-plungeclipw/2+plungeclipcut-0.1,plungerh]) rotate([-90,0,0]) cylinder(d=plungeclipnotchd,h=plungeclipw-2*plungeclipcut+0.2,$fn=6);
    }
  }
}

module plungespring(tension) {
  difference() {
    union() {
      // Spring
      if (flatspring) {
	translate([-plungespringxoffset-plungespringl/2,-plungespringw/2,plungespringbottomheight+ztolerance-plungerz]) roundedbox(plungespringl,plungespringw,wall,cornerd);
	translate([-plungespringxoffset-plungespringl/2,plungespringw/2,plungespringbottomheight+ztolerance-plungerz]) scale([1,1,(plungespringh+plungerz+tension)/plungespringh]) rotate([90,0,0]) flatspring(plungespringh,plungespringl,plungespringw,1,12,1);
	translate([-plungespringxoffset-plungespringl/2,-plungespringw/2,plungespringtopheight-wall-ztolerance+tension]) roundedbox(plungespringl,plungespringw,wall,cornerd);
	// Bottom orient
	translate([-plungespringcenteringxoffset,0,plungespringbottomheight-plungerz-plungespringcenteringh+0.01]) cylinder(h=plungespringcenteringh+ztolerance+0.01,d1=plungespringcenteringd/3,d2=plungespringcenteringd,$fn=60);
      } else {
	translate([-plungespringxoffset,0,plungespringbottomheight+ztolerance]) scale([1,1,(plungespringh+tension)/plungespringh]) spring(plungespringh,plungespringd,plungespringplatethickness,plungespringthickness);
      }

      // Top orient
      translate([-plungespringcenteringxoffset,0,plungespringbottomheight+ztolerance+plungespringh+tension-0.01]) cylinder(h=plungespringcenteringh+ztolerance+0.01,d2=plungespringcenteringd/3,d1=plungespringcenteringd,$fn=60);
    }

    translate([-plungespringxoffset-plungespringl/2,plungespringw/2-smalltextsize-0.7,plungespringtopheight-ztolerance+tension+0.01]) cube([plungespringl,plungespringw/2-(plungespringw/2-smalltextsize-0.7),wall]);
    translate([-plungespringxoffset,plungespringw/2-0.5,plungespringtopheight-wall-ztolerance+tension-textdepth+wall+0.01]) linear_extrude(height=textdepth+0.01) text(versiontext,font="Liberation Sans:style=Bold",size=smalltextsize,halign="center", valign="top");
  }
}

module sideform() {
  hull() {
    translate([lcornerd/2,width/2-wall/2,0]) cylinder(d=lcornerd,h=topl+wall-cornerd/2);
    translate([height-lcornerd/2,width/2-wall/2,0]) cylinder(d=lcornerd,h=topl-cornerd/2);
    translate([fingerendheight+fingerh-wall/2,width/2-wall,length]) roundedbox(wall,wall,wall,cornerd);
    translate([fingertoph,width/2-wall,fingertopl]) roundedbox(wall,wall,wall,cornerd);
    intersection() {
      finger(width/2);
      translate([0,width/2-wall,0]) cube([height,wall,length]);
    }
  }
}

module sideformcut() {
  hull() {
    translate([lcornerd/2,width/2-wall/2,wall]) cylinder(d=lcornerd-wall*2,h=topl-wall-cornerd/2);
    translate([height-lcornerd/2,width/2-wall/2,wall]) cylinder(d=lcornerd-wall*2,h=topl-wall*2-cornerd/2);
    translate([fingerendheight+fingerh-wall/2-wall,width/2-wall-wall,length-wall]) roundedbox(wall,wall,wall,cornerd);
    translate([fingertoph-wall,width/2-wall-wall,fingertopl-wall]) roundedbox(wall,wall,wall,cornerd);
  }
}

module sides() {
  for (m=[0,1]) mirror([0,m,0]) {
      difference() {
	union() {
	  intersection() {
	    difference() {
	      sideform();

	      sideformcut();
	    }
	    translate([0,width/2-wall,0]) cube([height,wall+lcornerd/2,length+wall+cornerd/2]);
	  }
	  
	  // side plate
	  translate([0,width/2-wall,0]) roundedbox(height,wall,wall+backcornersupport+ztolerance+backcornersupport,cornerd);
	  intersection() {
	    hull() {
	      translate([0,width/2-wall,wall+backcornersupport+ztolerance+backcornersupport-wall]) roundedbox(height,wall,wall,cornerd);
	      translate([0,width/2-wall+lcornerd/2,wall+backcornersupport+ztolerance+backcornersupport-wall+lcornerd/2]) roundedbox(height,wall,wall,cornerd);
	    }
	    sideform();
	  }

	  // Strengthening
	  if (0) hull() {
	    translate([fingerendh+fingerh-wall/2,width/2-wall+wall/2,length+wall/2]) sphere(d=strengthd,$fn=30);
	    translate([fingertoph+wall/2,width/2-wall+wall/2,fingertopl+wall/2]) sphere(d=strengthd,$fn=30);
	  }

	  hull() {
	    translate([height-wall/2,width/2-wall+wall/2,topl-wall/2]) sphere(d=strengthd,$fn=30);
	    translate([fingertoph+wall/2,width/2-wall+wall/2,fingertopl+wall/2]) sphere(d=strengthd,$fn=30);
	  }
	}
      }
    }

  // strengtening of top front
  hull() {
    for (m=[0,1]) mirror([0,m,0]) {
	//translate([height-wall/2,-width/2+strengthd/2+wall/2-strengthd/2,topl-wall/2]) sphere(d=strengthd,$fn=30);
	translate([height-wall/2,width/2+wall/2-wall,topl-wall/2]) sphere(d=strengthd,$fn=30);
      }
  }
}

module finger(y) {
  difference() {
    union() {
      translate([0,0,-preventerh]) hull() {
	translate([0,y-fingerw/2,fingerstart]) roundedbox(wall,fingerw,bottoml-fingerstart,fingercornerd);
	translate([0,y-fingerw/2,bottoml]) roundedbox(fingerh,fingerw,fingercornerd,fingercornerd);
      }
      translate([0,y-fingerw/2,bottoml-preventerh]) roundedbox(fingerh,fingerw,topl-bottoml+preventerh+fingercornerd,fingercornerd);
      hull() {
	translate([0,y-fingerw/2,topl]) roundedbox(fingerh,fingerw,fingercornerd,fingercornerd);
	translate([fingerendheight,y-fingerw/2,length-fingernarrowl]) roundedbox(fingerh,fingerw,fingercornerd,fingercornerd);
	translate([fingerendheight+fingerh-wall/2,y,length]) sphere(wall);
      }
    }
  }
}

module fingercut(y) {
  for (x=[-fingerh/5,fingerh/5]) {
    difference() {
      union() {
	translate([x+fingerh/2-fingercuth/2,y-fingercutw/2,bottoml-preventerh+fingercornerd/2]) cube([fingercuth,fingercutw,topl-bottoml+preventerh]);
	hull() {
	  l=length-fingernarrowl;
	  h=fingercuth*(l-fingerendheight)/l;
	  translate([x+fingerh/2-h/2,y-fingercutw/2,topl+fingercornerd/2]) cube([h,fingercutw,0.01]);
	  translate([x+fingerendheight+fingerh/2-h/2,y-fingercutw/2,l+fingercornerd/2]) cube([h,fingercutw,0.01]);
	}
      }
    }
  }
}

module berrypicker() {
  // bottom
  difference() {
    // Bottom
    union() {
      difference() {
	union() {
	  translate([0,-width/2,0]) roundedbox(wall,width,bottoml,cornerd);
	  hull() {
	    translate([0,-width/2,slitstart-slitd]) roundedbox(wall,width,slitl+slitd*2.5,cornerd);
	    translate([0,-slitsw/2,slitstart-slitd/2]) roundedbox(slitwall,slitsw,slitl+slitd*1.5,cornerd);
	  }

	  // fingers
	  if (print!=4) {
	    intersection() {
	      union() {
		for (y=[-width/2:fingerdistance:width/2]) {
		  finger(y);
		}
	      }
	      
	      hull() for (m=[0,1]) mirror([0,m,0]) sideform();
	      //translate([0,-width/2,0]) cube([height,width,length+cornerd+wall]);
	    }
	  }
	}

	// Cutouts for hinges
	for (m=[0,0]) mirror([0,m,0]) {
	    y=-width/2+wall; // ,width-wall-ytolerance-hingew-ytolerance]) {
	    translate([-0.1,y,-0.01]) cube([wall+0.2,ytolerance+hingew+ytolerance,axleh+axleoutd/2+axleh-axleoutd/2+2]);
	  }
	
	// cut bottom back (later filled with structure
	translate([-0.01,-width/2+wall+ytolerance+hingew,-0.01]) cube([wall+axlefrombottom+0.02,width-2*(wall+hingew+ytolerance),axleh]);

	// Openings for leaves and other trash
	for (y=[-width/2+fingerw/2:fingerdistance:width/2-slitd]) {
	  hull() {
	    translate([-0.1,y+slitd/2,slitstart+slitd/2]) rotate([0,90,0]) cylinder(h=slitwall+0.2,d=slitd);
	    translate([-0.1,y+slitd/2,slitstart+slitl]) rotate([0,90,0]) cylinder(h=slitwall+0.2,d=slitd);
	  }
	}
      }

      // Prevents berries from escaping
      if (print!=4) intersection() {
	  hull() {
	    for (m=[0,1]) mirror([0,m,0]) {
		sideform();
	      }
	  }

	  for (m=[0,1]) mirror([0,m,0]) {
	      for (y=[0:preventerdistance:width/2+lcornerd/2]) {
		ymax=(y+preventerdistance+wall/2>=width/2+lcornerd/2?-wall:0);
		hull() {
		  translate([wall/2,y,storagel+wall/2]) sphere(d=wall);
		  translate([wall/2,y,storagel+preventerh*2+wall/2]) sphere(d=wall);
		  translate([preventerh+wall/2,y,storagel+preventerh+wall]) sphere(d=wall);
		}
		hull() {
		  translate([wall/2,y,storagel+preventerh*2+wall/2]) sphere(d=wall);
		  translate([preventerh+wall/2,y,storagel+preventerh+wall]) sphere(d=wall);
		  translate([wall/2,y+preventerdistance/2,storagel+preventerh*2+preventerdistance/2]) sphere(d=wall);
		  translate([preventerh+wall/2,y+preventerdistance/2,storagel+preventerh+preventerdistance/2+wall]) sphere(d=wall);
		}
		hull() {
		  translate([wall/2,y+preventerdistance+ymax,storagel+preventerh*2+wall/2]) sphere(d=wall);
		  translate([preventerh+wall/2,y+preventerdistance+ymax,storagel+preventerh+wall]) sphere(d=wall);
		  translate([wall/2,y+preventerdistance/2,storagel+preventerh*2+preventerdistance/2]) sphere(d=wall);
		  translate([preventerh+wall/2,y+preventerdistance/2,storagel+preventerh+preventerdistance/2+wall]) sphere(d=wall);
		}

		// Prevents berries from getting stuck in tight corners
		yymax=(y+preventerdistance+wall/2>=width/2?-wall:0);
	  
		hull() {
		  translate([wall/2+preventerdistance/2,y+preventerdistance/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
		  translate([wall/2,y,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
		  translate([wall/2,y+preventerdistance+yymax,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
		}
		hull() {
		  translate([wall/2+preventerdistance/2,y+preventerdistance/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
		  translate([wall/2,y,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
		  translate([wall/2+preventerdistance/4,y,storagel+preventerh*2-preventerdistance/4+wall/2]) sphere(d=wall);
		}
		hull() {
		  translate([wall/2+preventerdistance/2,y+preventerdistance/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
		  translate([wall/2,y+yymax+preventerdistance,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
		  translate([wall/2+preventerdistance/4,y+yymax+preventerdistance,storagel+preventerh*2-preventerdistance/4+wall/2]) sphere(d=wall);
		}
	      }
	    }
	}

      // Bottom back structure
      difference() {
	hull() {
	  translate([0,-width/2,backopening+axleoutd]) roundedbox(wall,width,wall,cornerd);
	  translate([backopening+wall+0.5*xtolerance,-width/2,wall]) roundedbox(wall,width,0.2,cornerd);
	  translate([backopening-0.5*xtolerance,-width/2,0]) roundedbox(wall,width,0.2,cornerd);
	  translate([axlefrombottom,-width/2,axleh]) rotate([-90,0,0]) cylinder(d=axleoutd,h=width,$fn=90);
	  translate([axleoutd/2,-width/2,axleoutd/2]) rotate([-90,0,0]) cylinder(d=axleoutd,h=width,$fn=90);
	}

	for(m=[0,1]) mirror([0,m,0]) {
	    translate([-0.1,-width/2+wall,-0.01]) cube([height/2,ytolerance+hingew+ytolerance,axleh+axleoutd/2+ztolerance]);
	  }
      }

      // sides
      sides();
    }

    for (y=[-width/2:fingerdistance:width/2]) {
      fingercut(y);
    }

    // Axle hole inside
    for (m=[0,1]) mirror([0,m,0]) { // for (y=[0,width-wall]) {
	y=-width/2;
	translate([axlefrombottom,y+wall+ytolerance+hingew,axleh]) axlehole(0);
      }

    // Axle hole cut in the side
    for (m=[0,1]) mirror([0,m,0]) {
	translate([axlefrombottom,-width/2,axleh]) axlehole(180);
      }
  }
  
  // top
  difference() {
    union() {
      // Guides to drop berries past structure which keeps back in position
      for (m=[0,1]) mirror([0,m,0]) { // for (y=[wall,width-wall-ytolerance-backcornersupport]) {
	  y=-width/2+wall;
	  translate([height-wall-backcornersupport-0.01,y-0.01,wall+ztolerance]) triangle(backcornersupport+0.02,backcornersupport+ytolerance+0.02,backcornersupport,3);
	  translate([height-wall-backcornersupport-0.01,y-0.01,wall+backcornersupport+ztolerance-0.01]) triangle(backcornersupport+0.02,backcornersupport+ytolerance+0.02,backcornersupport+0.01,0);
	}

      // Top plate
      difference() {
	translate([height-wall,-width/2,0]) roundedbox(wall,width,topl,cornerd);
	translate([height-wall-0.1,-clipslided/2,-0.1]) cube([wall+0.2,clipslided,cliph+0.1]);
      }
      translate([height+plungerx-wall,-clipslided/2,0]) roundedbox(wall,clipslided,clippullh,cornerd);

      // Leaf spring to return the back lock to locked position
      hull() {
	translate([height+plungerx-wall,-clipslided/2,clippullh]) roundedbox(wall+1.5,clipslided,cornerd,cornerd);
	translate([height-wall,-clipslided/2,clippullh+cliph]) roundedbox(wall+1.5,clipslided,cornerd,cornerd);
      }

      // T-shape for spring
      hull() {
	translate([height-wall,-clipslided/2,cliph+cutw]) roundedbox(wall+1.5,clipslided,clipsideh-cutw,cornerd);
	translate([height-0.1,-clipslided/2-clipsidew,cliph+cutw]) roundedbox(0.1,clipsidew+clipslided+clipsidew,clipsideh-cutw,cornerd);
      }
    }

    translate([height-textdepth+0.01,-width/2+cornerd+1,cornerd+1]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="right", valign="bottom");

    // Clip to hold back cuts
    translate([height-wall-0.1,-clipw/2,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
    translate([height-wall-0.1,clipw/2-cutw,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
    translate([height-wall-0.1,-clipw/2-clipsidew,cliph]) cube([wall+0.2,clipsidew+cutw+0.01,cutw+0.1]);
    translate([height-wall-0.1,+clipw/2-cutw-0.01,cliph]) cube([wall+0.2,clipsidew+cutw+0.01,cutw+0.1]);
    translate([height-wall-0.1,-clipw/2-clipsidew,cliph+clipsideh]) cube([wall+0.2,clipsidew+clipw+clipsidew+0.01,cutw+0.1]);

    // Cut to weaken spring to allow it to detach in desired position.
    translate([height+plungerx-wall/2,-clipw/2,clippullh]) triangle(wall*1.5+0.01,clipw,wall*2,0); // DUPLICATED in handle
  }
    
  // Clip to keep back closed
  translate([height-wall+plungerx,-clipw/2+cutw,0]) roundedbox(wall,clipw-cutw*2,clippullh,cornerd);
  translate([height-wall-cornerd+plungerx,-clipw/2+cutw,0]) roundedbox(wall+cornerd,clipw-cutw*2,clipheight,cornerd);

  // Lock
  difference() {
    hull() {
      translate([height-wall-clipdepth+plungerx,-clipw/2+cutw,0]) roundedbox(clipdepth,clipw-cutw*2,clipheight,cornerd);
      translate([height-wall-clipdepth+plungerx,-cornerd/2,wall+clipw/2]) roundedbox(clipdepth,cornerd,cornerd,cornerd  );
    }
    translate([height-wall+plungerx-xtolerance-1,-clipw/2,clippullh]) triangle(1+xtolerance+0.01,clipw,clipheight+clipw/2-clippullh+cornerd,3);
  }

  // Mechanism to open the back (top part)
  intersection() {
    union() {
      hull() {
	translate([height+plungerx,-clipslided/2+clippullh+clippullh/2,0]) cylinder(h=clippullh,d1=clippullh,d2=clippullh*3,$fn=90);// clippullh+cutw,0]) cylinder(h=clippullh,d1=0,d2=clippullh*2,$fn=90);
	translate([height+plungerx,+clipslided/2-clippullh-clippullh/2,0]) cylinder(h=clippullh,d1=clippullh,d2=clippullh*3,$fn=90);
	translate([height+handlex+plungerx,0,0]) cylinder(h=clippullh,d1=clipw-2*clippullh-2*cutw, d2=clipslided);
      }

      // plunger counter shape
      difference() {
	hull() {
	  difference() {
	    translate([height+handlex+plungerx,0,clippullh-0.1]) cylinder(h=plungerangledh+clipplungerzmovement+0.1,d=clipslided);
	    translate([height+handlex+plungerx-clipslided/2,-clipslided/2,clippullh+clipplungerzmovement]) triangle(clipslided+0.01,clipslided,plungerangledh+0.01,1);
	  }
	  intersection() {
	    translate([-plungercountersupportheight/2,-width/2,-plungercountersupportheight+clipplungerzmovement]) difference() {
	      translate([height+handlex+plungerx,0,clippullh-0.1]) cylinder(h=plungerangledh+0.1,d=clipslided);
	      translate([height+handlex+plungerx-clipslided/2,-clipslided/2,clippullh]) triangle(clipslided+0.01,clipslided,plungerangledh+0.01,1);
	    }
	    translate([height,-handled/2,clippullh]) cube([handlex+handled,handled,plungerh]);
	  }
	}

	if (flatspring) {
	  translate([height+handlex+plungerx-clipslided/2,-plungespringspacew/2,clippullh+plungerangledh-clipplungerzmovement-ztolerance]) cube([clipslided+xtolerance*2+0.01,plungespringspacew,clipplungerzmovement+wall+0.01]);
	}
      }

      translate([height+plungerx+wall+xtolerance,-clipslided/2,clippullh]) triangle(handlex-wall-clipslided-xtolerance-xtolerance,clippullh,clippullh,11);
      translate([height+plungerx+wall+xtolerance,clipslided/2-clippullh,clippullh]) triangle(handlex-wall-clipslided-xtolerance-xtolerance,clippullh,clippullh,8);
  
    }

    // Cutout for lower handle
    union() {
      hull() {
	translate([height+plungerx+handlex-clipdepth-xtolerance,0,0]) cylinder(h=clippullh+plungerangledh+clipplungerzmovement,d=clipslided);
	translate([height+plungerx-cornerd,-clipw/2,0]) cube([handlex-clipdepth-xtolerance+cornerd,clipw,clippullh+clipslided+clipplungerzmovement]);
      }
      translate([height-wall-clipdepth+plungerx,-clipw/2+clippullh+cutw,0]) roundedbox(wall+clipdepth,clipw-cutw*2-clippullh*2,clippullh,cornerd);      
    }
  }

  // back 
  if (adhesion) {
    x=-2;
    w=wall+ytolerance+hingew+ytolerance+2;
    xl=axlefrombottom+2;
      
    for (m=[0,1]) mirror([0,m,0]) {
	y = -width/2+cornerd;
	translate([x,y,0]) cube([0.4,w,0.2]);
	translate([x,y,0]) cube([xl,0.4,0.2]);
	translate([x,y+w,0]) cube([xl,0.4,0.2]);
      }
  }
    
  // Opening back
  intersection() {
    // Back movement circle to help cut shape to lock parts to allow easy opening
    hull() {
      translate([axlefrombottom,-width/2+wall,axleh]) rotate([-90,0,0]) cylinder(h=width-2*wall,r=height-axlefrombottom-wall-xtolerance,$fn=90);
      translate([axlefrombottom,-width/2+wall,0]) rotate([-90,0,0]) cylinder(h=width-2*wall,r=height-axlefrombottom-wall-xtolerance,$fn=90);
    }

    // Back plate and its parts
    union() {
      difference() {
	union() {
	  // Structures to limit back plate movement
	  for (m=[0,1]) mirror([0,m,0]) {
	      y=-width/2+wall+ytolerance+cornerd/2;
	      //#	    for (y=[wall+ytolerance+cornerd/2,width-wall-ytolerance-backcornersupport]) {
	      intersection() {
		translate([height-wall-backcornersupport-0.01,y-0.01,wall-0.01]) triangle(backcornersupport+0.01,backcornersupport+ytolerance+0.02,backcornersupport+0.01,2);
		translate([height-wall-backcornersupport-0.01,y-0.01,wall]) cube([backcornersupport-xtolerance-cornerd/2+0.02,backcornersupport-cornerd/2+0.02,backcornersupport]);
	      }
	      translate([height-wall-2*backcornersupport,y,wall-0.01]) triangle(backcornersupport,backcornersupport-ytolerance+0.03,backcornersupport+0.01,0);
	    }

	  // Plate
	  hull() {
	    translate([wall+backopening+xtolerance,-width/2+wall+ytolerance,0]) roundedbox(height-backopening-2*wall-2*xtolerance,width-2*wall-2*ytolerance,0.2,cornerd);
	    translate([wall+backopening+wall+xtolerance,-width/2+wall+ytolerance,0]) roundedbox(height-backopening-2*wall-2*xtolerance-wall,width-2*wall-2*ytolerance,wall,cornerd);
	  }

	  // Structure for lock, keeping back closed until lock is opened
	  difference() {
	    hull() {
	      translate([height-wall-clipdepth-wall-xtolerance-wall,-clipw/2-wall,0]) roundedbox(clipdepth+wall+wall,clipw+2*wall,clipw/2+3*wall,cornerd);
	      translate([height-wall-clipdepth-wall-xtolerance-wall,-clipw/2-wall,clipw/2+2*wall+clipdepth+wall]) roundedbox(wall,clipw+2*wall,wall,cornerd);
	      translate([height-wall-clipdepth-wall-xtolerance-wall-clipw/2-2*wall-clipdepth-wall,-clipw/2-wall,wall]) roundedbox(wall,clipw+2*wall,wall,cornerd);
	    }

	    // Cutout for lock structure
	    hull() {
	      translate([height-wall-clipdepth-xtolerance,-clipw/2,-0.1]) cube([clipdepth+wall,clipw,clipheight+0.1]);
	      translate([height-wall-clipdepth-xtolerance,-cornerd/2,wall+clipw/2+2*ztolerance]) cube([clipdepth+cornerd,cornerd,cornerd]);
	    }
	  }
	}

	// Cutout for lock structure (related to above)
	translate([height-wall-clipdepth-xtolerance,-clipw/2,-0.1]) cube([clipdepth+xtolerance+0.1,clipw,wall+0.2]);
      }

      // Hinge to back plate attachment
      for (m=[0,1]) mirror([0,m,0]) {
	  // for (y=[wall+ytolerance,width-wall-ytolerance-hingew]) {
	  y=-width/2+wall+ytolerance;
	  hull() {
	    translate([axlefrombottom,y,0]) roundedbox(height-axlefrombottom-2*wall-backcornersupport,hingew,wall,cornerd);
	    translate([axlefrombottom+xtolerance,y,axleh]) rotate([-90,0,0]) cylinder(d=axleoutd,h=hingew);
	  }
	}
    }
  }

  // Inside Axle
  for (m=[0,1]) mirror([0,m,0]) {
      y=-width/2;
      translate([axlefrombottom,y+wall+ytolerance+hingew,axleh]) axletappi(0);
    }

  // Outside axle
  for (m=[0,1]) mirror([0,m,0]) {
      translate([axlefrombottom,-width/2+wall+ytolerance,axleh]) axletappi(180);
    }
      
  // handle
  difference() {
    union() {
      // Spring stopper
      if (flatspring) {
	difference() {
	  hull() {
	    translate([height+handlex-plungerd/2-wall/2+cutw,-plungespringsupportw/2,plungerheight+plungespringbottomheight-plungespringstopperh]) triangle(plungespringdepth+wall/2,plungespringsupportw,plungespringstopperh,1);
	    translate([height+handlex-plungespringxoffset-plungespringl/2,-plungespringsupportw/2,plungerheight+plungespringbottomheight-wall/2]) roundedbox(plungespringl,plungespringsupportw,wall/2,cornerd);
	  }

	  translate([height+handlex-plungespringcenteringxoffset,0,plungerheight+plungespringbottomheight-plungespringcenteringh/2+0.01]) cylinder(h=plungespringcenteringh/2+0.01,d1=plungespringcenteringd/3,d2=plungespringcenteringd*1.5,$fn=90);
	  translate([height+handlex-plungespringcenteringxoffset,0,plungerheight+plungespringbottomheight-plungespringcenteringh-ztolerance]) cylinder(h=plungespringcenteringh+0.01,d1=plungespringcenteringd/3+xtolerance,d2=plungespringcenteringd+xtolerance,$fn=90);
	}
      } else {
	hull() {
	  translate([height+handlex-plungerd/2-wall/2+cutw,-plungespringsupportw/2,plungerheight+plungespringbottomheight-plungespringstopperh]) triangle(plungespringdepth+wall/2,plungespringsupportw,plungespringstopperh,1);
	  translate([height+handlex-plungerd/2-wall/2+plungespringdepth+wall/2,0,plungerheight+plungespringbottomheight-1]) cylinder(d=plungespringsupportw,h=1);
	}
      }
    
      difference() {
	union() {
	  difference() {
	    // Low handle part
	    union() {
	      hull() {
		translate([height-wall,-handleattachd/2,0]) roundedbox(wall,handleattachd,handleattachd,cornerd); //-handlex/3
		translate([height+handlex,0,0]) cylinder(d=handled,h=handlelowh);

		hull() {
		  translate([height-wall,-bridgey/2-wall,plungerheight+plungespringbottomheight-plungespringstopperh+wall-1]) cube([handlex+wall,bridgey+2*wall,1]);
		  translate([height-wall,-handleattachd/2,0]) cube([wall,handleattachd,handleattachd]); //clippullh*2
		}
	      }
	      translate([height+handlex,0,0]) cylinder(d=handled,h=handlel);
	    }

	    // Cut insides
	    hull() {
	      translate([height-wall,-bridgey/2,plungerheight+plungespringbottomheight-plungespringstopperh-1]) cube([handlex+wall,bridgey,1]);
	      translate([height-wall,-clipw/2,wall]) cube([handlex+wall,clipw,handleattachd]); //clippullh+clipplungerzmovement*2-wall
	    }
	  }

	  // Top handle part
	  union() {
	    difference() {
	      hull() {
		translate([height-wall,-handleattachd/2,handlefrontattach]) roundedbox(wall,handleattachd,handleattachd,cornerd);
		translate([height+handlex,0,handlel]) cylinder(d=handled,h=wall);
	      }

	      // Cut insides
	      hull() {
		translate([height-0.1,-handleattachd/2+wall,handlefrontattach+wall*0.7]) roundedbox(0.1,handleattachd-wall*2,handleattachd-wall*2.5,cornerd);
		translate([height+handlex,0,handlel+wall]) cylinder(d=handled-2*wall,h=0.1);
	      }
	    }
	  }
	}

	// Weaken back leaf spring as it is designed to be separate, but needs to connected to be be printed
	translate([height-wall/2,-clipw/2,clippullh]) triangle(wall*1.5+0.01,clipw,wall*2,0); // DUPLICATED in top

     
	// Cut clip from top
	for (m=[0,1]) mirror([0,m,0]) translate([height-wall-0.1,-clipw/2,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
	//translate([height-wall-0.1,clipw/2-cutw,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);

	// Space for clip movement
	intersection() {
	  translate([height,-(handled-wall*2)/2,wall]) cube([cutw+clipdepth+wall+xtolerance,handled-wall*2,cliph-wall]);
	}

	// Cut space for plunger
	translate([height+handlex,0,-0.1]) cylinder(d=handled-wall*2,h=topl+0.2+wall/2);

	// Space for movement in the base of low handle
	translate([height,-(handled-wall*2)/2,-0.1]) cube([handlex,handled-wall*2,wall+0.2]);
      }

      // Holdback to keep clip movement in place
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([height+cutw+clipdepth+wall+xtolerance,clipw/2-clippullh,0]) triangle(handlex-cutw-clipdepth-wall-xtolerance,clippullh,clippullh,11);
	  //translate([height+cutw+clipdepth+wall+xtolerance,-clipw/2,0]) triangle(handlex-cutw-clipdepth-wall-xtolerance,clippullh,clippullh,8);
	  translate([height+cutw+clipdepth+wall+xtolerance,clipw/2-clippullh,clippullh]) triangle(handlex-clipslided/2-clipdepth-plungercountersupportheight/2-wall,clippullh,clippullh,9);
	  //translate([height+cutw+clipdepth+wall+xtolerance,-clipw/2,clippullh]) triangle(handlex-clipslided/2-clipdepth-plungercountersupportheight/2-wall,clippullh,clippullh,10);
	}

  // Shelf to prevent plunger to drop out from above (plug has clip)
	  translate([height+handlex-handled/2,-plungeclipshelfw/2,handlel+wall]) cube([plungeclipshelfdepth,plungeclipshelfw,plungeclipshelfh+clipslided-wall]);
    }

    // Holes for plunge clip to go in
    translate([height+handlex-handled/2-xtolerance-plungeclipd,-plungeclipw/2-plungeclipcut/2*2,handlel+clipslided-plungeclipd*2]) cube([handlex,plungeclipw+plungeclipcut*2,plungeclipd*2]);
    translate([height+handlex-handled/2-xtolerance+plungeclipshelfdepth,-plungeclipw/2-plungeclipcut/2*2,handlel+clipslided-plungeclipd*2]) cube([handlex,plungeclipw+plungeclipcut*2,topl]);
  }
}

intersection() {
  //if (debug) translate([-20,-width/2-lcornerd,0]) cube([height+80,width/2+lcornerd*2,length+3]);
  if (debug) translate([-20,-width/2-lcornerd,0]) cube([height+80,width/2+lcornerd,length+3]);
  //if (debug) translate([0,-width/2,0]) cube([axlefrombottom,20,length+1]);
  if (print==4 && debug) translate([-10,-width/2-lcornerd/2,0]) cube([height+90,width/2+lcornerd/2+plungerd+20,topl]);

  union() {
    if (print==0 || print==1 || print==3 || print==4) {
      berrypicker();
    }

    if (print==0) {
      translate([height+handlex,0,plungerzposition]) plunger();
      translate([height+handlex,0,plungerzposition]) plungespring(0);
    }

    if (print==3 || print==6) {
      translate([-plungespringl/2+1,plungespringbottomheight+plungespringh/2+wall/2,plungespringw/2]) rotate([90,0,0]) plungespring(plungespringtension);

      if (adhesion) {
	w=plungespringh+wall*2;
	y=-w/2;
	xl=plungespringl+1+axlefrombottom;
	x=-xl+axlefrombottom;
	  translate([x,y,0]) cube([0.4,w,0.2]);
	  translate([x,y,0]) cube([xl,0.4,0.2]);
	  translate([x,y+w,0]) cube([xl,0.4,0.2]);
      }
    }
    
    if (print==2 || print==3 || print==4) {
      translate([height+wall+plungerd/2-1,-plungerd-wall+lcornerd/2-wall+0.5,0]) {
	if (adhesion) {
	  zz=floor((plungerh-plungerd)/10)*10-9;
	  translate([-0.4,width/2+1-zz/3.5,0]) triangle(0.8,zz/3.5-0.5+0.01,zz,11);
	  translate([-0.4,width/2-0.5,0]) cube([0.8,1,zz]);
	  for (z=[10:10:zz-1]) {
	    translate([-0.25,width/2+1-0.5,z]) cube([0.5,0.51,1]);
	  }
	}
      
	translate([0,width/2+1+clipslided/2,plungerh]) {
	  rotate([180,0,180]) plunger();
	}
      }
    }
  }
}

if (print==5) {
  totalh=plungespringh+ztolerance+plungerz+1;
  intersection() {
    if (debug) translate([-plungespringd,-width/2,0]) cube([plungespringd*2,plungespringd,totalh+1]);
    union() {
      translate([0,-width/2,0]) spring(totalh,plungespringd,plungespringplatethickness,plungespringthickness);
    }
  }
 }

//#    translate([-20,-width/2,plungespringspaceh]) rotate([180,0,0]) scale([1,1,plungespringspaceh/plungespringh]) spring(plungespringh,plungespringd,plungespringplatethickness,plungespringthickness);
