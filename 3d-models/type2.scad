// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=print==0?1:0;
$fn=90;

cornerd=0.01;
wall=1.6;
holderwall=2.5;
dtolerance=0.7;
xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;

// Angle when plug is in place
insertangle=10;
plugangle=10+insertangle;

// Test angle
//testangle=insertangle;
//testangle=plugangle;
testangle=plugangle-10;

// Vehicle Inlet (Socket at car end)
t2evinletl=35.5; // Inlet 0 is at front
t2evinletd=51; // +- 0.3;
// bottom 51.8 -0.6;
t2evinletw=51; // +- 0.3;
t2evinlettoph=18.5; // +-0.15
t2evinleth=t2evinletw/2+t2evinlettoph;
// bottom R10 +- 0.15;
t2evinletholeheight=5; // From bottom
t2evinletcornerd=9.6; // +- 0.15;
t2evinletoutl=t2evinletl;
// bottom R10 +- 0.15;
t2evinletoutw=65; // +0.5
// Bottom 64+0.6
t2evinletouttoph=25.5; // 25.4 +0.5
// Bottom 25.0 +0.3
t2evinletouth=t2evinletoutw/2+t2evinletouttoph;
// Bottom 64.8-0.6 / 2 + 25 +0.3;
t2evinletoutd=65; // 65 +0.5
// Bottom 64 + 0.6
t2evinletoutcornerd=16.6; // +- 0.25
// Bottom 16.1 +- 0.15
t2evinletextra=5;
t2evinletlockholel=5; // 5+-0.8;
t2evinletlockholebottomheight=27.3-t2evinletlockholel; // -0.4
t2evinletlockholebottomx=(t2evinlettoph+t2evinletouttoph)/2;
t2evinletlockholew=6;
t2evinletlockholefromcenter=(t2evinletd/2+t2evinletoutd/2)/2; // This is pin coming out from surrounding structure
t2evinletlockholeatable=[-90,180,90];

t2evinletholebottom=0;
t2evinletsignalholed=10.2; // +0.2
t2evinletsignalholel=30.5;
t2evinletcontactholed=14.7; // +0.2;
t2evinletcontactholel=30.5;

// Pins apply to both Plug is centered
t2signalpinx=11.2;
t2centerpinx=0;
t2lowerpinx=-13.9;
t2lowerpinw=32;

// vehicle connector Plug towards car
t2evconnectorl=35;
t2evconnectorw=52.2; // +0.5
// bottom t2evconnectorw=51.4; 51.4 +0.4
t2evconnectord=52.2; // 63 +- 0.5;
t2evconnectortoph=19.1; // +0.25;
// bottom t2evconnectortoph=18.7; // +0.25;
t2evconnectorh=t2evconnectord/2+t2evconnectortoph; // 24.5 +- 0.5;
t2evconnectorcornerd=9.9*2; // R9.9 -0.4
// bottom t2evconnectorcornerd=10.3*2; // 

t2evconnectoroutl=34.5;
t2evconnectoroutw=63; // 63 +- 0.5
t2evconnectoroutd=63;
t2evconnectorouttoph=24.5;
t2evconnectorouth=t2evconnectoroutd/2+t2evconnectorouttoph; //24.5; // 24 +- 0.5;
t2evconnectoroutcornerd=15.7*2; // R15.7+0.4
t2evconnectorbaseh=0.7;
t2evconnectorsignaltowerd=9.7; // 9.7 -0.2
t2evconnectorcontacttowerd=14.2; // 14.2 -0.2
t2evconnectorsignaltowerl=29.5; // 29.5 +-0.2
t2evconnectorcontacttowerl=29.5; // 29.5 +-0.2
t2evconnectorpintowerbottom=t2evconnectorbaseh;
t2evconnectorsignalholebottom=34.5-28.7;
t2evconnectorsignalholed=3.5; // +0.2;
t2evconnectorsignalholel=25.4+0.01; // +0.2;
t2evconnectorcontactholebottom=29.5-25.4;
t2evconnectorcontactholed=6.5; // +0.2;
t2evconnectorcontactholel=25.4+0.01; // +0.2;

t2evconnectorlockholebottom=19.4; // 19.4 -2
t2evconnectorlockholew=6.5; // 6.5 +-0.5
t2evconnectorlockholebottomx=t2evconnectortoph;
t2evconnectorlockholel=28.4-19.4; // 28.4+0.2 - 19.4-2
t2evconnectorlocktrianglel=t2evconnectorlockholel-2;
t2evconnectorlocktrianglew=5;
t2evconnectorlocktriangleh=(t2evconnectorouth-t2evconnectorh)/2-1;
t2evconnectorlocktrianglex=t2evconnectorlockholebottomx+1;
t2evconnectorlocktrianglebottom=t2evconnectorlockholebottom-xtolerance; //-t2evconnectorlockholel;
t2evconnectorholewall=1.2;
t2evconnectorlockholeatable=[-90,180,90];
t2evconnectorlockholefromcenter=t2evconnectord/2-1;
t2evconnectorlockholeh=t2evconnectorouth-t2evconnectorh+2;

t2evconnectorhandlew=70; // 70+4/-0.5
t2evconnectorhandled=70; // 70+4/-0.5
t2evconnectorhandletoph=28; // 28+2/-0.5
t2evconnectorhandleh=t2evconnectorhandled/2+t2evconnectorhandletoph;
t2evconnectorhandlecornerd=19.2; // +0.5
t2evconnectorhandlel=20;

// Plugbody is just a sample
//plugbodyl=30;
//plugbodyh=63.4;
//plugbodyw=70.4;
// plugbodycornerdd=10.3*2; // R10.3 -0.4 

t2cpy=-16/2;
t2ppy=16/2;

t2upperpinsw=23;
t2lowerpinsw=16;

t2npiny=-t2upperpinsw/2; // Looking at plug
t2pepiyn=0;
t2l1piny=t2upperpinsw/2; 
t2l3piny=-t2lowerpinsw/2;
t2l2piny=t2lowerpinsw/2;

t2plugl=44.5; // 44.5 +- 0.2
t2plugw=56; // 56 + 4
t2plugd=t2plugw; // 56 + 4
t2plugh=t2plugd/2+21.2; // +21+2 (upper dimension only);
t2plugcornerd=12.2*2; // 12.2 +- 0.3;
t2plugholebottom=5; // -0.2

t2plugoutwallextend=2;
t2plugoutw=56+wall*2; // 56+4
t2plugoutd=56+wall*2; // 56+4
t2plugoutcornerd=12.2; // +- 0.3
t2plugoutl=20;
t2plugouth=t2plugoutd/2+21; // +21+2

t2pluglockholebottom=32.5; // 32.5-0.5;
t2pluglockholel=41.5-t2pluglockholebottom; // +0.2
t2pluglockholew=6; // 3x6+1 ???
t2pluglockholebottomx=t2signalpinx;
t2plugholewall=1.2;
t2plugholesidewall=1.6;
t2pluglockholesidefromcenter=21.2-5;

t2lockbottom=32.5+1; // 32.5-0.5;
t2lockholel=41.5-t2lockbottom-1; // +0.2
t2lockw=t2pluglockholew-cornerd; // 3x6+1 ???
t2lockbottomx=14.5; // t2signalpinx;

t2signalpinw=16;
t2plugsignalholed=9.5; // +0.2;
t2plugsignalholebottom=5;
t2plugcontactholebottom=5;
t2plugsignalholel=t2plugl-t2plugsignalholebottom;
t2plugcontactholed=14; // +0.2;
t2plugcontactholel=t2plugl-t2plugcontactholebottom;

t2plugextra=5;

screwd=4;
screwtowerh=5;
screwbased=7.6+wall*2;
screwl=15;

wallplatethickness=3;
wallplateh=t2plugd+t2plugl*sin(plugangle)-wall*2+screwd*3+wall;
wallplatew=t2plugd+wall*3+screwd*3+wall;
wallplateheight=0;//-t2evconnectord/2+wall*2-t2evconnectorl*sin(insertangle);

cableholdl=14;
cableholdh=20;
cableholdw=25;
cableholdtopw=15;

//holderheight=-(t2evconnectoroutd/2+holderwall)*sin(insertangle)-t2evconnectorl*sin(insertangle);
//holderheight=-(t2evconnectoroutd/2+holderwall); // +*sin(insertangle)-t2evconnectorl*sin(insertangle);
//holderheight=-(t2evconnectoroutd/2)-dtolerance/2-holderwall;//+(t2evconnectorl+wall)*sin(insertangle);
holderheight=t2evconnectorouttoph+dtolerance/2-(t2evconnectorouth+dtolerance)*cos(insertangle)-holderwall*cos(insertangle);//+(t2evconnectorl+wall)*sin(insertangle);

module t2evconnectorholes(w) {
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    hull() {
      translate([t2signalpinx,y,t2evconnectorsignalholebottom]) cylinder(d=t2evconnectorsignalholed+w*2,h=t2evconnectorsignalholel+0.01);
      translate([t2signalpinx,y,t2evconnectorsignalholebottom-t2evconnectorsignalholed/2]) cylinder(d1=0.1,d2=t2evconnectorsignalholed+w*2,h=t2evconnectorsignalholed/2+0.01);
    }
  }
    
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    hull() {
      translate([t2lowerpinx,y,t2evconnectorcontactholebottom]) cylinder(d=t2evconnectorcontactholed+w*2,h=t2evconnectorcontactholel+0.01);
      translate([t2lowerpinx,y,t2evconnectorcontactholebottom-t2evconnectorcontactholed/2]) cylinder(d1=0.1,d2=t2evconnectorcontactholed+w*2,h=t2evconnectorcontactholed/2+0.01);
    }
  }

  for (y=[-t2lowerpinw/2,0,t2lowerpinw/2]) {
    hull() {
      translate([0,y,t2evconnectorcontactholebottom]) cylinder(d=t2evconnectorcontactholed+w*2,h=t2evconnectorcontactholel+0.01);
      translate([0,y,t2evconnectorcontactholebottom-t2evconnectorcontactholed/2]) cylinder(d1=0.1,d2=t2evconnectorcontactholed+w*2,h=t2evconnectorcontactholed/2+0.01);
    }
  }
}

module t2evconnectortowers(w) {
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    translate([t2signalpinx,y,0]) cylinder(d=t2evconnectorsignaltowerd+w*2,h=t2evconnectorsignaltowerl+0.01);
  }
    
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    translate([t2lowerpinx,y,0]) cylinder(d=t2evconnectorcontacttowerd+w*2,h=t2evconnectorcontacttowerl+0.01);
  }

  for (y=[-t2lowerpinw/2,0,t2lowerpinw/2]) {
    translate([0,y,0]) cylinder(d=t2evconnectorcontacttowerd+w*2,h=t2evconnectorcontacttowerl+0.01);
  }
}

module t2evinletholes(w) {
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    translate([t2signalpinx,y,t2evinletholebottom-0.02]) cylinder(d=t2evinletsignalholed+w*2,h=t2evinletsignalholel+0.02);
  }
    
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    translate([t2lowerpinx,y,t2evinletholebottom-0.02]) cylinder(d=t2evinletcontactholed+w*2,h=t2evinletcontactholel+0.02);
  }

  for (y=[-t2lowerpinw/2,0,t2lowerpinw/2]) {
    translate([0,y,t2evinletholebottom-0.02]) cylinder(d=t2evinletcontactholed+w*2,h=t2evinletcontactholel+0.02);
  }

}

module t2socketoutletholes(w) {
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    translate([t2signalpinx,y,t2plugholebottom]) cylinder(d=t2plugsignalholed+w*2,h=t2plugsignalholel+0.01);
  }
    
  for (y=[-t2signalpinw/2,t2signalpinw/2]) {
    translate([t2lowerpinx,y,t2plugholebottom]) cylinder(d=t2plugcontactholed+w*2,h=t2plugsignalholel+0.01);
  }

  for (y=[-t2lowerpinw/2,0,t2lowerpinw/2]) {
    translate([0,y,t2plugholebottom]) cylinder(d=t2plugcontactholed+w*2,h=t2plugcontactholel+0.01);
  }

}

// Plug starts at 0, xy centered at center pin, shape centered at center pin other than flattened top
module t2evinlet(holes,w,includebody) {
  difference() {
    union() {
      // Plug
      difference() {
	minkowski() {
	  roundedcylinder(t2evinletoutcornerd+wall*2,cornerd,cornerd);
	  intersection() {
	    translate([0,0,0]) cylinder(d=t2evinletoutd-t2evinletoutcornerd,h=t2evinletoutl+wall);
	    translate([-t2evinletoutd/2+t2evinletoutcornerd/2,-t2evinletoutd/2+t2evinletoutcornerd/2,0]) cube([t2evinletouth-t2evinletoutcornerd,t2evinletoutd-t2evinletoutcornerd,t2evinletoutl+wall]);
	  }
	}

	minkowski() {
	  roundedcylinder(t2evinletoutcornerd,cornerd,cornerd);
	  intersection() {
	    translate([0,0,-0.01]) cylinder(d=t2evinletoutd-t2evinletoutcornerd,h=t2evinletoutl+cornerd+0.01);
	    translate([-t2evinletoutd/2+t2evinletoutcornerd/2,-t2evinletoutd/2+t2evinletoutcornerd/2,-0.01]) cube([t2evinletouth-t2evinletoutcornerd,t2evinletoutd-t2evinletoutcornerd,t2evinletoutl+cornerd+0.01]);
	  }
	}
      }
  
      minkowski() {
	roundedcylinder(t2evinletcornerd+w*2,cornerd,cornerd);
	intersection() {
	  translate([0,0,0]) cylinder(d=t2evinletd-t2evinletcornerd,h=t2evinletl+cornerd/2);
	  translate([-t2evinletd/2+t2evinletcornerd/2,-t2evinletw/2+t2evinletcornerd/2,0]) cube([t2evinleth-t2evinletcornerd,t2evinletw-t2evinletcornerd,t2evinletl+cornerd/2]);
	}
      }
    }

    if (holes) {
      t2evinletholes(0);
    
      // Locking hole top
      difference() {
	translate([t2evinletlockholebottomx-cornerd/2,-t2evinletlockholew/2,t2evinletlockholebottomheight]) {
	  roundedbox(t2evinleth-t2evinletd/2+0.01,t2evinletlockholew,t2evinletlockholel,cornerd);
	}
	//t2evinletholes(t2evinletholewall);
      }

      // Locking holes sides
      for (a=t2evinletlockholeatable) {
	difference() {
	  rotate([0,0,a]) {
	    translate([t2evinletlockholefromcenter,-t2evinletlockholew/2,t2evinletlockholebottomheight]) roundedbox(t2evinleth-t2evinletd/2+0.01,t2evinletlockholew,t2evinletlockholel,cornerd);
	  }
	  //t2evinletholes(t2evinletholesidewall);
	}
      }
    }
  }
}

// Plug starts at 0, xy centered at center pin, shape centered at center pin other than flattened top
module t2evconnector(holes,w,includebody,extrahandled,extral,justtop) {
  intersection() {
    if (justtop) translate([0,0,t2evconnectorl-0.2]) cylinder(d=t2evconnectoroutd*2,h=0.2);
    difference() {
      union() {
	difference() {
	  minkowski() {
	    roundedcylinder(t2evconnectoroutcornerd+w*2,cornerd,cornerd);
	    intersection() {
	      translate([0,0,-cornerd/2]) cylinder(d=t2evconnectoroutd-t2evconnectoroutcornerd,h=t2evconnectoroutl+extral-cornerd/2);
	      translate([-t2evconnectoroutd/2+t2evconnectoroutcornerd/2,-t2evconnectoroutw/2+t2evconnectoroutcornerd/2,-cornerd/2]) cube([t2evconnectorouth-t2evconnectoroutcornerd,t2evconnectoroutw-t2evconnectoroutcornerd,t2evconnectoroutl+extral-cornerd/2]);
	    }
	  }

	  if (includebody) {
	    minkowski() {
	      roundedcylinder(t2evconnectorcornerd,cornerd,cornerd);
	      intersection() {
		translate([0,0,t2evconnectorbaseh]) cylinder(d=t2evconnectord-t2evconnectorcornerd,h=t2evconnectorl);
		translate([-t2evconnectord/2+t2evconnectorcornerd/2,-t2evconnectorw/2+t2evconnectorcornerd/2,-cornerd/2]) cube([t2evconnectorh-t2evconnectorcornerd,t2evconnectorw-t2evconnectorcornerd,t2evconnectorl-cornerd/2]);
	      }
	    }
	  }
	}

	// Body (just short bit for demo)
	if (includebody>0) {
	  t=extrahandled>0?xtolerance:0;
	  minkowski() {
	    roundedcylinder(t2evconnectorhandlecornerd,cornerd,cornerd);
	    intersection() {
	      translate([0,0,-t2evconnectorhandlel-cornerd/2]) cylinder(d=t2evconnectorhandled-t2evconnectorhandlecornerd+extrahandled,h=t2evconnectorhandlel+t-cornerd/2);
	      translate([-t2evconnectorhandled/2+t2evconnectorhandlecornerd/2-extrahandled,-t2evconnectorhandled/2+t2evconnectorhandlecornerd/2-extrahandled,-t2evconnectorhandlel-cornerd/2]) cube([t2evconnectorhandleh-t2evconnectorhandlecornerd+extrahandled*2,t2evconnectorhandled-t2evconnectorhandlecornerd+extrahandled*2,t2evconnectorhandlel+t-cornerd/2]);
	    }
	  }
	}

	// Pin towers
	t2evconnectortowers(0);
      }

      if (holes) {
	t2evconnectorholes(0);
    
	// Locking hole top
	difference() {
	  translate([t2evconnectorlockholebottomx-cornerd/2,-t2evconnectorlockholew/2,t2evconnectorlockholebottom]) {
	    roundedbox(t2evconnectorh-t2evconnectord/2+0.01,t2evconnectorlockholew,t2evconnectorlockholel,cornerd);
	  }
	  t2evconnectorholes(t2evconnectorholewall);
	}

	// Locking holes sides
	for (a=t2evconnectorlockholeatable) {
	  difference() {
	    rotate([0,0,a]) {
	      translate([t2evconnectorlockholefromcenter,-t2evconnectorlockholew/2,t2evconnectorlockholebottom]) cube([t2evconnectorlockholeh,t2evconnectorlockholew,t2evconnectorlockholel]);
	    }
	  }
	}
      }
    }
  }
}

module rotateholder(a,holes,w,includebody,extra,extral,justtop) {
  //  translate([t2evconnectorl,0,-(t2evconnectoroutd/2+holderwall)]) rotate([0,-90+a,0]) translate([t2evconnectoroutd/2+holderwall,0,0]) t2evconnector(holes,w,includebody,extra,extral);
  d=t2evconnectoroutd;
  h=t2evconnectorouttoph+dtolerance;
  translate([t2evconnectorl+sin(plugangle)*d,0,h]) rotate([0,-90+a,0]) translate([-h,0,0]) t2evconnector(holes,w,includebody,extra,extral,justtop);
}
     
module holderoutshape() {
  hull() {
    hull() {
      translate([0,0,holderheight+t2evconnectoroutd/2+dtolerance/2+holderwall]) rotate([0,90,0]) roundedcylinder(t2evconnectoroutd+dtolerance+holderwall*2,wall,cornerd,0,90);
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([0,t2upperpinsw/2+wall+holderwall,t2evconnectorouttoph+dtolerance/2+t2evconnectorl*sin(plugangle)-t2evconnectord/2-holderwall+dtolerance/2+holderwall]) rotate([0,90,0]) scale([1,(t2evconnectord+dtolerance+holderwall*2-t2upperpinsw)/(t2evconnectord+dtolerance+holderwall*2),1]) cylinder(d=t2evconnectord+dtolerance+wall*2,h=wall);
	}
    }
      
    for (a=[insertangle,plugangle]) {
      //x=rotatexcalculation(a); // t2evconnectorl*cos(a)+(t2evconnectoroutd/2+holderwall+dtolerance)/2*sin(a)+wall+xtolerance;
      rotateholder(a,1,holderwall+dtolerance/2,0,0,0);
      //#      translate([t2evconnectorl,0,-(t2evconnectoroutd/2+holderwall)]) rotate([0,-90+a,0]) translate([t2evconnectoroutd/2+holderwall,0,0]) t2evconnector(1,holderwall+dtolerance/2,0,0);
    }
  }

  //kx=rotatexcalculation(insertangle); // t2evconnectorl*cos(insertangle)+(t2evconnectord+dtolerance)/2*sin(insertangle)+wall+xtolerance;
  translate([t2evconnectorl+(t2evconnectorouth+dtolerance/2+holderwall)*sin(insertangle)+xtolerance,0,-(t2evconnectoroutd/2+holderwall)]) rotate([0,-90+insertangle,0]) translate([t2evconnectoroutd/2+holderwall,0,0]) {
    hull() {
      translate([t2evconnectorouttoph+dtolerance,-cableholdw/2,0]) roundedbox(wall,cableholdw,wall,cornerd);
      translate([t2evconnectorouttoph+dtolerance+cableholdh,-cableholdtopw/2,0]) roundedbox(wall,cableholdtopw,wall,cornerd);
      translate([t2evconnectorouttoph+dtolerance,-cableholdw/2,cableholdl]) roundedbox(wall,cableholdw,wall,cornerd);
     }
  }
}

module t2holder() {
  //x=rotatexcalculation(plugangle); // t2evconnectorl*cos(plugangle)+(t2evconnectord+dtolerance)/2*sin(plugangle)+wall+xtolerance;

  difference() {
    union() {
      difference() {
	union() {
	  for (m=[0,1]) mirror([0,m,0]) {
	      for (z=[holderheight+wallplateheight+screwbased/2+cornerd/2,holderheight+wallplateheight+wallplateh-screwbased/2-cornerd/2]) {
		translate([0,wallplatew/2-screwbased/2-cornerd/2,z]) rotate([0,90,0]) cylinder(d=screwbased,h=screwtowerh);
	      }
	    }

	  hull() {
	    translate([0,-wallplatew/2,holderheight+wallplateheight]) roundedbox(wallplatethickness,wallplatew,wallplateh,cornerd);
	    intersection() {
	      translate([0,-wallplatew/2,holderheight+wallplateheight]) roundedbox(wallplatethickness+5,wallplatew,wallplateh,cornerd);
	      holderoutshape();
	    }
	  }
	}
	
	for (m=[0,1]) mirror([0,m,0]) {
	    for (z=[holderheight+wallplateheight+screwbased/2+cornerd/2,holderheight+wallplateheight+wallplateh-screwbased/2-cornerd/2]) {
	      translate([-screwl+screwtowerh,wallplatew/2-screwbased/2-cornerd/2,z]) rotate([0,90,0]) ruuvireika(screwl,screwd,1,print>0?1:0);
	      translate([screwtowerh-0.01,wallplatew/2-screwbased/2-cornerd/2,z]) rotate([0,90,0]) cylinder(d1=screwbased,d2=screwbased+screwl*2,h=screwl);
	    }
	  }
      }


      holderoutshape();
    }
    
    hull() {
      for (x=[0]) { // -t2evconnectorl,
	translate([x,0,0]) {
	  for (a=[insertangle,plugangle]) {
	    //x=rotatexcalculation(a); // t2evconnectorl*cos(a)+(t2evconnectord+dtolerance)/2*sin(a)+wall+xtolerance;
	    //translate([x,0,0]) rotate([0,-90+a,0]) t2evconnector(1,dtolerance/2,0,0,0);
	    rotateholder(a,1,dtolerance/2,0,0,xtolerance);
	  }
	}
      }
    }

    for (a=[insertangle,plugangle]) {
      //x=rotatexcalculation(a); // t2evconnectorl*cos(a)+(t2evconnectord+dtolerance)/2*sin(a)+wall+xtolerance;
      //translate([x,0,0]) rotate([0,-90+a,0]) t2evconnector(1,dtolerance/2,2,5,0);
      rotateholder(a,1,dtolerance/2,2,10,xtolerance);
    }

    hull() {
      for (x=[0,-t2evconnectorl]) {
	translate([x,0,0]) {
	  for (a=[plugangle])
	    	    rotateholder(a,1,dtolerance/2,2,10,xtolerance,1);
	}
      }
    }

    //translate([x,0,0]) rotate([0,-90+plugangle,0]) {
    //hull() {
    //	translate([t2evconnectorlockholebottomx+dtolerance/2-wall+0.01,-t2evconnectorlockholew,t2evconnectorlockholebottom+t2evconnectorlockholel]) cube([t2evconnectorh-t2evconnectord/2-t2lockbottomx+wall,t2evconnectorlockholew*2,t2evconnectorlockholel]);
    //      }
    //    }
  }

  d=t2evconnectoroutd;
  h=t2evconnectorouttoph+dtolerance;
  translate([t2evconnectorl+sin(plugangle)*d,0,h]) rotate([0,-90+plugangle,0]) translate([-h,0,0]) {
    intersection() {
      translate([t2evconnectorouttoph+dtolerance/2,t2evconnectorlocktrianglew/2,0]) rotate([90,0,0]) cylinder(d=(t2evconnectorlockholebottom-xtolerance+t2evconnectorlocktrianglel+2)*2,h=t2evconnectorlocktrianglew);
      hull() {
	translate([t2evconnectorlocktrianglex+dtolerance/2,-t2evconnectorlocktrianglew/2,t2evconnectorlocktrianglebottom+1]) triangle(t2evconnectorlocktriangleh+0.01,t2evconnectorlocktrianglew,t2evconnectorlocktrianglel,3);
	translate([t2evconnectorlocktrianglex+dtolerance/2,-t2evconnectorlocktrianglew/2,t2evconnectorlocktrianglebottom+2]) triangle(t2evconnectorlocktriangleh+0.01,t2evconnectorlocktrianglew,t2evconnectorlocktrianglel,3);
      }
    }

    //    translate([t2evconnectorlockholebottomx+dtolerance/2+0.01,-t2evconnectorlockholew/2,t2evconnectorlockholebottom+t2evconnectorlockholel]) supportbox(t2evconnectorh-t2evconnectord/2-t2evconnectorlockholebottomx-1,t2evconnectorlockholew,t2evconnectorlockholel,0);
  }
}

if (print==0) {
  intersection() {
    union() {
      t2holder();
      //x=rotatexcalculation(testangle); // t2evconnectorl*cos(testangle)+(t2evconnectord+dtolerance)/2*sin(testangle)+wall+xtolerance;
      //translate([x,0,0]) rotate([0,-90+testangle,0]) t2evconnector(1,0,1,0,0);
      rotateholder(testangle,1,0,1,0,0);
    }
    
    translate([-100,00,-100]) cube([200,200,200]);
  }
 }

if (print==1) {
  rotate([0,-90,0]) t2holder();
 }

if (print==2) {
    t2evinlet(1,0,1);
  intersection() {
    //  translate([-100,-100,-100]) cube([200,200,140]);
  }
 }

if (print==3) {
  t2evconnector(1,0,1,0);
 }
