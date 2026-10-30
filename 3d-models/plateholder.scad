// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=print>0?0:0;

largeplate=0;
smallplate=1;

platesize=0;
platesizetable=[[116.5,108.3,105,105,50],
		[110.5,117.8,105,105,60]];

abs=1;
sizecompensation=1;//abs?1.009:1.003;

platew=largeplate?300*sizecompensation:platesizetable[platesize][0];
plateh=largeplate?400*sizecompensation:platesizetable[platesize][1];
platel=2;

platescrewcorner=10; // Distance of the screw hole from edge

versiontext=str("V1.2");
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";

wall=3;

maxbridge=10;
cornerd=min(3,wall);
smallcornerd=0.2;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

versiontextl=textlen(versiontext)+cornerd;

thickwall=6;

screwd=4.4*sizecompensation; // M4
screwtowerd=11;
screwheadd=8.5*sizecompensation; //8.6; // Round head
screwheadh=3.5;
screwheadspaceh=6;
screwl=20;

nutd=7*sizecompensation;//+dtolerance;
nuth=3.1*sizecompensation+ztolerance;
nutcd=nutd/cos(180/6)*sizecompensation+dtolerance;

endd=12;
end2d=9;
endl=endd;
endh=endd;

poled=(largeplate?60:platesizetable[platesize][4])*sizecompensation;
poleh=40;

polecut=1;

//poleoutd=poled+thickwall*2;
poleoutd=poled+thickwall*2;
//poleout2d=poled+thickwall;
poleout2d=poleoutd;
poleouth=poleh; //poled*0.8;
poleoutgap=1;
poleoutx=poleoutd/2+poleoutgap;
polesupporth=poleouth-5;

polescrewx=poleoutx-screwl/2;
polescrewy=-poled/2-screwd;
polescrewheight=poleh/2;
polescrewholex=poleoutx-screwl/2-10;

cut=0.5;
nutclipcuth=screwd*2;
nutclipcutw=screwd*3;
nutclipl=1;
nutclipw=2;
nutclipdepth=0.4;
nutcliph=2;
nutcliplowh=5;

holderw=wall+ytolerance+platew+ytolerance+wall;
holderh=wall+ztolerance+plateh+ztolerance+wall;
holderl=wall+ztolerance+platel+ztolerance+wall;
holderx=wall-holderl;

openingw=largeplate?platew:platesizetable[platesize][2];
openingh=largeplate?platew:platesizetable[platesize][3];
openingheight=holderh/2-openingh/2;

hatoverlap=(holderh-openingh)/2;
hatcollarh=hatoverlap;
hatheight=holderh-hatoverlap;

hatw=wall+ytolerance+holderw+holderl+ytolerance+wall;
hatl=wall+xtolerance+holderl+xtolerance+wall;
hath=wall;
hatx=wall+xtolerance+wall-hatl;
hattopl=wall*2+hatl+wall*2;

hatclipd=wall;
hatclipl=platew/2;
hatclipdepth=0.65;
hatclipheight=hatheight-hatcollarh/2+hatclipd/2+cornerd/2;
hatangle=10;

module plateholder() {
  texth=textsize+cornerd+1;
  textl=versiontextl;
  
  difference() {
    for (m=[0,1]) mirror([0,m,0]) {
	translate([poleoutx+poleoutd/2-thickwall,-texth/2,0]) roundedbox(thickwall,texth,textl,cornerd,1);
  
	hull() {
	  translate([poleoutx,0,0]) roundedcylinder(poleoutd,cornerd,cornerd,1,180);
	  translate([poleoutx,0,0]) roundedcylinder(poleout2d,poleouth,cornerd,1,180);
	}

	if (largeplate) {
	  hull() {
	    intersection() {
	      union() {
		translate([poleoutx,0,0]) roundedcylinder(poleoutd,cornerd,cornerd,1,180);
		translate([poleoutx,0,0]) roundedcylinder(poleout2d,poleouth/2,cornerd,1,180);
	      }
	      translate([0,-poleoutd/2,0]) cube([poleoutx-polecut/2,poleoutd,poleouth]);
	    }
	    translate([0,-platew/2+platescrewcorner-endd/4,0]) roundedbox(endl,cornerd,cornerd,cornerd,1);
	    translate([0,-platew/2+platescrewcorner,0]) roundedbox(endl,cornerd,endd,cornerd,1);

	    intersection() {
	      union() {
		translate([poleoutx,0,0]) roundedcylinder(poleoutd,cornerd,cornerd,1,180);
		translate([poleoutx,0,0]) roundedcylinder(poleout2d,poleouth,cornerd,1,180);
	      }
	      //translate([poleoutd/3/2,-poleoutd/2,0]) cube([poleoutd/2-poleoutd/3,poleoutd,poleouth]);
	      translate([poleoutgap,-poleoutd/2,0]) cube([poleoutd/2-poleoutd/3,poleoutd,poleouth]);
	    }
	    translate([0,-platew/2+platescrewcorner-endd/4,0]) roundedbox(endl,cornerd,cornerd,cornerd,1);
	    translate([0,-platew/2+platescrewcorner,0]) roundedbox(endl,cornerd,endd,cornerd,1);
	  }
	  hull() {
	    translate([0,-platew/2+platescrewcorner-endd/4,0]) roundedbox(endl,cornerd,cornerd,cornerd,1);
	    translate([0,-platew/2+platescrewcorner,endd/2]) rotate([0,90,0]) roundedcylinder(endd,endh,cornerd,0,180);
	  }
	}

	if (smallplate) {
	  difference() {
	    union() {
	      translate([0,-holderw/2,0]) roundedbox(wall,holderw,holderh,cornerd,1);
	      difference() {
		translate([holderx,-holderw/2,0]) roundedbox(wall,holderw,holderh,cornerd,1);
		translate([holderx-cornerd/2,-openingw/2,openingheight]) roundedbox(wall+cornerd,openingw,holderh,cornerd,0);
	      }
	      difference() {
		translate([holderx,-holderw/2,0]) roundedbox(holderl,holderw,wall,cornerd,1);

		// Water leak holes
		for (y=[-platew/2+platel/2,0,platew/2-platel/2]) {
		  translate([holderx+holderl/2,y,-0.1]) cylinder(d=platel,h=wall+0.2,$fn=60);
		}
	      }

	      hull() {
		translate([holderx,-holderw/2,0]) roundedbox(holderl,wall,holderh,cornerd,1);
		intersection() {
		  translate([holderx+holderl/2,-holderw/2,0]) roundedcylinder(holderl,holderh,cornerd,1,90);
		  translate([holderx,-holderw/2-holderl/2,0]) cube([holderl,holderl/2,holderh]);
		}
	      }
	    }

	    // Hat clip
	    translate([wall+hatclipd/2-hatclipdepth,0,hatclipheight]) rotate([0,0,90]) tubeclip(hatclipl,hatclipd,dtolerance);
	  }

	  //Plate supports
	  for (y=[-holderw/2+cornerd/2+wall,0]) {
	    hull() {
	      translate([0,y==0?-wall/2:y,0]) roundedbox(wall,wall,holderh-hatoverlap-hatcollarh+cornerd/2,cornerd,1);
	      translate([y==0?0:poled/2,y==0?-wall/2:-poled/2-wall,0]) roundedbox(y==0?thickwall+poleoutgap:wall,wall,poleh,cornerd,1);
	    }
	  }
	}

	// Pole screw tower
	hull() {
	  towerx=polescrewx-12;
	  towerl=screwl+12;
	  //translate([polescrewx,polescrewy,polescrewheight]) rotate([0,90,0]) roundedcylinder(screwtowerd,screwl,cornerd,0,90);
	  translate([towerx,polescrewy,polescrewheight]) rotate([0,90,0]) roundedcylinder(screwtowerd,towerl,cornerd,0,90);
	  nutclipcoverheight=polescrewheight-nutcd/2-nutcliplowh-wall;
	  translate([polescrewx-nutclipl-nutclipl-nutclipdepth-wall,polescrewy-wall,nutclipcoverheight]) cube([cut+nutclipdepth+wall*2,nutd*2+wall*2,nutcd+nutcliplowh+wall*2]);
	  translate([polescrewx-nutclipl-nutclipl-nutclipdepth-wall,polescrewy-wall+nutclipcoverheight,0]) cube([cut+nutclipdepth+wall*2,nutd*2+wall*2,nutcd+nutcliplowh+wall*2]);
	  for (x=[polescrewx+screwtowerd,polescrewx-nutclipl-nutclipl-nutclipdepth-wall]) {
	    for (z=[-screwtowerd/2,screwtowerd/2]) {
	      translate([x,polescrewy+screwtowerd/2,polescrewheight+z]) rotate([0,90,0]) roundedcylinder(screwtowerd,screwl-screwtowerd*2,cornerd,0,90);
	    }
	  }
	}
      }

    for (m=[0,1]) mirror([0,m,0]) {
	// Pole cut
	translate([poleoutx,0,-0.1]) cylinder(d=poled,h=poleouth+0.2,$fn=180);

	// Nut space
	if (largeplate) {
	  translate([endh-nuth-0.1,-platew/2+platescrewcorner,endd/2]) rotate([0,90,0]) cylinder(d=nutcd,h=poleouth+0.1,$fn=6);
	  translate([endh,-platew/2+platescrewcorner,endd/2]) rotate([0,90,0]) cylinder(d1=nutcd,d2=nutcd+poleouth,h=poleouth+0.1,$fn=6);

	  // Screw hole
	  hull() {
	    translate([-0.1,-platew/2+platescrewcorner,endd/2]) rotate([0,90,0]) cylinder(d=screwd,h=poleouth+0.2,$fn=90);
	    translate([-0.1,-platew/2+platescrewcorner-screwd/4,endd/2]) cube([poleouth+0.2,screwd/2,screwd/2]);
	  }
	}

	// Pole adapter cut
	translate([poleoutx-polecut/2,-poleoutd-0.1,-0.1]) cube([polecut,poleoutd*2+0.2,poleouth+0.2]);

	// Pole screwhole
	hull() {
	  translate([polescrewholex,polescrewy,polescrewheight]) rotate([0,90,0]) cylinder(d=screwd,h=poleoutd+0.2,$fn=90);
	  translate([polescrewholex,polescrewy-screwd/4,polescrewheight]) cube([poleoutd+0.2,screwd/2,screwd/2]);
	}

	// Pole screw head space
	hull() {
	  translate([polescrewx+screwl-0.01,polescrewy,polescrewheight]) rotate([0,90,0]) cylinder(d=screwheadd,h=screwheadh+poleoutd,$fn=90);
	  translate([polescrewx+screwl-0.01+screwheadd,polescrewy-screwheadd,polescrewheight-screwheadd]) rotate([0,90,0]) cylinder(d=screwheadd,h=screwheadh+poleoutd,$fn=90);
	  translate([polescrewx+screwl-0.01+screwheadd,polescrewy-screwheadd,polescrewheight+screwheadd]) rotate([0,90,0]) cylinder(d=screwheadd,h=screwheadh+poleoutd,$fn=90);
	}

	// Pole nuthole
	difference() {
	  union() {
	    hull() {
	      translate([polescrewx,polescrewy,polescrewheight]) rotate([0,90,0]) cylinder(d=nutcd,h=nuth,$fn=6);
	      translate([polescrewx,0,polescrewheight]) rotate([0,90,0]) cylinder(d=nutcd,h=nuth,$fn=6);
	    }

	    // Pole nuthole insert hole
	    hull() {
	      translate([polescrewx,polescrewy+nutd/2,polescrewheight-nutcd/2]) cube([nuth,nutd,nutcd]);
	      translate([polescrewx-1,polescrewy+nutd/2+nutcd,polescrewheight-nutcd]) cube([nuth+2,nutd,nutcd*2]);
	    }
	  }

	  hull() {
	    translate([polescrewx-nutclipl,polescrewy+nutd/2,polescrewheight-nutcliph/2]) roundedbox(nutclipl+nutclipdepth,nutclipw/2,nutcliph,smallcornerd,0);
	    translate([polescrewx-nutclipl,polescrewy+nutd/2,polescrewheight-nutcliph/2-nutclipl]) roundedbox(nutclipl,nutclipw,nutcliph+nutclipl*2,smallcornerd,0);
	  }
	}

	translate([polescrewx-nutclipl-nutclipl-nutclipdepth,polescrewy,polescrewheight+nutcd/2-cut]) cube([nutclipl*3+nutclipdepth,nutd*2,cut]);
	hull() {
	  translate([polescrewx-nutclipl-nutclipl-nutclipdepth,polescrewy+nutd/2,polescrewheight+nutcd/2-cut]) cube([nutclipl*3+nutclipdepth,nutd,cut]);
	  translate([polescrewx-nutclipl-nutclipl-nutclipdepth,polescrewy+nutd/2+nutd-0.01,polescrewheight+nutcd/2-cut]) cube([nutclipl*3+nutclipdepth,0.01,cut+nutd/2]);
	}
	translate([polescrewx-nutclipl-nutclipl-nutclipdepth,polescrewy,polescrewheight-nutcd/2-nutcliplowh]) cube([cut+nutclipdepth,nutd*2,nutcd+nutcliplowh]);
      }

    translate([poleoutx+poleoutd/2-textdepth+0.01,0,textl/2]) rotate([0,90,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
    translate([poleoutx-textdepth+0.01,0,textdepth-0.01]) rotate([0,0,180]) translate([poled/2+thickwall/2-cornerd/2,0,0]) rotate([0,180,-90]) linear_extrude(textdepth) text(versiontext,size=thickwall-2,font=textfont,valign="center",halign="center");
  }

  if (abs) {
    translate([poleoutx,0,0]) {
      intersection() {
	ring(poleoutd-cornerd,0.4,0.6,0,180);
	translate([poleoutx-polecut/2-0.1,-poleoutd-0.1,-0.1]) cube([polecut+0.2,poleoutd*2+0.2,poleouth+0.2]);
      }
    }
  }
}

module hat() {
  difference() {
    union() {
      hull() {
	translate([hatx,-hatw/2,hatheight+hatoverlap]) roundedbox(hatl,hatw,wall,cornerd,2);
	translate([hatx-0.5*wall*sin(hatangle),-hatw/2,hatheight+hatoverlap+sin(hatangle)*hatl]) rotate([0,hatangle,0]) roundedbox(hatl,hatw,wall,cornerd,2);
      }

      translate([hatx-wall*2-0.5*wall*sin(hatangle),-hatw/2-wall*2,hatheight+hatoverlap+sin(hatangle)*(hatl+wall*2)+xtolerance]) rotate([0,hatangle,0]) {
	difference() {
	  roundedbox(hattopl,hatw+wall*4,wall,cornerd,2);
	  translate([wall,wall,-wall/2]) roundedbox(hattopl-wall*2,hatw+wall*4-wall*2,wall,cornerd,2);
	}
      }
      hull() {
	translate([hatx,-openingw/2+ytolerance,hatheight]) roundedbox(wall,openingw-ytolerance*2,hatoverlap+wall,cornerd,2);
	translate([hatx+wall,-openingw/2+ytolerance,hatheight+wall/2]) roundedbox(wall,openingw-ytolerance*2,hatoverlap+wall-wall/2,cornerd,2);
      }
      for (x=[hatx,hatx+hatl-wall]) {
	translate([x,-hatw/2,hatheight]) roundedbox(wall,hatw,hatoverlap+wall,cornerd,2);
      }
      translate([hatx+hatl-wall,-hatw/2,hatheight-hatcollarh]) roundedbox(wall,hatw,hatoverlap+wall+hatcollarh,cornerd,2);
    
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([hatx,-hatw/2,hatheight-hatcollarh]) roundedbox(hatl,wall,hatoverlap+hatcollarh+wall,cornerd,2);
	  hull() {
	    translate([hatx,-hatw/2,hatheight-hatcollarh]) roundedbox(wall,(hatw-openingw)/2-wall,hatoverlap+hatcollarh+wall,cornerd,2);
	    translate([hatx,-hatw/2,hatheight]) roundedbox(wall,(hatw-openingw)/2,hatoverlap+wall,cornerd,2);
	  }
	}

      // Hat clip
      translate([wall+hatclipd/2-hatclipdepth,0,hatclipheight]) rotate([0,0,90]) tubeclip(hatclipl,hatclipd,0);
    }

    translate([poleoutx,0,-0.1]) cylinder(d=poled,h=holderh*2+0.2,$fn=180);

    translate([hatx+textdepth-0.2,0,hatheight+cornerd/2+0.3]) rotate([90,0,-90]) linear_extrude(textdepth+0.2) text(versiontext,size=textsize-1,font=textfont,valign="bottom",halign="center");
  }
}

module tool() {
  w=nutd+1;
  l=30;
  h=nuth;
  c=0.01;
  thinh=0.6;
  
  translate([-l/2,0,0]) difference() {
    hull() {
      translate([0,-w/2,0]) roundedbox(l-0.8,w,h,c,1);
      translate([l/2,-w/2,0]) roundedbox(l/2-0.8,w,h+thinh*2,c,1);
    }
    translate([0,0,-0.1]) rotate([0,0,360/6/2]) cylinder(d=nutcd,h=nuth+1,$fn=6);
    translate([l,0,thinh]) rotate([0,0,360/6/2]) cylinder(d=nutcd,h=nuth+0.1,$fn=6);

    translate([l/2,0,textdepth-0.01]) rotate([0,180,0]) linear_extrude(textdepth) text(versiontext,size=w-2,font=textfont,valign="center",halign="center");
  }
}

if (print==0) {
  intersection() {
    if (debug==1) translate([0,-platew/2,0]) cube([polescrewx+nuth/2,platew,poleoutd]);
    if (debug==2) translate([-200,-200,-200]) cube([400,200,400]);
    union() {
      difference() {
	union() {
	  plateholder();
	  if (smallplate) translate([0,0,ztolerance]) hat();
	}
#	translate([polescrewx,polescrewy,polescrewheight]) rotate([0,90,0]) cylinder(d=screwd,h=screwl,$fn=90);
      }
    }
  }
 }

if (print==1 || print==5) {
  difference() {
    rotate([0,0,largeplate?45:90]) translate([0.5/2,0,0]) plateholder();
    //#    printareacube("ankermake");
  }
 }

if (print==2) {
  difference() {
    for (r=[45,-45-90]) {
      rotate([0,0,r]) translate([0.5/2+holderl-wall,0,0]) plateholder();
    }
    //#    printareacube("ankermake");
  }
 }

if (print==3) {
  if (debug) translate([0,-platew/2,0]) cube([polescrewx+nuth/2,platew,poleoutd]);
  rotate([0,0,largeplate?45:90]) {
    intersection() {
      translate([0.5/2,0,0]) plateholder();
      //translate([0,-platew/2,0]) cube([poleoutx+poleoutd,platew/2+poleoutd/2+screwtowerd/3,poleh]);
      difference() {
	translate([0,-platew/2,0]) cube([poleoutx,platew,100]);
	translate([0,-platew/2+15,0.8]) cube([poleoutx,platew-30,100]);
      }
    }
  }
 }

if (print==4 || print==5) {
  rotate([0,0,largeplate?45:90]) translate([poleoutx,0,0]) tool();
 }

if (print==5 || print==6) {
  translate([0,-wall*2,0]) rotate([0,180,90]) translate([0,0,-wall]) rotate([0,-hatangle,0]) translate([-(hatx-wall*2-0.5*wall*sin(hatangle)),0,-hatheight-hatoverlap-sin(hatangle)*(hatl+wall*2)-xtolerance]) hat();
 }
