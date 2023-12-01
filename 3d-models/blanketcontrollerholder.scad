cornerd=1;
// 0 whole part (no joints), 1 upper parts, 2 lower part
print=2;

belowpartheight=170;
bottompartheight=170;
midpartheight=170;
toppartheight=300;

maxwidth=210;
maxdepth=100;

bedattachoutheight=100;
bedattachinheight=15;
bedattachdepth=32;
bedattachwidth=33;
bedattachoutdepth=8;
bedattachindepth=5;
bedattachthickness=6;

bedbaseheight=150+275;

bedsupportwidth=200;

controllerholderlowwidth=56;
controllerholderlowheight=35;
controllerholderlowdepth=33; // verify

controllerheight=160;
cablecutw=18;

  
controllerholderupwidth=63.5;
controllerholderupheight=30; // verify
controllerholderupdepth=34;

controllerholderbackdepth=8;
controllerholderbackwidth=bedattachwidth;

controllerwall=5;

maxxspace=controllerholderlowwidth+controllerwall;

cd=10;

cablehookheight=40;
cablehookwall=6;
cableholed=20;

wall=3;
jointwidth=bedattachwidth-cornerd;
jointheight=40;
jointmidheight=20;
jointthickness=6;
jointwidening=7;
jointmaxw=jointwidth*0.2;
jointminw=jointwidth*0.3;
tolerance=0.3;
jointp=[[jointwidth-jointminw,0],
	[jointwidth-jointmaxw,jointmidheight/2],
	[jointmaxw,jointmidheight/2],
	[jointminw,0]];

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

module malejoint(x,y,z) {
  translate([x+cornerd/2,y+bedattachoutdepth-0.01,z]) cube([jointwidth,jointthickness+0.01,jointmidheight]);
  translate([x+cornerd/2,y+bedattachoutdepth-0.01,z+jointmidheight-0.01]) triangle(jointwidth,jointthickness+0.01,jointheight,8);
  //  translate([x,y+bedattachoutdepth+jointthickness+0.01,z]) rotate([90,0,0]) linear_extrude(height=bedattachoutdepth+jointthickness-0.02) polygon(points=jointp);
}

module malejointcut(x,y,z) {
  translate([x,y+bedattachoutdepth+jointthickness+0.01,z-0.01]) rotate([90,0,0]) linear_extrude(height=bedattachoutdepth+jointthickness+0.02) polygon(points=jointp);
}

module femalejoint(x,y,z) {
  translate([x+cornerd/2,y,z-jointmidheight]) cube([jointwidth,bedattachoutdepth+jointthickness,jointmidheight]);
  translate([x+cornerd/2,y+bedattachoutdepth-0.01,z-jointmidheight-jointheight]) triangle(jointwidth,jointthickness,jointheight+0.01,10);
  translate([x,y+bedattachoutdepth+jointthickness,z]) rotate([90,0,0]) linear_extrude(height=bedattachoutdepth+jointthickness+0.02) scale([0.99,1,0.99]) polygon(points=jointp);
}

module bedcontrollerholder() {
  roundedbox(bedattachwidth,bedattachoutdepth,bedattachoutheight,cornerd);
  translate([-bedsupportwidth/2+bedattachwidth/2,0,bedattachoutheight-bedattachthickness]) roundedbox(bedsupportwidth,bedattachoutdepth+bedattachdepth+bedattachindepth,bedattachthickness,cornerd);
  translate([cornerd/2,0,bedattachoutheight-0.01]) triangle(bedattachwidth-cornerd,bedattachoutdepth+bedattachdepth+bedattachindepth-cornerd/2,bedattachthickness,8);
  translate([-bedsupportwidth/2+bedattachwidth/2,bedattachoutdepth+bedattachdepth,bedattachoutheight-bedattachinheight]) roundedbox(bedsupportwidth,bedattachindepth,bedattachinheight,cornerd);
  translate([-bedsupportwidth/2+bedattachwidth/2+cornerd/2,bedattachoutdepth+bedattachdepth-bedattachindepth,bedattachoutheight-bedattachinheight+cornerd/2+0.01]) triangle(bedsupportwidth-cornerd,bedattachindepth,bedattachinheight-cornerd/2,9);

  roundedbox(bedattachwidth,bedattachoutdepth,bedattachoutheight+bedbaseheight+cornerd/2,cornerd);

  difference() {
    translate([bedattachwidth/2+cablecutw/2,0,bedattachoutheight+bedbaseheight+controllerwall+controllerheight]) roundedbox(cablehookwall,cableholed*1.3,cablehookheight+1.5*cablehookwall,cornerd);
    translate([bedattachwidth/2+cablecutw/2-0.01,cableholed/3,bedattachoutheight+bedbaseheight+controllerwall+controllerheight+cablehookheight/1.5+cablehookwall/2]) rotate([0,90,0]) cylinder(h=cablehookwall+0.02,d=cableholed);
  }
  difference() {
    translate([bedattachwidth/2+cablecutw/2+cablehookwall*3,0,bedattachoutheight+bedbaseheight+controllerwall+controllerheight]) roundedbox(cablehookwall,cableholed,cablehookheight+cablehookwall,cornerd);
    translate([bedattachwidth/2+cablecutw/2+cablehookwall*3-0.01,cableholed*0.8,bedattachoutheight+bedbaseheight+controllerwall+controllerheight+cablehookheight/1.5+cablehookwall/2]) rotate([0,90,0]) cylinder(h=cablehookwall+0.02,d=cableholed);
  }
  
  difference() {
    union() {
      translate([bedattachwidth/2-controllerholderlowwidth/2-controllerwall,0,bedattachoutheight+bedbaseheight]) roundedbox(controllerholderlowwidth+controllerwall+controllerwall,controllerwall+controllerholderlowdepth+controllerwall,controllerholderlowheight+controllerwall-cornerd,cornerd);

      translate([bedattachwidth/2-controllerholderbackwidth/2,0,bedattachoutheight+bedbaseheight]) roundedbox(bedattachwidth,controllerholderbackdepth,controllerwall+controllerheight+controllerwall,cornerd);
	     
      translate([bedattachwidth/2-controllerholderupwidth/2-controllerwall,0,bedattachoutheight+bedbaseheight+controllerwall+controllerheight-controllerholderupheight]) roundedbox(controllerholderupwidth+controllerwall+controllerwall,controllerwall+controllerholderupdepth+controllerwall,controllerholderupheight+controllerwall,cornerd);
    }

    hull() {
    for (yfront=[controllerholderbackdepth+cd,controllerholderbackdepth+controllerholderlowdepth-cd]) {
      for (xx=[bedattachwidth/2-controllerholderlowwidth/2+cd,bedattachwidth/2+controllerholderlowwidth/2-cd]) {
      translate([xx,yfront,bedattachoutheight+bedbaseheight+controllerwall+cd]) sphere(cd);
      translate([xx,yfront,bedattachoutheight+bedbaseheight+controllerwall+controllerholderlowheight+cd]) sphere(cd);
      }
    }

    yfront2=controllerholderbackdepth+controllerholderlowdepth;
    translate([bedattachwidth/2,yfront2,bedattachoutheight+bedbaseheight+controllerwall+cd]) sphere(cd);
    translate([bedattachwidth/2,yfront2,bedattachoutheight+bedbaseheight+controllerwall+controllerholderlowheight+cd]) sphere(cd);
}
    
    translate([bedattachwidth/2-cablecutw/2,controllerholderbackdepth,bedattachoutheight+bedbaseheight-cornerd]) roundedbox(cablecutw,controllerholderlowdepth+controllerwall*2,controllerholderlowheight+controllerwall+2*cornerd,cornerd);

    translate([bedattachwidth/2-controllerholderupwidth/2,controllerholderbackdepth,bedattachoutheight+bedbaseheight+controllerwall+controllerheight-controllerholderupheight-cornerd]) roundedbox(controllerholderupwidth,controllerwall+controllerholderupdepth+cornerd,controllerholderupheight+cornerd,cornerd);

        translate([bedattachwidth/2-cablecutw/2,controllerholderbackdepth,bedattachoutheight+bedbaseheight+controllerwall+controllerheight-cornerd]) roundedbox(cablecutw,controllerholderupdepth+controllerwall*2,controllerwall+2*cornerd,cornerd);

  }
}

if (print == 0)
  bedcontrollerholder();

if (print == 1) {
  //  bedcontrollerholder();
  
  translate([-bedsupportwidth/2+bedattachwidth-1,0,0]) union() {
    rotate([90,0,0]) union() {
      intersection() {
	bedcontrollerholder();
	translate([bedattachwidth/2-maxwidth/2,0,0]) cube([maxwidth,maxdepth,belowpartheight]);
      }
      femalejoint(0,0,belowpartheight);
    }
  }
 }

if (print == 2) {
  translate([0,belowpartheight,0]) 
    rotate([90,0,0]) difference() {
    union() {
      malejoint(0,0,belowpartheight);
      intersection() {
	bedcontrollerholder();
	translate([bedattachwidth/2-maxwidth/2,0,belowpartheight]) cube([maxwidth,maxdepth,bottompartheight]);
      }
      femalejoint(0,0,belowpartheight+bottompartheight);
    }
    malejointcut(0,0,belowpartheight);
  }

  translate([bedattachwidth+1,belowpartheight+bottompartheight,0]) rotate([90,0,0]) difference() {
    union() {
      malejoint(0,0,belowpartheight+bottompartheight);
      intersection() {
	bedcontrollerholder();
	translate([bedattachwidth/2-maxwidth/2,0,belowpartheight+bottompartheight]) cube([maxwidth,maxdepth,midpartheight]);
      }
      femalejoint(0,0,belowpartheight+bottompartheight+midpartheight);
    }
    malejointcut(0,0,belowpartheight+bottompartheight);
  }

  translate([2*bedattachwidth+controllerholderupwidth/2+controllerwall+1-bedattachwidth/2+1,belowpartheight+bottompartheight+midpartheight,0]) {
    rotate([90,0,0]) difference() {
      union() {
	malejoint(0,0,belowpartheight+bottompartheight+midpartheight);
	intersection() {
	  bedcontrollerholder();
	translate([bedattachwidth/2-maxwidth/2,0,belowpartheight+bottompartheight+midpartheight]) cube([maxwidth,maxdepth,toppartheight]);
	}
      }
      malejointcut(0,0,belowpartheight+bottompartheight+midpartheight);
    }
  }
 }


  

