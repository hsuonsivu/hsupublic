// 0=working model, 1=full printout, 2=single bar test

print=0;
debug=0;
strong=((print==0)||(print==2)) ? 0 : 1;

versiontext="V 1.0";
// How deep text is cut
textdepth=0.8;
textsize=7;

$fn=90;
tolerance=0.2; // Any narrow tolerance

slidewall=1.5;
slidesupportdistance=50; // Distance between T's
slidesupportwidth=10; // width of T
slidewidthout=slidesupportdistance+slidesupportwidth+slidewall*2;
slidedepth=2.4;// 1.5+, thickness of attachment
slidethickness=2.4;// 1.5+, thickness of attachment support
slideinside=slidewidthout-2*slidesupportwidth-2*slidewall-2*slidewall;
holderheight=60;//80.5;
holderbasetotalwidth=125;
holderbasewidth=34.5;
holderbaseheight=holderheight-27;
holderbasez=slidewall+slidedepth+6;
holderthicknessin=11.5;
holderthicknessout=16;
holderinsideheight=6.1;
holderinsidescrewtowerd=8;
holdernotchy=-2.2;
holdernotchd=2;
holderendwidth=23;
holderendx=1.5;
holderendheight=3.2;
holderendymidstart=holderbaseheight*2/3;
holderendystart=holderbaseheight/2;
holderwidth=slidewidthout; //cardlength=slidewidthout;//160.5;
wall=2.5;
cornerd=1;

holderbottomheight=holderbaseheight-5;

holderbottomwidth=holderbasetotalwidth-20;
  
screwout=20.36; // screwhole in base
screwlength=29;
screwmaxinsert=27;
screwholed=4; // ulkohalkaisija kierteen päällä 4mm
screwtowerd=screwholed*3;
screwbasewall=wall+1; // must be no more than wall...

middlecableholed=32;
middlecableholecenter=6+middlecableholed/2;

countersinkheightmultiplier=0.63;
countersinkdiametermultiplier=2.4;

module ruuvireika(height,diameter,countersink,makestrong) {
  $fn=90;
  cylinder(h=height,d=diameter-0.1); // Slightly smaller hole

  if (makestrong) {
    if (1) {
      maxd=diameter*countersinkdiametermultiplier-(diameter+0.4)+1;
      for (i=[0:1:maxd]) {
	di=diameter+0.4+i*2;
	// i=maxd -> 0, i=0 >diameter/3
	hfix=(maxd-i)/maxd*screwtowerd/3-0.1;
	translate([0,0,-1])
	  difference() {
	  translate([0,0,-hfix]) cylinder(h=height+hfix+1-0.1,d=di+0.03,$fn=20);
	  translate([0,0,-0.01-hfix]) cylinder(h=height+hfix+1+0.02,d=di,$fn=20);
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
    translate([x-slidesupportwidth/2,-0.01,slidewall]) cube([slidesupportwidth,holderheight+0.02,slidedepth]);
    translate([x-slidethickness/2,-0.01,-0.01]) cube([slidethickness,holderheight+0.02,slidewall+0.02]);
}

module oneholder(x,y,z) {
  difference() {
    union() {
      hull() {
	translate([x,y+holderendystart,z]) roundedbox(holderbasewidth,holderbaseheight-holderendystart,holderthicknessout,cornerd);
      }
      translate([x,y+holderbaseheight-cornerd,z+holderthicknessout/2-holderthicknessin/2]) roundedbox(holderbasewidth,holderinsideheight+cornerd,holderthicknessin,cornerd);

      hull() {
	translate([x,y+holderendymidstart,z-(holderendwidth-holderthicknessout)/2]) roundedbox(holderendx,holderbaseheight+holderendheight-holderendymidstart,holderendwidth,cornerd);
	translate([x,y+holderendystart,z]) roundedbox(holderendx,holderbaseheight+holderendheight-holderendystart,holderthicknessout,cornerd);
      }
      hull() {
	translate([x+holderbasewidth-holderendx,y+holderendymidstart,z-(holderendwidth-holderthicknessout)/2]) roundedbox(holderendx,holderbaseheight+holderendheight-holderendymidstart,holderendwidth,cornerd);
	translate([x+holderbasewidth-holderendx,y+holderendystart,z]) roundedbox(holderendx,holderbaseheight+holderendheight-holderendystart,holderthicknessout,cornerd);
      }
    }
    translate([x+holderbasewidth/2,y+holderbaseheight,z+holderthicknessout/2]) rotate([-90,0,0]) cylinder(h=holderinsideheight+0.01,d=holderinsidescrewtowerd);
    translate([x,y+holderbaseheight+holdernotchy,z-(holderendwidth-holderthicknessout)/2-0.01]) cylinder(h=holderendwidth+0.02,d=holdernotchd);
    translate([x+holderbasewidth,y+holderbaseheight+holdernotchy,z-(holderendwidth-holderthicknessout)/2-0.01]) cylinder(h=holderendwidth+0.02,d=holdernotchd);
  }
}

module basebind() {
  hull() {
    translate([middlecableholed/2+cornerd,cornerd,slidewall+slidedepth+cornerd]) sphere(cornerd);
    translate([slidewidthout/2,cornerd,slidewall+slidedepth+cornerd]) sphere(cornerd);
    translate([slidewidthout/2+holderendwidth,cornerd,holderbasez+cornerd]) sphere(cornerd);
    translate([slidewidthout/2+holderendwidth,cornerd,holderbasez+holderthicknessout-cornerd]) sphere(cornerd);
    translate([holderbasetotalwidth/2-holderbasewidth+cornerd,cornerd,holderbasez+holderthicknessout-cornerd]) sphere(cornerd);
    translate([holderbasetotalwidth/2-holderbasewidth+cornerd,holderendystart,slidewall+slidedepth+cornerd]) sphere(cornerd);
    translate([holderbasetotalwidth/2-holderbasewidth,holderendystart,holderbasez]) roundedbox(holderbasewidth,cornerd,holderthicknessout,cornerd);
  }
}

module cableholder() {
  difference() {
    union() {
      basebind();
      mirror([1,0,0]) basebind();
      
      oneholder(-holderbasetotalwidth/2,0,holderbasez);
      oneholder(holderbasetotalwidth/2-holderbasewidth,0,holderbasez);

      // Attachment
      difference() {
	translate([-slidewidthout/2-slidewall,0,0]) roundedbox(slidewidthout+2*slidewall,holderheight,slidewall+slidedepth+wall,cornerd);
	slidecut(-slidesupportdistance/2);
	slidecut(slidesupportdistance/2);
      }

    }
    for (x=[-holderbasetotalwidth/2,holderbasetotalwidth/2-holderbasewidth]) {
      length=screwout;
      hull() {
	translate([x+holderbasewidth/2,-0.01,holderbasez+holderthicknessout/2]) rotate([-90,0,0]) cylinder(h=1,d=screwtowerd);
	translate([x+holderbasewidth/2,holderbaseheight-screwout+1+0.01,holderbasez+holderthicknessout/2]) rotate([90,0,0]) ruuvireika(1+0.03,screwholed,1,0);
      }
      translate([x+holderbasewidth/2,holderbaseheight-screwout+length+0.01,holderbasez+holderthicknessout/2]) rotate([90,0,0]) ruuvireika(length+0.03,screwholed,1,strong);
    }
    hull() {
      translate([0,middlecableholecenter+middlecableholed/2,-0.01]) cylinder(h=holderthicknessout+holderbasez+1,d=6);
      translate([0,middlecableholecenter,-0.01]) cylinder(h=holderthicknessout+holderbasez+1,d=middlecableholed);
      translate([0,0,-0.01]) cylinder(h=holderthicknessout+holderbasez+1,d=middlecableholed);
    }

    if (debug) {
    translate([holderbasetotalwidth/2-holderbasewidth/2,0,0]) cube([holderbasewidth,holderheight,holderheight]);
    }

    translate([0,holderheight-textsize,slidewall+slidedepth+wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

  }
}

if (print==0) {
  cableholder();
 }

if (print==1) {
  translate([0,0,0]) rotate([90,0,90]) cableholder();
 }

if (print==2) {
  translate([0,0,0]) rotate([90,0,90]) difference() {
    cableholder();
    translate([-holderbasetotalwidth/2+holderbasewidth,-0.01,-0.01]) cube([holderbasetotalwidth+holderbasewidth+1,holderheight+1,holderbasez+holderwidth*2]);
   translate([-holderbasetotalwidth,-0.01,-0.01]) cube([holderbasetotalwidth+holderbasewidth+1,holderheight+1,slidewall+slidedepth]);
   translate([-holderbasetotalwidth,holderbaseheight+holderinsideheight,-0.01]) cube([holderbasetotalwidth,holderheight,holderbasez+holderwidth*2]);
  }
 }

