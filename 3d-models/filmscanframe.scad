// glassless film holder for Epson V850 pro

use <hsu.scad>;

filmtype=46; //35; //46; //35; // 35mm or 46

filmshrunksize=149;
filmshouldbesize=150; // Observed on kodak film
filmshrink=filmshrunksize/filmshouldbesize;
filmshrinktext=str(floor(10000*(filmshouldbesize-filmshrunksize)/filmshouldbesize)/100,"%");
//echo(filmshrinktext);

print=0; // 1 = print film frame, 2 print 1 cover set, 2 = print covers for all film frames, 3 = print one whole set, 4 print attachment test
debug=0; // 1 just one strip, 2 smallest possible
tappitypemale=1; // 0 = rounded cube, 1 = circular
tappitypefemale=1; // 0 = rounded cube, 1 = circular
filmstrips=((debug>0) || (print==5))?1:((filmtype==35)?4:3);
detachable_epson_bits=1;
testcuts=0; // Cutouts to reveal clip structures.
adhesion=print>0?0:0; // Adds some structures to increase bed adhesion.
tassusizelarge=10;
tassusizesmall=5;
antiwarp=0;

hooks=0;//((filmtype==35) ?1:0);
starthooksonly=1; // Only make hooks for first frame or so
frameseparators=((filmtype==35) && (hooks==1))?0:1;

v="V1.31";
versiontext=debug?str(v, "-", debug):v;

copyrighttext="© Heikki Suonsivu CC-BY-NC-SA";
  
textdepth=1;
textsize=6;
textxposition=textsize/6;
copyrighttextsize=5;

wall=textdepth+1;

cornerd=0.3;

xtolerance=0.4;
ytolerance=0.5;
xhookholetolerance=0.5;
yhookholetolerance=0.5;//30;
ztolerance=0.3;
tappiztolerance=0.35;

length=(debug==2)?90:(debug==1)?225:((filmtype==35)?230:230);
thickness=5; // Thickness.

holeoutsidew=(filmtype==35)?30.8:42; //8;
framew=(filmtype==35)?35.1:46.1;//35.8;//5;
holefromoutw=(framew-holeoutsidew)/2;

holedistance=38/8;

holewidth=1.6; // Width of film holes. Actual 2.2.
holew=(filmtype==35)?holewidth:2; //2;//(holeoutsidew - holeinsidew)/2-0.9;
holeoffset=(4-holewidth)/2;
tappiw=holew;//+0.1;

holeinsidew=holeoutsidew-2*holew; //25.3;
framel=(filmtype==35)?36:44;
framegap=2;

frameimagew=(filmtype==35) ? 24.6 : 45.5; //26.5;//.3; // holeinsidew+0.4;
frameimagey=framew/2-frameimagew/2;
//echo(frameimagey,framew,frameimagew);

filmholdery=(filmtype==35)?31:31;
filmholderx=10;
filmthickness=0.12; // was 0.2, 0.12 measured
// frame starts at hole, new frame every 8 holes.

filmh=2-filmthickness/2; // Position of the film above the glass

framehookx=holewidth;//*0.9; // 0.9 compensate 3d printer inaccuracy
framehookh=thickness-filmh-filmthickness;
coverthickness=thickness-filmh; // Thing above the film
coverh=thickness-filmh;
framehooktoph=thickness;
framehooky=2+holew;
hookcornerd=1.5;
filmheight=coverh-filmthickness;

tappih=min(thickness - framehookh,1.5);//framehookh - 0.5;

// First frame start
framestart=1;

frameseparator=0.8; //1.2; // 2 mm minus tolerance
frameseparatoroffset=(2-frameseparator)/2;
framedistance=((filmtype==35)?38:45)*filmshrink;

// Openings widened toward scanning glass to reduce reflections
framewidenedw=frameimagew+filmh*0.7*2;
framewidenedy=framew/2-framewidenedw/2;

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
adapterattachx=18;
adapterattachd=adapterattachy-0.5;
adapterattachxin=3;
adapterattachxtolerance=0.14; // 25;
adapterattachytolerance=0.14; // 15;
adapterattachdtolerance=0.10;
adapterattachdxoffset=0.5;
adapteraxlesink=0.5;
adapteraxled=thickness-adapterh-ztolerance;
adapteraxledepth=2;
adapteraxleheight=adapterh+adapteraxled/2+ztolerance;
dtolerance=0.7;
adapterattachyoffset=1;

filmholderl=length-filmholderx*2;
filmholdergap=8.4;//3.7;//4;
filmholderoffset=framew+filmholdergap;

filmw=filmtype==35?35:46;

filmedgecover=filmtype==35?0:(filmw-frameimagew)/2;
//echo("filmedgecover ", filmedgecover);

guidew=22;
guidel=framedistance-frameseparator;
guideh=wall;
guidey=2;
guidex=adapteroffset+adapterdistance-wall-guidel;
  
lightenholeystart=7;
lightenholexstart=filmholderx;
lightenholexend=adapteroffset+adapterdistance-wall-adapterl-wall-guidel-wall-1;
lightenholes=floor((lightenholexend-lightenholexstart)/24);
lightenholestep=(lightenholexend-lightenholexstart)/lightenholes;
lightenholey=17; //filmholdery*0.63;
lightenholexoffset=2.5;
lightenholex=lightenholestep-lightenholexoffset;

rolldiameter=100;

width=filmholdery+filmstrips*(framew+filmholdergap)+1.5;//(debug==2)?67:(debug==1)?72:181;//218;

clipdepth=0.6;
cliph=2;
clipz=1;
clipx=1.2;
clipdistance=20;
clipwidth=20;
clipxtolerance=0.30;
clipytolerance=0.5;

sideclipdepth=0.7;
sidecliph=2;
sideclipz=1;
sideclipy=1.2;
sideclipdistance=20;
sideclipwidth=7;
sideclipspace=1.5;
sideclipoffset=10; // between right and left side.
sideclipysink=2.2;//1;
sideclipxtolerance=0.50;
sideclipytolerance=0.30; //0.45; //55

holdertotalw=framew+sideclipysink+ytolerance+sideclipy;

//covertopw=framew+1.6;
covertopw=framew+7.5;
covertoph=1-filmthickness;

filml=framedistance*(filmtype==35?5:4)+2;
filmsprocketdistancew=filmtype==35?25.17:42; //24.89;
filmsprocketl=1.854;
filmsprocketw=filmtype==35?2.794:1;
filmsprocketcornerd=0.4;
filmframel=filmtype==35?36:40;
filmframew=filmtype==35?24.5:40;//25.0;
filmframecornerd=3;
filmsprocketfromedge=(filmw-filmsprocketdistancew-filmsprocketw*2)/2;
//echo(filmsprocketfromedge);

module filmstrip() {
  h=thickness-filmh-filmthickness;
  yy=filmholdery+framew/2-filmw/2;
  difference() {
    union() {
      translate([filmholderx+framestart,yy,h]) cube([filml,filmw,filmthickness]);

      for (x=[filmholderx+framestart+(filmtype==35?0.35:2):framedistance:filmholderx+framestart+filml-2]) {
	color("green") translate([x+1,yy+filmw/2-filmframew/2,h]) roundedboxxyz(filmframel,filmframew,filmthickness,filmframecornerd,0,0,30);
      }
    }
    if (filmw==35) {
      for (x=[filmholderx+framestart+1:holedistance:filmholderx+framestart+filml-2]) {
	for (y=[yy+filmw/2-filmsprocketdistancew/2-filmsprocketw,yy+filmw/2+filmsprocketdistancew/2]) {
	  	  translate([x,y,h-0.01]) roundedboxxyz(filmsprocketl,filmsprocketw,filmthickness+0.02,filmsprocketcornerd,0,0,30);
	}
      }
    }
  }
}

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
    tassu(-135,tassusizesmall);
    //translate([length,0,0]) tassu(-45,10);
    translate([length,width,0]) tassu(45,tassusizesmall);
    translate([0,width,0]) tassu(135,tassusizesmall);
  }
  

  difference() {
    // Adapters
    for (x=[adapteroffset:adapterdistance:length-adapterl]) {
      debugangle=(print==0 && x>adapteroffset)?180:0;
      translate([0,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([debugangle,0,0]) translate([0,-(adapteraxled/2+adapteraxlesink),-adapteraxleheight]) {
	{
	  translate([x,-adapterw,0]) roundedbox(adapterl,adapterw+(detachable_epson_bits?-1:cornerd),adapterh,cornerd);
	  if (adhesion) {
	    translate([x,-adapterw,0]) tassu(-135,tassusizelarge);
	    translate([x+adapterl,-adapterw,0]) tassu(-45,tassusizesmall);
	    //translate([x+adapterl,-1,0]) tassu(10,10);
	    //translate([x,-1,0]) tassu(170,10);
	  }
	  translate([x+adaptertappid/2,-adapterw+adaptertappid/2,cornerd/2]) cylinder(h=adaptertappih-cornerd/2,d=adaptertappid,$fn=90);
	  if (detachable_epson_bits) {
	    translate([x+(adapterl-adapterattachx)/2,0,0]) {
	      //	    translate([adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,0]) cylinder(h=thickness,d=adapterattachd,$fn=90);
	      //	    translate([0,adapterattachyoffset,0]) roundedbox(adapterattachx,adapterattachy,thickness,cornerd);
	      translate([0,-cornerd-1,0]) cube([adapterattachx,adapteraxlesink+cornerd+1,adapterh]);
	      hull() {
		translate([0,adapteraxlesink,0]) cube([adapterattachx,adapteraxled,adapterh]);
		translate([0,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,90,0]) cylinder(d=adapteraxled,h=adapterattachx,$fn=30);
	      }
	      translate([adapterattachx/2,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,0,90]) onehinge(adapteraxled,adapterattachx,adapteraxledepth,0,ytolerance,dtolerance);
	      //	    translate([adapterattachx-adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,0]) cylinder(h=thickness,d=adapterattachd,$fn=90);
	    }
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
	translate([x+adaptertappid/2,adapterw-adaptertappid/2+(adapteraxled/2+adapteraxlesink)*2,h2]) cylinder(h=adaptertappih+0.02,d=adaptertappid+1,$fn=90);

	translate([x+(adapterl-adapterattachx)/2,0,0]) {
	  //	  translate([-adapterattachxtolerance+adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,-0.01]) cylinder(h=thickness/2+0.02,d=adapterattachd+adapterattachdtolerance,$fn=90);
	  //translate([adapterattachdxoffset-adapterattachxtolerance,adapterattachy/2+adapterattachyoffset,thickness/2]) cylinder(h=thickness/2+0.01,d1=adapterattachd+adapterattachdtolerance,d2=adapterattachd+adapterattachdtolerance*3,$fn=90);
	  //#	  translate([-adapterattachxtolerance,-0.01,-0.01]) cube([adapterattachx+adapterattachxtolerance*2,thickness+adapterattachy+adapterattachyoffset+adapteraxlesink+0.01,thickness+0.02]);
	  translate([-adapterattachxtolerance,-0.01,-0.01]) cube([adapterattachx+adapterattachxtolerance*2,adapteraxled+adapteraxlesink+dtolerance/2+0.01,thickness+0.02]);
	  //translate([adapterattachx+adapterattachxtolerance-adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,-0.01]) cylinder(h=thickness/2+0.02,d=adapterattachd+adapterattachdtolerance,$fn=90);
	  //translate([adapterattachx+adapterattachxtolerance-adapterattachdxoffset,adapterattachy/2+adapterattachyoffset,thickness/2]) cylinder(h=thickness/2+0.01,d1=adapterattachd+adapterattachdtolerance,d2=adapterattachd+adapterattachdtolerance*3,$fn=90);
	  translate([adapterattachx/2,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,0,90]) onehinge(adapteraxled,adapterattachx,adapteraxledepth,1,ytolerance,dtolerance);
	}
      }
    }

    // Film openings
    for (y=[filmholdery:filmholderoffset:width-filmholdery]) {
      // Open slits in sides to let scanner see film type and bar codes
      if (filmtype==35) {
	for (yy=[y+framew/2-filmw/2,y+framew/2+filmw/2-filmsprocketfromedge]) {
	  translate([filmholderx,yy,-0.01]) cube([filmholderl,filmsprocketfromedge,thickness-filmh+0.02]);
	}
      }
      
      // Widen cover at top
      difference() {
  	//translate([-0.1,y+framew/2-covertopw/2-ytolerance,thickness-covertoph-ztolerance]) cube([length+0.2,covertopw+ytolerance*2,covertoph+ztolerance+0.1]);
		translate([-0.1,y+framew/2-covertopw/2-ytolerance,filmheight]) cube([length+0.2,covertopw+ytolerance*2,thickness-filmheight+0.01]);

	// Vertical support for film to drop neatly in place.
	translate([filmholderx+framestart,y,filmheight]) {
	  hull() {
	    translate([xtolerance,-ytolerance/2-(thickness-filmheight),0]) triangle(filmholderl-framestart-xtolerance*2,thickness-filmheight,thickness-filmheight,11);
	    translate([xtolerance,0,0]) cube([filmholderl-framestart-xtolerance*2,ytolerance,thickness-filmheight]);
	  }
	  hull() {
	    translate([xtolerance,framew+ytolerance/2,0]) triangle(filmholderl-framestart-xtolerance*2,thickness-filmheight,thickness-filmheight,8);
	    translate([xtolerance,framew-ytolerance,0]) cube([filmholderl-framestart-xtolerance*2,ytolerance,thickness-filmheight]);
	  }
	}
      }
      
      // Frame separator cuts
      for (y=[filmholdery:filmholderoffset:width-filmholdery]) {
	if (frameseparators) {
	  for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance]) {
	    //	    translate([x-xtolerance,y+framew/2-covertopw/2,thickness-covertoph]) roundedbox(frameseparator+xtolerance*2,covertopw,covertoph,cornerd);
	    translate([x-xtolerance,y+framew/2-covertopw/2,framehookh]) cube([frameseparator+xtolerance*2,covertopw,thickness-framehookh]);
	    //translate([x,y-filmh*0.7+frameimagey,coverh]) cube([frameseparator,frameimagew+2*filmh*0.7,thickness-coverh]);
	  }
	}
      }
	
      // End clip cuts
      translate([-0.01,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipx+clipxtolerance+0.02,clipwidth+clipytolerance*2,framehookh+0.02]);
      translate([clipx+clipxtolerance-0.01,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02]);
      translate([clipx+clipxtolerance-0.01,y+framew/2-clipwidth/2-clipytolerance,cliph/2-0.01]) triangle(clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02,2);

      translate([length-clipx-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipx+clipxtolerance+0.01,clipwidth+clipytolerance*2,framehookh+0.02]);
      translate([length-clipx-clipdepth-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,-0.01]) cube([clipdepth+0.01,clipwidth+clipytolerance*2,cliph/2+0.02]);
      translate([length-clipx-clipdepth-clipxtolerance,y+framew/2-clipwidth/2-clipytolerance,cliph/2-0.01]) triangle(clipdepth+0.02,clipwidth+clipytolerance*2,cliph/2+0.02,0);

      // Side clip cut
      for (clipx=[filmholderx+framestart:sideclipdistance:filmholderx+framestart+filmholderl-sideclipdistance]) {
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
    for (y=[lightenholeystart]) {
      for (x=[lightenholexstart:lightenholestep:lightenholexend]) { //filmholderx+filmholderl-framedistance*2
	translate([x,y,-0.1]) cube([lightenholex,lightenholey,thickness+0.2]);
      }
    }

    // Orientation help
    translate([guidex,guidey,guideh]) cube([guidel,guidew,thickness-guideh+0.1]);

    translate([textxposition,filmholdery/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");

    translate([guidex+guidel/2,guidey+2+textsize/2,guideh-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text("Top", size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([guidex+guidel/2,guidey+guidew-2-textsize/2,guideh-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text(filmshrinktext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([adapteroffset+adapterl+1,lightenholeystart/2,thickness-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="right",font="Liberation Sans:style=Bold");
  }

  // Frame separators
  for (y=[filmholdery:filmholderoffset:width-filmholdery]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance]) {
	translate([x,y+framewidenedy-cornerd/2,0]) cube([frameseparator,framewidenedw+cornerd,framehookh]);
	//	translate([x,y+framew/2-covertopw-cornerd/2,0]) cube([frameseparator,covertopw-cornerd,framehookh]);
	//		translate([x,y-filmh*0.7+frameimagey,0]) cube([frameseparator,frameimagew+2*filmh*0.7,framehookh]);
      }
    }
    
    if (hooks) {
      // Hooks
      for (x=[filmholderx+framestart:framedistance:filmholderx+(starthooksonly?filmholderx+framestart:filmholderl)]) {
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
    translate([0,filmholdery+ytolerance,thickness]) mirror([0,0,1]) tassu(-135,tassusizesmall);
    translate([length,filmholdery+ytolerance,thickness]) mirror([0,0,1]) tassu(-45,tassusizesmall);
    translate([length,filmholdery+ytolerance+framew-2*ytolerance,thickness]) mirror([0,0,1]) tassu(45,tassusizesmall);
    translate([0,filmholdery+ytolerance+framew-2*ytolerance,thickness]) mirror([0,0,1]) tassu(135,tassusizesmall);
  }
  
  // Frame separators
  for (y=[filmholdery:filmholderoffset:filmholdery]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance]) {
	//	translate([x,y+framew/2-covertopw/2,thickness-covertoph]) roundedbox(frameseparator,covertopw,covertoph,cornerd);
	translate([x,y+framew/2-covertopw/2+cornerd/2,coverh]) cube([frameseparator,covertopw-cornerd,thickness-coverh]);
	//translate([x,y-filmh*0.7+frameimagey,coverh]) cube([frameseparator,frameimagew+2*filmh*0.7,thickness-coverh]);
      }
    }
  }
  
  difference() {
    union() {
      translate([0,filmholdery+ytolerance,coverh]) roundedbox(length,framew-2*ytolerance,thickness-coverh,cornerd);
      translate([0,filmholdery+framew/2-covertopw/2,coverh]) roundedbox(length,covertopw,thickness-coverh,cornerd);
    }

    // Vertical support for film to drop neatly in plade.
    translate([filmholderx+framestart,filmholdery,filmheight]) {
      hull() {
	translate([0,-ytolerance-(thickness-filmheight),0]) triangle(filmholderl-framestart,thickness-filmheight,thickness-filmheight,11);
	translate([0,0,0]) cube([filmholderl-framestart,ytolerance,thickness-filmheight]);
      }

      hull() {
	translate([0,framew+ytolerance,0]) triangle(filmholderl-framestart,thickness-filmheight,thickness-filmheight,8);
	translate([0,framew-ytolerance,0]) cube([filmholderl-framestart,ytolerance,thickness-filmheight]);
      }
    }
 
    if (filmtype==35)    for (y=[filmholdery+framew/2-filmw/2,filmholdery+framew/2+filmw/2-filmsprocketfromedge]) {
	translate([filmholderx,y,thickness-filmh-0.01]) cube([filmholderl,filmsprocketfromedge,filmh+0.02]);
    }
      
    for (y=[filmholdery:filmholderoffset:filmholdery]) {
      translate([filmholderx,y+frameimagey,framehookh-0.01]) cube([filmholderl,frameimagew,filmh+0.02]);
      hull() {
	//narrowing=filmtype==35?filmh*0.7:0;
	narrowing=filmh*0.7;
	translate([filmholderx,y+frameimagey,framehookh+0.5+ztolerance-0.01]) cube([filmholderl,frameimagew,0.2]);
	translate([filmholderx-narrowing,y-narrowing+frameimagey,thickness+0.01]) cube([filmholderl+2*narrowing,frameimagew+2*narrowing,0.2]);
      }

      if (hooks) {
	for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl]) {
	  for (xx=[x-holewidth:holedistance:(x+framel > filmholderx + filmholderl) ? length - 2*holedistance : x + framel]) {
	    translate([xx+holeoffset-xhookholetolerance/2,y+holefromoutw-yhookholetolerance/2,framehookh]) tappi(framehookx+xhookholetolerance,tappiw+yhookholetolerance,tappih+tappiztolerance,0,hookcornerd,tappitypefemale,0);
	  
	    translate([xx+holeoffset-xhookholetolerance,y+framew-holefromoutw-tappiw-yhookholetolerance/2,framehookh]) tappi(framehookx+xhookholetolerance,tappiw+yhookholetolerance,tappih+tappiztolerance,0,hookcornerd,tappitypefemale,0);
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
    for (clipx=[filmholderx+framestart:sideclipdistance:filmholderx+framestart+filmholderl-sideclipdistance]) {
      // Right clip
      //color("red") translate([clipx-10,y-1,0]) cube([10,1,thickness]);
      translate([clipx,y-sideclipy-sideclipysink-sideclipytolerance,coverh]) cube([sideclipwidth,sideclipy+sideclipysink+sideclipytolerance+(framew/2-filmw/2)+filmedgecover,thickness-coverh]);
      translate([clipx,y-sideclipy-sideclipytolerance-sideclipysink,0]) cube([sideclipwidth,sideclipy,thickness]);
      translate([clipx,y-sideclipytolerance-sideclipysink,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,8);
      translate([clipx,y-sideclipytolerance-sideclipysink,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,10);

      // Left clip
      //color("red") translate([clipx-10,y+framew,0]) cube([10,1,thickness]);
      translate([clipx+sideclipoffset,y+filmw+(framew/2-filmw/2)-filmedgecover,coverh]) cube([sideclipwidth,sideclipy+sideclipysink+sideclipytolerance+(framew/2-filmw/2)+filmedgecover,thickness-coverh]);
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
	   //	   #color("red") filmstrip();
	   translate([0,filmholderoffset,0]) scancover();
      //#      translate([0,filmholderoffset,0]) color("red") filmstrip();
      //#      translate([0,filmholderoffset*2,0]) color("red") filmstrip();
    }

    if (testcuts) {
      translate ([10,filmholdery+framew/2,-0.01]) cube([13,width-filmholdery-framew/2+1,thickness+1]);//filmholdery+framew/2+1
      translate ([52.2,framew/2,-0.01]) cube([50,width-filmholdery-framew/2+1,thickness+1]);//filmholdery+framew/2+1
      translate ([-0.01,-0.01,-0.01]) cube([12+20-0.02,filmholdery+framew+framegap+10,thickness+1]);
      translate ([length-12-15,-0.01,-0.01]) cube([12+20+0.02,filmholdery+framew/2+1,thickness+1]);
      translate ([length/2+38,filmholderoffset-5.5,-0.01]) cube([12+20+0.02,filmholdery+framew/2+1,thickness+1]);
      translate ([length/2,filmholderoffset-8,-0.01]) cube([12+20+0.02,framew-1,thickness+1]);
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
  if (antiwarp) {
    antiwarpwall(0,-adapterw,0,length,width+adapterw+filmholderoffset+sideclipy+sideclipysink,thickness+2,1,0.8);
  }
  scanadapter();

  translate([0,width+filmholdery + holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
 }

if (print==6) {
  intersection() {
    scanadapter();
    #scancover();
  }
 }
