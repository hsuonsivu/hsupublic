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
print=0;
facethickness=3;
clipcornerd=1;
$fn=90;

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

//lista(20,0);
//lista(96,1);
//translate([width+1,0,0]) lista(130,2);

if (0) translate([-width-1,0,0]) {
  translate([0,0,0]) lista(130 + 0.01,2);
  translate([0,130,0]) rotate([90,0,0]) lista(125+0.01,1); //96
}

vasen=170;
oikea=175;
poikki=210;
translate([1,0,0]) {
  translate([0,0,0]) lista(poikki + 0.01,3);
  translate([0,poikki,0]) rotate([90.25,0,0]) lista(oikea+0.01,1); //96
  rotate([-0.25,0,0]) translate([0,0,vasen]) rotate([90,180,180]) lista(vasen+0.01,2); //96
}
