// CopyOAright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=1;
debugscrewcuts=1; // This makes model slow to display
peekholes=0; // Cutouts to see reset mechanism
powerswitch=1;
resetpressed=0;
support=1;

textdepth=0.7;
textsize=7;
versiontext="v1.6";
textfont="Liberation Sans:style=Bold";
labelsize=5;

xtolerance=0.20;
ytolerance=0.20;
ztolerance=0.20;
xmtolerance=0.60;
ymtolerance=0.60;
zmtolerance=0.40;
dtolerance=0.5;
screwdtolerance=0.2;
maxbridge=10;

screw=0; // "35mm countersink";
//screw=1; //"30mm countersink";
//screw=2; //"20mm cup";
screwdtable=[4.4,4.4,4.4];
screwd=screwdtable[screw];
screwheaddtable=[7.3,7.3,7.9];
screwheadd=screwheaddtable[screw];
screwheadhtable=[0.4,0.4,3.5]; // straight part of screw head
screwheadh=screwheadhtable[screw];
screwsinkhtable=[2-screwheadh,2-screwheadh,0]; // Countersink part of screw head
screwsinkh=screwsinkhtable[screw];
screwltable=[35,30,20+screwheadh]; // Countersink screws total, flat heads includes head
screwl=screwltable[screw];
nutd=6.9;
nuth=2.3;

wall=1.6;
thinwall=1.2;
mediumwall=2;
thickwall=2.5;
cornerd=wall-0.5;
sidewall=3;

shellyxtolerance=0;//0.10;
shellyytolerance=0;//0.10;
shellyztolerance=0.10;

shellyw=42.4;
shellyl=37.9;
shellyh=16.77;
shellywl=29;
shellyendw=22;
shellycornerd=2;
shellynarrowingw=shellyw-4;
shellynarrowingl=3;

shellycontactdepth=6;
shellycontactw=30;
shellycontacts=7;
shelly1contactstep=shellycontactw/(shellycontacts-1);
shelly1contactscrewd=4;
shelly1contactscrewdepth=3.3;
shelly1contactw=4;
shelly1contactheight=5;
shelly1contacth=5.2;
shelly1contactdepth=1;
shellyoffset=0.2;
shellycontactblockheight=4.2;
shelly1contactgap=0.93;
shellycontactblockw=shellycontactw+shelly1contactw+shelly1contactgap;
shellycontactblockh=11;
shellycontacth=shellycontactblockh+shellycontactblockheight-0.1;
shellycontactblockspacew=35.5;
shellycontactblockspaceheight=shellycontactblockheight-0.1;
shellycontactblockspaceh=shellycontactblockh+0.2;
shellycontactblockspacedepth=shellycontactdepth+0.1;
shellycontactblockcornerd=0.5;
shellycontactblockslopel=1;
shellycontactblockslopeh=4.2;
shellylabell=shellycontactdepth+1;
shellyresetl=29.8; //.8;
// 29.8; ???
shellyresety=8.3; //8.1;
shellyresetd=3.9;
dincaseresetbuttond=shellyresetd-1;
shellyresetdepth=0.53+ztolerance; // When pressed down
shellytextsize=2.5;
shellyclipl=10;
shellycliph=4;
shellyclipw=2.7;
shellyclipcut=0.5;

contactw=6.9;
contactholew=5.2;
contactl=19.38;
contacth=7.8;
contactcornerd=1;
contactholeh=5.33;
contactblockw=17.07;
contactblockmidl=5.2;
contactblockmidw=contactblockw-contactw*2+contactcornerd*2;
contactblockmidholed=3.22;
contactblockscrewd=3;
contactpressd=7.06;
contactpressendd=2;
contactpressl=18;
contactpressw=5.65;
contactblockpressw=contactblockw+(contactpressd-contactw)*2+0.1;
contactpressh=2.11;
contactpressmidsupporth=1.8;
contactpressheight=contacth+contactpressmidsupporth;
contactpressmidsupportl=4.54;
contactpressmidsupportw=4.88;
contactpresscutd=55;
contacttotalh=contacth+contactpressmidsupporth+contactpressh;
contactmidh=11;
contactworkspace=7.5;

dincaseunitw=18-ytolerance;
//dincasew=2*18-ytolerance;
dincasew=83;
dincasetopw=45; // Seems variable 45.15-46
dincaseh=2*18-ytolerance; //44;
dincasetopl=67;
dincasecontactx=17.76;
dinbaseh=6;
dincasel=44+dinbaseh;
dincasesidew=(dincasew-dincasetopw)/2-ytolerance;
dincasesidel=dincasel-(dincasecontactx+contacttotalh+contactworkspace); // wall-xtolerance-x+tolerance+s
dincasesideinsidel=dincasel-wall-xtolerance-(dincasecontactx+contacttotalh+contactworkspace+wall+xtolerance);
dincasesidex=dincasecontactx+contacttotalh+contactworkspace;
dincasesplith=dincaseh/2+contactblockw/2;
dincasecoverh=dincaseh-dincasesplith-ztolerance;
dincasesideh=dincaseh/2-contactblockw/2;
dincaseedgeh=4; // How much cover edges go inside each other for closing etc
dincaseshellymidsupporty=-dincasetopw/4+wall*3;

shellyx=dincasecontactx+contacth+wall; //xx
shellyclipx=shellyx+shellyclipl;
shellyy=0;
shellyheight=wall+ytolerance+11; //wall+ytolerance+10;
resetpusherheight=shellyheight-1;
shellyclipcutheight=shellyheight+shellyh/2;
shellyclipcuth=shellyh/2+shellycliph+shellyztolerance+0.01;
shellyclipcuttopheight=shellyheight+shellyh+shellyztolerance+shellycliph;

resetbuttonpusherw=4;

dincaseresetbuttonx=shellyx+shellyresetl;
dincaseresetbuttonheight=resetpusherheight-shellyresetdepth-ztolerance;
dincaseresetbuttony=-shellyw/2+shellyresety;
dincaseresetbuttonbodyl=shellyresetd*1.5;
dincaseresetbuttonbodyoutl=shellyresetd*2.5;
dincaseresetbuttonl=shellyresetd*2;
dincaseresetbuttonbodyx=dincaseresetbuttonx-dincaseresetbuttonbodyl/2;
dincaseresetbuttonbodyw=sidewall+ytolerance+resetbuttonpusherw+ytolerance+sidewall;
dincaseresetbuttontunnelw=wall+ytolerance+resetbuttonpusherw+ytolerance+wall;
buttoney=wall;
resetbuttonpusherew=4+buttoney;
dincaseresetbuttonbodyew=dincaseresetbuttonbodyw+buttoney;
dincaseresetzmovement=resetpressed?shellyresetdepth:0;
dincaseresetxmovement=resetpressed?dincaseresetbuttonl/2:0;

dinrailw=35.1+ytolerance*2;
dinrailh=1;

resetbuttonpusheroutl=dincaseresetbuttonbodyoutl+2;
resetbuttonbx=0;
resetbuttonx=dincaseresetbuttonx-resetbuttonbx;
resetbuttonpusherl=dincaseresetbuttonbodyl;//shellyresetd*2;
resetbuttonpushertotall=dincasetopl-dincaseresetbuttonx+dincaseresetbuttonbodyl+resetbuttonpusheroutl;
resetbuttonpusherh=resetpusherheight-ztolerance-wall-ztolerance-shellyresetdepth-wall;
resetbuttonspringx=shellyx-4;//wall  . dincasecontactx+contacttotalh+1;
resetbuttonspringl=dincaseresetbuttonx-resetbuttonspringx-dincaseresetbuttonbodyl/2;
resetbuttonspringh=resetbuttonpusherh-shellyresetdepth*2-0.1;
resetbuttonspringthickness=1;
resetbuttonspringcoils=6;
resetbuttonspringtension=0.5;

dincaseresetbuttonspacew=ytolerance+resetbuttonpusherw+ytolerance;
dincaseresetbuttonspaceh=ztolerance+resetbuttonpusherh-shellyresetdepth*2+ztolerance;

dincaseresetbuttonsupportl=dincaseresetbuttonbodyx-resetbuttonspringx-maxbridge; //shellyresetd*2;

dinclipheight=6;//4.5; 6-wall;
dincliph=dincaseh-dinclipheight*2;
dincasebottomw=(dincasew-dinrailw)/2;
dinclipl=dinbaseh-wall;
dinclipholdh=dinbaseh-wall-xtolerance-xtolerance-dinrailh; // -xtolerance-xtolerance; Remember add these for cut
dinclipholdl=1;
dinclipout=2.2; // 2.6 in tomzn
dinclipmovement=3.5; //4
dinclipspringl=dincasecontactx-wall-xtolerance-xtolerance-wall;
dinclipspringh=4;
dinclipspringrooth=dincliph-dinclipspringl/2;
dinclipbodyl=3;
dinclippulloutholew=3;
dinclippulloutholeh=12;
dinclippulloutholeheight=dincaseh/2-dinclippulloutholeh/2;
dinclippullouty=-dincasew/2-wall-3;//dinclippulloutholew;
dinclippulloutw=wall+dinclippulloutholew+wall*3;

switchw=20;
switchh=6.8;
switchl=14.5;
switchsw=21.4; // Locking width
switchsh=5.5; // Locking h
switchsl=10;
switchfw=21.3;
switchfh=9.33;
switchfl=2;

switchcablew=6; // Width for cable opening

switchy=dincasetopw/4-wall*3-wall/2; // switchw/2-3;
switchheight=wall+switchh/2+1; // +ztolerance;

switchcontactl=9;
switchcontacth=0.8;
switchcontactw=4.9;
switchcontacty=4.8; // center from width
switchcontactheight=0.7; // From h

// Power switch
module switch() {
  difference() {
    union() {
      translate([-switchl,-switchw/2,-switchh/2]) roundedbox(switchl+switchfl+textdepth-0.01,switchw,switchh,cornerd);
      translate([0,-switchfw/2,-switchfh/2]) roundedbox(switchfl,switchfw,switchfh,cornerd);
      translate([-switchcontactl-switchl+0.01,switchw/2-switchcontacty-switchcontactw/2,-switchh/2+switchcontactheight]) roundedbox(switchcontactl+cornerd/2,switchcontactw,switchcontacth,cornerd);
      translate([-switchcontactl-switchl+0.01,-switchw/2+switchcontacty-switchcontactw/2,switchh/2-switchcontactheight-switchcontacth]) roundedbox(switchcontactl+cornerd/2,switchcontactw,switchcontacth,cornerd);
    }
    translate([switchfl,-switchfw/4,0]) rotate([90,90,90]) linear_extrude(height=textdepth) text("O",font="Liberation Sans:style=Bold",size=textsize-2,halign="center", valign="center");
    translate([switchfl,switchfw/4,0]) rotate([90,90,90]) linear_extrude(height=textdepth) text("1",font="Liberation Sans:style=Bold",size=textsize-2,halign="center", valign="center");
  }
 }

module shelly() {
  difference() {
    union() {
      difference() {
	union() {
	  hull() {
	    translate([shellyoffset,-shellyw/2,0]) roundedbox(shellywl-shellyoffset,shellyw,shellyh-shellycontactblockslopeh,shellycornerd,1);
	    translate([shellyoffset+shellycontactblockslopel+shellynarrowingl,-shellyw/2,0]) roundedbox(shellywl-shellycontactblockslopel-shellyoffset-shellynarrowingl,shellyw,shellyh,shellycornerd,1);
	    translate([shellyoffset+shellycontactblockslopel,-shellynarrowingw/2,0]) roundedbox(shellywl-shellycontactblockslopel-shellyoffset,shellynarrowingw,shellyh,shellycornerd,1);
	    translate([shellyoffset+shellycontactblockslopel,-shellyendw/2,0]) roundedbox(shellyl-shellyoffset-shellycontactblockslopel,shellyendw,shellyh,shellycornerd,1);
	  }
	}
	translate([-0.01,-shellycontactblockspacew/2,shellycontactblockspaceheight]) cube([shellycontactblockspacedepth,shellycontactblockspacew,shellycontactblockspaceh]);
	translate([-0.01,-shellyw/2-0.01,shellycontacth]) cube([shellycontactdepth+0.01,shellyw+0.02,shellyh-shellycontacth+0.01]);
      }
      hull() {
	translate([0,-shellycontactblockw/2,shellycontactblockheight]) roundedbox(shellycontactdepth,shellycontactblockw,shellycontactblockh-shellycontactblockslopeh,shellycontactblockcornerd,1);
	translate([shellycontactblockslopel,-shellycontactblockw/2,shellycontactblockheight]) roundedbox(shellycontactdepth-shellycontactblockslopel,shellycontactblockw,shellycontactblockh,shellycontactblockcornerd,1);
      }
    }

    for (y=[-shellycontactw/2:shelly1contactstep:shellycontactw/2]) {
      translate([shelly1contactscrewdepth,y,shellycontacth-2]) cylinder(d=shelly1contactscrewd,h=2.2,$fn=60);
      translate([-0.01,y-shelly1contactw/2,shelly1contactheight]) cube([shelly1contactdepth+0.01,shelly1contactw,shelly1contacth]);
    }

    w=shelly1contactw;
    w2=shelly1contactw+shelly1contactgap+shelly1contactw;
    w3=shelly1contactw+shelly1contactgap+shelly1contactw+shelly1contactgap+shelly1contactw;
    
    translate([shellylabell+shellytextsize+1,-shellycontactw/2-w/2,shellyh-textdepth+0.01]) cube([1,w,textdepth]);
    translate([shellylabell+shellytextsize/2,-shellycontactw/2,shellyh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text("O",size=shellytextsize,font=textfont,valign="center",halign="center");

    translate([shellylabell+shellytextsize+1,-shellycontactw/2+shelly1contactstep-w/2,shellyh-textdepth+0.01]) cube([1,w,textdepth]);
    translate([shellylabell+shellytextsize/2,-shellycontactw/2+shelly1contactstep,shellyh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text("SW",size=shellytextsize,font=textfont,valign="center",halign="center");

    translate([shellylabell+shellytextsize+1,-shellycontactw/2+shelly1contactstep*3-w3/2,shellyh-textdepth+0.01]) cube([1,w3,textdepth]);
    translate([shellylabell+shellytextsize/2,-shellycontactw/2+shelly1contactstep*3,shellyh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text("L",size=shellytextsize,font=textfont,valign="center",halign="center");

    translate([shellylabell+shellytextsize+1,-shellycontactw/2+shelly1contactstep*5.5-w2/2,shellyh-textdepth+0.01]) cube([1,w2,textdepth]);
    translate([shellylabell+shellytextsize/2,-shellycontactw/2+shelly1contactstep*5.5,shellyh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(textdepth) text("N",size=shellytextsize,font=textfont,valign="center",halign="center");

    translate([shellyl/2+textsize/2,0,shellyh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("ShellyDIN",font="Liberation Sans:style=Bold",size=shellytextsize+1,halign="center", valign="center");
    translate([shellyl/2-textsize/2+1,0,shellyh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=shellytextsize+2,halign="center", valign="center");
    
    // Reset button
    translate([shellyresetl,-shellyw/2+shellyresety,-0.01]) cylinder(d=shellyresetd,h=shellyresetdepth+0.01,$fn=60);
  }
}

module contactpair() {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([-contactl/2,-contactblockw/2,0]) roundedbox(contactl,contactw,contacth,contactcornerd);

	  for (ml=[0,1]) mirror([ml,0,0]) {
	      hull() {
		translate([-contactpressl/2+contactpressd/2,-contactblockw/2+contactw/2,contactpressheight]) cylinder(d=contactpressd,h=contactpressh,$fn=60);
		translate([contactpressl/2-contactpressendd/2,-contactblockw/2+contactw/2,contactpressheight]) cylinder(d=contactpressendd,h=contactpressh,$fn=60);
	      }
	    }

	  translate([-contactpressmidsupportl/2,-contactblockw/2+contactw/2-contactpressmidsupportw/2,contacth-contactcornerd/2]) roundedbox(contactpressmidsupportl,contactpressmidsupportw,contactpressmidsupporth+contactcornerd,contactcornerd);
	}

      translate([-contactblockmidl/2,-contactblockmidw/2,0]) roundedbox(contactblockmidl,contactblockmidw,contacth,contactcornerd);
    }

    for (m=[0,1]) mirror([0,m,0]) {
	translate([-contactl/2-0.01,-contactblockw/2+contactw/2-contactholew/2,contacth/2-contactholeh/2]) cube([contactl+0.02,contactholew,contactholeh]);
      }

    translate([0,-contactblockpressw/2,contactmidh+contactpresscutd/2+0.7]) rotate([-90,0,0]) cylinder(d=contactpresscutd+contactpressh,h=contactblockpressw,$fn=120);

    translate([0,0,-0.01]) cylinder(d=contactblockmidholed,h=contacth+0.02,$fn=60);
  }
}

module dinclipspace() {
  // Space for internals
  translate([wall,-ytolerance-dincasew/2+wall,-ztolerance+dinclipheight]) cube([xtolerance+dinclipl+xtolerance,-wall+ytolerance+dincasebottomw+ytolerance-wall*2,ztolerance+dincliph+ztolerance]);

  // Opening for din rail clip
  translate([wall,-dincasew/2+dincasebottomw-wall*2-ytolerance-0.01,dinclipheight-ztolerance]) cube([xtolerance+dinclipholdh+xtolerance,ytolerance+wall*2+ytolerance+0.02,ztolerance+dincliph+ztolerance]);
  
  // Opening for clip pullout 
  translate([wall,-dincasew/2-ytolerance-0.01,dinclipheight-ztolerance]) cube([xtolerance+dinclipbodyl+xtolerance,ytolerance+wall+ytolerance+0.02,ztolerance+dincliph+ztolerance]);

  // Space for leaf spring
  hull() {
    translate([wall,-dincasew/2+wall-ytolerance+dinclipmovement,dinclipheight-ztolerance]) cube([xtolerance+dinclipspringl+xtolerance,ytolerance+wall+ytolerance,ztolerance+dincliph+ztolerance]);
    translate([wall,-dincasew/2+wall-ytolerance,dinclipheight-ztolerance]) cube([xtolerance+dinclipl+xtolerance,ytolerance+wall+ytolerance,ztolerance+dincliph+ztolerance]);
  }
}

module dinclip() {
  difference() {
    union() {
      // Body
      translate([wall+xtolerance,-dincasew/2+wall,dinclipheight]) roundedbox(dinclipbodyl,-wall+dincasebottomw-wall*2,dincliph,cornerd,1);
      difference() {
	translate([wall+xtolerance,-dincasew/2+wall+dinclipmovement,dinclipheight]) roundedbox(dinclipl,-wall+dincasebottomw-wall*2-dinclipmovement,dincliph,cornerd,1);
	translate([wall+xtolerance+dinclipholdl,-dincasew/2+wall+dinclipmovement-0.01,dinclipheight+dincliph/2-dinclipspringrooth/2-0.1]) cube([dinclipl-dinclipholdl+0.01,wall+cornerd+0.5,dinclipspringrooth+0.2]);
      }

      // Din rail clip
      hull() {
	w=wall*2+cornerd;
	translate([wall+xtolerance+dinclipholdh-0.8-xtolerance,-dincasew/2+dincasebottomw-w,dinclipheight]) roundedbox(0.8,w+dinclipout,dincliph,cornerd,1);
	translate([wall+xtolerance,-dincasew/2+dincasebottomw-w,dinclipheight]) roundedbox(dinclipholdh,w,dincliph,cornerd,1);
      }
  
      // Pullout
      difference() {
	translate([wall+xtolerance,-dincasew/2-dinclippulloutw,dinclipheight]) roundedbox(dinclipbodyl,wall+dinclippulloutw+cornerd,dincliph,cornerd,1);
	translate([wall+xtolerance-cornerd/2,dinclippullouty,dinclippulloutholeheight]) roundedbox(dinclipbodyl+cornerd,dinclippulloutholew,dinclippulloutholeh,cornerd);
      }

      // Leaf spring
      c=cornerd*2;
      minkowski() {
	sphere(d=cornerd,$fn=30);
	difference() {
	  hull() {
	    translate([wall+xtolerance+cornerd/2,-dincasew/2+wall+dinclipmovement+cornerd/2,dinclipheight+dincliph/2-dinclipspringrooth/2+cornerd/2]) cube([dinclipbodyl+wall-cornerd,wall-cornerd,dinclipspringrooth-cornerd]);
	    translate([wall+xtolerance+cornerd/2,-dincasew/2+wall+dinclipmovement+cornerd/2,dinclipheight+dincliph/2-dinclipspringh/2+cornerd/2]) cube([dinclipspringl-cornerd,wall-cornerd,dinclipspringh-cornerd]);
	  }

	  h=dinclipspringrooth-dinclipspringh-cornerd*2*sqrt(2);
	  hull() {
	    for (z=[dinclipheight+dincliph/2-h/2+cornerd/2,dinclipheight+dincliph/2+h/2-cornerd/2]) {
	      translate([wall+xtolerance+dinclipbodyl+c/2,-dincasew/2+wall+dinclipmovement+cornerd/2-0.01,z]) rotate([-90,0,0]) cylinder(d=c,h=wall-cornerd+0.02,$fn=30);
	    }
	    translate([wall+xtolerance+dinclipbodyl+dinclipspringl-h/2-dinclipspringh/2,-dincasew/2+wall+dinclipmovement+cornerd/2-0.01,dinclipheight+dincliph/2]) rotate([-90,0,0]) cylinder(d=c,h=wall-cornerd+0.02,$fn=30);
	  }
	}
      }
    }

    translate([wall+xtolerance+textdepth-0.01,-dincasew/2+dincasebottomw/2-1,dincaseh/2]) rotate([90,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-1,halign="center", valign="center");
  }
}

basescrewx=dinbaseh+2+screwheadd/2;
basescrewy=-dincasew/2+contactl-screwheadd/2+1;
//basescrewheight=dincasesplith+5;
screwheighttable=[dincaseh-(dincaseh-screwl)/2,dincaseh-(dincaseh-screwl)/2,dincasesplith+5];
basescrewheight=screwheighttable[screw];

topscrewx=((dincasecontactx+contacttotalh+contactworkspace+wall+xtolerance)+(dincasel-wall-xtolerance))/2; // wall-xtolerance-x+tolerance+shellyxtolerance+shellywl+cornerd/2; //dincasel-2-screwheadd/2;
topscrewy=-dincasew/2+2+screwheadd/2+cornerd/2;

screwtowerwall=wall*2;

maxscrewtowerd=screwheadd+screwtowerwall+wall;

screwheight=basescrewheight; //dincasesplith+2*wall;
  
module screwtower(x,y) {
  hull() {
    translate([x,y,screwheight-screwsinkh-screwheadh-wall]) roundedcylinder(screwd+screwtowerwall+screwdtolerance,dincaseh-(screwheight-screwsinkh-screwheadh-wall),cornerd,0,60);
    translate([x,y,screwheight-screwheadh-wall]) roundedcylinder(screwheadd+screwtowerwall+screwdtolerance,dincaseh-(screwheight-screwheadh-wall),cornerd,0,60);
  }

  translate([x,y,screwheight-screwl]) cylinder(d=screwd+screwtowerwall+screwdtolerance,h=screwl,$fn=60);
  
  hull() {
    translate([x,y,-0.01]) cylinder(d=nutd/cos(180/6)+screwtowerwall+screwdtolerance,h=screwheight-screwl+nuth+wall,$fn=6);
    translate([x,y,-0.01]) cylinder(d=screwd+screwtowerwall+screwdtolerance,h=screwheight-screwl+nuth+nutd/screwd+wall,$fn=60);
  }
  hull() {
    translate([x,y,-0.01]) cylinder(d=nutd/cos(180/6)+screwtowerwall+screwdtolerance,h=screwheight-screwl+0.02,$fn=6);
    translate([x,y,-0.01]) cylinder(d=nutd/cos(180/6)+screwtowerwall+2+screwdtolerance,h=0.1,$fn=6);
  }
}

module screwcut(x,y) {
  difference() {
    union() {
      translate([x,y,screwheight-screwheadh+screwheadh-0.01]) cylinder(d1=screwheadd+screwdtolerance,d2=screwheadd+screwdtolerance+(dincaseh-screwheight),h=dincaseh-screwheight+0.02,$fn=60);
      hull() {
	translate([x,y,screwheight-screwheadh]) cylinder(d=screwheadd+screwdtolerance,h=screwheadh+0.1,$fn=60);
	translate([x,y,screwheight-screwsinkh-screwheadh]) cylinder(d1=screwd+screwdtolerance,d2=screwheadd+screwdtolerance,h=screwsinkh+0.1,$fn=60);
      }
    }
    if (support && screwsinkh==0 && screwheadh>0.9) {
      translate([x,y,screwheight-screwheadh]) supportcylinder(screwheadd+screwdtolerance,dincaseh-screwheight+screwheadh,2);
    }
  }
  translate([x,y,screwheight-screwl]) cylinder(d=screwd+screwdtolerance,h=screwl+0.1,$fn=60);
  hull() {
    translate([x,y,-0.01]) cylinder(d=nutd/cos(180/6)+screwdtolerance,h=screwheight-screwl+nuth+0.02,$fn=6);
    translate([x,y,-0.01]) cylinder(d=screwd+screwdtolerance,h=screwheight-screwl+nuth+nutd/screwd+0.02,$fn=60);
  }
  hull() {
    translate([x,y,-0.01]) cylinder(d=nutd/cos(180/6)+screwdtolerance,h=screwheight-screwl+0.02,$fn=6);
    translate([x,y,-0.01]) cylinder(d=nutd/cos(180/6)+screwdtolerance+min((screwheight-screwl)*2,2),h=0.01,$fn=6);
  }
}

module screwcutouts() {
  for (m=[0,1]) mirror([0,m,0]) {
      screwcut(basescrewx,basescrewy);
      screwcut(topscrewx,topscrewy);
 }
}

module screw(x,y) {
  color("blue") {
    // Screw head
    hull() {
      // Straigth part
      translate([x,y,screwheight-screwheadh]) cylinder(d=screwheadd,h=screwheadh,$fn=60);
      // Countersink part
      translate([x,y,screwheight-screwsinkh-screwheadh]) cylinder(d1=screwd,d2=screwheadd,h=screwsinkh,$fn=60);
    }
    // Screw shaft
    translate([x,y,screwheight-screwl]) cylinder(d=screwd,h=screwl,$fn=60);
    // Nut
    translate([x,y,screwheight-screwl]) cylinder(d=nutd/cos(180/6),h=nuth,$fn=6);
  }
}

module screws() {
  for (m=[0,1]) mirror([0,m,0]) {
      screw(basescrewx,basescrewy);
      screw(topscrewx,topscrewy);
 }
}

module shellyclips(t) {
  for (m=[0,1]) mirror([0,m,0]) {
      // Clips to keep the shelly in place
      translate([shellyclipx-t,-dincasetopw/2-t,shellyheight+shellyh]) {
	hull() {
	  roundedbox(shellyclipl+t*2,shellyclipw+t*2,wall,cornerd);
	  translate([0,0,-shellyclipw/1.3+wall]) roundedbox(shellyclipl+t*2,wall+t*2,shellycliph+shellyclipw/1.3-wall,cornerd);
	}
      }
    }
}

module shellydinadapter() {
  difference() {
    union() {
      // Right side
      difference() {
	union() {
	  translate([dinbaseh,-dincasew/2,0]) roundedbox(dincasel-dinbaseh,dincasew,wall,cornerd,1);
	  translate([dinbaseh,-dincasetopw/2,0]) roundedbox(dincasetopl-dinbaseh,dincasetopw,wall,cornerd,1); // dincasew

	  // Top
	  difference() {
	    translate([dincasetopl-wall,-dincasetopw/2,0]) roundedbox(wall,dincasetopw,dincaseh-wall-ztolerance,cornerd,1);
	    translate([dincasetopl-wall-0.01,dincaseresetbuttony-resetbuttonpusherw/2-buttoney-ytolerance,wall]) cube([wall+0.02,ytolerance+resetbuttonpusherew+ytolerance,ztolerance+resetbuttonpusherh+ztolerance]);
	  }
	  
	  // top shelly support
	  difference() {
	    translate([dincasetopl-wall*2,-dincasetopw/2,0]) roundedbox(wall+cornerd,dincasetopw,shellyheight,cornerd,1);
	    translate([dincasetopl-wall*2-0.01,dincaseresetbuttony-resetbuttonpusherw/2-buttoney-ytolerance,wall]) cube([wall+cornerd+0.02,ytolerance+resetbuttonpusherew+ytolerance,ztolerance+resetbuttonpusherh+ztolerance]);
	    w=ytolerance+sidewall+ymtolerance+resetbuttonpusherw+ytolerance+sidewall+ymtolerance;
	    translate([dincaseresetbuttonbodyx-xmtolerance,dincaseresetbuttony-w/2-buttoney,wall]) cube([xmtolerance+dincaseresetbuttonbodyoutl+xmtolerance,w+buttoney,shellyheight+shellyztolerance-wall]);
	  }
	  difference() {
	    translate([shellyx+shellyl+shellyxtolerance,-dincasetopw/2,0]) roundedbox(wall,dincasetopw,shellyheight+shellyh,cornerd,1);
	    translate([shellyx+shellyl+shellyxtolerance-0.01,dincaseresetbuttony-resetbuttonpusherw/2-buttoney-ytolerance,wall]) cube([wall+0.02,ytolerance+resetbuttonpusherew+ytolerance,ztolerance+resetbuttonpusherh+ztolerance]);
	  }

	  // Supports for shelly
	  for (m=[0,1]) mirror([0,m,0]) {
	      translate([shellyx-shellyxtolerance-wall,-dincasetopw/2+wall-cornerd/2,0]) roundedbox(dincasetopl-shellyx+wall+shellyxtolerance,wall+cornerd/2,shellyheight,cornerd,1);
	      translate([shellyx-shellyxtolerance-wall,dincaseshellymidsupporty,0]) roundedbox(dincasetopl-shellyx+wall+shellyxtolerance,wall,shellyheight,cornerd,1);
	    }
	}

	// Cut holes for lifting button press mechanism
	for (y=[-buttoney,dincaseresetbuttonbodyw-sidewall]) {
	  translate([dincaseresetbuttonbodyx-xmtolerance,y+dincaseresetbuttony-dincaseresetbuttonbodyw/2-ymtolerance,-0.01]) cube([xmtolerance+dincaseresetbuttonbodyoutl+xmtolerance,ymtolerance+sidewall+ymtolerance,shellyheight+0.02]);
	}
      }
    

      for (m=[0,1]) mirror([0,m,0]) {
	  intersection() {
	    screwtower(basescrewx,basescrewy);
	    translate([basescrewx,basescrewy,0]) cylinder(d=maxscrewtowerd,h=dincaseh/2+contactblockw/2,$fn=60);
	    translate([0,-dincasew/2,0]) roundedbox(dincasecontactx-xtolerance,contactl+screwheadd,dincasesplith,cornerd);
	  }

	  intersection() {
	    screwtower(topscrewx,topscrewy);
	    union() {
	      translate([topscrewx,topscrewy,0]) cylinder(d=maxscrewtowerd,h=dincasesideh-ztolerance,$fn=60);
	      translate([dincasesidex+wall+xtolerance,-dincasew/2+wall+ytolerance,dincasesideh-cornerd]) roundedbox(dincasesideinsidel,-wall-ytolerance+dincasesidew-wall-ytolerance,dincaseedgeh+cornerd,cornerd);
	    }
	    //translate([0,-dincasew/2,0]) roundedbox(dincasecontactx-xtolerance,contactl+screwheadd,dincasesplith,cornerd);
	  }
	}
	  
      // Bottom base
      translate([0,-dincasew/2,0]) roundedbox(dinbaseh+wall,dincasebottomw,dincasesplith,cornerd,1); // dincaseh
      
      // Top base
      translate([0,dinrailw/2,0]) roundedbox(dinbaseh+wall,(dincasew-dinrailw)/2,dincasesplith,cornerd,1);
      hull() {
	translate([0,dinrailw/2,0]) roundedbox(dinbaseh-xtolerance-dinrailh,(dincasew-dinrailw)/2,dincasesplith,cornerd,1);
	translate([0,dinrailw/2-dinbaseh/1.5,0]) roundedbox(cornerd,(dincasew-dinrailw)/2+dinbaseh/1.5,dincasesplith,cornerd,1);
      }
      translate([dinbaseh,-dincasew/2,0]) roundedbox(thickwall,dincasew,dincasesplith,cornerd,1);

      // Bases for contact blocks
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([dinbaseh,-dincasew/2,0]) roundedbox(dincasecontactx-dinbaseh-xtolerance,contactl,dincaseh/2+contactblockw/2,cornerd,1);
	  translate([dinbaseh,-dincasew/2,0]) roundedbox(dincasel-dinbaseh,(dincasew-dincasetopw)/2+cornerd/2,dincasesideh-ztolerance,cornerd,1);
	  //x=dincasecontactx+contacttotalh+contactworkspace+wall;
	  translate([dincasesidex+wall+xtolerance,-dincasew/2+wall+ytolerance,dincasesideh-cornerd]) roundedbox(dincasesideinsidel,-wall-ytolerance+dincasesidew-wall-ytolerance,dincaseedgeh+cornerd,cornerd);
	}

      // Structure around top and shelly
      difference() {
	for (m=[0,1]) mirror([0,m,0]) {
	    translate([shellyx-wall-shellyxtolerance,-dincasetopw/2,0]) roundedbox(dincasetopl-shellyx+wall+shellyxtolerance,wall,dincaseh-wall-ztolerance,cornerd,1);
	  }
	
	translate([shellyx-shellyxtolerance,-shellyw/2-shellyytolerance,shellyheight-shellyztolerance]) roundedbox(shellyxtolerance+shellywl+cornerd/2,shellyytolerance+shellyw+shellyytolerance,dincaseh-shellyheight-shellyztolerance-wall,cornerd);
      }

      // Front cover
      difference() {
	translate([shellyx-shellyxtolerance-wall,-dincasetopw/2,wall-cornerd/2]) roundedbox(wall,dincasetopw,shellyheight+3,cornerd);

	if (powerswitch) {
	  translate([shellyx-shellyxtolerance-wall-0.01,-switchcablew/2,wall]) cube([wall+0.02,switchcablew,shellyheight+3]);
	  translate([shellyx-shellyxtolerance-wall-0.01,-dincaseshellymidsupporty+switchcablew/2-wall,wall]) cube([wall+0.02,switchcablew,shellyheight+3]);
	}
      }

      for (m=[0,1]) mirror([0,m,0]) {
	  // Front side covers
	  translate([shellyx-shellyxtolerance-wall,-dincasetopw/2,wall-cornerd/2]) roundedbox(wall,4,dincaseh-wall+cornerd/2-wall-ztolerance,cornerd);
	  translate([shellyx-shellyxtolerance-wall*1.5,-dincasew/2+contactl+ytolerance,wall-cornerd/2]) roundedbox(wall/2+cornerd,wall,dincaseh-wall+cornerd/2-wall-ztolerance,cornerd);
	}

      shellyclips(0);

      // Back clip - this does not seem to be useful
      if (0) hull() {
	  translate([shellyx+shellyl-shellyclipw+wall,-shellyclipl/2,shellyheight+shellyh]) roundedbox(shellyclipw,shellyclipl,wall,cornerd);
	  translate([shellyx+shellyl,-shellyclipl/2,shellyheight+shellyh-shellyclipw/1.3+wall]) roundedbox(wall,shellyclipl,shellycliph+shellyclipw/1.3-wall,cornerd);
	}

      for (m=[0,1]) mirror([0,m,0]) {
	  translate([dincasecontactx-0.1-xtolerance,-dincasew/2+contactl/2,dincaseh/2]) rotate([90,0,90]) cylinder(d1=contactblockscrewd,d2=contactblockscrewd/3,h=contactblockscrewd/2+0.01,$fn=60);

	  // Keep contact blocks in place (bottom)
	  hull() {
	    translate([dincasecontactx+contacth,-dincasew/2+2,dincaseh/2-contactblockw/2-ztolerance-cornerd/2]) roundedbox(1,contactl-4,1+cornerd/2,cornerd);
	    translate([dincasecontactx+contacth,-dincasew/2+contactl/2-cornerd/2,dincaseh/2-contactblockw/2-ztolerance-cornerd/2]) roundedbox(contactpressmidsupporth-ztolerance,cornerd,1+cornerd/2,cornerd);
	  }
	}
    
      // Reset button pusher tunnel and mechanism
      translate([0,0,dincaseresetzmovement]) {
	union() {
	  // Notch to lift the button when pushing
	  hull() {
	    translate([dincaseresetbuttonbodyx,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-wall+ztolerance]) roundedbox(dincaseresetbuttonbodyl/2+shellyresetd/2+cornerd/2,dincaseresetbuttonbodyew,wall-ztolerance,cornerd,0);
	    translate([dincaseresetbuttonbodyx,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-wall+ztolerance]) roundedbox(dincaseresetbuttonbodyl+cornerd,dincaseresetbuttonbodyw,cornerd,cornerd,0);
	  }

	  hull() {
	    translate([dincaseresetbuttonbodyx,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-wall+ztolerance]) roundedbox(dincaseresetbuttonbodyl/2+shellyresetd/2+cornerd/2+cornerd/2,dincaseresetbuttonbodyew,cornerd,cornerd,0);
	    translate([dincaseresetbuttonbodyx,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-wall+ztolerance]) roundedbox(dincaseresetbuttonbodyl/2+shellyresetd/2+cornerd/2,dincaseresetbuttonbodyew,wall-ztolerance,cornerd,0);
	    translate([dincaseresetbuttonbodyx,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-shellyresetdepth*2-wall+ztolerance]) roundedbox(cornerd,dincaseresetbuttonbodyew,wall,cornerd,0);
	  }


	  // Notch to hold button in place
	  hull() {
	    translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyl/2+shellyresetd/2+cornerd/2-cornerd,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-cornerd]) roundedbox(cornerd,dincaseresetbuttonbodyew,cornerd,cornerd,0);
	    translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyl,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-wall+ztolerance]) roundedbox(cornerd,dincaseresetbuttonbodyew,cornerd,cornerd,0);
	    translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyoutl-cornerd,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-cornerd/2-cornerd]) roundedbox(cornerd,dincaseresetbuttonbodyew,cornerd,cornerd,0);
	  }

	  hull() {
	    //        translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyl/2+shellyresetd/2+cornerd/2-cornerd,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-(wall-cornerd/2)]) roundedbox(cornerd,dincaseresetbuttonbodyw,cornerd,cornerd,0);
	    translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyl,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-wall+ztolerance]) roundedbox(cornerd,dincaseresetbuttonbodyew,cornerd,cornerd,0);
	    translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyoutl-cornerd,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-cornerd/2-cornerd]) roundedbox(cornerd,dincaseresetbuttonbodyew,cornerd,cornerd,0);
	    translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyoutl-wall-cornerd/2-xtolerance,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney,dincaseresetbuttonheight-shellyresetdepth-wall+ztolerance]) roundedbox(wall,dincaseresetbuttonbodyew,wall,cornerd,0);
	  }
	}

	// Side panels for lifting button presser
	for (y=[sidewall,dincaseresetbuttonbodyew]) {
	  intersection() {
	    hull() {
	      translate([dincaseresetbuttonbodyx,y+dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney-sidewall,-cornerd]) roundedbox(dincaseresetbuttonbodyl/2+shellyresetd/2+cornerd/2,sidewall,dincaseresetbuttonheight+cornerd,cornerd);
	      translate([dincaseresetbuttonbodyx,y+dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney-sidewall,-cornerd]) roundedbox(dincaseresetbuttonbodyoutl,sidewall,cornerd+dincaseresetbuttonheight-cornerd/2,cornerd,1);
	    }
	    translate([dincaseresetbuttonbodyx,y+dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney-sidewall,-dincaseresetzmovement]) cube([dincaseresetbuttonbodyoutl,sidewall,dincaseresetbuttonheight+dincaseresetzmovement]);
	  }
	}

	// Button presser
	hull() {
	  translate([dincaseresetbuttonx,dincaseresetbuttony,dincaseresetbuttonheight-0.01]) cylinder(d1=dincaseresetbuttond+1,d2=dincaseresetbuttond,h=shellyheight-shellyresetdepth-resetpusherheight,$fn=60);
	  translate([dincaseresetbuttonx,dincaseresetbuttony,shellyheight-shellyresetdepth-0.01]) cylinder(d1=dincaseresetbuttond,d2=dincaseresetbuttond/2,h=shellyresetdepth,$fn=60);
	}
      }

      // Top above spring connecting to lifting part
      hull() {
	translate([resetbuttonspringx,dincaseresetbuttony-dincaseresetbuttontunnelw/2,dincaseresetbuttonheight-wall]) roundedbox(wall,dincaseresetbuttontunnelw,wall,cornerd,1);
	translate([resetbuttonspringx+dincaseresetbuttonx-resetbuttonspringx-wall,dincaseresetbuttony-dincaseresetbuttontunnelw/2,dincaseresetbuttonheight-wall+dincaseresetzmovement]) roundedbox(wall,dincaseresetbuttontunnelw,wall,cornerd,1);
      }
      
      // Side panels around the spring
      for (y=[0,dincaseresetbuttontunnelw-wall]) {
	translate([resetbuttonspringx,y+dincaseresetbuttony-dincaseresetbuttontunnelw/2,0]) roundedbox(dincaseresetbuttonsupportl,wall,dincaseresetbuttonheight,cornerd,1);
	translate([resetbuttonspringx,y+dincaseresetbuttony-dincaseresetbuttontunnelw/2,0]) roundedbox(dincaseresetbuttonbodyx-resetbuttonspringx-xtolerance*2-((y==0)?dincaseresetbuttonl/2:0),wall,dincaseresetbuttonheight-wall-zmtolerance,cornerd,1);
      }

      hull() {
	translate([resetbuttonspringx,dincaseresetbuttony-dincaseresetbuttontunnelw/2,dincaseresetbuttonheight-wall]) roundedbox(dincaseresetbuttonsupportl,dincaseresetbuttontunnelw,wall,cornerd,0);
	translate([resetbuttonspringx,dincaseresetbuttony-dincaseresetbuttontunnelw/2,wall+dincaseresetbuttonspaceh]) roundedbox(dincaseresetbuttonsupportl,dincaseresetbuttontunnelw,wall,cornerd,0);
      }

      // End plate of the spring tunnel
      translate([resetbuttonspringx,dincaseresetbuttony-dincaseresetbuttontunnelw/2,0]) roundedbox(wall,dincaseresetbuttontunnelw,dincaseresetbuttonheight,cornerd,1);

    }

    // Peek hole to reset mechanism
    if (peekholes) {
      translate([dincaseresetbuttonbodyx,-dincasetopw/2-0.01,wall*2]) cube([dincaseresetbuttonbodyoutl,wall+wall/2+0.02,resetpusherheight]);
      translate([dincaseresetbuttonbodyx+2,dincaseresetbuttony-dincaseresetbuttonbodyw/2-buttoney-ymtolerance-0.01,wall*2]) cube([dincaseresetbuttonbodyoutl-4,buttoney+sidewall+ytolerance*2+0.02,resetpusherheight-wall*2-3.4]);

      translate([shellyx+shellyl-1-0.01,dincaseresetbuttony-resetbuttonpusherw/2-buttoney-ytolerance,wall+resetbuttonpusherh+1.5]) cube([wall*2+0.02,ytolerance+resetbuttonpusherew+ytolerance,ztolerance+resetbuttonpusherh+ztolerance]);

    }

    if (powerswitch) {
      difference() {
	union() {
	  translate([dincasetopl-switchl-xtolerance,switchy-switchw/2-ytolerance,switchheight-switchh/2-ztolerance]) cube([switchl+xtolerance+0.01,ytolerance+switchw+ytolerance,ztolerance+switchh+ztolerance]);
	  hdiff=shellyheight-(switchheight+switchh/2);
	  hull() {
	    translate([dincasetopl-switchl-xtolerance,switchy-switchw/2-ytolerance,switchheight-switchh/2-ztolerance]) cube([switchl-wall+xtolerance+0.01,ytolerance+switchw+ytolerance,ztolerance+switchh+ztolerance]);
	    translate([dincasetopl-switchl-xtolerance+hdiff,switchy-switchw/2-ytolerance+hdiff,switchheight-switchh/2-ztolerance]) cube([switchl-wall+xtolerance+0.01-hdiff*2,ytolerance+switchw+ytolerance-hdiff*2,ztolerance+switchh+ztolerance+hdiff]);
	  }
	}

	translate([dincasetopl-wall,switchy-switchw/2+1,switchheight-switchh/2-ztolerance]) supportbox(wall,switchw-2,ztolerance+switchh+ztolerance,0);
      }
    }
    
    dinclipspace();

    translate([dincasetopl-textdepth+0.01,dincasetopw/2-textsize+2.5/2+1.5,dincaseh/2]) rotate([90,90,90]) linear_extrude(height=textdepth) text("ShellyDIN",font="Liberation Sans:style=Bold",size=textsize-2.5,halign="center", valign="center");
    translate([dincasetopl-textdepth+0.01,dincasetopw/2-textsize*1.6,dincaseh-wall-2]) rotate([90,90,90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize-1,halign="left", valign="center");

    translate([contactl/2,dincasew/2-textdepth+0.01,dincaseh/2-contactblockw/2+contactw/2]) rotate([-90,-90,0]) linear_extrude(height=textdepth) text("N",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    translate([contactl/2,dincasew/2-textdepth+0.01,dincaseh/2+contactblockw/2-contactw/2]) rotate([-90,-90,0]) linear_extrude(height=textdepth) text("L",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");

    translate([contactl/2,-dincasew/2+textdepth-0.01,dincaseh/2+contactblockw/2-contactw/2]) rotate([90,90,0]) linear_extrude(height=textdepth) text("O",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");

    if (powerswitch) {
      translate([shellyx+textsize,0,wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) scale([0.7,1,1]) text("SW",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
      translate([shellyx+textsize,-dincaseshellymidsupporty+switchcablew-wall,wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text("L",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    }
    
    translate([shellyx-shellyxtolerance-wall-0.01,dincaseresetbuttony-dincaseresetbuttonspacew/2,wall]) cube([wall+0.02,dincaseresetbuttonspacew,dincaseresetbuttonspaceh]);

    // DEBUGGING
    if (0) translate([dincaseresetbuttonx,dincaseresetbuttony,-0.01]) cylinder(d=shellyresetd+0.5,h=shellyheight+1,$fn=60);
    
    for (m=[0,1]) mirror([0,m,0]) {
	//	translate([dinbaseh+wall,-dincasew/2+contactl/2,dincaseh/2]) rotate([90,0,90]) cylinder(d=contactblockscrewd,h=-dinbaseh-wall+dincasecontactx+0.01,$fn=60);

	// Clips cuts for shelly clips
	translate([shellyclipx-shellyclipcut,-dincasetopw/2-0.01,shellyclipcuttopheight]) cube([shellyclipcut+shellyclipl+shellyclipcut,shellyclipw+0.02,shellyclipcut]);
	for (x=[-shellyclipcut,shellyclipl]) {
	  translate([shellyclipx+x,-dincasetopw/2-0.01,shellyclipcutheight]) cube([shellyclipcut,shellyclipw+0.02,shellyclipcuth]);
	}
      }

    if (debugscrewcuts || !debug || print>0) screwcutouts();

    if (0) {
      translate([dincasetopl-shellyclipw-0.01,-shellyclipl/2-shellyclipcut,shellyclipcuttopheight]) cube([shellyclipw+0.02,shellyclipcut+shellyclipl+shellyclipcut,shellyclipcut]);
      for (m=[0,1]) mirror([0,m,0]) {
	  translate([dincasetopl-shellyclipw-0.01,-shellyclipl/2-shellyclipcut,shellyclipcutheight]) cube([shellyclipw+0.02,shellyclipcut,shellyclipcuth]);
	}
    }
  }
}

module dincaseresetbutton(tension) {
  t=ztolerance;
  difference() {
    union() {
      translate([resetbuttonx-dincaseresetbuttonbodyl/2-dincaseresetxmovement,dincaseresetbuttony-resetbuttonpusherw/2-buttoney,wall+t]) roundedbox(resetbuttonbx+cornerd,resetbuttonpusherew,resetbuttonpusherh-shellyresetdepth*2,cornerd);
      hull() {
	translate([dincaseresetbuttonbodyx-dincaseresetxmovement,dincaseresetbuttony-resetbuttonpusherw/2-buttoney,wall+t]) roundedbox(dincaseresetbuttonbodyoutl,resetbuttonpusherew,resetbuttonpusherh-shellyresetdepth*2,cornerd);
	translate([dincaseresetbuttonbodyx+resetbuttonpusherl-wall/2-dincaseresetxmovement,dincaseresetbuttony-resetbuttonpusherw/2-buttoney,wall+t]) roundedbox(wall,resetbuttonpusherew,resetbuttonpusherh,cornerd);
      }
  
      translate([dincaseresetbuttonbodyx+dincaseresetbuttonbodyl-cornerd/2-dincaseresetxmovement,dincaseresetbuttony-resetbuttonpusherw/2-buttoney,wall+t]) roundedbox(resetbuttonpusherl+dincaseresetbuttonbodyl,resetbuttonpusherew,resetbuttonpusherh-shellyresetdepth,cornerd);

      translate([resetbuttonspringx+wall-tension,dincaseresetbuttony-resetbuttonpusherw/2,wall+t]) roundedbox(wall,resetbuttonpusherw,resetbuttonspringh,cornerd);
      l=resetbuttonspringl+tension-xtolerance;
      translate([resetbuttonspringx+wall+xtolerance-tension,dincaseresetbuttony-resetbuttonpusherw/2,wall+t]) scale([(l-dincaseresetxmovement)/l,1,1]) rotate([0,-90,-90]) flatspring(l,resetbuttonspringh,resetbuttonpusherw,resetbuttonspringthickness,resetbuttonspringcoils,0.1);
    }
    
    translate([resetbuttonx+dincaseresetbuttonbodyl/2,dincaseresetbuttony-resetbuttonpusherw/2-buttoney+textdepth-0.01,wall+t+resetbuttonpusherh/2]) rotate([90,0,0]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=resetbuttonspringh-3,halign="center", valign="center");
  }
}

module shellydinadaptercover() {
  difference() {
    union() {
      // Screw towers
      for (m=[0,1]) mirror([0,m,0]) {
	  intersection() {
	    screwtower(basescrewx,basescrewy);
	    translate([basescrewx,basescrewy,dincasesplith+ztolerance]) cylinder(d=maxscrewtowerd,h=dincasecoverh,$fn=60);
	  }
	  intersection() {
	    screwtower(topscrewx,topscrewy);
	    translate([topscrewx,topscrewy,dincaseedgeh+dincasesideh+ztolerance]) cylinder(d=maxscrewtowerd,h=dincaseh-dincasesideh-dincaseedgeh,$fn=60);
	  }
	}
      
      // Left side
      if (print>0 || !debug) {
	union() {
	  translate([dinbaseh,-dincasew/2,dincaseh-wall]) roundedbox(dincasel-dinbaseh,dincasew,wall,cornerd,1);
	  translate([dinbaseh,-dincasetopw/2,dincaseh-wall]) roundedbox(dincasetopl-dinbaseh,dincasetopw,wall,cornerd,1); // dincasew
	}
      }

      for (m=[0,1]) mirror([0,m,0]) {
	  translate([shellyx-shellyxtolerance+xtolerance,-dincasetopw/2+wall+ytolerance,dincaseh-wall-dincaseedgeh]) roundedbox(dincasetopl-wall-xtolerance-shellyx+shellyxtolerance-xtolerance,wall,dincaseedgeh+wall,cornerd);
	  hull() {
	    translate([shellyx-shellyxtolerance+xtolerance,-dincasetopw/2+wall+ytolerance,dincaseh-wall-dincaseedgeh]) roundedbox(-xtolerance+shellyxtolerance+shellywl+shellyxtolerance-xtolerance+cornerd/2,wall,dincaseedgeh+wall,cornerd);
	    translate([shellyx-shellyxtolerance+xtolerance,-shellyw/2-shellyytolerance+ytolerance,dincaseh-wall-dincaseedgeh]) roundedbox(-xtolerance+shellyxtolerance+shellywl+shellyxtolerance-xtolerance+cornerd/2,wall,dincaseedgeh+wall,cornerd);
	  }
	}

      for (x=[shellyx-shellyxtolerance+xtolerance,dincasetopl-wall-xtolerance-wall]) {
	translate([x,-dincasetopw/2+wall+ytolerance,dincaseh-wall-dincaseedgeh]) roundedbox(wall,-ytolerance-wall+dincasetopw-wall-ytolerance,dincaseedgeh+wall,cornerd);
      }
      
      // Structure to keep shelly in place
      h=dincaseh-shellyheight-shellyh-wall-ztolerance-shellyztolerance; //-ztolerance; Slightly pressing shelly in place
      if (0) for (x=[shellyx+5,shellyx+shellyresetl]) {
	hull() {
	  translate([x,-shellyw/2+shellyresety+h+wall,shellyheight+shellyh]) roundedbox(wall,shellyw-shellyresety*2-h*2-wall*2,wall,cornerd);
	  translate([x+(x>shellyx+5?-h:h),-shellyw/2+shellyresety+h+wall,shellyheight+shellyh+h]) roundedbox(wall,shellyw-shellyresety*2-h*2-wall*2,wall,cornerd);
	}
      }
      for (y=[-shellyw/2+shellyresety,shellyw/2-shellyresety-wall]) {
	hull() {
	  translate([shellyx+5,y,shellyheight+shellyh]) roundedbox(shellyresetl-5+wall,wall,wall,cornerd);
	  translate([shellyx+5,y-sign(y)*h,shellyheight+shellyh+h]) roundedbox(shellyresetl-5+wall,wall,wall,cornerd);
	}
      }
      
      // Bottom base
      translate([0,-dincasew/2,dincasesplith+ztolerance]) roundedbox(dinbaseh+wall,dincasebottomw,dincasecoverh,cornerd,1); // dincaseh
      
      // Top base
      translate([0,dinrailw/2,dincasesplith+ztolerance]) roundedbox(dinbaseh+wall,(dincasew-dinrailw)/2,dincasecoverh,cornerd,1);
      hull() {
	translate([0,dinrailw/2,dincasesplith+ztolerance]) roundedbox(dinbaseh-xtolerance-dinrailh,(dincasew-dinrailw)/2,dincasecoverh,cornerd,1);
	translate([0,dinrailw/2-dinbaseh/1.5,dincasesplith+ztolerance]) roundedbox(cornerd,(dincasew-dinrailw)/2+dinbaseh/1.5,dincasecoverh,cornerd,1);
      }
      translate([dinbaseh,-dincasew/2,dincasesplith+ztolerance]) roundedbox(thickwall,dincasew,dincasecoverh,cornerd,1);

      for (m=[0,1]) mirror([0,m,0]) {
	  translate([dinbaseh,-dincasew/2,dincasesplith+ztolerance]) roundedbox(dincasecontactx+contacth-dinbaseh-xtolerance,contactl,dincasecoverh,cornerd,1);
	  translate([dinbaseh,-dincasew/2,dincasesplith+ztolerance]) roundedbox(dincasel-dinbaseh,dincasesidew,dincasecoverh,cornerd,1);
	  translate([dincasecontactx+contacttotalh+contactworkspace,-dincasew/2,dincasesideh]) roundedbox(wall,dincasesidew-contactl/2+wall,dincaseh-dincasesideh,cornerd);
	  x=dincasecontactx+contacttotalh+contactworkspace;
	  translate([x,-dincasew/2,dincasesideh]) roundedbox(wall,dincasesidew,dincaseh-dincasesideh,cornerd);
	  translate([dincasecontactx+contactmidh,-dincasew/2+dincasesidew-contactl/2,dincasesideh]) roundedbox(dincasel-dincasecontactx-contactmidh-(dincasel-x)+wall,wall,dincaseh-dincasesideh,cornerd);
	  translate([dincasecontactx+contacttotalh,-dincasew/2+dincasesidew-contactl/2,dincasesideh]) roundedbox(wall,contactl/2,dincaseh-dincasesideh,cornerd);
	  translate([dincasecontactx+contacttotalh,-dincasew/2+dincasesidew-wall,dincasesideh]) roundedbox(dincasel-dincasecontactx-contacttotalh,wall,dincaseh-dincasesideh,cornerd);
	  translate([x,-dincasew/2,dincasesideh]) roundedbox(dincasel-x,wall,dincaseh-dincasesideh,cornerd);
	  translate([dincasel-wall,-dincasew/2,dincasesideh]) roundedbox(wall,dincasesidew,dincaseh-dincasesideh,cornerd);
	  //	  translate([dinbaseh,-dincasew/2,dincasesplith+ztolerance]) roundedbox(dincasecontactx+contacth-dinbaseh-xtolerance,contactl,dincasecoverh,cornerd,1);
	  //  translate([dinbaseh,-dincasew/2,dincasesplith+ztolerance]) roundedbox(dincasel-dinbaseh,(dincasew-dincasetopw)/2+cornerd/2,dincaseh/2-contactblockw/2-ztolerance,cornerd,1);

	  // Keep contact blocks in place (top)
	  hull() {
	    translate([dincasecontactx+contacth,-dincasew/2+2,dincaseh/2+contactblockw/2+ztolerance-1]) roundedbox(1,contactl-4,1+cornerd/2,cornerd);
	    translate([dincasecontactx+contacth,-dincasew/2+contactl/2-cornerd/2,dincaseh/2+contactblockw/2+ztolerance-1]) roundedbox(contactpressmidsupporth-ztolerance,cornerd,1+cornerd/2,cornerd);
	  }
	}
    }

    dinclipspace();

    shellyclips(ytolerance);
    
    if (debugscrewcuts || !debug || print>0)    screwcutouts();

    translate([shellyx+shellyl/2,0,dincaseh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("ShellyDIN",font="Liberation Sans:style=Bold",size=textsize-1,halign="center", valign="center");
    translate([shellyx+shellyl/2-textsize-1,0,dincaseh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(versiontext,font="Liberation Sans:style=Bold",size=textsize,halign="center", valign="center");

    // In connectors
    translate([dincasel-textsize,dincasew/2-textdepth+0.01,dincaseh/2-contactblockw/2+contactw/2]) rotate([-90,-90,0]) linear_extrude(height=textdepth) text("N",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    translate([dincasel-textsize,dincasew/2-textdepth+0.01,dincaseh/2+contactblockw/2-contactw/2]) rotate([-90,-90,0]) linear_extrude(height=textdepth) text("L",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");

    translate([dincasel-textdepth+0.01,dincasew/2-textsize,dincaseh/2-contactblockw/2+contactw/2]) rotate([180,90,180]) linear_extrude(height=textdepth) text("N",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    translate([dincasel-textdepth+0.01,dincasew/2-textsize,dincaseh/2+contactblockw/2-contactw/2]) rotate([180,90,180]) linear_extrude(height=textdepth) text("L",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");

    // Out connectors
    if (0) translate([dincasel-textsize,-dincasew/2+textdepth-0.01,dincaseh/2-contactblockw/2+contactw/2+1]) rotate([90,90,0]) linear_extrude(height=textdepth) scale([0.7,1,1]) text("SW",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    translate([dincasel-textsize,-dincasew/2+textdepth-0.01,dincaseh/2+contactblockw/2-contactw/2]) rotate([90,90,0]) linear_extrude(height=textdepth) text("O",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    
    if (0) translate([dincasel-textdepth+0.01,-dincasew/2+textsize,dincaseh/2-contactblockw/2+contactw/2+1]) rotate([0,90,0]) linear_extrude(height=textdepth) scale([0.7,1,1]) text("SW",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    translate([dincasel-textdepth+0.01,-dincasew/2+textsize,dincaseh/2+contactblockw/2-contactw/2]) rotate([0,90,0]) linear_extrude(height=textdepth) text("O",font="Liberation Sans:style=Bold",size=labelsize,halign="center", valign="center");
    
  }
}

if (print==0) {
  intersection() {
    difference() {
      union() {
	shellydinadapter();
#	dincaseresetbutton(0);
	dinclip();
	//	shellydinadaptercover();
      }
    
      //      translate([shellyx,shellyy,shellyheight]) #render() shelly(); //xxxx
      for (m=[0,1]) mirror([0,m,0]) {
	  #      translate([dincasecontactx,-dincasew/2+contactl/2,dincaseh/2]) rotate([90,0,90]) contactpair();
	}

#      screws();
    }

    if (debug) {
      translate([-0.1,-13,0]) cube([200,200,200]); // Debug bottom side
      //translate([-0.1,-100,0]) cube([200,200,27]); // Debug Right side
      //translate([12,-13-22,-50]) cube([200,200,200]); // Debug screw hole
      //translate([-0.1,-100,0]) cube([200,200,20]); // Debug dinclip
      //translate([12,-100,11]) cube([200,200,200]); // Debug shelly position
    }
  }
    
  if (powerswitch) #translate([dincasetopl,switchy,switchheight]) switch();
      
  if (0) {
    screwtower(basescrewx,basescrewy);
  }
 }

if (print==1 || print==5) {
  difference() {
    shellydinadapter();
  }
 }

if (print==2 || print==5) {
  intersection() {
    translate([-0.5,0,dincaseh]) rotate([0,180,0]) shellydinadaptercover();
  }
 }

if (print==3 || print==5) {
  translate([-1,dincasew/2+0.5,0]) rotate([-90,0,0]) translate([-resetbuttonspringx,-dincaseresetbuttony-resetbuttonpusherw/2,-wall-ztolerance]) dincaseresetbutton(resetbuttonspringtension);
 }

if (print==4 || print==5) {
  translate([dincasetopl+0.5,0,0]) rotate([0,0,0]) translate([-wall-xtolerance,dincasew/2-wall-dinclippulloutholew-wall*2,-dinclipheight]) dinclip();
  //translate([0,0,-dincliph/2]) rotate([0,0,0]) translate([-wall-xtolerance,dincasew/2-dinclippulloutw,-dinclipheight]) dinclip();
 }

if (print==6) {
  shelly();
 }

//translate([0,dincasew/2+shellyw/2+1,0]) shelly();
