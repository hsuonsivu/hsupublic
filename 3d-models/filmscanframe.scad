// glassless film holder for Epson V850 pro

// TODO:
// Major cleanup of old stuff. Some fixes, but obsolete stuff and spaghetti still there
// Narrow framew to filmw, as 35mm film seems to fit fine due to shrinkage -- ok for 35, 46 under testing

use <hsu.scad>;

filmtype=46; // 110 //35; //46; //35; // 35mm or 46

filmshrunksize=149;
filmshouldbesize=150; // Observed on kodak film
filmshrink=filmshrunksize/filmshouldbesize;
filmshrinktext=str(floor(10000*(filmshouldbesize-filmshrunksize)/filmshouldbesize)/100,"%");
//echo(filmshrinktext);

print=0; // 1 = print film frame, 2 print 1 cover set, 2 = print covers for all film frames, 3 = print one whole set, 4 print attachment test
debug=0; // 1 just one strip, 2 smallest possible
tappitypemale=1; // 0 = rounded cube, 1 = circular
tappitypefemale=1; // 0 = rounded cube, 1 = circular
filmstrips=((debug>0) || (print==5))?1:(filmtype==110?7:((filmtype==35)?4:3));
detachable_epson_bits=1;
testcuts=0; // Cutouts to reveal clip structures.
adhesion=print>0?0:0; // Adds some structures to increase bed adhesion.
tassusizelarge=10;
tassusizesmall=5;
antiwarp=0;

//starthooksonly=1; // Only make hooks for first frame or so
frameseparators=1;//((filmtype==35 || filmtype==110) && (hooks==1))?0:1;

v="V1.39";
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

filmw=filmtype==110?16:(filmtype==35?35:45.9); // Actual width of physical film should be exact but seems that films shrink

framew=filmw; //(filmtype==35)?35:46;

holedistance=filmtype==35?38/8:(filmtype==110?25:0);

//holewidth=1.6; // Width of film holes. Actual 2.2.

framel=(filmtype==35)?36:(filmtype==110?17:(filmtype==46?44:0));
framegap=2;

// Width of image data (for 46mm film this is expanded close to film
// width, as the pictures are not framed exactly and we want to scan
// film type codes in the sides. For 35mm side data is scanned through
// side slits so this does not need to be that accurate.

frameimagew=(filmtype==35) ? 24.6 : (filmtype==46 ? filmw-0.5 : (filmtype==110 ? filmw-0.5 : 0)); // 110 was 13
frameimagey=framew/2-frameimagew/2;
//echo(frameimagey,framew,frameimagew);

filmholdery=31;//(filmtype==35)?31:31;
filmholderx=10;
filmthickness=0.18; // was 0.2, 0.12 measured - note needs to have some slack due to tolerance issues
// frame starts at hole, new frame every 8 holes.

filmh=2-filmthickness/2; // Position of the film above the glass

//framehookx=holewidth;//*0.9; // 0.9 compensate 3d printer inaccuracy
framehookh=thickness-filmh-filmthickness;
coverthickness=thickness-filmh; // Thing above the film
coverh=thickness-filmh;
//framehooktoph=thickness;
//framehooky=2+holew;
//hookcornerd=1.5;
filmheight=coverh-filmthickness;

//tappih=min(thickness - framehookh,1.5);//framehookh - 0.5;

// First frame start
framestart=1;

frameseparator=0.8; //1.2; // 2 mm minus tolerance
frameseparatoroffset=(2-frameseparator)/2;
framedistance=(filmtype==110 ? 25 : ((filmtype==35)?38:46)*filmshrink);

// Openings widened toward scanning glass to reduce reflections
framewidenedw=frameimagew+((filmtype==35 || filmtype==110)?filmh*0.7*2:0);
//framewidenedw=frameimagew+filmh*0.7*2;
//framewidenedw=frameimagew+(filmtype==35?filmh*0.7*2:0);
framewidenedy=framew/2-framewidenedw/2;

// Make small support notches for 46mm
framesidesupportwidening=1.0; //0.8;
framesidesupportw=(filmtype==35?0:frameimagew-framesidesupportwidening);
framesidesupportdistance=framedistance/4;

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

filmwidenedw=filmw+(filmtype==35?0:filmh*0.7*2);
filmwidenedy=framew/2-filmwidenedw/2;

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

sideclipsperframe=filmtype==110?1:2;
sideclipxtolerance=0.50;
sideclipdepth=0.7;
sidecliph=2;
sideclipgap=1+sideclipxtolerance*2;
sideclipz=1;
sideclipy=1.2;
sideclipwidth=6;
sidecliparea=framedistance-frameseparator;
//sideclipdistance=(framedistance-framegap-frameseparator)/sideclipsperframe;
sideclipsl=sideclipwidth*2+sideclipgap;
sideclipsgapx=sidecliparea-sideclipsl*sideclipsperframe-sideclipsl/2;
sideclipsgap=sideclipsgapx<1+sideclipxtolerance*2?sideclipgap:sideclipsgapx;
//echo("sideclipsl", sideclipsl,"sideclipsgap", sideclipsgap);
sideclipsalll=sideclipsl*sideclipsperframe+sideclipsgap*(sideclipsperframe-1);
sideclipdistance=sideclipsl+sideclipsgap;
//echo("sideclipdistance",sideclipdistance);
//sideclipsl=sideclipwidth*(2*sideclipsperframe)+sideclipgap*(2*sideclipsperframe-1);
//echo(sideclipwidth,sideclipdistance);
sideclipspace=1.5;
sideclipoffset=sideclipwidth+sideclipgap; // sideclipdistance/sideclipsperframe; //10; // between right and left side.
sideclipysink=2.2;//1;
sideclipytolerance=0.30; //0.45; //55
//sideclipstart=filmholderx+framestart+framegap+1;//+sideclipdistance/2;
sideclipstart=frameseparator+sidecliparea/2-sideclipsalll/2;//+sideclipdistance/2;
//echo(framedistance, framegap, frameseparator, sideclipwidth, sideclipgap,"sideclipstart", sideclipstart);
sideclipend=filmholderx+framestart+filmholderl-sideclipdistance-framestart-2;
  
holdertotalw=framew+sideclipysink+ytolerance+sideclipy;

//covertopw=framew+1.6;
covertopwiden=7.5;
covertopw=framew+covertopwiden;
covertoph=1-filmthickness;

filmframew=filmtype==110?13:filmtype==35?24.5:40;//25.0;
filmsprocketoneside=filmtype==110?1:0;
filmframefromedge=filmtype==110?filmw-1.9-filmframew:filmw/2-filmframew/2;
filml=framedistance*(filmtype==110?7:(filmtype==35?5:4))+2;
filmsprocketdistancew=filmtype==110?0.8:(filmtype==35?25.17:42); //24.89;
filmsprocketl=filmtype==110?2.5:1.854;
filmsprocketw=filmtype==110?1.75:filmtype==35?2.794:1;
filmsprocketcornerd=0.4;
filmframel=filmtype==110?17:filmtype==35?36:40;
filmframecornerd=3;
filmsprocketfromedge=filmtype==110?filmsprocketdistancew:(filmw-filmsprocketdistancew-filmsprocketw*2)/2;
//echo(filmsprocketfromedge);

module filmstrip() {
  h=thickness-filmh-filmthickness;
  yy=filmholdery+framew/2-filmw/2;
  difference() {
    union() {
      translate([filmholderx+framestart,yy,h]) cube([filml,filmw,filmthickness]);

      for (x=[filmholderx+framestart+(filmtype==35?0.35:filmtype==110?5:2):framedistance:filmholderx+framestart+filml-2]) {
	color("green") translate([x+1,yy+filmframefromedge,h]) roundedboxxyz(filmframel,filmframew,filmthickness,filmframecornerd,0,0,30);
      }
    }
    if (filmtype==35) {
      for (x=[filmholderx+framestart+1:holedistance:filmholderx+framestart+filml-2]) {
	for (y=[yy+filmw/2-filmsprocketdistancew/2-filmsprocketw,yy+filmw/2+filmsprocketdistancew/2]) {
	  	  translate([x,y,h-0.01]) roundedboxxyz(filmsprocketl,filmsprocketw,filmthickness+0.02,filmsprocketcornerd,0,0,30);
	}
      }
    }

    if (filmtype==110) {
      for (x=[filmholderx+framestart+1:holedistance:filmholderx+framestart+filml-2]) {
	for (y=[yy+filmw-filmsprocketdistancew-filmsprocketw]) {
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
	  translate([-adapterattachxtolerance,-0.01,-0.01]) cube([adapterattachx+adapterattachxtolerance*2,adapteraxled+adapteraxlesink+dtolerance/2+0.01,thickness+0.02]);
	  translate([adapterattachx/2,adapteraxled/2+adapteraxlesink,adapteraxleheight]) rotate([0,0,90]) onehinge(adapteraxled,adapterattachx,adapteraxledepth,1,ytolerance,dtolerance);
	}
      }
    }

    // Film openings
    for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
      // Open slits in sides to let scanner see film type and bar codes
      if (filmtype==35) {
	for (yy=[y+framew/2-filmw/2,y+framew/2+filmw/2-filmsprocketfromedge]) {
	  translate([filmholderx,yy,-0.01]) cube([filmholderl,filmsprocketfromedge,thickness-filmh+0.02]);
	}
      }
      
      // Widen cover at top
      difference() {
	translate([-0.1,y+framew/2-covertopw/2-ytolerance,filmheight]) cube([length+0.2,covertopw+ytolerance*2,thickness-filmheight+0.02]);

	// Vertical support for film to drop neatly in place
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
      for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
	if (frameseparators) {
	  for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance]) {
	    translate([x-xtolerance,y+framew/2-covertopw/2,framehookh]) cube([frameseparator+xtolerance*2,covertopw,thickness-framehookh]);
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
      for (clipxx=[filmholderx+framestart:framedistance:sideclipend]) {
	// echo(clipxx,sideclipend,filmholderl);
	for (clipx=[clipxx+sideclipstart:sideclipdistance:clipxx+sideclipstart+sideclipdistance*(sideclipsperframe-1)+1]) {
	  if (clipx < sideclipend) {

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
	}
      }

      // Film opening cut
     translate([filmholderx,y+frameimagey,-0.1]) cube([filmholderl,frameimagew,framehookh+0.2]);
      hull() {
	narrowing=(filmtype==35?filmh*0.7:0);
	translate([filmholderx,y+frameimagey,framehookh-0.6]) cube([filmholderl,frameimagew,0.1]);
	translate([filmholderx-filmh*0.7,y-narrowing+frameimagey,-0.01]) cube([filmholderl+2*filmh*0.7,frameimagew+narrowing*2,0.01]);	
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

    translate([textxposition,filmholdery/2-covertopwiden/2/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="bottom",halign="center",font="Liberation Sans:style=Bold");

    translate([guidex+guidel/2,guidey+2+textsize/2,guideh-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text("Top", size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([guidex+guidel/2,guidey+guidew-2-textsize/2,guideh-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text(filmshrinktext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([adapteroffset+adapterl+1,lightenholeystart/2,thickness-textdepth+0.01])  rotate([0,0,180]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="right",font="Liberation Sans:style=Bold");
  }

  // Frame separators
  for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
    if (frameseparators) {
      for (x=[filmholderx+framestart:framedistance:filmholderx+filmholderl-framedistance]) {
	translate([x,y+filmwidenedy-cornerd/2,0]) cube([frameseparator,filmwidenedw+cornerd,framehookh]);
      }
    }

    // Frame side supports
    if (0) { //filmtype==46) {
      for (x=[filmholderx+framestart:framesidesupportdistance:filmholderx+filmholderl-framesidesupportdistance]) {
	hull() {
	  translate([x,y-cornerd/2,framehookh-0.1]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
	  translate([x,y-cornerd/2,framehookh/2]) cube([frameseparator,cornerd/2,framehookh/2]);
	}
	hull() {
	  translate([x,y+filmw-framesidesupportwidening,framehookh-0.1]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
	  translate([x,y+filmw,framehookh/2]) cube([frameseparator,cornerd/2,framehookh/2]);
	}
      }
    }
  }

  for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
    for (clipxx=[filmholderx+framestart:framedistance:filmholderx+filmholderl]) {
      for (clipx=[clipxx+sideclipstart:sideclipdistance:clipxx+sideclipstart+sideclipdistance*(sideclipsperframe-1)+1]) {
	if (clipx < sideclipend) {
	  // Frame side supports
	  if (filmtype==46) {
	    for (xx=[clipx,clipx+sideclipwidth-frameseparator]) {
	      hull() {
		translate([xx,y-cornerd/2,framehookh-0.1]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
		translate([xx,y-cornerd/2,framehookh/2]) cube([frameseparator,cornerd/2,framehookh/2]);
	      }
	      hull() {
		translate([xx+sideclipoffset,y+filmw-framesidesupportwidening,framehookh-0.1]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
		translate([xx+sideclipoffset,y+filmw,framehookh/2]) cube([frameseparator,cornerd/2,min(coverh/2,framesidesupportwidening)]);
	      }
	    }
	  }
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
	translate([x,y+framew/2-covertopw/2+cornerd/2,coverh]) cube([frameseparator,covertopw-cornerd,thickness-coverh]);
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
	translate([0,-ytolerance-(thickness-filmheight),0]) triangle(filmholderl-framestart,thickness-filmheight,thickness-filmheight+0.01,11);
	translate([0,0,0]) cube([filmholderl-framestart,ytolerance,thickness-filmheight+0.01]);
      }

      hull() {
	translate([0,framew+ytolerance,0]) triangle(filmholderl-framestart,thickness-filmheight,thickness-filmheight+0.01,8);
	translate([0,framew-ytolerance,0]) cube([filmholderl-framestart,ytolerance,thickness-filmheight+0.01]);
      }
    }
 
    if (filmtype==35)    for (y=[filmholdery+framew/2-filmw/2,filmholdery+framew/2+filmw/2-filmsprocketfromedge]) {
	translate([filmholderx,y,thickness-filmh-0.01]) cube([filmholderl,filmsprocketfromedge,filmh+0.02]);
      }
      
    for (y=[filmholdery:filmholderoffset:filmholdery]) {
      translate([filmholderx,y+frameimagey,framehookh-0.01]) cube([filmholderl,frameimagew,filmh+0.02]);
      hull() {
	narrowing=(filmtype==35?filmh*0.7:0);
	translate([filmholderx,y+frameimagey,framehookh+0.5+ztolerance-0.01]) cube([filmholderl,frameimagew,0.2]);
	translate([filmholderx-narrowing,y-narrowing+frameimagey,thickness+0.01]) cube([filmholderl+2*narrowing,frameimagew+2*narrowing,0.2]);
      }

      translate([textxposition,y+framew/2,thickness-textdepth+0.01])  rotate([0,0,-90]) linear_extrude(height=textdepth) text(str(versiontext," ",filmshrinktext), size=filmtype==110?textsize/2:textsize-1, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    }
  }

  translate([0,filmholdery+framew/2-clipwidth/2,0]) cube([clipx,clipwidth,framehookh+cornerd+ztolerance]);
  translate([clipx,filmholdery+framew/2-clipwidth/2,0]) triangle(clipdepth,clipwidth,cliph/2,1);
  translate([clipx,filmholdery+framew/2-clipwidth/2,cliph/2]) triangle(clipdepth,clipwidth,cliph/2,2);

  translate([length-clipx,filmholdery+framew/2-clipwidth/2,0]) cube([clipx,clipwidth,framehookh+cornerd+ztolerance]);
  translate([length-clipx-clipdepth,filmholdery+framew/2-clipwidth/2,0]) triangle(clipdepth,clipwidth,cliph/2,3);
  translate([length-clipx-clipdepth,filmholdery+framew/2-clipwidth/2,cliph/2]) triangle(clipdepth,clipwidth,cliph/2,0);

  //color("blue") translate([filmholderx+framestart+frameseparator,filmholdery,0]) cube([framedistance-frameseparator,20,thickness]);
  
  for (y=[filmholdery:filmholderoffset:filmholdery]) {
    for (clipxx=[filmholderx+framestart:framedistance:filmholderx+filmholderl]) {
      //      echo("Frame x ",clipxx);
      //      echo(clipxx+sideclipstart,sideclipdistance,"min",clipxx+sideclipstart+sideclipdistance,filmholderx+filmholderl-sideclipdistance);
      //      echo(clipxx+sideclipstart,clipxx+sideclipstart+sideclipdistance);
      for (clipx=[clipxx+sideclipstart:sideclipdistance:min(clipxx+sideclipstart+sideclipdistance,sideclipend)-1]) {
	//	echo(clipxx,clipx);
	// Right clip
	translate([clipx,y-sideclipy-sideclipysink-sideclipytolerance,coverh]) cube([sideclipwidth,sideclipy+sideclipysink+sideclipytolerance+(framew/2-filmw/2)+filmedgecover,thickness-coverh]);
	translate([clipx,y-sideclipy-sideclipytolerance-sideclipysink,0]) cube([sideclipwidth,sideclipy,thickness]);
	translate([clipx,y-sideclipytolerance-sideclipysink,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,8);
	translate([clipx,y-sideclipytolerance-sideclipysink,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,10);

	// Left clip
	translate([clipx+sideclipoffset,y+filmw+(framew/2-filmw/2)-filmedgecover,coverh]) cube([sideclipwidth,sideclipy+sideclipysink+sideclipytolerance+(framew/2-filmw/2)+filmedgecover,thickness-coverh]);
	translate([clipx+sideclipoffset,y+framew+sideclipysink+sideclipytolerance,0]) cube([sideclipwidth,sideclipy,thickness]);
	translate([clipx+sideclipoffset,y+framew+sideclipysink-sideclipdepth+sideclipytolerance,sidecliph/2-0.01]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,11);
	translate([clipx+sideclipoffset,y+framew+sideclipysink-sideclipdepth+sideclipytolerance,0]) triangle(sideclipwidth,sideclipdepth,sidecliph/2,9);

	// Frame side supports
	if (filmtype==46) {
	  for (xx=[clipx,clipx+sideclipwidth-frameseparator]) {
	    hull() {
	      translate([xx,y-cornerd/2,coverh]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
	      translate([xx,y-cornerd/2,coverh+min(coverh/2,framesidesupportwidening)]) cube([frameseparator,cornerd/2,min(coverh/2,framesidesupportwidening)]);
	    }
	    hull() {
	      translate([xx+sideclipoffset,y+filmw-framesidesupportwidening,coverh]) cube([frameseparator,cornerd/2+framesidesupportwidening,0.1]);
	      translate([xx+sideclipoffset,y+filmw,coverh+min(coverh/2,framesidesupportwidening)]) cube([frameseparator,cornerd/2,min(coverh/2,framesidesupportwidening)]);
	    }
	  }
	}
      }
    }
  }
}

if (print==0) {
  difference() {
    union() {
      scanadapter();
      scancover();
      #color("red") filmstrip();
      //#translate([0,filmholderoffset,0]) scancover();
	   #translate([0,filmholderoffset,0]) filmstrip();
      //      #translate([0,filmholderoffset*2,0]) color("red") filmstrip();
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
  for (y=[filmholdery:filmholderoffset:width-filmholderoffset]) {
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
  //#translate([0,0,0]) filmstrip();

  translate([0,width+filmholdery + holdertotalw+1,thickness]) rotate([0,180,180]) scancover();
 }

if (print==6) {
  intersection() {
    scanadapter();
    #scancover();
  }
 }
