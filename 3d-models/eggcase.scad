// 0 = draft 1 = final 2 = bottom 3 = cover
print=1;
// Print texts even in draft mode
printtext=1;
// ankermake 0.2 mm layers, change color at
// ;LAYER:132, add M600
// ;LAYER:135, add M600
eggs=1;

tolerance=0.2;
cornersize=3;
wall=2.5;
eggspace=2;
zfactor = (print == 0) ? 0.2 : 1;
xyfactor= (print == 0) ? 0.2 : 1;

eggd=40 * xyfactor;

eggheight=59.5 * zfactor;

eggmaxd=48 * xyfactor;

eggmaxdh=28 * zfactor;

eggtopd=32 * xyfactor;

fingeropeningd=20;
fingeropeningh=15;
fingeropeningwidth=20;

lockbottom=wall;
lockcut=1;
lockwidth=fingeropeningd+3;
locknotchd=2.5;
lockdepth=locknotchd;//wall;
lockback=locknotchd/2+tolerance;

objectxgap=locknotchd/2+1;

//xsize=1.3;
ysize=1.3;
basedepth=28;
deeptext=0;
textheight=7;
textspace=textheight/3;
textdepth=1;
basewidth=eggmaxd*eggs*ysize;
baselength=eggmaxd + lockdepth + lockback + eggspace + textspace + textheight + lockdepth + lockback;
eggxposition=eggmaxd/2 + tolerance + wall + locknotchd;
eggtextxposition=baselength - tolerance - lockdepth - lockback - textspace;
//echo("textheigth ", textheight);
eggholedepth=2.9;

yfree=basewidth - eggmaxd*eggs;//)/2;//????
  
eggy=yfree/(eggs+1)+eggmaxd/2;
eggdistance=(eggmaxd+yfree/(eggs+1));
//echo("eggdistance ", eggdistance);

eggbasez=basedepth+eggd/eggholedepth-eggd/2;

eggtop=eggbasez+eggheight;

eggbase=basedepth-eggheight/eggholedepth;

$fn=(print > 0) ? 180 : 90;

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

module fancyroundedbox(x,y,z,c) {
  corner=(c > 0) ? c : 1;
  scd = ((x < 1 || y < 1 || z < 1) ? min(x,y,z) : corner);
  f=(print > 0) ? 180 : 90;
  xcut=x*0.12;
  ycut=xcut; //y*0.1;
  zcut=z*0.4;
  
  hull() {
    translate([scd/2+xcut,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2+ycut,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,scd/2,scd/2+zcut]) sphere(d=scd,$fn=f);
    
    translate([scd/2+xcut,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-ycut--scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2+zcut]) sphere(d=scd,$fn=f);
    
    translate([x-xcut-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2+ycut,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2+zcut]) sphere(d=scd,$fn=f);

    translate([x-xcut-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-ycut-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2+zcut]) sphere(d=scd,$fn=f);

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

//echo("width ",basewidth, " length ",baselength);

if ((print == 0) || (print == 1) || (print == 2)) {
  difference() {
    translate([tolerance,tolerance]) roundedbox(baselength-tolerance*2,basewidth-tolerance*2,basedepth-tolerance,cornersize);

    for (y=[eggy:eggdistance:basewidth]) {
      translate([eggxposition,y,eggbase]) hull() {
	translate([0,0,eggd/2]) sphere(d=eggd);
	translate([0,0,eggmaxdh]) sphere(d=eggmaxd);
	translate([0,0,eggheight-eggtopd/2]) sphere(d=eggtopd);
      }
    }

    teksti=(eggs>1)?((eggs>2)?"Design by Anja Suonsivu":"Anja Suonsivu"):"Anja Suonsivu";
    if ((print > 0) || printtext) {
      translate([eggtextxposition, basewidth/2,basedepth-textdepth-tolerance]) 
	linear_extrude(height=textdepth+0.01) rotate([0,0,90]) text(teksti,size=textheight-1,font="Liberation Sans:style=Bold",halign="center");

      if (deeptext) {
	translate([eggtextxposition, basewidth/2,basedepth-textdepth-textdepth-tolerance]) 
	  for (xb=[-0.1,0.1]) {
	    for (yb=[-0.1,0.1]) {
	      translate([xb,yb,0]) linear_extrude(height=textdepth+0.02) rotate([0,0,90]) text(teksti,size=textheight-1,font="Liberation Sans:style=Bold",halign="center");
	    }
	  }
	
	translate([eggtextxposition, basewidth/2,basedepth-2*textdepth-textdepth-textdepth-tolerance]) 
	  for (xs=[-0.2,0.2]) {
	    for (ys=[-0.2,0.2]) {
	      translate([xs,ys,0]) linear_extrude(height=2*textdepth+0.02) rotate([0,0,90]) text(teksti,size=textheight-1,font="Liberation Sans:style=Bold",halign="center");
	    }
	  }
      }
    }

    for (x=[tolerance-0.01,baselength-lockdepth-lockback-tolerance]) {
      for (y=[-lockwidth/2-lockcut,lockwidth/2]) {
	translate([x,basewidth/2+y,lockbottom]) cube([lockdepth+lockback+0.01,lockcut,basedepth]);
	translate([x,basewidth/2+y,lockbottom]) cube([lockdepth+lockback,lockcut,basedepth]);
      }
    }

    for (x=[lockdepth+tolerance,baselength-lockdepth-lockback-tolerance]) {
      translate([x,basewidth/2-lockwidth/2-0.01,lockbottom]) cube([lockback,lockwidth+0.02,basedepth]);
    }

 }

hull() {
  translate([0,basewidth/2-lockwidth/2,basedepth-locknotchd/2-tolerance]) rotate([270,0,0]) cylinder(h=lockwidth,d=locknotchd);
  translate([-tolerance+0.01,basewidth/2-lockwidth/2,basedepth-2*tolerance-locknotchd+0.01]) triangle(tolerance*2,lockwidth,tolerance,3);
}

hull() {
  translate([baselength,basewidth/2-lockwidth/2,basedepth-locknotchd/2-tolerance]) rotate([270,0,0]) cylinder(h=lockwidth,d=locknotchd);
  translate([baselength-tolerance-0.01,basewidth/2-lockwidth/2,basedepth-2*tolerance-locknotchd+0.01]) triangle(tolerance*2,lockwidth,tolerance,1);
}

  translate([baselength-tolerance-0.01,basewidth/2-lockwidth/2,basedepth-locknotchd/2-tolerance]) rotate([270,0,0]) cylinder(h=lockwidth,d=locknotchd);

for (x=[0,baselength-locknotchd]) translate([x,basewidth/2-lockwidth/2,basedepth-locknotchd-tolerance]) cube([locknotchd,lockwidth,locknotchd]);
 }

if ((print == 0) || (print == 1) || (print == 3)) {
  translate([-baselength-objectxgap-wall,0,0]) 
    difference() {
    coverheight = eggtop;
    translate([-wall,-wall,0]) fancyroundedbox(baselength+wall*2,basewidth+wall*2,coverheight,cornersize);


    translate([0,0,coverheight-basedepth]) roundedbox(baselength,basewidth,coverheight,cornersize);

    for (y=[eggy:eggdistance:basewidth]) {
      translate([baselength-eggxposition,y,wall]) cylinder(h=coverheight,d=eggmaxd);
    }
    //    translate([baselength-eggxposition,vainoy,wall]) cylinder(h=coverheight,d=vainomaxd);
    //    translate([baselength-eggxposition,almay,wall]) cylinder(h=coverheight,d=almamaxd);

    union() {
      translate([baselength+wall+1,basewidth/2,coverheight-fingeropeningh]) rotate([90,0,270]) cylinder(h=baselength+wall*3,d=fingeropeningd);
      translate([-wall-0.01,basewidth/2-fingeropeningwidth/2,coverheight-fingeropeningh]) cube([baselength+wall*2+0.02,fingeropeningwidth,fingeropeningh+0.01]);
    }
  
    for (x=[0,baselength]) translate([x,basewidth/2-lockwidth/2-1,coverheight-basedepth+locknotchd/2+tolerance]) rotate([270,0,0]) cylinder(h=lockwidth+2,d=locknotchd+tolerance);
    for (x=[0,baselength-locknotchd]) translate([x,basewidth/2-lockwidth/2-1,coverheight-basedepth]) cube([locknotchd,lockwidth+2,locknotchd]);
  }
 }
