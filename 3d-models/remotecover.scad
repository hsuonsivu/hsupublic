// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=1;
debug=print==0?1:0;

xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.50;
cornerd=3;
wall=2;

versiontext="1.2";
text1="Useless button";
text2=str("cover V",versiontext);
textdepth=0.7;
textsize=6.5;
textfont="Liberation Sans:style=Bold";

remotel=161;
remoteh=13.3;
remoted=remoteh;
remotew=36.1;
remotethinh=10.8;
remotethinx=66.15;
remotethind=12;
remotethincenterx=70;

remotebuttonx=76;
remotebuttond=8;
remotebuttonh=0.45;
remotebuttonw=22;

remotecoveroutl=wall+xtolerance+81.5;
remotecoveroutw=remotew+ytolerance*2+wall*2;
remotecoverouth=remoteh+ztolerance*2+wall*2;
remotecoveroutd=remotecoverouth;
remotecoveroutx=-xtolerance-wall;
remotecoverinl=remotecoveroutl-wall;
remotecoverinw=remotew+ytolerance*2;
remotecoverinh=remoteh+ztolerance*2;
remotecoverind=remotecoverinh;
remotecoverinx=-xtolerance;
echo(remotecoveroutl,remotecoverinl,remotecoveroutx,remotecoverinx);

lockclipx=69.3+xtolerance;
lockclipcutl=20;
lockclipcut=0.5;
lockclipw=remotew-3;//-remoted;
lockclipspringw=remotew-remoted;
lockclipspringl=10;
lockclipspringtransit=(lockclipw-lockclipspringw)/2;
lockclipspringx=remotecoveroutx+remotecoveroutl-lockclipcutl-lockclipspringtransit-lockclipspringl;

module remote() {
  difference() {
    union() {
      hull() {
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([0,-remotew/2+remoted/2,0]) rotate([0,90,0]) roundedcylinder(remoted,remotel,cornerd,1,90);
	  }
      }
    }

    difference() {
      union() {
	hull() {
	  for (x=[remotethincenterx,remotel]) {
	    translate([x,0,-remoteh/2+remotethinh+remotethind/2]) rotate([90,0,0]) cylinder(d=remotethind,h=remotew+0.1,center=true,$fn=90);
	  }
	}
      }

      for (y=[-remotebuttonw/2,0,remotebuttonw]) {
	translate([remotebuttonx,y,-remoteh/2+remotethinh-1]) cylinder(d=remotebuttond,1+remotebuttonh,$fn=90);
      }
    }
  }
}

module remotecover() {
  difference() {
    union() {
      hull() {
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([remotecoveroutx,-remotecoveroutw/2+remotecoveroutd/2,0]) rotate([0,90,0]) roundedcylinder(remotecoveroutd,remotecoveroutl,cornerd,1,90);
	  }
      }
    }
    
    hull() {
      for (x=[remotethincenterx,remotel]) {
	translate([x,0,-remoteh/2+remotethinh+remotethind/2]) rotate([90,0,0]) cylinder(d=remotethind-dtolerance-wall*2,h=remotecoveroutw+0.1,center=true,$fn=90);
      }
    }

    hull() {
      translate([remotecoveroutx+remotecoveroutl-wall*2/3,-remotecoveroutw/2,-remoteh/2+remotethinh+ztolerance+wall]) cube([wall,remotecoveroutw,wall]);
      translate([remotecoveroutx+remotecoveroutl,-remotecoveroutw/2,-remoteh/2+remotethinh+ztolerance+wall-wall/2]) cube([wall,remotecoveroutw,wall]);
    }
    
    difference() {
      hull() {
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([remotecoverinx,-remotecoverinw/2+remotecoverind/2,0]) rotate([0,90,0]) cylinder(d=remotecoverind,h=remotecoverinl+0.1,$fn=90);
	  }
      }

      intersection() {
	d=remotethind-dtolerance;
	hull() {
	  translate([remotethincenterx-d/2,-remotecoveroutw/2,-remoteh/2+remotethinh]) cube([d/2,remotecoveroutw,d/2]);
	  translate([remotethincenterx-d/2+wall,-remotecoveroutw/2,-remoteh/2+remotethinh+wall]) cube([d/2,remotecoveroutw,d/2]);
	}
	translate([remotethincenterx,0,-remoteh/2+remotethinh+remotethind/2]) rotate([90,0,0]) cylinder(d=remotethind-dtolerance,h=remotecoveroutw+0.1,center=true,$fn=90);
      }
      hull() {
	for (x=[remotethincenterx,remotecoveroutx+remotecoveroutl]) {
	  translate([x,0,-remoteh/2+remotethinh+remotethind/2]) rotate([90,0,0]) cylinder(d=remotethind-dtolerance-wall,h=remotecoveroutw+0.1,center=true,$fn=90);
	}
      }
      translate([remotecoveroutx+remotecoveroutl,0,-remoteh/2+remotethinh+remotethind/2]) scale([0.5,1,1]) rotate([90,0,0]) cylinder(d=remotethind-dtolerance,h=remotecoveroutw+0.1,center=true,$fn=90);
    }

    for (m=[0,1]) mirror([0,m,0]) {
	translate([remotecoveroutx+remotecoveroutl-lockclipcutl,-lockclipw/2-lockclipcut,0]) cube([lockclipcutl+0.1,lockclipcut,remotecoverouth/2+0.1]);
	translate([lockclipspringx,-lockclipspringw/2-lockclipcut,0]) cube([lockclipspringl+lockclipcut,lockclipcut,remotecoverouth/2+0.1]);
	hull() {
	  translate([lockclipspringx+lockclipspringl,-lockclipspringw/2-lockclipcut,0]) cube([lockclipcut,lockclipcut,remotecoverouth/2+0.1]);
	  translate([lockclipspringx+lockclipspringl+lockclipspringtransit,-lockclipw/2-lockclipcut,0]) cube([lockclipcut,lockclipcut,remotecoverouth/2+0.1]);
	}
      }

    textx=(remotethinx-remotethind/4)/2+1;
    translate([textx,textsize/2+1,remotecoverouth/2-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) text(text=text1,size=textsize,font=textfont,valign="center",halign="center");
    translate([textx,-textsize/2-1,remotecoverouth/2-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) text(text=text2,size=textsize,font=textfont,valign="center",halign="center");

  }

  if (0) intersection() {
    translate([remotecoveroutx,-remotecoveroutw/2,0]) cube([remotecoveroutl,remotecoveroutw,remotecoverouth/2-wall/2]);
    union() {
      translate([remotethincenterx,-lockclipw/2,-remoteh/2+remotethinh+remotethind/2]) rotate([-90,0,0]) roundedcylinder(remotethind-dtolerance,lockclipw,cornerd,0,90);
    }
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([-100,0,-100]) cube([200,200,200]);
    union() {
      difference() {
	remotecover();
	#remote();
      }
    }
  }
 }

if (print==1) {
  translate([0,0,wall+xtolerance]) rotate([0,-90,0]) remotecover();
 }
