
// 0 full model, 1 jaws, 2 head in two parts, 3 mouth covers
print=2;

$fn=60;

tolerance=0.5;

upperarmdiameter=76.5;
upperarmconnectbox=108-upperarmdiameter;
upperarmlength=43;
upperarmconnectorboxposition=3.7;
upperarmconnectorboxdepth=31.4;
upperarmconnectorboxwidth=33.11;
upperarmconnectorboxlength=60; //47; //57; 60?
grabberbaselength=108;
upperarmgap=7.14;
grabbermidtop=20;
grabbermidlowhmin=147;
grabbermidlowhmax=160;

grabberfingerthickness=8.4;
grabberfingerlength=40; // grabbing side
grabberfingerupperlength=26.65; // outside below hump
grabberfingerupperwidth=17;
grabberfingerupperthickness=19.5-grabberfingerthickness;
grabberfingerwidth=23.1;
grabbermechanismmaxwidth=39; // check
grabbermaxheight=156;
grabbermaxhposition=100; // check
grabbermaxlength=105 + (160-147); // check (length of maximum size)

grabberwall=2;

wall=2;

grabberlockwidth=grabberfingerwidth-10;
grabberlockdiameter=4.5;
grabberlocklength=25;

headminlength=153; // head must be taller than this
headmlength=grabbermidlowhmax+grabbermidtop+upperarmgap+upperarmlength;
headminheightup=upperarmdiameter/2+30;
headminheightdown=upperarmdiameter/2+20;
headminwidth=upperarmdiameter/2+upperarmconnectorboxdepth+10;
hd=5;
eyed=30;
eyehup=30;
eyehdown=15;
eyeposition=130;
headeyew=30;

eyeh=headminheightup+eyehup;
eyew=headminwidth+headeyew;

poskih=5;
poskiw=grabbermechanismmaxwidth+10;
poskiposition=grabbermaxhposition+5;

noseh=50;
nosew=grabbermechanismmaxwidth/2+1;
noseposition=poskiposition+140;

chinh=-40;
chinw=grabbermechanismmaxwidth/2+1;
chinposition=noseposition-2;
  
mutteridiameter=10; // $fn=6, measured outside.
ruuvidiameter=5.7; // M5
ruuvipituus=20;
ruuvifrontposition=grabbermaxhposition + 60;
ruuvibackposition=10;

toothstart=grabberbaselength+upperarmgap+grabbermidlowhmax-grabberfingerlength-20;
toothwidthstart=36/2+1;
toothsize=20;
teeth=3; // straight teeth
mouthreserve=5; // How much space reserved for teeth and mouth
jawwidth=3;
jawh=toothsize;
jawx=toothsize/sqrt(2);
jawlength=toothsize*sqrt(2)*teeth;
lowerjawshort=jawwidth*1.2;
lowerjawlength=jawlength-lowerjawshort;
toothwidth=1;
toothgap=0.2;
jawspace=toothsize*sqrt(2)/4; // gap between teeth
jawhornheight=6;
jawhornlength=20;

movementlength=130; // test
movementguidedepth=6;
movementguidewmargin=1;
movementguidehmargin=2;
movementthickness=5;
movementguidewidth=grabbermechanismmaxwidth+mouthreserve+movementguidedepth;
movementguideh=movementthickness+movementguidehmargin;
movementguideposition=grabberbaselength; // test

coverangle=37;
mouthcoverad=movementthickness;
mouthcoverw=toothwidthstart*2-jawwidth-tolerance; //grabbermechanismmaxwidth+mouthreserve/2;
mouthcoverwl=5;
mouthcoverww=mouthcoverw+2;
mouthcovercutl=mouthcoverwl-4;
mouthcovercutw=31;
mouthcoverlength=jawlength*cos(coverangle)+mouthcoverad+6;
mouthcoverh=movementthickness;
  
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

module head() {
  union() {
    difference() {
      union() {
      hull() {
	translate([0,0,0]) cylinder(h=1,d=upperarmdiameter+60);
      
	translate([headminheightup,0,hd/2]) sphere(d=hd);
	translate([-headminheightdown,0,hd/2]) sphere(d=hd);
	translate([0,headminwidth,hd/2]) sphere(d=hd);
	translate([0,-headminwidth,hd/2]) sphere(d=hd);
	translate([0,headminwidth,50]) sphere(d=hd);
	translate([0,-headminwidth,50]) sphere(d=hd);
      
	translate([eyeh,0,eyeposition]) sphere(d=hd);
	translate([-eyeh,0,eyeposition]) sphere(d=hd);
	translate([eyeh,headeyew,eyeposition]) sphere(d=hd);
	translate([eyeh,-headeyew,eyeposition]) sphere(d=hd);

	translate([noseh,nosew,noseposition]) sphere(d=hd);
	translate([noseh,-nosew,noseposition]) sphere(d=hd);

	translate([chinh,chinw,chinposition]) sphere(d=hd);
	translate([chinh,-chinw,chinposition]) sphere(d=hd);

	translate([-grabbermaxheight/2-10,-grabbermechanismmaxwidth/2-10,grabbermaxhposition]) cube([grabbermaxheight+20,grabbermechanismmaxwidth+20,grabbermaxlength]);
	translate([poskih,poskiw,poskiposition]) sphere(d=hd);
	translate([poskih,-poskiw,poskiposition]) sphere(d=hd);
      }
      // eyes
      hull() {
	translate([eyeh,headeyew,eyeposition]) sphere(d=eyed);
	translate([eyeh-eyed,headeyew,eyeposition-eyed*1.5]) sphere(d=hd);
      }
      hull() {
	translate([eyeh,-headeyew,eyeposition]) sphere(d=eyed);
	translate([eyeh-eyed,-headeyew,eyeposition-eyed*1.5]) sphere(d=hd);
      }
      }
      union() {
	translate([0,0,-0.01]) cylinder(h=grabbermaxhposition+0.02,d=upperarmdiameter);
	translate([0,0,grabbermaxhposition]) cylinder(h=upperarmdiameter,d1=upperarmdiameter,d2=0);
      }
     translate([-upperarmconnectorboxwidth/2,-upperarmdiameter/2-upperarmconnectorboxdepth,upperarmconnectorboxposition]) cube([upperarmconnectorboxwidth,upperarmdiameter+2*upperarmconnectorboxdepth,upperarmconnectorboxlength-upperarmconnectorboxdepth]);
      translate([-upperarmconnectorboxwidth/2,0,upperarmconnectorboxposition+upperarmconnectorboxlength-upperarmconnectorboxdepth-0.01]) triangle(upperarmconnectorboxwidth,upperarmdiameter/2+upperarmconnectorboxdepth,upperarmdiameter/2+upperarmconnectorboxdepth,8);
      translate([-upperarmconnectorboxwidth/2,-upperarmdiameter/2-upperarmconnectorboxdepth,upperarmconnectorboxposition+upperarmconnectorboxlength-upperarmconnectorboxdepth-0.01]) triangle(upperarmconnectorboxwidth,upperarmdiameter/2+upperarmconnectorboxdepth,upperarmdiameter/2+upperarmconnectorboxdepth,11);
      translate([-grabbermaxheight/2,-grabbermechanismmaxwidth/2-mouthreserve/2,grabbermaxhposition]) cube([grabbermaxheight,grabbermechanismmaxwidth+mouthreserve,grabbermaxlength+100]);

      //     translate([grabbermaxheight/2-0.01,-movementguidewidth/2,movementguideposition]) cube([movementguideh+0.02,movementguidewidth,movementlength]);
      //     translate([-grabbermaxheight/2-movementguideh,-movementguidewidth/2,movementguideposition]) cube([movementguideh+0.01,movementguidewidth,movementlength]
     translate([grabbermaxheight/2-movementguideh-0.01,-movementguidewidth/2,movementguideposition]) cube([movementguideh+0.02,movementguidewidth,movementlength]);
     translate([-grabbermaxheight/2,-movementguidewidth/2,movementguideposition]) cube([movementguideh+0.01,movementguidewidth,movementlength]);
    }
  }
}

module fingerattachment() {
  // Upper attachment
  union() {
    difference() {
      union() {
	translate([0,-grabberfingerwidth/2-grabberwall,0]) cube([grabberfingerthickness+2*grabberwall,grabberfingerwidth+2*grabberwall,grabberfingerlength+2*grabberwall]);
	xx=grabberwall+grabberfingerthickness+grabberwall;
	xxx=jawspace+jawh-grabberwall-grabberfingerthickness-grabberwall;
	translate([0,-grabberfingerwidth/2-grabberwall,grabberfingerlength+2*grabberwall-0.01]) triangle(grabberfingerthickness+2*grabberwall,grabberfingerwidth+2*grabberwall,grabberfingerthickness+grabberwall,0);
      }
    
      translate([grabberwall,-grabberfingerwidth/2,-0.01]) cube([grabberfingerthickness,grabberfingerwidth,grabberfingerlength+0.01]);
    translate([grabberwall+grabberfingerthickness-0.01,-grabberfingerupperwidth/2,-0.01]) cube([grabberfingerupperthickness+0.02,grabberfingerupperwidth,grabberfingerlength-grabberfingerupperlength+0.02]);

      translate([-0.01,-grabberlockwidth/2-wall,-0.01]) cube([grabberwall+0.02,wall,grabberlocklength]);
      translate([-0.01,grabberlockwidth/2,-0.01]) cube([grabberwall+0.02,wall,grabberlocklength]);
    }

    translate([0,-grabberlockwidth/2,-grabberlockdiameter]) cube([grabberwall,grabberlockwidth,grabberlockdiameter+0.01]);
    translate([grabberwall,grabberlockwidth/2,-grabberlockdiameter/2-0.01]) rotate([90,0,0]) cylinder(h=grabberlockwidth,d=grabberlockdiameter, $fn=30);
  }
}

module jaw(upper) {
  length=upper?jawlength:lowerjawlength;
  difference() {
    union() {
      for (y=[-toothwidthstart,toothwidthstart]) {
	translate([jawspace,y-jawwidth/2,0]) cube([jawh,jawwidth,length]);
	translate([jawspace-toothsize*sqrt(2)/2+toothgap,y-jawwidth/2+toothwidth/2,upper?0:toothsize*sqrt(2)/2]) {
	  for (i=[0:1:teeth-2+upper]) {
	    translate([0,0,i*toothsize*sqrt(2)+toothsize*sqrt(2)/2]) rotate([0,45,0]) cube([toothsize,2,toothsize]);
	  }
	}
    }

    translate([jawspace,-toothwidthstart-jawwidth/2,length]) cube([jawh,toothwidthstart*2+jawwidth,jawwidth]);

      translate([jawspace+jawh-0.01,-toothwidthstart-jawwidth/2,length-jawhornlength+jawwidth]) triangle(jawhornheight,jawwidth,jawhornlength,1);
      translate([jawspace+jawh-0.01,toothwidthstart-jawwidth/2,length-jawhornlength+jawwidth]) triangle(jawhornheight,jawwidth,jawhornlength,1);

        translate([grabberwall+grabberfingerthickness+grabberwall-0.01,-toothwidthstart,grabberfingerlength-grabberfingerupperlength]) cube([jawwidth,toothwidthstart*2,length-(grabberfingerlength-grabberfingerupperlength)+0.03]);

    translate([0,-jawwidth/2,0]) union() {
      hull() {
	translate([jawspace,-toothwidthstart,jawwidth+length-jawwidth]) cube(jawwidth);
	translate([jawspace,-toothwidth,jawwidth+length-jawwidth]) cube(jawwidth);
	translate([(upper?0:jawspace)-jawh,-toothwidthstart/2,jawwidth+length-jawwidth/2+toothwidth/2]) cube(toothwidth);
      }
      hull() {
	translate([jawspace,toothwidthstart,jawwidth+length-jawwidth]) cube(jawwidth);
	translate([jawspace,toothwidth,jawwidth+length-jawwidth]) cube(jawwidth);
	translate([(upper?0:jawspace)-jawh,toothwidthstart/2,jawwidth+length-jawwidth/2+toothwidth/2]) cube(toothwidth);
      }
    }

    fingerattachment();
  }
  translate([jawspace+jawh-mouthcoverad,-toothwidthstart-jawwidth,length-mouthcoverad/2]) rotate([270,0,0]) cylinder(h=toothwidthstart*2+jawwidth*2+0.02,d=mouthcoverad);
  translate([jawspace+jawh-mouthcoverad/2-tolerance,-0.01-toothwidthstart-jawwidth/2,length-mouthcoverad/2]) rotate([0,-90,0]) translate([0,0,-tolerance]) cube([3*mouthcoverad,toothwidthstart*2+jawwidth+0.02,mouthcoverad/2+tolerance]);
translate([jawspace+jawh-jawwidth-mouthcoverad,-toothwidthstart+jawwidth/2-0.01,length-0.01]) cube([jawwidth+mouthcoverad+0.01,toothwidthstart*2+0.02-jawwidth,jawwidth+mouthcoverad]);
}
}

module mouthcover(upper) {
  difference() {
    union() {
      l=upper?mouthcoverlength:mouthcoverlength-cos(coverangle)*lowerjawshort;
      translate([0,-mouthcoverw/2,mouthcoverad/2]) cube([mouthcoverh,mouthcoverw,l-mouthcoverad/2-mouthcoverad/2]);
      translate([0,-mouthcoverww/2,mouthcoverad/2]) cube([mouthcoverh,mouthcoverww,mouthcoverwl]);
      translate([mouthcoverh-mouthcoverad/2,-mouthcoverw/2-jawwidth-tolerance,l-mouthcoverad/2]) intersection() {
	rotate([270,0,0]) cylinder(h=mouthcoverw+jawwidth*2+tolerance*2,d=mouthcoverad);
	translate([-mouthcoverad/2,0,0]) cube([mouthcoverad,mouthcoverw+jawwidth*2+tolerance*2,mouthcoverad]);
      }
      translate([mouthcoverh-mouthcoverad/2,-movementguidewidth/2+movementguidewmargin/2,mouthcoverad/2]) rotate([270,0,0]) cylinder(h=movementguidewidth-movementguidewmargin,d=mouthcoverad);
    }
    translate([-0.01,-mouthcovercutw/2,-0.01]) cube([mouthcoverh+0.02,mouthcovercutw,mouthcoverad+mouthcovercutl]);
  }
}

if (print == 0) {
  head();
  translate([0,0,toothstart]) jaw(1);
  translate([0,0,toothstart]) rotate([0,0,180]) jaw(0);
  translate([grabbermaxheight/2+mouthcoverad/2-movementguideh,0,movementguideposition+46+mouthcoverad+53]) rotate([0,-coverangle,0])mouthcover();
 }

if (print == 1) {
  rotate([180,0,90]) {
    jaw(1);
    translate([grabberfingerthickness*2+grabberwall*2+toothsize/sqrt(2),0,lowerjawshort]) jaw(0);
  }
 }

if (print == 3) {
  rotate([0,270,0]) mouthcover(1);
  translate([mouthcoverad+1,mouthcoverw+jawwidth+movementguidedepth,0]) rotate([0,270,0]) mouthcover(0);
 }

if (print == 4) {
  translate([mouthcoverad+1,mouthcoverw+jawwidth+movementguidedepth,0]) rotate([0,270,0]) mouthcover(0);
 }

if (print == 5) {
  rotate([0,270,0]) mouthcover(1);
 }

module mutterikolo() {
  translate([0,0,-0.01]) cylinder(d=ruuvidiameter, h=upperarmdiameter*2, $fn=60);
  translate([0,0,ruuvipituus/2]) cylinder(d=mutteridiameter, h=upperarmdiameter*2,  $fn=6);
}

module ruuvikolo() {
  translate([0,0,-0.01]) cylinder(d=ruuvidiameter, h=upperarmdiameter*2, $fn=60);
  translate([0,0,ruuvipituus/2]) cylinder(d=mutteridiameter, h=upperarmdiameter*2, $fn=6);
}

if (print == 2) {
  difference() {
    head();
    translate([-upperarmdiameter*2,-upperarmdiameter*2,-1-hd]) cube([upperarmdiameter*4,upperarmdiameter*2,grabbermaxheight*2]);
    translate([-grabbermaxheight/2-mutteridiameter-2,0,ruuvifrontposition]) rotate([270,0,0]) mutterikolo();
    translate([grabbermaxheight/2+mutteridiameter+2,0,ruuvifrontposition]) rotate([270,0,0]) mutterikolo();
    translate([-upperarmdiameter/2-mutteridiameter-2,0,ruuvibackposition]) rotate([270,0,0]) mutterikolo();
    translate([upperarmdiameter/2+mutteridiameter+2,0,ruuvibackposition]) rotate([270,0,0]) mutterikolo();
  }
  if (0) translate([0,-1,0]) difference() {
    head();
    translate([-upperarmdiameter*2,0,-1-hd]) cube([upperarmdiameter*4,upperarmdiameter*2,grabbermaxheight*2]);
    translate([-grabbermaxheight/2-mutteridiameter-2,0,ruuvifrontposition]) rotate([90,0,0]) ruuvikolo();
    translate([grabbermaxheight/2+mutteridiameter+2,0,ruuvifrontposition]) rotate([90,0,0]) ruuvikolo();
    translate([-upperarmdiameter/2-mutteridiameter-2,0,ruuvibackposition]) rotate([90,0,0]) ruuvikolo();
    translate([upperarmdiameter/2+mutteridiameter+2,0,ruuvibackposition]) rotate([90,0,0]) ruuvikolo();
  }
 }
