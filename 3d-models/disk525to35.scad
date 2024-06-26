// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// 0: Make a complex version with locking mechanism
// 1: Make a simple version, with no locking mechanism
simple=0;

// Full version, includes all material saving holes (very slow in openscad - render before rotating view)
full=1;

// Enable pushers and holder separately (pushers only print with non-simple version)
springpushers=1;
holder=1;

// Short or long version
short=1;

// Width locking keys as multiple of screw diameter
keywidthmultiplier=1.60;

versiontext="V2.2";

length=short?170:198; // Shorter version 17.05, long version 19.8;

width=146;
height=40;//41.8;
outscrewh=10;
outscrew2h=22.5;
outscrew1position=52.3;
outscrew2position=131.93;
outscrewdiameter=2.8;
outscrewbase=0.1;
outscrewspringlength=25;
outscrewspringheight=outscrewdiameter*keywidthmultiplier;
outscrewspringangle=simple?0:3;
springgap=0.7;

disklength=147;
diskwidth=102.7;
diskheight=26; // max height can be up to 41.2 but that is also 5.25 max height - needs to be two separate parts in that case
diskxposition=length-disklength+2;
diskyposition=width/2-diskwidth/2;
diskentrywidth=diskwidth; //105;

bottomthickness=2;
roofthickness=2;
sidebottomthickness=bottomthickness+0.3;
sideroofthickness=roofthickness+0.5;
diskscrewh=6.7;
diskscrew1position=16.52;
diskscrew2position=76.71;
diskscrew3position=118.19;
diskscrewdiameter=3;
diskscrewbase=outscrewbase;
diskscrewspringlength=25;
diskscrewspringheight=diskscrewdiameter*keywidthmultiplier;
diskscrewspringangle=simple?0:3;

springpusherextra=5.3; // How much wider pusher needs to be to have strong enough sides at openings.

airholediameterx=55;
airholediametery=25;
airholedistancex=7;
airholedistancey=7;
airholesx=floor((length-airholedistancex)/(airholediameterx+airholedistancex));
airholesy=floor(diskwidth/(airholediametery+airholedistancey));
airholeslength=airholesx*airholediameterx+(airholesx-1)*airholedistancex;
airholeswidth=airholesy*airholediametery+(airholesy-1)*airholedistancey;
airholexstart=length/2-airholeslength/2;
airholeystart=width/2-airholeswidth/2;
//echo("airholesx ",airholesx," airoholexstart", airholexstart, " airholeslength ", airholeslength, "kaava", (airholediameter+airholedistance)*airholesx/2);

sidewall=2;
sidecutwidth=width/2-diskwidth/2-2*sidewall;
sidecutheight=height-sidebottomthickness-sideroofthickness;

sideairholediameterx=38;
sideairholediametery=14;
sideairholedistancex=7;
sideairholedistancey=7;
sideairholesx=floor(length/(sideairholediameterx+sideairholedistancex));
sideairholesy=floor(diskwidth/(sideairholediametery+sideairholedistancey));
sideairholeslength=sideairholesx*sideairholediameterx+(sideairholesx-1)*sideairholedistancex;
sideairholeswidth=sideairholesy*sideairholediametery+(sideairholesy-1)*sideairholedistancey;
sideairholexstart=length/2-sideairholeslength/2;
sideairholeystart=width/2-sideairholeswidth/2;

sidetopairholediameterx=38;
sidetopairholediametery=14;
sidetopairholedistancex=7;
sidetopairholedistancey=7;
sidetopairholesx=floor(length/(sidetopairholediameterx+sidetopairholedistancex));
sidetopairholesy=floor(diskwidth/(sidetopairholediametery+sidetopairholedistancey));
sidetopairholeslength=sidetopairholesx*sidetopairholediameterx+(sidetopairholesx-1)*sidetopairholedistancex;
sidetopairholeswidth=sidetopairholesy*sidetopairholediametery+(sidetopairholesy-1)*sidetopairholedistancey;
sidetopairholexstart=length/2-sidetopairholeslength/2;
sidetopairholeystart=sidewall+sidecutwidth/2-sidetopairholediametery/2; //width/2-sidetopairholeswidth/2;

springpusherheightout=outscrewspringheight+springpusherextra;
springpusherheightdisk=diskscrewspringheight+springpusherextra;
springpusherheight=max(springpusherheightout,springpusherheightdisk);
springpusherlengthout=outscrew2position + outscrewspringheight;
springpusherlengthdisk=diskscrew3position+diskxposition + diskscrewspringheight;
echo("outscrewh ", outscrewh, " diskscrewh ", diskscrewh);
echo("outscrewspringpushertop ",outscrewspringpushertop," -bottom ",outscrewspringpusherbottom," top-bottom ",outscrewspringpushertop-outscrewspringpusherbottom," springpusherheightout ",springpusherheightout);
echo("diskscrewspringpushertop ",diskscrewspringpushertop," -bottom ",diskscrewspringpusherbottom," top-bottom ",diskscrewspringpushertop-diskscrewspringpusherbottom," springpusherheightdisk ",springpusherheightdisk);
//springpusherlength=max(springpusherlengthout,springpusherlengthdisk);
springpusherthickness=2.5;//5;
springpusherhandle=7;
springpusherhandlethickness=10;
springpushergap=1;
springpusherwall=2;
springpusherbottom=1.5;
springpusherroof=1.5;

outscrewspringpusherbottom=outscrewh-outscrewspringheight/2-springpusherextra/2-springpushergap/2;
outscrewspringpushertop=outscrewh+outscrewspringheight/2+springpusherextra/2+springpushergap/2;
outscrew2springpusherbottom=outscrew2h-outscrewspringheight/2-springpusherextra/2-springpushergap/2;
outscrew2springpushertop=outscrew2h+outscrewspringheight/2+springpusherextra/2+springpushergap/2;
diskscrewspringpusherbottom=diskscrewh-diskscrewspringheight/2-springpusherextra/2-springpushergap/2+bottomthickness;
diskscrewspringpushertop=diskscrewh+diskscrewspringheight/2+springpusherextra/2+springpushergap/2+bottomthickness;

// this probably should be calculated from springpushergap; This adjusts steepness of raise behing screwhole insert.
keysupportadjust=0.5;

// Extra length for the hole to allow releasing springpusher in the wrong hole :/
keycutextra=4;
textdepth=0.5;

sidefreez=height-sideroofthickness-sidebottomthickness-springpusherheightdisk-springpushergap-springpusherroof;
sideairholezstart=sidebottomthickness+springpusherheightdisk+springpushergap+springpusherroof+sidefreez/2-sideairholediametery/2;

module tappi(screwdiameter,screwbase) {
  cylinder(h=screwbase,d=screwdiameter,$fn=30);
  translate([0,0,screwbase-0.01]) sphere(d=screwdiameter,$fn=30);  //cylinder(h=screwdiameter/2,d1=screwdiameter,d2=screwdiameter/3,$fn=30);
}

module key(keylength,keywidth,keythickness,keyscrewdiameter,keyscrewdepth) {
  translate([-1,-keywidth/2,0]) union () {
    cube([keylength+1,keywidth,keythickness]);
    translate([keylength+1,keywidth/2,0]) cylinder(h=keythickness,d=keywidth, $fn=30);
    translate([keylength+1,keywidth/2,keythickness]) tappi(keyscrewdiameter,keyscrewdepth);
    if (!simple) {
      translate([keylength+1,keywidth/2,0.5]) resize([0,0,springpushergap+1]) sphere(d=keywidth,$fn=30);
    }
  }
}

// This is centered on key
module keycut(keycutlength,keycutwidth,keycutthickness) {
  translate([-0.01,-springgap-keycutwidth/2,-0.01]) cube([keycutlength+keycutextra+springgap*2+0.02,keycutwidth+springgap*2,keycutthickness+0.02]);
  translate([keycutlength+keycutextra+springgap*2,-springgap-keycutwidth/2,0]) intersection() {
    dia=keycutwidth+springgap;
    diaroot=sqrt(dia)*2;
    translate([0,0,-0.01]) rotate([0,0,45]) cube([diaroot,diaroot,keycutthickness+0.02]);
    translate([0,0,-0.01]) cube([keycutwidth/2+springgap*2,keycutwidth+0.02+springgap*2,keycutthickness+0.02]);
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
  }
}

module roundedbox(x,y,z) {
  smallcornerdiameter=1;
  f=30;
  hull() {
    translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
  }
}

module holvicut(x,y,z) {
  translate([x/2-0.01,y/2-0.01,-0.01]) resize([x+0.02,y+0.02,z+0.02]) cylinder(h=z+0.02,d=x,$fn=6);
  translate([-0.01,-0.01,-0.01]) cube([x/2+0.2,y+0.02,z+0.02]);
}

//tappi();

//translate([-30,0,0]) key(20,6,2,3,0.3);
//translate([-30,0,-3]) keycut(20,6,2);

module halfholder() {
  disky = width/2-diskwidth/2-sidewall;

  union() {
    difference() {
      roundedbox(length,width,height);
      translate([diskxposition-0.01,width/2-diskwidth/2,bottomthickness]) cube([disklength+0.02,diskwidth,height-bottomthickness-roofthickness]);
      translate([-0.01,width/2-diskentrywidth/2,bottomthickness]) cube([diskxposition+0.02,diskentrywidth,height-bottomthickness-roofthickness]);
      if (diskxposition+disklength>length) {
	translate([diskxposition+disklength-0.01,width/2-diskentrywidth/2,bottomthickness]) cube([length-diskxposition-disklength+1,diskentrywidth,height-bottomthickness-roofthickness]);
      } else {
	echo("Disk is recessed in the case, this is bad for cabling.");
      }

      if (full) {
	for(x=[0:1:airholesx-1]) {
	  for(y=[0:1:floor((airholesy+1)/2)]) {
	    translate([airholexstart+x*(airholediameterx+airholedistancex),airholeystart+y*(airholediametery+airholedistancey),-0.01]) holvicut(airholediameterx, airholediametery, height+1);
	  }
	}

	for(x=[0:1:sidetopairholesx-1]) {
	  translate([sidetopairholexstart+x*(sidetopairholediameterx+sidetopairholedistancex),sidetopairholeystart,height-sideroofthickness-0.01]) holvicut(sidetopairholediameterx,sidetopairholediametery,sideroofthickness+1);
	}

	for(x=[0:1:sideairholesx-1]) {
	  translate([sideairholexstart+x*(sideairholediameterx+sideairholedistancex),sidecutwidth+sidewall*2,sideairholezstart]) rotate([90,0,0]) holvicut(sideairholediameterx,sideairholediametery,sidecutwidth+sidewall-1);
	}
      }

      translate([-0.01,sidewall,sidebottomthickness]) cube([length+0.02,sidecutwidth,sidecutheight]);
      translate([-0.01,sidewall,sidebottomthickness]) cube([sidewall+sidecutwidth,sidecutwidth,springpusherheightdisk-sidebottomthickness+sidewall]);
      
      translate([sidewall+diskxposition,width-(width/2-diskwidth/2-2*sidewall)-sidewall,sidebottomthickness]) cube([disklength-2*sidewall,width/2-diskwidth/2-2*sidewall,height-sidebottomthickness-sideroofthickness+20]);

      for (x=[outscrew1position,outscrew2position]) {
	translate([x-outscrewspringlength,0,outscrewh]) rotate([270,0,0]) keycut(outscrewspringlength,outscrewspringheight,sidewall);
      }
      
      for (x=[outscrew1position,outscrew2position]) {
	translate([x-outscrewspringlength,0,outscrew2h]) rotate([270,0,0]) keycut(outscrewspringlength,outscrewspringheight,sidewall);
      }

      for (x=[diskscrew1position,diskscrew2position,diskscrew3position]) {
	translate([diskxposition+x-diskscrewspringlength,disky,diskscrewh+bottomthickness]) rotate([270,0,0]) keycut(diskscrewspringlength,diskscrewspringheight,sidewall);
      }

      translate([-0.01,width/2+0.01,-0.01]) cube([length+0.02,width,height+0.02]);
    }
    
    for (x=[outscrew1position,outscrew2position]) {
      translate([x-outscrewspringlength,sidewall,outscrewh]) rotate([90,0,outscrewspringangle]) key(outscrewspringlength,outscrewspringheight,sidewall,outscrewdiameter,outscrewbase);
    }
    

    for (x=[outscrew1position,outscrew2position]) {
      translate([x-outscrewspringlength,sidewall,outscrew2h]) rotate([90,0,outscrewspringangle]) key(outscrewspringlength,outscrewspringheight,sidewall,outscrewdiameter,outscrewbase);
    }

    for (x=[diskscrew1position,diskscrew2position,diskscrew3position]) {
      translate([diskxposition+x-diskscrewspringlength,sidecutwidth+sidewall,diskscrewh+bottomthickness]) rotate([270,0,-diskscrewspringangle]) key(diskscrewspringlength,diskscrewspringheight,sidewall,diskscrewdiameter,diskscrewbase);
    }

    if (!simple) {
      translate([0,sidewall-0.01,outscrewspringpusherbottom-springpusherbottom]) cube([springpusherlengthout,springpusherthickness+springpushergap+0.01+springpusherwall,springpusherbottom]);
      translate([springpusherhandlethickness,sidewall+springpusherthickness+springpushergap,outscrewspringpusherbottom-0.01]) difference() {
	cube([springpusherlengthout-springpusherhandlethickness,springpusherwall,springpusherheightout+springpushergap+0.02]);
	translate([-0.01,-0.01,0]) triangle(springpusherheightout+springpushergap+0.02,springpusherwall+0.02,springpusherheightout+springpushergap+0.03,1);	
      }
      translate([springpusherhandlethickness+springpusherheightout,sidewall-0.01,outscrewspringpushertop]) difference() {
	cube([springpusherlengthout-springpusherhandlethickness-springpusherheightout,springpusherthickness+springpushergap+0.01+springpusherwall,springpusherroof]);
	translate([-0.01,-0.01,springpusherroof+0.01]) rotate([-90,0,0]) triangle(springpusherheightout+springpushergap+0.02,springpusherroof+0.02,springpusherthickness+springpushergap+springpusherwall+0.03,1);	
    }

    translate([0,sidewall-0.01,outscrew2springpusherbottom-springpusherbottom]) difference() {
      cube([springpusherlengthout,springpusherthickness+springpushergap+0.01+springpusherwall,springpusherbottom]);
      translate([-0.01,-0.01,springpusherroof+0.01]) rotate([-90,0,0]) triangle(springpusherheightout+springpushergap+0.02,springpusherroof+0.02,springpusherthickness+springpushergap+springpusherwall+0.03,1);	      
  }
      translate([springpusherhandlethickness,sidewall+springpusherthickness+springpushergap,outscrew2springpusherbottom-0.01]) difference() {
	cube([springpusherlengthout-springpusherhandlethickness,springpusherwall,springpusherheightout+springpushergap+0.02]);
	translate([-0.01,-0.01,0]) triangle(springpusherheightout+springpushergap+0.02,springpusherwall+0.02,springpusherheightout+springpushergap+0.03,1);	
	translate([-0.01-springpusherhandlethickness,-0.01-springpusherthickness-springpushergap,springpusherbottom]) rotate([-90,0,0]) triangle(springpusherheightout+springpushergap+0.02,springpusherroof+0.02,springpusherthickness+springpushergap+springpusherwall+0.03,1);
}
      translate([springpusherhandlethickness+springpusherheightout-0.01,sidewall-0.01,outscrew2springpushertop]) difference() {
	cube([springpusherlengthout-springpusherhandlethickness-springpusherheightout+0.01,springpusherthickness+springpushergap+0.02+springpusherwall,springpusherroof]);
	translate([-0.01,-0.01,springpusherroof+0.01]) rotate([-90,0,0]) triangle(springpusherheightout+springpushergap+0.02,springpusherroof+0.02,springpusherthickness+springpushergap+springpusherwall+0.03,1);	
      }

      echo("diskscrewspringpusherbottom ",diskscrewspringpusherbottom," sidebottomthickness ", sidebottomthickness);
      translate([0,sidewall+sidecutwidth-springpusherthickness-springpushergap-springpusherwall,diskscrewspringpusherbottom-springpusherbottom]) cube([springpusherlengthdisk,springpusherthickness+springpushergap+0.01+springpusherwall,springpusherbottom]);
      
      translate([springpusherhandlethickness,sidewall+sidecutwidth-springpusherthickness-springpushergap-springpusherwall,diskscrewspringpusherbottom-0.01]) difference() {
	cube([springpusherlengthdisk-springpusherhandlethickness,springpusherwall,springpusherheightdisk+springpushergap+0.02]);
	translate([-0.01,-0.01,0]) triangle(springpusherheightdisk+springpushergap+0.02,springpusherwall+0.02,springpusherheightdisk+springpushergap+0.03,1);
      }

      translate([springpusherhandlethickness+springpusherheightdisk,sidewall+sidecutwidth-springpusherthickness-springpushergap-springpusherwall,diskscrewspringpushertop]) difference() {
	cube([springpusherlengthdisk-springpusherhandlethickness-springpusherheightdisk,springpusherthickness+springpushergap+springpusherwall+0.01,springpusherroof]);
	translate([-0.01,springpusherthickness+springpushergap+springpusherwall,0]) rotate([90,0,0]) triangle(springpusherheightdisk+springpushergap+0.02,springpusherroof+0.02,springpusherthickness+springpushergap+springpusherwall+0.03,1);	
      }
  }
    }
  }

if (holder) {
  difference() {
    union() {
      halfholder();
      translate([0,width,0]) mirror([0,1,0]) halfholder();
    }
    translate([2,width-(width-diskwidth)/2-2,bottomthickness-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="left");
    translate([2,width-2,height-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,size=airholedistancex-2,halign="left");
    slotnumbersize=springpusherthickness+springpusherwall+1;

    if (!simple) {
      translate([1,width-sidewall-1,outscrewspringpusherbottom-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("1",size=slotnumbersize,halign="left");
      translate([1,width-sidewall-sidecutwidth+springpusherthickness+springpushergap+springpusherwall-1,diskscrewspringpusherbottom-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("2",size=slotnumbersize,halign="left");
      translate([1,sidewall+sidecutwidth-1,diskscrewspringpusherbottom-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("3",size=slotnumbersize,halign="left");
      translate([1,sidewall+springpusherthickness+springpushergap+springpusherwall-1,outscrewspringpusherbottom-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("4",size=slotnumbersize,halign="left");
    }
  }
 }

// springpushersticks
if (!simple && springpushers) {
  //out
  for (i=[0:1:3]) {
    translate([0,0,height+1+i*(springpusherheight+1)]) union() {
      v=["1", "4", "3", "2"];
      v2=[0, 1, 0, 1];
      t=v[i];
      rot=v2[i];
      difference() {
	union() {
	  if (i < 2) {
	    roundedbox(springpusherthickness,outscrew2position+outscrewdiameter*2,springpusherheight);
	  } else {
	    roundedbox(springpusherthickness,diskxposition+diskscrew3position+diskscrewdiameter*2,springpusherheight);
	  }
	  roundedbox(springpusherhandle,springpusherhandlethickness,springpusherheight);
	  translate([springpusherthickness-0.01,springpusherhandlethickness-0.01,0.5]) cube([springpusherwall+0.01,0.5+0.01,springpusherheight-1]);
	  translate([springpusherthickness+springpusherwall,springpusherhandlethickness+0.5,0.5]) rotate([0,0,90]) triangle(springpusherheight-1,springpusherwall+0.01,springpusherheight-1,(i==0 || i==2)?1:2);
	}
	translate([springpusherthickness-textdepth+0.01,springpusherhandlethickness+springpusherheight+2,(rot?springpusherheight-2:2)]) rotate([90,rot?180:0,90]) linear_extrude(height=textdepth) text(versiontext,size=springpusherheight-4,halign=rot?"right":"left");
	if (i < 2) {
	  for (x=[outscrew1position,outscrew2position]) {
	    translate([-0.01,x+outscrewdiameter*2,springpusherheight/2-outscrewspringheight/2-springpushergap]) cube([springpusherthickness+0.02,outscrewspringlength+outscrewdiameter*2,outscrewspringheight+springpushergap*2]);
	    translate([-0.01,x+outscrewdiameter*2+outscrewspringlength+outscrewdiameter*2+springpusherthickness,springpusherheight/2-outscrewspringheight/2-springpushergap]) rotate([90,0,0]) triangle(springpusherthickness+0.02,outscrewspringheight+springpushergap*2,springpusherthickness+0.02,1);
	  }
	} else {
	  for (x=[diskscrew1position,diskscrew2position,diskscrew3position]) {
	    translate([-0.01,x+diskxposition+diskscrewdiameter*2,springpusherheight/2-diskscrewspringheight/2-springpushergap]) cube([springpusherthickness+0.02,diskscrewspringlength+diskscrewdiameter*2,diskscrewspringheight+springpushergap*2]);
	    translate([-0.01,x+diskxposition+diskscrewdiameter*2+diskscrewspringlength+diskscrewdiameter*2+springpusherthickness,springpusherheight/2-diskscrewspringheight/2-springpushergap]) rotate([90,0,0]) triangle(springpusherthickness+0.02,diskscrewspringheight+springpushergap*2,springpusherthickness+0.02,1);
	  }
	}
	translate([-0.1,springpusherhandlethickness/2,-1]) rotate([0,90,0]) cylinder(h=springpusherhandle+0.2,d=springpusherhandle,$fn=30);
	translate([-0.1,springpusherhandlethickness/2,1+springpusherheight]) rotate([0,90,0]) cylinder(h=springpusherhandle+0.2,d=springpusherhandle,$fn=30);
	translate([springpusherhandle/2,textdepth-0.01,rot?springpusherheight-1.5:1.5]) rotate([90,rot?180:0,0]) linear_extrude(height=textdepth) resize([springpusherhandle-3,0,0]) text(t,size=springpusherheight-3,halign="center");
      }
    }
  }
}

