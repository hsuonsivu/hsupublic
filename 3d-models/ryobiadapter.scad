// Copyright 2022-2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// 0=full model, 1=ryobi interface, 2=parkside interface, 3=clips, 4=print all
print=0; 
debug=0;
support=1;

maxbridge=10;
cornerd=1.5;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;
textheight=8;
textdepth=0.7;

wall=1.6; //2-0.8;

screwd=4.3; // M5
screwheadd=12; //8.6; // Round head
screwheadh=3.5;
screwl=32.8;
     
nutd=7;
nuth=3.5;

ryobid=28;
ryobil=33;
ryobidl=11;
ryobih=44.8;

ryobibaseh=8.95;
ryobibased=80; //100;
;
ryobibasel=58.6;
ryobibasew=62-1.8;
ryobibasecornerxyd=5;
ryobibasecornerzd=cornerd;
ryobibasex=ryobid/2-ryobibasel;

parksidel=70; //54.3;
parksidew=70;

sidecontacth=14;
backcontacth=14;
backcontactdepth=2.8;
backcontactw=8.5;
sidecontactx=ryobid/2-25;
sidecontactdepth=2.8;
sidecontactw=8.5;
contactopening=3;

ryobitotalh=ryobih+ryobibaseh;
ryobiconnectorx=ryobid/2-ryobil;

ryobiconnectorcornerd=cornerd;

contactl=19.9; // Total length;
contacth=4.3; // This is 2.5mm cable + crimp
contactw=4.3; // This is 2.5mm cable + crimp
contactbladel=11;
contactbladeh=0.8;
contactbladew=7.9;

// Placement of the contacts (blade)
contactsw=23.7;
  
parksidex=ryobibasex-10;
parksidetoph=13+3;
parksidecontactblockh=7.9;
parksidecontactblockw=31-ytolerance*2; // 38.15;
parksidecontactblockheight=-parksidetoph-parksidecontactblockh;
  
contactz=-parksidetoph-parksidecontactblockh+parksidecontactblockh/2-contactbladew/2;
contactx=parksidex+36-contactbladel;//+22.75;

contactsupportblockl=15;
cableholed=10;
cableholemidw=wall;
cableholew=ryobid-3;

parksidecontactblockx=contactx+contactbladel;

parksideclipl=8;
parksidecliph=5.5;
parksideclipw=24;
parksideclipx=parksidecontactblockx-50;

parksideclipbarl=4;
parksideclipbarw=34;
parksideclipbarx=parksideclipx-parksideclipbarl;

parksidecliparoundl=11;
parksidecliparoundw=44;

parksidenarrowslidew=38.5;
parksidenarrowslideh=5.5;
parksidewideslidew=47;
parksidewideslideh=4.6;

parksidebottomh=parksidewideslideh+parksidenarrowslideh;

parksideslideh=parksidenarrowslideh+parksidewideslideh;

parksideslidel=46.6;
parksideslidex=parksidecontactblockx+16-parksideslidel;
//parksideslidew=11;
parksideslideheight=-parksidetoph-parksidebottomh;
parksideystep=(parksidew-ryobibasew)/2;

clipupperh=parksidetoph+ryobibaseh-wall*2;
clipupperheight=-parksidetoph+wall;
cliph=ryobibaseh+parksidetoph+parksidebottomh-2*wall; // no tolerances
clipx=ryobibasex+12;
clipw=20; //21;
clipdepth=5;
clipupperdepth=clipdepth+3; // Start at bottom of parksidetop (-parksidetoph)
clipuppery=0;
clipopeningdepth=(parksidew-ryobibasew)/2+clipdepth;
cliplowery=parksidew/2-ryobibasew/2;
clipheight=-(parksidetoph+parksidebottomh)+wall;
clipspaceh=cliph+1;
clipspacex=clipx+clipw/2-clipw/2;
clipspacexoffset=clipx-clipspacex;
clipmovement=3.5;
clippressy=cliplowery;
clipwall=3;
clipspringthickness=2;
clippressh=6;
cliphookh=2.5;
cliphookdepth=cliphookh;

clipyposition=ryobibasew/2; // how much outside

clipnotchh=1;
clipnotchdepth=1;
cliplowerh=-clipheight-clipnotchh;
//clipupperh=cliph-cliplowerh;
cliplowerdepth=cliplowery;//2.5;
cliphookheight=ryobibaseh-wall-clipnotchh-cliphookh;

module clipcuts() {
  difference() {
    union() {
      translate([clipx-xtolerance,ryobibasew/2-clipdepth,clipheight-ztolerance]) cube([clipw+xtolerance*2,clipdepth-clipnotchdepth+0.1,cliph+ztolerance*2]);

      difference() {
	translate([clipx-xtolerance,ryobibasew/2-clipupperdepth-ytolerance,clipupperheight-ztolerance]) cube([clipw+xtolerance*2,clipupperdepth-clipnotchdepth+0.1,clipupperh+ztolerance*2]);
	translate([clipx-xtolerance,ryobibasew/2-clipupperdepth-ytolerance,clipupperheight-ztolerance]) triangle(clipw+xtolerance*2,clipupperdepth-clipdepth+ytolerance,clipwall-ytolerance,8);
      }
      
      translate([clipx-xtolerance,ryobibasew/2-clipdepth,clipheight-ztolerance]) cube([clipw+xtolerance*2,clipopeningdepth+0.1,cliph-clipnotchh+ztolerance*2]);
    }

    y=ryobibasew/2-clipdepth+wall;
    depth=parksidew/2-y;
    intersection() {
      union() {
	translate([clipx-xtolerance,y,clipheight-ztolerance]) triangle(clipw/2+xtolerance,depth,clipw/2,2);
	translate([clipx+clipw/2,y,clipheight-ztolerance]) triangle(clipw/2+xtolerance,depth,clipw/2,0);
      }
      translate([clipx-xtolerance,y,clipheight-ztolerance]) triangle(clipw+xtolerance*2,depth,clipw/2,11);
    }
  }
}

module ryobiclip() {
  $fn=30;
  z1=clipheight+parksideystep+clipdepth;
  hull() {
    translate([clipx,ryobibasew/2-clipdepth+ytolerance,clipheight]) roundedbox(clipw,wall,clipwall,cornerd);
    translate([clipx,parksidew/2-clipwall,z1]) roundedbox(clipw,clipwall,clipwall,cornerd);
  }
  hull() {
    translate([clipx,parksidew/2-clipwall,z1]) roundedbox(clipw,clipwall,-z1,cornerd);
    translate([clipx,parksidew/2-clipwall,z1+cornerd]) cube([clipw,clipwall,-z1-cornerd*2]);
  }
  hull() {
    translate([clipx,parksidew/2-clipwall,clipheight+clipw/2-cornerd/2]) roundedbox(clipw,clipwall,clipwall,cornerd);
    translate([clipx+clipw/2,ryobibasew/2-clipdepth+cornerd/2+ytolerance,clipheight+cornerd/2+ztolerance]) sphere(d=cornerd,$fn=30);
    translate([clipx+clipw/2,parksidew/2-cornerd/2,clipheight+cornerd/2+ztolerance]) sphere(d=cornerd,$fn=30);
  }
  translate([clipx,parksidew/2-parksideystep-clipwall,-clipwall]) roundedbox(clipw,cliplowerdepth+clipwall,clipwall,cornerd);
  translate([clipx,ryobibasew/2-clipwall,-clipwall]) roundedbox(clipw,clipwall,clipwall+ryobibaseh-wall-clipnotchh,cornerd);
  translate([clipx,ryobibasew/2-clipwall,-clipwall]) roundedbox(clipw,wall+ytolerance,clipwall+ryobibaseh-wall,cornerd);
  hull() {
    translate([clipx,ryobibasew/2-clipwall,cliphookheight]) roundedbox(clipw,clipwall,cliphookh,cornerd);
    translate([clipx,ryobibasew/2,cliphookheight]) triangle(clipw,cliphookdepth,cliphookh,8);
  }
  springh=clipupperdepth;
  springw=clipupperdepth+parksideystep-clipwall+ytolerance;
  translate([clipx,parksidew/2-clipwall-springw+0.01,z1+springh+clipwall]) rotate([0,90,0]) flatspring(springw,-z1-clipwall*2,clipw,0.8,3,1);
}

module screwholes() {
  translate([0,0,0]) {
      for (x=[ryobibasex+screwd/2/cos(180/6)+cornerd,screwd/2-cornerd*2]) {
      for (y=[-ryobibasew/2+screwd/2+cornerd,ryobibasew/2-screwd/2-cornerd]) {
	translate([x,y,parksideslideheight-0.1]) cylinder(d=screwd,h=max(screwl,-parksideslideheight+ryobibaseh)+0.2,$fn=30); 
	translate([x,y,ryobibaseh-screwheadh]) cylinder(d=screwheadd,h=screwheadh+0.01,$fn=30);
	translate([x,y,parksideslideheight-0.1]) cylinder(d=nutd/cos(180/6),h=nuth+0.1,$fn=6);

	//#translate([x,y,parksideslideheight]) cylinder(d=screwd,h=max(screwl,-parksideslideheight+ryobibaseh)+0.2,$fn=30); 
	//#translate([x,y,ryobibaseh-screwheadh]) cylinder(d=6.82/cos(180/6),h=screwheadh+0.01,$fn=6);
	//#translate([x,y,parksideslideheight]) cylinder(d=nutd/cos(180/6),h=nuth+0.1,$fn=6);
      }
    }
  }
}

module ryobiadapter() {
  difference() {
    union() {
      minkowski() {
	intersection() {
	  hull() {
	    cylinder(d=ryobid-ryobiconnectorcornerd,h=ryobih+ryobibaseh-ryobiconnectorcornerd/2,$fn=90);
	    translate([-ryobidl,0,0]) cylinder(d=ryobid-ryobiconnectorcornerd,h=ryobih+ryobibaseh-ryobiconnectorcornerd/2,$fn=90);
	  }
	  translate([ryobid/2-ryobil+ryobiconnectorcornerd/2,-ryobid/2,0]) cube([ryobil,ryobid,ryobih+ryobibaseh-ryobiconnectorcornerd/2]);
	}

	sphere(d=ryobiconnectorcornerd,$fn=30);
      }

      minkowski() {
	intersection() {
	  translate([ryobid/2-ryobibased/2,0,0]) cylinder(d=ryobibased-ryobiconnectorcornerd/2,h=ryobibaseh-ryobiconnectorcornerd/2,$fn=90);
	  translate([ryobibasex,0,0]) hull() {
	    for (x=[ryobibasecornerxyd/2+ryobiconnectorcornerd/2,ryobibasel-ryobibasecornerxyd/2-ryobiconnectorcornerd/2]) {
	      for (y=[-ryobibasew/2+ryobibasecornerxyd/2+ryobiconnectorcornerd/2,ryobibasew/2-ryobibasecornerxyd/2-ryobiconnectorcornerd/2]) {
		translate([x,y,0]) cylinder(d=ryobibasecornerxyd,h=ryobibaseh-ryobiconnectorcornerd/2,$fn=60);
	      }
	    }
	  }
	}
	sphere(d=ryobiconnectorcornerd,$fn=30);
      }
    }

    hull() {
      lowerh=ryobitotalh-sidecontacth;
      upperh=lowerh+contactopening;
      translate([0,0,-0.01]) intersection() {
	hull() {
	  cylinder(d=ryobid-ryobiconnectorcornerd-wall*5,h=upperh,$fn=90);
	  translate([-ryobidl+wall,0,0]) cylinder(d=ryobid-ryobiconnectorcornerd-wall*5,h=upperh,$fn=90);
	}
	translate([ryobid/2-ryobil+ryobiconnectorcornerd/2+wall*2,-ryobid/2+wall,0]) cube([ryobil-wall*2,ryobid-wall*2,upperh]);
      }

      translate([0,0,-0.01]) intersection() {
	hull() {
	  cylinder(d=ryobid-ryobiconnectorcornerd-wall,h=lowerh,$fn=90);
	  translate([-ryobidl,0,0]) cylinder(d=ryobid-ryobiconnectorcornerd-wall,h=lowerh,$fn=90);
	}
	translate([ryobid/2-ryobil+ryobiconnectorcornerd/2+wall,-ryobid/2+wall,0]) cube([ryobil-wall*2,ryobid-wall*2,lowerh]);
      }
    }
    
    translate([0,0,-0.01]) intersection() {
      hull() {
	cylinder(d=ryobid-ryobiconnectorcornerd-wall*5,h=ryobih+ryobibaseh-ryobiconnectorcornerd/2-wall,$fn=90);
	translate([-ryobidl,0,0]) cylinder(d=ryobid-ryobiconnectorcornerd-wall*5,h=ryobih+ryobibaseh-ryobiconnectorcornerd/2-wall,$fn=90);
      }
      translate([ryobid/2-ryobil+ryobiconnectorcornerd/2+wall*3,-ryobid/2+wall*2,0]) cube([ryobil-wall*4,ryobid-wall*4,ryobih+ryobibaseh-ryobiconnectorcornerd/2-wall]);
    }

    translate([ryobiconnectorx-0.1,-backcontactw/2,ryobitotalh-backcontacth]) cube([backcontactdepth+0.1,backcontactw,backcontacth]);
    translate([ryobiconnectorx-0.1,-backcontactw/2,ryobitotalh-backcontacth]) cube([backcontactdepth+wall+0.1,backcontactw,contactopening]);

    for (y=[-ryobid/2-0.1,ryobid/2-sidecontactdepth]) {
      translate([sidecontactx,y,ryobitotalh-sidecontacth]) cube([sidecontactw,sidecontactdepth+0.1,sidecontacth]);
      translate([sidecontactx,y-wall,ryobitotalh-sidecontacth]) cube([sidecontactw,sidecontactdepth+wall*2+0.1,contactopening]);
    }

    translate([sidecontactx+sidecontactw/2,ryobid/2-sidecontactdepth-textheight/2,ryobih+ryobibaseh-textdepth+0.01]) linear_extrude(textdepth) text("-",halign="center",valign="center");
    translate([sidecontactx+sidecontactw/2,-ryobid/2+sidecontactdepth+textheight/2,ryobih+ryobibaseh-textdepth+0.01]) linear_extrude(textdepth) text("+",halign="center",valign="center");

    clipcuts();
    mirror([0,1,0]) clipcuts();

    if (0) {for (y=[-ryobibasew/2-0.1,ryobibasew/2-clipdepth]) {
      translate([clipx-xtolerance,y,clipheight]) cube([clipw+xtolerance*2,clipdepth+0.1,cliph+ztolerance]);
    }
    for (y=[-ryobibasew/2+clipnotchdepth,ryobibasew/2-clipdepth]) {
      translate([clipx-xtolerance,y,clipheight]) cube([clipw+xtolerance*2,clipdepth-clipnotchdepth+0.1,cliph+clipnotchh+ztolerance]);
    }
    }

    translate([ryobibasex-0.1,-ryobibasew/2-0.1,-ryobiconnectorcornerd-0.1]) cube([ryobibasel+0.2,ryobibasew+0.2,ryobiconnectorcornerd+0.1]);

    screwholes();
  }

  if (support) {
    translate([clipx+1,ryobibasew/2-clipnotchdepth,0]) supportbox(clipw-2,clipnotchdepth,ryobibaseh-wall-clipnotchh+ztolerance,1);
    mirror([0,1,0]) translate([clipx+1,ryobibasew/2-clipnotchdepth,0]) supportbox(clipw-2,clipnotchdepth,ryobibaseh-wall-clipnotchh+ztolerance,1);
  }
}

module contact() {
  translate([0,0,0]) cube([contactbladel,contactbladeh,contactbladew]);
  translate([contactbladel,contacth/2,contactbladew/2]) rotate([0,90,0]) cylinder(d=contacth,h=contactl-contactbladel,$fn=30);
}

module parksideadapter() {
  difference() {
    union() {
      difference() {
	translate([parksidex,-parksidew/2,-parksidetoph]) roundedbox(parksidel,parksidew,parksidetoph,cornerd);
	hull() {
	  for (y=[-cableholew/2+cableholed/2,cableholew/2-cableholed/2]) {
	    translate([contactx+contactbladel+contactsupportblockl+cableholed/2,y,-parksidetoph-0.1]) cylinder(d=cableholed,h=parksidetoph+0.2,$fn=30);
	  }
	  
	  translate([contactx+contactbladel+contactsupportblockl,-cableholew/2+cableholed/3,-parksidetoph-0.1]) cube([cableholed/2,cableholew-cableholed*2/3,parksidetoph+0.2]);
	}
      }

      difference() {
	hull() {
	  translate([parksideclipbarx,-parksideclipbarw/2,-parksidetoph]) roundedbox(parksideclipbarl,parksideclipbarw,parksidetoph,cornerd,1);
	  translate([parksideclipbarx+parksidecliparoundl,-parksidecliparoundw/2,-parksidetoph]) roundedbox(parksidecliparoundl,parksidecliparoundw,parksidetoph,cornerd,1);
	}

	translate([parksideclipx,-parksideclipw/2,-parksidetoph-cornerd]) roundedbox(parksideclipl,parksideclipw,parksidecliph+cornerd,cornerd,0);
      }
	
      translate([parksidecontactblockx,-parksidecontactblockw/2,parksidecontactblockheight]) roundedbox(contactsupportblockl,parksidecontactblockw,parksidecontactblockh+cornerd,cornerd);

      for (y=[-cableholemidw/2,-parksidecontactblockw/2,parksidecontactblockw/2-cableholemidw]) {
	translate([parksidecontactblockx,y,parksidecontactblockheight]) roundedbox(contactsupportblockl+cableholed+cornerd,cableholemidw,parksidecontactblockh+parksidetoph,cornerd);
      }

      for (y=[-parksidew/2,parksidewideslidew/2]) {
	translate([parksideslidex,y,parksideslideheight+parksidewideslideh-cornerd/2]) roundedbox(parksideslidel+cornerd,(parksidew-parksidewideslidew)/2,parksidewideslideh+cornerd*2,cornerd,0);
      }
      for (y=[-parksidew/2,parksidenarrowslidew/2]) {
	translate([parksideslidex,y,parksideslideheight]) roundedbox(parksideslidel+cornerd,(parksidew-parksidenarrowslidew)/2,parksidewideslideh,cornerd,0);
      }

      if (support) {
	for (y=[-parksidenarrowslidew/2-(parksidewideslidew-parksidenarrowslidew)/2+1-cornerd/2+1,parksidenarrowslidew/2+cornerd/2]) {
	  translate([parksideslidex+cornerd/2-0.2,y,parksideslideheight+parksidewideslideh]) supportbox(parksideslidel-cornerd*2,(parksidewideslidew-parksidenarrowslidew)/2-2,parksidenarrowslideh);
	}
      }

      extendl=parksidenarrowslideh+parksidewideslideh;
      for (y=[-parksidew/2,parksidewideslidew/2]) {
	hull() {
	  translate([parksideslidex-extendl,y,-parksidetoph]) roundedbox(parksideslidel+extendl,(parksidew-parksidewideslidew)/2,parksidetoph,cornerd,0);
	  translate([parksideslidex,y,parksideslideheight]) roundedbox(parksideslidel,(parksidew-parksidewideslidew)/2,cornerd,cornerd,0);
	}
      }

      for (y=[-parksidew/2,parksidewideslidew/2]) {
	  translate([parksidex+extendl,y,parksideslideheight]) roundedbox(parksidel-extendl,(parksidew-parksidewideslidew)/2,parksideslideh+cornerd,cornerd,0);
      }
      
      for (y=[-parksidew/2,parksidew/2-(parksidew-parksidecontactblockw)/2-cableholemidw]) {
	x=parksideslidex+parksideslidel;
	translate([x,y,parksideslideheight]) roundedbox(parksidex+parksidel-x,(parksidew-parksidecontactblockw)/2+cableholemidw,parksideslideh+cornerd,cornerd,0);
      }

      translate([parksidex+parksidel-wall,-parksidew/2,parksideslideheight]) roundedbox(wall,parksidew,parksideslideh+cornerd,cornerd,0);
      
      translate([parksideslidex-extendl,-parksidew/2,-parksidetoph]) roundedbox(parksideslidel+extendl,parksidew,parksidetoph,cornerd,0);
    }

    clipcuts();
    mirror([0,1,0]) clipcuts();
    
    for (y=[-contactsw/2+contacth/2-xtolerance,contactsw/2-contacth/2-contactbladeh+xtolerance]) {
      translate([contactx+contactbladel-0.1,y,contactz+contactbladew/2]) rotate([0,90,0]) cylinder(d=contacth+dtolerance,h=contactsupportblockl+0.2,$fn=60);
    }

    translate([contactx+contactbladel+contactsupportblockl/2,ryobid/2-sidecontactdepth-1,parksidecontactblockheight-0.01]) linear_extrude(textdepth) text("+",halign="center",valign="center");
    translate([contactx+contactbladel+contactsupportblockl/2,-ryobid/2+sidecontactdepth+1,parksidecontactblockheight-0.01]) linear_extrude(textdepth) text("-",halign="center",valign="center");

    screwholes();
    
    //#  translate([contactx,-contactsw/2-contactbladeh/2,contactz])  contact();
    //#  translate([contactx,contactsw/2-contactbladeh/2,contactz]) mirror([0,1,0])  contact();
  }
}

if (print==0) {
  intersection() {
    union() {
      ryobiadapter();
      //      translate([clipx,-clipyposition,clipheight])
      ryobiclip();
      // translate([clipx,clipyposition,clipheight])
      mirror([0,1,0]) ryobiclip();
      
      parksideadapter();
    }
    if (debug) translate([-100,0,-100]) cube([80,200,120]);
  }
 }

if (print==1 || print==4) {
  ryobiadapter();
 }

if (print==2 || print==4) {
  translate([ryobid/2+(parksidex+parksidel)+0.5,0,0]) rotate([180,0,180]) parksideadapter();
 }

if (print==3 || print==4) {
  translate([ryobid/2+(parksidex+parksidel)+0.5,parksidew+parksidebottomh+wall+clipwall,0]) rotate([0,-90,-90]) translate([-clipx,-parksidew/2,clipheight]) ryobiclip();
  translate([ryobid/2+(parksidex+parksidel)+0.5+0.5,parksidew+parksidebottomh+wall+clipwall,0]) mirror([1,0,0]) rotate([0,-90,-90]) translate([-clipx,-parksidew/2,clipheight]) ryobiclip();
 }
