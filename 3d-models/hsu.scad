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
  sl=(!strongl || strongl=="")?height:strongl;
  
  hull() {
    translate([0,0,diameter/2]) cylinder(h=height-diameter/2,d=diameter,$fn=90);
    translate([0,0,0]) cylinder(h=diameter/2,d2=diameter,d1=1,$fn=90); // Sharp end
  }

  if (makestrong) {
    intersection() {
      union() {
	maxd=diameter*countersinkdiametermultiplier-(diameter+0.3)+1;
	for (d=[diameter+2:1.2:diameter*3-2]) {
	  di=d;
	  bottom=(d<diameter*3*0.6-0.8)?-diameter/3*3+0.8:-diameter/3*3+(d-diameter)*1-diameter*0.6+0.8;
	  top=countersink?((d>countersinkd(diameter))?height-0.8:height-0.8-diameter+d/2-0.8):height-0.8;
	  translate([0,0,0])
	    difference() {
	    translate([0,0,bottom]) cylinder(h=top-bottom,d=di+0.03,$fn=20);
	    translate([0,0,bottom-0.01]) cylinder(h=top-bottom+0.02,d=di,$fn=20);
	  }
	}
      }

      translate([0,0,height-sl+1.2]) cylinder(d=diameter*countersinkdiametermultiplier+1,h=sl-2.4);
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
  } else if (mode==13) { //
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z/2]]);
  } else if (mode==14) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z/2],[x,z],[x,0]]);
  } else if (mode==15) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x/2,0]]);
  } else if (mode==16) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y/2,x],[y,0]]);
  } else if (mode==17) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x/2]]);
  } else if (mode==18) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x/2],[y,x],[y,0]]);
  } else if (mode==19) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y/2,0]]);
  } else if (mode==20) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z/2,y],[z,0]]);
  } else if (mode==21) { //
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y/2]]);
  } else if (mode==22) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y/2],[z,y],[z,0]]);
  } else if (mode==23) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z/2,0]]);
  }
}

module newtriangle(x,y,z,mode) {
}

module roundedtriangle(x,y,z,mode,cornerd) {
  c=min(x,y,z,cornerd?cornerd:0);

  minkowski() {
    if (c>0) sphere(d=c,$fn=30);
    adjust=c>0?(1/sqrt(c)):0;//1/sqrt(c/2*c/2+c/2*c/2);
    union() { //translate([c/2,c/2,c/2]) scale([(x-c)/x,(y-c)/y,(z-c)/z]) { // scale([(x-c)/x,(y-c)/y,(z-c)/z]) {
	if (mode==0) {
	  difference() {
	    if (0) {
	      xc=sqrt(c*c+c*c); //1/sqrt(c);
	      yc=sqrt(c*c+c*c); //1/sqrt(c);
	    }
	    xc=(x-c)/x;
	    yc=(y-c)/y;
	    zc=(z-c)/z;
	    
	    //translate([c/2+xc/2,y-c/2,c/2]) rotate([90,0,0]) linear_extrude(height=y-yc) polygon(points=[[0,0],[x-c-xc/2,z-c-zc/2],[x-c-yc/2,0]]);
	    xx=(x-c)*z/x;
	    zz=(z-c)*x/z;
	    //echo("xx ",xx, " zz ",zz);
	    translate([c/2,y-c/2,c/2]) rotate([90,0,0]) linear_extrude(height=y-c) polygon(points=[[0,0],[x-c,z-c],[x-c,0]]);
	    if (0) hull() {
	    translate([0,0,0]) cube([xc/2,y,zc/2]);
	    translate([x-xc/2,0,z-zc/2]) cube([xc/2,y,zc/2]);
	    }
	  }
	} else if (mode==1) {
	  translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z]]);
	} else if (mode==2) {
	  a=atan2(x,z); //echo(x,z,a);

	  //echo("a, cos ",a, cos(a)," sin ",sin(a), " tan ", tan(a));
	  
	  xc=sin(a)*c;
	  zc=cos(a)*c;

	  //echo("c, c/2 ",c,c/2," xc ",xc," zc ",zc,sqrt(xc*xc+zc*zc));
	  //translate([c/2,y-c/2,c/2]) rotate([90,0,0]) linear_extrude(height=y-c) polygon(points=[[0,0],[0,z-c-zc],[x-c-xc,0]]);
	  //translate([c/2,y-c/2,c/2]) rotate([90,0,0]) linear_extrude(height=y-c) polygon(points=[[0,0],[0,z-c],[x-c/2,0]]);
	  r=sqrt((x-c)*(x-c)+(z-c)*(z-c));
	  //echo(" r ",r," R ",sqrt(x*x+z*z));
	  //translate([r*cos(a),r*sin(a),0]) cube([1,1,1]);
	  x1=-(c/2)*tan(a);
	  x2=-sqrt(tan(a)*c/2*tan(a)*c/2+c/2*c/2);  //-c/2*sin(a);
	  x3=0; //-c/2*sin(a);
	  xd=x1+x2+x3;
	  echo ("x, x1,x2,x3,xd,x+xd ",x, x1,x2,x3,xd,x+xd);
	  z1=-(c/2)*tan(90-a);
	  z2=-sqrt(tan(90-a)*c/2*tan(90-a)*c/2+c/2*c/2);  //-c/2*sin(a);
	  z3=0; //-c/2*sin(a);
	  zd=z1+z2+z3;
	  echo ("z, z1,z2,z3,zd,z+zd ",z, z1,z2,z3,zd,z+zd);
	  translate([c/2,y-c/2,c/2]) rotate([90,0,0]) linear_extrude(height=y-c) polygon(points=[[0,0],[0,z+zd-c/2],[x+xd-c/2,0]]);
	  //translate([c/2,c/2,c/2]) cube([x-c-xc,y-c,z-c-zc]);
	  //	   translate([c/2,c/2,c/2]) cube([xx-c,y-c,zz-c]);
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
	} else if (mode==13) { //
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
	} else if (mode==21) { //
	  translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y/2]]);
	} else if (mode==22) {
	  translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y/2],[z,y],[z,0]]);
	} else if (mode==23) {
	  translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z/2,0]]);
	}
      }
  }
}

module triangletest() {
  textsize=3;
  textdepth=0.8;

  x=2;
  y=4;
  z=6;
  
  for (i=[0:1:23]) {
    colorselect=floor(i/4) % 4;
    color([colorselect%4==0?1:0,floor((colorselect+1)/4)==0?1:0,floor((colorselect+2)/4)==0?1:0]) {
      translate([0,i*6,0]) triangle(x,y,z,i);
      translate([5+textsize,i*6,0]) rotate([0,0,90]) linear_extrude(textdepth) text(text=str(i),size=textsize);
    }
  }

  for (i=[0:1:23]) {
    colorselect=floor(i/4) % 4;
    color([colorselect%4==0?1:0,floor((colorselect+1)/4)==0?1:0,floor((colorselect+2)/4)==0?1:0]) {
      translate([-x-1,i*6,0]) roundedtriangle(x,y,z,i,1);
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
  //f=(print > 0) ? 90 : 30;
  f=90; // (print > 0) ? 90 : 30;
  
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

    if (printableoption==1 || printableoption==3) {
      for (x=[0+scd/2,xsize-scd/2]) {
	for (y=[0+scd/2,ysize-scd/2]) {
	  translate([x,y,0]) cylinder(d=scd/2,h=0.01,$fn=f);
	}
      }
    }

    if (printableoption==2 || printableoption==3) {
      for (x=[0+scd/2,xsize-scd/2]) {
	for (y=[0+scd/2,ysize-scd/2]) {
	  translate([x,y,h-0.01]) cylinder(d=scd/2,h=0.01,$fn=f);
	}
      }
    }

    if (printableoption==4 || printableoption==6) {
      for (x=[0+scd/2,xsize-scd/2]) {
	for (z=[0+scd/2,h-scd/2-0.01]) {
	  translate([x,0,z]) rotate([-90,0,0]) cylinder(d=scd/2,h=0.01,$fn=f);
	}
      }
    }

    if (printableoption==5 || printableoption==6) {
      for (y=[0+scd/2,ysize-scd/2]) {
	for (z=[0+scd/2,h-scd/2-0.01]) {
	  translate([0,y,z]) rotate([0,-90,0]) cylinder(d=scd/2,h=0.01,$fn=f);
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

module ring(diameter,wall,height,printsupport,fnin) {
  //  echo(diameter,wall,height,printsupport,fnin);
  //fn=(!fnin || fnin!="" || fnin==0 || fnin<7)?30:fnin;
  fn=(is_undef(fnin) || fnin=="")?30:fnin;
  p=(printsupport=="")?0:printsupport;
  w=(p)?wall:0;
  difference() {
    union() {
      hull() {
	cylinder(d=diameter,h=height+(p==1?wall:0),$fn=fn);
	if (p==2) {
	  translate([0,0,height]) cylinder(d1=diameter,d2=diameter-wall*2,h=wall,$fn=fn);
	  //	  translate([0,0,height]) cylinder(
	}
      }
    }
    translate([0,0,-0.1]) cylinder(d=diameter-wall*2,h=height+w+0.2,$fn=fn);
    if (p==1) {
      translate([0,0,height-0.1]) cylinder(d2=diameter,d1=diameter-wall*2,h=wall+0.2,$fn=fn);
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
module axle(diameter,width,axledepthin,cutout,ytolerance,dtolerance) {
  axledepth=(axledepthin>diameter/3?diameter/3:axledepthin);
  if (cutout) {
    for (a=[0,180]) mirror([0,a,0]) hull() {
	translate([0,-width/2-ytolerance,0]) rotate([90,0,0]) cylinder(d2=diameter+dtolerance-axledepth*2,d1=diameter+dtolerance,h=axledepth,$fn=90);
	translate([0,-width/2,0]) rotate([90,0,0]) cylinder(d=diameter+dtolerance,h=ytolerance,$fn=90);
      }
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
      union() {
	translate([0,0,0]) axle(diameter,width,axledepth,cutout,ytolerance,dtolerance);
	if (cutout==2) translate([0,-width/2-0.01,0]) rotate([-90,0,0]) cylinder(d=diameter+dtolerance,h=width+0.02,$fn=90);//axle(diameter,width,axledepth,cutout,ytolerance,dtolerance);
      }
    }
  } else {
    translate([0,0,0]) axle(diameter,width,axledepth,cutout,0,0);
  }
}

// Used to work out placement of components being printed
module printareacube(printer) {
  xysize=(printer=="ankermake")?235:(print=="anycubic")?380:380; // No other working printers at the moment
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
// If printable is 2, top is made printable (to allow printing upside down
// If printable is 3, both ends of cylinder are made printable.

module roundedcylinder(diameter,heightin,cornerd,printable,fn) {
  $fn=(fn!="" || fn==0 || fn>6)?fn:30;
  height=heightin>0?heightin:0.01;

  hull() {
    if (printable==1 || printable==3) cylinder(d=diameter-cornerd/1.7,h=height/2);
    if (printable==2 || printable==3) translate([0,0,height/2]) cylinder(d=diameter-cornerd/1.7,h=height/2);
    
    translate([0,0,cornerd/2]) rotate_extrude(convexity=10) translate([diameter/2-cornerd/2,0,0]) {
      intersection() {
	circle(d=cornerd,$fn=90);
	translate([0,-diameter/2]) square([diameter,diameter]);
      }
    }
    
    translate([0,0,height-cornerd/2]) rotate_extrude(convexity=10) translate([diameter/2-cornerd/2,0,0]) {
      intersection() {
	circle(d=cornerd,$fn=90);
	translate([0,-diameter/2]) square([diameter,diameter]);
      }
    }
  }
}

module roundedboxxyz(x,y,z,dxy,dzin,printable,fn) {
  dz=dzin>0?dzin:0.01;
  minz=(dz==z?0.01:0);
  $fn=(fn!="" || fn>0)?fn:30;
  translate([dxy/2,dxy/2,0]) minkowski(convexity=10) {
    cube([x-dxy,y-dxy,z-dz+minz]);
    roundedcylinder(dxy,dz,dz-minz,printable,$fn);
  }
}

module supportbox(xsize,ysize,height,onbed) {
  z=onbed?0:0.2;
  h=onbed?height-0.2:height-0.4;

  // If on bed, make a surface for adhesion
  if (onbed) {
    cube([xsize,ysize,0.2]);
  }
  
  // Corners
  for (z=[0,height-0.2]) {
    if (xsize >= ysize) translate([-0.2,-0.2,z]) cube([0.8,0.4,0.2]);
    if (xsize < ysize) translate([-0.2,-0.2,z]) cube([0.4,0.8,0.2]);
    if (xsize >= ysize) translate([-0.2,ysize-0.2,z]) cube([0.8,0.4,0.2]);
    if (xsize < ysize) translate([-0.2,ysize-0.2-0.4,z]) cube([0.4,0.8,0.2]);
    if (xsize >= ysize) translate([xsize-0.2-0.4,ysize-0.2,z]) cube([0.8,0.4,0.2]);
    if (xsize < ysize) translate([xsize-0.2,ysize-0.2-0.4,z]) cube([0.4,0.8,0.2]);
    if (xsize >= ysize) translate([xsize-0.2-0.4,-0.2,z]) cube([0.8,0.4,0.2]);
    if (xsize < ysize)translate([xsize-0.2,-0.2,z]) cube([0.4,0.8,0.2]);
    
    xsteps=floor(xsize/1.2);
    //echo(xsteps);
    if (xsteps > 0) {
      xstep=xsize/xsteps;
      for (x=[xstep:xstep:xsize-xstep]) {
	//echo(x);
	translate([x-0.2,-0.2,z]) cube([0.4,0.4,0.2]);
	translate([x-0.2,ysize-0.2,z]) cube([0.4,0.4,0.2]);
	if (z==0) translate([x-0.2,-0.2,0.2]) cube([0.4,ysize+0.4,h-0.2]);
      }
    }

    ysteps=floor(ysize/2.5);
    if (ysteps > 0) {
      ystep=ysize/ysteps;
      for (y=[ystep:ystep:ysize-ystep]) {
	translate([-0.2,y-0.2,z]) cube([0.4,0.4,0.2]);
	translate([xsize-0.2,y-0.2,z]) cube([0.4,0.4,0.2]);
	if (z==0) translate([-0.2,y-0.2,0.2]) cube([xsize+0.4,0.4,h-0.2]);
      }
    }
  }

  translate([-0.2,-0.2,z]) cube([xsize+0.4,0.4,h]);
  translate([-0.2,-0.2,z]) cube([0.4,ysize+0.4,h]);
  translate([xsize-0.2,-0.2,z]) cube([0.4,ysize+0.4,h]);
  translate([-0.2,ysize-0.2,z]) cube([xsize+0.4,0.4,h]);
}

module supportline(l,w,hin,layerh,onbed) {
  sl=0.8;
  steps=floor(l/8)+1;
  step=(l-sl)/steps;
  height=(onbed==1?0:0.2);
  h=(onbed>0?hin-0.2:hin-0.4);

  //  echo(l,w,hin,layerh,onbed, " calculated ",sl,steps,step,height,h);
  //translate([0,0,0]) cube([5,5,hin]);
  
  // Full line
  translate([0,-w/2,height]) cube([l,w,h]);

  // Supports
  for (x=[0:step:l]) {
    translate([x,-w/2,0]) cube([sl,w,hin]);
  }
}

// onbed=1 attach to bed at z=0, onbed=2 attach to bed at heightin
module supportcylinder(diameterin,hin,onbed,fnin) {
  fn=(is_undef(fnin) || fnin=="")?30:fnin;
  //echo("diameter ", diameterin, " hin ",hin," onbed ",onbed," fnin ", fnin, " fn ",fn);
  height=(onbed==1?0:0.2);
  w=0.4; // THIS SHOULD BE TUNABLE, width of line
  maxbridge=10;
  margin=0.6;
  diameter=diameterin-margin*2;
  
  dsteps=floor(diameter/maxbridge);
  dstep=(dsteps > 0)?diameter/dsteps:diameter;

  h=(onbed>0)?hin-0.2:hin-0.4;

  if (onbed>0 && hin>0.8) {
    adhesionheight=(onbed==2)?hin-0.6:0;
    translate([0,0,adhesionheight]) cylinder(d=diameterin-2,h=0.6,$fn=fn);
  }
    
  for (d=[0:dstep:diameter]) {
    asteps=(is_undef(fnin)?floor(2*3.14159*(d)/maxbridge):fn);
    astep=360/fn;
    //echo("d ",d," asteps ",asteps," astep ",astep," 360/asteps ",360/asteps," fn ",fn, " h ", h);

    if (d==0) {
      for (a=[0:90:359]) {
	rotate([0,0,a]) translate([-dstep/2+w,0,0]) supportline(dstep/2-w,w,hin,0.2,onbed);
      }
    } else {
      for (a=[0:360/asteps:359]) {
	translate([0,0,height]) ring(d-0.2,0.4,h,0,asteps);

	rotate([0,0,a]) {
	  intersection() {
	    translate([0,0,0]) ring(d-0.2,0.4,hin,0,asteps);
	    translate([d/2-w*2,-w*2,0]) cube([w*2,w*4,hin]);
	  }
	  
	  if (d<diameter) translate([d/2-w/2,0,0]) supportline(dstep/2,w,hin,0.2,onbed);
	}
      }
    }
  }
}


module flatspring(l,w,h,width,coils,cornerend) {
  coilstep=cornerend?l/(coils-0.5):l/coils;
  d=(coilstep+width*2)/2;
  $fn=30;

  intersection() {
    for (c=[0:1:coils]) {
      intersection() {
	translate([d/2,c*(d*2-width*2),0]) ring(d,width,h);
	translate([0,c*(d*2-width*2)-d/2,0]) cube([d/2,d,h]);
      }
      intersection() {
	translate([d/2+w-d,c*(d*2-width*2)+d-width,0]) ring(d,width,h);
	translate([d/2+w-d,c*(d*2-width*2)+d/2-width,0]) cube([d/2,d,h]);
      }
      translate([d/2,c*(d*2-width*2)+d/2-width,0]) cube([w-d,width,h]);
      if (c) {
	translate([d/2,c*(d*2-width*2)-d/2,0]) cube([w-d,width,h]);
      }
    }

    cube([w,l,h]);
  }
}

function textlen(t,fontsize) = textmetrics(text=t,font="Liberation Sans:style=Bold",size=fontsize,valign="top",halign="center").size[0];
function textheight(t,fontsize) = textmetrics(text=t,font="Liberation Sans:style=Bold",size=fontsize,valign="top",halign="center").size[1];

// Centered by width,length
// Note: upper step is outside l, so l should be only the steps l
module portaat(l,w,h,n) {
  zstep=h/n;
  xstep=l/(n-1);

  translate([-l/2,-w/2,0]) {
    intersection() {
      cube([l+xstep,w,h]);
      union() {
	for (i=[0:1:n-1]) {
	  translate([i*xstep,0,i*zstep]) roundedbox(xstep,w,zstep,cornerd);
	}

	hull() {
	  for (i=[0,n-1]) {
	    translate([i*xstep,0,(i-1)*zstep]) roundedbox(xstep,w,zstep,cornerd);
	  }
	  if (l>h) {
	    lw=l-h;
	    translate([l-h,w/2-lw/2,-zstep]) roundedbox(xstep,lw,zstep,cornerd);
	  }
	}
      }
    }
  }
}

function length_and_depth_to_diameter(l,depth) = 2*(depth/2+l*l/8/depth);

knobwall=2;
knobxtolerance=0.3;
knobytolerance=0.3;
knobztolerance=0.3;
knobshaftnarrowing=0.6;
knobshaftnarrowheight=1.5;
knobshaftnarrowh=2;
knobbridge=4;

module knobaxle(knobd,knobh) {
  knobshaftd=knobd-5;
  knobcornerd=knobd/10;

  knobshafth=knobh-knobwall-knobztolerance;
  knobshaftnarrowd=knobshaftd-knobshaftnarrowing*2;
  hull() {
    translate([0,0,0]) cylinder(d=knobshaftd,h=knobshaftnarrowheight-knobshaftnarrowing,$fn=90);
    translate([0,0,0]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowheight,$fn=90);
  }

  translate([0,0,0+knobshaftnarrowheight]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowh,$fn=90);
  
  hull() {
    translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=knobshaftd,h=knobshafth-knobshaftnarrowing-knobshaftnarrowh-knobshaftnarrowing-knobshaftd/2,$fn=90);
    translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=min(knobbridge,knobshaftd/2),h=knobshafth-knobshaftnarrowing-knobshaftnarrowh-knobshaftnarrowing,$fn=90);
    translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowing,$fn=90);
  }
}

module knob(knobd,knobh) {
  knobshaftd=knobd-5;
  knobaxleheight=0;
  knobshaftnarrowd=knobshaftd-knobshaftnarrowing*2;
  knobshafth=knobh-knobwall-knobztolerance;
  knobspringin=1;
  knobdtolerance=0.6;
  knobspringh=6.5;
  knobspringa=10;
  knobspringcut=max(0.5,knobd/20);
  //echo(knobspringcut,knobd);
  
  difference() {
    union() {
      translate([0,0,0+knobshaftnarrowheight]) roundedcylinder(knobd,knobh-knobshaftnarrowheight,cornerd,2,90);
    }
    
    translate([0,0,0+knobshaftnarrowheight+knobspringin-0.1]) cylinder(d=knobshaftnarrowd+knobdtolerance,h=knobshaftnarrowh-knobspringin+0.2,$fn=90);
    translate([0,0,0+knobshaftnarrowheight-0.1]) cylinder(d1=knobshaftd+knobdtolerance*2,d2=knobshaftnarrowd+knobdtolerance,h=knobshaftnarrowh-knobspringin+0.2,$fn=90);
    hull() {
      dd=min(knobbridge,knobshaftd/2);
      dh=max(knobbridge,knobshaftd/2);
      translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=knobshaftd+knobdtolerance,h=knobshafth-knobshaftnarrowh-knobshaftnarrowing-knobztolerance-dh,$fn=90);
      translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=dd+knobdtolerance,h=knobshafth-knobshaftnarrowh - knobshaftnarrowing-knobztolerance,$fn=90);
      translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh]) cylinder(d=knobshaftnarrowd+knobdtolerance,h=knobshaftnarrowing,$fn=90);
    }
    translate([0,0,0+knobshaftnarrowheight-0.1]) ring(knobd-2,knobshaftnarrowing,knobspringh,0,90);
    for (a=[0:360/knobspringa:359]) {
      rotate([0,0,a]) translate([0,-knobspringcut/2,0+knobshaftnarrowheight-0.1]) cube([(knobd-2)/2,knobspringcut,knobspringh]);
    }

    //translate([0,0,-knobaxleheight+knobshaftnarrowheight+knobh-textdepth+0.01]) linear_extrude(textdepth) text(versiontext,size=textsize-1,font=textfont,valign="center",halign="center");

  }
}

windowedge=14;
windowoverlap=6; // Go over the material
windowcornerd=10; // This is for the cover, not windows itself which are cut rectangular
windowsmallcornerd=1;
windowoutlap=6; // Rounded at edges
windowcutoutlap=3;
windowoverlapbottomh=0.3*4; // For 0.3 layers 4 layers, for 0.2 layers 6 layers;
windowoverlaptoph=0.3*4; // For 0.3 layers 4 layers, for 0.2 layers 6 layers;
windowh=2;
windowztolerance=0.2;
windowtemplateh=1;
windowtemplateedge=7;

module windowframe(x,y,height,l,w,h) {
  overl=l+windowoutlap*2;
  overw=w+windowoutlap*2;
  
  hull() {
    translate([x-l/2,y-w/2,height]) roundedboxxyz(l,w,windowoverlapbottomh,windowcornerd,windowsmallcornerd,0,90);
    translate([x-overl/2,y-overw/2,height+windowztolerance+windowoverlapbottomh]) roundedboxxyz(overl,overw,h,windowcornerd,windowsmallcornerd,0,90);
  }
}

module windowcut(x,y,height,l,w,h) {
  cutl=l-windowoverlap*2;
  cutw=w-windowoverlap*2;
  overl=l+windowoutlap*2;
  overw=w+windowoutlap*2;
  overcutl=l-windowoverlap*2+windowcutoutlap*2;
  overcutw=w-windowoverlap*2+windowcutoutlap*2;
  
  translate([x-l/2-xtolerance,y-w/2-ytolerance,height+windowoverlapbottomh+windowztolerance]) cube([l+xtolerance*2,w+ytolerance*2,h+windowztolerance*2]);
  hull() {
    translate([x-cutl/2,y-cutw/2,height-windowsmallcornerd/2]) roundedboxxyz(cutl,cutw,windowoverlapbottomh+windowsmallcornerd,windowcornerd,windowsmallcornerd,0,90);
    translate([x-overcutl/2,y-overcutw/2,height-windowsmallcornerd]) roundedboxxyz(overcutl,overcutw,windowsmallcornerd,windowcornerd,windowsmallcornerd,0,90);
  }

  translate([x-cutl/2,y-cutw/2,height+windowoverlapbottomh+windowztolerance+windowh+windowztolerance-0.01]) roundedboxxyz(cutl,cutw,windowoverlaptoph+0.01,windowcornerd,0.005,0,90);
  hull() {
    translate([x-cutl/2,y-cutw/2,height+windowoverlapbottomh+windowztolerance+windowh+windowztolerance+0.3]) roundedboxxyz(cutl,cutw,windowoverlaptoph-0.3,windowcornerd,0.005,0,90);
    translate([x-cutl/2-h/2,y-cutw/2-h/2,height+windowoverlapbottomh+windowztolerance+windowh+windowztolerance+windowoverlaptoph]) roundedboxxyz(cutl+h,cutw+h,windowoverlaptoph+0.01,windowcornerd,0.005,0,90);
  }
}

module windowtemplate(l,w) {
  midsupportl=((l-windowoverlap*2-50)>0?1:0);
  midsupportw=((w-windowoverlap*2-50)>0?1:0);

  difference() {
    echo(l,w,windowtemplateh,windowcornerd,1);
    translate([-l/2,-w/2,0]) roundedbox(l,w,windowtemplateh,windowcornerd,1);
    if (midsupportl&&midsupportw) {
      for (n=[0,1]) mirror([n,0,0]) for (m=[0,1]) mirror([0,m,0]) translate([-l/2+windowtemplateedge,-w/2+windowtemplateedge,-windowcornerd/2]) roundedbox(l/2-windowtemplateedge*1.5,w/2-windowtemplateedge*1.5,windowtemplateh+windowcornerd,windowcornerd,1);
    } else if (midsupportl) {
      for (m=[0,1]) mirror([0,m,0]) translate([-l/2+windowtemplateedge,-w/2+windowtemplateedge,-windowcornerd/2]) roundedbox(l-windowtemplateedge*2,w/2-windowtemplateedge*1.5,windowtemplateh+windowcornerd,windowcornerd,1);
    } else {
      translate([-l/2+windowtemplateedge,-w/2+windowtemplateedge,-windowcornerd/2]) roundedbox(l-windowtemplateedge*2,w-windowtemplateedge*2,windowtemplateh+windowcornerd,windowcornerd,1);
    }
  }
}

function windowheight(h) = windowoverlapbottomh+windowztolerance+h+windowztolerance+windowoverlaptoph;

