// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO:
// Jatka ulosmenevan aukon taso, jotta hiiren on helpompi painaa se alas, tasapainotus tarkistettava.
// Ulosmenevan aukon alaosa cornerd:lla
// Vastaavasti cover muutokset, ehka samalla tavalla kuin incoming kattokin.

include <hsu.scad>

print=0;
adhesion=(print>0 && print<6)?1:0;
debug=0;
antiwarp=(print>0)?1:0;
antiwarpdistance=4; //3 mm
antiwarpw=0.8;

// Make some voids in thicker parts. May save material if dense fill is used. At 10% fill, using fill is cheaper.
makevoids=0; 

version="V1.0";
name="Heikki's Mousetrap";
versiontext=str(name, " ",version);
textdepth=0.8;
textsize=7;
copyrighttext="© heikki@suonsivu.net CC-BY-NC-SA";
copyrighttextsize=textsize-3;
textoffset=2+textsize/2;
copyrighttextoffset=textsize/2+textoffset+1;

cornerd=1;

wall=3;
xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;
axledtolerance=0.8;
dtolerance=0.5;
maxbridge=10;
cutsmall=3;

$fn=60;

swingw=50;
swingh=50;
swingl=150; //135; //235/2; // Length of one arm
swingtoplreduction=0;
swingsideh=20;
angle=20;//20 in closed up; 5 down in open lock
closedangle=20; 
openangle=closedangle;
axleheight=28;//25;
axled=7;
axlel=wall;
axledepth=2;
smallstepx=5;
smallstependd=0.4;

swingheight=wall;//axleheight;

midwallw=axledepth+ytolerance+wall*2+ytolerance+axledepth;

boxh=swingh+50;

boxincornerd=20; // round corners to avoid mice eating through
boxcornerd=cornerd;

clipdepth=1.00+max(xtolerance,ytolerance);
clipd=wall+clipdepth;
clipl=20;
clipheight=boxh-wall-ztolerance-clipd/2;

swingtunnelw=ytolerance+wall/2+swingw+wall/2+ytolerance;

lockaxleheight=axled/2+wall/2;
lockaxled=axled;
lockaxlex=-swingl/2-20;//8;
lockaxledepth=2;
lockangle=27;//27;//29.7;//29.7;//23=release in plate, 29.7=locked;
lockangleprint=0;
lockweightl=30;
lockweighth=15;
lockweightw=wall*2;
lockaxleyoffset=0;
lockaxlel=wall+ytolerance+midwallw+ytolerance+wall+lockaxleyoffset;
lockaxley=-swingtunnelw/2-midwallw/2-lockaxleyoffset/2; // midpoint
locklefty=-swingtunnelw/2+ytolerance+wall;
lockrighty=-swingtunnelw/2-midwallw-ytolerance-wall;

boxx=lockaxlex-lockaxled/2;
boxl=248; //235  -boxx+swingl-25;
boxw=wall+swingtunnelw+midwallw+swingtunnelw+wall;
boxy=swingtunnelw/2+wall-boxw;

doorl=50;
doorw=wall;
doorhandleh=15;
doorh=boxh-wall+doorhandleh;
dooroverlap=10;
doorholel=doorl-2;
doorholeh=doorl-5-wall;

//swingweightl=lockaxled+wall*4; //-lockaxlex-swingl/2+lockaxled/2;
swingweightl=-lockaxlex-swingl/2+lockaxled/2;
swingweighth=wall;
weigthvoids=1;

midholel=46+15;
midholex=boxx+boxl-wall-midholel; //boxl-wall-midholel;
midholey=-swingtunnelw/2-midwallw;
midwalll=midholex-boxx;
  
outholel=46;
outholeh=50; //outholel;

storageboxl=230-8-boxincornerd/2-2-8-4;
storageboxw=120;
storageboxx=boxx-storageboxl-xtolerance;
storageboxy=-swingtunnelw/2-storageboxw;
storageboxh=boxh;
storageboxoutcornerd=boxincornerd+wall*2;
  
storagel=storageboxl-wall*2;
storageh=storageboxh-wall*2+boxincornerd;
storagew=storageboxw-wall*2;

swingtunnelh=storageh;

boxlockpind=8;
boxlockh=2;
boxlockpinh=wall*2-0.4-ztolerance;
boxlockl=boxlockh+10/2+boxlockpind+boxlockpind/2;
boxlockw=swingtunnelw-wall-lockaxledepth/2-wall/2-lockaxledepth+ytolerance-10-1;
boxlocky=-swingtunnelw/2-midwallw-swingtunnelw+10/2;
boxlockpinholex=boxx+wall+10/2+boxlockpind/2;
boxlockpinholeh=boxlockpinh+ztolerance;
boxlockpinholeytable=[boxlocky+5+boxlockpind/2,boxlocky+boxlockw-5-boxlockpind/2];

boxclipxpositions=[boxx+boxl/4-clipl,boxx+boxl/2-clipl,boxx+boxl-boxl/4-clipl];

mouseh=midholel; // Size of tunnels for a mouse to crawl through

// Circular hole cut for swing movement
module swingcut() {
  swingtunneld=swingl+xtolerance+2;
  hull() {
    intersection() {
      translate([0,-swingtunnelw/2,axleheight]) rotate([-90,0,0]) cylinder(d=swingtunneld,h=swingtunnelw);
      hull() {
	translate([-swingl/2+wall*0.5,-swingtunnelw/2,wall]) roundedbox(swingl-wall*1,swingtunnelw,swingtunnelh,cornerd);
	translate([-swingl/2-wall,-swingtunnelw/2+wall,wall*2]) roundedbox(swingl+2*wall,swingtunnelw-wall*2,swingtunnelh-wall*2,cornerd);
      }
    }
  }
  hull() {
    intersection() {
      //      translate([0,-swingtunnelw/2,axleheight]) rotate([-90,0,0]) cylinder(d=swingtunneld,h=swingtunnelw);
      translate([0,-swingtunnelw/2,wall]) roundedbox(swingl/2+wall*3,swingtunnelw,wall*3,cornerd);
      hull() {
	translate([-swingl/2+wall*0.5,-swingtunnelw/2,wall]) roundedbox(swingl-wall*1,swingtunnelw,wall*3,cornerd);
	translate([-swingl/2-wall,-swingtunnelw/2+wall,wall*2]) roundedbox(swingl+2*wall,swingtunnelw-wall*2,wall*2,cornerd);
      }
    }
  }
}

module coverswingcut(x,y,z,l,h,w,axleheight,d,c) {
  intersection() {
    translate([x,y,axleheight]) rotate([-90,0,0]) cylinder(d=d,h=w);
    translate([x-l,y,z]) roundedbox(l*2,w,h,c);
  }
}

module swingside(y,l) {
  zz=(1-(swingl/2)/(-lockaxlex))*swingheight+wall;
  yy=l?y:-y;
  yyy=l?y-0.5:-y+0.5;
  
  hull() {
    translate([-swingl/2,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
    translate([0,yy,swingheight+wall/2]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
    translate([0,yyy,swingheight+wall/2+swingsideh]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
    translate([-swingl/2,yyy,swingheight+wall+swingsideh]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
  }
}

module swing(a,l) {
  translate([0,0,axleheight]) rotate([0,a,0]) translate([0,0,0]) {
    // Swing floor
    difference() {
      for (x=[-swingl/2,swingl/2-0.1]) {
	difference() {
	  union() {
	    hull() {
	      for (y=[-swingw/2,swingw/2]) {
		yy=-sign(y)/2+y;
		yyy=yy+(l&&(y<0)&&(x<0)?wall*2+1:0);
		for (y=[-swingw/2,swingw/2]) {
		  if (l && x>0) {
		    if (x>0) {
		      translate([x,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		      translate([x+smallstepx,y-sign(y)*wall/2,swingheight+wall/2+smallstepx*sin(closedangle)]) rotate([0,90,0]) cylinder(d=smallstependd,h=0.1);
		    }
		  }
		}
	      }
	    }

	    if (0) hull() {
	      for (y=[-swingw/2,swingw/2]) {
		for (y=[-swingw/2,swingw/2]) {
		  if (!l && x<0) {
		    if (x<0) {
		      translate([x,y+(y>0?-wall*2-0.5-ytolerance:0.5),swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		      translate([x-smallstepx,y+(y>0?-wall-0.5-ytolerance-smallstependd/2:0)-sign(y)*wall/2,swingheight+wall/2+smallstepx*sin(closedangle)]) rotate([0,90,0]) cylinder(d=smallstependd,h=0.1);
		    }
		  }
		}
	      }
	    }
	    
	    hull() {
	      for (y=[-swingw/2,swingw/2]) {
		yy=-sign(y)/2+y;
		yyy=yy+(l&&(y<0)&&(x<0)?wall*2+1:0);
		if (!l && x<0 && y>0) {
		  translate([x+wall,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x,yyy-wall*1.25,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		} else {
		  translate([x,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
		if (l && x<0) {
		  translate([x+wall*2,yy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x,yyy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x+wall*2,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
		if (!l && x>0) {
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
		translate([-0.01*sign(x),yy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
	      }
	    }
	    if (!l && x>0) {
	      hull() {
		for (y=[-swingw/2,swingw/2]) {
		  yy=-sign(y)/2+y;
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x+swingweightl,yy,swingheight+wall+sin(closedangle)*swingweightl]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
	      }
	    } 
	    if (l && x<0) {
	      hull() {
		for (y=[-swingw/2+wall*2,swingw/2]) {
		  yy=-sign(y)+0.5+y;
		  yyy=yy+(y<0?0.5:0);
		  //yyy=-sign(y)*1+y;
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x-swingweightl,yyy,swingheight+wall+sin(closedangle)*swingweightl+sin(closedangle)*wall-ztolerance]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
	      }
	    } 
	  }

	  voidh=0.1;

	  // Make voids to increase weight
	  if (weigthvoids) {
	    if (l && x<0) {
	      translate([x+wall,-swingw/2+0.5+wall,swingheight]) cube([swingl/2-wall*5,swingw-wall*2-1,voidh]);
	      translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8]) cube([swingl*3/4/2-wall*2,swingw-wall*2-1,voidh]);
	      translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8*2]) cube([swingl/4-wall*2,swingw-wall*2-1,voidh]);
	      translate([x+wall-wall,-swingw/2+0.5+wall,swingheight+0.8*3]) cube([wall*4,swingw-wall*2-1,voidh]);
	    }
	    if (!l && x>0) {
	      translate([x-swingl/2+wall*4,-swingw/2+0.5+wall,swingheight]) cube([swingl/2-wall*5,swingw-wall*2-1,voidh]);
	      translate([x-swingl*3/4/2+wall,-swingw/2+0.5+wall,swingheight+0.8]) cube([swingl*3/4/2-wall*2,swingw-wall*2-1,voidh]);
	      translate([x-swingl/4+wall,-swingw/2+0.5+wall,swingheight+0.8*2]) cube([swingl/4-wall*2,swingw-wall*2-1,voidh]);
	      translate([x-wall*4,-swingw/2+0.5+wall,swingheight+0.8*3]) cube([wall*4,swingw-wall*2-1,voidh]);
	    }
	  }
	}
      }

      for (y=[-swingw/2+wall/2,swingw/2-wall/2-axledepth-1-ytolerance*2]) {
	hull() {
	  translate([-axled*1.3,y,-axled/2-2]) rotate([-90,0,0]) cylinder(d=axled+4,h=axledepth+1+ytolerance*2);
	  translate([0,y,0]) rotate([-90,0,0]) cylinder(d=axled+4,h=axledepth+1+ytolerance*2);
	  translate([axled*1.3,y,-axled/2-2]) rotate([-90,0,0]) cylinder(d=axled+4,h=axledepth+1+ytolerance*2);
	}
      }
    }
    
    // Swing sides
    for (y=[-swingw/2,swingw/2]) {
      yy=-sign(y)/2+y;
      hull() {
	translate([-swingl/2+wall*3,yy,swingheight]) sphere(d=wall);
	translate([0,y,swingheight]) sphere(d=wall);
	translate([0,y,-axled/2+wall/2]) sphere(d=wall);
      }
      hull() {
	translate([swingl/2-wall,yy,swingheight]) sphere(d=wall);
	translate([0,y,swingheight]) sphere(d=wall);
	translate([0,y,-axled/2+wall/2]) sphere(d=wall);
      }
    }
    
    if (0) swingside(swingw/2,l);
    if (0) mirror([1,0,0]) swingside(swingw/2,l);

    // Weighting
    hull() {
      
    }

    translate([0,-swingw/2,0]) onehinge(axled,axlel,axledepth,0,ytolerance,axledtolerance);
    translate([0,swingw/2,0]) onehinge(axled,axlel,axledepth,0,ytolerance,axledtolerance);
  }
}

arml=sqrt(pow(-lockaxlex-(swingl/2+wall+xtolerance)*cos(closedangle),2)+pow(axleheight+(swingl/2+wall)*sin(closedangle),2))+swingheight+wall/5-lockaxleheight+1;
  
module lock() {
 translate([0,0,0]) onehinge(lockaxled,lockaxlel,axledepth,0,ytolerance,axledtolerance);
 ly=locklefty-lockaxley;
 ry=lockrighty-lockaxley;
 lwy=-lockweightw/2;
 
 hull() {
    translate([0,ly,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([-lockaxled/2+wall/2,ly+wall+0.5,arml+wall*4]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+wall*1.5+0.5,ly-wall*1+0.5,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=0.2);
  }

  // Weight
  hull() {
    translate([-lockaxled/2+wall/2,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2,lwy,arml+wall*3]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+lockweightl+wall*3,lwy,arml+wall*4.5]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+lockweightl,lwy,arml+wall*4.5+lockweighth]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
  }

  hull() {
    w=wall*2+ytolerance+wall+ytolerance+0.2;
    translate([-lockaxled/2+wall/2,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=w);
    translate([-lockaxled/2+wall/2,lwy,arml+wall*3]) rotate([-90,0,0]) cylinder(d=wall,h=w);
    translate([-lockaxled/2+wall/2+wall*1.5,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=w);
  }

  hull() {
    translate([0,ly,0]) rotate([90,0,0]) cylinder(d=axled,h=wall);
    translate([0,ly,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=axled,h=wall);
  }

  hull() {
    translate([0,ly,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=axled,h=wall);
    translate([-lockaxled/2+wall*3,ly+wall+0.5-wall*2,arml-wall-ytolerance-0.5]) rotate([-90,0,0]) cylinder(d=wall,h=wall*1.5);
    translate([-lockaxled/2+wall/2,ly+wall+0.5,arml-wall*2-ytolerance-0.5]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
  }

  hull() {
    translate([0,ry+wall,0]) rotate([90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([1,ry+wall,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled+2,h=wall);
  }
  hull() {
    translate([1,ry+wall,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled+2,h=wall);
    for (x=[0,wall-0.5]) {
      w=x?0.1:wall;
      translate([x+lockaxled+wall/2+0.5,ry+wall-1,arml/2-wall]) rotate([90,0,0]) cylinder(d=wall*2.4+1,h=w);
      translate([x-lockaxled/2+wall/3/2,ry+wall-1,arml+wall]) rotate([90,0,0]) cylinder(d=wall/3,h=w);
      translate([x+15,ry+wall-0.5,lockaxled+wall*2+0.5]) rotate([90,0,0]) cylinder(d=wall,h=w);
    }
  }
}

module storagegate() {
  hull() {
    translate([boxx+wall+xtolerance,boxy+wall+storagew-boxincornerd,wall*2]) roundedbox(outholel-wall-xtolerance*2,boxincornerd+wall+swingtunnelw-wall-ytolerance-0.5-wall-ytolerance-0.05,outholeh,boxincornerd);
    translate([boxx+wall+(outholel-wall-xtolerance*2)/2-maxbridge/2+xtolerance,boxy+storagew+boxincornerd,outholel*1.7-maxbridge*2]) roundedbox(maxbridge,boxincornerd*2,boxincornerd,cornerd);
  }
}

module mousestorage() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([storageboxx+storageboxl/2-doorl/2-wall*2,storageboxy-wall,0]) {
	    roundedbox(doorl+wall*4,doorw+wall,storageboxh-wall-ztolerance,cornerd);
	  }
	
	  difference() {
	    union() {
	      intersection() {
		minkowski() {
		  cylinder(d=storageboxoutcornerd,h=1);
		  translate([storageboxx+storageboxoutcornerd/2,storageboxy+storageboxoutcornerd/2,0]) cube([storageboxl-storageboxoutcornerd,storageboxw-storageboxoutcornerd,storageboxh-cornerd]);
		  //translate([storageboxx,storageboxy,0]) roundedbox(storageboxl,storageboxw,storageboxh,boxcornerd);
		}
		translate([storageboxx,storageboxy,0]) cube([storageboxl,storageboxw,storageboxh-wall-ztolerance]);
	      }

	      // locking storage box into mousebox
	      translate([storageboxx+storageboxl-boxcornerd/2,boxlocky,0]) cube([boxlockl+boxcornerd,boxlockw,boxlockh]);
	      for (y=boxlockpinholeytable) {
		translate([boxlockpinholex,y,0]) cylinder(d=boxlockpind,h=boxlockpinh);
	      }

	      if (antiwarp) {
		antiwarph=storageboxh+5;
		difference() {
		  minkowski(convexity=10) {
		    union() {
		      translate([storageboxx+storageboxoutcornerd/2-antiwarpdistance-antiwarpw,storageboxy+storageboxoutcornerd/2-antiwarpdistance-antiwarpw,0]) cube([storageboxl-storageboxoutcornerd+antiwarpdistance*2+antiwarpw*2,storageboxw-storageboxoutcornerd+antiwarpdistance*2+antiwarpw*2,antiwarph]);
		      translate([storageboxx+storageboxl/2-(doorl/2+wall)-storageboxoutcornerd/2+antiwarpdistance+antiwarpw,storageboxy-wall+storageboxoutcornerd/2-antiwarpdistance-antiwarpw,0]) cube([(doorl+wall*2)+storageboxoutcornerd-antiwarpdistance*2-antiwarpw*2,storageboxw-storageboxoutcornerd+antiwarpdistance+antiwarpw*2,antiwarph]);
		      translate([storageboxx+storageboxl-boxcornerd/2,boxlocky-antiwarpdistance-antiwarpw,0]) cube([boxlockl+boxcornerd-storageboxoutcornerd/2+antiwarpdistance+antiwarpw,boxlockw+antiwarpdistance*2+antiwarpw*2,antiwarph]);
		    }
		    cylinder(d=storageboxoutcornerd,h=1);
		  }
		  minkowski(convexity=10) {
		    union() {
		      translate([storageboxx+storageboxoutcornerd/2-antiwarpdistance,storageboxy+storageboxoutcornerd/2-antiwarpdistance,-0.1]) cube([storageboxl-storageboxoutcornerd+antiwarpdistance*2,storageboxw-storageboxoutcornerd+antiwarpdistance*2,antiwarph+0.2]);
		      translate([storageboxx+storageboxl/2-(doorl/2+wall)-storageboxoutcornerd/2+antiwarpw+antiwarpdistance,storageboxy-wall+storageboxoutcornerd/2-antiwarpdistance,-0.1]) cube([doorl+wall*2+storageboxoutcornerd-antiwarpdistance*2-antiwarpw*2,storageboxw+wall-storageboxoutcornerd+antiwarpdistance*2,antiwarph+0.2]);
		      translate([storageboxx+storageboxl-boxcornerd/2,boxlocky-antiwarpdistance,-0.1]) cube([boxlockl+boxcornerd-storageboxoutcornerd/2+antiwarpdistance,boxlockw+antiwarpdistance*2,antiwarph+0.2]);
		    }
		    cylinder(d=storageboxoutcornerd,h=1);
		  }

		  // Space between antiwarp and object needs to be outside to get brim in between.
		  translate([storageboxx+storageboxl/2,storageboxy+storageboxw,-0.1]) cube([1,antiwarpdistance+antiwarpw+1,0.4+0.1]);
		}
	      }
	    }

	    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-textdepth+0.01,storageboxh/2]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-textdepth+0.01,storageboxh/2-copyrighttextoffset]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");


	    // Opening between out tunnel and storage
	    hull() {
  y=-swingtunnelw/2-midwallw-swingtunnelw;
  w=swingtunnelw-wall-ytolerance-wall-ytolerance;
	      translate([storageboxx+storageboxl-wall-boxincornerd/2,y,wall*2]) roundedbox(boxincornerd+wall,w,outholeh,boxincornerd);
  translate([storageboxx+storageboxl-wall-boxincornerd/2,y+(w-maxbridge)/2,wall*2+outholeh+(w-maxbridge-boxincornerd)/4]) cube([boxincornerd+wall,maxbridge,maxbridge]);
	    }
	    
	    // Mouse storage
	    translate([storageboxx+wall,storageboxy+wall,wall]) roundedbox(storagel/2-boxincornerd-wall*3,storagew,storageh,boxincornerd);
	    translate([storageboxx+wall,storageboxy+wall+wall,wall]) roundedbox(storagel,storagew-wall,storageh,boxincornerd);
	    translate([storageboxx+storageboxl-wall-(storagel/2-boxincornerd-wall*3),storageboxy+wall,wall]) roundedbox(storagel/2-boxincornerd-wall*3,storagew,storageh,boxincornerd);
	  }
	}
      }

      for (x=[storageboxx+storageboxl/5,storageboxx+storageboxl-storageboxl/5]) {
	for (y=[storageboxy+clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }

      for (x=[storageboxx+storageboxl/4,storageboxx+storageboxl/2,storageboxx+storageboxl-storageboxl/4]) {
	for (y=[storageboxy+storageboxw-clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }
	
      for (x=[storageboxx+clipd/2,storageboxx+storageboxl-clipd/2]) {
	for (y=[storageboxy+wall+storagew/4,storageboxy+wall+storagew*3/4]) {
	  translate([x,y,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,0);
	}
      }

    }

    doorcut();

    translate([storageboxx+storageboxl/2,storageboxy+clipd/2,clipheight]) tubeclip(clipl,clipd,dtolerance);
  }
}

swingtunnelladjust=swingtunnelw/1.4;
endwin=maxbridge*1.4;//maxbridge*1.5;//+boxincornerd-wall/2;
endwout=maxbridge+wall*2;//+boxincornerd
tunnelendx=boxx+boxl-wall-swingtunnelladjust;
swingtunnell=boxincornerd/2+boxl-swingtunnelladjust;
outgoingswingtunnell=boxl+boxx+swingl/2-swingtunnelladjust;

module mousebox() {
  difference() {
    union() {
      difference() {
	union() {
	  difference() {
	    union() {
	      intersection() {
		hull() {
		  hull() {
		    translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		    translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		  }
		  
		  hull() {
		    translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		    translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		  }
		  
		  hull() {
		    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		  }
		  
		  hull() {
		    translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		    translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		  }
		  
		  hull() {
		    translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,cornerd/2]) sphere(d=cornerd);
		    translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,boxh-cornerd/2]) sphere(d=cornerd);
		    translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,cornerd/2]) sphere(d=cornerd);
		    translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
		  }
		}
		translate([boxx,boxy,0]) cube([boxl,boxw,boxh-wall-ztolerance]);//-boxincornerd/2
	      }
	    }

	    translate([boxx+boxl/2,boxy+boxw-textdepth+0.01,boxh/2]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	    translate([boxx+boxl/2,boxy+boxw-textdepth+0.01,boxh/2-copyrighttextoffset]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	    
	    // Spaces for swinging platforms
	    swingcut();
	    translate([0,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) swingcut();
    
	    // Incoming tunnel
	    c=boxincornerd;
	    hull() {
	      translate([boxx-c/2,-swingtunnelw/2,wall*2]) roundedbox(swingtunnell,swingtunnelw,boxh-wall+c,c);
	      translate([-swingl/2*cos(closedangle)-swingheight*cos(closedangle)-cornerd/2-cornerd/2-swingweightl,-swingtunnelw/2,wall*2]) roundedbox(cornerd+2*swingweightl+swingl*cos(closedangle)-wall,swingtunnelw,boxh-wall*3,cornerd);
	    }

	    // Outgoing tunnel
	    hull() {
	      translate([-swingl/2,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(outgoingswingtunnell,swingtunnelw,storageh-wall,c);
	      translate([-swingl/2*cos(closedangle)-cornerd,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(swingweightl+swingheight*cos(closedangle)+swingl*cos(closedangle)+cornerd*2,swingtunnelw,boxh-wall*3,cornerd);
	    }
	    translate([boxx-c/2,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(swingtunnell,swingtunnelw-wall-ytolerance-wall-ytolerance,storageh-wall,c);
	      
	    xx=swingl/2*cos(closedangle);

	    // Opening between in and out tunnels
	    hull() {
	      translate([boxx+boxl-wall-midholel,-swingtunnelw-midwallw-swingtunnelw/2,wall*2]) roundedbox(midholel-swingtunnelladjust+wall,swingtunnelw+midwallw+swingtunnelw,boxh-wall*3+boxincornerd,boxincornerd);
	      hull() {
		translate([boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw/2-endwin/2,wall*2]) roundedbox(midholel,endwin,boxh-wall*3+boxincornerd/2,boxincornerd);
		translate([boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw/2-endwin/2,wall*2+boxincornerd/4]) cube([midholel,endwin,boxh-boxincornerd/2+boxincornerd/4-wall*3]);
	      }
	    }

	    // Opening at exit part of out tunnel
	    translate([boxx+wall,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(-boxx-xx+boxincornerd,swingtunnelw-wall-lockaxledepth/2-wall/2-lockaxledepth+ytolerance,storageh,boxincornerd);
    
	    // Cut for locking storage box into mousebox
	    translate([boxx-0.01,boxlocky-ytolerance,-0.1]) hull() {
	      cube([boxlockl+xtolerance,boxlockw+ytolerance*2,boxlockh+0.1+ztolerance]);
	      cube([boxlockl+xtolerance+wall,boxlockw+ytolerance*2,0.1]);
	    }
	    for (y=boxlockpinholeytable) {
	      translate([boxlockpinholex,y,0]) cylinder(d=boxlockpind+dtolerance,h=boxlockpinholeh);
	    }

	    // Cut for lock movement
	    translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall*2+ytolerance*2,storageh]);
	    translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2-midwallw-ytolerance-wall-ytolerance-0.5,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall+ytolerance+0.5,storageh]);

	      
	    // Cut for lock weight movement
	    y=-swingtunnelw/2-midwallw/2-lockweightw/2-0.5-ytolerance;
	    h=storageh-arml+lockweighth-wall*1-0.3-wall;
	    height=arml/2;
	    oheight=lockaxled/2+arml*cos(lockangle);
	    oh=boxh-wall-oheight-wall/2;
	    intersection() {
	      union() {
		translate([lockaxlex-lockaxled/2+0.4,y,height]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+lockweightl+xtolerance,ytolerance+lockweightw+ytolerance+1,h]);

		hull() {
		  translate([lockaxlex-lockaxled/2-axledtolerance/2,y,oheight]) cube([arml*cos(lockangle)-lockaxled-wall,ytolerance+lockweightw+ytolerance+wall+0.1,oh]);
		  translate([lockaxlex-lockaxled/2-axledtolerance/2+oh,y,oheight+oh-lockaxled/2-0.1]) cube([arml*cos(lockangle)-lockaxled-wall,ytolerance+lockweightw+ytolerance+wall+0.1,0.1]);
		}
	      }

	      translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(r=arml+lockweighth+lockweightl-wall*3,h=ytolerance+lockweightw+ytolerance+wall+0.1);
	    }

	    // Test saving holes, did not work, filament consumption increased.
	    if (makevoids) {
	      translate([boxx+lockaxled/2+lockaxled,midholey+wall,wall]) cube([midwalll-lockaxled/2-lockaxled-wall,midwallw-wall*2,height-wall-wall]);
	      difference() {
	      translate([boxx+lockaxled/2+lockaxled,midholey+wall,height]) cube([midwalll-lockaxled/2-lockaxled-wall,midwallw-wall*2,boxh-wall-wall-height]);
	      translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(r=arml+lockweighth+lockweightl-wall*3+wall,h=ytolerance+lockweightw+ytolerance+wall+0.1);
	      }
	    }
	  }

	  // spaces for swing axles
	  for (y=[-swingw/2+wall/2+ytolerance,swingw/2-wall/2-axledepth-1-ytolerance]) {
	    for (yy=[y,y-swingtunnelw-midwallw]) {
	      hull() {
		translate([-axleheight,yy+0.5,wall]) rotate([-90,0,0]) cylinder(d=1,h=axledepth-0.01);
		translate([0,yy,axleheight]) rotate([-90,0,0]) cylinder(d=axled+2,h=axledepth+1);
	      }
	      hull() {
		translate([0,yy,axleheight]) rotate([-90,0,0]) cylinder(d=axled+2,h=axledepth+1);
		translate([axleheight,yy+0.5,wall]) rotate([-90,0,0]) cylinder(d=1,h=axledepth-0.01);
	      }
	    }
	  }

	  // Support below swings
	  for (y=[0,-swingtunnelw/2-midwallw-swingtunnelw/2]) {
	    difference() {
	      union() {
		hull() {
		  translate([-axleheight,y-swingtunnelw/2-0.1,1/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
		  translate([0,y-swingtunnelw/2-0.1,axleheight-axled/2-1/2-ztolerance]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
		  translate([axleheight,y-swingtunnelw/2-0.1,1/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
		}
	
		hull() {
		  hull() {
		    translate([-axled+2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
		    translate([0,y-swingw/2+wall/2+ytolerance,axleheight+swingheight-axled/2-ztolerance-wall/2]) rotate([-90,0,0]) cylinder(d=axled,h=swingw-wall-ytolerance*2);
		    translate([axled-2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
		  }
		  for (x=[-axleheight-axled,0,axleheight+axled]) {
		    translate([x,y-swingw/2+wall/2+ytolerance+abs(sign(x)),wall/2]) rotate([-90,0,0]) cylinder(d=wall,h=swingw-wall-ytolerance*2-abs(sign(x))*2);
		  }
		}
	      }

	      if (makevoids) {
		hull() {
		  translate([-axleheight+wall*2.5,y-swingtunnelw/2-0.1,1/2+wall]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
		  translate([0,y-swingtunnelw/2-0.1,axleheight-1/2-wall-ztolerance-wall/2-wall]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
		  translate([axleheight-wall*2.5,y-swingtunnelw/2-0.1,1/2+wall]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
		}
	
		hull() {
		  hull() {
		    //translate([-axled+2,y-swingw/2+wall/2+ytolerance+1+wall,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2-wall*2);
		    translate([0,y-swingw/2+wall/2+ytolerance+wall,axleheight-wall-ztolerance-wall/2-wall]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-wall*2);
		    //translate([axled-2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
		  }
		  for (x=[-axleheight-axled+wall*3,0,axleheight+axled-wall*3]) {
		    translate([x,y-swingw/2+wall/2+ytolerance+abs(sign(x))+wall,wall/2+wall]) rotate([-90,0,0]) cylinder(d=wall,h=swingw-wall-ytolerance*2-abs(sign(x))*2-wall*2);
		  }
		}
	      }
	    }
	  }

	  // Lock axle end covers
	  for (y=[locklefty+ytolerance,lockaxley-lockaxlel/2-wall-ytolerance+0.5]) {
	    hull() {
	      translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled,h=axledepth+0.5);
	      //	      translate([lockaxlex-lockaxled*2,y,wall/2]) rotate([-90,0,0]) cylinder(d=wall,h=axledepth+0.5);
	    }
	  }

	  if (adhesion) {
	    adhesiontowerh=swingsideh+9;
	    
	    // Left support
	    z=boxh-wall-ztolerance+0.1;
	    lefty=locklefty+lockaxledepth*2;
	    x=lockaxlex-lockaxled/2;
	    hull() {
	      translate([x,lefty-lockaxledepth+ytolerance,cornerd/2]) cube([0.2,0.4,0.4]);
	      translate([x,lefty+ytolerance*2,z]) cube([0.2,0.4,0.4]);
	    }

	    // Some slicers generate support towers here for no reason.
	    translate([x,-swingtunnelw/2+0.1,z-10]) cube([0.2,10,10]);
	    translate([x,-swingtunnelw/2-midwallw-0.5-wall-0.5-0.2,z-10]) cube([0.2,wall+0.5+ytolerance+0.2,10]);
 
	    righty=lockaxley-lockaxlel/2-wall/2-ytolerance;
	    translate([x,righty,cornerd/2]) cube([0.2,0.4,z-cornerd/2]);
	    translate([x,righty,z]) cube([0.2,lefty-righty+ytolerance+0.4,0.4]);

	    // Swings are very weakly connected through supports, so manually create support towers for better adhesion.
	    ly=0;
	    lx=-x-swingl/2-swingweightl;
	    sl=swingl/2+swingweightl*2;
	    sheight=axleheight+swingheight+wall+swingweighth+wall*2.5;
	    translate([x,ly-swingw/2+wall*2,sheight]) {
	      cube([sl,swingw-wall*2-1,0.8]);
	      cube([lx-0.2,swingw-wall*2,0.8]);
	    }
	    if (0) for (xx=[x+lx:2:x+lx+swingweightl]) {
	      translate([xx,ly-swingw/2+wall*3+1+swingw-wall*4-1,sheight]) cube([0.2,1,0.4]);
	    }
	    if (0) for (xx=[x+lx+swingweightl:5:x+sl]) {
	      translate([xx,ly-swingw/2+wall*3+1+swingw-wall*4-1,sheight]) cube([0.2,1,0.4]);
	    }

	    swingmheight=axleheight+swingheight+wall+wall;
	    swingmh=sheight-swingmheight;
	    
	    for (lyy=[-10,15]) {
	      translate([x,lyy,sheight]) triangle(sl,0.8,adhesiontowerh,2);
	      translate([x,lyy,swingmheight]) cube([lx-0.2,0.8,swingmheight]);
	      hull() {
		translate([x+lx,lyy,swingmheight-0.9]) triangle(swingweightl,0.8,swingmh+1,3);
		translate([0,lyy,swingmheight-wall]) cube([0.4,0.8,swingmh+wall]);
		translate([0,lyy,swingmheight-wall]) cube([swingweightl-lx,0.8,swingmh+wall]);
	      }

	      for (xx=[x+lx+swingweightl:5:x+sl]) {
		translate([xx,lyy,axleheight+swingheight]) cube([0.2,0.4,swingmh]);
	      }

	      intersection() {
		for (xx=[x+lx:5:x+lx+swingweightl]) {
		  translate([xx,lyy,axleheight+swingheight]) cube([0.2,0.4,swingmh+wall*3]);
		}
		hull() {
		  translate([x+lx,lyy,axleheight+swingheight+wall]) triangle(swingweightl,0.8,swingmh,3);
		  translate([x+lx,lyy,axleheight+swingheight+wall+swingmh]) cube([swingweightl,0.8,wall*2]);
		}
	      }

	      translate([x,ly-swingw/2+wall*2+1,sheight]) cube([0.4,swingw-wall*2-1,swingmheight-swingmh]);
	    }
	    
	    ry=-swingtunnelw/2-midwallw-swingtunnelw/2-wall*2-1;
	    ryy=-swingtunnelw/2-midwallw-swingtunnelw/2;

	    for (ryyy=[ryy-18,ryy+10]) {
	      translate([x,ryy-swingw/2+1,axleheight+swingheight+wall+swingweighth+wall*2]) cube([swingl/2+swingweightl*2,swingw-wall*2-1,0.8]);
	      translate([x,ryy-swingw/2-1,axleheight+swingheight+wall+swingweighth+wall*2]) cube([-x-swingl/2-0.2,swingw-wall*4-1,0.8]);
	      translate([x,ryy,axleheight]) cube([-x-swingl/2-0.2,0.8,swingheight+wall+swingweighth+wall*2]);
	      
	      translate([x,ryyy,sheight]) triangle(sl,0.8,adhesiontowerh,2);
	      //swingmheight=axleheight+swingheight+wall+1-wall/2;
	      //swingmh=sheight-swingmheight;
	      translate([x,ryyy,swingmheight]) cube([lx-0.2,0.8,swingmheight]);
	      hull() {
		translate([x,ryyy,swingmheight-wall]) cube([sl,0.8,swingmh+wall]);
		//	      translate([0,ryy,swingmheight]) cube([0.4,0.8,swingmh]);
		//	      translate([0,ryy,swingmheight]) cube([swingweightl-lx,0.8,swingmh]);
	      }

	      if (0) for (xx=[x+lx+swingweightl:5:x+sl]) {
		  translate([xx,ryy-swingw/2-ytolerance,sheight]) cube([0.2,wall+1,0.4]);
		}

	      for (xx=[x+lx+swingweightl:5:x+sl]) {
		translate([xx,ryyy,axleheight+swingheight]) cube([0.2,0.4,swingmh]);
	      }	

	      translate([x,ry-swingw/2+wall*3+1,swingmheight]) cube([0.4,swingw-wall*4-1,swingmheight]);
	    }
	  }
	}

	// Lock axle hinge cuts
	translate([lockaxlex,lockaxley,lockaxleheight]) onehinge(lockaxled,lockaxlel,lockaxledepth,1,ytolerance,axledtolerance);
	hull() {
	  translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+axledtolerance*2,h=lockaxlel+ytolerance*2);
	  translate([lockaxlex+lockaxled/2+axledtolerance+1,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=0.5,h=lockaxlel+ytolerance*2);
	}

	// Accommodate lock angle in locked position
	intersection() {
	  hull() {
	    translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+axledtolerance*2,h=lockaxlel+ytolerance*2);
	    translate([lockaxlex+lockaxled+axledtolerance+3,lockaxley-lockaxlel/2-ytolerance,lockaxleheight+lockaxled/2]) rotate([-90,0,0]) cylinder(d=0.5,h=lockaxlel+ytolerance*2);
	  }

	  union() {
	    for (y=[lockaxley-lockaxlel/2-ytolerance,lockaxley+lockaxlel/2-wall-ytolerance]) {
	      translate([lockaxlex,y,wall]) cube([lockweightl,wall+ytolerance*2,wall+0.01]);
	    }
	  }
	}
	for (y=[0,-swingtunnelw/2-midwallw-swingtunnelw/2]) {
	  translate([0,y-swingw/2,axleheight]) onehinge(axled,axlel,axledepth,1,ytolerance,axledtolerance);
	  translate([0,y+swingw/2,axleheight]) onehinge(axled,axlel,axledepth,1,ytolerance,axledtolerance);
	}
      }

      for (x=boxclipxpositions) {
	for (y=[boxy+clipd/2,boxy+boxw-clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }
    }
  }
}

// Make a roof insert for cover. Call roundedroofcut separately as these may be unionized.
module roundedroof(x,y,z,l,w,h,c) {
  intersection() {
    translate([x+xtolerance,y+ytolerance,z-c/2]) roundedbox(l-xtolerance*2,w-ytolerance*2,h+c,c);
    translate([x,y,z+cutsmall]) cube([l,w,h-cutsmall]);
  }
}

// Cutout part of roof insert
module roundedroofcut(x,y,z,l,w,h,c) {
  translate([x+xtolerance,y+ytolerance,z-c/2]) roundedbox(l-xtolerance*2,w-ytolerance*2,c,c);
}

module storagecover() {
  difference() {
    union() {
      intersection() {
	//translate([storageboxx,storageboxy,0]) roundedbox(storageboxl,storageboxw,storageboxh,cornerd);
	//translate([storageboxx-0.1,storageboxy-0.1,storageboxh-wall]) cube([storageboxl+0.2,storageboxw+0.02,wall]);
	minkowski() {
	  cylinder(d=storageboxoutcornerd,h=1);
	  translate([storageboxx+storageboxoutcornerd/2,storageboxy+storageboxoutcornerd/2,storageboxh-wall]) cube([storageboxl-storageboxoutcornerd,storageboxw-storageboxoutcornerd,wall-1]);
	}
      }

      theight=axleheight+swingheight+swingl/2*sin(closedangle)-wall;
      th=storageboxh-theight+wall+boxincornerd+0.01;
      tx=-cos(closedangle)*swingl/2-wall;
      tl=storageboxl-tx+storageboxx-wall;
  
      intersection() {
	union() {
	  difference() {
	    union() {
	      // Mouse storage
	      roundedroof(storageboxx+wall,storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew,boxincornerd/2,boxincornerd);
	      roundedroof(storageboxx+wall,storageboxy+wall+wall,storageboxh-wall-boxincornerd/2,storagel,storagew-wall,boxincornerd/2,boxincornerd);
	      roundedroof(storageboxx+storageboxl-wall-(storagel/2-boxincornerd-wall*3),storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew-2,boxincornerd/2,boxincornerd);
	    }

	    // Storage roof cut
	    roundedroofcut(storageboxx+wall,storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew,boxincornerd/2,boxincornerd);
	    roundedroofcut(storageboxx+wall,storageboxy+wall+wall,storageboxh-wall-boxincornerd/2,storagel,storagew-wall,boxincornerd/2,boxincornerd);
	    roundedroofcut(storageboxx+storageboxl-wall-(storagel/2-boxincornerd-wall*3),storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew,boxincornerd/2,boxincornerd);
	  }
	}
      }
    }

    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-15,storageboxh-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-copyrighttextoffset-15,storageboxh-textdepth+0.01]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

    // Cover locking clips
    for (x=[storageboxx+storageboxl/5,storageboxx+storageboxl-storageboxl/5]) {
      for (y=[storageboxy+clipd/2]) {
	translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
      }
    }
    
    for (x=[storageboxx+storageboxl/4,storageboxx+storageboxl/2,storageboxx+storageboxl-storageboxl/4]) {
      for (y=[storageboxy+clipd/2,storageboxy+wall+storagew+wall-clipd/2,storageboxy+wall+storagew+clipd/2,storageboxy+storageboxw-clipd/2]) {
	translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
      }
    }
    
    for (x=[storageboxx+clipd/2,storageboxx+storageboxl-clipd/2]) {
      for (y=[-swingtunnelw/2-midwallw-swingtunnelw/2,storageboxy+wall+storagew/4,storageboxy+wall+storagew*3/4]) {
	translate([x,y,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,dtolerance);
      }
    }

    doorcut();

    // Air holes
    airholefromedge=boxincornerd+wall+5;
    airholeoutdiameter=10;
    airholeindiameter=2;
    airholesw=5;
    airholesl=10;
    airholexstep=(storagel-airholefromedge*2)/airholesl;
    airholeystep=(storagew-airholefromedge*2)/airholesw;
    
    for (x=[storageboxx+wall+airholefromedge+airholexstep/2:airholexstep:storageboxx+storageboxl-airholefromedge]) {
      for (y=[storageboxy+wall+airholefromedge+airholeystep/2:airholeystep:storageboxy+storagew-airholefromedge]) {
	hull() {
	  translate([x,y,storageboxh-wall-0.1]) cylinder(d=airholeindiameter,h=0.4);
	  translate([x,y,storageboxh-wall-0.2]) cylinder(d=airholeoutdiameter,h=0.1);
	}
	translate([x,y,storageboxh-wall-0.1]) cylinder(d=airholeindiameter,h=wall+0.2);
      }
    }
  }
}

module cover() {
  difference() {
    union() {
      intersection() {
	hull() {
	  hull() {
	    translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
	}
	
	//translate([boxx,boxy,0]) roundedbox(boxl,boxw,boxh,boxcornerd);
	translate([boxx-0.1,boxy-0.1,boxh-wall]) cube([boxl+0.2,boxw+0.02,wall]);
      }

      theight=axleheight+swingheight+swingl/2*sin(closedangle)+wall*1;
      //      th=boxh-theight+wall+boxincornerd+0.01;
      tx=-cos(closedangle)*swingl/2-wall;
      tl=boxl-tx+boxx-wall;

      c=boxincornerd;
      
      intersection() {
	union() {
	  difference() {
	    union() {
	      // Incoming tunnel
	      difference() {
		intersection() {
		  roundedroof(boxx-c/2,-swingtunnelw/2,boxh-wall-c/2,swingtunnell,swingtunnelw,c/2,c);
		  translate([boxx-c/2,-swingtunnelw/2+ytolerance,boxh-wall-boxincornerd]) cube([swingtunnell-xtolerance,swingtunnelw-ytolerance*2,boxincornerd]);
		}

		translate([boxx-c/2-0.1,-swingtunnelw/2,boxh-wall-boxincornerd]) cube([c/2+0.1,swingtunnell,swingtunnelw]);
	      }

	      // Outgoing tunnel main section
	      roundedroof(tx,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-c/2,tl-swingtunnelladjust,swingtunnelw,c/2,c);
	      translate([boxx+wall+c/2+xtolerance,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,boxh-wall-c/2+cutsmall]) cube([tx-boxx+c/2-xtolerance*2,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance*2,c/2]);
	      translate([tx+c/2,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,boxh-wall-c/2+cutsmall]) cube([c/2+xtolerance,swingtunnelw-ytolerance*2,c/2-1-cutsmall]);

	      // Opening between in and out tunnels
	      hull() {
		roundedroof(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,midholel-swingtunnelladjust+wall,swingtunnelw*2+midwallw,boxincornerd/2,boxincornerd);
		hull() {
		  roundedroof(boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2,boxh-wall-c/2,midholel-xtolerance*2,endwin,c/2,c);
		  hull() {
		    translate([boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2+ytolerance,boxh-wall-0.1]) cube([midholel-xtolerance*2,endwin-ytolerance*2,0.1]);
		    translate([boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2+ytolerance,boxh-wall-c/2]) cube([midholel-xtolerance*2-0.5,endwin-ytolerance*2,c/2]);
		  }
		}
	      }
	      
	      // Close extra spaces
	      translate([boxx,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,theight-boxincornerd/2]) roundedbox(boxl-tl-wall+boxincornerd/2,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance,boxh-wall-theight+boxincornerd/2+wall,cornerd*2);
	    }

	    // Incoming tunnel roof cut
	    roundedroofcut(boxx-boxincornerd/2,-swingtunnelw/2,boxh-wall-boxincornerd/2,boxincornerd/2+boxl-wall-swingtunnelladjust,swingtunnelw,boxincornerd/2,boxincornerd);
	
	    // Outgoing tunnel roof cut
	    roundedroofcut(tx+boxincornerd/2,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,tl-boxincornerd/2-swingtunnelladjust,swingtunnelw,boxincornerd/2,boxincornerd);

	    // Swing cuts
	    coverswingcut(0,-swingtunnelw-midwallw-swingtunnelw/2,wall/2,swingl,boxh-2*wall-boxincornerd,swingtunnelw,axleheight,swingl+wall/2+ytolerance,boxincornerd);
	    if (0) coverswingcut(0,-swingtunnelw-midwallw-swingtunnelw/2,wall/2,swingl+(swingsideh*sin(closedangle)+wall+ytolerance)*2,boxh-2*wall-boxincornerd,ytolerance+wall+0.5+ytolerance,axleheight,swingl+wall/2+ytolerance+swingsideh*sin(closedangle)+wall+ytolerance,boxincornerd);
	
	    // Opening between in and out tunnels roof cut
	    hull() {
	      roundedroofcut(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,midholel-swingtunnelladjust+wall,swingtunnelw*2+midwallw,boxincornerd/2,boxincornerd);
	      hull() {
		roundedroofcut(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw/2-endwin/2-c/4,boxh-wall-boxincornerd/2,midholel,endwin+c/2,c/2,c);
		//		translate([boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2+ytolerance,boxh-wall-c/2]) cube([midholel-xtolerance*2,endwin-ytolerance*2,c/2]);
	      }
	    }
	    translate([boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-c/2-0.1]) cube([midholel,swingtunnelw*2+midwallw,cutsmall+0.1]);
	  }
	}
      }

      closeheight=axleheight+swingheight-(-swingl/2)*sin(closedangle)+wall/2+wall+ztolerance;
      closeh=boxh-closeheight;
      closew=swingw-wall*2-wall/2-ytolerance*2-0.5;
	
      difference() {
	union() {
	  x=(-swingl/2+wall*2)*cos(closedangle)+wall+wall;
	  z=closeheight-wall;
	  lx=x/2;
	  hull() {
	    translate([lx,-swingtunnelw/2+ytolerance,boxh-wall/2]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	    translate([x,-swingtunnelw/2+ytolerance,closeheight-wall+ztolerance]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	    translate([0,-swingtunnelw/2+ytolerance,boxh-wall/2]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	  }
	}
      }

      if (0) hull() {
	translate([(-swingl/2)*cos(closedangle)+wall+wall+closeh*sin(closedangle),-swingw/2+wall*2,boxh-wall]) rotate([-90,0,0]) cylinder(h=closew,d=wall);
      }
    }

    // Cover locking clips
    for (x=boxclipxpositions) {
      for (y=[boxy+clipd/2,boxy+boxw-clipd/2]) {
	translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
      }
    }

    translate([boxx+boxl/2,boxy+boxw/2,boxh-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([boxx+boxl/2,boxy+boxw/2-copyrighttextoffset,boxh-textdepth+0.01]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module mousetrap(a,la) {
  intersection() {
    union() {
      mousebox();
      swing(a,1);
      translate([0,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) swing(a,0);
  
      translate([lockaxlex,lockaxley,lockaxleheight]) rotate([0,la,0]) lock();
    }
    //                    translate([-200,-swingtunnelw,-1]) cube([400,400,200]);//axleheight+1
    //                   translate([-200,-swingtunnelw/2+0.1-swingtunnelw-midwallw,-1]) cube([400,400,200]);//axleheight+1
    //                   translate([-200,-200,14]) cube([400,400,200]);//axleheight+1
    //translate([-100,-swingtunnelw/2-midwallw-6.8,-1]) cube([400,400,200]);//axleheight+1
    //        translate([-80,-100-swingtunnelw/2-midwallw-6.8,-1]) cube([400,400,200]);//axleheight+1
  }
}  

module door() {
  difference() {
    union() {
      translate([storageboxx+storagel/2-doorl/2,storageboxy,wall]) {
	hull() {
	  translate([doorw,doorw/4,0]) cube([doorl,doorw/2,doorh]);
	  translate([doorw,0,doorw/4]) cube([doorl,doorw,doorh-doorw/4]);
	  translate([0,doorw-0.01,doorw]) cube([doorl+doorw*2,0.01,doorh-doorw]);
	}
      }
      translate([storageboxx+storageboxl/2,storageboxy+clipd/2,clipheight]) tubeclip(clipl,clipd,0);
    }

    translate([storageboxx+storageboxl/2,storageboxy+textdepth-0.01,boxh/2-wall]) rotate([-90,90,180]) linear_extrude(height=textdepth) text(versiontext, size=textsize-3, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module doorcut() {
  translate([storageboxx+storagel/2-doorl/2,storageboxy,wall-ztolerance]) {
    hull() {
      translate([-xtolerance+doorw,-ytolerance,0]) cube([doorl+ytolerance*2,doorw+xtolerance*2,doorh]);
      translate([-xtolerance,-ytolerance+doorw,wall]) cube([doorl+doorw*2+xtolerance*2,0.04+ytolerance*2,doorh+ztolerance]);
    }
    hull() {
      translate([(doorl-doorholel)/2+wall,-wall-0.01,boxincornerd/2]) cube([doorholel+ytolerance*2,doorw+xtolerance*2+wall+wall+0.02,doorholeh+boxincornerd-wall*2]);
      translate([(doorl-doorholel)/2+wall+(doorholel+ytolerance*2)/2-maxbridge/2,-wall-0.01,boxincornerd/2]) cube([maxbridge,doorw+xtolerance*2+wall+wall+0.02,doorholeh+boxincornerd+(doorholeh-maxbridge)/2-wall*2]);
    }
  }
}

xxx=lockaxlex-lockaxled/2;

mechanismx=lockaxlex-lockaxled/2-0.01;
mechanismy=-swingtunnelw/2-midwallw-swingtunnelw-axledepth;//-ytolerance;
mechanismz=wall/2;
mechanisml=swingl/2+swingweightl+1-xxx;
mechanismw=axledepth+swingtunnelw+midwallw+swingtunnelw+axledepth;
mechanismh=boxh-mechanismz;

module mechanics(angle,lockangle) {
  mousetrap(angle,lockangle);
}

module box() {
  difference() {
    mousetrap(0,0);
    translate([mechanismx-xtolerance,mechanismy-ytolerance,mechanismz-ztolerance]) cube([mechanisml+xtolerance*2,mechanismw+ytolerance*2,mechanismh+ztolerance*2]);
  }
}

if (print==0) {
  intersection() {
    union() {
      mechanics(angle,lockangle);
      //mousestorage();
      //door();
      //   storagecover();
      #  cover();
    }
    //if (debug) translate([boxx,-swingtunnelw/2-midwallw/2,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
    //if (debug) translate([boxx,-swingtunnelw/2-swingtunnelw-50,boxh-wall*15]) cube([590,swingtunnelw*2+midwallw+50,100]);//axleheight+1
    if (debug) translate([storageboxx+storageboxl/2-0,storageboxy,50]) cube([storageboxl+50,storageboxw,100]);
    //if (debug) translate([boxx,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
    // if (debug) translate([boxx,-swingtunnelw/2-midwallw/2,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
  }
 }

if (print==1) {
  translate([0,0,-xxx-0.01]) rotate([0,-90,0]) 
  intersection() {
    union() {
      mousetrap(0,lockangleprint);
    }
    //if (debug) translate([-200,-swingtunnelw/2+10,30]) cube([400,400,60]);//axleheight+1
    if (debug) translate([-200,-swingtunnelw/2-midwallw-swingtunnelw+1,30]) cube([400,400,60]);//axleheight+1

    if (0) union() {
      translate([xxx+0.01,-swingtunnelw/2-midwallw-swingtunnelw-axledepth+ytolerance,wall/2]) cube([lockweightl+lockweighth+0.01,-ytolerance+axledepth+swingtunnelw+midwallw+swingtunnelw+axledepth-ytolerance,boxh-wall-wall/2+lockweightl-40]);
      translate([xxx+0.01,-swingtunnelw/2-midwallw,wall/2]) cube([-xxx,midwallw,boxh-wall-wall/2+lockweightl-40]);
    translate([xxx+0.01,-swingtunnelw/2-midwallw-swingtunnelw-axledepth+ytolerance,wall/2]) cube([axled/2+2-xxx,-ytolerance+axledepth+swingtunnelw+midwallw+swingtunnelw+axledepth-ytolerance,boxh-wall-wall/2-42]);
    translate([xxx+0.01,-swingtunnelw/2-midwallw-swingtunnelw-axledepth+ytolerance,wall/2]) cube([swingl/2+3-xxx,-ytolerance+axledepth+swingtunnelw+midwallw+swingtunnelw+axledepth-ytolerance,wall*2-wall/2+cornerd/2]);
    translate([xxx+0.01,-swingtunnelw/2+0.1,wall/2]) cube([swingl/2+1-xxx,swingtunnelw-0.2,boxh-wall-wall/2-42]);
    translate([xxx+0.01,-swingtunnelw/2-midwallw-swingtunnelw+0.1,wall/2]) cube([swingl/2+1-xxx,swingtunnelw-0.2,boxh-wall-wall/2-42]);
    translate([0,-swingtunnelw/2-midwallw-swingtunnelw+0.1,axleheight-axled]) cube([swingl/2+swingweightl+1,swingtunnelw-0.2,axled+axleheight+swingsideh]);
    }
    //    ww=swingtunnelw+ytolerance+axledepth*2;
    //    translate([xxx+0.01,-ww-ww/2-1-wall/2,wall/2]) cube([-xxx*2+0.01,ww+1+ww+wall/2,boxw-wall-wall/2]);
  }
 }

if (print==2) {
  translate([0,0,storageboxh]) rotate([180,0,0]) {
    storagecover();
  }
 }

if (print==3) {
  translate([-boxx,0,0]) mousestorage();
 }

if (print==4) {
  rotate([0,0,45])
  intersection() {
    translate([0,0,boxh]) rotate([180,0,0]) {
      translate([-boxx,-boxy-boxw/2,0]) cover();
    }
    d=(boxw)/sqrt(2);
    d2=(boxw)/sqrt(2)+wall*2;
    hull() {
      translate([wall+ytolerance*2-0.3,0,0]) rotate([0,0,45]) translate([-d/2,-d/2,0]) cube([d,d,boxh]);
      translate([boxl-tunnelendx/2+5.95,0,0]) rotate([0,0,45]) translate([-d/2,-d/2,0]) cube([d,d,boxh]);

      translate([wall+ytolerance*2+0.5,0]) rotate([0,0,45]) translate([-d2/2,-d2/2,wall]) cube([d2,d2,boxh]);
      translate([boxl-tunnelendx/2+9,0,0]) rotate([0,0,45]) translate([-d2/2,-d2/2,wall]) cube([d2,d2,boxh]);
    }
  }
 }

if (print==5) {
  rotate([90,0,90]) translate([0,-storageboxy,0]) door();
 }

if (print==6) {
  intersection() {
    mousestorage();
    storagecover();
    //cover();
    //mechanics(angle,lockangle);
  }
 }
