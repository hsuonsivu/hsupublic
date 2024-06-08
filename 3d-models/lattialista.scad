// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679



use <hsu.scad>

print=2; // 0 shape, 1 kitchen corner 2 eteinen 3 backplate, 4 both, 5 corner piece

strong=0;

width=55;
insidewidth=47; // Including clip
edge=14;
insidetoclip=9.51;
totalthickness=21;
topedgethickness=3;
bottomedgethickness=1.5;
//insidewidth=width-topedgethickness-bottomedgethickness;
clipz=1.6;//1.65;
clipx=1;
cornerd=2;
incornerd=6;
facethickness=3;
clipcornerd=1;
$fn=60;

clipheight=(width-insidewidth)/2;

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


module lista(length,angledend) {
  difference() {
    union() {
      difference() {
	roundedbox(width,length,totalthickness,cornerd);
	translate([bottomedgethickness,-incornerd,facethickness]) roundedbox(width-(topedgethickness+bottomedgethickness),length+incornerd*20,totalthickness-facethickness+incornerd,incornerd);
      }
      hull() {
	for (y=[clipcornerd/2,length-clipcornerd/2]) {
	  translate([bottomedgethickness-clipcornerd/2,y,totalthickness-clipcornerd/2]) sphere(d=clipcornerd);
	  translate([bottomedgethickness+clipx-clipcornerd/2,y,totalthickness-clipcornerd/2-clipz]) sphere(d=clipcornerd);
	  translate([bottomedgethickness-clipcornerd/2,y,totalthickness-clipz*2-clipcornerd/2]) sphere(d=clipcornerd);
	}
      }

      hull() {
	for (y=[clipcornerd/2,length-clipcornerd/2]) {
	  translate([width-topedgethickness+clipcornerd/2,y,totalthickness-clipcornerd/2]) sphere(d=clipcornerd);
	  translate([insidewidth+clipx+clipcornerd/2,y,totalthickness-clipcornerd/2]) sphere(d=clipcornerd);
	  translate([insidewidth+clipcornerd/2,y,totalthickness-clipz-clipcornerd/2]) sphere(d=clipcornerd);
	  translate([width-topedgethickness+clipcornerd/2,y,totalthickness-clipz-(width-insidewidth)]) sphere(d=clipcornerd);
	}
      }
    }
    if (angledend==1 || angledend==3) {
      translate([-0.02,-0.02,-0.02]) triangle(width+0.04,totalthickness+0.04,totalthickness+0.04,10);
    }
    if (angledend==2 || angledend==3) {
      translate([-0.02,length-totalthickness,-0.02]) triangle(width+0.04,totalthickness+0.04,totalthickness+0.04,9);
    }
  }
}

internalbase=5;
internalwidth=49;
internalbasethickness=1.5;
internalbasewidth=48;
internalformd=1.8;
internalformr=internalformd/2;
internaledgeh=7.4;
internalh=14;
internalhalfh=3.4;
internallength=17;

outsidebase=0;
outsidewidth=55;
outsidebasethickness=1.2;
outsidebasewidth=48.5;
outsideformd=2;
outsideformr=outsideformd/2;
outsideedgeh=13.5;
outsideh=21;
//outsidehalfh=3.6;
outsidelength=55+outsideformd;
outsidestart=15;
outsidejoiny=-internalwidth/2+internalformr;

endcut=max(internalformr,outsideformr);

module internalform(l,filled) {
  intersection() {
       translate([0,-internalwidth/2,0]) cube([l,internalwidth/2,internalbase+internalh]);
    union() {
      hull() {
	for (x=[-internalformr,l+internalformr]) {
	  translate([x,-internalbasewidth/2,internalbase]) cube([internalbasethickness,internalbasethickness,0.1]);
	  translate([x+internalformr,-internalwidth/2+internalformr,internalbase+internalhalfh]) sphere(d=internalformd);
	  translate([x+internalformr,-internalwidth/2+internalformr,internalbase+internaledgeh]) sphere(d=internalformd);
	}
      }

      hull() {
	for (x=[-internalformr,l+internalformr]) {
	  translate([x,-internalwidth/2+internalformr,internalbase+internaledgeh]) sphere(d=internalformd);
	  translate([x,0,internalbase+internalh-internalformr]) sphere(d=internalformd);
	}
      }
    }
  }
}

insideclipl=19;
insidecliple=25;
insideclipy=3.2;
insidecliph=2.62;
insideclipd=0.2;
insideclipr=insideclipd/2;

module outsideform(l,filled) {
  intersection() {
    translate([0,-outsidewidth/2,0]) cube([l,outsidewidth/2,outsidebase+outsideh]);
    union() {
      hull() {
	for (x=[l/2-insidecliple/2,l/2+insidecliple/2]) {
	  translate([x,-internalwidth/2+internalformr,insidecliph*2/3]) sphere(d=insideclipd);
	}
	
	for (x=[l/2-insideclipl/2,l/2+insideclipl/2]) {
	  translate([x,-internalwidth/2+insideclipy-internalformr,insidecliph]) sphere(d=insideclipd);
	  translate([x,-internalwidth/2,insidecliph]) sphere(d=insideclipd);
	  translate([x,-internalwidth/2+internalbasethickness,0]) sphere(d=insideclipd);
	}
      }
      
      hull() {
	for (x=[-outsideformr,l+outsideformr]) {
	  translate([x,-outsidebasewidth/2,outsidebase]) cube([outsidebasethickness,outsidebasethickness,0.1]);
	  //      translate([x+outsideformr,outsidejoiny,outsidebase+outsideedgeh]) sphere(d=outsideformd);
	  translate([x+outsideformr,-outsidewidth/2+outsideformr,outsidebase+outsideedgeh]) sphere(d=outsideformd);
	}
	if (filled) {
	for (x=[-outsideformr,l+outsideformr]) {
	  translate([x+outsideformr,-outsidewidth/2+outsideformr,outsidebase+outsideedgeh]) sphere(d=outsideformd);
	  translate([x+outsideformr,0,outsidebase+outsideh-outsideformr]) sphere(d=outsideformd);
	  translate([x+outsideformr,0,-outsideformr]) sphere(d=outsideformd);
	}
	}
      }

      hull() {
	for (x=[-outsideformr,l+outsideformr]) {
	  translate([x+outsideformr,-outsidewidth/2+outsideformr,outsidebase+outsideedgeh]) sphere(d=outsideformd);
	  translate([x+outsideformr,0,outsidebase+outsideh-outsideformr]) sphere(d=outsideformd);
	}
      }
    }
  }
}

module joinform(l,filled) {
  intersection() {
    translate([0,-outsidewidth/2,0]) cube([l,outsidewidth/2,outsidebase+outsideh]);
    union() {
      hull() {
	for (x=[-outsideformr,l+outsideformr]) {
	  translate([x,-outsidebasewidth/2,outsidebase]) cube([outsidebasethickness,outsidebasethickness,0.1]);
	  //      translate([x+outsideformr,outsidejoiny,outsidebase+outsideedgeh]) sphere(d=outsideformd);
	  translate([x+outsideformr,-outsidewidth/2+outsideformr,outsidebase+outsideedgeh]) sphere(d=outsideformd);

	  translate([x,-internalbasewidth/2,internalbase]) cube([internalbasethickness,internalbasethickness,0.1]);
	  translate([x+internalformr,-internalwidth/2+internalformr,internalbase+internalhalfh]) sphere(d=internalformd);
	  translate([x+internalformr,-internalwidth/2+internalformr,internalbase+internaledgeh]) sphere(d=internalformd);
	}
      }

      hull() {
	for (x=[-outsideformr,l+outsideformr]) {
	  translate([x+outsideformr,-outsidewidth/2+outsideformr,outsidebase+outsideedgeh]) sphere(d=outsideformd);
	  translate([x+outsideformr,0,outsidebase+outsideh-outsideformr]) sphere(d=outsideformd);
	  translate([x+internalformr,-internalwidth/2+internalformr,internalbase+internaledgeh]) sphere(d=internalformd);
	  translate([x+internalformr,0,internalbase+internalh-internalformr]) sphere(d=internalformd);
	}
      }
    }
  }
}

supportstart=0;
supportend=outsidestart+outsidelength;
supportfromwall=3;
supportdistance=14;
supportthickness=0.3;
supportthicknesstop=0.3;

supportdistanceinternal=(internallength-1+supportthicknesstop)/2;

module kulmapalabase(filled) {
  start=filled?0:outsidestart;
  l=filled?outsidelength+outsidestart:outsidelength;
  internalform(internallength,filled);
  translate([start,0,0]) joinform(internallength-outsidestart,filled);
  translate([start,0,0]) outsideform(l,filled);

  for (x=[outsidestart+outsidelength-supportthicknesstop:-supportdistance:outsidestart+supportdistance]) {
    hull() {
      translate([x,-internalbasewidth/2+5,0]) cube([supportthickness,internalbasewidth/2-5,1]);
      translate([x,-internalwidth/2-outsideformd/2,outsideedgeh-outsideformd/2]) cube([supportthicknesstop,1,1]);
      translate([x,0,outsideh-outsideformd]) cube([supportthicknesstop,1,1]);
    }
  }

  for (x=[0:supportdistanceinternal:internallength]) {
    hull() {
      translate([x,-internalbasewidth/2+5,0]) cube([supportthickness,internalbasewidth/2-5,1]);
      translate([x,-internalwidth/2+internalformd/2,internalbase]) cube([supportthicknesstop,1,1]);
      translate([x,-internalwidth/2+internalformd/2,internalbase+internaledgeh-internalformd/2]) cube([supportthicknesstop,1,1]);
      translate([x,0,internalbase+internalh-internalformd]) cube([supportthicknesstop,1,1]);
    }
  }

}

module kulmapalabasemirrored(filled) {
  maxdimensions=max(outsidewidth,outsidelength+internallength);
  translate([-outsidestart,outsidewidth/2,0]) {
    intersection() {
      union() {
	translate([0,-outsidewidth/2,0]) cube([outsidestart,outsidewidth,outsidebase+outsideh]);
	translate([outsidestart,-outsidewidth/2,0]) rotate([0,0,45]) cube([maxdimensions*2,maxdimensions*2,maxdimensions*2]);
      }
      union() {
	kulmapalabase(filled);
	mirror([0,1,0]) kulmapalabase(filled);

	hull() {
	  translate([internallength+1+supportthicknesstop+5,-internalwidth/2+supportthicknesstop+5,0]) sphere(supportthicknesstop/2);
	  translate([internallength-outsideformr+2,-outsidewidth/2+outsideformr+2,outsideedgeh]) sphere(supportthicknesstop/2);
	  #translate([outsidestart+outsidelength-outsideformd-8,internalwidth/2+1+outsideformd-8,0]) sphere(supportthicknesstop/2);
	  translate([outsidestart+outsidelength-outsideformd-3,internalwidth/2+1+outsideformd-3,outsideedgeh]) sphere(supportthicknesstop/2);
	  translate([outsidestart+outsidelength/2-outsideformd/2,0,outsideh-outsideformd]) sphere(supportthicknesstop/2);
	}
      }
    }
  }
}

if (print==6) {
  kulmapalabasemirrored(0);
 }

module kulmapala(filled) {
  render() {
    kulmapalabasemirrored(filled);
    mirror([1,-1,0]) kulmapalabasemirrored(filled);
  }
}

module kulmapalafilled() {
}

if ((print==1)) {
  lista(20,0);
 }

if (print==2) {
  kulmashiftleft=3;
  kulmashiftright=5;
  vasen=170-10+kulmashiftleft;
  oikea=175-7+kulmashiftright;
  poikki=210;
  kulmaleikkaus=11; // Extra for end cut
  translate([1,0,0]) {
    translate([0,0,0]) lista(poikki + 0.01,3);
    translate([0,poikki,0]) rotate([91.0,0,0]) difference() {
      lista(oikea+kulmaleikkaus+0.01,1); //96
      #translate([outsidewidth+1,oikea+23+kulmashiftleft,16]) rotate([91,180,0]) kulmapala(1);
    }
    rotate([-0.25,0,0]) translate([0,0,vasen+kulmaleikkaus]) rotate([90,180,180]) render() difference() {
      lista(vasen+kulmaleikkaus+0.01,2);
      #translate([outsidewidth+1-2,-18+kulmashiftleft,16]) rotate([-90,90,0]) kulmapala(1);
    }
  }
 }


backplatethickness=totalthickness-(totalthickness-clipz*2-clipcornerd/2)+1;//+1;

if (print == 3 || print == 4) {

  backplatel=100;
  backplatescrewd=4.8;
  backplatescrewl=10;
  textdepth=0.7;
  textheight=6;
  
  if (print == 4) lista(backplatel,0);
  
  translate([0,0,print==4 ? 0 : -totalthickness+backplatethickness]) difference() {
    union() {
      translate([bottomedgethickness-clipcornerd,clipcornerd,totalthickness-backplatethickness]) cube([width-topedgethickness-clipcornerd/2,backplatel-clipcornerd*2,backplatethickness-clipcornerd/2]);
      translate([width/4,clipcornerd,totalthickness-backplatethickness]) cube([width/2,backplatel-clipcornerd*2,backplatethickness]);
    }
    lista(backplatel,0);
    for (y=[backplatescrewd*2+clipcornerd,backplatel/2+clipcornerd,backplatel-backplatescrewd*2-clipcornerd]) {
      //      translate([width/2,y,0]) cylinder(h=totalthickness+1,d=backplatescrewd);
      translate([width/2,y,totalthickness-backplatescrewl]) ruuvireika(totalthickness-backplatescrewl+1,backplatescrewd,0);
    }

    translate([textheight/2+1,backplatel/2-clipcornerd,totalthickness-clipcornerd/2-textdepth+0.01]) linear_extrude(height=textdepth+0.01) rotate([0,0,-90]) text("Down towards the wall",size=textheight,halign="center");
  }
 }

if (print == 5) {
  kulmapala(0);
 }
