print=0;
strong=(print == 0) ? 0 : 1;
$fn=90;
tolerance=0.2; // Any narrow tolerance

versiontext="V 1.1";
// How deep text is cut
textdepth=0.8;

height=19; // Card height
//slidewidthout=57;
slidewall=1.5;
slidesupportdistance=50; // Distance between T's
slidesupportwidth=10; // width of T
slidewidthout=slidesupportdistance+slidesupportwidth+slidewall*2;
slidedepth=2.4;// 1.5+, thickness of attachment
slidethickness=2.4;// 1.5+, thickness of attachment support
slideinside=slidewidthout-2*slidesupportwidth-2*slidewall-2*slidewall;
cardwidth=80.5;
cardlength=160.5;
cardtolerance=1; // Reserve space around the card
wall=2.5;
cornerd=1;

clipwidth=15;
clipdepth=2;
clipheight=0.5;
cliptriangleheight=1;
clipcut=1;

screwlength=19;
screwholed=3.5;
screwtowerd=screwholed*3;
screwbasewall=wall+1; // must be no more than wall...

cardthickness=1.8;
backspace=2.6; // space needed below card for soldering, pins, etc
frontspace=14;
// leaves too little space for jumpers, use height
totalheight=cardthickness+backspace+frontspace;

cardholed=2.8;
cardsupportd=6;
cardtowertolerance=0.5;
towernarrow=2;

boxwidth=cardwidth+2*cardtolerance+2*wall;
boxlength=cardlength+2*cardtolerance+2*wall;
boxthickness=height+2*wall;
  
cliptable=[clipwidth,boxlength/2,boxlength-clipwidth];

holetable=[[3.3,3.3],[76.5,3.3],[72.5,56],[72.5,100.5],[3.3,cardlength-3.3],[76.5,cardlength-3.3]];

// openings on left
usbhole=7;
usbholewidth=20-7;
usbholeoffset=-2;
usbholeheight=7;
ethernethole=27;
ethernetholewidth=18;
ethernetholeoffset=0;
ethernetholeheight=frontspace;
cablehole=50;
cableholewidth=24;
cableholeoffset=0;
cableholeheight=frontspace-1;
leftholetable=[[usbhole,usbholewidth,usbholeoffset,usbholeheight],[ethernethole,ethernetholewidth,ethernetholeoffset,ethernetholeheight],[cablehole,cableholewidth,cableholeoffset,cableholeheight]];
rightholetable=[[5,33,0,frontspace-4],[cardwidth-5-33,33,0,frontspace-4]];
topholeoffsetfromright=23;
topholewidth=6.5;

countersinkheightmultiplier=0.63;
countersinkdiametermultiplier=2.4;

module ruuvireika(height,diameter,countersink) {
  $fn=90;
  cylinder(h=height,d=diameter-0.1); // Slightly smaller hole

  if (strong) {
    if (1) {
      maxd=diameter*countersinkdiametermultiplier-(diameter+0.4)+4/2;
      for (i=[0:1:maxd]) {
	di=diameter+0.4+i*2;
	// i=maxd -> 0, i=0 >diameter/3
	hfix=(maxd-i)/maxd*screwtowerd/3-0.1;
	translate([0,0,-1])
	  difference() {
	  cylinder(h=height+hfix+1-0.1,d=di+0.05,$fn=20);
	  translate([0,0,-0.01]) cylinder(h=height+hfix+1+0.02,d=di,$fn=20);
	}
      }
    } else {
      for (xx=[-2*diameter:1:2*diameter]) {
	translate([xx,-2*diameter,-1]) cube([0.05,4*diameter,height+1-0.1]);
      }
    }
  }

  if (countersink) {
    translate([0,0,height-diameter*countersinkheightmultiplier]) cylinder(h=diameter*countersinkheightmultiplier,d1=diameter,d2=diameter*countersinkdiametermultiplier);
  }
}

module ruuvitorni(height,diameter) {
  cylinder(h=height,d=diameter);
  translate([0,0,height-0.01]) cylinder(h=diameter/3,d1=diameter,d2=diameter*0.6);
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

module roundedbox(x,y,z,c) {
  corner=(c > 0) ? c : 1;
  scd = ((x < 1 || y < 1 || z < 1) ? min(x,y,z) : corner);
  f=(print > 0) ? 180 : 90;
  
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

module slidecut(x) {
    translate([x-slidesupportwidth/2,-0.01,slidewall]) cube([slidesupportwidth,boxwidth+0.02,slidedepth]);
    translate([x-slidethickness/2,-0.01,-0.01]) cube([slidethickness,boxwidth+0.02,slidewall+0.02]);
}

module clip(x,y,z,width,thickness,height,depth)
{
  translate([x-width/2,y,z]) cube([width,thickness,height+0.01]);
  translate([x-width/2,y-depth,z+height]) triangle(clipwidth,depth+thickness,depth+thickness,11);
}

module clipcut(x,y,z,width,thickness,height,depth)
{
  translate([x-width/2-clipcut,y-0.01,z]) cube([clipcut,thickness+0.02,height+0.0]);
  translate([x-width/2+width,y-0.01,z]) cube([clipcut,thickness+0.02,height+0.0]);
    //    translate([boxlength/2+clipwidth/2,boxwidth-wall-0.01,slidewall+slidedepth+wall]) cube([clipcut,wall+0.02,boxthickness-wall+0.02]);
}

module case() {
  difference() {
    union() {
      difference() {
	translate([0,0,slidewall+slidedepth]) roundedbox(boxlength,boxwidth,boxthickness,cornerd);
	translate([-0.01,-0.01,slidewall+slidedepth+wall]) cube([boxlength+0.2,boxwidth-wall+0.01,boxthickness-wall+0.01]);
      }

      translate([0,wall,slidewall+slidedepth+wall-0.01]) cube([wall,cardtolerance+usbhole+usbholewidth+0.01,backspace+cardthickness+usbholeoffset]);
      translate([0,wall+cardtolerance+usbhole+usbholewidth,slidewall+slidedepth+wall]) cube([wall,boxwidth-(wall+cardtolerance+usbhole+usbholewidth)+0.01-wall,backspace+cardthickness]);
      translate([boxlength-wall,wall,slidewall+slidedepth+wall-0.01]) cube([wall+0.02,boxwidth-wall-wall+0.01,backspace+cardthickness+0.01]);

      // clip
      for (clipx=cliptable) {
	clip(clipx,boxwidth-wall,slidewall+slidedepth+wall,clipwidth,wall,boxthickness-wall,clipdepth);
      }

      // Attachment
      difference() {
	translate([boxlength/2-slidewidthout/2-slidewall,0,0]) roundedbox(slidewidthout+2*slidewall,cardwidth+2*wall+cardtolerance*2,slidewall+slidedepth+wall,cornerd);
	slidecut(boxlength/2-slidesupportdistance/2);
	slidecut(boxlength/2+slidesupportdistance/2);
      }

      // Towers below board
      for (hole=holetable) {
	difference() {
	  union() {
	    translate([hole[1]+wall+cardtolerance,hole[0]+wall+cardtolerance,slidewall+slidedepth+wall-0.01]) cylinder(h=backspace,d1=cardsupportd+backspace,d2=cardsupportd-0.5);
	    translate([hole[1]+wall+cardtolerance,hole[0]+wall+cardtolerance,slidewall+slidedepth+wall-0.01]) cylinder(h=+backspace+cardthickness,d1=cardholed*1.2,d2=cardholed*0.5);
	  }
	}
      }

      // screw
      hull() {
	translate([boxlength/2,wall+tolerance,slidewall+slidedepth+wall-screwtowerd/2]) rotate([-90,0,0]) ruuvitorni(screwlength-screwbasewall,screwtowerd);
	translate([boxlength/2-slideinside/2+tolerance,wall+tolerance,slidewall+slidedepth]) roundedbox(slideinside-tolerance*2,screwlength*2,wall,cornerd);
      }
    }
    
    translate([boxlength/2,wall-screwbasewall+screwlength-0.01,slidewall+slidedepth+wall-screwtowerd/2]) rotate([90,0,0]) ruuvireika(screwlength,screwholed,1);
    // cut for lid
    translate([boxlength/2-slideinside/2-0.01,-0.01,-0.01]) cube([slideinside+0.02,wall+tolerance+0.02,slidewall+slidedepth+wall+0.02]);
    

    // Clip cuts
    for (clipx=cliptable) {
      clipcut(clipx,boxwidth-wall,slidewall+slidedepth+wall,clipwidth,wall,boxthickness-wall,clipdepth);
    }

    translate([5,slidewall+slidedepth+wall,slidewall+slidedepth+textdepth-0.01]) rotate([180,0,0]) linear_extrude(height=textdepth) text(versiontext, size=7, valign="center",font="Liberation Sans:style=Bold");
  }
}

module cover() {
  difference() {
    union() {
      difference() {
	translate([0,0,slidewall+slidedepth]) roundedbox(boxlength,boxwidth,boxthickness,cornerd);
	translate([wall,wall,slidewall+slidedepth-0.01]) cube([boxlength-wall*2,boxwidth-wall+0.01,boxthickness-wall+0.02]);
	translate([-0.01,boxwidth-wall,slidewall+slidedepth-0.01]) cube([boxlength+0.02,wall+0.01,boxthickness+0.02]);
	translate([-0.01,-0.01,slidewall+slidedepth-0.01]) cube([boxlength+0.2,boxwidth-wall+0.02,wall+0.01]);
	for (opening=leftholetable) {
	  translate([-0.01,opening[0]+wall+cardtolerance,slidewall+slidedepth+wall+backspace+cardthickness+opening[2]]) cube([wall+0.02,opening[1],opening[3]]);
	}
	translate([-0.01,wall-0.01,slidewall+slidedepth+wall-0.01]) cube([wall+0.02,cardtolerance+usbhole+usbholewidth+0.02,backspace+cardthickness+usbholeoffset+0.02]);
	translate([-0.01,wall+cardtolerance+usbhole+usbholewidth-0.01,slidewall+slidedepth+wall-0.01]) cube([wall+0.02,boxwidth-(wall+cardtolerance+usbhole+usbholewidth)+0.02-wall,backspace+cardthickness+0.02]);
	for (opening=rightholetable) {
	  translate([boxlength-wall-0.01,opening[0]+wall+cardtolerance,slidewall+slidedepth+wall+backspace+cardthickness+opening[2]]) cube([wall+0.02,opening[1],opening[3]]);
	  translate([boxlength-wall-cardtolerance-topholeoffsetfromright,opening[0]+wall+cardtolerance,slidewall+slidedepth+wall+height-0.01]) cube([topholewidth,opening[1],wall+0.02]);
	}
	translate([boxlength-wall-0.01,wall-0.01,0]) cube([wall+0.02,boxwidth-wall-wall+0.02,slidewall+slidedepth+wall+backspace+cardthickness+0.01]);
      }

      // Towers on cover
      for (hole=holetable) {
	translate([hole[1]+wall+cardtolerance,hole[0]+wall+cardtolerance,slidewall+slidedepth+wall+backspace+cardthickness+cardtowertolerance]) cylinder(h=height-backspace-cardthickness,d=cardsupportd,$fn=90);
      }

      belowz=slidewall+slidedepth+wall-screwtowerd;
      translate([boxlength/2-slideinside/2+tolerance,wall-screwbasewall,0]) roundedbox(slideinside-tolerance*2,screwbasewall,slidewall+slidedepth+boxthickness,cornerd);
      hull() {
	translate([boxlength/2-slideinside/2+tolerance,wall-screwbasewall,slidewall+slidedepth]) roundedbox(slideinside-tolerance*2,screwbasewall,cornerd,cornerd);
	translate([boxlength/2,wall-screwbasewall,slidewall+slidedepth+wall-screwtowerd/2]) rotate([-90,0,0]) cylinder(h=screwbasewall,d=screwtowerd);
      }
      hull() {
	translate([boxlength/2-slideinside/2+tolerance,wall-screwbasewall,slidewall+slidedepth+wall]) roundedbox(slideinside-tolerance*2,screwbasewall,boxthickness-wall,cornerd);
	translate([boxlength/2-(slideinside+20)/2,0,slidewall+slidedepth+wall]) roundedbox(slideinside+20,wall,boxthickness-wall,cornerd);
      }
    }
    translate([boxlength/2,wall-screwbasewall+screwlength-0.01,slidewall+slidedepth+wall-screwtowerd/2]) rotate([90,0,0]) ruuvireika(screwlength,screwholed,1);

    translate([5,slidewall+slidedepth+wall,slidewall+slidedepth+boxthickness-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth+1) text(versiontext, size=7, valign="center",font="Liberation Sans:style=Bold");
  }
}

if (print==0) {
  color([1,0,0]) case();
  color([0,1,0]) cover();
 }

if (print==1 || print==2) {
  translate([0,0,boxwidth]) rotate([-90,0,0]) color([1,0,0]) case();
 }

if (print==1 || print==3) {
  translate([0,-1-screwbasewall+wall,boxthickness+slidewall+slidedepth]) rotate([180,0,0]) color([0,1,0]) cover();
 }
