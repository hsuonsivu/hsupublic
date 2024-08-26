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

print=3; // 0=full model, 1=body, 2=plunger, 3=all parts, 4=smaller debug model, spring test

adhesion=1; // Additional bits to allow using skirt when printing.

withlonghandle=1;
plungerdown=0;

debug=0;

$fn=120;

testhreduction=(print==4)?20:0;
testwreduction=(print==4)?50:0;
testlreduction=(print==4)?0:0; // testlreduction=(print==4)?58:0;
testslreduction=(print==4)?50:0;

length=228-testlreduction;
height=75-testhreduction; // 125;

versiontextb=str("v1.7",(print==4)?"D":"");;

textsize=(print==4)?4:7;
textdepth=1;

wall=1.5;
strengthd=2.5;//2.5;

topl=190-testlreduction;
bottoml=160-testlreduction;

fingerl=70;
fingerw=9;
fingers=(print==4)?4:9;
fingerh=3*wall;
fingerdistance=15.5;// width/fingers; // This should be diameter of a full grown blueberry, need to test
width=fingerdistance*fingers; //140;
fingerendh=8;
fingertoph=height-10;
fingertopl=topl+20;
fingerstart=bottoml-20;
fingernarrowl=6;

storageh=5;
preventerh=25;
preventers=(floor(fingers/4)*2);
preventerdistance=width/preventers;

storagel=176-2*preventerh-preventerdistance-testslreduction;

handled=25;
handleattachd=30;
handlex=42.5;
handlefrontattach=topl-handleattachd;
handlel=topl-handlex-10;
cornerd=wall/2;

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
echo("plungerh ",plungerh);
plungerd=clipslided;
plungerangledh=clipslided*2;

plungeclipshelfdepth=2;
plungeclipshelfw=handled/2+0.01;//clipslided;
plungeclipshelfh=2;
plungeclipcut=0.5;
plungeclipdepth=3;
plungeclipd=3.5;
plungeclipnotchd=2.5; // to allow unclipping
plungeclipl=1.5;
plungeclipw=clipslided/3;
plungecliph=25;
plungeclipfingerd=12;
plungecliptopadjust=2; // More space to place notch
plungecliptopadjusth=plungecliph-20;
plungercountersupporth=plungerangledh+clipplungerzmovement;
plungercountersupportw=2;
plungercountersupportheight=clipplungerzmovement+plungercountersupportw;
longhandlel=500;
longhandled=handled;

plungespringw=9;
plungespringcut=0.5;
plungespringdepth=plungerd/2-3.5;
plungespringbaseh=plungespringdepth;
plungespringbaseheight=clipslided;
plungerheight=clippullh+clipplungerzmovement+ztolerance;
plungespringspaceh=plungerh-plungespringbaseh-clipslided*2-4;
plungerzposition=plungerheight+plungerz;
plungespringsteps=7;
plungespringsteph=2;
plungespringendh=4;

plungespringthickness=3;
plungespringplatethickness=2;
plungespringd=13; // spring diameter
plungespringspaced=plungespringd+1;
plungespringxoffset=plungerd/3/2-1;
plungespringcenteringxoffset=plungespringxoffset+2;
plungespringcenteringh=3;
plungespringcenteringd=4;
plungespringbottomheight=plungerangledh-11+ztolerance; // Spring starts here relative to plunger start
plungespringtopheight=plungerh-plungecliph-2; // spring ends here
plungespringh=plungespringtopheight-plungespringbottomheight;
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
handlelowh=clippullh+clipplungerzmovement+3+handled-plungespringbaseh*2;
plungespringheight=handlelowh-wall; //clipslided+clipplungerzmovement; // From start of the plunger

slitd=fingerdistance-fingerw;
slitstart=backopening+axleoutd+wall;
slitl=storagel-storageh-1-slitstart-slitd/2-2;
  
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
      translate([-plungerd/2-plungeclipd+1,-plungeclipw/2+plungeclipcut,plungerh-plungeclipd*2]) triangle(plungeclipd,plungeclipw-plungeclipcut*2,plungeclipd*2,3);

      if (adhesion) {
	w=plungeclipw+plungeclipcut+1;
	translate([-plungerd/2-plungeclipd,-w/2,plungerh-0.2]) cube([0.4,w,0.2]);
	translate([-plungerd/2-plungeclipd,-w/2,plungerh-0.2]) cube([plungerd/3,0.4,0.2]);
	translate([-plungerd/2-plungeclipd,w/2-0.4,plungerh-0.2]) cube([plungerd/3,0.4,0.2]);
      }
    }

    // Spring support cut
    union() {
      hull() {
	translate([-plungerd/2-0.01,-plungespringw/2-plungespringcut,-0.01]) cube([plungespringdepth+plungespringcut+0.02,plungespringw+plungespringcut*2,plungespringbottomheight+plungespringbaseh*2+0.02]);
	translate([-plungespringxoffset,0,-0.01]) cylinder(d=plungespringw+xtolerance,h=plungespringbottomheight+plungespringbaseh*2);
      }
     hull() {
	translate([-plungespringxoffset,0,plungespringbottomheight-4-0.01]) cylinder(d2=plungespringspaced,d1=plungespringw+xtolerance,h=4+0.02,$fn=90);
      }
    }

   // Round spring space inside the plunger
   translate([-plungespringxoffset,0,plungespringbottomheight-0.01]) cylinder(d=plungespringspaced,h=plungespringh+0.02,$fn=90);
    
    // text cut
    tlx=len(versiontextb)*(textsize-1);
    tl=(print==4)?tlx/2:tlx;
    
   hull() {
      translate([plungerd-0.01,-plungerd/2,plungerangledh+ztolerance+4-plungerd*2/3]) cube([0.02,plungerd,tl]);
      translate([plungerd/3,-plungerd/2,plungerangledh+ztolerance+4]) cube([plungerd/3,plungerd,tl]);
    }
    translate([plungerd/3-textdepth+0.01,0,plungerangledh+ztolerance+4+tl/2]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontextb,font="Liberation Sans:style=Bold",size=((print==4)?textsize/2:textsize),halign="center", valign="center");

    // Create angled bottom
    translate([-plungerd/2,-plungerd/2,-0.02]) triangle(plungerd+0.01,plungerd,plungerangledh+0.02,0);

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

  // Spring
  translate([-plungespringxoffset,0,plungespringbottomheight+ztolerance+plungespringh+plungespringthickness/2]) rotate([180,0,0]) spring(plungespringh+ztolerance+plungerz+1,plungespringd,plungespringplatethickness,plungespringthickness);

  translate([-plungespringcenteringxoffset,0,plungespringbottomheight-plungespringcenteringh+ztolerance-plungerz]) cylinder(h=plungespringcenteringh+0.01,d1=plungespringcenteringd/3,d2=plungespringcenteringd,$fn=60);
  
  if (0)  translate([-plungespringdepth+wall,-plungespringw/2,clipslided+plungespringbaseh*2+ztolerance-plungespringendh+ztolerance-plungerz]) roundedbox(plungespringthickness,plungespringw,plungespringendh+plungespringthickness,1);
  
  if (0)  for (i=[0:1:plungespringsteps]) {
    z=plungespringbaseh*2+ztolerance*2-plungerz+i*plungespringstep;

    hull() {
      translate([-plungespringdepth+wall,-plungespringw/2,z]) roundedbox(plungespringthickness,plungespringw,plungespringthickness,plungespringthickness);
      translate([-xtolerance-plungespringthickness-plungespringcompress,-plungespringw/2,z+plungespringstep/2]) roundedbox(plungespringthickness,plungespringw,plungespringthickness,plungespringthickness);
    }

    hull() {
      translate([-xtolerance-plungespringthickness-plungespringcompress,-plungespringw/2,z+plungespringstep/2]) roundedbox(plungespringthickness,plungespringw,plungespringthickness,plungespringthickness);
      translate([-plungespringdepth+wall,-plungespringw/2,z+plungespringstep]) roundedbox(plungespringthickness,plungespringw,plungespringthickness,plungespringthickness);
    }
  }
}

module sides() {
  for (y=[0,width-wall]) {
    difference() {
      union() {
	hull() {
	  translate([0,y,0]) roundedbox(height,wall,topl,cornerd);
	  translate([fingerendh,y,length]) roundedbox(wall,wall,wall,cornerd);
	  translate([fingertoph,y,fingertopl]) roundedbox(wall,wall,wall,cornerd);
	}

	// Strengthening
	hull() {
	  translate([fingerendh+wall/2,y+wall/2,length+wall/2]) sphere(d=strengthd,$fn=30);
	  translate([fingertoph+wall/2,y+wall/2,fingertopl+wall/2]) sphere(d=strengthd,$fn=30);
	}

	hull() {
	  translate([height-wall/2,y+wall/2,topl-wall/2]) sphere(d=strengthd,$fn=30);
	  translate([fingertoph+wall/2,y+wall/2,fingertopl+wall/2]) sphere(d=strengthd,$fn=30);
	}

	hull() {
	  translate([-storageh,y,0]) roundedbox(storageh+wall,wall,storagel-storageh,cornerd);
	  translate([0,y,storagel]) roundedbox(wall,wall,wall,cornerd);
	}
      }

      for (y=[0,width-wall]) {
	if (y==0) {
	  translate([-storageh+axlefrombottom,y,axleh]) axlehole(180);
	} else {
	  translate([-storageh+axlefrombottom,y-ytolerance,axleh]) axlehole(0);
	}
      }
    }
  }

  hull() {
    translate([height-wall/2,strengthd/2+wall/2-strengthd/2,topl-wall/2]) sphere(d=strengthd,$fn=30);
    translate([height-wall/2,width+wall/2-wall,topl-wall/2]) sphere(d=strengthd,$fn=30);
  }

  for (y=[0,width]) {
    if (y==0) {
      translate([-storageh+axlefrombottom,y+wall+ytolerance,axleh]) axletappi(180);
    } else {
      translate([-storageh+axlefrombottom,y-wall-ytolerance,axleh]) axletappi(0);
    }
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
	  translate([-storageh-0.1,y,-0.01]) cube([wall+0.2,ytolerance+hingew+ytolerance,axleh+axleoutd/2+axleh-axleoutd/2+2]);
	}
	translate([-storageh-0.01,wall+ytolerance+hingew,-0.01]) cube([wall+axlefrombottom+0.02,width-2*(wall+hingew+ytolerance),axleh]);
	for (y=[fingerw/2:fingerdistance:width-slitd]) {
	  hull() {
	    translate([-storageh-0.1,y+slitd/2,slitstart+slitd/2]) rotate([0,90,0]) cylinder(h=wall+0.2,d=slitd);
	    translate([-storageh-0.1,y+slitd/2,slitstart+slitl]) rotate([0,90,0]) cylinder(h=wall+0.2,d=slitd);
	  }
	}
      }
      hull() {
	translate([0,0,storagel]) roundedbox(wall,width,wall,cornerd);
	translate([-storageh,0,storagel-storageh-wall]) roundedbox(wall,width,wall,cornerd);
      }

      // Prevents berries from escaping
      if (print!=4) for (y=[0:preventerdistance:width-preventerdistance]) {
	  ymax=(y+preventerdistance+wall/2>=width?-wall:0);
	  hull() {
	    translate([wall/2,y+wall/2,storagel+wall/2]) sphere(d=wall);
	    translate([wall/2,y+wall/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
	    translate([preventerh+wall/2,y+wall/2,storagel+preventerh+wall]) sphere(d=wall);
	  }
	  hull() {
	    translate([wall/2,y+wall/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
	    translate([preventerh+wall/2,y+wall/2,storagel+preventerh+wall]) sphere(d=wall);
	    translate([wall/2,y+preventerdistance/2,storagel+preventerh*2+preventerdistance/2+wall/2]) sphere(d=wall);
	    translate([preventerh+wall/2,y+preventerdistance/2,storagel+preventerh+preventerdistance/2+wall]) sphere(d=wall);
	  }
	  hull() {
	    translate([wall/2,y+wall/2+preventerdistance+ymax,storagel+preventerh*2+wall/2]) sphere(d=wall);
	    translate([preventerh+wall/2,y+preventerdistance+wall/2+ymax,storagel+preventerh+wall]) sphere(d=wall);
	    translate([wall/2,y+preventerdistance/2,storagel+preventerh*2+preventerdistance/2+wall/2]) sphere(d=wall);
	    translate([preventerh+wall/2,y+preventerdistance/2,storagel+preventerh+preventerdistance/2+wall]) sphere(d=wall);
	  }

	  // Prevents berries from getting stuck in tight corners
	  yymax=(y+preventerdistance+wall/2>=width?-wall:0);
	  
	  hull() {
	    translate([wall/2+preventerdistance/2,y+preventerdistance/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
	    translate([wall/2,y+wall/2,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
	    translate([wall/2,y+wall/2+preventerdistance+yymax,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
	  }
	  hull() {
	    translate([wall/2+preventerdistance/2,y+preventerdistance/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
	    translate([wall/2,y+wall/2,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
	    translate([wall/2+preventerdistance/4,y+wall/2,storagel+preventerh*2-preventerdistance/4+wall/2]) sphere(d=wall);
	  }
	  hull() {
	    translate([wall/2+preventerdistance/2,y+preventerdistance/2,storagel+preventerh*2+wall/2]) sphere(d=wall);
	    translate([wall/2,y+yymax+preventerdistance+wall/2,storagel+preventerh*1.4+wall/2]) sphere(d=wall);
	    translate([wall/2+preventerdistance/4,y+yymax+preventerdistance+wall/2,storagel+preventerh*2-preventerdistance/4+wall/2]) sphere(d=wall);
	  }
      }

      hull() {
	translate([-storageh,wall+hingew+2*ytolerance,backopening+axleoutd]) roundedbox(wall,width-2*wall-4*ytolerance-2*hingew,wall,cornerd);
	translate([-storageh+backopening+wall+0.5*xtolerance,wall+hingew+2*ytolerance,wall]) roundedbox(wall,width-2*wall-4*ytolerance-2*hingew,0.2,cornerd);
	translate([-storageh+backopening-0.5*xtolerance,wall+hingew+2*ytolerance,0]) roundedbox(wall,width-2*wall-4*ytolerance-2*hingew,0.2,cornerd);
	translate([-storageh+axlefrombottom,wall+hingew+2*ytolerance,axleh]) rotate([-90,0,0]) cylinder(d=axleoutd,h=width-2*wall-4*ytolerance-2*hingew,$fn=90);
	translate([-storageh+axleoutd/2,wall+hingew+2*ytolerance,axleoutd/2]) rotate([-90,0,0]) cylinder(d=axleoutd,h=width-2*wall-4*ytolerance-2*hingew,$fn=90);
      }

      // sides
      sides();
    }
      
    for (y=[0,width-wall]) {
      if (y==0) {
	translate([-storageh+axlefrombottom,y+wall+ytolerance+hingew,axleh]) axlehole(0);
      } else {
	translate([-storageh+axlefrombottom,y-(ytolerance+hingew+wall+ytolerance),axleh]) axlehole(180);
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
      
      difference() {
	translate([height-wall,0,0]) roundedbox(wall,width,topl,cornerd);
	translate([height-wall-0.1,width/2-clipslided/2,-0.1]) cube([wall+0.2,clipslided,cliph+0.1]);
      }
      translate([height+plungerx-wall,width/2-clipslided/2,0]) roundedbox(wall,clipslided,clippullh,cornerd);
      
       hull() {
	 translate([height+plungerx-wall,width/2-clipslided/2,clippullh]) roundedbox(wall*2,clipslided,cornerd,cornerd);
	 translate([height-wall,width/2-clipslided/2,clippullh+cliph]) roundedbox(wall*2,clipslided,cornerd,cornerd);
	 //translate([height+plungerx-wall,width/2-clipslided/2,clippullh]) roundedbox(wall*2,clipslided,cliph+clippullh,cornerd);
       }
	    
      hull() {
	translate([height-wall,width/2-clipslided/2,cliph+cutw]) roundedbox(wall*2,clipslided,clipsideh-cutw,cornerd);
	translate([height-0.1,width/2-clipslided/2-clipsidew,cliph+cutw]) roundedbox(0.1,clipsidew+clipslided+clipsidew,clipsideh-cutw,cornerd);
      }
    }

    translate([height-textdepth+0.01,cornerd+1,cornerd+1]) rotate([0,90,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="right", valign="bottom");

    // Clip to hold back cuts
    translate([height-wall-0.1,width/2-clipw/2,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
    translate([height-wall-0.1,width/2+clipw/2-cutw,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
    translate([height-wall-0.1,width/2-clipw/2-clipsidew,cliph]) cube([wall+0.2,clipsidew+cutw+0.01,cutw+0.1]);
    translate([height-wall-0.1,width/2+clipw/2-cutw-0.01,cliph]) cube([wall+0.2,clipsidew+cutw+0.01,cutw+0.1]);
    translate([height-wall-0.1,width/2-clipw/2-clipsidew,cliph+clipsideh]) cube([wall+0.2,clipsidew+clipw+clipsidew+0.01,cutw+0.1]);

    translate([height+plungerx-wall/2,width/2-clipw/2,clippullh]) triangle(wall*1.5+0.01,clipw,wall*2,0); // DUPLICATED in handle
  }
    
  // Clip to keep back closed
  translate([height-wall+plungerx,width/2-clipw/2+cutw,0]) roundedbox(wall,clipw-cutw*2,clippullh,cornerd);
  translate([height-wall-cornerd+plungerx,width/2-clipw/2+cutw,0]) roundedbox(wall+cornerd,clipw-cutw*2,clipheight,cornerd);
 difference() {
    hull() {
      translate([height-wall-clipdepth+plungerx,width/2-clipw/2+cutw,0]) roundedbox(clipdepth,clipw-cutw*2,clipheight,cornerd);
      translate([height-wall-clipdepth+plungerx,width/2-cornerd/2,wall+clipw/2]) roundedbox(clipdepth,cornerd,cornerd,cornerd  );
    }
    translate([height-wall+plungerx-xtolerance-1,width/2-clipw/2,clippullh]) triangle(1+xtolerance+0.01,clipw,clipheight+clipw/2-clippullh+cornerd,3);
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
      hull() {
	difference() {
	  translate([height+handlex+plungerx,width/2,clippullh-0.1]) cylinder(h=plungerangledh+clipplungerzmovement+0.1,d=clipslided);
	  translate([height+handlex+plungerx-clipslided/2,width/2-clipslided/2,clippullh+clipplungerzmovement]) triangle(clipslided+0.01,clipslided,plungerangledh+0.01,1);
	}
	intersection() {
	  translate([-plungercountersupportheight/2,0,-plungercountersupportheight+clipplungerzmovement]) difference() {
	    translate([height+handlex+plungerx,width/2,clippullh-0.1]) cylinder(h=plungerangledh+0.1,d=clipslided);
	    translate([height+handlex+plungerx-clipslided/2,width/2-clipslided/2,clippullh]) triangle(clipslided+0.01,clipslided,plungerangledh+0.01,1);
	  }
	  translate([height,width/2-handled/2,clippullh]) cube([handlex+handled,handled,plungerh]);
	}
      }

      translate([height+plungerx+wall+xtolerance,width/2-clipslided/2,clippullh]) triangle(handlex-wall-clipslided-xtolerance-xtolerance,clippullh,clippullh,11);
      translate([height+plungerx+wall+xtolerance,width/2+clipslided/2-clippullh,clippullh]) triangle(handlex-wall-clipslided-xtolerance-xtolerance,clippullh,clippullh,8);
  
    }
    union() {
      hull() {
	translate([height+plungerx+handlex-clipdepth-xtolerance,width/2,0]) cylinder(h=clippullh+plungerangledh+clipplungerzmovement,d=clipslided);
	translate([height+plungerx-cornerd,width/2-clipw/2,0]) cube([handlex-clipdepth-xtolerance+cornerd,clipw,clippullh+clipslided+clipplungerzmovement]);
      }
      translate([height-wall-clipdepth+plungerx,width/2-clipw/2+clippullh+cutw,0]) roundedbox(wall+clipdepth,clipw-cutw*2-clippullh*2,clippullh,cornerd);      
    }
  }

  // back 
  if (withlonghandle) {

    if (adhesion) {
      x=-storageh-2;
      w=wall+ytolerance+hingew+ytolerance+2;
      xl=axlefrombottom+2;
      
      for (y=[cornerd,width-w-0.4-cornerd]) {
	translate([x,y,0]) cube([0.4,w,0.2]);
	translate([x,y,0]) cube([xl,0.4,0.2]);
	translate([x,y+w,0]) cube([xl,0.4,0.2]);
      }
    }
    
    // Opening back
    intersection() {
      hull() {
	translate([-storageh+axlefrombottom,wall,axleh]) rotate([-90,0,0]) cylinder(h=width-2*wall,r=height+storageh-axlefrombottom-wall-xtolerance,$fn=90);
	translate([-storageh+axlefrombottom,wall,0]) rotate([-90,0,0]) cylinder(h=width-2*wall,r=height+storageh-axlefrombottom-wall-xtolerance,$fn=90);
      }
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
		translate([height-wall-clipdepth-xtolerance,width/2-clipw/2,-0.1]) cube([clipdepth+wall,clipw,clipheight+0.1]);
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
	    //	    translate([-storageh+axlefrombottom,y+wall+ytolerance,axleh]) axletappi(180);
	    translate([-storageh+axlefrombottom,y+wall+ytolerance+hingew,axleh]) axletappi(0);
	  } else {
	    //translate([-storageh+axlefrombottom,y-wall-ytolerance,axleh]) axletappi(0);
	    translate([-storageh+axlefrombottom,y-wall-ytolerance-hingew,axleh]) axletappi(180);
	  }
	}
      }
    }
  } else {
    // Fixed back
    translate([-storageh,0,0]) roundedbox(height+storageh,width,wall,cornerd);
  }

  // handle
  difference() {
    union() {
      // Spring stopper
      difference() {
	hull() {
	  translate([height+handlex-plungerd/2-wall/2,width/2-plungespringw/2,plungerheight+plungespringbottomheight-plungespringstopperh]) triangle(plungespringdepth+wall/2,plungespringw,plungespringstopperh,1);
	  translate([height+handlex-plungerd/2-wall/2+plungespringdepth+wall/2,width/2,plungerheight+plungespringbottomheight-1]) cylinder(d=plungespringw,h=1);
	}

	translate([height+handlex-plungespringcenteringxoffset,width/2,plungerheight+plungespringbottomheight-plungespringcenteringh/2]) cylinder(h=plungespringcenteringh/2+0.01,d1=plungespringcenteringd/3,d2=plungespringcenteringd*1.5,$fn=90);
	translate([height+handlex-plungespringcenteringxoffset,width/2,plungerheight+plungespringbottomheight-plungespringcenteringh]) cylinder(h=plungespringcenteringh+0.01,d1=plungespringcenteringd/3+xtolerance,d2=plungespringcenteringd+xtolerance,$fn=90);
      
      }
    
      difference() {
	union() {
	  difference() {
	    // Low handle part
	    union() {
	      hull() {
		translate([height-wall,width/2-handleattachd/2,0]) roundedbox(wall,handleattachd,handleattachd-handlex/3,cornerd);
		translate([height+handlex,width/2,0]) cylinder(d=handled,h=handlelowh);

		hull() {
		  translate([height-wall,width/2-bridgey/2-wall,plungerheight+plungespringbottomheight-plungespringstopperh+wall-1]) cube([handlex+wall,bridgey+2*wall,1]);
		  translate([height-wall,width/2-handleattachd/2,0]) cube([wall,handleattachd,handleattachd]); //clippullh*2
		}
	      }
	      translate([height+handlex,width/2,0]) cylinder(d=handled,h=handlel);
	    }

	    // Cut insides
	    hull() {
	      translate([height-wall,width/2-bridgey/2,plungerheight+plungespringbottomheight-plungespringstopperh-1]) cube([handlex+wall,bridgey,1]);
	      translate([height-wall,width/2-clipw/2,wall]) cube([handlex+wall,clipw,clippullh+clipplungerzmovement*2-wall]);
	    }
	  }

	  // Top handle part
	  union() {
	    difference() {
	      hull() {
		translate([height-wall,width/2-handleattachd/2,handlefrontattach]) roundedbox(wall,handleattachd,handleattachd,cornerd);
		translate([height+handlex,width/2,handlel]) cylinder(d=handled,h=wall);
	      }

	      // Cut insides
	      // Does not work properly, makes it difficult to close the lower part
	      hull() {
		translate([height-0.1,width/2-handleattachd/2+wall,handlefrontattach+wall*0.7]) roundedbox(0.1,handleattachd-wall*2,handleattachd-wall*2.5,cornerd);
		translate([height+handlex,width/2,handlel+wall]) cylinder(d=handled-2*wall,h=0.1);
	      }
	    }
	  }

	  // Close upper handle support
	  if (0) intersection() {
	    translate([height+handlex,width/2,handlel]) cylinder(d=handled,h=handlel+clipslided);
	    translate([height+handlex-handled/2,width/2-handled/2,handlel-0.01]) triangle(handled/2,handled,clipslided+ztolerance+wall*2.0,2);
	  }
	}

	//translate([height-wall-0.1,width/2-clipslided/2,-0.1]) cube([wall+0.2,clipslided,cliph+0.1]);

	// Weaken back leaf spring as it is designed to be separate, but needs to connected to be be printed
	translate([height-wall/2,width/2-clipw/2,clippullh]) triangle(wall*1.5+0.01,clipw,wall*2,0); // DUPLICATED in top

     
	// Cut clip from top
	translate([height-wall-0.1,width/2-clipw/2,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);
	translate([height-wall-0.1,width/2+clipw/2-cutw,-0.1]) cube([wall+0.2,cutw,cliph+0.1]);

	// Space for clip movement
	intersection() {
	  translate([height,width/2-(handled-wall*2)/2,wall]) cube([cutw+clipdepth+wall+xtolerance,handled-wall*2,cliph-wall]);
	}

	// Cut space for plunger
	translate([height+handlex,width/2,-0.1]) cylinder(d=handled-wall*2,h=topl+0.2+wall/2);

	// Space for movement in the base of low handle
	translate([height,width/2-(handled-wall*2)/2,-0.1]) cube([handlex,handled-wall*2,wall+0.2]);

	//translate([height+handlex,width/2,handlel-0.01]) cylinder(d=handled-wall*2,h=handled+0.01);
      }

	  // Close upper handle support
      if (0)	  intersection() {
	    difference() {
	      translate([height+handlex,width/2,handlel]) cylinder(d=handled,h=handlel+clipslided);
	      translate([height+handlex,width/2,handlel]) cylinder(d=handled-wall*2,h=handlel+clipslided);
	    }

	    translate([height+handlex-handled/2,width/2-handled/2,handlel-0.01]) triangle(handled/2,handled,clipslided+ztolerance+wall+wall,2);
	  }
	  
      // Holdback to keep clip movement in place
      translate([height+cutw+clipdepth+wall+xtolerance,width/2+clipw/2-clippullh,0]) triangle(handlex-cutw-clipdepth-wall-xtolerance,clippullh,clippullh,11);
      translate([height+cutw+clipdepth+wall+xtolerance,width/2-clipw/2,0]) triangle(handlex-cutw-clipdepth-wall-xtolerance,clippullh,clippullh,8);
      translate([height+cutw+clipdepth+wall+xtolerance,width/2+clipw/2-clippullh,clippullh]) triangle(handlex-clipslided/2-clipdepth-plungercountersupportheight/2,clippullh,clippullh,9);
      translate([height+cutw+clipdepth+wall+xtolerance,width/2-clipw/2,clippullh]) triangle(handlex-clipslided/2-clipdepth-plungercountersupportheight/2,clippullh,clippullh,10);

    }

    // Holes for plunge clip to go in
    translate([height+handlex-handled/2-xtolerance-plungeclipd,width/2-plungeclipw/2-plungeclipcut/2*2,handlel+clipslided-plungeclipd*2]) cube([handlex,plungeclipw+plungeclipcut*2,plungeclipd*2]);
    translate([height+handlex-handled/2-xtolerance+plungeclipshelfdepth,width/2-plungeclipw/2-plungeclipcut/2*2,handlel+clipslided-plungeclipd*2]) cube([handlex,plungeclipw+plungeclipcut*2,topl]);
  }

  // Shelf to prevent plunger to drop out from above (plug has clip)
  translate([height+handlex-handled/2-xtolerance,width/2-plungeclipshelfw/2,handlel+clipslided]) cube([plungeclipshelfdepth,plungeclipshelfw,plungeclipshelfh]);

  // fingers
  if (print!=4) {
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
}

intersection() {
  if (debug) translate([-20,0,0]) cube([height+80,width/2,length+1]);
  if (print==4 && debug) translate([-storageh-10,0,0]) cube([height+90,width+plungerd+20,topl]);

  union() {
    if (print==0 || print==1 || print==3 || print==4) {
      berrypicker();
    }

    if (print==0) {
      translate([height+handlex,width/2,plungerzposition]) plunger();
    }
  
    if (print==2 || print==3 || print==4) {
      translate([height,width+1+clipslided/2,plungerh]) rotate([180,0,120]) plunger();
    }
  }
}

if (print==5) {
  totalh=plungespringh+ztolerance+plungerz+1;
  intersection() {
    if (debug) translate([-plungespringd,0,0]) cube([plungespringd*2,plungespringd,totalh+1]);
    union() {
      translate([0,0,0]) spring(totalh,plungespringd,plungespringplatethickness,plungespringthickness);
      if (0) difference() {
	cylinder(h=totalh,d=plungespringd+1.6+ztolerance*2,$fn=90);
	translate([0,0,-0.01]) cylinder(h=totalh+0.02,d=plungespringspaced,$fn=90);
      }
    }
  }
 }
