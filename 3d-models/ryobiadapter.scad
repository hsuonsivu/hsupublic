// Copyright 2022-2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

// 0=full model, 1=ryobi interface, 2=parkside interface, 3=clips, 4=print all, 5=electrical inside body, 6=bottom part of parkside,
// 7=protection circuit board (for debugging)
print=5;
debug=1;
//debugon=1;
debugon=print==0?debug:0;
support=1;

versiontext=str("V1.3");

maxbridge=10;
cornerd=1.5;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;
plugtolerance=0.3;

textsize=7;
textdepth=0.7;

wall=1.6; //2-0.8;

screwd=4.4; // M5
screwheadd=12; //8.6; // Round head
screwheadh=4.7;
screwl=32.8;
     
nutd=7;
nuth=2.3;

ryobid=28;
ryobil=33;
ryobidl=10.5; //11;
ryobih=44.3; // 44.8;

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

contactl=19.9; // Total length;
contacth=4.3; // This is 2.5mm cable + crimp
contactw=4.3; // This is 2.5mm cable + crimp
contactbladel=11;
contactbladeh=0.8;
contactbladew=7.9;
contactoffset=contacth/2-contactbladeh/2;

sidecontacth=14;
backcontacth=14;
backcontactdepth=2.8;
backcontactw=8.5;
sidecontactx=ryobid/2-25;
sidecontactdepth=2.8;//2.8;
uppercontactoffset=wall-contactbladeh+contactbladeh+ytolerance+0.28;//+0.28;
sidecontactw=8.5;
contactopening=3;
ryobicontacttopshift=4;
ryobitotalh=ryobih+ryobibaseh;
ryobiconnectorx=ryobid/2-ryobil;

ryobiconnectorcornerd=cornerd;

// Placement of the contacts (blade) in lower
contactsw=24;

// Ryobi placement is slightly (24.2) but this is close enough. 
ryobicontactsw=24;
  
parksidex=ryobibasex-10;
parksidetoph=13+3;
parksidecontactblockh=7.9;
parksidecontactblockw=31-ytolerance*2; // 38.15;
parksidecontactblockheight=-parksidetoph-parksidecontactblockh;

contactheightinblock=parksidecontactblockh/2-contactbladew/2;
contactz=-parksidetoph-parksidecontactblockh+contactheightinblock;
contactx=parksidex+36-contactbladel;//+22.75;

contactsupportblockl=32; // 15;
cableholed=10;
cableholemidw=wall;
cableholew=ryobid-5;
electronicsareaconnectorsl=ryobidl+1;

cablingspacex=0;
cablingspaced=ryobid-10;

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
parksideh=parksidetoph+parksidebottomh;
parksideheight=-parksideh;
parksidebottomheight=-parksidetoph-parksidebottomh;
parksidewideslideheight=parksidebottomheight+parksidewideslideh;

parksideslideh=parksidenarrowslideh+parksidewideslideh;

parksideslidel= 47.9; //46.6;
parksideslidex=parksidecontactblockx+16-parksideslidel;

parksideadaptersplith=parksidewideslideh;
  
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
clipspringtension=1; // Slight oversize to prestress the spring
clippressh=6;
cliphookh=2.5;
cliphookdepth=cliphookh;
cliphookextend=0.5;

clipyposition=ryobibasew/2; // how much outside

clipnotchh=1;
clipnotchdepth=1;
cliplowerh=-clipheight-clipnotchh;
//clipupperh=cliph-cliplowerh;
cliplowerdepth=cliplowery;//2.5;
cliphookheight=ryobibaseh-wall-clipnotchh-cliphookh;

// Voltage protection circuit xh-m609
// Items from top
// wall, pcunderh,ztolerance,pcpcbh,pch-pcpcbh,freeh,wall
// area height is
// parksideh-wall-wall
// bottom tower should be this 
// wall, freeh, pch-pcpcbh, ztolerance
// top tower should be this
// pcunderh+wall
// height from top  should be top-wall-pcunderh
// h of tower from bottom  should wall+freeh+pch-pcpcbh-ztolerance
// height from bottom should be wall+freeh+pch-pcpcbh+ztolerance+pcpcbh+ztolerance
// pcb should be at height wall+freeh+pch-pcpcbh

pcw=57.2;
pcl=42.15;
pcunderh=3; // Sticking out pins under the board
pch=16.6; // Total height including pcb
pcpcbh=1.5; // PCB thickness
pcbtolerance=0.5;
protectionspaceh=parksideh-wall-wall;
freeh=parksideh-wall-pcunderh-ztolerance-pch;

pcx=screwd+6+pcbtolerance;
protectioncablespacex=parksideslidex+parksideslidel+cornerd+wall;
pcextensionl=pcx-(-parksideclipbarx-parksidel);
pcxtoparksidebodyend=(parksidex+parksidel)-pcx;
  
pcy=0; // Centered
pcheight=parksidebottomheight+wall+freeh;
pcscrewdistance=3; // From both edges, center
pcscrewholed=3.0; // 3.4; Screw holes on pcb
pcscrewd=2.5;
pcscrewholeextra=5;
pcscrewsupportd=6;
pcdisplayw=23;
pcdisplayl=14.3;
pcdisplayh=9.1-pcpcbh;
pcdisplayx=23.25-pcdisplayl;
pcdisplayy=6.6;
pcdisplayopenw=1;
pcdisplayopendown=1;

pcconnectorw=10.7;
pcconnectorl=10.2;
pcconnectorh=14.4;
pcconnectory=6.45;
pcconnectorx=1.3;
pcconnectorholew=2.2;
pcconnectorholeh=3;
pcconnectorholez=1.75;
pcconnectorspacew=pcw-pcconnectory*2;
pcrelayw=12;
pcrelayl=15.2;
pcrelayh=15; // (including pcb)
pcrelayx=1.4;
pcrelayy=22.4;

pcbutton2y=11.9; // "-" button
pcbutton1y=24; // "+" button
pcbuttonx=3.7;
pcbuttond=3.5;
buttondtolerance=0.7;
pcbuttonbasew=6;
pcbuttonbasel=6;
pcbuttonbaseh=5.6-pcpcbh;
pcbuttonh=6.54-pcpcbh;

pcbuttonpresserd=6;
pcbuttonpressershaftd=4;
pcbuttonpresserxoffset=0.0;
pcbuttonpressermovement=1;
pcbuttonpressermid=5;

fromtoptobuttons=wall+ztolerance+pcunderh+pcpcbh+pcbuttonh;
bottomtobuttons=parksideh-fromtoptobuttons;
  

module pcconnector() {
  difference() {
    cube([pcconnectorl,pcconnectorw,pcconnectorh]);
    for (y=[pcconnectorw/2-pcconnectorw/4-pcconnectorholew/2,pcconnectorw/2+pcconnectorw/4-pcconnectorholew/2]) {
    translate([-0.1,y,pcconnectorholez]) cube([pcconnectorl+0.2,pcconnectorholew,pcconnectorholeh]);
    }
  }
}

// Centered at button
module pcbutton() {
  translate([-pcbuttonbasel/2,-pcbuttonbasew/2,0]) {
    cube([pcbuttonbasel,pcbuttonbasew,pcbuttonbaseh]);
  }
  cylinder(d=pcbuttond,h=pcbuttonh,$fn=30);
}

module pcbuttonpresser(t) {
  hull() {
    translate([pcbuttonpresserxoffset,0,parksideheight-0.1]) cylinder(d=pcbuttonpresserd+t,h=wall+pcbuttonpressermovement+0.2,$fn=30);
    translate([0,0,parksideheight+pcbuttonpressermid]) cylinder(d=pcbuttonpressershaftd+t,h=pcbuttonpressermovement,$fn=30);
  }
  hull() {
    translate([0,0,parksideheight+pcbuttonpressermid]) cylinder(d=pcbuttonpressershaftd+t,h=pcbuttonpressermovement,$fn=30);
    translate([0,0,parksideheight+bottomtobuttons-pcbuttonpressermid]) cylinder(d=pcbuttonpressershaftd+t,h=pcbuttonpressermovement,$fn=30);
  }
  hull() {
    translate([0,0,parksideheight+bottomtobuttons-pcbuttonpressermid]) cylinder(d=pcbuttonpressershaftd+t,h=pcbuttonpressermovement,$fn=30);
    translate([0,0,parksideheight+bottomtobuttons-wall-pcbuttonpressermovement]) cylinder(d=pcbuttonpresserd+t,h=wall+pcbuttonpressermovement-ztolerance,$fn=30);
  }
}

// Centered on y axis, x 0 at connector edge, z 0 at pcb bottom (not includes pins coming under)
module protectionboard() {
  difference() {
    translate([0,-pcw/2,0]) cube([pcl,pcw,pcpcbh]);
    for (x=[pcscrewdistance,pcl-pcscrewdistance]) {
      for (y=[-pcw/2+pcscrewdistance,pcw/2-pcscrewdistance]) {
	translate([x,y,-0.1]) cylinder(d=pcscrewholed,h=pcpcbh+0.2,$fn=30);
      }
    }
  }
  
  for (y=[-pcw/2+pcconnectory,pcw/2-pcconnectory-pcconnectorw]) {
    translate([pcconnectorx,y,pcpcbh]) pcconnector();
  }

  translate([pcrelayx,-pcw/2+pcrelayy,0]) cube([pcrelayl,pcrelayw,pcrelayh]);

  // Display
  translate([pcl-pcdisplayx-pcdisplayl,pcw/2-pcdisplayy-pcdisplayw,pcpcbh]) {
    cube([pcdisplayl,pcdisplayw,pcdisplayh]);
  }

  // Buttons
  for (y=[pcw/2-pcbutton1y,pcw/2-pcbutton2y]) {
    translate([pcl-pcbuttonx,y,pcpcbh]) pcbutton();
  }
}

module protectionboardstandsupper() {
  // pcb stands, upper part
  for (x=[pcx+pcscrewdistance,pcx+pcl-pcscrewdistance]) {
    for (y=[-pcw/2+pcscrewdistance,pcw/2-pcscrewdistance]) {
      translate([x,y,-wall-pcunderh]) {
	hull() {
	  for (xx=[(x>parksidex+parksidel)?wall:-wall,0]) {
	    for (yy=[-(y<0?wall:-wall),0]) {
	      translate([xx,yy,0]) cylinder(d=pcscrewsupportd,h=pcunderh+ztolerance+0.1,$fn=30);
	    }
	  }
	}
      }

      translate([x,y,-wall-pcunderh-ztolerance-pcpcbh]) {
	hull() {
	  cylinder(d=pcscrewd,h=ztolerance+pcpcbh+ztolerance+0.1,$fn=30);
	  translate([0,0,-pcscrewd/2]) cylinder(d=pcscrewd/2,h=ztolerance+pcpcbh+ztolerance*2-pcscrewd/2,$fn=30);
	}
      }
    }
  }
}

module protectionboardstandslower() {
    for (x=[pcx+pcscrewdistance,pcx+pcl-pcscrewdistance]) {
      for (y=[-pcw/2+pcscrewdistance,pcw/2-pcscrewdistance]) {
	difference() {
	  union() {
	    translate([x,y,parksideheight]) {
	      // tower h from space bottom
	      hh=freeh+pch-pcpcbh-ztolerance; // ztolerance+pch-pcpcbh+wall+cornerd/2;
	      hull() {
		for (xx=[x>parksidex+parksidel?0:0,0]) {
		  for (yy=[0,0]) {
		    offset=(x>pcx+pcl/2)?-pcscrewsupportd/2:pcscrewsupportd/2;
		    hull() {
		      translate([xx,yy,wall-0.1]) cylinder(d=pcscrewsupportd,h=-wall+hh+0.1,$fn=30);
		      translate([xx-pcscrewsupportd/2+offset,yy-pcscrewsupportd/2,wall-cornerd/2]) roundedbox(pcscrewsupportd,pcscrewsupportd,-wall+hh+cornerd/2,cornerd);
		    }
		  }
		}
	      }
	    }
	  }

	  translate([x,y,-wall-ztolerance-pcunderh-pcpcbh-ztolerance-pcscrewholeextra]) {
	    cylinder(d=pcscrewholed,h=pcscrewholeextra+ztolerance+0.11,$fn=30);
	  }
	}
      }
    }
}

// This opens only insides of parkside body and wall
module protectionboardcut() {
  // Opening for protection circuit area
  difference() {
    union() {
      translate([pcx-pcbtolerance, -pcw/2-pcbtolerance,-wall-ztolerance-pcunderh-pch-ztolerance]) cube([pcxtoparksidebodyend+pcbtolerance+0.01,pcw+pcbtolerance*2,ztolerance+pcunderh+pch+ztolerance]);
      translate([protectioncablespacex-xtolerance,-pcconnectorspacew/2-ytolerance,-wall-ztolerance-pcunderh-pch-ztolerance]) cube([pcx-protectioncablespacex+xtolerance*2,pcconnectorspacew+ytolerance*2,pch-pcpcbh+ztolerance]);
    }
  }
}

module clipcuts() {
  difference() {
    union() {
      translate([clipx-xtolerance,ryobibasew/2-clipdepth,clipheight-ztolerance]) cube([clipw+xtolerance*2,clipdepth-clipnotchdepth,cliph+ztolerance*2]);

      difference() {
	translate([clipx-xtolerance,ryobibasew/2-clipupperdepth-ytolerance,clipupperheight-ztolerance]) cube([clipw+xtolerance*2,clipupperdepth-clipnotchdepth,clipupperh+ztolerance*2]);
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
  difference() {
    union() {
      hull() {
	translate([clipx,ryobibasew/2-clipdepth+ytolerance,clipheight]) roundedbox(clipw,wall,clipwall,cornerd);
	translate([clipx,parksidew/2-clipwall,z1]) cube([clipw,clipwall,clipwall]); //roundedbox(clipw,clipwall,clipwall,cornerd);
      }
      hull() {
	translate([clipx,parksidew/2-clipwall,z1]) roundedbox(clipw,clipwall,-z1,cornerd);
	translate([clipx,parksidew/2-clipwall,z1+cornerd]) cube([clipw,clipwall,-z1-cornerd*2]);
      }
      hull() {
	translate([clipx,parksidew/2-clipwall,clipheight+clipw/2]) cube([clipw,clipwall,clipwall]); // roundedbox(clipw,clipwall,clipwall,cornerd);
	translate([clipx+clipw/2,ryobibasew/2-clipdepth+cornerd/2+ytolerance,clipheight+cornerd/2+ztolerance]) sphere(d=cornerd,$fn=30);
	translate([clipx+clipw/2,parksidew/2-cornerd/2,clipheight+cornerd/2+ztolerance]) sphere(d=cornerd,$fn=30);
      }
      translate([clipx,parksidew/2-parksideystep-clipwall,-clipwall]) roundedbox(clipw,cliplowerdepth+clipwall,clipwall,cornerd);
      translate([clipx,ryobibasew/2-clipwall,-clipwall]) roundedbox(clipw,clipwall,clipwall+ryobibaseh-wall-clipnotchh,cornerd);
      translate([clipx,ryobibasew/2-clipwall,-clipwall]) roundedbox(clipw,wall+ytolerance,clipwall+ryobibaseh-wall-ztolerance,cornerd);
      hull() {
	translate([clipx,ryobibasew/2-clipwall,cliphookheight]) roundedbox(clipw,clipwall,cliphookh,cornerd);
	translate([clipx,ryobibasew/2+cliphookextend,cliphookheight]) triangle(clipw,cliphookdepth,cliphookh,8);
      }
      springh=clipupperdepth;
      springw=clipupperdepth+parksideystep-clipwall+ytolerance;
      translate([clipx,parksidew/2-clipwall-springw-clipspringtension+0.01,z1+springh+clipwall]) rotate([0,90,0]) flatspring(springw+clipspringtension,-z1-clipwall*2,clipw,0.8,3,1);
    }

    translate([clipx+clipw/2,parksidew/2-textdepth+0.01,z1]) rotate([90,0,180]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
  }
}

module screwholes() {
  translate([0,0,0]) {
      for (x=[ryobibasex+screwd/2/cos(180/6)+cornerd,screwd/2-cornerd*2]) {
      for (y=[-ryobibasew/2+screwd/2+cornerd,ryobibasew/2-screwd/2-cornerd]) {
	translate([x,y,parksideslideheight-0.1]) cylinder(d=screwd,h=max(screwl,-parksideslideheight+ryobibaseh)+0.2,$fn=30); 
	translate([x,y,ryobibaseh-screwheadh]) cylinder(d=screwheadd,h=screwheadh+0.01,$fn=30);
	hull() {
	  translate([x,y,parksideslideheight-0.1]) cylinder(d=nutd/cos(180/6),h=nuth+0.1,$fn=6);
	  // Improve printability
	  translate([x,y,parksideslideheight]) cylinder(d=screwd,h=nuth+(nutd/screwd),$fn=30);
	}

	//#translate([x,y,parksideslideheight]) cylinder(d=screwd,h=max(screwl,-parksideslideheight+ryobibaseh)+0.2,$fn=30); 
	//#translate([x,y,ryobibaseh-screwheadh]) cylinder(d=6.82/cos(180/6),h=screwheadh+0.01,$fn=6);
	//#translate([x,y,parksideslideheight]) cylinder(d=nutd/cos(180/6),h=nuth+0.1,$fn=6);
      }
    }
  }
}

// Cut inside of the ryobi plug (tolerance = 0 for cutout
module ryobicut(tolerance,downextension,noupper) {
  lowerh=ryobitotalh-sidecontacth+parksidetoph+downextension;
  upperh=lowerh+contactopening;
  allh=upperh+sidecontacth-contactopening-wall;
  hull() {
    // Narrower cut to top, helps with printability and is needed for openings
    translate([0,0,-parksidetoph-downextension-0.01]) intersection() {
      hull() {
	cylinder(d=ryobid-wall*5-tolerance*2,h=upperh+0.01-tolerance,$fn=90);
	translate([-ryobidl+wall,0,0]) cylinder(d=ryobid-wall*5-tolerance*2,h=upperh+0.01-tolerance,$fn=90);
      }
      translate([ryobid/2-ryobil+wall+backcontactdepth+xtolerance+tolerance,-ryobid/2+wall+tolerance,0]) cube([ryobil-wall*2-tolerance*2,ryobid-wall*2-tolerance*2,upperh+0.01-tolerance]);
    }

    // Wider cut for lower part
    translate([0,0,-parksidetoph-downextension-0.01]) intersection() {
      hull() {
	cylinder(d=ryobid-wall*2-tolerance*2,h=lowerh+0.01-tolerance,$fn=90);
	translate([-ryobidl,0,0]) cylinder(d=ryobid-wall*2-tolerance*2,h=lowerh+0.01-tolerance,$fn=90);
      }
      translate([ryobid/2-ryobil+wall+tolerance,-ryobid/2+wall+tolerance,0]) cube([ryobil-wall*2-tolerance*2,ryobid-wall*2-tolerance*2,lowerh-0.01]);
    }
  }

  // Narrow cut to the top
  if (!tolerance) {
    hull() 
    for (h=[0,sidecontacth/2]) {
      topreduction=h?0:sidecontacth;
      translate([0,0,-parksidetoph-downextension-0.01]) intersection() {
	hull() {
	  cylinder(d=ryobid-wall*5-tolerance*2-topreduction/2,h=allh-h-0.01-tolerance,$fn=90);
	  translate([-ryobidl+wall,0,0]) cylinder(d=ryobid-wall*5-tolerance*2-topreduction/2,h=allh-h+0.01-tolerance,$fn=90);
	}
	l=ryobil-topreduction-wall*2-tolerance*2;
	w=ryobid-topreduction-wall*4;
	translate([ryobid/2-ryobil+wall+backcontactdepth+xtolerance+topreduction/2+tolerance,-w/2,0]) cube([l,w,allh-h+0.01-tolerance]);
      }
    }
  }
}

module contact() {
  translate([0,-contactbladeh/2,0]) cube([contactbladel,contactbladeh,contactbladew]);
  translate([contactbladel,contactoffset,contactbladew/2]) rotate([0,90,0]) cylinder(d=contacth,h=contactl-contactbladel,$fn=30);
}

module showcontacts() {
  // Parkside contacts
  #for (m=[0,1]) mirror([0,m,0]) translate([contactx,contactsw/2,contactz]) translate([0,0,contactbladew]) rotate([180,0,0]) contact();
  // Ryobi contacts
  #for (m=[0,1]) mirror([0,m,0]) translate([sidecontactx+sidecontactw/2-contactbladew/2,-ryobid/2+uppercontactoffset,ryobitotalh-sidecontacth+contactbladel+0.01]) rotate([0,90,0]) contact();
}

module contactcut(printable) {
  t=dtolerance;
  xd=contacth+t;
  l=contactl-contactbladel;
  translate([0.8,-contactbladeh/2-t/4,-t/4]) cube([contactbladel+0.8,contactbladeh+t/2,contactbladew+t/2]);
  translate([contactbladel,contactoffset, contactbladew/2]) rotate([0,90,0]) hull() {
    cylinder(d=xd,h=l+0.2,$fn=90);
    if (printable) translate([-xd/2,-xd/4,0]) cube([xd/2,xd/2,l+0.2]);
  }
}

module electronicsarea() {
  w=contactsw-contactbladeh/2-wall;
  difference() {
    hull() {
      for (y=[-w/2+cablingspaced/2,w/2-cablingspaced/2]) {
	translate([cablingspacex,y,parksidecontactblockheight-0.1]) cylinder(d=cablingspaced,h=parksidecontactblockh+parksidetoph-wall);
      }
      translate([-ryobidl,-w/2,contactz]) cube([electronicsareaconnectorsl,w,parksidecontactblockh+parksidetoph-wall]);
    }
    translate([-ryobidl,-w/2-0.1,contactz-0.1]) cube([1,w+0.2,wall+0.2]);
  }
}

module sidecontactcuts() {
  // Cut openings for side contacts
  for (m=[0,1]) mirror([0,m,0]) {
      translate([sidecontactx,ryobid/2-sidecontactdepth,ryobitotalh-sidecontacth]) cube([sidecontactw,sidecontactdepth+0.1,sidecontacth]);
      translate([sidecontactx,ryobid/2-sidecontactdepth-contacth,ryobitotalh-sidecontacth-ztolerance]) cube([sidecontactw,sidecontactdepth+contacth+dtolerance+ytolerance+wall,contactopening]);
      translate([sidecontactx,ryobid/2-sidecontactdepth-contacth,ryobitotalh-sidecontacth-ztolerance]) triangle(sidecontactw,sidecontactdepth+contacth,contactopening+sidecontactdepth,11);
      //      translate([sidecontactx,ryobid/2-sidecontactdepth-contacth,ryobitotalh-sidecontacth]) triangle(sidecontactw,sidecontactdepth+contacth,contactopening+sidecontactdepth,11);
    }
}

module topcontactholecut() {
  for (m=[0,1]) mirror([0,m,0]) {
      translate([sidecontactx+sidecontactw/2-contactbladew/2,-ryobid/2+uppercontactoffset,ryobitotalh-sidecontacth+contactbladel+0.01]) rotate([0,90,0]) contactcut(0);
    }
}

if (print==0) {
  if (0) translate([0,-100,0]) {
    difference() {
      translate([contactbladel+0.01,-50,-10]) cube([50,100,50]);
      contactcut(0);
      translate([0,10,0]) contactcut(1);

      #contact();
      #translate([0,10,0]) contact();
    }
  }
 }

module ryobielectronicsplug() {
  difference() {
    union() {
      ryobicut(plugtolerance,0.3);

      // Connector block
      translate([parksidecontactblockx,-parksidecontactblockw/2,parksidecontactblockheight]) roundedbox(contactsupportblockl,parksidecontactblockw,parksidecontactblockh-ztolerance,cornerd);
    }
    
    // Connector holes for parkside connector
    l=contactl-contactbladel+ryobidl-2;
    for (m=[0,1]) mirror([0,m,0]) {
	translate([contactx-0.1,-contactsw/2,contactz]) contactcut(1);
	offset=2;
	hull() {
	  for (a=[0,contacth]) {
	    translate([-ryobidl,contactsw/2-contactoffset-a,contactz+contactbladew/2+a]) rotate([0,90,0]) cylinder(d=contacth+dtolerance,h=offset,$fn=60);
	    translate([-ryobidl+offset,contactsw/2-contactoffset-a,contactz+contactbladew/2+a]) rotate([0,90,0]) cylinder(d1=contacth+dtolerance,h=electronicsareaconnectorsl-offset,$fn=60);
	  //translate([-ryobidl,contactsw/2-contactoffset-contacth,contactz+contactbladew/2+contacth]) rotate([0,90,0]) cylinder(d1=contacth+dtolerance,h=electronicsareaconnectorsl-contacth,$fn=30);
	  }
	}
      }

    // Connector holes for ryobi connector
    for (m=[0,1]) mirror([0,m,0]) {
	topcontactholecut();
	
	hull() { //sidecontactdepth+xtolerance+dtolerance/2+contactoffset
	  translate([sidecontactx+sidecontactw/2,-ryobid/2+uppercontactoffset+contactoffset,ryobitotalh-sidecontacth-contactl+contactbladel]) cylinder(d=contacth+dtolerance,h=0.1,$fn=30);
	  translate([sidecontactx+sidecontactw/2,-ryobid/2+uppercontactoffset+contactoffset+wall/2+dtolerance,ryobitotalh-sidecontacth-contactl+contactbladel-ryobicontacttopshift]) cylinder(d=contacth+dtolerance,h=0.1,$fn=30);
	}
	hull() { //sidecontactdepth+xtolerance+dtolerance/2+contactoffset
	  translate([sidecontactx+sidecontactw/2,-ryobid/2+uppercontactoffset+contactoffset+wall/2+dtolerance,ryobitotalh-sidecontacth-contactl+contactbladel-ryobicontacttopshift]) cylinder(d=contacth+dtolerance,h=0.1,$fn=30);
	  //translate([sidecontactx+sidecontactw/2,-ryobicontactsw/2+contacth/2+contactbladeh/2,ryobitotalh-sidecontacth-contactbladel]) cylinder(d=contacth+dtolerance,h=0.1,$fn=30);
	  electronicsarea();
	}
      }

    sidecontactcuts();
    
    // Hole for cables and electronics
    electronicsarea();

    protectionboardcut();
    
    translate([protectioncablespacex-xtolerance,-pcw/2-ytolerance,-wall-ztolerance-pcunderh-pcpcbh-0.01]) triangle(ryobid-wall,pcw+ytolerance*2,ryobid-wall,0);
    insidew=ryobid-wall*4-dtolerance+ytolerance*2;
    hull() {
      translate([protectioncablespacex-xtolerance,-insidew/2,-wall-ztolerance-pcunderh-pcpcbh-0.01]) triangle(ryobid-wall,insidew,insidew*0.8,22);
      //      translate([protectioncablespacex-xtolerance,-maxbridge/2,ryobid/2-maxbridge/2]) cube([ryobid-wall,maxbridge,0.1]);
    }

    translate([pcx,-pcw/2+pcconnectory,parksideheight+wall]) cube([pcconnectorl,pcw-pcconnectory*2,pcconnectorh]);

    translate([sidecontactx+textsize/2,-sidecontactdepth,ryobitotalh-sidecontacth+contactopening-ztolerance-textdepth+0.01]) linear_extrude(textdepth) text("+",size=textsize-1,halign="center",valign="center",font="Liberation Sans:style=Bold");
    translate([sidecontactx+textsize/2,sidecontactdepth+1,ryobitotalh-sidecontacth+contactopening-ztolerance-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text("-",size=textsize-2,halign="center",valign="center",font="Liberation Sans:style=Bold");

    translate([parksidecontactblockx+textsize/2+1,contactsw/2-textsize/2,parksidecontactblockheight+textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text("+",size=textsize-1,halign="center",valign="center",font="Liberation Sans:style=Bold");
    translate([parksidecontactblockx+textsize/2+1,-contactsw/2+textsize/2,parksidecontactblockheight+textdepth-0.01]) rotate([180,0,90]) linear_extrude(textdepth) text("-",size=textsize-2,halign="center",valign="center",font="Liberation Sans:style=Bold");

    translate([contactx+contactbladel+contactbladew+textsize+3,ryobid/2-sidecontacth,ryobitotalh-sidecontacth+contactopening-ztolerance-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
  }
}

module ryobiadapter() {
  difference() {
    union() {
      // Outside form of ryobi adapter
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

      // Base of the ryobi adapter
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

    // Inside cutout of the ryobi adapter
    ryobicut(0,0.1);

    topcontactholecut();
    
    // Cut the opening for back contact
    translate([ryobiconnectorx-0.1,-backcontactw/2,ryobitotalh-backcontacth]) cube([backcontactdepth+0.1,backcontactw,backcontacth]);
    translate([ryobiconnectorx-0.1,-backcontactw/2,ryobitotalh-backcontacth]) cube([backcontactdepth+wall+0.1,backcontactw,contactopening]);

    // Cut openings for side contacts
    sidecontactcuts();

    // Add texts
    translate([sidecontactx+sidecontactw/2,ryobid/2-sidecontactdepth-textsize/1.7,ryobih+ryobibaseh-textdepth+0.01]) rotate([0,0,90]) linear_extrude(textdepth) text("-",halign="center",valign="center");
    translate([sidecontactx+sidecontactw/2,-ryobid/2+sidecontactdepth+textsize/1.7,ryobih+ryobibaseh-textdepth+0.01]) linear_extrude(textdepth) text("+",halign="center",valign="center");

    // Openings for ryobi clips
    for (m=[0,1]) mirror([0,m,0]) clipcuts();

    // Cut extras from bottom (result of minkowski)
    translate([ryobibasex-0.1,-ryobibasew/2-0.1,-ryobiconnectorcornerd-0.1]) cube([ryobibasel+0.2,ryobibasew+0.2,ryobiconnectorcornerd+0.1]);

    // Screw holes
    screwholes();

    translate([contactx+contactbladel+contactbladew+textsize+3,ryobid/2-sidecontacth,ryobitotalh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
  }

  if (support) {
    for (m=[0,1]) mirror([0,m,0]) translate([clipx+1,ryobibasew/2-clipnotchdepth,0]) supportbox(clipw-2,clipnotchdepth,ryobibaseh-wall-clipnotchh+ztolerance,1);
    
    for (m=[0,1]) mirror([0,m,0]) {
	translate([clipx+1,ryobibasew/2-clipupperdepth+0.8,0]) supportbox(clipw-2,clipupperdepth-3,ryobibaseh-wall+ztolerance,1);
	translate([clipx+2,ryobibasew/2-clipupperdepth+1.8,0]) supportbox(clipw-4,clipupperdepth-5,ryobibaseh-wall+ztolerance,1);
      }
  }
}

// Centered
module hysteresis(size,w,depth) {
  width=size*0.7;
  boxw=width/2;
  h=size*0.8;
  // Horizontal lines
  for (x=[0,0+width/4]) {
    translate([x-width/2+(x?0:w/2),(x?h/2-w:-h/2),0]) cube([width/2+width/4-w+w/2,w,depth]);
  }
  // Vertical lines
  for (x=[-width/2,-w]) {
    translate([x+width/4,-h/2,0]) cube([w,h,depth]);
  }
}

module parksideadapterbody() {
  difference() {
    union() {
      // Main block
      difference() {
	union() {
	  translate([parksidex,-parksidew/2,-parksidetoph]) roundedbox(parksidel,parksidew,parksidetoph,cornerd);

	  // Space for battery protection
	  for (z=[-wall,parksideheight]) {
	    translate([pcx-wall-xtolerance,-pcw/2-wall-ytolerance,z]) roundedbox(wall+xtolerance+pcl+xtolerance+wall,wall+ytolerance+pcw+ytolerance+wall,wall,cornerd);
	  }
	  translate([pcx+pcl+xtolerance,-pcw/2-wall-ytolerance,parksideheight]) roundedbox(wall,wall+ytolerance+pcw+ytolerance+wall,parksideh,cornerd);
	  for (y=[-pcw/2-wall-ytolerance,pcw/2+ytolerance]) {
	    translate([pcx-wall-xtolerance,y,parksideheight]) roundedbox(wall+xtolerance+pcl+xtolerance+wall,wall,parksideh,cornerd);
	  }
	}
      }

      // Parkside locking clip
      difference() {
	hull() {
	  translate([parksideclipbarx,-parksideclipbarw/2,-parksidetoph]) roundedbox(parksideclipbarl,parksideclipbarw,parksidetoph,cornerd,1);
	  translate([parksideclipbarx+parksidecliparoundl,-parksidecliparoundw/2,-parksidetoph]) roundedbox(parksidecliparoundl,parksidecliparoundw,parksidetoph,cornerd,1);
	}

	translate([parksideclipx,-parksideclipw/2,-parksidetoph-cornerd]) roundedbox(parksideclipl,parksideclipw,parksidecliph+cornerd,cornerd,0);
      }

      // Structure the battery slides in
      for (y=[-parksidew/2,parksidewideslidew/2]) {
	translate([parksideslidex,y,parksideslideheight+parksidewideslideh-cornerd/2]) roundedbox(parksideslidel+cornerd,(parksidew-parksidewideslidew)/2,parksidewideslideh+cornerd*2,cornerd,0);
      }
      for (y=[-parksidew/2,parksidenarrowslidew/2]) {
	translate([parksideslidex,y,parksideslideheight]) roundedbox(parksideslidel+cornerd,(parksidew-parksidenarrowslidew)/2,parksidewideslideh,cornerd,0);
      }

      // Angled part for slide (for style, mostly)
      extendl=parksidenarrowslideh+parksidewideslideh;
      extral=0.0;
      for (y=[-parksidew/2,parksidewideslidew/2]) {
	hull() {
	  translate([parksideslidex-extendl-extral,y,-parksidetoph]) roundedbox(parksideslidel+extendl+extral,(parksidew-parksidewideslidew)/2,parksidetoph,cornerd,0);
	  translate([parksideslidex-extral,y,parksideslideheight]) roundedbox(parksideslidel+extral,(parksidew-parksidewideslidew)/2,cornerd,cornerd,0);
	}
      }

      for (y=[-parksidew/2,parksidewideslidew/2]) {
	  translate([parksidex+extendl,y,parksideslideheight]) roundedbox(parksidel-extendl,(parksidew-parksidewideslidew)/2,parksideslideh+cornerd,cornerd,0);
      }

      w=(parksidew-parksidecontactblockw)/2-ytolerance;
      x=parksideslidex+parksideslidel;
      for (m=[0,1]) mirror([0,m,0]) {
	translate([x,-parksidew/2,parksideslideheight]) roundedbox(parksidex+parksidel-x,w,parksideslideh+cornerd,cornerd,0);
      }
      translate([x,-parksidew/2,parksidebottomheight]) roundedbox(parksidex+parksidel-x,parksidew,parksidecontactblockheight-parksidebottomheight-ztolerance,cornerd);
      translate([parksideslidex+parksideslidel-textsize-1,-contactsw/2,parksidebottomheight]) roundedbox(contactsupportblockl/2,contactsw,parksidecontactblockheight-parksidebottomheight-ztolerance,cornerd);
      translate([parksidex+parksidel-wall,-parksidew/2,parksideslideheight]) roundedbox(wall,parksidew,parksideslideh+cornerd,cornerd,0);
      
      translate([parksideslidex-extendl,-parksidew/2,-parksidetoph]) roundedbox(parksideslidel+extendl,parksidew,parksidetoph,cornerd,0);
    }

    // Opening for cables
    ryobicut(0,0.1);
	
    for (m=[0,1]) mirror([0,m,0]) clipcuts();
    
    screwholes();

    protectionboardcut();

    translate([ryobibasex,0,-parksidetoph+textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    translate([ryobibasex-2,0,-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="top",halign="center",font="Liberation Sans:style=Bold");
    translate([0,0,parksidebottomheight+textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize-2, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
  }
}

module parksideadapterupper() {
  intersection() {
    parksideadapterbody();
    translate([parksideclipbarx,-parksidew/2,parksidebottomheight+parksideadaptersplith]) cube([-parksideclipbarx+parksidel+pcextensionl,parksidew,parksidetoph + parksidebottomh - parksideadaptersplith]);
  }
  
  protectionboardstandsupper();
}

module parksideadapterlower() {
  difference() {
    union() {
      intersection() {
	parksideadapterbody();
	translate([parksideclipbarx,-parksidew/2,parksidebottomheight]) cube([-parksideclipbarx+parksidel+pcextensionl,parksidew,parksideadaptersplith]);
      }

      protectionboardstandslower();

      // Opening for the display
      hull() {
	translate([pcx+pcl-pcdisplayx-pcdisplayl-wall,-pcw/2+pcdisplayy-pcdisplayopenw-wall,parksideheight]) roundedbox(pcdisplayl+pcdisplayopendown+wall*2,pcdisplayw+pcdisplayopenw*2+wall*2,wall,cornerd);
	translate([pcx+pcl-pcdisplayx-pcdisplayl-wall,-pcw/2+pcdisplayy-wall,-wall-pcunderh-ztolerance-pcpcbh-pcdisplayh-wall]) roundedbox(pcdisplayl+wall*2,pcdisplayw+wall*2,wall,cornerd);
      }

      // Body for button pressers
      translate([pcx+pcl-pcbuttonx-pcbuttonpresserd/2-buttondtolerance/2-wall+xtolerance+pcbuttonpresserxoffset,-pcw/2,parksideheight]) roundedbox(wall+pcbuttonx+pcbuttonpresserd/2+buttondtolerance/2-xtolerance-pcbuttonpresserxoffset,pcbutton1y+pcbuttonpresserd+buttondtolerance+wall,bottomtobuttons-ztolerance,cornerd);
    }
      
    // Opening for the display
    hull() {
      translate([pcx+pcl-pcdisplayx-pcdisplayl,-pcw/2+pcdisplayy-pcdisplayopenw,parksideheight-0.1-cornerd/2]) roundedbox(pcdisplayl+pcdisplayopendown,pcdisplayw+pcdisplayopenw*2,wall+cornerd,cornerd);
      translate([pcx+pcl-pcdisplayx-pcdisplayl,-pcw/2+pcdisplayy,-wall-pcunderh-ztolerance-pcpcbh-pcdisplayh-wall-0.1-cornerd/2]) roundedbox(pcdisplayl,pcdisplayw,wall+cornerd,cornerd);
    }

    // Openings for the button pressers
    for (y=[-pcw/2+pcbutton1y,-pcw/2+pcbutton2y]) {
      translate([pcx+pcl-pcbuttonx,y,0]) {
	difference() {
	  for (z=[0,pcbuttonpressermovement]) {
	    pcbuttonpresser(buttondtolerance);
	    translate([0,0,z]) pcbuttonpresser(buttondtolerance);
	  }
	  pcbuttonpresser(0);
	}
      }
    }

    // Protection board 
    translate([pcx+pcl-pcbuttonx,-pcw/2+pcbutton1y+pcbuttond+1,parksidebottomheight+textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) text("Set V/+", size=textsize-3, valign="center",halign="right",font="Liberation Sans:style=Bold");
    translate([pcx+pcl-pcbuttonx,-pcw/2+pcbutton2y-pcbuttond-textsize/4-1,parksidebottomheight+textdepth-0.01]) rotate([180,0,-90]) hysteresis(textsize,1,textdepth);
    translate([pcx+pcl-pcbuttonx,-pcw/2+pcbutton2y-pcbuttond-1-textsize/2,parksidebottomheight+textdepth-0.01]) rotate([180,0,-90]) linear_extrude(height=textdepth) text("/-", size=textsize-3, valign="center",halign="left",font="Liberation Sans:style=Bold");
    
  }
}


if (print==0) {
  intersection() {
    union() {
      ryobiadapter();
      difference() {
	ryobielectronicsplug();
	showcontacts();
      }
      
      for (m=[0,1]) mirror([0,m,0]) ryobiclip();
      
      parksideadapterlower();
      parksideadapterupper();

      #translate([pcx,pcy,pcheight]) translate([0,0,pch-pcpcbh]) rotate([0,180,180]) protectionboard();
      //      #translate([pcx,pcy,pcheight]) translate([0,0,pch-pcpcbh]) rotate([0,180,180]) translate([0,-pcw/2,0]) cube([pcl,pcw,pch]);
    }
    
    if (debugon) translate([-40,-5,-100]) cube([194,100,200]);
  }
 }

if (print==1 || print==4) {
  intersection() {
    difference() {
      ryobiadapter();
      showcontacts();
    }
    if (debugon) translate([-100,-100,-100]) cube([194,100,200]);
  }
 }

if (print==2 || print==4) {
  translate([ryobid/2+(parksidex+parksidel)+pcl-pcxtoparksidebodyend+2.5,0,0]) rotate([180,0,180]) parksideadapterupper();
 }

if (print==3 || print==4) {
  translate([-30,parksidew/2-4,0]) {
    translate([1,ryobibasew/2+parksidew/2+parksidebottomh+wall+clipwall,0]) rotate([0,-90,-90]) translate([-clipx,-parksidew/2,clipheight]) ryobiclip();
    translate([0,1.5,0]) rotate([0,0,180]) translate([-1.5,-ryobibasew/2+parksidew/2+parksidebottomh+wall+clipwall-cliph,0]) rotate([0,-90,-90]) translate([-clipx,-parksidew/2,clipheight]) ryobiclip();
  }
 }

if (print==5 || print==4) {
  translate([-ryobid+2,ryobibasew/2+parksidecontactblockw/2+0.7,-parksidecontactblockheight]) {
    difference() {
      intersection() {
	ryobielectronicsplug();
	if (debugon) translate([-7,-100,-100]) cube([194,100,200]);
      }
      showcontacts();
    }
  }
 }

if (print==6 || print==4) {
  translate([ryobid/2+parksidex+0.5+parksidew+0.5+11,parksidew+0.5,-parksidebottomheight]) rotate([0,0,180]) parksideadapterlower();
 }

if (print==7) {
  protectionboard();
 }

if (print==8) {
  translate([0,0,0]) hysteresis(10/0.8,1,0.7);
 }
