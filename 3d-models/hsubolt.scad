// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

use <threadlib/threadlib.scad>

m20div=1.3;
m20drext=1.5830/m20div;
m20drint=1.5330/m20div+0.1;

MY_THREAD_TABLE=[
		 ["M20-ext", [2.5, 8.3120+(1.1583-m20drext)+0.1, 16.9380+(1.5830-m20drext)*2, [[0, -1.0929], [0, 1.0929], [m20drext+0.1, 0.1790], [m20drext+0.1, -0.1790]]]],
		 ["M20-int", [2.5, -10.2925, 20.2925, [[0, 1.2304], [0, -1.2304], [m20drint, -0.3453], [m20drint, 0.3453]]]]
		 ];

boltturns=5;
boltholespecs=thread_specs("M20-int",table=MY_THREAD_TABLE);
boltholepitch=boltholespecs[0];
boltholed=boltholespecs[2];
boltholel=(boltturns+1)*boltholespecs[0];
boltspecs=thread_specs("M20-ext",table=MY_THREAD_TABLE);
boltpitch=boltspecs[0];
boltd=boltspecs[2];
boltl=(boltturns+1)*boltpitch;
//boltbasel=7;
boltbaseh=9;
boltbased=boltd+20;
boltthreadh=boltpitch;
  
// Make a bolt
module m20bolt(threadlength=20,nothreadlength=0,text="",font="",textsize=boltbased/2,boltbaseh=boltbaseh) {
  boltturns=(threadlength-nothreadlength-boltd*0.1-cornerd/2)/boltpitch-0.5;
  boltl=(boltturns)*boltspecs[0];
  difference() {
    union() {
      translate([0,0,-boltbaseh]) roundedcylinder(boltbased,boltbaseh,cornerd,1,6);
      hull() {
	translate([0,0,-cornerd/2]) cylinder(d=boltd,h=cornerd/2+nothreadlength,$fn=90);
	translate([0,0,-cornerd/2]) roundedcylinder(boltholed-1,nothreadlength,cornerd,0,90);//cylinder(d=boltd,h=nothreadlength+0.01,$fn=90);
      }
      //translate([0,0,boltbasel-cornerd]) roundedcylinder(boltholed,cornerd,1,90); //supportringl-supportringdepth+
      //translate([0,0,boltbasel-0.01]) cylinder(d=boltd,h=ztolerance+0.02); //supportringl-supportringdepth+
      intersection() {
	translate([0,0,nothreadlength]) cylinder(d=boltholed,h=boltl+boltthreadh/2,$fn=90);
	translate([0,0,nothreadlength+boltthreadh/4]) bolt("M20",turns=boltturns,table=MY_THREAD_TABLE);
      }
      hull() {
	translate([0,0,-cornerd/2]) roundedcylinder(boltd,threadlength-boltd*0.1+cornerd/2,cornerd,0,90);
	translate([0,0,0]) roundedcylinder(boltd*0.9,threadlength,cornerd,0,90);
      }
      if (0) hull() {
	translate([0,0,boltthreadh+boltpitch/2+boltpitch-cornerd/2]) roundedcylinder(boltd,cornerd,cornerd,0,90);//+supportringl
	translate([0,0,boltthreadh+boltpitch/2+boltpitch+cornerd]) roundedcylinder(boltd-cornerd*2,cornerd,cornerd,0,90);//+supportringl
      }
    }

    for (a=[0:360/6:359]) {
      d=2*sin(360/6)*boltbased;
      cutd=3.14159*d/6*0.9;
      sink=(boltbased/2-cos(360/6)*(boltbased/2))/2;
      rotate([0,0,360/6/2+a]) translate([boltbased/2+cutd/2-sink,0,-boltbaseh-0.01]) cylinder(d=cutd,h=boltbaseh+0.02,$fn=90);
    }
      
    translate([0,0,-boltbaseh-0.01]) resize([boltd*0.8,boltd*0.8,0]) linear_extrude(textdepth) rotate([180,0,0]) text(text,size=textsize,font=font,valign="center",halign="center");
  }
}

// Bolt cover
module m20boltcover(threadlength=20) {
  roundedcylinder(boltholed+4,threadlength+4,cornerd,0,90);
}
		    
// Tap a bolt hole
module m20boltcut(threadlength=20) {
  boltturns=(threadlength-boltd*0.1-cornerd/2)/boltpitch-0.5;
  boltl=(boltturns)*boltspecs[0];
  boltholel=(boltturns+1)*boltholespecs[0];
  translate([0,0,boltholepitch/2]) rotate([0,0,180]) tap("M20",turns=boltturns+0.5,table=MY_THREAD_TABLE);
  translate([0,0,-0.01]) cylinder(d=boltholed,h=0.02,$fn=90);
  translate([0,0,boltholepitch/2+boltholel-0.01]) cylinder(d1=boltholed,d2=boltholed-boltpitch,h=boltpitch+0.02,$fn=90);
}

function boltholed()=boltholed;
function boltbased()=boltbased;
function boltbaseh()=boltbaseh;
function boltholel()=boltholel;
function boltholecoverd()=boltholed+4;
