// Copyright 2025 Heikki Suonsivu

include <hsu.scad>

// 0 = draft 1 = final 2 = bottom 3 = cover 4=text background parts if textbackground is enabled, 5 base backgrounds, 6 top background only 7 test backgrounds

print=7;
debug=0;
  
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
dtolerance=0.6;

layerh=0.24;

// Print texts even in draft mode
printtext=1;
// ankermake 0.2 mm layers, change color at
// ;LAYER:132, add M600
// ;LAYER:135, add M600
eggs=1;

textbackground=1;
textbackgroundh=1.2; // Works for both 0.2 and 0.3mm layers
textztolerance=0.15; // One layer

logodepth=textbackgroundh; //1.2;  These must be same now to allow printing both base and top at the same time
textsizeonnenmuna=12;
logooffset=1;
backgroundoffset=logooffset;
toptextoffset=2;

tolerance=0.2;
cornersize=3;
wall=2.5;
eggspace=2;
zfactor = 1;
xyfactor= 1;

eggd=40 * xyfactor;

bottomfillh=2.5;
filld=3;

//eggheight=59.5 * zfactor;
eggheight=57.5 * zfactor;

eggmaxd=46+dtolerance+filld; //48+2 * xyfactor;

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
insidetextheight=textheight-1;
textspace=textheight/3;
textdepth=logodepth;
basewidth=eggmaxd*eggs*ysize;
baselength=eggmaxd + lockdepth + lockback + eggspace + textspace + textheight + lockdepth + lockback;
eggxposition=eggmaxd/2 + tolerance + wall + locknotchd;
eggtextxposition=baselength - tolerance - lockdepth - lockback - insidetextheight;
//echo("textheigth ", textheight);
eggholedepth=2.9;

logoh=baselength-cornersize-4.5-1;
logol=basewidth-cornersize-1;

insideteksti="Onnenmuna";
insidetekstil=textlen(insideteksti,textheight-1);
insidetekstih=textheight(insideteksti,textheight-1);

toptextd=min(baselength,basewidth)-cornersize;

yfree=basewidth - eggmaxd*eggs;//)/2;//????
  
eggy=yfree/(eggs+1)+eggmaxd/2;
eggdistance=(eggmaxd+yfree/(eggs+1));
//echo("eggdistance ", eggdistance);

eggbasez=basedepth+eggd/eggholedepth-eggd/2;

eggbase=basedepth-eggheight/eggholedepth;

eggtop=eggbase+eggheight+wall+textbackgroundh*2+3+2.5;

coverheight = eggtop;

$fn=(print > 0) ? 180 : 90;

echo(logol,logoh);

module egg() {
  hull() {
    translate([0,0,eggd/2]) sphere(d=eggd-dtolerance);
    translate([0,0,eggmaxdh]) sphere(d=eggmaxd-dtolerance);
    translate([0,0,eggheight-eggtopd/2]) sphere(d=eggtopd-dtolerance);
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

module anjalogo() {
  translate([-logol/2,-logoh/2]) intersection() {
    square([logol,logoh]);
    translate([-cornersize-0.5,0]) resize([logol-1,0],auto=true) import("AS_muna_nimi.svg",convexity=10);
  }
}

module anjalogoholes(cut) {
  difference() {
    fill() anjalogo();
    offset(cut?0.2:0) anjalogo();
  }
}


//module anjalogofilled(cut) {
//  offset(logooffset+(cut?dtolerance/2:0)) fill() anjalogo();
//}

module logobackground(h,l,cut) {
  difference() {
    union() {
      translate([0,0,logodepth-0.01]) linear_extrude(height=logodepth+(cut?textztolerance:0)) offset(cut?dtolerance/2:0) anjalogo();
      translate([0,0,cut?-textztolerance:0]) linear_extrude(height=logodepth+(cut?textztolerance*2:0)) offset(logooffset+(cut?dtolerance/2:0)) anjalogo(); //fill()
    }
    translate([0,0,-textztolerance-0.01]) linear_extrude(height=logodepth*2+textztolerance*2+0.02) anjalogoholes(cut);
  }
}

module insidetextbackground(cut) {
  translate([0,0,cut?-textztolerance:0]) linear_extrude(height=textbackgroundh+(cut?textztolerance*2:0)) offset(backgroundoffset+(cut?dtolerance/2:0)) fill() text(insideteksti,size=insidetextheight,font="Liberation Sans:style=Bold",halign="center",valign="center");

  //cube([insidetekstih+(cut?xtolerance*2:0),insidetekstil+(cut?ytolerance*2:0),textbackgroundh+(cut?textztolerance*2:0)]);
}

module base() {
  difference() {
    translate([tolerance,tolerance,0]) roundedbox(baselength-tolerance*2,basewidth-tolerance*2,basedepth-tolerance,cornersize);

    translate([tolerance+baselength/2,tolerance+basewidth/2,logodepth-0.01])
    rotate([180,0,-90]) linear_extrude(height=logodepth+0.01) anjalogo();

    if (textbackground) {
      translate([tolerance+baselength/2,tolerance+basewidth/2,logodepth*2+logodepth-0.03+textztolerance]) rotate([180,0,-90]) logobackground(logoh,logol,1);
    }

    for (y=[eggy:eggdistance:basewidth]) {
      translate([eggxposition,y,eggbase]) hull() {
	translate([0,0,eggd/2]) sphere(d=eggd);
	translate([0,0,eggmaxdh]) sphere(d=eggmaxd);
	translate([0,0,eggheight-eggtopd/2]) sphere(d=eggtopd);
      }
    }

    //teksti=(eggs>1)?((eggs>1)?"Design by Anja Suonsivu":"Anja Suonsivu"):"Onnenmuna";
    if (printtext) {
      translate([eggtextxposition, basewidth/2,basedepth-textdepth-tolerance]) 
	linear_extrude(height=textdepth+0.01) rotate([0,0,90]) text(insideteksti,size=insidetextheight,font="Liberation Sans:style=Bold",halign="center",valign="center");

      if (textbackground) {
	translate([eggtextxposition, basewidth/2,basedepth-textdepth-tolerance-textdepth-textztolerance+0.01])
	  rotate([0,0,90]) insidetextbackground(1);
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

module toptext() {
  rotate([0,0,180]) {
    translate([0,textsizeonnenmuna/2+1]) text("Onnen",size=textsizeonnenmuna,font="Liberation Sans:style=Bold",halign="center",valign="center");
    translate([0,-textsizeonnenmuna/2-1]) text("muna",size=textsizeonnenmuna,font="Liberation Sans:style=Bold",halign="center",valign="center");
  }
}

module toptextholes(cut) {
  offset(cut?0.3:0)
    difference() {
    fill() toptext();
    offset(0.1) toptext();
  }
}

module toptextbackground(cut) {
  difference() {
    union() {
      translate([0,0,logodepth-0.01]) linear_extrude(height=logodepth+(cut?textztolerance:0)) offset(cut?dtolerance/2:0) toptext();
      translate([0,0,cut?-textztolerance:0]) linear_extrude(height=logodepth+(cut?textztolerance*2:0)) {
	if (cut) {
	  fill() offset(toptextoffset+(cut?dtolerance/2:0)) toptext();
	} else {
	  offset(toptextoffset+(cut?dtolerance/2:0)) toptext();
	}
      }
    }
    translate([0,0,-textztolerance-0.01]) linear_extrude(height=logodepth*2+textztolerance*2+0.02) toptextholes(cut==0);
  }
}

module top() {
  translate([-baselength-objectxgap-wall,0,0]) 
    difference() {
    translate([-wall,-wall,0]) fancyroundedbox(baselength+wall*2,basewidth+wall*2,coverheight,cornersize);
    translate([-tolerance+baselength/2,-tolerance+basewidth/2,textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) toptext();
    translate([-tolerance+baselength/2,-tolerance+basewidth/2,textdepth*2+textdepth-0.01+textztolerance]) rotate([180,0,-90]) toptextbackground(1);
    translate([0,0,coverheight-basedepth]) roundedbox(baselength,basewidth,coverheight,cornersize);

    for (y=[eggy:eggdistance:basewidth]) {
      translate([baselength-eggxposition,y,wall+textdepth*2+layerh+textztolerance]) cylinder(h=coverheight+textbackgroundh,d=eggmaxd);
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

if (print==0) {
  intersection() {
    if (debug) translate([-100,31,-10]) cube([200,200,200]);
    union() {
      base();
 #     translate([eggxposition,eggy,eggbase+bottomfillh]) egg();
      //translate([tolerance+baselength/2,tolerance+basewidth/2,logodepth*2+logodepth+layerh+textztolerance]) rotate([180,0,-90]) logobackground(logoh,logol,0);
      translate([eggtextxposition, basewidth/2,basedepth-textdepth-tolerance-textdepth-textztolerance+0.01])
	rotate([0,0,90]) insidetextbackground(0);
      
      translate([-wall*2+tolerance,0,coverheight]) rotate([0,180,0]) {
	top();
	//translate([-baselength-objectxgap-wall,0,0]) translate([-wall*2+tolerance,0,coverheight]) rotate([0,180,0]) translate([-wall+baselength/2,-wall+basewidth/2,textdepth*2+textdepth+layerh+textztolerance]) rotate([180,0,-90]) toptextbackground(0);
	//#	translate([-baselength-objectxgap-wall,0,0]) translate([-wall+baselength/2,-wall+basewidth/2,textdepth*2+textdepth+layerh+textztolerance]) rotate([180,0,-90]) toptextbackground(0);
      }
    }
  }
 }

intersection() {
  if (debug) translate([-100,31,-10]) cube([200,200,200]);

  union() {
    if ((print == 1) || (print == 2)) {
      base();
    }

    if ((print == 1) || (print == 3)) {
      top();
    }
  }
}

if (print==5 || print==4) {
  translate([logoh/2,logol/2,0]) logobackground(logoh,logol,0);
  translate([logoh/2-2,-insidetextheight+2,0]) insidetextbackground(0);
 }

if (print==6 || print==4) {
  translate([toptextd/2,logol+toptextd/2-16]) toptextbackground(0);
 }

if (print==7) {
  translate([logoh/2,logol/2,0]) logobackground(logoh,logol,0);
  translate([-logoh/2-2,logol/2,0]) logobackground(logoh,logol,1);
  translate([logoh/2-2,-insidetextheight+2,0]) insidetextbackground(0);
  translate([logoh/2-2,-insidetextheight+2-insidetextheight-3,0]) insidetextbackground(1);
  translate([toptextd/2,logol+toptextd/2-16]) toptextbackground(0);
  translate([toptextd/2,logol+toptextd/2-16+toptextd/2]) toptextbackground(1);

  translate([100,0,0]) linear_extrude(height=2) toptextholes(1);
  translate([120,0,0]) linear_extrude(height=2) toptextholes(0);
 }
