// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

print=0; // 0=full holder, 1=both holder parts in one print, 2=lowerpart, 3=upper pad holder part, 4=screw test. 5=clip
light=1;
strong=1; // strenghten screwholes. Slow.

versiontext="v1.2";
textsize=8;
textdepth=2;

topwidth=215;
edgewall=5;
edgedepth=15;

// pulse sensor hanger
pulsesensorhangerlength=15;

basethickness=7.8;
basewidth=topwidth; //50;
basebelow=15;
screwd=18;
screwtoa=89;
angle=220.6-180;
atotop=50;
topdepth=43;
toplid=21;//16; //edgewall;
toplidthickness=5;
toplidnotch=5;
cornerd=2;

displayangle=9;
displaywidth=245;
displayheight=187.5;
displaythickness=10;
displaybottomh=5;//xxx
displayholderthickness=11;
displayholderh=4;
displaysupportbelowt=12.5;
lholed=25;
lstart=-topwidth/2+lholed;
lholesx=floor((topwidth-lholed)/(lholed*1.5));
lwidth=(topwidth-2*lholed)/lholesx;
lend=lstart+lholesx*lwidth;
lholecutdepth=70;
lholecuty=-lholecutdepth/2+5;
displaybottom=screwtoa+cos(angle)*atotop+cos(90-angle)*(topdepth+basethickness);
displaybase=edgewall+1;
lowerholeh=displaybottom+lholed*0.8;
upperholeh=displayheight-lholed*1.5;
lztable=[[lholed-10,110],[lowerholeh,upperholeh]];

topscrewholed=3.5;
topscrewholebase=1; // countersink
topscrewlength=19;
topscrewfronty=displaythickness+topscrewholed+8;
topscrewbacky=-20;
sidescrewsupport=topscrewlength*4;

clipfronth=10;
clipbackh=(displaybottom+displaybase+displayheight) - (lowerholeh+upperholeh)-6;
clipwidth=40;
clipwall=5;
clipdepth=displaythickness+displayholderthickness-1.5;
clipplugd=10;
cliptolerance=0.3;

module deeptext(teksti, height, depth, ha) {
  h=depth/3;
  translate([0,0,h*2]) linear_extrude(height=h) text(teksti,size=height,font="Liberation Sans:style=Bold",halign=ha);

  for (xb=[-0.1,0.1]) {
    for (yb=[-0.1,0.1]) {
      translate([xb,yb,h]) linear_extrude(height=h+0.01) text(teksti,size=height,font="Liberation Sans:style=Bold",halign=ha);
    }
  }

  for (xs=[-0.2,0.2]) {
    for (ys=[-0.2,0.2]) {
      translate([xs,ys,0]) linear_extrude(height=h+0.01) text(teksti,size=height,font="Liberation Sans:style=Bold",halign=ha);
    }
  }
}

countersinkheightmultiplier=0.63;
countersinkdiametermultiplier=2.4;

// If display is angled, move screwholes inward accordingly.
y1=cos(displayangle) * topscrewfronty;
z1=sin(displayangle) * topscrewfronty;
y2=y1-z1/2;
zd=(y2-(topscrewholed*countersinkdiametermultiplier/2))*sin(displayangle);

screwyshift=y2 - topscrewfronty;
screwzshift=zd;      

module ruuvireika(height,diameter,countersink) {
  $fn=90;
  cylinder(h=height,d=diameter-0.1); // Slightly smaller hole

  if (strong) {
    if (1) {
      for (i=[0:1:(diameter*countersinkdiametermultiplier-(diameter+0.4)+4)/2]) {
	di=diameter+0.4+i*2;
	translate([0,0,-1])
	  difference() {
	  cylinder(h=height+1-0.1,d=di+0.05,$fn=20);
	  translate([0,0,-0.01]) cylinder(h=height+1+0.02,d=di,$fn=20);
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

//ruuvireika(10,4,1);

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

module tunturiholder() {
  difference() {
    union() {
      difference() {
	translate([-basewidth/2-cornerd,0,-basebelow]) roundedbox(basewidth+cornerd*2,basethickness,basebelow+screwtoa,cornerd);
	translate([0,-0.01,0]) rotate([270,0,0]) {
	  cylinder(d=screwd,h=basethickness+0.02);
	}
	translate([-screwd/2,-0.01,-basebelow-0.01]) cube([screwd,basethickness+0.02,basebelow+0.02]);
      }

    // Screwtowers
    for (x=[-basewidth*0.8/2,0,basewidth*0.8/2]) {
      translate([x,topscrewfronty+screwyshift,displaybottom+displaybase-topscrewlength+screwzshift]) cylinder(h=topscrewlength,d=topscrewholed*2.5,$fn=30);
      translate([x,topscrewfronty+screwyshift,displaybottom+displaybase-topscrewlength+screwzshift-2]) cylinder(h=2+0.01,d1=topscrewholed*1,d2=topscrewholed*2.5,$fn=30);
    }

    for (x=[-displaywidth/2+3,displaywidth/2-3]) {
      translate([x,topscrewbacky,displaybottom+displaybase-topscrewlength]) cylinder(h=topscrewlength,d=topscrewholed*2.5,$fn=30);
      translate([x,topscrewbacky,displaybottom+displaybase-topscrewlength-2]) cylinder(h=2+0.01,d1=topscrewholed*1,d2=topscrewholed*2.5,$fn=30);
    }
      

    hull() {
	translate([-basewidth/2-cornerd,0,screwtoa-cornerd]) roundedbox(basewidth+2*cornerd,basethickness,cornerd,cornerd);
	translate([-basewidth/2-cornerd,0,screwtoa]) rotate([angle]) roundedbox(basewidth+2*cornerd,basethickness,cornerd,cornerd);
      }
      translate([-basewidth/2-cornerd,0,screwtoa]) rotate([angle]) {
	roundedbox(basewidth+2*cornerd,basethickness,atotop+toplidthickness,cornerd);
	translate([0,0,atotop]) roundedbox(basewidth+2*cornerd,topdepth+basethickness+toplidnotch,toplidthickness,cornerd);
	translate([0,topdepth+basethickness,atotop-toplid]) roundedbox(basewidth+2*cornerd,toplidnotch,toplid+cornerd,cornerd);
      }
      depth=sin(angle)*atotop+basethickness;
      // right side
      translate([-basewidth/2-edgewall,-depth+edgewall,-basebelow]) roundedbox(edgewall,depth+edgedepth,displaybottom+basebelow+cornerd,cornerd);
      translate([-basewidth/2-edgewall+cornerd/2-topscrewholed*3.5,-depth+edgewall+cornerd/2,displaybottom-sidescrewsupport]) triangle(topscrewholed*3.5,depth+edgedepth-cornerd,sidescrewsupport+0.01,3);
      // left side
      translate([basewidth/2,-depth+edgewall,-basebelow]) roundedbox(edgewall,depth+edgedepth,displaybottom+basebelow+cornerd,cornerd);
      translate([basewidth/2+edgewall-cornerd/2,-depth+edgewall+cornerd/2,displaybottom-sidescrewsupport]) triangle(topscrewholed*3.5,depth+edgedepth-cornerd,sidescrewsupport+0.01,1);
      // top
      translate([-displaywidth/2-edgewall,0,displaybottom]) roundedbox(displaywidth+2*edgewall,displaythickness+displayholderthickness+edgewall,displaybase,cornerd);
      
      translate([-displaywidth/2,0,displaybottom]) rotate([displayangle,0,0]) {
	roundedbox(displaywidth,displaythickness,displaybase+displayheight,cornerd);

	translate([-edgewall,0,0]) roundedbox(displaywidth+2*edgewall,displaythickness+displayholderthickness+edgewall,displaybase,cornerd);
      
	translate([-edgewall,displaythickness+displayholderthickness,0]) roundedbox(displaywidth+2*edgewall,edgewall+1,displaybase+displayholderh,cornerd);
      translate([-edgewall,0,0]) roundedbox(edgewall,displaythickness+displayholderthickness+edgewall,displaybase+displayholderh,cornerd);      
      translate([displaywidth,0,0]) roundedbox(edgewall,displaythickness+displayholderthickness+edgewall,displaybase+displayholderh,cornerd);
      translate([-edgewall,0,0]) roundedbox(displaywidth+2*edgewall,displaythickness,displaybase+displayholderh,cornerd);
      }

      hull() {
	translate([-displaywidth/2+2*edgewall,-depth+edgewall+cornerd/2+0.01,displaybottom+edgewall-0.01]) roundedbox(edgewall,1,1,cornerd);
	translate([-displaywidth/2+2*edgewall,edgewall+cornerd/2+0.01,displaybottom+edgewall-0.01]) roundedbox(edgewall,1,1,cornerd);
	translate([-displaywidth/2+2*edgewall,edgewall+cornerd/2+0.01,displaybottom+edgewall-0.01]) rotate([displayangle,0,0]) translate([0,0,displayheight/2]) roundedbox(edgewall,1,1,cornerd);
      }
      hull() {
	translate([displaywidth/2-3*edgewall,-depth+edgewall+cornerd/2+0.01,displaybottom+edgewall-0.01]) roundedbox(edgewall,1,1,cornerd);
	translate([displaywidth/2-3*edgewall,edgewall+cornerd/2+0.01,displaybottom+edgewall-0.01]) roundedbox(edgewall,1,1,cornerd);
	translate([displaywidth/2-3*edgewall,edgewall+cornerd/2+0.01,displaybottom+edgewall-0.01]) rotate([displayangle,0,0]) translate([0,0,displayheight/2]) roundedbox(edgewall,1,1,cornerd);
      }
      
      translate([-displaywidth/2-edgewall,-depth+edgewall,displaybottom]) roundedbox(4*edgewall,displaythickness+displayholderthickness+depth,displaybase,cornerd);
      translate([displaywidth/2-edgewall-2*edgewall,-depth+edgewall,displaybottom]) roundedbox(4*edgewall,displaythickness+displayholderthickness+depth,displaybase,cornerd);
      translate([-basewidth/2-cornerd,displaythickness,displaybottom-displaysupportbelowt]) triangle(basewidth+2*cornerd,displaythickness+3,displaysupportbelowt,9);

      // pulse sensor hanger
      translate([displaywidth/2,0,displaybottom]) roundedbox(edgewall+pulsesensorhangerlength+edgewall,edgewall,edgewall,cornerd);
      translate([displaywidth/2+edgewall+pulsesensorhangerlength,0,displaybottom]) roundedbox(edgewall,edgewall,2*edgewall,cornerd);
    }

    if (light) {
      //lightening holes
      for (x=[lstart:lwidth:lend]) {
	for (zt=lztable) {
	  hull() {
	    translate([x,lholecuty,zt[0]+lholed]) rotate([-90,0,0]) cylinder(h=lholecutdepth,d=lholed);
	    translate([x,lholecuty,zt[0]]) rotate([-90,0,0]) cylinder(h=lholecutdepth,d=5);
	    translate([x,lholecuty,zt[0]+zt[1]-lholed]) rotate([-90,0,0]) cylinder(h=lholecutdepth,d=lholed);
	    translate([x,lholecuty,zt[0]+zt[1]]) rotate([-90,0,0]) cylinder(h=lholecutdepth,d=5);
	  }
	}
      }
    }

    // Screwholes
    for (x=[-basewidth*0.8/2,0,basewidth*0.8/2]) {
      translate([x,topscrewfronty+screwyshift,displaybottom+displaybase-topscrewlength+screwzshift+0.01]) ruuvireika(topscrewlength,topscrewholed,1);
      translate([x,topscrewfronty+screwyshift,displaybottom+displaybase+screwzshift]) cylinder(h=topscrewlength,d=topscrewholed*countersinkdiametermultiplier,$fn=30);
    }

    for (x=[-displaywidth/2+3,displaywidth/2-3]) {
      translate([x,topscrewbacky,displaybottom+displaybase-topscrewlength+0.01]) ruuvireika(topscrewlength,topscrewholed,1);
    }

   translate([-basewidth/2+textsize/2,textdepth-0.01,-basebelow+textsize/2]) rotate([90,0,0]) deeptext(versiontext,textsize,textdepth,"left");
   translate([-basewidth/2+textsize/2,textdepth-0.01,displaybottom]) rotate([displayangle,0,0]) translate([0,0,displaybase]) rotate([90,0,0]) deeptext(versiontext,textsize,textdepth,"left");

   translate([0,displaythickness/2+0.01,displaybottom]) rotate([displayangle,0,0]) translate([0,0,displaybase+displayheight-clipbackh-clipplugd]) rotate([90,0,0]) cylinder(h=displaythickness/2+0.02,d1=1-cliptolerance,d2=clipplugd-cliptolerance,$fn=90);

  }
}

module clip() {
  difference() {
    union() {
      translate([-clipwidth/2,-clipwall,displaybottom+displaybase+displayheight]) roundedbox(clipwidth,clipwall+clipdepth+clipwall,clipwall,cornerd);
      translate([-clipwidth/2,clipdepth,displaybottom+displaybase+displayheight-clipfronth]) roundedbox(clipwidth,clipwall,clipwall+clipfronth,cornerd);
      hull() {
	translate([-clipwidth/2,-clipwall,displaybottom+displaybase+displayheight-clipbackh]) roundedbox(clipwidth,clipwall,clipwall+clipbackh,cornerd);
	translate([0,-clipwall+clipwall,displaybottom+displaybase+displayheight-clipbackh-clipplugd]) rotate([90,0,0]) cylinder(h=clipwall,d=clipplugd);
      }
      translate([0,-clipwall+clipwall+clipwall,displaybottom+displaybase+displayheight-clipbackh-clipplugd]) rotate([90,0,0]) cylinder(h=displaythickness/2,d1=1,d2=clipplugd-cliptolerance,$fn=90);
    }

    translate([0,0,displaybottom+displaybase+displayheight+clipwall-textdepth+0.01]) deeptext(versiontext,textsize,textdepth,"center");
  }
}

if (print==0) {
  tunturiholder();
  clip();
 }

if (print==1 || print==2) {
  translate([0,-36,displaybottom]) rotate([180,0,0])
  intersection() {
    tunturiholder();
    translate([-displaywidth/2-40,-60,-basebelow]) cube([displaywidth+80,120,basebelow+displaybottom]);
  }
 }

if (print==1 || print==3) {
  translate([0,36,-displaybottom]) intersection() {
    tunturiholder();
    translate([-displaywidth/2-40,-60,displaybottom]) cube([displaywidth+80,120,displayheight+50]);
      }
 }

if (print==4) {
  translate([0,-29,displaybottom]) rotate([180,0,0])
  intersection() {
    tunturiholder();
    translate([-displaywidth/2-25,-28,displaybottom-15]) cube([40,20,15]);
  }
  translate([0,30,-displaybottom]) intersection() {
    tunturiholder();
    translate([-displaywidth/2-20,-30,displaybottom]) cube([40,20,7]);
      }
 }

if (print==5) {
  translate([0,0,displaybottom+displaybase+displayheight+clipwall]) rotate([180,0,0]) clip();
 }
