// Ruokasuppilo
// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

versiontext="V1.1";
textdepth=0.8;
textsize=8;

suppiloupw=400;//350; //320;
suppiloupl=420;
suppilodownw=290; //225;
suppilodownl=410; //225;
suppiloinheight=400;//68; //400;  testing..
suppilooutheight=0;
suppilow=max(suppilodownl,suppiloupl,suppiloupw,suppilodownw);
wall=1.5;
hangtoph=20;
hangw=10; //+wall
hanglowerh=63+hangtoph;
hangspike=5;
hangback=3.8;
hangwidth=25;
hangspikewidth=5.5;
hangdistance=suppiloupw-2*hangwidth-2*hangwidth;
backhangdistance=hangw;//-1; // 1 mm for cloth
hookout=8;
hookh=10;
hookw=4;
hookheight=0;//suppilooutheight+12;
hookd=suppilodownw/2+(suppiloupw-suppilodownw)/2*(hookheight/(suppiloinheight+2*wall));
//hookd=suppilodownd/2+(suppiloupd-suppilodownd)/2*(hookheight/(suppiloinheight+2*wall));
//suppilooutd=suppilodownd/2+(suppiloupd-suppilodownd)/2*(suppilooutheight/suppiloinheight);
suppilomaxw=max(suppiloupw,suppilodownw)+hangw;
suppilomaxl=max(suppiloupl,suppilodownl);

totalheight=suppiloinheight+hangtoph;;

$fn=120;

module suppilo() {
  dup=min(suppiloupw,suppiloupl);
  mup=max(suppiloupw,suppiloupl);
  centerdistanceup = (dup>mup?dup-mup:0)/2;
  ddown=min(suppilodownw,suppilodownl);
  mdown=min(suppilodownw,suppilodownl);
  centerdistancedown = (ddown>mdown?ddown-mdown:0)/2;
  difference() {
    union() {
      hull() {
	translate([0,-centerdistanceup/2,suppiloinheight-1]) cylinder(h=1,d=dup);
	translate([suppiloupl/2-dup/2,0,suppiloinheight-1]) cylinder(h=1,d=dup);
	translate([0,centerdistanceup/2,suppiloinheight-1]) cylinder(h=1,d=dup);
	
	translate([0,-centerdistancedown/2,0]) cylinder(h=1,d=ddown);
	translate([suppilodownl/2-ddown/2,0,]) cylinder(h=1,d=ddown);
	translate([0,centerdistancedown/2,0]) cylinder(h=1,d=ddown);
	
	translate([0,-centerdistanceup/2,suppiloinheight-0.01]) cylinder(h=hangtoph,d=dup);
	translate([suppiloupl/2-dup/2,0,suppiloinheight-0.01]) cylinder(h=hangtoph,d=dup);
	translate([0,centerdistanceup/2,suppiloinheight-0.01]) cylinder(h=hangtoph,d=dup);
      }
    }

  hull() {
    translate([0,-centerdistanceup/2,suppiloinheight-1-0.1]) cylinder(h=1+0.2,d=dup-wall*2);
    translate([suppiloupl/2-dup/2,0,suppiloinheight-1-0.01]) cylinder(h=1+0.02,d=dup-wall*2);
    translate([0,centerdistanceup/2,suppiloinheight-1-0.1]) cylinder(h=1+0.2,d=dup-wall*2);
      
    translate([0,centerdistancedown/2,-0.1]) cylinder(h=1+0.2,d=ddown-wall*2);
    translate([suppilodownl/2-ddown/2,0,-0.1]) cylinder(h=1+0.2,d=ddown-wall*2);
    translate([0,-centerdistancedown/2,-0.1]) cylinder(h=1+0.2,d=ddown-wall*2);
    
    translate([0,-centerdistanceup/2,suppiloinheight-0.1]) cylinder(h=hangtoph+0.2,d=dup-wall*2);
    translate([suppiloupl/2-dup/2,0,suppiloinheight-0.1]) cylinder(h=hangtoph+0.2,d=dup-wall*2);
    translate([0,centerdistanceup/2,suppiloinheight-0.1]) cylinder(h=hangtoph+0.2,d=dup-wall*2);
  }
  translate([-suppilow/2-1,-suppilow/2-1,-0.1]) cube([suppilow/2+1,suppilow+2,suppiloinheight+hangtoph+0.2]);
  
    //if (0) hull() {
    //  translate([wall,-suppilodownd/2,-wall]) cube([wall,suppilodownd,wall]);
    //  translate([suppilooutd,-suppiloupd/2,suppilooutheight]) cube([wall,suppiloupd,wall]);
    //  translate([suppilooutd,-suppiloupd/2,0]) cube([wall,suppiloupd,wall]);
    //}
  }

  hull() {
    translate([0,-suppilodownw/2,0]) cube([wall,suppilodownw,wall]);
    translate([0,-suppiloupw/2,suppiloinheight]) cube([wall,suppiloupw,wall]);
  }

  translate([-hangw,-suppiloupw/2,suppiloinheight-0.01]) cube([hangw+0.01,wall,hangtoph]);
  translate([-hangw,suppiloupw/2-wall,suppiloinheight-0.01]) cube([hangw+0.01,wall,hangtoph]);
  hull() {
    translate([-hangw,-suppiloupw/2,suppiloinheight+hangtoph-wall]) cube([wall,suppiloupw,wall]);
    translate([0,-suppiloupw/2,suppiloinheight]) cube([wall,suppiloupw,wall]);
  }
difference() {
  hull() {
    translate([-hangw,-suppiloupw/2,suppiloinheight]) cube([hangback,suppiloupw,wall]);
    translate([-hangw,-suppiloupw/2,suppiloinheight+hangtoph-wall]) cube([wall,suppiloupw,wall]);
  }

    translate([-hangw+textdepth-0.01,0,suppiloinheight+hangtoph/2]) rotate([90,0,-90]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    
}

  hull() {
    translate([-hangw,-suppiloupw/2,suppiloinheight]) cube([hangw,(suppiloupw-hangdistance)/2-hangwidth,wall]);
    translate([0,-suppiloupw/2+hangw,suppiloinheight-hangtoph]) cube([wall,(suppiloupw-hangdistance)/2-hangwidth-hangw,wall]);
  }
  hull() {
    translate([-hangw,hangdistance/2+hangwidth,suppiloinheight]) cube([hangw,(suppiloupw-hangdistance)/2-hangwidth,wall]);
    translate([0,hangdistance/2+hangwidth,suppiloinheight-hangtoph]) cube([wall,(suppiloupw-hangdistance)/2-hangwidth-hangw,wall]);
  }
  hull() {
    translate([-hangw,-hangdistance/2,suppiloinheight]) cube([hangw,hangdistance,wall]);
    translate([0,-hangdistance/2,suppiloinheight-hangtoph]) cube([wall,hangdistance,wall]);
  }

  //if (0) for (angle=[-85,-45,0,45,85]) {
  //    rotate([0,0,angle]) {
  //  translate([hookd-0.1,-hookw/2,hookheight]) cube([hookout+0.1,hookw,hookw]);
  //  translate([hookd+hookout,-hookw/2,hookheight]) cube([hookw,hookw,hookh]);
  //  hull() {
  //	translate([hookd,-hookw/2,hookheight]) cube([hookw+hookout,hookw,1]);
  //	translate([suppilooutd-wall/2,-hookw/2,suppilooutheight+wall]) cube([0.1,hookw,0.1]);
  //  }
  //}
  //}

  for (y=[-suppilodownw/2,-suppilodownw/4,-hookw/2,suppilodownw/4-hookw,suppilodownw/2-hookw]) {
    hull() {
      translate([-backhangdistance,y,hookheight]) cube([backhangdistance+0.1,hookw,hookw]);
      translate([0,y,hookheight+2*backhangdistance]) cube([wall,hookw,hookw]);
    }
    if (0) {
      translate([-backhangdistance,y,hookheight]) cube([hookw,hookw,hookh]);
      hull() {
	translate([-backhangdistance,y,hookheight]) cube([backhangdistance+0.1,hookw,1]);
	translate([0,y,suppilooutheight+wall]) cube([0.1,hookw,0.1]);
      }
    }
  }
}


intersection() {
  translate([0,0,totalheight]) rotate([180,0,0]) suppilo();
  translate([-suppilomaxw/2-1,-suppilomaxl/2-1,242]) cube([suppilomaxw+5,suppilomaxl+5,totalheight-242+1]);
}
