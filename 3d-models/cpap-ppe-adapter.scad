include <threads.scad>

debug=0;
adhesion=1;
tube=0;

dtolerance=0.5;

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
tubex=-externald1/2;
tubey=cover2d/2-tubed/2;
tubeangle=-20;

outholex=13;
outholed=1.5;
outholeangle=-30;

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
	  translate([coverxstart+coverl/2,0,0]) scale([coverl/coverw,1,1]) cylinder(d=coverw,h=coverbaseh);
	  translate([coverxstart+coverl-coverd/2,0,0]) cylinder(d=coverd,h=coverbaseh);

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
	hull() {
	  // Bottom shape
	  translate([coverxstart+coverd/2+3,0,-0.01]) cylinder(d=coverd-edgew-5,h=coverbasecuth);
	  translate([coverxstart+coverl/2+3,0,-0.01]) scale([(coverl-4)/coverw,1,1]) cylinder(d=coverw-edgew,h=coverbasecuth);
	  translate([coverxstart+coverl-coverd/2,0,-0.01]) cylinder(d=coverd-edgew,h=coverbasecuth);

	  // top
	  translate([0,0,coverheight-coverh]) cylinder(d1=cover2d+dtolerance,d2=cover2d+dtolerance,h=coverh);
	}
      
	for (i=[1:1:4]) {
	  for (j=[1:1:4]) {
	    translate([coverxstart+outholex+edgew+outholed*2+i*outholed*1.5,-outholed*2.5*1.5+j*outholed*1.5,0]) rotate([0,outholeangle,0]) cylinder(d=outholed,h=coverheight);
	  }
	}

	if (tube) translate([tubex,tubey,0]) rotate([0,tubeangle,0]) cylinder(d=tubed,h=adapterheight);
      }
      translate([0,0,-0.01]) cylinder(d=externald2+dtolerance,h=coverheight+0.02);
    }
  }

  if (adhesion) cylinder(d=cpaptubeind-0.15*2,h=0.2);
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
    #if (0) {
      hull() {
	cylinder(d1=50.75,d2=43.3,h=threadh-dtolerance*2);
	scale([28.4*2/43.3,1,1]) cylinder(d1=50.75,d2=43.3,h=0.1);
      }
      cylinder(d=43.3,h=threadh-dtolerance*2+4);
    }
  }
  if (debug) translate([-100,-100,0]) cube([200,100,200]);
}

