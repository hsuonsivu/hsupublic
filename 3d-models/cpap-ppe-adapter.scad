include <threads.scad>
include <hsu.scad>

debug=0;
adhesion=1;
tube=2;

dtolerance=0.65;

$fn=90;

t1=0.8; // height t1
r=1.225;
h=7; // threads per inch mm 7 nato 4 gost
pitch=3.629; // 4 gost
internald1=40.16;
internald2=(38.56+38.86)/2;
externald1=(40+39.7)/2;
externald2=38.40-pitch/2-dtolerance;
threadh=13.42+dtolerance*2;//18.6;

tooth_angle=40;

cpapoutd=22.3+dtolerance;
cpapind=cpapoutd+0.65;
cpapl=20.7;
cpaptubeind=cpapoutd-2;

adapterd=26;
adaptercurved=31;
adapterh=6;
adapterspaceh=16;//2;
adapterheight=threadh+adapterspaceh;

adapterangle=66;

axlebottomh=1;
axletoph=axlebottomh;
axlenarrowing=1.5;
axled=adapterd+2*axlenarrowing; // 1.5 mm depth or hinge
axleh=threadh-axlebottomh-axletoph-2*axlenarrowing;

wall=2.5;
cornerd=1;
  
nuth=4.5;

coverh=2.5;
coverh1=3.5;
cover2d=43.3;
coverh2=coverh1;
coverspread=5;
coverh3=coverh2+coverspread;
coverholed=adapterd;
coverxstart=-58;
coverw=56.7; // Widest point
coverd=47;
coverl=92.5;
coverheight=threadh+coverh1+coverh2;
coverbaseh=1;
coverbasecuth=0.1;
stripw=8;
edgew=4;
supportw=2; // Cross supports in the mask

tubed=9;
tubex=tube==1?-externald1/2:tube==2?coverxstart+coverl-edgew-3.5:0;
tubey=tube==1?cover2d/2-tubed/2:tube==2?tubed/2+0.5:0;;
tubeangle=tube==1?-20:tube==2?10:0;
tuberangle=-12;
tubesideangle=-45;
tubesider=-cover2d/2-tubed/2;
tubecatchd=tubed+10;
tubecatchheight=10;

outholex=13;
outholed=1.2;
outholeangle=-35;

insideadapterd=28.23;
insideadapterh=7;
insidetubed=24.87;
insidetubetotalh=10;
insidetubeh=2.94;//=2.4;
insidetubemidh=2.4;
ringcutheight=2.94;
ringcuth=2.2;
ringcutd=22.78;
topcutw=20.88;
topcutx=18.55-insidetubed/2;
insidetubetoph=10-insidetubeh-ringcuth-insidetubemidh;
notchh=1.77;
notchw=1.85;
clipd=1.88-1.34;
cliph=1.7;

insidecutd=23;
insidecutheight=insideadapterh+insidetubeh+ringcuth+1;
insidecuth=10;
sidecutl=2.7;

insidetubex=ringcutd/2-tubed/2-wall/2;
insidetuberotate=50;
insideholed=ringcutd-wall;
insideholeh=5;

module insidecut() {
  hull() {
    // Bottom shape
    translate([coverxstart+coverd/2+3,0,-0.01]) cylinder(d=coverd-edgew-5,h=coverbasecuth);
    translate([coverxstart+coverl/2+3,0,-0.01]) scale([(coverl-4)/coverw,1,1]) cylinder(d=coverw-edgew,h=coverbasecuth);
    translate([coverxstart+coverl-coverd/2,0,-0.01]) cylinder(d=coverd-edgew,h=coverbasecuth);

    // top
    translate([0,0,coverheight-coverh]) cylinder(d1=cover2d+dtolerance,d2=cover2d+dtolerance,h=coverh);
  }
}

module cpaptube() {
  difference() {
    union() {
      // Base
      translate([0,0,0]) cylinder(d=adapterd,h=axlebottomh+0.01);
      hull() {
	translate([0,0,axlebottomh]) cylinder(d1=adapterd,d2=axled,h=axlenarrowing);
	translate([0,0,axlebottomh+axlenarrowing]) cylinder(d=axled,h=axleh);
	translate([0,0,axlebottomh+axlenarrowing+axleh]) cylinder(d2=adapterd,d1=axled,h=axlenarrowing);
      }
      height=threadh-axletoph;
      hull() {
	translate([0,0,height+axlebottomh]) cylinder(d1=adapterd,d2=axled,h=axlenarrowing);
	translate([0,0,height+axlebottomh+axlenarrowing]) cylinder(d=axled,h=axleh);
	translate([0,0,height+axlebottomh+axlenarrowing+axleh]) cylinder(d2=adapterd,d1=axled,h=axlenarrowing);
      }
      translate([0,0,threadh-axletoph-0.01]) cylinder(d=adapterd,h=axlebottomh+adapterspaceh+0.02);
  
      // Curved tube
      translate([-adaptercurved/2,0,adapterheight])  {
	rotate([90,0,0]) rotate_extrude(angle=adapterangle,convexity=10) translate([adaptercurved/2,0]) circle(d=adapterd);
      }

      // Cpap adapter tube
      translate([-adaptercurved/2*(1-cos(adapterangle)),0,adapterheight+adaptercurved/2*sin(adapterangle)]) rotate([0,-adapterangle,0]) {
	cylinder(d=adapterd,h=adapterh);
	translate([0,0,adapterh]) cylinder(h=cpapl,d1=cpapind,d2=cpapoutd);
      }

      // Cover
      difference() {
	hull() {
	  // Bottom shape
	  translate([coverxstart+coverd/2,0,0]) cylinder(d=coverd,h=coverbaseh);
	  translate([coverxstart+coverl/2,0,0]) scale([coverl/coverw,1,1]) cylinder(d=coverw+wall,h=coverbaseh);
	  translate([coverxstart+coverl-coverd/2,0,0]) cylinder(d=coverd+wall,h=coverbaseh);
	  if (tube==2) {
	    intersection() {
	      translate([coverxstart+coverl-coverd/2,0,0]) cylinder(d=coverd*2,h=threadh+coverh1+coverh2+coverspread);
	      translate([tubex,tubey,0]) rotate([0,tubeangle,0]) cylinder(d=tubed+wall*2,h=adapterheight);
	    }
	  }
	  
	  // top
	  //	  translate([0,0,coverheight]) cylinder(d1=cover2d+dtolerance,d2=cover2d+coverspread+dtolerance,h=coverh);
	  translate([0,0,threadh+coverh1+coverh2]) cylinder(d1=cover2d+dtolerance,d2=cover2d+coverspread*2+dtolerance,h=coverspread);
	}
	translate([0,0,threadh+coverh1+coverh2-0.01]) cylinder(d1=cover2d+dtolerance,d2=cover2d+coverspread*2+dtolerance,h=coverspread+0.02);
	translate([0,0,-0.01]) cylinder(d=externald2+dtolerance,h=coverheight+0.02);
      }

      // Tube combining out and in flows
      //      translate([-externald1
    }
    translate([0,0,-0.01]) cylinder(d=cpaptubeind,h=adapterheight+0.02);
    translate([-adaptercurved/2,0,adapterheight])  {
      rotate([90,0,0]) rotate_extrude(angle=adapterangle,convexity=10) translate([adaptercurved/2,0]) circle(d=cpaptubeind);
    }

    // Cpap adapter tube
    translate([-adaptercurved/2*(1-cos(adapterangle)),0,adapterheight+adaptercurved/2*sin(adapterangle)]) rotate([0,-adapterangle,0]) {
      translate([0,0,-0.01]) cylinder(d=cpaptubeind,h=adapterh+adapterheight+0.02);
    }

    // Cover cut
    difference() {
      union() {
	difference() {
	  insidecut();
	}
	
	for (i=[1:1.5:4]) {
	  for (j=[1:1.5:4]) {
	    translate([coverxstart+outholex+edgew+outholed*2+i*outholed*1.5,-outholed*2.5*1.5+j*outholed*1.5,0]) rotate([0,outholeangle,0]) cylinder(d=outholed,h=coverheight);
	    translate([coverxstart+outholex+edgew+outholed*2+i*outholed*1.5,-outholed*2.5*1.5+j*outholed*1.5,0]) rotate([0,outholeangle,0]) translate([0,0,-coverheight/2*sin(outholeangle)-2*i*sin(outholeangle)+1]) cylinder(d1=outholed,d2=outholed*2,h=coverheight/2);
	  }
	}

	if (tube==1) {
	  rotate([0,0,tubesideangle]) translate([tubesider,0,0]) {
	    rotate([0,tuberangle,0]) cylinder(d=tubed,h=adapterheight);
	  }
	}

	if (tube==2) {
	  translate([tubex,tubey,0]) rotate([0,tubeangle,0]) cylinder(d=tubed,h=adapterheight);
	}
      }
      translate([0,0,-0.01]) cylinder(d=externald2+dtolerance,h=coverheight+0.02);

      //translate([tubex,tubey,coverheight/2]) cylinder(d=tubed-sin(tubeangle)*threadh,coverheight/2);
    }
  }

  if (adhesion) cylinder(d1=cpaptubeind-0.15*2,d2=cpaptubeind-0.6,h=0.6);
}

module filteradapter() {
  difference() {
    union() {
      ScrewThread(externald1,threadh,pitch=pitch,tooth_angle,dtolerance,0,0,0);
      translate([0,0,threadh-0.01]) cylinder(d=externald2-dtolerance/2,h=coverh1);
      translate([0,0,threadh+coverh1-0.01]) cylinder(d1=externald2-dtolerance/2,d2=43.4,h=coverh2);
      translate([0,0,threadh+coverh1+coverh2-0.01]) cylinder(d1=cover2d,d2=cover2d+coverspread*2,h=coverspread);
      hull() {
	translate([0,0,threadh+coverh1+coverh2+coverspread-0.01]) cylinder(d=cover2d,h=nuth,$fn=6);
      }
    }
    
    translate([0,0,-0.01]) cylinder(d=adapterd+dtolerance,h=axlebottomh+0.02);
    hull() {
      translate([0,0,axlebottomh]) cylinder(d1=adapterd+dtolerance,d2=axled,h=axlenarrowing);
      translate([0,0,axlebottomh+axlenarrowing]) cylinder(d=axled+dtolerance,h=axleh);
      translate([0,0,axlebottomh+axlenarrowing+axleh]) cylinder(d2=adapterd+dtolerance,d1=axled+dtolerance,h=axlenarrowing);
    }
    translate([0,0,threadh-axletoph-0.01]) cylinder(d=adapterd+dtolerance,h=axlebottomh+0.02);
    height=threadh-axletoph;
    hull() {
      translate([0,0,height+axlebottomh]) cylinder(d1=adapterd+dtolerance,d2=axled,h=axlenarrowing);
      translate([0,0,height+axlebottomh+axlenarrowing]) cylinder(d=axled+dtolerance,h=axleh);
      translate([0,0,height+axlebottomh+axlenarrowing+axleh]) cylinder(d2=adapterd+dtolerance,d1=axled+dtolerance,h=axlenarrowing);
    }
    translate([0,0,height+axlenarrowing+axleh+axlenarrowing]) cylinder(d=adapterd+dtolerance,h=adapterspaceh+nuth);
  }
}

intersection() {
  union() {
    filteradapter();
    cpaptube();
  }
  if (debug) translate([-100,0,0]) cube([200,100,200]);
}

if (0) translate([coverxstart+coverl+wall+2+insideadapterd/2,0,0]) {
  difference() {
    h=(insidetubed-ringcutd)/2;
    union() {
      roundedcylinder(insideadapterd,insideadapterh,cornerd,1,90);
      roundedcylinder(insidetubed,insideadapterh+insidetubeh,cornerd,1,90);
      roundedcylinder(ringcutd,insideadapterh+insidetubeh+ringcuth+insidetubemidh,cornerd,1,90);
      translate([0,0,insideadapterh+insidetubeh+ringcuth+h/2]) roundedcylinder(insidetubed,insidetubemidh-h/2,cornerd,0,90);
      intersection() {
	hull() {
	  translate([0,0,insideadapterh+insidetubeh+ringcuth+h/2]) roundedcylinder(insidetubed,insidetubemidh+insidetubetoph-h/2,cornerd,1,90);
	  translate([0,0,insideadapterh+insidetubeh+ringcuth-h/2]) roundedcylinder(ringcutd,insidetubemidh+insidetubetoph,cornerd,1,90);
	}
	union() {
	  translate([topcutx,-topcutw/2,insideadapterh+insidetubeh+ringcuth-h]) roundedbox(insideadapterd,topcutw,insidetubemidh+insidetubetoph+h,cornerd,0);
	  translate([0,0,insideadapterh+insidetubeh+ringcuth-h]) roundedcylinder(insidetubed,insidetubemidh+h,cornerd,0,90);
	}
      }
      intersection() {
	translate([0,0,insideadapterh+insidetubeh+ringcuth+insidetubemidh+insidetubetoph-cliph]) roundedcylinder(insidetubed+clipd*2,cliph,cornerd,1,90);
	translate([topcutx,-topcutw/2,insideadapterh+insidetubeh+ringcuth]) roundedbox(insidetubed/2-topcutx,topcutw,insidetubemidh+insidetubetoph,cornerd,0);
      }
      intersection() {
	roundedcylinder(insideadapterd,insideadapterh+notchh,cornerd,1,90);
	translate([-insideadapterd/2,-notchw/2,0]) roundedbox(insideadapterd/2,notchw,insideadapterh+notchh,cornerd,1);
      }
    }

    translate([0,0,insidecutheight]) roundedcylinder(insidecutd,insidecuth,cornerd,0,90);
    translate([0,0,insideholeh]) roundedcylinder(insideholed,insideadapterh+insidetubetotalh,cornerd,0,90); 
    translate([topcutx-sidecutl,-insideadapterd/2,insidecutheight]) roundedbox(sidecutl,insideadapterd,insidecuth,cornerd,0);
    rotate([0,0,insidetuberotate]) translate([insidetubex,0,-0.01]) cylinder(d=tubed,h=insideadapterh+insidetubetotalh);
  }
}
