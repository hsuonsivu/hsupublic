// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=4; // 0=full model, 1=body, 2=plunger, 3=all parts

withlonghandle=1;
plungerdown=0;

debug=0;

//$fn=60;

testhreduction=(print==4)?20:0;
testwreduction=(print==4)?50:0;
testlreduction=(print==4)?80:0;
testslreduction=(print==4)?50:0;

length=228-testlreduction;
height=70-testhreduction; // 125;

versiontextb="v1.4";
textsize=7;
textdepth=1;

wall=1.5;

topl=190-testlreduction;
bottoml=160-testlreduction;

fingerl=70;
fingerw=9;
fingers=(print==4)?3:9;
fingerh=3*wall;
fingerdistance=15.5;// width/fingers; // This should be diameter of a full grown blueberry, need to test
width=fingerdistance*fingers; //140;
fingerendh=8;
fingertoph=height-10;
fingertopl=topl+20;
fingerstart=bottoml-20;
fingernarrowl=6;

storagel=110-testslreduction;
storageh=10;

handled=20;
handleattachd=25;
handlex=40;
handlefrontattach=topl-handleattachd;
handlel=topl-handlex-10;
handlelowh=handleattachd+5;
cornerd=wall/2;

cutw=0.5;
cliph=50;
clipw=handled-2*wall;
clipdepth=6;
clipheight=wall;
clippullh=wall+3;

clipslided=clipw-2*cutw;
clipplungermovement=clipdepth;

xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;

plungerx=plungerdown?clipplungermovement:0;
plungerz=plungerdown?-clipplungermovement-ztolerance:0;

plungerh=handlel-clippullh-clipplungermovement+clipslided; // height;
plungerd=clipslided;

plungeclipshelfdepth=2;
plungeclipshelfw=handled-wall*2+0.01;//clipslided;
plungeclipshelfh=2;
plungeclipcut=0.5;
plungeclipdepth=3;
plungeclipd=3.5;
plungeclipnotchd=2.5; // to allow unclipping
plungeclipl=1.5;
plungeclipw=clipslided/3;
plungeclipheight=40;
plungeclipfingerd=12;
plungecliptopadjust=2; // More space to place notch
plungecliptopadjusth=plungeclipheight-20;
longhandlel=500;
longhandled=handled;

hingew=4;
axledsmall=5;
axledlarge=axledsmall+wall;;
axleoutd=axledlarge+2;
axleh=axleoutd/2+wall/2;
axlefrombottom=axleh; //dlarge/2+wall;
axledtolerance=0.7;
hingeh=axleh+axleoutd/2;
backopening=axlefrombottom+4;
backcornersupport=10;
//hinged=axledlargeout-axledtolerance;

versiontext=str("piikki ",fingerw,"  rako ",fingerdistance-fingerw,"  ",versiontextb);

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
      translate([0,0,0]) cylinder(h=plungerh,d=plungerd);
      translate([-plungerd/2-plungeclipd+1,-plungeclipw/2+plungeclipcut,plungerh-plungeclipd]) triangle(plungeclipd,plungeclipw-plungeclipcut*2,plungeclipd,3);
      

      intersection() {
	difference() {
	  translate([plungeclipfingerd*(2/3),0,plungerh+plungeclipfingerd/2+2]) sphere(plungeclipfingerd+wall);
	  translate([plungeclipfingerd*(2/3),0,plungerh+plungeclipfingerd/2+2]) sphere(plungeclipfingerd);
	}
	translate([plungeclipfingerd*(2/3)-plungerd,-plungerd*2/2,plungerh-clipplungermovement]) cube([plungerd,plungerd*2,clipplungermovement]);
      }
    }

    tl=len(versiontextb)*(textsize-1);
    
    // text cut
    hull() {
      translate([plungerd-0.01,-plungerd/2,plungerd+ztolerance+4-plungerd*2/3]) cube([0.02,plungerd,tl]);
      translate([plungerd/3,-plungerd/2,plungerd+ztolerance+4]) cube([plungerd/3,plungerd,tl]);
    }
    translate([plungerd/3-textdepth+0.01,0,plungerd+ztolerance+4+tl/2]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontextb,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");

    
    translate([-plungerd/2,-plungerd/2,-0.02]) triangle(plungerd+0.01,plungerd,plungerd+0.02,0);

    // Cut for plunge clip
    union() {
      translate([plungeclipdepth-plungerd/2,-plungeclipw/2,handlel+plungerd-plungeclipheight]) cube([plungeclipcut+plungeclipd/2+0.01,plungeclipw,plungeclipheight-plungecliptopadjusth+0.1]);
      translate([-plungerd/2,-plungeclipw/2,handlel+plungerd-plungeclipheight]) cube([plungeclipdepth+plungeclipcut+plungecliptopadjust,plungeclipcut,plungeclipheight+0.1]);
      translate([-plungerd/2,plungeclipw/2-plungeclipcut,handlel+plungerd-plungeclipheight]) cube([plungeclipdepth+plungeclipcut+plungecliptopadjust,plungeclipcut,plungeclipheight+0.1]);

      translate([plungeclipdepth-plungerd/2+plungecliptopadjust,-plungeclipw/2,handlel+plungerd-plungeclipheight]) cube([plungeclipcut+plungeclipd/2+plungecliptopadjust,plungeclipw,plungeclipheight+0.1]);
    
      translate([-plungerd/2+plungeclipdepth-plungeclipnotchd+plungecliptopadjust,-plungeclipw/2+plungeclipcut-0.1,plungerh]) rotate([-90,0,0]) cylinder(d=plungeclipnotchd,h=plungeclipw-2*plungeclipcut+0.2,$fn=6);
    }

    // Cut for finger point
    translate([plungeclipfingerd*(2/3),0,plungerh+plungeclipfingerd/2+2]) sphere(plungeclipfingerd);
  }
}

module berrypicker() {
  // bottom
  difference() {
    union() {
      translate([0,0,storagel]) roundedbox(wall,width,bottoml-storagel,cornerd);
      difference() {
	translate([-storageh,0,0]) roundedbox(wall,width,storagel-storageh,cornerd);
	for (y=[wall,width-wall-ytolerance-hingew-ytolerance]) {
	  translate([-storageh-0.01,y,-0.01]) cube([wall+0.02,ytolerance+hingew+ytolerance,axleh+axleoutd/2+axleh-axleoutd/2]);
	}
	translate([-storageh-0.01,wall+ytolerance+hingew,-0.01]) cube([wall+axlefrombottom+0.02,width-2*(wall+hingew+ytolerance),axleh]);
      }
      hull() {
	translate([0,0,storagel]) roundedbox(wall,width,wall,cornerd);
	translate([-storageh,0,storagel-storageh-wall]) roundedbox(wall,width,wall,cornerd);
      }

      hull() {
	translate([-storageh,wall+hingew+2*ytolerance,backopening+axleoutd]) roundedbox(wall,width-2*wall-4*ytolerance-2*hingew,wall,cornerd);
	translate([-storageh+backopening+wall+xtolerance,wall+hingew+2*ytolerance,wall]) roundedbox(wall,width-2*wall-4*ytolerance-2*hingew,0.2,cornerd);
	translate([-storageh+backopening,wall+hingew+2*ytolerance,0]) roundedbox(wall,width-2*wall-4*ytolerance-2*hingew,0.2,cornerd);
	translate([-storageh+axlefrombottom,wall+hingew+2*ytolerance,axleh]) rotate([-90,0,0]) cylinder(d=axleoutd,h=width-2*wall-4*ytolerance-2*hingew,$fn=90);
	translate([-storageh+axleoutd/2,wall+hingew+2*ytolerance,axleoutd/2]) rotate([-90,0,0]) cylinder(d=axleoutd,h=width-2*wall-4*ytolerance-2*hingew,$fn=90);
      }

      // sides
      for (y=[0,width-wall]) {
	difference() {
	  union() {
	    hull() {
	      translate([0,y,0]) roundedbox(height,wall,topl,cornerd);
	      translate([fingerendh,y,length]) roundedbox(wall,wall,wall,cornerd);
	      translate([fingertoph,y,fingertopl]) roundedbox(wall,wall,wall,cornerd);
	    }

	    hull() {
	      translate([-storageh,y,0]) roundedbox(storageh+wall,wall,storagel-storageh,cornerd);
	      translate([0,y,storagel]) roundedbox(wall,wall,wall,cornerd);
	    }
	  }
	}
      }
    }

    for (y=[0,width-wall]) {
      if (y==0) {
	translate([-storageh+axlefrombottom,y+wall+ytolerance+hingew,axleh]) axlehole(0);
      } else {
	translate([-storageh+axlefrombottom,y-(ytolerance+hingew+wall+ytolerance),axleh]) axlehole(180);
      }

      if (y==0) {
	translate([-storageh+axlefrombottom,y,axleh]) axlehole(180);
      } else {
	translate([-storageh+axlefrombottom,y-ytolerance,axleh]) axlehole(0);
      }
    }
  }
  
  // top
  difference() {
    union() {
      for (y=[wall,width-wall-ytolerance-backcornersupport]) {
	translate([height-wall-backcornersupport-0.01,y-0.01,wall+ztolerance]) triangle(backcornersupport+0.02,backcornersupport+ytolerance+0.02,backcornersupport,3);
	translate([height-wall-backcornersupport-0.01,y-0.01,wall+backcornersupport+ztolerance-0.01]) triangle(backcornersupport+0.02,backcornersupport+ytolerance+0.02,backcornersupport+0.01,0);
      }
      
      translate([height-wall,0,0]) roundedbox(wall,width,topl,cornerd);
    }

    translate([height-textdepth+0.01,cornerd+1,cornerd+1]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="right", valign="bottom");

    // Clip to hold back
    translate([height-wall-0.1,width/2-clipw/2,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
    translate([height-wall-0.1,width/2+clipw/2-cutw,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
  }
    
  // Clip to keep back closed
  hull() {
    translate([height-wall-clipdepth,width/2-clipw/2+cutw,0]) roundedbox(clipdepth+wall,clipw-cutw*2,clipheight,cornerd);
    translate([height-wall-clipdepth,width/2-cornerd/2,wall+clipw/2]) roundedbox(clipdepth+cornerd,cornerd,cornerd,cornerd  );
  }

// Mechanism to open the back (top part)
intersection() {
union() {
  hull() {
    translate([height+plungerx,width/2-clipslided/2+clippullh+clippullh/2,0]) cylinder(h=clippullh,d1=clippullh,d2=clippullh*3,$fn=90);// clippullh+cutw,0]) cylinder(h=clippullh,d1=0,d2=clippullh*2,$fn=90);
    translate([height+plungerx,width/2+clipslided/2-clippullh-clippullh/2,0]) cylinder(h=clippullh,d1=clippullh,d2=clippullh*3,$fn=90);
    translate([height+handlex+plungerx,width/2,0]) cylinder(h=clippullh,d1=clipw-2*clippullh-2*cutw, d2=clipslided);
  }

  // plunger counter shape
  difference() {
    translate([height+handlex+plungerx,width/2,clippullh-0.1]) cylinder(h=clipslided+clipplungermovement+0.1,d=clipslided);
    translate([height+handlex+plungerx-clipslided/2,width/2-clipslided/2,clippullh+clipplungermovement]) triangle(clipslided+0.01,clipslided,clipslided+0.01,1);
  }

  translate([height+plungerx-0.01,width/2-clipslided/2,clippullh]) triangle(handlex-clipslided-xtolerance,clippullh,clippullh,11); // clipw/2-clippullh-xtolerance+cutw,clippullh+cutw-ztolerance,10);
  translate([height+plungerx-0.01,width/2+clipslided/2-clippullh,clippullh]) triangle(handlex-clipslided-xtolerance,clippullh,clippullh,8);
  
}
hull() {
  translate([height+plungerx+handlex-clipdepth-xtolerance,width/2,0]) cylinder(h=clippullh+clipslided+clipplungermovement,d=clipslided);
  translate([height+plungerx-cornerd,width/2-clipw/2,0]) cube([handlex-clipdepth-xtolerance+cornerd,clipw,clippullh+clipslided+clipplungermovement]);
}
}
    
// back 
if (withlonghandle) {
  // Opening back
  union() {
    difference() {
      union() {
	for (y=[wall+ytolerance+cornerd/2,width-wall-ytolerance-backcornersupport]) {
	  intersection() {
	    translate([height-wall-backcornersupport-0.01,y-0.01,wall-0.01]) triangle(backcornersupport+0.01,backcornersupport+ytolerance+0.02,backcornersupport+0.01,2);
	    translate([height-wall-backcornersupport-0.01,y-0.01,wall]) cube([backcornersupport-xtolerance-cornerd/2+0.02,backcornersupport-cornerd/2+0.02,backcornersupport]);
	  }
	translate([height-wall-2*backcornersupport,y,wall-0.01]) triangle(backcornersupport,backcornersupport-ytolerance+0.03,backcornersupport+0.01,0);
	}
	  
	hull() {
	  translate([-storageh+wall+backopening+xtolerance,wall+ytolerance,0]) roundedbox(height+storageh-backopening-2*wall-2*xtolerance,width-2*wall-2*ytolerance,0.2,cornerd);
	  translate([-storageh+wall+backopening+wall+xtolerance,wall+ytolerance,0]) roundedbox(height+storageh-backopening-2*wall-2*xtolerance-wall,width-2*wall-2*ytolerance,wall,cornerd);
	}
	difference() {
	  hull() {
	    translate([height-wall-clipdepth-wall-xtolerance-wall,width/2-clipw/2-wall,0]) roundedbox(clipdepth+wall+wall,clipw+2*wall,clipw/2+3*wall,cornerd);
	    translate([height-wall-clipdepth-wall-xtolerance-wall,width/2-clipw/2-wall,clipw/2+2*wall+clipdepth+wall]) roundedbox(wall,clipw+2*wall,wall,cornerd);
	    translate([height-wall-clipdepth-wall-xtolerance-wall-clipw/2-2*wall-clipdepth-wall,width/2-clipw/2-wall,wall]) roundedbox(wall,clipw+2*wall,wall,cornerd);
	  }

	  hull() {
	    translate([height-wall-clipdepth-xtolerance,width/2-clipw/2,0]) cube([clipdepth+wall,clipw,clipheight]);
	    translate([height-wall-clipdepth-xtolerance,width/2-cornerd/2,wall+clipw/2+2*ztolerance]) cube([clipdepth+cornerd,cornerd,cornerd]);
	  }
	}
      }
	
      translate([height-wall-clipdepth-xtolerance,width/2-clipw/2,-0.1]) cube([clipdepth+xtolerance+0.1,clipw,wall+0.2]);
    }

    for (y=[wall+ytolerance,width-wall-ytolerance-hingew]) {
      hull() {
	translate([-storageh+axlefrombottom,y,0]) roundedbox(height+storageh-axlefrombottom-2*wall-backcornersupport,hingew,wall,cornerd);
	translate([-storageh+axlefrombottom+xtolerance,y,axleh]) rotate([-90,0,0]) cylinder(d=axleoutd,h=hingew);
      }
    }

    for (y=[0,width]) {
      if (y==0) {
	translate([-storageh+axlefrombottom,y+wall+ytolerance,axleh]) axletappi(180);
	translate([-storageh+axlefrombottom,y+wall+ytolerance+hingew,axleh]) axletappi(0);
      } else {
	translate([-storageh+axlefrombottom,y-wall-ytolerance,axleh]) axletappi(0);
	translate([-storageh+axlefrombottom,y-wall-ytolerance-hingew,axleh]) axletappi(180);
      }
    }
  }
 } else {
  // Fixed back
  translate([-storageh,0,0]) roundedbox(height+storageh,width,wall,cornerd);
 }

// handle
union() {
  difference() {
    union() {
      hull() {
	translate([height-wall,width/2-handleattachd/2,0]) roundedbox(wall,handleattachd,handleattachd-handlex/3,cornerd);
	translate([height+handlex,width/2,0]) cylinder(d=handled,h=handlelowh);
	hull() {
	  translate([height+wall,width/2,clippullh*2+cornerd/2+handleattachd/2]) rotate([0,-90,0]) cylinder(d=cornerd,h=wall);
	  translate([height,width/2-handleattachd/2,0]) cube([wall,handleattachd,clippullh*2]);
	}
	//	intersection() {
	//	  translate([height,width/2,handleattachd-handlex/3]) rotate([0,90,0]) cylinder(d=handleattachd,h=wall);
	//	  translate([height,width/2-handleattachd/2,handleattachd-handlex/3]) cube([wall,handleattachd,handleattachd/2]);
	//}
      }
      translate([height+handlex,width/2,0]) cylinder(d=handled,h=handlel);

      hull() {
	translate([height-wall,width/2-handleattachd/2,handlefrontattach]) roundedbox(wall,handleattachd,handleattachd,cornerd);
	translate([height+handlex,width/2,handlel]) cylinder(d=handled,h=wall);
      }
    }

    // Cut insides
    hull() {
      translate([height+wall,width/2,clippullh*2+cornerd/2+handleattachd/2-wall]) rotate([0,-90,0]) cylinder(d=cornerd,h=wall);
      translate([height,width/2-handled/2+wall,wall]) cube([wall,handled-2*wall,clippullh*2-wall]);
      translate([height+handlex-wall/2,width/2,handlelowh-wall]) rotate([0,-90,0]) cylinder(d=cornerd,h=wall);
      translate([height+handlex,width/2-clipw/2,wall]) cube([0.1,clipw,clippullh*2-wall]);
    }
    // Clip to hold back
    translate([height-wall-0.1,width/2-clipw/2,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
    translate([height-wall-0.1,width/2+clipw/2-cutw,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);

  // Space for clip movement
  intersection() {
    hull() {
      translate([height,width/2,wall]) cylinder(d=handled-wall*2,h=cliph-wall);
      translate([height+clipdepth,width/2,wall]) cylinder(d=handled-wall*2,h=cliph-wall);
    }
    translate([height,width/2-handled/2+wall,wall]) cube([handled/2-wall+clipdepth,handled-wall*2,cliph-wall]);
  }

  translate([height+handlex,width/2,-0.1]) cylinder(d=handled-wall*2,h=topl+0.2+wall/2);
  translate([height,width/2-(handled-wall*2)/2,-0.1]) cube([handlex,handled-wall*2,wall+0.2]);

  hull() {
    translate([height,width/2-handleattachd/2+wall,handlefrontattach+wall/2]) roundedbox(0.1,handleattachd-wall*2,handleattachd-wall*2,cornerd);
    translate([height+handlex,width/2,handlel+wall/2]) cylinder(d=handled-wall*2,h=0.1);
  }
}

// Holdback for clip movement
translate([height+cutw+clipdepth,width/2+clipw/2-clippullh,0]) triangle(handlex-cutw-clipdepth,clippullh,clippullh,11); // clipw/2-clippullh-xtolerance+cutw,clippullh+cutw-ztolerance,11);
translate([height+cutw+clipdepth,width/2-clipw/2,0]) triangle(handlex-cutw-clipdepth,clippullh,clippullh,8);

translate([height+cutw+clipdepth,width/2+clipw/2-clippullh,clippullh]) triangle(handlex-clipslided/2-cutw-clipdepth-ztolerance,clippullh,clippullh,9); // clipw/2-clippullh-xtolerance+cutw,clippullh+cutw-ztolerance,11);
translate([height+cutw+clipdepth,width/2-clipw/2,clippullh]) triangle(handlex-clipslided/2-cutw-clipdepth-ztolerance,clippullh,clippullh,10);

}
// Shelf to prevent plunger to drop out from above (plug has clip)
translate([height+handlex-handled/2-xtolerance,width/2-plungeclipshelfw/2,handlel+clipslided]) roundedbox(plungeclipshelfdepth,plungeclipshelfw,plungeclipshelfh,cornerd);

// fingers
intersection() {
  union() {
    for (y=[0:fingerdistance:width]) {
      hull() {
	translate([0,y-fingerw/2,fingerstart]) roundedbox(wall,fingerw,bottoml-fingerstart,cornerd);
	translate([0,y-fingerw/2,bottoml+cornerd]) roundedbox(fingerh,fingerw,wall,cornerd);
      }
      translate([0,y-fingerw/2,bottoml]) roundedbox(fingerh,fingerw,topl-bottoml+cornerd,cornerd);
      hull() {
	translate([0,y-fingerw/2,topl]) roundedbox(fingerh,fingerw,wall,cornerd);
	translate([fingerendh,y-fingerw/2,length-fingernarrowl]) roundedbox(fingerh,fingerw,wall,cornerd);
	translate([fingerendh+fingerh-wall/2,y,length]) sphere(wall);
      }
    }
  }

  cube([height,width,length+cornerd+wall]);
}
}

intersection() {
  if (debug) translate([-20,0,0]) cube([height+60,width/2,length+1]);

  union() {
    if (print==0 || print==1 || print==3 || print==4) {
      berrypicker();
    }

    if (print==0) {
      translate([height+handlex,width/2,clippullh+clipplungermovement+ztolerance+plungerz]) plunger();
    }
  
    if (print==2 || print==3 || print==4) {
      translate([height,width+1+clipslided/2,plungerh]) rotate([180,0,120]) plunger();
    }
  }
}

