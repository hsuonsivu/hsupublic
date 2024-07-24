// glassless film holder for Epson V850 pro

use <hsu.scad>;

filmtype=35; //46; //35; // 35mm or 46

print=3; // 1 = print film frame, 2 print 1 cover, 2 = print covers for all film frames, 3 = print one whole set, 4 print attachment test
debug=1; // 1 just one strip, 2 smallest possible
tappitypemale=1; // 0 = rounded cube, 1 = circular
tappitypefemale=1; // 0 = rounded cube, 1 = circular
filmstrips=((debug==0) || (debug==3))?((filmtype==35)?4:3):1;
detachable_epson_bits=1;
testcuts=0; // Cutouts to reveal clip structures.
adhesion=0; // Adds some structures to increase bed adhesion.

hooks=((filmtype==35) ?1:0);
frameseparators=(filmtype==35)?0:1;
v="V1.25";
versiontext=debug?str(v, "-", debug):v;

textdepth=1;
textsize=6;
textxposition=textsize/6;

cornerd=0.3;

xtolerance=0.4;
ytolerance=0.55;
xhookholetolerance=0.30;
yhookholetolerance=0.30;
ztolerance=0.3;
tappiztolerance=ztolerance;

length=(debug==2)?90:(debug==1)?225:((filmtype==35)?260:260);
thickness=5; // Thickness.

holeoutsidew=(filmtype==35)?30.8:42; //8;
framew=(filmtype==35)?35.8:46.2;//35.8;//5;
holefromoutw=(framew-holeoutsidew)/2;

holedistance=38/8;

holewidth=2; // Width of film holes. Actual 2.2.
holew=(filmtype==35)?holewidth:2; //2;//(holeoutsidew - holeinsidew)/2-0.9;
holeoffset=(4-holewidth)/2;
tappiw=holew+0.1;

holeinsidew=holeoutsidew-2*holew; //25.3;
framel=(filmtype==35)?36:44;
framegap=2;

frameimagew=(filmtype==35) ? 24.5 : 41; //26.5;//.3; // holeinsidew+0.4;
frameimagey=framew/2-frameimagew/2;
  
filmh=2; // Position of the film above the glass

filmholdery=(filmtype==35)?31:31;
filmholderx=11;
filmthickness=0.12; // was 0.2, 0.12 measured
// frame starts at hole, new frame every 8 holes.

framehookx=holewidth*0.9; // 0.9 compensate 3d printer inaccuracy
framehookh=thickness-filmh-filmthickness;
coverthickness=thickness-filmh; // Thing above the film
coverh=thickness-filmh;
framehooktoph=thickness;
framehooky=2+holew;
hookcornerd=1.5;

tappih=min(thickness - framehookh,1.7);//framehookh - 0.5;

// First frame start
framestart=1;

frameseparator=1.2; // 2 mm minus tolerance
frameseparatoroffset=(2-frameseparator)/2;
framedistance=(filmtype==35)?38:46.5;

adapterw=19.7; // From right side
adapterl=24.9;
adapteroffset=18; // From top
adaptertappid=4.85;
adaptertappih=6.5; // From base
adapterdistance=182;
adapterh=1.5;
adaptertextx=adapterl/2; // relative from start of adapter
adaptertexty=-9-textsize; // relative from start of adapter
adapterattachy=4;
adapterattachyoffset=1;
adapterattachx=18;
adapterattachd=adapterattachy-0.5;
adapterattachxin=3;
adapterattachxtolerance=0.14; // 25;
adapterattachytolerance=0.14; // 15;
adapterattachdtolerance=0.10;
adapterattachdxoffset=0.5;

filmholderl=length-filmholderx*2;
filmholdergap=3.7;//4;
filmholderoffset=framew+filmholdergap;

lightenholestart=7;
lightenholex=15;
lightenholegap=((framel+framegap)-2*lightenholex)/2;
lightenholey=18; //filmholdery*0.63;
lightenholexoffset=2.5;

rolldiameter=100;

width=filmholdery+filmstrips*(framew+filmholdergap)+1.5;//(debug==2)?67:(debug==1)?72:181;//218;

clipdepth=0.6;
cliph=2;
clipz=1;
clipx=1.2;
clipdistance=20;
clipwidth=20;
clipxtolerance=0.4;
clipytolerance=0.55;

sideclipdepth=0.7;
sidecliph=2;
sideclipz=1;
sideclipy=1.2;
sideclipdistance=20;
sideclipwidth=7;
sideclipspace=1.5;
sideclipoffset=10; // between right and left side.
sideclipysink=1;
sideclipxtolerance=0.50;
sideclipytolerance=0.45; //55

holdertotalw=framew+sideclipysink+ytolerance+sideclipy;

module triangle(x,y,z,mode) {
  if (mode==0) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x,z],[x,0]]);
  } else if (mode==1) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z]]);
  } else if (mode==2) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,0]]);
  } else if (mode==3) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x,0]]);
  } else if (mode==4) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y,x],[y,0]]);
  } else if (mode==5) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x]]);
  } else if (mode==6) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,0]]);
  } else if (mode==7) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y,0]]);
  } else if (mode==8) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z,y],[z,0]]);
  } else if (mode==9) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y]]);
  } else if (mode==10) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,0]]);
  } else if (mode==11) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z,0]]);
  }
}

// height=total diameter, toph=height of narrowing top part 
module tappi(diameterx,diametery,height,toph,cd,circulartappi,down) {
  if (circulartappi) {
    diameter=min(diameterx,diametery);
    th=toph>0?toph:diameter/3;
    translate([diameter/2,diameter/2,0]) {
      if (down) {
	translate([0,0,th]) cylinder(h=height-th,d=diameter,$fn=30);
	cylinder(h=th+0.01,d1=diameter/3,d2=diameter,$fn=30);
	//hull() {
	//  translate([0,0,th+0.01]) cylinder(h=0.01,d=diameter,$fn=30);
	//  translate([0,0,1/2]) sphere(d=1,$fn=30);
	//}
      } else {
	cylinder(h=height-th,d=diameter,$fn=30);
	translate([0,0,height-th-0.01]) cylinder(h=th+0.01,d1=diameter,d2=diameter/3,$fn=30);
	  // 	hull() {
	  //	  translate([0,0,height-th-0.01]) cylinder(h=0.01,d=diameter,$fn=30);
	  //	  translate([0,0,height-1/2]) sphere(d=1,$fn=30);
	  //      }
    }
    }
  } else {
    // toph is ignored here
    roundedbox(diameterx,diametery,height,cd);
  }
}

module roundedbox(x,y,z,c) {
  corner=(c && (c > 0)) ? c : 1;
  scd = ((x < corner || y < corner || z < corner) ? min(x,y,z) : corner);
  f=(print > 0) ? 30 : 30;
  
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
  }
}

module scanadapter() {
  if (adhesion) {
    tassu(-135,10);
    translate([length,0,0]) tassu(-45,10);
    translate([length,width,0]) tassu(45,10);
    translate([0,width,0]) tassu(135,10);
  }
  

  difference() {
    // Adapters
    yoffset=(detachable_epson_bits && (print > 0))?-adapterattachy-1:0;
    translate([0,yoffset,0]) {
      for (x=[adapteroffset:adapterdistance:length-adapterl]) {
	translate([x,-adapterw,0]) roundedbox(adapterl,adapterw+(detachable_epson_bits?-1:cornerd),adapterh,cornerd);
	if (adhesion) {
	  translate([x,-adapterw,0]) tassu(-135,10);
	  translate([x+adapterl,-adapterw,0]) tassu(-45,10);
	  translate([x+adapterl,-1,0]) tassu(10,10);
	  translate([x,-1,0]) tassu(170,10);
	}
	translate([x+adaptertappid/2,-adapterw+adaptertappid/2,0]) cylinder(h=adaptertappih,d=adaptertappid,$fn=90);
	if (detachable_epson_bits) {
	  translate([x+(adapterl-adapterattachx)/2,0,0]) {
	    translate([adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,0]) cylinder(h=thickness,d=adapterattachd,$fn=90);
	    translate([0,adapterattachyoffset,0]) roundedbox(adapterattachx,adapterattachy,thickness,cornerd);
	    translate([0,-cornerd-1,0]) cube([adapterattachx,adapterattachy+cornerd+1,adapterh]);
	    translate([adapterattachx-adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,0]) cylinder(h=thickness,d=adapterattachd,$fn=90);
	  }
	}
      }
    }
	
    for (x=[adapteroffset:adapterdistance:length-adapterl]) {
      translate([x+adapterl/2,adaptertexty,adapterh-textdepth-0.01])  linear_extrude(height=textdepth+0.02) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    }
  }
  
  difference() {
    union() {
      roundedbox(length,width,thickness,cornerd);
    }

    // Adapters cut
    if (detachable_epson_bits) {
      for (x=[adapteroffset:adapterdistance:length-adapterl]) {
	h1=adapterh+thickness-adaptertappih-0.01;
	h2=adhesion?max(h1,0.2):h1;
	translate([x+adaptertappid/2,adapterw+adapterattachy+adapterattachyoffset-adaptertappid/2,h2]) cylinder(h=adaptertappih+0.02,d=adaptertappid+1,$fn=90);

	translate([x+(adapterl-adapterattachx)/2,0,0]) {
	  translate([-adapterattachxtolerance+adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,-0.01]) cylinder(h=thickness/2+0.02,d=adapterattachd+adapterattachdtolerance,$fn=90);
	  translate([adapterattachdxoffset-adapterattachxtolerance,adapterattachy/2+adapterattachyoffset,thickness/2]) cylinder(h=thickness/2+0.01,d1=adapterattachd+adapterattachdtolerance,d2=adapterattachd+adapterattachdtolerance*3,$fn=90);
	  translate([-adapterattachxtolerance,-0.01,-0.01]) cube([adapterattachx+adapterattachxtolerance*2,adapterattachy+adapterattachyoffset+adapterattachytolerance+0.02,thickness+0.02]);
	  translate([adapterattachx+adapterattachxtolerance-adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,-0.01]) cylinder(h=thickness/2+0.02,d=adapterattachd+adapterattachdtolerance,$fn=90);
	  translate([adapterattachx+adapterattachxtolerance-adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,thickness/2]) cylinder(h=thickness/2+0.01,d1=adapterattachd+adapterattachdtolerance,d2=adapterattachd+adapterattachdtolerance*3,$fn=90);
	}
      }
    }

    // Film openings
    for (y=[filmholdery:filmholderoffset:width-filmholdery]) {
      // End clip cuts
      translate([-0.01,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipx+clipxtolerance+0.02,clipwidth+clipytolerance*2,framehookh+0.02]);
      translate([clipx+clipxtolerance-0.01,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02]);
      translate([clipx+clipxtolerance-0.01,y+framew/2-clipwidth/2-clipytolerance,cliph/2-0.01]) triangle(clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02,2);

      translate([length-clipx-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipx+clipxtolerance+0.01,clipwidth+clipytolerance*2,framehookh+0.02]);
      translate([length-clipx-clipdepth-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipdepth+0.01,clipwidth+clipytolerance*2,cliph/2+0.02]);
      translate([length-clipx-clipdepth-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,cliph/2-0.01]) triangle(clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02,0);

      // Side clip cut
      for (clipx=[filmholderx+framestart:sideclipdistance:filmholderx+filmholderl-sideclipwidth-1]) {
	// right clip hole cut
	translate([clipx-sideclipxtolerance,y-sideclipy-sideclipspace-sideclipysink-0.01,framehookh]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+sideclipysink+0.02,thickness-framehookh+0.02]);
	translate([clipx-sideclipxtolerance,y-sideclipy-sideclipspace-sideclipysink,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+0.01,thickness+0.02]);
	translate([clipx-sideclipxtolerance,y-sideclipysink,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02]);
	translate([clipx-sideclipxtolerance,y-sideclipysink,sidecliph/2-0.01]) triangle(sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02,8);
	
	// left clip hole
	translate([clipx+sideclipoffset-sideclipxtolerance,y+framew-0.01,framehookh]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+sideclipysink+0.01,thickness-framehookh+0.02]);
	translate([clipx+sideclipoffset-sideclipxtolerance,y+framew+sideclipysink,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipy+sideclipspace+0.01,thickness+0.02]);
	translate([clipx+sideclipoffset-sideclipxtolerance,y+framew+sideclipysink-sideclipdepth,-0.01]) cube([sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02]);
	translate([clipx+sideclipoffset-sideclipxtolerance,y+framew+sideclipysink-sideclipdepth,sidecliph/2-0.01]) triangle(sideclipwidth+2*sideclipxtolerance,sideclipdepth+0.01,sidecliph/2+0.02,11);
      }

      // Film opening cut
      translate([filmholderx,y+frameimagey,-0.1]) cube([filmholderl,frameimagew,framehookh+0.2]);
      hull() {
	translate([filmholderx,y+frameimagey,framehookh-0.6]) cube([filmholderl,frameimagew,0.1]);
	translate([filmholderx-filmh*0.7,y-filmh*0.7+frameimagey,-0.01]) cube([filmholderl+2*filmh*0.7,frameimagew+2*filmh*0.7,0.01]);	
      }

      translate([filmholderx,y+frameimagey,-0.1]) cube([filmholderl,frameimagew,framehookh+0.02]);
      translate([-0.01,y,framehookh]) cube([length+0.02,framew,thickness-framehookh+0.1]);
    }

      // Holes to save filament
    for (y=[lightenholestart]) {
      for (x=[filmholderx+framestart+lightenholexoffset:framedistance:filmholderx+filmholderl-framedistance/2]) {
	translate([x+frameseparatoroffset,y,-0.1]) cube([lightenholex,lightenholey,thickness+0.2]);
	translate([x+frameseparatoroffset+lightenholex+lightenholegap,y,-0.1]) cube([lightenholex,lightenholey,thickness+0.2]);
      }
    }

    translate([textxposition,filmholdery/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
  }

  // Frame separators
  for (y=[filmholdery:filmholderoffset:width-filmholdery]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance*2]) {
	translate([x,y-filmh*0.7+frameimagey,0]) cube([frameseparator,frameimagew+2*filmh*0.7,framehookh]);
      }
    }
    
    if (hooks) {
      // Hooks
      for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl]) {
	for (xx=[x-holewidth:holedistance:(x+framel > filmholderx + filmholderl) ? length - 2*holedistance : x + framel]) {
	  translate([xx+holeoffset,y+holefromoutw,framehookh-(tappitypemale==1?0.01:hookcornerd/2)]) tappi(framehookx,holew,tappih+0.01,0,hookcornerd,tappitypemale,0);

	  translate([xx+holeoffset,y+framew-holefromoutw-holew,framehookh-(tappitypemale==1?0.01:hookcornerd/2)]) tappi(framehookx,holew,tappih+0.01,0,hookcornerd,tappitypemale,0);
	}
      }
    }
  }
}

module scancover() {
  if (adhesion) {
    translate([0,filmholdery+ytolerance,thickness]) mirror([0,0,1]) tassu(-135,8);
    translate([length,filmholdery+ytolerance,thickness]) mirror([0,0,1]) tassu(-45,8);
    translate([length,filmholdery+ytolerance+framew-2*ytolerance,thickness]) mirror([0,0,1]) tassu(45,8);
    translate([0,filmholdery+ytolerance+framew-2*ytolerance,thickness]) mirror([0,0,1]) tassu(135,8);
  }
  
  // Frame separators
  for (y=[filmholdery:filmholderoffset:filmholdery]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance*2]) {
	translate([x,y-filmh*0.7+frameimagey,coverh]) cube([frameseparator,frameimagew+2*filmh*0.7,thickness-coverh]);
      }
    }
  }
  
  difference() {
    translate([0,filmholdery+ytolerance,coverh]) roundedbox(length,framew-2*ytolerance,thickness-coverh,cornerd);

    for (y=[filmholdery:filmholderoffset:filmholdery]) {
      translate([filmholderx,y+frameimagey,framehookh-0.01]) cube([filmholderl,frameimagew,filmh+0.02]);
      hull() {
	translate([filmholderx,y+frameimagey,framehookh+0.5+ztolerance-0.01]) cube([filmholderl,frameimagew,0.1]);
	translate([filmholderx-filmh*0.7,y-filmh*0.7+frameimagey,thickness+0.01]) cube([filmholderl+2*filmh*0.7,frameimagew+2*filmh*0.7,0.1]);
      }

      if (hooks) {
	for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl]) {
	  for (xx=[x-holewidth:holedistance:(x+framel > filmholderx + filmholderl) ? length - 2*holedistance : x + framel]) {
	    translate([xx+holeoffset-xhookholetolerance,y+holefromoutw-yhookholetolerance,framehookh]) tappi(framehookx+xhookholetolerance*2,tappiw+yhookholetolerance*2,tappih+tappiztolerance,0,hookcornerd,tappitypefemale,0);
	  
	    translate([xx+holeoffset-xhookholetolerance,y+framew-holefromoutw-tappiw-yhookholetolerance,framehookh]) tappi(framehookx+xhookholetolerance*2,tappiw+yhookholetolerance*2,tappih+tappiztolerance,0,hookcornerd,tappitypefemale,0);
	  }
	}
      }

      translate([textxposition,y+framew/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    }
  }

  translate([0,filmholdery+framew/2-clipwidth/2,0]) cube([clipx,clipwidth,framehookh+cornerd+ztolerance]);
  translate([clipx,filmholdery+framew/2-clipwidth/2,0]) triangle(clipdepth,clipwidth,cliph/2,1);
  translate([clipx,filmholdery+framew/2-clipwidth/2,cliph/2]) triangle(clipdepth,clipwidth,cliph/2,2);

  translate([length-clipx,filmholdery+framew/2-clipwidth/2,0]) cube([clipx,clipwidth,framehookh+cornerd+ztolerance]);
  translate([length-clipx-clipdepth,filmholdery+framew/2-clipwidth/2,0]) triangle(clipdepth,clipwidth,cliph/2,3);
  translate([length-clipx-clipdepth,filmholdery+framew/2-clipwidth/2,cliph/2]) triangle(clipdepth,clipwidth,cliph/2,0);

  for (y=[filmholdery:filmholderoffset:filmholdery]) {
    for (clipx=[filmholderx+framestart:sideclipdistance:filmholderx+filmholderl-sideclipwidth-1]) {
      // Right clip
      translate([clipx,y-sideclipy-sideclipytolerance-sideclipysink,coverh]) cube([sideclipwidth,sideclipy+sideclipspace+sideclipysink-sideclipytolerance+cornerd,thickness-coverh]);
      translate([clipx,y-sideclipy-sideclipytolerance-sideclipysink,0]) cube([sideclipwidth,sideclipy,thickness]);
      translate([clipx,y-sideclipytolerance-sideclipysink,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,8);
      translate([clipx,y-sideclipytolerance-sideclipysink,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,10);

      // Left clip
      translate([clipx+sideclipoffset,y+framew-sideclipytolerance-cornerd,coverh]) cube([sideclipwidth,sideclipy+sideclipspace+sideclipysink-cornerd,thickness-coverh]);
      translate([clipx+sideclipoffset,y+framew+sideclipysink+sideclipytolerance,0]) cube([sideclipwidth,sideclipy,thickness]);
      translate([clipx+sideclipoffset,y+framew+sideclipysink-sideclipdepth+sideclipytolerance,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,11);
      translate([clipx+sideclipoffset,y+framew+sideclipysink-sideclipdepth+sideclipytolerance,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,9);
    }
  }
}

if (print==0) {
  difference() {
    union() {
      scanadapter();
      scancover();
    }

    if (testcuts) {
      translate ([10,filmholdery+framew/2,-0.01]) cube([13,width-filmholdery-framew/2+1,thickness+1]);//filmholdery+framew/2+1
      translate ([-0.01,-0.01,-0.01]) cube([12+20,filmholdery+framew/2+1,thickness+1]);
      translate ([length-12-20,-0.01,-0.01]) cube([12+20+0.02,filmholdery+framew/2+1,thickness+1]);
    }
  }
 }

if (print==1) {
  scanadapter();
  //  translate([0,width+holdertotalw+filmholdery+1,+thickness]) rotate([0,180,180]) scancover();
 }

if (print==2) {
  for (y=[filmholdery:filmholderoffset:width-filmholdery]) {
    translate([0,y,thickness]) rotate([0,180,180]) scancover();
  }
 }

if (print==3) {
  scanadapter();
  translate([0,width+filmholdery + holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
  if (filmstrips > 1) {
    translate([0,width+filmholdery + 2*holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
    if (filmstrips==4) {
    translate([0,width+filmholdery + 3*holdertotalw+1,+thickness]) rotate([0,180,180]) scancover();
    }
      translate([filmholdery-sideclipysink-sideclipy-sideclipspace-(adhesion?3.5:0),length,thickness]) rotate([0,180,90]) scancover();
  }
 }

if (print==4) {
  intersection() {
    scanadapter();
    translate([adapteroffset-17+adapterdistance,-adapterw-adapterattachy-1,0]) cube([adapterl+18,adapterw+adapterattachy+1+7+25,thickness+5]);
  }
 }

if (print==5) {
  intersection() {
    scanadapter();
    translate([adapteroffset-17+adapterdistance,-adapterw-adapterattachy-1,0]) cube([adapterl+18,adapterw+adapterattachy+0.9,thickness+5]);
  }
 }
