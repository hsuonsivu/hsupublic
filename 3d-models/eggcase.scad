// Copyright 2025 Heikki Suonsivu

include <hsu.scad>

// 0 = draft 1 = final 2 = bottom 3 = cover 4=text background parts if textbackground is enabled, 5 base backgrounds,
// 6 top background only 7 test backgrounds, 8 window template for old version,
// 9 flip case, 10 window template for flipcase, 11 logo background for flip case

print=12;
debug=1;
window=1;
debugangle=-180;

// Add ABS recycling logo. This uses https://www.thingiverse.com/thing:216963/files
basematerial="ABS"; // "ABS";
//materials=window?[basematerial,"PC","PETG"]:[basematerial,"PETG"];
materials=window?["O"]:[basematerial,"PETG"];

versiontext="1.2";
versiontextdepth=0.7;

xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
dtolerance=0.6;

logoxtolerance=0.15;
logoytolerance=0.15;
logoztolerance=0.15;

layerh=0.24;

// Print texts even in draft mode
printtext=1;
// ankermake 0.2 mm layers, change color at
// ;LAYER:132, add M600
// ;LAYER:135, add M600
eggs=1;

textontop=0;
windowontop=1;
windowonfront=1;

textbackground=1;
textbackgroundh=1.2; // Works for both 0.2 and 0.3mm layers
textztolerance=0.15; // One layer

raisedtexth=0.4;

logoasinsert=1; // Use insert for a separately printed logo

logodepth=textbackgroundh; //1.2;  These must be same now to allow printing both base and top at the same time
textsizeonnenmuna=12;
logooffset=1;
logox=1;
backgroundoffset=logooffset;
toptextoffset=2;
logoedge=1;

tolerance=0.2;
cornersize=3;
nwall=2.5;
eggspace=2;
zfactor = 1;
xyfactor= 1;

bottomfillh=2.5;
filld=3;

eggd=40+dtolerance+filld * xyfactor;

//eggheight=59.5 * zfactor;
eggheight=57.5 * zfactor;

eggmaxd=42;

//eggmaxd=41+dtolerance+filld; //48+2 * xyfactor;

eggmaxdh=25+bottomfillh; // 8 * zfactor;

eggtopd=32 * xyfactor;

fingeropeningd=20;
fingeropeningh=15;
fingeropeningwidth=20;

lockbottom=nwall;
lockcut=1;
lockwidth=fingeropeningd+3;
locknotchd=2.5;
lockdepth=locknotchd;//nwall;
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
sizeextra=5;
basewidth=40.5*eggs*ysize+5+sizeextra;
baselength=40.5 + lockdepth + lockback + eggspace + textspace + textheight + lockdepth + lockback + 2+sizeextra;
eggxposition=40.5/2 + tolerance + nwall + locknotchd;
eggtextxposition=baselength - tolerance - lockdepth - lockback - insidetextheight;
//echo("textheigth ", textheight);
eggholedepth=2.9;
logoh=baselength-cornersize-4.5-3;
logol=basewidth-cornersize-3;

insideteksti="Onnenmuna";
insidetekstil=textlen(insideteksti,textheight-1);
insidetekstih=textheight(insideteksti,textheight-1);

toptextd=min(baselength,basewidth)-cornersize;

yfree=basewidth - 40.5*eggs;//)/2;//????
  
eggy=yfree/(eggs+1)+40.5/2;
eggdistance=(40.5+yfree/(eggs+1));
//echo("eggdistance ", eggdistance);

eggdtable=[[4.33,25,0],
	   [8.5,30,0],
	   [9.5,31,0],
	   //	   [10,32,0],
	   [10.3,33,0],
	   [12,34,0],
	   [12.1,35,0],
	   [12.9,36,0],
	   [14.3,37,0],
	   [17,38,0],
	   //[19.3,39,0],
	   //[21.7,40,0],
	   //	   [23.1,40.5,0],
	   [20,eggmaxd,0],
	   //	   [24.6,40,1],
	   //[29.7,39,1],
	   [32,39,1],
	   //[30.9,38,1],
	   [33.28,37,1],
	   //	   [33.8,36,1],
	   [35.6,35,1],
	   [37,34,1],
	   [39,33,1],
	   [40,32,1],
	   //[41.3,31,1],
	   [41,30,1],
	   [44.67,25,1],
	   [51.1,0,1]
	   ];

eggh=51.5;

eggbasez=basedepth+eggd/eggholedepth-eggd/2;

eggbase=basedepth-eggheight/eggholedepth;

eggtop=eggbase+eggheight+nwall+textbackgroundh*2+3+2.5;

coverheight = eggtop;

$fn=(print > 0) ? 180 : 90;

module egg(expand) {
  hull() {
    for (i=[0:1:len(eggdtable)-1]) {
      depth=eggdtable[i][0];
      diameter=eggdtable[i][1];
      slicestart=i?eggdtable[i-1][0]:0;
      sliceh=i?depth-eggdtable[i-1][0]:depth;
      //dd=eggdtable[i][2]?length_and_depth_to_diameter(diameter,depth):length_and_depth_to_diameter(diameter,51.1-depth);
      dd=eggdtable[i][1];
      d=(dd>eggmaxd)?eggmaxd:dd;
      //if (expand) echo(eggdtable[i][2],depth,l,dd,d,depth>d/2?depth-d/2:d/2);
      //echo(slicestart,sliceh);
      if (!expand) echo(i,diameter,dd,d,sliceh,eggdtable[i][2]);
      if (eggdtable[i][2]==0) {
	intersection() {
	  translate([0,0,slicestart-expand/2]) cylinder(d=eggmaxd+expand,h=sliceh+expand);
	  translate([0,0,depth>d/2?depth:d/2]) sphere(d=d+expand);
	}
      } else {
	intersection() {
	  if (i==23 && expand==0) {
	    # intersection() {
	      translate([0,0,slicestart-expand/2]) cylinder(d=d+expand,h=sliceh+expand);
	      translate([0,0,depth+d/2>eggh?eggh-d/2:d/2]) scale([1,1,i==len(eggdtable)-1?1:1]) sphere(d=d+expand);
	    }
	  } else {
	    translate([0,0,slicestart-expand/2]) cylinder(d=d+expand,h=sliceh+expand);
	    translate([0,0,depth+d/2>eggh?eggh-d/2:d/2]) scale([1,1,i==len(eggdtable)-1?1:1]) sphere(d=d+expand);
	  }
	}
      }
    }
  }

  if (0)  hull() {
    translate([0,0,eggd/2]) sphere(d=eggd-dtolerance+expand);
    translate([0,0,eggmaxdh]) sphere(d=eggmaxd-dtolerance+expand);
    translate([0,0,eggheight-eggtopd/2]) sphere(d=eggtopd-dtolerance+expand);
  }
}

module roundedboxold(x,y,z,c) {
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
    translate([scd/2,y-ycut-scd/2,scd/2]) sphere(d=scd,$fn=f);
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

module triangleold(x,y,z,mode) {
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

module anjalogo(offset=0) {
  ll=min(logol,logoh);
  resize([ll-6,0],auto=true) translate([-ll/2,-logoh/2]) intersection() {
    square([logol,logoh]);
    translate([-cornersize-0.5,0]) offset(r=offset) resize([ll-1,0],auto=true) import("AS_muna_nimi.svg",convexity=10);
  }
}

module logoinsert() {
  difference() {
    union() {
      hull() {
	translate([logox-logol/2,-logoh/2,logodepth]) roundedboxxyz(logol,logoh,logodepth,cornerd+logoedge,0,1,90);
	translate([logox-logol/2+logodepth,-logoh/2+logodepth,0]) roundedboxxyz(logol-logodepth*2,logoh-logodepth*2,logodepth+logodepth,cornerd+logoedge*2,0,1,90);
      }
    }

    translate([logox-logol/2+logodepth+logoedge,-logoh/2+logodepth+logoedge,-0.1]) roundedboxxyz(logol-logodepth*2-logoedge*2,logoh-logodepth*2-logoedge*2,raisedtexth+0.1,cornerd,0,1,90);
  }
  translate([logox,0,0]) linear_extrude(height=raisedtexth+0.01) rotate([0,180,90]) anjalogo(offset=0); // 0.2
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

module baseold() {
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

windowh=2;
windowl=baselength-9;
windoww=basewidth-9;
topl=windowl-4;
topw=windoww-4;

module top() {
  translate([-baselength-objectxgap-nwall,0,0]) 
    difference() {
    union() {
      translate([-nwall,-nwall,0]) fancyroundedbox(baselength+nwall*2,basewidth+nwall*2,coverheight,cornersize);

      if (windowontop) {
	intersection() {
	  translate([-tolerance+baselength/2,-tolerance+basewidth/2,windowheight(windowh)]) rotate([180,0,0]) windowframe(0,0,0,windowl,windoww,windowh);
	  translate([-nwall,-nwall,0]) hull() fancyroundedbox(baselength+nwall*2,basewidth+nwall*2,coverheight,cornersize);
	}
      }
    }
    if (textontop) {
      translate([-tolerance+baselength/2,-tolerance+basewidth/2,textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) toptext();
      translate([-tolerance+baselength/2,-tolerance+basewidth/2,textdepth*2+textdepth-0.01+textztolerance]) rotate([180,0,-90]) toptextbackground(1);
    }

    if (windowontop) {
      translate([-tolerance+baselength/2,-tolerance+basewidth/2,windowheight(windowh)]) rotate([180,0,0]) windowcut(0,0,0,windowl,windoww,windowh);
    }
    
    translate([0,0,coverheight-basedepth]) roundedbox(baselength,basewidth,coverheight,cornersize);

    topwall=(textontop?nwall+textdepth*2+layerh+textztolerance:(windowontop?nwall:nwall));

    insidetextholel=insidetextheight+1;
    insidetextholew=topw;
    insidetextholex=-tolerance+baselength-eggtextxposition-(insidetextheight+2)/2;
    insidetextholey=basewidth/2;
    
    topmidheight=topwall+coverheight/4;
    for (y=[eggy:eggdistance:basewidth]) {
      translate([baselength-eggxposition,y,topmidheight]) cylinder(h=coverheight+textbackgroundh,d=eggmaxd);

      hull() {
	translate([baselength-eggxposition,y,topmidheight-0.01]) cylinder(h=1,d=eggmaxd);
	translate([-tolerance+baselength/2-topl/2,y-topw/2,topwall]) roundedboxxyz(topl,topw,1,10,1,0,90);
	translate([insidetextholex,insidetextholey-insidetextholew/2,topmidheight-0.01]) roundedbox(insidetextholel+7,insidetextholew,cornersize,cornersize);
	translate([-tolerance+baselength-eggtextxposition-(insidetextheight+2)/2,-tolerance+basewidth/2-cornersize/2,coverheight-basedepth-cornersize-nwall]) cube([insidetextheight+2+eggd/2,cornersize,cornersize]);
      }
      translate([0,insidetextholey,0]) for (m=[0,1]) mirror([0,m,0]) hull() {
	translate([insidetextholex,-topw/2,topmidheight]) roundedbox(insidetextholel+3,insidetextholew/3,cornersize,cornersize);
	translate([insidetextholex,-topw/2,topmidheight]) roundedbox(insidetextholel+7,cornersize,cornersize,cornersize);
	translate([insidetextholex,-topw/2,coverheight-basedepth-cornersize/2+ztolerance]) roundedbox(insidetextholel,insidetextholew/3,cornersize,cornersize);
	translate([insidetextholex,-topw/2,coverheight-basedepth-cornersize/2+ztolerance]) roundedbox(insidetextholel+2,cornersize,cornersize,cornersize);
      }
      translate([0,insidetextholey,0]) hull() {
	translate([insidetextholex,-topw/2,topmidheight]) roundedbox(insidetextholel+3,insidetextholew,cornersize,cornersize);
	translate([insidetextholex,-topw/2,coverheight-basedepth-cornersize/2+ztolerance]) roundedbox(insidetextholel,insidetextholew,cornersize,cornersize);
      }
    }

    union() {
      translate([baselength+nwall+1,basewidth/2,coverheight-fingeropeningh]) rotate([90,0,270]) cylinder(h=baselength+nwall*3,d=fingeropeningd);
      translate([-nwall-0.01,basewidth/2-fingeropeningwidth/2,coverheight-fingeropeningh]) cube([baselength+nwall*2+0.02,fingeropeningwidth,fingeropeningh+0.01]);
    }
  
    for (x=[0,baselength]) translate([x,basewidth/2-lockwidth/2-1,coverheight-basedepth+locknotchd/2+tolerance]) rotate([270,0,0]) cylinder(h=lockwidth+2,d=locknotchd+tolerance);
    for (x=[0,baselength-locknotchd]) translate([x,basewidth/2-lockwidth/2-1,coverheight-basedepth]) cube([locknotchd,lockwidth+2,locknotchd]);
  }
}

// Axle version

wall=2;
axled=7;
axlel=3;
axledepth=2;
axlexposition=wall+axled/2+dtolerance/2;
axlex=-baselength/2+axlexposition;
axlew=basewidth-wall*2-ytolerance*2-axledepth*2-axlel;
axleheight=coverheight/2;
attachheight=axleheight-axled/2; //-axled/2-dtolerance/2-wall;
attachh=coverheight/2+axled/2; //axled+axled/2+dtolerance/2+wall;
attachl=axled/2+dtolerance+wall+xtolerance;
basel=baselength;
basew=basewidth;
baseh=basedepth-wall*2;
cornerd=2;
coverh=coverheight;
coverangle=0;
printangle=180;
//coverx=axlex+baselength/2+xtolerance;
coverx=wall+axled+dtolerance+wall+xtolerance;
basebackh=axleheight+axled/2+wall;
backraise=axlexposition+wall;
axlecoverl=axlexposition+axled/2+xtolerance+wall*2+xtolerance;
axlecoverh=axleheight;
outaxlesupportw=basew/2-axlew/2-axlel/2-ytolerance;
basefrontx=-basel/2+axlexposition+axlecoverl-axlexposition-cornerd;
basefrontl=basel-wall-xtolerance-axlexposition-(axlecoverl-axlexposition)+cornerd;
coverbackover=wall*2;

clipdepth=1.2;
clipd=wall+clipdepth;
clipheight=1.5;
clipl=20;
//echo(axlex,baselength);

coverwindowx=coverx/2;
coverwindowh=2;
coverwindowl=baselength-17;
coverwindoww=basewidth-9;
coverwindowoverlap=3;

frontwindowx=coverx/2;
frontwindowh=2;
frontwindowl=baselength-17;
frontwindoww=basewidth-13;
frontwindowoverlap=3;

eggclampx=eggmaxd/2-wall*3;
eggclampl=wall*2+wall*2;
eggclampw=10;
eggclamph=baseh+10+3;
eggclampww=eggclampw+10;
eggclampwheight=baseh-cornerd;

backclampl=eggmaxd/2;//wall*2+wall*3;
backclampx=-eggmaxd/2-wall*2;
backclampw=15;
backclamph=baseh+10+22;
backclampww=eggclampw+10;
backclampwheight=baseh-cornerd;

fingerpresscut=0.5;
fingerpressw=20;
fingerpressh=19;
fingerpressd=45;
fingerpressdepth=1;
fingerpressheight=baseh-fingerpressh/2;

module cover() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([axlex,-axlew/2,axleheight]) onehinge(axled,axlel,axledepth,0,ytolerance,dtolerance);
	  translate([-basel/2+coverx+wall+xtolerance,-basew/2,baseh+ztolerance]) roundedbox(basel-coverx-wall-xtolerance,wall,coverh-baseh-ztolerance,cornerd,2);
	  hull() {
	    translate([-basel/2+coverx,-basew/2,coverh-axlecoverh+wall*0.5]) roundedbox(basel-coverx,wall,axlecoverh-wall*0.5,cornerd,2);
	    translate([-basel/2+coverx+wall+xtolerance,-basew/2,coverh-axlecoverh-wall*0.5+ztolerance]) roundedbox(basel-coverx-wall-xtolerance,wall,axlecoverh-wall*0.5-ztolerance,cornerd,2);
	  }
	  //	  translate([-basel/2+coverx,-basew/2,basebackh+ztolerance]) roundedbox(wall,basew/2-axlew/2+axlel/2,coverh-basebackh-ztolerance,cornerd,2);
	  translate([-basel/2+coverx,-basew/2,coverh-axlecoverh+wall*0.5]) roundedbox(wall,basew/2-axlew/2+axlel/2,axlecoverh-wall*0.5,cornerd,2);
	  if (1) hull() {
	      translate([-basel/2,axlew/2-axlel/2,axleheight+axled/2]) roundedbox(coverx,axlel,coverh-basebackh-coverx+wall,cornerd,2);
	      translate([axlex,axlew/2-axlel/2,axleheight]) rotate([-90,0,0]) roundedcylinder(axled,axlel,cornerd,0,90);
	    }
	  if (1) hull() {
	      //translate([axlex,-axlew/2-axlel/2,axleheight]) rotate([-90,0,0]) roundedcylinder(axled,axlel,cornerd,0,90);
	      translate([-basel/2,-axlew/2-axlel/2,axlecoverh+ztolerance]) roundedbox(coverx+wall,axlel,coverh-axlecoverh-coverx+wall,cornerd,2);
	      translate([-basel/2+coverx-wall,-axlew/2-axlel/2,basebackh+ztolerance]) roundedbox(wall+wall,axlel,coverh-basebackh-ztolerance,cornerd,2);
	    }
	}
      
      translate([-basel/2+coverx,-basew/2,coverh-wall]) roundedbox(basel-coverx,basew,wall,cornerd,2);
      if (window) intersection() {
	  translate([-basel/2+coverx,-basew/2,0]) roundedbox(basel-coverx,basew,coverh,cornerd,2);
	  windowframe(coverwindowx,0,coverh-windowheight(coverwindowh),coverwindowl,coverwindoww,coverwindowh,overlap=coverwindowoverlap);
	}
      difference() {
	translate([basel/2-wall,-basew/2,baseh+ztolerance]) roundedbox(wall,basew,coverh-baseh-ztolerance,cornerd,2);
	translate([basel/2-wall-xtolerance-wall+clipd/2,0,baseh+clipheight+clipd/2]) rotate([0,0,90]) tubeclip(clipl,clipd,dtolerance);
      }
      hull() {
	translate([-basel/2+coverx-wall,-axlew/2-axlel/2,coverh-wall]) roundedbox(wall*2,axlew+axlel,wall,cornerd,2);
	translate([-basel/2+coverx-coverbackover,-axlew/2-axlel/2,coverh-wall-wall]) roundedbox(wall,axlew+axlel,wall,cornerd,2);
      }
      //  translate([-basel/2+coverx,-axlew/2,attachheight]) roundedbox(wall,axlew,axleheight+axled/2,2);
    }

    if (window) windowcut(coverwindowx,0,coverh-windowheight(coverwindowh),coverwindowl,coverwindoww,coverwindowh,overlap=coverwindowoverlap,windowtest=(window==2)); //ndowtest=(window==2));
  }
}

module basetopslope() {
  hull() {
    translate([-basel/2+wall+axlexposition-wall,0,coverh-wall-ztolerance-wall-wall]) roundedbox(wall+wall,wall,wall,cornerd,1);
    translate([-basel/2,0,coverh-backraise-wall*3]) roundedbox(wall,wall,wall+wall,cornerd,1);
  }
}

module base() {
  difference() {
    union() {
      // Bottom
      hull() {
	translate([-basel/2+coverx,-basew/2,0]) roundedbox(basel-coverx,basew,logoasinsert?textdepth*2+textztolerance+wall:cornerd,cornerd,1);
	if (!logoasinsert) {
	  translate([logox-logol/2-0.5,-basew/2,wall]) roundedbox(logol+1.5,basew,wall+textbackgroundh,cornerd,1);
	}
      }
      // Front
      hull() {
	translate([basel/2-wall,-basew/2,0]) roundedbox(wall,basew,baseh,cornerd,1);
	translate([basel/2-wall-xtolerance-wall,-basew/2,0]) roundedbox(wall,basew,baseh,cornerd,1);
      }
      translate([basel/2-wall-xtolerance-wall,-basew/2+wall+ytolerance,0]) roundedbox(wall,basew-wall*2-ytolerance*2,baseh+clipd+clipheight,cornerd,1);
      translate([basel/2-wall-xtolerance-wall+clipd/2,0,baseh+clipheight+clipd/2]) rotate([0,0,90]) tubeclip(clipl,clipd,0);
      
      for (m=[0,1]) mirror([0,m,0]) {
	  // Axle support outside
	  hull() {
	    translate([-basel/2,-basew/2,0]) roundedbox(axlecoverl,wall,baseh,cornerd,1);
	    translate([-basel/2,-basew/2,0]) roundedbox(axlecoverl,wall,axleheight,cornerd,1);
	    //translate([-basel/2+axlexposition,-basew/2,0]) roundedbox(axlecoverl-axlexposition,wall,basebackh,cornerd,1);
	  }

	  // Side
	  // raised inside
	  hull() {
	    translate([basefrontx,-basew/2+xtolerance+wall,0]) roundedbox(basefrontl,wall,baseh+clipd+clipheight,cornerd,1);
	    //	    translate([-basel/2+axlexposition+axlecoverl-axlexposition,-basew/2+xtolerance+wall,0]) roundedbox(wall,wall,basebackh+clipd+clipheight-wall,cornerd,1);
	  }
	  // Side inside extension
	  hull() {
	    for (y=[0,xtolerance+wall]) {
	      translate([basefrontx,-basew/2+y,0]) roundedbox(basefrontl,wall,baseh,cornerd,1);
	      //translate([-basel/2+axlexposition+axlecoverl-axlexposition-wall-xtolerance,-basew/2+y,0]) roundedbox(wall,wall,basebackh,cornerd,1);
	    }
	  }

	  // Axle support 
	  hull() {
	    translate([-basel/2,-basew/2,0]) roundedbox(axlecoverl,outaxlesupportw,axleheight,cornerd,1);
	    //	    translate([-basel/2+axlexposition,-basew/2,0]) roundedbox(axlecoverl-axlexposition,outaxlesupportw,basebackh,cornerd,1);
	    translate([axlex,-basew/2,axleheight]) rotate([-90,0,0]) roundedcylinder(axled+wall,outaxlesupportw,cornerd,0,90);
	  }
	  // Side low
	  translate([-basel/2,-basew/2,0]) roundedbox(basel,basew/2-axlew/2-axlel/2-ytolerance,wall,cornerd,1);

	  // Axle support front
	  translate([-basel/2+axlecoverl-wall,-basew/2,0]) roundedbox(wall,basew/2-axlew/2+axlel/2+ytolerance+wall,axlecoverh,cornerd,1);

	  // Axle support front bottom
	  translate([-basel/2+wall*1.5,-basew/2,0]) roundedbox(axlecoverl,basew/2-axlew/2+axlel/2+ytolerance+wall,wall,cornerd,1);
	  hull() {
	    // Axle support side inside
	    translate([-basel/2,-axlew/2+axlel/2+ytolerance,coverbackover+wall*2]) roundedbox(axlecoverl,wall,axlecoverh-coverbackover-wall*2,cornerd,1);

	    // Back wall top slope
	    translate([0,-axlew/2+axlel/2+ytolerance,0]) basetopslope();
	    
	    // Axle support side inside hinge cover
	    translate([axlex,-axlew/2+axlel/2+ytolerance,axleheight]) rotate([-90,0,0]) roundedcylinder(axled+wall,wall,cornerd,0,90);

	    // Axle support side inside hinge wall
	    translate([-basel/2+coverbackover+wall+xtolerance,-axlew/2+axlel/2+ytolerance,0]) roundedbox(axlecoverl-coverbackover-wall-xtolerance,wall,basebackh-backraise,cornerd,1);
	  }
	}

      difference() {
	translate([-basel/2,-axlew/2+axlel/2+ytolerance,coverbackover+wall*2]) roundedbox(wall,axlew-axlel-ytolerance*2,coverh-coverbackover-backraise-wall-wall*2,cornerd,1);
	for (i=[0:1:len(materials)-1]) {
	  material=materials[i];
	  translate([-basel/2+textdepth-0.01,0,coverh/4-1+i*16]) rotate([90,0,-90]) recyclingsymbol(type=material,size=15,h=textdepth);
	}
      }
      
      hull() {
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([0,-axlew/2+axlel/2+ytolerance,0]) basetopslope();
	  }
      }

      // Base plate middle part
      hull() {
	h=textdepth*2+textztolerance;
	translate([-basel/2+wall*1.5,-basew/2,0]) roundedbox(basel-wall*1.5,basew,wall,cornerd,1);
	translate([-basel/2+wall*1.5+h,-basew/2,0]) roundedbox(basel-wall*1.5-h,basew,wall+h,cornerd,1);
      }
      hull() {
	translate([-basel/2+coverbackover+wall+xtolerance,-axlew/2+axlel/2+ytolerance,0]) roundedbox(wall,axlew-axlel-ytolerance*2,wall,cornerd,1);
	translate([-basel/2,-axlew/2+axlel/2+ytolerance,coverbackover+wall*2]) roundedbox(wall,axlew-axlel-ytolerance*2,wall,cornerd,1);
      }

      intersection() {
	h=(baseh+basebackh)/2;
	union() {
	  hull() {
	    for (m=[0,1]) mirror([0,m,0]) {
		for (y=[0]) {
		  translate([-eggmaxd/2-wall,-basew/2+y,0]) roundedbox(eggmaxd+wall*2,wall,baseh,cornerd,1);
		  translate([-eggmaxd/2-wall,-basew/2+y,0]) roundedbox(wall,wall,h,cornerd,1);
		}
	      }
	  }
	  
	  hull() {
	    translate([eggclampx,-eggclampw/2,0]) roundedbox(eggclampl,eggclampw,eggclamph,cornerd,0);
	    translate([eggclampx,-eggclampww/2,eggclampwheight]) roundedbox(eggclampl,eggclampww,cornerd,cornerd,0);
	  }
	  hull() {
	    translate([backclampx,-backclampw/2,0]) roundedbox(backclampl,backclampw,backclamph,cornerd,0);
	    translate([backclampx,-backclampww/2,backclampwheight]) roundedbox(backclampl,backclampww,cornerd,cornerd,0);
	  }

	  translate([-basel/2,-axlew/2+axlel/2+ytolerance,0]) roundedbox(axlecoverl+wall,axlew-axlel-ytolerance*2,baseh+backraise,cornerd,1);
	}
	
	// Egg holder
	difference() {
	  union() {
	    translate([0,0,eggbase+bottomfillh]) egg(wall*1.5);
	    translate([0,0,0]) cylinder(d=eggmaxd*0.66,h=eggmaxdh);
	  }
	  translate([0,0,eggbase+bottomfillh]) egg(0);
	}
      }
    }

    for (m=[0,1]) mirror([0,m,0]) {
	translate([axlex,-axlew/2,axleheight]) onehinge(axled,axlel,axledepth,1,ytolerance,dtolerance);

	translate([basel/2-wall-xtolerance-wall-0.01,-fingerpressw/2-fingerpresscut,baseh-fingerpressh]) cube([wall*2+xtolerance+0.02,fingerpresscut,fingerpressh+clipd+clipheight+0.1]);
      }

    translate([basel/2-fingerpressdepth+fingerpressd/2,0,fingerpressheight]) sphere(d=fingerpressd,$fn=90);
    difference() {
      hull() {
	translate([basel/2-wall-wall,-fingerpressw/2-cornerd/2,baseh-fingerpressh]) roundedbox(wall,fingerpressw+cornerd,fingerpressh-wall,cornerd);
	translate([basel/2-wall-wall-wall,-fingerpressw/2-cornerd/2,baseh-fingerpressh]) roundedbox(wall,fingerpressw+cornerd,fingerpressh,cornerd);
      }

      translate([basel/2-fingerpressdepth+fingerpressd/2,0,fingerpressheight]) sphere(d=fingerpressd+wall*2,$fn=90);
    }
      
    // Make space for logo part to be inserted
    if (logoasinsert) {
      hull() {
	translate([logox-logol/2+logodepth-logoxtolerance,-logoh/2+logodepth-logoytolerance,-0.01]) roundedboxxyz(logol-logodepth*2+logoxtolerance*2,logoh-logodepth*2+logoytolerance*2,logodepth+logodepth+textztolerance,cornerd,0,1,90);
	translate([logox-logol/2-logoxtolerance,-logoh/2-logoytolerance,logodepth]) roundedboxxyz(logol+logoxtolerance*2,logoh+logoytolerance*2,logodepth+textztolerance,cornerd,0,1,90);
      }
    } else {
      translate([logox,0,logodepth-0.01]) rotate([180,0,-90]) linear_extrude(height=logodepth+0.01) anjalogo();
      if (textbackground) {
	translate([logox,0,logodepth*2+logodepth-0.03+textztolerance]) rotate([180,0,-90]) logobackground(logoh,logol,1);
      }
    }
  }
}

module axlecase() {
  translate([axlex,0,axleheight]) rotate([0,printangle,0]) translate([-axlex,0,-axleheight]) cover();
  if (debug) translate([axlex,0,axleheight]) rotate([0,debugangle,0]) translate([-axlex,0,-axleheight]) cover();
  base();
}


if (print==0) {
  intersection() {
    if (debug) translate([-100,31,-10]) cube([200,200,200]);
    union() {
      base();
      translate([eggxposition,eggy,eggbase+bottomfillh]) egg(0);
      //translate([tolerance+baselength/2,tolerance+basewidth/2,logodepth*2+logodepth+layerh+textztolerance]) rotate([180,0,-90]) logobackground(logoh,logol,0);
      translate([eggtextxposition, basewidth/2,basedepth-textdepth-tolerance-textdepth-textztolerance+0.01])
	rotate([0,0,90]) insidetextbackground(0);
      
      translate([-nwall*2+tolerance,0,coverheight]) rotate([0,180,0]) {
	top();
	//translate([-baselength-objectxgap-nwall,0,0]) translate([-nwall*2+tolerance,0,coverheight]) rotate([0,180,0]) translate([-nwall+baselength/2,-nwall+basewidth/2,textdepth*2+textdepth+layerh+textztolerance]) rotate([180,0,-90]) toptextbackground(0);
	//#	translate([-baselength-objectxgap-nwall,0,0]) translate([-nwall+baselength/2,-nwall+basewidth/2,textdepth*2+textdepth+layerh+textztolerance]) rotate([180,0,-90]) toptextbackground(0);
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
  if (textontop) translate([toptextd/2,logol+toptextd/2-16]) toptextbackground(0);
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

if (print==8) {
  windowtemplate(windowl,windoww,text=str("eggcase",versiontext));
 }

if (print==9) {
  intersection() {
    if (debug) translate([-1000,0,0]) cube([2000,1000,1000]);
    union() {
      axlecase();
      if (debug) logoinsert();
    }
  }
}

if (print==10) {
  windowtemplate(coverwindowl,coverwindoww,text=str("eggflipcase ",versiontext));
 }

if (print==11) {
  translate([logoh/2,logol/2,0]) logobackground(logoh,logol,0);
 }

if (print==12) {
  intersection() {
    if (debug) translate([0,0,0]) cube([100,100,100]);
    translate([0,0,textdepth*2]) rotate([180,0,0]) logoinsert();
  }
 }

if (print==13) {
  intersection() {
    base();
    cylinder(d=eggmaxd+wall*2,52+eggbase);
  }
 }
