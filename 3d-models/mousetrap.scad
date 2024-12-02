// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO:
// Jatka ulosmenevan aukon taso, jotta hiiren on helpompi painaa se alas, tasapainotus tarkistettava.
// Ulosmenevan aukon alaosa cornerd:lla
// Vastaavasti cover muutokset, ehka samalla tavalla kuin incoming kattokin.

include <hsu.scad>

print=0;
adhesion=print?1:0;
debug=1;

cornerd=1;
wall=3;
bigcornerd=5;
xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;
axledtolerance=0.8;
dtolerance=0.5;
maxbridge=10;

$fn=60;

swingw=50;
swingh=50;
swingl=135; //235/2; // Length of one arm
swingtoplreduction=0;
swingsideh=20;
angle=-20;//20 in closed up; 5 down in open lock
closedangle=20; 
openangle=closedangle;
axleheight=25;
axled=7;
axlel=wall;
axledepth=2;

swingheight=wall;//axleheight;

midwallw=axledepth+ytolerance+wall*2+ytolerance+axledepth;

boxh=swingh+50;

boxincornerd=10; // round corners to avoid mice eating through
boxcornerd=cornerd;

clipdepth=0.20+max(xtolerance,ytolerance);
clipd=wall+clipdepth;
clipl=20;
clipheight=boxh-wall-ztolerance-clipd/2;

swingtunnelw=ytolerance+wall/2+swingw+wall/2+ytolerance;

lockaxleheight=axled/2+wall/2;
lockaxled=axled;
lockaxlex=-swingl/2-20;//8;
lockaxledepth=2;
lockangle=29.7;//29.7;//29.7;//23=release in plate, 29.7=locked;
lockweightl=30;
lockweighth=15;
lockweightw=wall*2;
lockaxleyoffset=0;
lockaxlel=wall+ytolerance+midwallw+ytolerance+wall+lockaxleyoffset;
lockaxley=-swingtunnelw/2-midwallw/2-lockaxleyoffset/2; // midpoint
locklefty=-swingtunnelw/2+ytolerance+wall;
lockrighty=-swingtunnelw/2-midwallw-ytolerance-wall;

boxx=xtolerance-wall-boxincornerd/2-swingl/2-34-10;
boxl=230; // -boxx+swingl-25;
boxw=230;
boxy=swingtunnelw/2+wall-boxw;

doorl=50;
doorw=wall;
doorhandleh=15;
doorh=boxh-wall+doorhandleh;

swingweightl=lockaxled+wall*4; //-lockaxlex-swingl/2+lockaxled/2;
swingweighth=wall;

midholel=46;

storagel=boxl-wall*2;
storageh=boxh-wall*2+boxincornerd;
storagew=boxw-wall*3-swingtunnelw*2-midwallw;

swingtunnelh=storageh;

outholel=46;
outholeh=outholel;

mouseh=midholel; // Size of tunnels for a mouse to crawl through

echo("boxw ",boxw," boxl ",boxl," boxh ",boxh);

// Circular hole cut for swing movement
module swingcut() {
  swingtunneld=swingl+xtolerance+2*swingl/2*(1-cos(closedangle))+2;
  hull() {
    intersection() {
      translate([0,-swingtunnelw/2,axleheight]) rotate([-90,0,0]) cylinder(d=swingtunneld,h=swingtunnelw);
      hull() {
	translate([-swingl/2+wall*0.5,-swingtunnelw/2,wall]) roundedbox(swingl-wall*1,swingtunnelw,swingtunnelh,cornerd);
	translate([-swingl/2-wall,-swingtunnelw/2+wall,wall*2]) roundedbox(swingl+2*wall,swingtunnelw-wall*2,swingtunnelh-wall*2,cornerd);
      }
    }
  }
}

module coverswingcut(x,y,z,l,h,w,axleheight,d,c) {
  intersection() {
    translate([x,y,axleheight]) rotate([-90,0,0]) cylinder(d=d,h=w);
    translate([x-l,y,z]) roundedbox(l*2,w,h,c);
  }

  if (0) {
    swingtunneld=swingl+xtolerance+2*(swingl/2)*(1-cos(closedangle))+swingweightl*2+2;
    //swingtunneld=swingl+xtolerance+2*(swingl/2+swingweightl)*(1-cos(closedangle))+swingweightl*2+2;
    hull() {
      intersection() {
	translate([0,-swingtunnelw/2,axleheight]) rotate([-90,0,0]) cylinder(d=swingtunneld,h=swingtunnelw);
	hull() {
	  translate([-swingl/2-swingweightl+wall*0.5,-swingtunnelw/2,wall]) roundedbox(swingl+swingweightl*2-wall*1,swingtunnelw,swingtunnelh-boxincornerd*2,boxincornerd);
	  translate([-swingl/2-wall,-swingtunnelw/2+wall,wall*2]) roundedbox(swingl+2*wall,swingtunnelw-wall*2,swingtunnelh-wall*2-boxincornerd*2,cornerd);
	}
      }
    }
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
		if (!l && x<0 && y>0) {
		  translate([x+wall,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x,yyy-wall,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
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
	      hull() {
		translate([x+swingweightl,-swingw/2+0.5,swingheight+wall+sin(closedangle)*swingweightl]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		translate([x+swingweightl,-swingw/2+0.5,swingheight+wall+sin(closedangle)*swingweightl+swingsideh]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		translate([x,-swingw/2+0.5,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		translate([x,-swingw/2+0.5,swingheight+wall+swingsideh]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
	      }
	    } 
	    if (l && x<0) {
	      hull() {
		for (y=[-swingw/2+wall*2,swingw/2]) {
		  yy=-sign(y)+0.5+y;
		  yyy=yy+(y<0?0.5:0);
		  //yyy=-sign(y)*1+y;
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x-swingweightl,yyy,swingheight+wall+sin(closedangle)*swingweightl]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
	      }
	      hull() {
		translate([x-swingweightl,swingw/2-0.5,swingheight+wall+sin(closedangle)*swingweightl]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		translate([x-swingweightl,swingw/2-0.5,swingheight+wall+sin(closedangle)*swingweightl+swingsideh]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		translate([x,swingw/2-0.5,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		translate([x,swingw/2-0.5,swingheight+wall+swingsideh]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
	      }
	    } 
	  }

	  voidh=0.1;
	  
	  if (l && x<0) {
	    translate([x+wall,-swingw/2+0.5+wall,swingheight]) cube([swingl/2-wall*5,swingw-wall*2-1,voidh]);
	    translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8]) cube([swingl*3/4/2-wall*2,swingw-wall*2-1,voidh]);
	    translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8*2]) cube([swingl/4-wall*2,swingw-wall*2-1,voidh]);
	    translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8*3]) cube([wall*3,swingw-wall*2-1,voidh]);
	  }
	  if (!l && x>0) {
	    translate([x-swingl/2+wall*4,-swingw/2+0.5+wall,swingheight]) cube([swingl/2-wall*5,swingw-wall*2-1,voidh]);
	    translate([x-swingl*3/4/2+wall,-swingw/2+0.5+wall,swingheight+0.8]) cube([swingl*3/4/2-wall*2,swingw-wall*2-1,voidh]);
	    translate([x-swingl/4+wall,-swingw/2+0.5+wall,swingheight+0.8*2]) cube([swingl/4-wall*2,swingw-wall*2-1,voidh]);
	    translate([x-wall*4,-swingw/2+0.5+wall,swingheight+0.8*3]) cube([wall*4,swingw-wall*2-1,voidh]);
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
    
    swingside(swingw/2,l);
    mirror([1,0,0]) swingside(swingw/2,l);

    // Weighting
    hull() {
      
    }

    translate([0,-swingw/2,0]) onehinge(axled,axlel,axledepth,0,ytolerance,axledtolerance);
    translate([0,swingw/2,0]) onehinge(axled,axlel,axledepth,0,ytolerance,axledtolerance);
  }
}

arml=sqrt(pow(-lockaxlex-(swingl/2+wall+xtolerance)*cos(closedangle),2)+pow(axleheight+(swingl/2+wall)*sin(closedangle),2))+swingheight+wall/5-lockaxleheight+1;
echo("arml ", arml);
  
module lock() {
 translate([0,0,0]) onehinge(lockaxled,lockaxlel,axledepth,0,ytolerance,axledtolerance);
 ly=locklefty-lockaxley;
 ry=lockrighty-lockaxley;
 lwy=-lockweightw/2;
 
 hull() {
    translate([0,ly,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([-lockaxled/2+wall/2,ly+wall+0.5,arml+wall*4]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+wall*1.5,ly-wall*1+0.5,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=0.2);
  }

  // Weight
  hull() {
    translate([-lockaxled/2+wall/2,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2,lwy,arml+wall*3]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+lockweightl,lwy,arml+wall*4.5]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+lockweightl,lwy,arml+wall*4.5+lockweighth]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
  }

  hull() {
    w=wall*2+ytolerance+wall+ytolerance+0.2;
    translate([-lockaxled/2+wall/2,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=w);
    translate([-lockaxled/2+wall/2,lwy,arml+wall*3]) rotate([-90,0,0]) cylinder(d=wall,h=w);
    translate([-lockaxled/2+wall/2+wall*1.5,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=w);
  }

  if (0)  hull() {
    translate([0,ly,0]) rotate([90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([-lockaxled/2+wall/2,ly,arml+wall]) rotate([90,0,0]) cylinder(d=wall,h=wall);
  }

  hull() {
    translate([0,ly,0]) rotate([90,0,0]) cylinder(d=axled,h=wall);
    translate([0,ly,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=axled,h=wall);
  }

  hull() {
    translate([0,ly,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=axled,h=wall);
    translate([-lockaxled/2+wall*3,ly+wall+0.5,arml-wall-ytolerance-0.5]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2,ly+wall+0.5,arml-wall*2-ytolerance-0.5]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
  }

  hull() {
    translate([0,ry+wall,0]) rotate([90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([1,ry+wall,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled+2,h=wall);
  }
  hull() {
    translate([1,ry+wall,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled+2,h=wall);
    for (x=[0,wall]) {
      w=x?0.1:wall;
      translate([x+lockaxled+wall/2,ry+wall,arml/2-wall]) rotate([90,0,0]) cylinder(d=wall*2.4+1,h=w);
      translate([x-lockaxled/2+wall/2/2,ry+wall-0.5,arml+wall]) rotate([90,0,0]) cylinder(d=wall/2,h=w);
      translate([x+13.5,ry+wall-0.5,lockaxled+wall*2]) rotate([90,0,0]) cylinder(d=wall,h=w);
    }
  }
}

module storagegate() {
  hull() {
    translate([boxx+wall+xtolerance,boxy+wall+storagew-boxincornerd,wall*2]) roundedbox(outholel-wall-xtolerance*2,boxincornerd+wall+swingtunnelw-wall-ytolerance-0.5-wall-ytolerance-0.05,outholeh,boxincornerd);
    translate([boxx+wall+(outholel-wall-xtolerance*2)/2-maxbridge/2+xtolerance,boxy+storagew+boxincornerd,outholel*1.7-maxbridge*2]) roundedbox(maxbridge,boxincornerd*2,boxincornerd,cornerd);
  }
}

module mousebox() {
  difference() {
    union() {
      difference() {
	union() {
	  difference() {
	    union() {
	      intersection() {
		translate([boxx,boxy,0]) roundedbox(boxl,boxw,boxh,boxcornerd);
		translate([boxx,boxy,0]) cube([boxl,boxw,boxh-wall-ztolerance]);//-boxincornerd/2
	      }
	    }

	    // Spaces for swinging platforms
	    swingcut();
	    translate([0,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) swingcut();
    
	    // Incoming tunnel
	    c=boxincornerd;
	    hull() {
	      translate([boxx-c/2,-swingtunnelw/2,wall*2]) roundedbox(c/2+boxl-wall,swingtunnelw,boxh-wall+boxincornerd,c);
	      translate([-swingl/2*cos(closedangle)-cornerd/2-cornerd/2-swingweightl,-swingtunnelw/2,wall*2]) roundedbox(cornerd+2*swingweightl+swingl*cos(closedangle)-wall,swingtunnelw,boxh-wall*3,cornerd);
	    }

	    // Outgoing tunnel
	    hull() {
	      translate([-swingl/2,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(boxl+boxx+swingl/2-wall,swingtunnelw,storageh-wall,c);
	      //#	  translate([-swingl/2*cos(closedangle)-cornerd/2-cornerd/2-swingweightl,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(cornerd+2*swingweightl+swingl*cos(closedangle)-wall,swingtunnelw,boxh-wall*3,cornerd);
	    }
	    xx=swingl/2*cos(closedangle);

	    // Opening between in and out tunnels
	    translate([boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(midholel,swingtunnelw*2,boxh-wall*3+boxincornerd,boxincornerd);

	    // Opening at exit part of out tunnel
	    translate([boxx+wall,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(-boxx-xx+boxincornerd,swingtunnelw-wall-lockaxledepth/2-wall/2-lockaxledepth+ytolerance,storageh,boxincornerd);
    
	    // Opening between out tunnel and storage
	    storagegate();
	
	    // Cut for lock movement
	    translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall*2+ytolerance*2,storageh]);
	    translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2-midwallw-ytolerance-wall-ytolerance-0.5,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall+ytolerance+0.5,storageh]);

	      
	    // Cut for lock weight movement
	    y=-swingtunnelw/2-midwallw/2-lockweightw/2-0.5-ytolerance;
	    h=storageh-arml+lockweighth-wall*1+wall;
	    height=arml/2;
	    top=h+height;
	    oh=top-(lockaxled+arml*cos(lockangle))+wall;
	    oheight=lockaxled+arml*cos(lockangle);
	    intersection() {
	      union() {
		translate([lockaxlex-lockaxled/2+0.4,y,height]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+lockweightl+xtolerance,ytolerance+lockweightw+ytolerance+1,h]);

		hull() {
		  translate([lockaxlex-lockaxled/2-axledtolerance/2,y,oheight]) cube([arml*cos(lockangle)-lockaxled-wall,ytolerance+lockweightw+ytolerance+wall+0.1,oh]);
		  translate([lockaxlex-lockaxled/2-axledtolerance/2+oh,y,oheight+oh-0.1]) cube([arml*cos(lockangle)-lockaxled-wall,ytolerance+lockweightw+ytolerance+wall+0.1,0.1]);
		}
	      }

	      translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(r=arml+lockweighth+lockweightl-wall*3,h=ytolerance+lockweightw+ytolerance+wall+0.1);
	    }
	    
	    // Mouse storage
	    translate([boxx+wall,boxy+wall,wall]) roundedbox(storagel,storagew,storageh,boxincornerd);
	  }

	  for (y=[-swingw/2+wall/2+ytolerance,swingw/2-wall/2-axledepth-1-ytolerance]) {
	    for (yy=[y,y-swingtunnelw-midwallw]) {
	      hull() {
		translate([0,yy,axleheight]) rotate([-90,0,0]) cylinder(d=axled+2,h=axledepth+1);
		translate([-4,yy+0.5,(axleheight-wall)/2]) rotate([-90,0,0]) cylinder(d=(axleheight-wall*2),h=axledepth-0.01);
		translate([4,yy+0.5,(axleheight-wall)/2]) rotate([-90,0,0]) cylinder(d=(axleheight-wall*2),h=axledepth-0.01);
	      }
	    }
	  }

	  for (y=[0,-swingtunnelw/2-midwallw-swingtunnelw/2]) {
	    hull() {
	      translate([-axleheight,y-swingtunnelw/2-0.1,1/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	      translate([0,y-swingtunnelw/2-0.1,axleheight-1/2-wall-ztolerance-wall/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	      translate([axleheight,y-swingtunnelw/2-0.1,1/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	    }
	
	    hull() {
	      hull() {
		translate([-axled+2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
		translate([0,y-swingw/2+wall/2+ytolerance,axleheight-wall-ztolerance-wall/2]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2);
		translate([axled-2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
	      }
	      for (x=[-axleheight-axled,0,axleheight+axled]) {
		translate([x,y-swingw/2+wall/2+ytolerance+abs(sign(x)),wall/2]) rotate([-90,0,0]) cylinder(d=wall,h=swingw-wall-ytolerance*2-abs(sign(x))*2);
	      }
	    }
	  }

	  for (y=[locklefty+ytolerance,lockaxley-lockaxlel/2-wall-ytolerance]) {
	    hull() {
	      translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+1,h=axledepth+0.5);
	      translate([lockaxlex-lockaxled*2,y,wall/2]) rotate([-90,0,0]) cylinder(d=wall,h=axledepth+0.5);
	    }
	  }

	  if (adhesion) {
	    z=arml+lockweightl;
	    lefty=locklefty+lockaxledepth*2;
	    x=lockaxlex-lockaxled/2;
	    hull() {
	      translate([x,lefty-lockaxledepth+ytolerance,0]) cube([0.2,0.4,0.4]);
	      translate([x,lefty+ytolerance*2,z]) cube([0.2,0.4,0.4]);
	    }
	    righty=lockaxley-lockaxlel/2-wall/2-ytolerance;
	    translate([x,righty,0]) cube([0.2,0.4,z]);
	    translate([x,righty,z]) cube([0.2,lefty-righty+ytolerance+0.4,0.4]);

	    // Swings are very weakly connected through supports, so manually create support towers for better adhesion.
	    ly=0;
	    lx=-x-swingl/2-swingweightl;
	    sl=swingl/2+swingweightl*2;
	    sheight=axleheight+swingheight+wall+swingweighth+wall*2;
	    translate([x,ly-swingw/2+wall*3+1,sheight]) {
	      cube([sl,swingw-wall*4-1,0.8]);
	      cube([lx-0.2,swingw-wall*4+wall,0.8]);
	    }
	    for (xx=[x+lx:2:x+lx+swingweightl]) {
	      translate([xx,ly-swingw/2+wall*3+1+swingw-wall*4-1,sheight]) cube([0.2,1,0.4]);
	    }
	    for (xx=[x+lx+swingweightl:5:x+sl]) {
	      translate([xx,ly-swingw/2+wall*3+1+swingw-wall*4-1,sheight]) cube([0.2,1,0.4]);
	    }

	    translate([x,ly,sheight]) triangle(sl,0.8,swingsideh,2);
	    swingmheight=axleheight+swingheight+wall+1-wall/2;
	    swingmh=sheight-swingmheight;
	    translate([x,ly,swingmheight]) cube([lx-0.2,0.8,swingmheight]);
	    hull() {
	      translate([x+lx,ly,swingmheight+wall]) triangle(swingweightl,0.8,swingmh-wall,3);
	      translate([0,ly,swingmheight]) cube([0.4,0.8,swingmh]);
	      translate([0,ly,swingmheight]) cube([swingweightl-lx,0.8,swingmh]);
	    }

	    for (xx=[x+lx+swingweightl:5:x+sl]) {
	      translate([xx,ly,axleheight+swingheight]) cube([0.2,0.4,swingmh]);
	    }

	    translate([x,ly-swingw/2+wall*3+1,sheight]) cube([0.4,swingw-wall*4-1,swingmheight-swingmh]);

	    ry=-swingtunnelw/2-midwallw-swingtunnelw/2-wall*2-1;
	    ryy=-swingtunnelw/2-midwallw-swingtunnelw/2;
	    
	    translate([x,ry-swingw/2+wall*3+1,axleheight+swingheight+wall+swingweighth+wall*2]) cube([swingl/2+swingweightl*2,swingw-wall*4-1,0.8]);
	    translate([x,ryy-swingw/2-1,axleheight+swingheight+wall+swingweighth+wall*2]) cube([-x-swingl/2-0.2,swingw-wall*4-1,0.8]);
	    translate([x,ryy,axleheight]) cube([-x-swingl/2-0.2,0.8,swingheight+wall+swingweighth+wall*2]);
	      
	    translate([x,ryy,sheight]) triangle(sl,0.8,swingsideh,2);
	    //swingmheight=axleheight+swingheight+wall+1-wall/2;
	    //swingmh=sheight-swingmheight;
	    translate([x,ryy,swingmheight]) cube([lx-0.2,0.8,swingmheight]);
	    hull() {
	      translate([x,ryy,swingmheight]) cube([sl,0.8,swingmh]);
	      //	      translate([0,ryy,swingmheight]) cube([0.4,0.8,swingmh]);
	      //	      translate([0,ryy,swingmheight]) cube([swingweightl-lx,0.8,swingmh]);
	    }

	    for (xx=[x+lx+swingweightl:5:x+sl]) {
	      translate([xx,ryy-swingw/2-ytolerance,sheight]) cube([0.2,wall+1,0.4]);
	    }

	    for (xx=[x+lx+swingweightl:5:x+sl]) {
	      translate([xx,ryy,axleheight+swingheight]) cube([0.2,0.4,swingmh]);
	    }	

	    translate([x,ry-swingw/2+wall*3+1,swingmheight]) cube([0.4,swingw-wall*4-1,swingmheight]);
	  }
	}

	translate([lockaxlex,lockaxley,lockaxleheight]) onehinge(lockaxled,lockaxlel,lockaxledepth,1,ytolerance,axledtolerance);
	hull() {
	  translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+axledtolerance*2,h=lockaxlel+ytolerance*2);
	  translate([lockaxlex+lockaxled/2+axledtolerance+1,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=0.5,h=lockaxlel+ytolerance*2);
	}

	// Accommodate lock angle in locked position
	intersection() {
	  hull() {
	    translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+axledtolerance*2,h=lockaxlel+ytolerance*2);
	    translate([lockaxlex+lockaxled+axledtolerance+1,lockaxley-lockaxlel/2-ytolerance,lockaxleheight+lockaxled/2]) rotate([-90,0,0]) cylinder(d=0.5,h=lockaxlel+ytolerance*2);
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

      for (x=[boxx+boxw/4,boxx+boxw-boxw/4]) {
	for (y=[boxy+clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }

      for (x=[boxx+boxw/4,boxx+boxw/2,boxx+boxw-boxw/4]) {
	for (y=[boxy+wall+storagew+wall-clipd/2,boxy+wall+storagew+clipd/2,boxy+boxw-clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }
	
      for (x=[boxx+clipd/2,boxx+boxl-clipd/2]) {
	for (y=[-swingtunnelw/2-midwallw-swingtunnelw/2,boxy+wall+storagew/4,boxy+wall+storagew*3/4]) {
	  translate([x,y,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,0);
	}

	translate([boxx+boxw-clipd/2,0,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,0);
      }
    }

    doorcut();
  }
}

// Make a roof insert for cover. Call roundedroofcut separately as these may be unionized.
module roundedroof(x,y,z,l,w,h,c) {
  cutsmall=1;
  intersection() {
    translate([x+xtolerance,y+ytolerance,z-c/2]) roundedbox(l-xtolerance*2,w-ytolerance*2,h+c,c);
    translate([x,y,z+cutsmall]) cube([l,w,h-cutsmall]);
  }
}

// Cutout part of roof insert
module roundedroofcut(x,y,z,l,w,h,c) {
  translate([x+xtolerance,y+ytolerance,z-c/2]) roundedbox(l-xtolerance*2,w-ytolerance*2,c,c);
}

module cover() {
  difference() {
    union() {
      intersection() {
	translate([boxx,boxy,0]) roundedbox(boxl,boxw,boxh,boxcornerd);
	translate([boxx-0.1,boxy-0.1,boxh-wall]) cube([boxl+0.2,boxw+0.02,wall]);
      }

      theight=axleheight+swingheight+swingl/2*sin(closedangle)-wall;
      th=boxh-theight+wall+boxincornerd+0.01;
      tx=-cos(closedangle)*swingl/2-wall;
      tl=boxl-tx+boxx-wall;
  
      intersection() {
	union() {
	  difference() {
	    union() {
	      // Incoming tunnel
	      intersection() {
		roundedroof(boxx-boxincornerd/2,-swingtunnelw/2,boxh-wall-boxincornerd/2,boxincornerd/2+boxl-wall,swingtunnelw,boxincornerd/2,boxincornerd);
		translate([boxx,-swingtunnelw/2+ytolerance,boxh-wall-boxincornerd]) cube([boxl-wall-xtolerance,swingtunnelw-ytolerance*2,boxincornerd]);
	      }

	      // Outgoing tunnel main section
	      roundedroof(tx+boxincornerd/2,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,tl-boxincornerd/2,swingtunnelw,boxincornerd/2,boxincornerd);
	      translate([boxx+wall+boxincornerd/2+xtolerance,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,boxh-wall-boxincornerd/2+1]) cube([tx-boxx+boxincornerd/2,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance*2,boxincornerd/2-1]);
	      translate([tx+boxincornerd/2,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,boxh-wall-boxincornerd/2+1]) cube([boxincornerd/2+xtolerance,swingtunnelw-ytolerance*2,boxincornerd/2-1]);

	      // Opening between out and storage tunnels
	      roundedroof(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,midholel,swingtunnelw*2,boxincornerd/2,boxincornerd);
	      roundedroof(boxx+wall,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance+wall+0.5+ytolerance,theight,boxl-wall-tl-wall,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance-wall-0.5-ytolerance,boxh-wall-theight,boxincornerd);
	      // Close extra spaces
	      translate([boxx+wall+xtolerance,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,theight-boxincornerd/2]) roundedbox(boxl-wall-tl-wall+boxincornerd/2,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance*2,boxh-wall-theight+boxincornerd/2+wall,boxincornerd);
		      
	      // Mouse storage
	      roundedroof(boxx+wall,boxy+wall,boxh-wall-boxincornerd/2,storagel,storagew,boxincornerd/2,boxincornerd);
	    }

	    // Incoming tunnel roof cut
	    roundedroofcut(boxx-boxincornerd/2,-swingtunnelw/2,boxh-wall-boxincornerd/2,boxincornerd/2+boxl-wall,swingtunnelw,boxincornerd/2,boxincornerd);
	
	    // Outgoing tunnel roof cut
	    roundedroofcut(tx+boxincornerd/2,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,tl-boxincornerd/2,swingtunnelw,boxincornerd/2,boxincornerd);

	    // Outgoing tunnel to storage root cut
	    storagegate(); // Hole to storage
	    roundedroofcut(boxx+wall,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance+wall+0.5+ytolerance,theight-boxincornerd-0.01,boxl-wall-tl-wall+10,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance-wall-0.5-ytolerance*2,boxh-wall-theight,boxincornerd);

	    // Swing cuts
	    coverswingcut(0,-swingtunnelw-midwallw-swingtunnelw/2,wall/2,swingl,boxh-2*wall-boxincornerd,swingtunnelw,axleheight,swingl+wall/2+ytolerance,boxincornerd);
	    coverswingcut(0,-swingtunnelw-midwallw-swingtunnelw/2,wall/2,swingl+(swingsideh*sin(closedangle)+wall+ytolerance)*2,boxh-2*wall-boxincornerd,ytolerance+wall+0.5+ytolerance,axleheight,swingl+wall/2+ytolerance+swingsideh*sin(closedangle)+wall+ytolerance,boxincornerd);
	
	    // Opening between in and out tunnels roof cut
	    roundedroofcut(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,midholel,swingtunnelw*2,boxincornerd/2,boxincornerd);

	    // Storage roof cut
	    roundedroofcut(boxx+wall,boxy+wall,boxh-wall-boxincornerd/2,storagel,storagew,boxincornerd/2,boxincornerd);
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
	  hull() {
	    translate([x,-swingw/2+wall*2,z]) rotate([-90,0,0]) cylinder(h=closew,d=wall);
	    //lx=(-swingl/2)*cos(closedangle)+wall+wall+closeh*sin(closedangle);
	    lx=x/2;
	    translate([lx,-swingw/2+wall*2,boxh-wall/2]) rotate([-90,0,0]) cylinder(h=closew,d=wall);
	    translate([0,-swingw/2+wall*2,boxh-wall/2]) rotate([-90,0,0]) cylinder(h=closew,d=wall);
	  }
	  hull() {
	    translate([x,-swingw/2-ytolerance,closeheight-wall]) rotate([-90,0,0]) cylinder(h=swingw-wall,d=wall);
	    translate([0,-swingw/2-ytolerance,boxh-wall]) rotate([-90,0,0]) cylinder(h=swingw-wall,d=wall);
	  }
	  hull() {
	    xd=-x;
	    zd=boxh-z;
	    ad=atan2(zd,xd);
	    translate([x+(swingsideh+wall)*cos(ad),-swingtunnelw/2+ytolerance,z+(swingsideh+wall)*sin(ad)]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	    translate([0,-swingtunnelw/2+ytolerance,boxh-wall]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	  }
	}
      }

      hull() {
	//    translate([
	translate([(-swingl/2)*cos(closedangle)+wall+wall+closeh*sin(closedangle),-swingw/2+wall*2,boxh-wall]) rotate([-90,0,0]) cylinder(h=closew,d=wall);
      }
    }

    // Cover locking clips
    for (x=[boxx+boxw/4,boxx+boxw/2,boxx+boxw-boxw/4]) {
      for (y=[boxy+clipd/2,boxy+wall+storagew+wall-clipd/2,boxy+wall+storagew+clipd/2,boxy+boxw-clipd/2]) {
	translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
      }
    }
    for (x=[boxx+clipd/2,boxx+boxl-clipd/2]) {
      for (y=[-swingtunnelw/2-midwallw-swingtunnelw/2,boxy+wall+storagew/4,boxy+wall+storagew*3/4]) {
	translate([x,y,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,dtolerance);
      }
	  
      translate([boxx+boxw-clipd/2,0,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,dtolerance);
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
    
    for (x=[boxx+wall+airholefromedge+airholexstep/2:airholexstep:boxx+boxl-airholefromedge]) {
      for (y=[boxy+wall+airholefromedge+airholeystep/2:airholeystep:boxy+storagew-airholefromedge]) {
	hull() {
	  translate([x,y,boxh-wall-0.1]) cylinder(d=airholeindiameter,h=0.3);
	  translate([x,y,boxh-wall-0.1]) cylinder(d=airholeoutdiameter,h=0.1);
	}
	translate([x,y,boxh-wall-0.1]) cylinder(d=airholeindiameter,h=wall+0.2);
      }
    }
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
  translate([boxx+wall+storagel/2-doorl/2-wall,boxy,wall]) {
    hull() {
      translate([doorw,0,0]) cube([doorl,doorw,doorh]);
      translate([0,doorw-0.01,doorw]) cube([doorl+doorw*2,0.01,doorh-doorw]);
    }
  }
  translate([boxx+boxw/2,boxy+clipd/2,clipheight]) tubeclip(clipl,clipd,0);
}

module doorcut() {
  translate([boxx+wall+storagel/2-doorl/2-wall-xtolerance,boxy-ytolerance,wall-ztolerance]) {
    hull() {
      translate([doorw,0,0]) cube([doorl+ytolerance*2,doorw+xtolerance*2,doorh]);
      translate([-xtolerance,-ytolerance+doorw-0.01,wall]) cube([doorl+doorw*2+xtolerance*2,0.04+ytolerance*2,doorh+ztolerance]);
    }
    translate([doorw,0,boxincornerd/2]) cube([doorl+ytolerance*2,doorw+xtolerance*2+wall,doorl+boxincornerd]);
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
  intersection() {
    mousetrap(angle,lockangle);
    translate([mechanismx,mechanismy,mechanismz]) cube([mechanisml,mechanismw,mechanismh]);
  }
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
      //mousetrap(angle,lockangle);
      //	#  box();
      mechanics(angle,lockangle);
      door();
      //                cover();
    }
    //       translate([boxx+wall*2,-swingtunnelw/2-midwallw-1,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
  }
 }

if (print==1) {
  translate([0,0,-xxx-0.01]) rotate([0,-90,0]) 
  intersection() {
    union() {
      mousetrap(0,0);
    }
    //              translate([-200,0,-1]) cube([400,400,50]);//axleheight+1

    union() {
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
  translate([0,0,0]) rotate([0,-90,0]) translate([-boxx+(boxx-mechanismx),0,0]) mechanics();
 }

if (print==3) {
  translate([-boxx,0,0]) box();
 }

if (print==4) {
  intersection() {
    translate([0,0,boxh]) rotate([180,0,0]) cover();
    //translate([00,0,-1]) cube([400,170,50]);//axleheight+1
  }
 }

if (print==5) {
  rotate([90,0,0]) translate([0,-boxy,0]) door();
 }
