// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

print=0;
strong=0;

countersinkheightmultiplier=0.63;
countersinkdiametermultiplier=2.4;

function countersinkd(diameter) = diameter*countersinkdiametermultiplier;

// Distance is distance between voids
module cylindervoids(diameter1,diameter2,height,distancein,voidwin,strong) {
  // This makes openscad slow, do for testing purposes, this can be disabled.
  makestrong=(strong=="")?1:strong;

  maxdiameter=max(diameter1,diameter2);
  mindiameter=min(diameter1,diameter2);

  voidw=voidwin?voidwin:0.01;
  distance=distancein?distancein:0.8;
  r=(diameter1>diameter2)?0:180;
  hf=(diameter1>diameter2)?0:height;

  $fn=0;
  $fs=0.1;
  $fa=20;
  
  if (makestrong) {
    translate([0,0,hf]) rotate([r,0,0]) {
      for (d=[distance*2:distance*2:mindiameter-distance*2]) {
	h=height;
	translate([0,0,distance]) ring(d,0.03,h-distance*2,0);
      }
      if (maxdiameter>mindiameter) {
	for (d=[mindiameter:distance*2:maxdiameter-distance*2]) {
	  h=height*(1-((d + distance - mindiameter)/(maxdiameter-mindiameter)))-distance*2;
	  translate([0,0,distance]) ring(d,0.03,h-distance*2,0);
	}
      }
    }
  }
}

module ruuvireika(height,diameter,countersink,strong,strongl) {
  makestrong=(strong=="")?1:strong;
  sl=(strongl=="")?height:strongl;
  
  hull() {
    translate([0,0,diameter/2]) cylinder(h=height-diameter/2,d=diameter-0.1,$fn=90); // Slightly smaller hole
    translate([0,0,0]) cylinder(h=diameter/2,d2=diameter-0.1,d1=1,$fn=90); // screw head
  }

  if (makestrong) {
    maxd=diameter*countersinkdiametermultiplier-(diameter+0.3)+1;
    for (d=[diameter+0.8:0.9:diameter*3-0.6]) {
      di=d;
      bottom=(d<diameter*3*0.6-0.8)?-diameter/3*3+0.4:-diameter/3*3+(d-diameter)*1-diameter*0.6+0.4;
      top=(d>countersinkd(diameter))?height-0.4:height-0.8-diameter+d/2-0.4;
      translate([0,0,0])
	difference() {
	translate([0,0,bottom]) cylinder(h=top-bottom,d=di+0.03,$fn=20);
	translate([0,0,bottom-0.01]) cylinder(h=top-bottom+0.02,d=di,$fn=20);
      }
    }
  }

  if (countersink) {
    translate([0,0,height-diameter*countersinkheightmultiplier]) cylinder(h=diameter*countersinkheightmultiplier,d1=diameter-0.1,d2=diameter*countersinkdiametermultiplier,$fn=90);
  }
}

module ruuvitorni(height,diameter) {
  cylinder(h=height,d=diameter);
  translate([0,0,-diameter/3+0.01]) cylinder(h=diameter/3,d2=diameter,d1=diameter*0.6,$fn=90);
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
  } else if (mode==12) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x/2,z],[x,0]]);
  } else if (mode==13) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z/2]]);
  } else if (mode==14) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x/2,z],[x,0]]);
  } else if (mode==15) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x/2,0]]);
  } else if (mode==16) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y/2,x],[y,0]]);
  } else if (mode==17) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x/2]]);
  } else if (mode==18) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,y/2],[y,x],[y,0]]);
  } else if (mode==19) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y/2,0]]);
  } else if (mode==20) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z/2,y],[z,0]]);
  } else if (mode==21) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y/2]]);
  } else if (mode==22) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y/2],[z,y],[z,0]]);
  } else if (mode==23) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z/2,0]]);
  }
}

module triangletest() {
  for (i=[0:1:23]) {
    colorselect=floor(i/4) % 4;
    color([colorselect%4==0?1:0,floor((colorselect+1)/4)==0?1:0,floor((colorselect+2)/4)==0?1:0]) {
      translate([0,i*6,0]) triangle(4,4,4,i);
      translate([5+textsize,i*6,0]) rotate([0,0,90]) text(text=str(i),size=textsize);
    }
  }
}

module lighten_recurse(w,h,thickness,edge,barw,maxbridge) {
  for (x=[barw+edge:barw*2+edge*2:w+edge]) {
    translate([w/2+x,0,h-edge/2+maxbridge/2]) rotate([0,45,0]) translate([-edge/sqrt(2)/2,-0.01,-edge/sqrt(2)/2]) cube([edge/sqrt(2),thickness+0.02,edge/sqrt(2)]);
    translate([w/2-x,0,h-edge/2+maxbridge/2]) rotate([0,45,0]) translate([-edge/sqrt(2)/2,-0.01,-edge/sqrt(2)/2]) cube([edge/sqrt(2),thickness+0.02,edge/sqrt(2)]);
  }

   if (edge<w/2) lighten_recurse(w,h,thickness,edge+barw+edge,barw,maxbridge);
}

// Cutouts to lighten a vertical plate. fill is percent of open space
module lightenhelper(width,height,thickness,margin,barw,maxbridge) {
  zadjust=maxbridge/2;
  w=width-margin*2;
  h=height-margin*2;
  //  barw=w*fill/2;
  sh=sqrt(maxbridge);
  intersection() {
    union() {
      translate([w/2+margin,0,h+margin-w/2+zadjust]) rotate([0,45,0]) translate([-w/sqrt(2)/2,-0.01,-w/sqrt(2)/2]) cube([w/sqrt(2),thickness+0.02,w/sqrt(2)]);
      if (h>w/2) {
	translate([margin,-0.01,margin]) cube([w,thickness+0.02,h-w/2+zadjust]);
      }

      translate([margin,0,margin]) lighten_recurse(w,h,thickness,maxbridge,barw,maxbridge);
    }
    translate([margin,-0.01,margin]) cube([w,thickness+0.02,h]);
  }
}

module lighten(w,h,thickness,margin,barw,maxbridge,direction) {
  bw=barw*2;
  if (direction=="up")
    lightenhelper(w,h,thickness,margin,bw,maxbridge);
  else if (direction=="down-yplane")
    translate([thickness,w,h]) rotate([0,180,90]) lightenhelper(w,h,thickness,margin,bw,maxbridge);
  else if (direction=="down-xplane")
    translate([w,0,h]) rotate([0,180,0]) lightenhelper(w,h,thickness,margin,bw,maxbridge);
  else if (direction=="back-yplane")
    translate([thickness,0,h]) rotate([0,90,90]) lightenhelper(h,w,thickness,margin,bw,maxbridge);
  else if (direction=="back-zplane")
    translate([h,0,0]) rotate([90,0,180]) lightenhelper(h,w,thickness,margin,bw,maxbridge);
  else if (direction=="left-xplane") // Up is left on x plane
    translate([h,thickness,w]) rotate([0,90,180]) lightenhelper(w,h,thickness,margin,bw,maxbridge);
  else if (direction=="right-xplane") // Up is right on x plane
   translate([0,thickness,0]) rotate([0,-90,180]) lightenhelper(w,h,thickness,margin,bw,maxbridge);
  else if (direction=="flat-xplane")
    translate([-0.01,margin,margin]) cube([thickness+0.02,w-margin*2,h-margin*2]);
  else echo("ERROR missing or incorrect argument for lighten: ",direction);
}

module roundedbox(xsize,ysize,h,c,printableoption) {
  corner=(c > 0) ? c : 1;
  //scd = ((xsize < 1 || ysize < 1 || h < 1) ? min(xsize,ysize,h) : corner);
  scd = min(xsize,ysize,h,corner);
  f=(print > 0) ? 90 : 30;
  
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,ysize-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([xsize-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([xsize-scd/2,ysize-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,h-scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,ysize-scd/2,h-scd/2]) sphere(d=scd,$fn=f);
    translate([xsize-scd/2,scd/2,h-scd/2]) sphere(d=scd,$fn=f);
    translate([xsize-scd/2,ysize-scd/2,h-scd/2]) sphere(d=scd,$fn=f);

    // Sphere may generate slight rounding errors with smaller $fn values, so form actual cube in the center
    translate([scd/2,scd/2,scd/2]) cube([xsize-scd,ysize-scd,h-scd]);

    if (printableoption) {
      for (x=[0+scd/2,xsize-scd/2]) {
	for (y=[0+scd/2,ysize-scd/2]) {
	  translate([x,y,0]) cylinder(d=scd/2,h=0.01,$fn=f);
	}
      }
    }
  }
}

module tassu(direction,size) {
  s=(size?size:7);
  $fn=30;
  rotate([0,0,direction]) {
    hull() {
      cylinder(d=3,h=0.31);
      translate([s/2-1,0,0]) cylinder(d=1.5,h=0.35);
      translate([s/2-1,0,0]) cylinder(d1=s,d2=s-1,h=0.35);
    }
  }
}

module ring(diameter,wall,height,printsupport) {
  p=(printsupport=="")?0:printsupport;
  w=(p)?wall:0;
  difference() {
    union() {
      hull() {
	cylinder(d=diameter,h=height+(p==1?wall:0));
	if (p==2) {
	  translate([0,0,height]) cylinder(d1=diameter,d2=diameter-wall*2,h=wall);
	  //	  translate([0,0,height]) cylinder(
	}
      }
    }
    //    echo(diameter,wall,diameter-wall);
    translate([0,0,-0.1]) cylinder(d=diameter-wall*2,h=height+w+0.2);
    if (p==1) {
      translate([0,0,height-0.1]) cylinder(d2=diameter,d1=diameter-wall*2,h=wall+0.2);
    }
  }
}

// TODO:
// - This does not work if diameter1 is smaller than 2*wall
// - Height is not adjusted correctly, do the math, what needs to be the height where wall can be given.
// Add error checking and messages.
module cone(diameter1,diameter2,wall,height) {
  difference() {
    cylinder(d1=diameter1,d2=diameter2,h=height);
    if (diameter2<wall*2) {
      hadjust1=wall*2-diameter2;
      hadjust=hadjust1<wall?wall:hadjust1;
      diameter2adjusted=diameter2;
      translate([0,0,-0.01]) cylinder(d1=diameter1-wall*2,d2=diameter2adjusted,h=height-hadjust);
    } else {
      translate([0,0,-0.01]) cylinder(d1=diameter1-wall*2,d2=diameter2-wall*2,h=height+0.02);
    }
  }
}

module tubeclip(length,diameter,tolerance) {
  hull() {
    for (x=[-length/2+diameter/2,length/2-diameter/2]) translate([x,0,0]) sphere(d=diameter+tolerance,$fn=60);
  }
}

// Make a spring. Springs generated are not very reliable, and need to be put inside a tube to work.
springangle=1.2;
module spring(h,d,plateh,thickness) {
  $fn=120;

  s=1;

  // Need to raise height pi*d for 360 degrees
  degrees=360*h/(d*3.14159)*springangle;
  
  platetwist=degrees*(d/2)/(h/2);
  twist=degrees;

  translate([0,0,h]) rotate([180,0,0]) {
    for (t=[1,-1]) {
      translate([0,0,t==1?0:h/2-plateh/2]) {
	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([d/2-s-thickness/2,0,0]) circle(d=thickness);
	  intersection() {
	    translate([0,-d/2,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([d/2-s-thickness/2,0,0]) circle(d=thickness);

	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([-d/2+s+thickness/2,0,0]) circle(d=thickness);
	  intersection() {
	    translate([-d/2,0,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([-d/2+s+thickness/2,0,0]) circle(d=thickness);

	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([0,d/2-s-thickness/2,0]) circle(d=thickness);
	  intersection() {
	    translate([0,0,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([0,d/2-s-thickness/2,0]) circle(d=thickness);

	hull() {
	  linear_extrude(height=d/2,center=false,convexity=10,twist=t*platetwist,$fn=90) translate([0,-d/2+s+thickness/2,0]) circle(d=thickness);
	  intersection() {
	    translate([-d/2,-d/2,0]) cube([d/2,d/2,plateh]);
	    cylinder(h=plateh+d/2,d=d);
	  }
	}
	linear_extrude(height=h/2,center=false,convexity=10,twist=t*twist,$fn=90) translate([0,-d/2+s+thickness/2,0]) circle(d=thickness);
      }
    }
  
    // Top
    translate([0,0,h-plateh]) cylinder(h=plateh,d=d);
  }
}

// This is used by onehinge
module axle(diameter,width,axledepthin,cutout) {
  axledepth=axledepthin>diameter/3?diameter/3:axledepthin;
  if (cutout) {
    translate([0,-width/2,0]) rotate([90,0,0]) cylinder(d2=diameter-axledepth*2,d1=diameter,h=axledepth,$fn=90);
    translate([0,width/2,0]) rotate([-90,0,0]) cylinder(d2=diameter-axledepth*2,d1=diameter,h=axledepth,$fn=90);
  } else {
    hull() {
      translate([0,-width/2,0]) rotate([-90,0,0]) cylinder(d=diameter,h=width,$fn=90);
      translate([0,width/2+axledepth,0]) rotate([90,0,0]) cylinder(d=diameter-axledepth*2,h=0.01,$fn=90);

      translate([0,-width/2-axledepth,0]) rotate([-90,0,0]) cylinder(d=diameter-axledepth*2,h=0.01,$fn=90);
    }
  }
}

// diameter, width - Makes the hinge structure with axle direction in x axis
// If cutout is 1, makes female cutout for axle but does not cut out axle itself
// If cutout is 2, makes female cutout for axle, including cutting axle itself. Use this if parts are separate modules.
// Hinge is centered at y, x and z axis
module onehinge(diameter,width,axledepth,cutout,ytolerance,dtolerance) {
  if (cutout) {
    difference() {
      translate([0,0,0]) axle(diameter+dtolerance,width,axledepth+ytolerance,cutout);
      if (cutout==1) translate([0,0,0]) axle(diameter,width,axledepth,cutout);
    }
  } else {
        translate([0,0,0]) axle(diameter,width,axledepth,cutout);
  }
}

// Used to work out placement of components being printed
module printareacube(printer) {
  xysize=(printer=="ankermake")?232:(print=="anycubic")?380:380; // No other working printers at the moment
  height=(printer=="ankermake")?249:(print=="anycubic")?380:380; // No other working printers at the moment
  xsize=xysize; // Leave some space for safety
  ysize=xysize;
  wall=0.4;
  h=0.2;
  
  difference() {
    translate([-xsize/2,-ysize/2,0]) cube([xsize,ysize,h]);
    translate([-xsize/2+wall,-ysize/2+wall,-0.1]) cube([xsize-wall*2,ysize-wall*2,h+0.2]);
  }
  
  translate([0,0,height-0.2]) difference() {
    translate([-xsize/2,-ysize/2,0]) cube([xsize,ysize,h]);
    translate([-xsize/2+wall,-ysize/2+wall,-0.1]) cube([xsize-wall*2,ysize-wall*2,h+0.2]);
  }

  for (x=[-xsize/2,xsize/2-wall]) {
    for (y=[-ysize/2,ysize/2-wall]) {
      translate([x,y,0]) cube([wall,wall,height]);
    }
  }
}

// Create heat protection box around an object for warpy materials
// such as abs. Curvy walls needed to avoid corners warping open.
// distance is distance from the object, 3mm or more (curved corners
// need to be accommodated, wall is wall thickness, 1-2 times
// nozzle. I use 2x for wall.

module antiwarpwall(x,y,z,l,w,h,distanceoption,walloption) {
  distance=distanceoption?distanceoption:3;
  wall=walloption?walloption:0.8;
  diameterin=min(distance+wall,l+distance*2,w+distance*2);
  diameterout=diameterin+wall*2;
  
  hh=max(h+2,2);
  
  difference() {
    translate([x,y,0]) minkowski() {
      cube([l,w,hh]);
      cylinder(d=diameterout,h=1);
    }

    translate([x,y,-0.1]) minkowski() {
      cube([l,w,hh+0.2]);
      cylinder(d=diameterin,h=1);
    }

    translate([x-diameterout/2-0.1,y+w/2,-0.01]) cube([diameterout/2-0.1+0.1,1,1.01]);
  }
}

// Rounded box with different roudings in xy and z directions. If printable is 1, bottom is set to max 45 degree angle.
// height must be non-zero, if 0, it will become 0.01..

module roundedcylinder(diameter,heightin,cornerd,printable,fn) {
  $fn=(fn!="" || fn>0)?fn:30;
  height=heightin>0?heightin:0.01;

  //echo("diameter ",diameter," heightin ", heightin, " cornerd ", cornerd, " printable ", printable);
  // echo("diameter - cornerd/1.7 ", diameter-cornerd/1.7);
  // echo("diameter/2 - cornerd/2 ", diameter/2-cornerd/2);
  hull() {
    if (printable) cylinder(d=diameter-cornerd/1.7,h=height/2);
    
    translate([0,0,cornerd/2]) rotate_extrude(convexity=10) translate([diameter/2-cornerd/2,0,0]) {
      intersection() {
	circle(d=cornerd);
	translate([0,-diameter/2]) square([diameter,diameter]);
      }
    }
    
    translate([0,0,height-cornerd/2]) rotate_extrude(convexity=10) translate([diameter/2-cornerd/2,0,0]) {
      intersection() {
	circle(d=cornerd);
	translate([0,-diameter/2]) square([diameter,diameter]);
      }
    }
  }
}

module roundedboxxyz(x,y,z,dxy,dzin,printable,fn) {
  //  echo("x ",x," y ", y," z ",z," dxy ",dxy,"dz", dzin," printable ",printable," fn ",fn);
  dz=dzin>0?dzin:0.01;
  $fn=(fn!="" || fn>0)?fn:30;
  translate([dxy/2,dxy/2,0]) minkowski(convexity=10) {
    cube([x-dxy,y-dxy,z-dz]);
    roundedcylinder(dxy,dz,dz,printable,$fn);
  }
}

