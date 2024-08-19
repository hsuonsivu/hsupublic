// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

debug=0;

print=0; // 1 = lower box with no mid walls with guides, 2 = upper box with mid walls, no guides, 3 = lower box with 1 mid wall with guides

withguides=(print==1 || print==3) ? 1 : 0;
withbottomguideinterface=(print==1 || print==3) ? 0 : 1;

brandtext="Utensilbox";
versiontext="v1.2";
textsize=7;
textdepth=1;

depth=295; // y
width=310; // x
height=60; // z, 120mm total height, two on top of each other
wall=2;
cornerd=1;
slots=(print == 1) ? 1 : (print == 3) ? 2 : 4;
handledepth=10;
handleheight=20;
handlelength=100;
handlecornerd=5;
handlecylinderd=3*wall;
handlecylinderw=1.5*wall;
handlecut=1; // Cut in the middle to make removing handle filler easier
handlecutwall=1; // The part to cut out should be thinner than wall
snapy=0.1;
snapw=0.3;
snapz=0.1;

holed=8;
holedistance=4;
slotwidth=(width-wall)/slots;

guidelength=70;
guideheight=21;
guidemidh=5;
guideh=10;
guidewall=1.5;
guideout=0.7;
guidetolerance=0.2;
guidecornerw=5;

boxsupporth=6;
boxsupportheight=height - boxsupporth;
boxsupportw=2;

texth=height/2+handleheight/2-handledepth/2;;
  
holesperslot=floor((slotwidth-guidewall*2)/(holed+holedistance));
holesperdepth=floor((depth-wall-guidewall*2)/(holed+holedistance));

guidecutd=10;
guideoverlap=guidecutd/2;

module guide() {
  // Wall extension
  hull() {
    translate([wall/2,wall/2,-guideh-wall/2]) sphere(d=wall,$fn=60);
    translate([wall/2,wall/2,-wall/2]) sphere(d=wall,$fn=60);
    translate([-guidetolerance+guidewall/2,-guidetolerance+guidewall/2,-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([guidelength,wall/2,-guideh-wall/2]) sphere(d=wall,$fn=60);
    translate([guidelength,wall/2,-wall/2]) sphere(d=wall,$fn=60);
    translate([guidelength,-guidetolerance+guidewall/2,-guidewall/2]) sphere(d=guidewall,$fn=60);
  }

  // Lower guide
  hull() {
    translate([-guidetolerance+guidewall/2,-guidetolerance+guidewall/2,-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([guidelength,-guidetolerance+guidewall/2,-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([-guidetolerance+guidewall/2,-guidetolerance+guidewall/2,guidemidh-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([guidelength,-guidetolerance+guidewall/2,guidemidh-guidewall/2]) sphere(d=guidewall,$fn=60);
  }

  // Upper guide
  hull() {
    translate([-guidetolerance+guidewall/2,-guidetolerance+guidewall/2,guidemidh-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([guidelength,-guidetolerance+guidewall/2,guidemidh-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([-guidetolerance+guidewall/2-guideout,-guidetolerance+guidewall/2-guideout,guideheight-guideh-guidewall/2]) sphere(d=guidewall,$fn=60);
    translate([guidelength,-guidetolerance+guidewall/2-guideout,guideheight-guideh-guidewall/2]) sphere(d=guidewall,$fn=60);
  }

  // Corner support
  hull() {
    translate([wall-cornerd/2,0,-boxsupporth]) triangle(boxsupportw,guidelength/2,boxsupporth,1);    
    translate([wall-cornerd/2,0,-boxsupporth]) triangle(guidecornerw,guidecornerw,boxsupporth,1);    
  }
}

module cornerguide() {
  guide();
  mirror([-1,1,0]) {
    guide();
  }
}

module utensilbox(withguides,withbottomguideinterface) {
  difference() {
    union() {
      if (withguides) {
	// To help with stacking the boxes
	translate([0,0,height]) cornerguide();
	translate([width,0,height]) rotate([0,0,90]) cornerguide();
	translate([0,depth,height]) rotate([0,0,-90]) cornerguide();
	translate([width,depth,height]) rotate([0,0,180]) cornerguide();

	translate([0,wall-cornerd/2,boxsupportheight]) triangle(width,boxsupportw,boxsupporth,10);
	translate([0,depth-wall-boxsupportw+cornerd/2,boxsupportheight]) triangle(width,boxsupportw,boxsupporth,9);
	translate([wall-cornerd/2,0,boxsupportheight]) triangle(boxsupportw,depth,boxsupporth,1);
	translate([width-boxsupportw-wall+cornerd/2,wall-cornerd/2,boxsupportheight]) triangle(boxsupportw,depth,boxsupporth,3);
      }

      // Bottom
      translate([0,0,0]) roundedbox(width,depth,wall,cornerd);

      // Walls for depth direction
      for (x=[0:slotwidth:width-wall]) {
	difference() {
	  translate([x,0,0]) roundedbox(wall,depth,height,cornerd);
	  translate([x-0.1,depth/2-handlelength/2,height-handledepth-handleheight]) cube([wall+0.2,handlelength,handleheight+handlecylinderd/2]);
	}
	difference() {
	  hull() {
	    translate([x+wall-(wall/2-handlecutwall/2),depth/2-handlelength/2+wall,height-handledepth-handleheight+wall]) roundedbox(0.01,handlelength-wall*2,handleheight-wall*2,handlecornerd);
	    translate([x+wall/2-snapw/2,depth/2-handlelength/2+snapy/2,height-handledepth-handleheight+snapz/2]) roundedbox(snapw,handlelength-snapy,handleheight-snapz,handlecornerd);
	    translate([x+wall/2-handlecutwall/2,depth/2-handlelength/2+wall,height-handledepth-handleheight+wall]) roundedbox(0.01,handlelength-wall*2,handleheight-wall*2,handlecornerd);
	  }
	  translate([x+wall/2-wall/2-0.1,depth/2-handlecut/2,height-handledepth-handleheight]) cube([wall+0.2,handlecut,handleheight]);
	}

	translate([x+wall/2,depth/2-handlelength/2-0.1,height-handledepth+handlecylinderd/2]) rotate([-90,0,0]) resize([handlecylinderw,0,0]) cylinder(d=handlecylinderd,h=handlelength+0.2,$fn=60);
      }

      for (x=[0,width-wall-guidewall-guidetolerance]) {
	if (withbottomguideinterface) translate([x,0,0]) roundedbox(wall+guidewall+guidetolerance,depth,guideh+guideoverlap,cornerd);
      }

      for (y=[0,depth-wall]) {
	translate([0,y,0]) roundedbox(width,wall,height,cornerd);
      }

      if (withbottomguideinterface) {
	for (y=[0,depth-wall-guidewall-guidetolerance]) {
	  translate([guidewall+guidetolerance,y,0]) roundedbox(width-guidewall-guidetolerance,wall+guidewall+guidetolerance,guideh+guideoverlap,cornerd);
	  translate([guidewall+guidetolerance,depth-wall-guidewall-guidetolerance,0]) roundedbox(width-guidewall-guidetolerance,wall+guidewall+guidetolerance,guideh+guideoverlap,cornerd);
	}
      }
    }

    for (x=[wall+guidewall:slotwidth:width-wall-2*guidewall]) {
      for (xx=[(slotwidth-holesperslot*(holed+holedistance))/2+holed/2:holed+holedistance:slotwidth-wall-2*guidewall]) {
	for (y=[depth-guidewall-holesperdepth*(holed+holedistance)+holed/2:holed+holedistance:depth-wall]) {
	  translate([x+xx-holed/2,y-holed/2,-0.1]) cube([holed,holed,wall+0.2]); //cylinder(h=wall+0.2,d=holed);
	}
      }
    }

    if (withbottomguideinterface) {
      for (y=[-guidecutd/2+guidewall,depth+guidecutd/2-guidewall]) {
	hull() {
	  for (z=[0,guideh+guidetolerance]) {
	    translate([-guidecutd/2+guidewall,y,z]) sphere(d=guidecutd,$fn=60);
	    translate([width+guidecutd/2-guidewall,y,z]) sphere(d=guidecutd,$fn=60);
	  }
	}
      }

      for (x=[-guidecutd/2+guidewall,width+guidecutd/2-guidewall]) {
	hull() {
	  for (z=[0,guideh+guidetolerance]) {
	    translate([x,-guidecutd/2+guidewall,z]) sphere(d=guidecutd,$fn=60);
	    translate([x,depth+guidecutd/2-guidewall,z]) sphere(d=guidecutd,$fn=60);
	  }
	}
      }
    }

    translate([width/2,textdepth-0.01,texth+textsize+2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(brandtext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");
    translate([width/2,textdepth-0.01,texth]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");

    translate([wall+2,depth-wall+textdepth-0.01,texth+textsize+2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(brandtext,font="Liberation Sans:style=Bold",size=textsize,halign="left", valign="center");
    translate([wall+2,depth-wall+textdepth-0.01,texth]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="left", valign="center");
  }
}

difference() {
  utensilbox(1,0); // Bottom
  # translate([0,0,height])  utensilbox(0,1); // Top
  //translate([-2,-2,-0.1]) cube([wall+guidewall+1+4,depth+4,height+guideheight+0.2]);
}
