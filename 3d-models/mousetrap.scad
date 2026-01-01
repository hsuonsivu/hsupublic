// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO:
// Jatka ulosmenevan aukon taso, jotta hiiren on helpompi painaa se alas, tasapainotus tarkistettava.
// Ulosmenevan aukon alaosa cornerd:lla
// Vastaavasti cover muutokset, ehka samalla tavalla kuin incoming kattokin.

include <hsu.scad>

print=0;
adhesion=(print>0 && print<6)?1:0;
debug=0;//print>0?0:1;
abs=1;
windows=1; // Make windows with 2mm polycarbonate inserts
antiwarp=(print>0)?abs:0;
antiwarpdistance=4; //3 mm
antiwarpw=0.8;
mechanicstest=0;
layerh=0.2; //0.3;

// Make some voids in thicker parts. May save material if dense fill is used. At 10% fill, using fill is cheaper.
makevoids=0; 

version="V1.2";
name="Heikki's Mousetrap";
versiontext=str(name, " ",version);
textdepth=0.8;
textsize=7;
copyrighttext="© heikki@suonsivu.net CC-BY-NC-SA";
copyrighttextsize=textsize-3;
textoffset=2+textsize/2;
copyrighttextoffset=textsize/2+textoffset+1;

cornerd=1;

wall=3;
thinwall=2;

xtolerance=0.4;
ytolerance=0.4;
ztolerance=0.4;
axledtolerance=0.8;
dtolerance=0.5;
maxbridge=10;
cutsmall=4;

$fn=60;

swingw=mechanicstest?20:50;
swingh=50;
swingl=150; //135; //235/2; // Length of one arm
swingtoplreduction=0;
swingsideh=20;
angle=-20;//20;//20 in closed up; 5 down in open lock
closedangle=20; 
lockangle=28;//23;//27;//27;//27;//29.7;//29.7;//23=release in plate, 29.7=locked;
openangle=closedangle;
axleheight=28;//25;
axled=7;
axlel=wall;
axledepth=2;
smallstepx=5;
smallstependd=0.4;

swingheight=wall;//axleheight;

midwallw=axledepth+ytolerance+wall*2+ytolerance+axledepth;

boxh=swingh+50;

boxincornerd=20; // round corners to avoid mice eating through
boxcornerd=cornerd;

clipdepth=1.00+max(xtolerance,ytolerance);
clipd=wall+clipdepth;
clipl=20;
clipheight=boxh-wall-ztolerance-clipd/2;

swingtunnelw=ytolerance+wall/2+swingw+wall/2+ytolerance;

lockinsertclipd=clipd+1;
lockinsertclipdepth=clipdepth;

lockaxleheight=axled/2+wall/2;
lockaxled=axled;
lockaxlex=-swingl/2-21;//8;
lockaxledepth=2;
lockangleprint=0;
lockweightl=30;
lockweighth=15;
lockweightw=wall*2;
lockaxleyoffset=0;
lockaxlel=wall+ytolerance+midwallw+ytolerance+wall+lockaxleyoffset+1.5;
lockaxley=-swingtunnelw/2-midwallw/2-lockaxleyoffset/2+1.5/2; // midpoint
locklefty=-swingtunnelw/2+ytolerance+wall;
lockaxlelefty=locklefty+1.5;
lockrighty=-swingtunnelw/2-midwallw-ytolerance-wall;

lockinserty=lockaxley-lockaxlel/2-wall-ytolerance+0.5;
lockinsertw=lockaxlelefty+ytolerance-lockinserty+axledepth+0.5;;
lockinsertl=21;
lockinserth=lockaxleheight+lockaxled/2+wall;
  
boxx=lockaxlex-lockaxled/2;
boxl=248; //248; //235  -boxx+swingl-25;
boxw=wall+swingtunnelw+midwallw+swingtunnelw+wall;
boxy=swingtunnelw/2+wall-boxw;

boxcrosssupportheight=boxh-wall-boxincornerd/2-wall-ztolerance;
boxcrosssupporth=wall;
boxcrosssupportl=maxbridge;
boxcrosssupportx=boxx+boxl/2-swingtunnelw/2; //+clipl
boxinsupporth=10;

incomingcrossbarheight=boxh-wall-boxinsupporth-ztolerance;

doorl=50;
doorw=wall;
doorhandleh=15;
doorh=boxh-wall+doorhandleh;
dooroverlap=10;
doorholel=doorl-2;
doorholeh=doorl-5-wall;

//swingweightl=lockaxled+wall*4; //-lockaxlex-swingl/2+lockaxled/2;
swingweightl=-lockaxlex-swingl/2+lockaxled/2;
swingweighth=wall-ztolerance;
weigthvoids=1;//mechanicstest?0:1;

midholel=46+15;
midholex=boxx+boxl-wall-midholel; //boxl-wall-midholel;
midholey=-swingtunnelw/2-midwallw;
midwalll=midholex-boxx;

midtunnelx=boxx+boxl-wall-midholel;

outholel=46;
outholeh=50; //outholel;

storageboxl=230-8-boxincornerd/2-2-8-4;
storageboxw=120;
storageboxx=boxx-storageboxl-xtolerance;
storageboxy=-swingtunnelw/2-storageboxw;
storageboxh=boxh;
storageboxoutcornerd=boxincornerd+wall*2;
  
storagel=storageboxl-wall*2;
storagew=storageboxw-wall*2;
storageh=storageboxh-wall*2+boxincornerd;

swingtunnelh=storageh;

boxlockpind=8;
boxlockh=2;
boxlockpinh=wall*2-0.4-ztolerance-0.4;
boxlockl=boxlockh+10/2+boxlockpind+boxlockpind/2;
boxlockw=swingtunnelw-wall-lockaxledepth/2-wall/2-lockaxledepth+ytolerance-10-1;
boxlocky=-swingtunnelw/2-midwallw-swingtunnelw+10/2;
boxlockpinholex=boxx+wall+10/2+boxlockpind/2;
boxlockpinholeh=boxlockpinh+ztolerance;
boxlockpinholeytable=[boxlocky+5+boxlockpind/2,boxlocky+boxlockw-5-boxlockpind/2];

boxclipxpositions=[boxx+boxl/4-clipl,boxx+boxl/2-clipl,boxx+boxl-boxl/4-clipl];

mouseh=midholel; // Size of tunnels for a mouse to crawl through

baitboxx=swingl/2+31;
baitboxy=-14;
baitboxangle=-35;

baitboxwall=2;
bb=30;
baitboxw=bb;
//baitboxpw1=baitboxw-maxbridge;
baitboxpw1=maxbridge;
baitboxpw=baitboxpw1<0?0:baitboxpw1;
baitboxtopw=baitboxw/2;
baitboxl=bb;
baitboxpl1=baitboxl-maxbridge;
baitboxpl=baitboxpl1<0?0:baitboxpl1;
baitboxph=max(baitboxw-baitboxpw,baitboxl-baitboxpl)/2;
baitboxh=26;
baitboxhandledepth=7;
baitboxtopl=baitboxl+1.8*(baitboxh-baitboxwall)-2;
baitboxcornerd=10;
baitboxincornerd=baitboxcornerd-baitboxwall;
baitboxinw=baitboxw-baitboxwall*2;
//baitboxinpw1=baitboxinw-maxbridge;
baitboxinpw1=maxbridge;
baitboxinpw=baitboxinpw1<0?0:baitboxinpw1;
baitboxinh=baitboxh-baitboxwall*2;
baitboxinl=baitboxl-baitboxwall*2;
baitboxtopinl=baitboxinl+2*baitboxh-baitboxwall*2;
baitboxinpl1=baitboxinl-maxbridge;
baitboxinpl=baitboxinpl1<0?0:baitboxinpl1;
baitboxdoorcornerd=2;
baitboxdoorw=baitboxw-baitboxcornerd;
baitboxdoortopheight=baitboxwall+(baitboxinw-maxbridge)/2-1;
baitboxdoorh=baitboxh-baitboxhandledepth-baitboxdoortopheight-1;
baitboxflangeextend=2.2;
baitboxflangecornerd=baitboxcornerd+baitboxflangeextend;
baitboxflangew=baitboxw+baitboxflangeextend*2;
baitboxflangetopw=baitboxw/2+baitboxflangeextend*2;
baitboxflangel=baitboxl+baitboxflangeextend;
baitboxflangetopl=baitboxtopl+baitboxflangeextend*2;
//baitboxflangetopl=baitboxtopl+baitboxwall*2+cornerd*2+xtolerance*2;
baitboxflangeh=baitboxflangeextend;
baitboxhandled=maxbridge+17;
baitboxhandlebottomd=maxbridge+10;

baitboxhandlescale=1.6; // Scale up lengthwise
baitboxclipdepth=1+max(xtolerance,ytolerance); // 0.8
baitboxclipd=baitboxwall+baitboxclipdepth;
baitboxclipl=17;
baitboxclipheight=baitboxh/2+8;
baitboxcliph=14;
baitboxclipcut=0.5;
baitboxclipcuth=10;
baitboxclipcutw=baitboxclipl;

baitboxslotl=baitboxl+xtolerance*2;
baitboxslotpl=baitboxslotl-maxbridge;
baitboxslottopl=baitboxtopl+xtolerance*2;
baitboxslotw=baitboxw+ytolerance*2;
//baitboxslotpw=baitboxslotw-maxbridge;
baitboxslotpw=maxbridge;
baitboxslotph=baitboxph;
baitboxslottopw=baitboxw/2+ytolerance*2;
baitboxsloth=baitboxh+ztolerance;

baitboxholed=2;
baitboxholedistance=baitboxholed+1.2;

outopeningy=-swingtunnelw/2-midwallw-swingtunnelw;
outopeningw=swingtunnelw-wall-ytolerance-wall-ytolerance;
outholetotalh=outholeh+(outopeningw-maxbridge*2)/2;

saranad=6;
saranacoverd=saranad+dtolerance+thinwall*2;
flapwall=5;
flapwalld=saranacoverd+5;
flapwallcornerd=5;
flapw=outopeningw+thinwall*2;
flapy=outopeningy-thinwall;
flapthickness=3;
flapangle=30;
flapaxleextend=2;
flapaxlew=flapw+flapaxleextend*2;
flaph=(outholetotalh+saranacoverd/2+wall*2)/cos(flapangle);
flapheight=wall;
flapaxleheight=wall*2+outholetotalh+saranacoverd;
flapaxlex=storageboxx+storageboxl-wall-saranad/2-dtolerance/2-xtolerance;

//windowedge=boxincornerd/2+wall+1;
//windowoverlap=7; // Go over the material
//windowcornerd=boxincornerd/2; // This is for the cover, not windows itself which are cut rectangular
//windowoutlap=7; // Not must be rounded at edges
//windowcutoutlap=3;
//windowoverlapbottomh=0.3*4; // For 0.3 layers 6 layers, for 0.2 layers 9 layers;
//windowoverlaptoph=0.3*4; // For 0.3 layers 4 layers, for 0.2 layers 6 layers;
//windowh=2;
//windowztolerance=0.2;
//windowheight=boxh-windowoverlaptoph-windowztolerance-windowh;
//windowtemplateh=1;
//windowtemplateedge=7;
//}

storagewindowh=2;
storagewindowheight=storageboxh-windowheight(storagewindowh);//-wall;//-windowoverlaptoph-windowztolerance-windowh;
storagewindowl=storageboxl-windowedge*2;
storagewindoww=storageboxw-windowedge*2;
inwindowl=70;
inwindoww=swingtunnelw-4;
inwindowheight=storagewindowheight;
inwindowcenterx=boxl/2+5;
inwindowcentery=0;

outwindowl=150;
outwindoww=swingtunnelw-4;
outwindowheight=storagewindowheight;
outwindowcenterx=boxl/2-10;
outwindowcentery=-swingtunnelw/2-midwallw-swingtunnelw/2;

// Open incoming tunnel wall to this point
intunnelopenx=(-swingl/2+wall*2)*cos(closedangle)+wall+wall;

module windowframeold(x,y,height,l,w,h) {
  overl=l+windowoutlap*2;
  overw=w+windowoutlap*2;
  
  hull() {
    translate([x-l/2,y-w/2,height-windowztolerance-windowoverlapbottomh]) roundedboxxyz(l,w,windowoverlapbottomh,windowcornerd,cornerd,0,90);
    translate([x-overl/2,y-overw/2,height]) roundedboxxyz(overl,overw,h,windowcornerd,cornerd,0,90);
  }
}

module windowcutold(x,y,height,l,w,h) {
  cutl=l-windowoverlap*2;
  cutw=w-windowoverlap*2;
  overl=l+windowoutlap*2;
  overw=w+windowoutlap*2;
  overcutl=l-windowoverlap*2+windowcutoutlap*2;
  overcutw=w-windowoverlap*2+windowcutoutlap*2;
  
  translate([x-l/2+xtolerance,y-w/2+ytolerance,height-windowztolerance]) cube([l+xtolerance*2,w+ytolerance*2,h+windowztolerance*2]);
  hull() {
    translate([x-cutl/2,y-cutw/2,height-windowztolerance-windowoverlapbottomh-cornerd/2]) roundedboxxyz(cutl,cutw,windowoverlapbottomh+cornerd,windowcornerd,cornerd,0,90);
    translate([x-overcutl/2,y-overcutw/2,height-windowztolerance-windowoverlapbottomh-cornerd]) roundedboxxyz(overcutl,overcutw,cornerd,windowcornerd,cornerd,0,90);
  }

  translate([x-cutl/2,y-cutw/2,height+windowh+windowztolerance-cornerd/2]) roundedboxxyz(cutl,cutw,windowoverlaptoph+cornerd,windowcornerd,cornerd,0,90);
}

module storagewindowtemplate() {
  windowtemplate(storagewindowl,storagewindoww);
  difference() {
    translate([-storagewindowl/2,-storagewindoww/2,0]) roundedbox(storagewindowl,storagewindoww,windowtemplateh,cornerd,1);
    for (n=[0,1]) mirror([n,0,0]) for (m=[0,1]) mirror([0,m,0]) translate([-storagewindowl/2+windowtemplateedge,-storagewindoww/2+windowtemplateedge,-cornerd/2]) roundedbox(storagewindowl/2-windowtemplateedge*1.5,storagewindoww/2-windowtemplateedge*1.5,windowtemplateh+cornerd,cornerd,1);
  }
}

module inwindowtemplate() {
  difference() {
    translate([-inwindowl/2,-inwindoww/2,0]) roundedbox(inwindowl,inwindoww,windowtemplateh,cornerd,1);
    for (n=[0,1]) mirror([n,0,0]) translate([-inwindowl/2+windowtemplateedge,-inwindoww/2+windowtemplateedge,-cornerd/2]) roundedbox(inwindowl/2-windowtemplateedge*1.5,inwindoww-windowtemplateedge*2,windowtemplateh+cornerd,cornerd,1);
  }
}

module outwindowtemplate() {
  difference() {
    translate([-outwindowl/2,-outwindoww/2,0]) roundedbox(outwindowl,outwindoww,windowtemplateh,cornerd,1);
    for (n=[0,1]) mirror([n,0,0]) translate([-outwindowl/2+windowtemplateedge,-outwindoww/2+windowtemplateedge,-cornerd/2]) roundedbox(outwindowl/2-windowtemplateedge*1.5,outwindoww-windowtemplateedge*2,windowtemplateh+cornerd,cornerd,1);
  }
}

module windowtemplates() {
  storagewindowtemplate();
  translate([0,storagewindoww/2+inwindoww/2+0.5,0]) inwindowtemplate();
  translate([0,-storagewindoww/2-outwindoww/2-0.5,0])  outwindowtemplate();
}

module baitboxslot() {
  // Space for baitbox
  difference() {
    union() {
      for (m=[0,1]) mirror([0,m,0]) translate([0,-baitboxw/2+baitboxwall-baitboxclipdepth,baitboxclipheight]) tubeclip(baitboxclipl+baitboxwall*2,baitboxclipd+baitboxwall*2,0);
      intersection() {
	hull() {
	  translate([-baitboxslotl/2-baitboxwall,-baitboxslotw/2-baitboxwall,baitboxh-baitboxcornerd/2]) roundedbox(baitboxslotl+baitboxwall*2,baitboxslotw+baitboxwall*2,baitboxcornerd,baitboxcornerd);
	  hull() {
	    translate([-baitboxslotl/2-baitboxwall,-baitboxslotw/2-baitboxwall,baitboxph-ztolerance-baitboxwall]) roundedbox(baitboxslotl+baitboxwall*2,baitboxslotw+baitboxwall*2,baitboxsloth-baitboxph+ztolerance+baitboxcornerd,0.1);
	    translate([-baitboxslotpl/2-baitboxwall,-baitboxslotpw/2-baitboxwall,-ztolerance-baitboxwall]) roundedbox(baitboxslotpl+baitboxwall*2,baitboxslotpw+baitboxwall*2,baitboxsloth+ztolerance+baitboxcornerd,0.1);
	  }

	  translate([-baitboxslottopl/2-baitboxwall,-baitboxslottopw/2-baitboxwall,baitboxh-baitboxcornerd/2]) roundedbox(baitboxslottopl+baitboxwall*2,baitboxslottopw+baitboxwall*2,baitboxcornerd,baitboxcornerd);
	  translate([-baitboxslotl/2-baitboxwall,-baitboxslotw/2-baitboxwall,baitboxph-ztolerance-baitboxwall]) roundedbox(baitboxslotl+baitboxwall*2,baitboxslotw+baitboxwall*2,baitboxsloth-baitboxph+ztolerance+baitboxcornerd,baitboxcornerd);
	}
	translate([-baitboxslottopl/2-baitboxwall,-baitboxslotw/2-baitboxwall,-baitboxslotph-ztolerance-baitboxwall]) cube([baitboxslottopl+baitboxwall*2,baitboxslotw+baitboxwall*2,baitboxsloth+baitboxslotph]);
      }
      intersection() {
	hull() {
	  h=baitboxflangeextend/2;
	  translate([-baitboxflangetopl/2-baitboxwall*2,-baitboxflangetopw/2-baitboxwall-ytolerance,baitboxh-wall]) roundedboxxyz(baitboxflangetopl+baitboxwall*4,baitboxflangetopw+baitboxwall*2+ytolerance*2,baitboxflangeh+baitboxwall+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
	  translate([-baitboxflangel/2-baitboxwall,-baitboxflangew/2-baitboxwall-ytolerance,baitboxh-wall]) roundedboxxyz(baitboxflangel+baitboxwall*2,baitboxflangew+baitboxwall*2+ytolerance*2,baitboxflangeh+baitboxwall+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
	  translate([-baitboxflangetopl/2-baitboxwall,-baitboxflangetopw/2-baitboxwall-ytolerance,baitboxh-baitboxflangeh-baitboxwall-ztolerance]) roundedboxxyz(baitboxflangetopl+baitboxwall*2,baitboxflangetopw+baitboxwall*2+ytolerance*2,baitboxflangeh+baitboxwall+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
	  translate([-baitboxflangel/2-baitboxwall,-baitboxflangew/2-baitboxwall-ytolerance,baitboxh-baitboxflangeh-baitboxwall-ztolerance]) roundedboxxyz(baitboxflangel+baitboxwall*2,baitboxflangew+baitboxwall*2+ytolerance*2,baitboxflangeh+baitboxwall+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
	}

	translate([-baitboxflangetopl/2-baitboxwall*2,-baitboxflangew/2-baitboxwall-ytolerance,baitboxh-baitboxflangeh-baitboxwall-ztolerance]) cube([baitboxflangetopl+baitboxwall*4,baitboxflangew+baitboxwall*2+ytolerance*2,baitboxflangeh+baitboxwall+ztolerance]);
      }
    }

    for (m1=[0,1]) mirror([m1,0,0]) translate([-baitboxl/2-baitboxwall,0,baitboxh/2-baitboxdoorh/2]) {
	rotate([0,-45,0]) for (m=[0,1]) mirror([0,m,0]) for (y=[0:baitboxholedistance:baitboxdoorw/2-baitboxholed/2]) {
	  for (z=[0:baitboxholedistance:baitboxdoorh]) {
	    translate([-baitboxwall*4-0.01,y,z]) {
	      hull() {
		rotate([0,90,0]) cylinder(d=baitboxholed,h=baitboxwall*4+0.02);
		translate([0,-baitboxholed/4,-baitboxholed/2]) cube([baitboxwall*4+0.02,baitboxholed/2,baitboxholed]);
	      }
	    }
	  }
	}
    }
  }
}

module baitboxform(cut) {
  xt=cut?xtolerance:0;
  yt=cut?ytolerance:0;
  zt=cut?ztolerance:0;

  h=(baitboxflangew-baitboxw)/2+0.5;
  
  if (1) hull() {
      translate([-baitboxl/2-xt,-baitboxflangew/2-xt,baitboxh-0.1]) roundedboxxyz(baitboxl+xt*2,baitboxflangew+xt*2,cut?0.2:0.1,baitboxcornerd,0.05,2,90);
      translate([-baitboxl/2-xt,-baitboxw/2-xt,baitboxh-h]) roundedboxxyz(baitboxl+xt*2,baitboxw+xt*2,h,baitboxcornerd,h/2,2,90);
      translate([-baitboxflangetopl/2-xt,-baitboxflangetopw/2-xt,baitboxh-0.1]) roundedboxxyz(baitboxflangetopl+xt*2,baitboxflangetopw+xt*2,cut?0.2:0.1,baitboxcornerd,0.05,2,90);
      translate([-baitboxtopl/2-xt,-baitboxtopw/2-xt,baitboxh-h-zt]) roundedboxxyz(baitboxtopl+xt*2,baitboxtopw+xt*2,h+zt,baitboxcornerd,0.05,2,90);
    }
  
  if (1) translate([0,0,0]) intersection() {
    hull() {
      translate([-baitboxtopl/2-xt,-baitboxtopw/2-xt,baitboxh-h-zt]) roundedboxxyz(baitboxtopl+xt*2,baitboxtopw+xt*2,h+zt,baitboxcornerd,0.05,2,90);
      hull() {
	translate([-baitboxl/2-xt,-baitboxw/2-xt,baitboxph-ztolerance]) roundedbox(baitboxl+xt*2,baitboxw+xt*2,baitboxh-baitboxph+ztolerance+cornerd,cornerd);
	translate([-baitboxpl/2-xt,-baitboxpw/2-xt,-ztolerance]) roundedbox(baitboxpl+xt*2,baitboxpw+xt*2,baitboxh-baitboxph+ztolerance*2+baitboxcornerd/2,0.1);
      }
    }
    translate([-baitboxtopl/2-xt,-baitboxflangew/2-xt,cut?-baitboxph-ztolerance:baitboxh-baitboxflangeh]) cube([baitboxtopl+xt*2,baitboxflangew+xt*2,cut?baitboxh+baitboxph+ztolerance*1:baitboxflangeh-0.01]);
  }
}

module baitboxslotcut() {
  for (m=[0,1]) mirror([0,m,0]) translate([0,-baitboxw/2+baitboxwall-+baitboxclipdepth,baitboxclipheight]) tubeclip(baitboxclipl,baitboxclipd,1);

  baitboxform(1);
  
  if (0) translate([0,0,+0.01]) intersection() {
    hull() {
      h=2;
      translate([-baitboxtopl/2-xtolerance,-baitboxtopw/2-xtolerance,baitboxh]) roundedboxxyz(baitboxtopl+xtolerance*2,baitboxtopw+xtolerance*2,h,baitboxcornerd,h/2,2,90);
      translate([-baitboxl/2-xtolerance,-baitboxw/2-xtolerance,baitboxh]) roundedboxxyz(baitboxl+xtolerance*2,baitboxw+xtolerance*2,h,baitboxcornerd,h/2,2,90);
      //translate([-baitboxl/2-xtolerance,-baitboxw/2-xtolerance,-ztolerance]) roundedbox(baitboxl+xtolerance*2,baitboxw+xtolerance*2,baitboxh+ztolerance*2+baitboxcornerd/2,baitboxcornerd);
      hull() {
	translate([-baitboxl/2-xtolerance,-baitboxw/2-xtolerance,-ztolerance]) roundedbox(baitboxl+xtolerance*2,baitboxw+xtolerance*2,baitboxh+ztolerance*2+baitboxcornerd/2,0.1);
	translate([-baitboxpl/2-xtolerance,-baitboxpw/2-xtolerance,-baitboxph-ztolerance]) roundedbox(baitboxpl+xtolerance*2,baitboxpw+xtolerance*2,baitboxh+ztolerance*2+baitboxcornerd/2,0.1);
      }
    }
    translate([-baitboxtopl/2-xtolerance,-baitboxw/2-xtolerance,-baitboxph-ztolerance]) cube([baitboxtopl+xtolerance*2,baitboxw+xtolerance*2,baitboxh+baitboxph+ztolerance*1]);
  }
  if (0) hull() {
    translate([-baitboxflangel/2-xtolerance-baitboxflangeh-ztolerance,-baitboxflangew/2-ytolerance,baitboxh]) roundedboxxyz(baitboxflangel+xtolerance*2+(baitboxflangeh+ztolerance)*2,baitboxflangew+ytolerance*2,baitboxflangeh+baitboxcornerd+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
    translate([-baitboxflangetopl/2-xtolerance-baitboxflangeh-ztolerance,-baitboxflangetopw/2-ytolerance,baitboxh]) roundedboxxyz(baitboxflangetopl+xtolerance*2+(baitboxflangeh+ztolerance)*2,baitboxflangetopw+ytolerance*2,baitboxflangeh+baitboxcornerd+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
    translate([-baitboxflangel/2-xtolerance,-baitboxflangew/2-ytolerance,baitboxh-baitboxflangeh-ztolerance]) roundedboxxyz(baitboxflangel+xtolerance*2,baitboxflangew+ytolerance*2,baitboxflangeh+baitboxcornerd+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
    translate([-baitboxflangetopl/2-xtolerance,-baitboxflangetopw/2-ytolerance,baitboxh-baitboxflangeh-ztolerance]) roundedboxxyz(baitboxflangetopl+xtolerance*2,baitboxflangetopw+ytolerance*2,baitboxflangeh+baitboxcornerd+ztolerance,baitboxflangecornerd,cornerd+xtolerance,2,90);
  }
}

module baitbox() {
  hwdiff=maxbridge-2;
  hldiff=maxbridge-2;//baitboxcornerd/2-baitboxwall;
  hdiff=max(hwdiff,hldiff);
  
  difference() {
    union() {
      difference() {
	union() {
	  intersection() {
	    //roundedbox(baitboxl,baitboxw,baitboxh+baitboxcornerd/2,baitboxcornerd);
	    hull() {
	      translate([-baitboxl/2,-baitboxw/2,baitboxph]) roundedbox(baitboxl,baitboxw,baitboxh-baitboxph+cornerd,cornerd);
	      translate([-baitboxpl/2,-baitboxpw/2,0]) roundedbox(baitboxpl,baitboxpw,baitboxh+cornerd/2,cornerd);
	    }
	    translate([-baitboxl/2,-baitboxw/2,0]) cube([baitboxl,baitboxw,baitboxh]);
	  }

	  for (m=[0,1]) mirror([0,m,0]) translate([0,-baitboxw/2+baitboxwall-baitboxclipdepth,baitboxclipheight]) tubeclip(baitboxclipl,baitboxclipd,0);

	  baitboxform(0);
	}

	difference() {
	  hull() {
	    translate([-baitboxinl/2,-baitboxinw/2,baitboxph]) roundedbox(baitboxinl,baitboxinw,baitboxh-baitboxph+cornerd,cornerd);
	    translate([-baitboxinl/2,-baitboxinw/2,baitboxwall+hldiff]) roundedbox(baitboxinl,baitboxinw,baitboxinh-hldiff,cornerd);
	    translate([-baitboxinpl/2,-baitboxinpw/2,baitboxwall]) cube([baitboxinpl,baitboxinpw,1]);
	  }
	}

	hull() {
	  translate([-baitboxl/2-baitboxdoorcornerd/2-0.01,-baitboxdoorw/2,baitboxdoortopheight]) roundedbox(baitboxwall+baitboxdoorcornerd+0.02,baitboxdoorw,baitboxdoorh,baitboxdoorcornerd-2);
	  translate([-baitboxl/2-baitboxcornerd/2-0.01,-maxbridge/2,baitboxwall]) cube([baitboxwall+baitboxcornerd+0.02,maxbridge,maxbridge/2]);
	}
      }

      translate([0,0,baitboxh-baitboxhandledepth-baitboxwall]) scale([baitboxhandlescale,1,1]) cylinder(d1=baitboxhandlebottomd+baitboxwall*2,d2=baitboxhandled+baitboxwall*2,h=baitboxhandledepth+baitboxwall);
    }

    difference() {
      translate([0,0,baitboxh-baitboxhandledepth]) scale([baitboxhandlescale,1,1]) cylinder(d1=baitboxhandlebottomd,d2=baitboxhandled,h=baitboxhandledepth+0.01);
      translate([-baitboxhandled/2*baitboxhandlescale-baitboxwall,-baitboxwall/2,baitboxh-baitboxhandledepth-baitboxwall]) scale([baitboxhandlescale,1,1]) roundedbox(baitboxhandled+baitboxwall*2,baitboxwall,baitboxhandledepth+baitboxwall,cornerd,2);
      translate([-baitboxhandled/2*baitboxhandlescale-baitboxwall,-baitboxwall*1.5/2,baitboxh-baitboxwall]) scale([baitboxhandlescale,1,1]) roundedbox(baitboxhandled+baitboxwall*2,baitboxwall*1.5,baitboxwall,cornerd,2);
      translate([-baitboxclipl/2-baitboxclipcut+0.01,-baitboxclipdepth-baitboxwall,baitboxh-baitboxhandledepth-baitboxwall]) roundedbox(baitboxclipl+baitboxclipcut*2-0.02,(baitboxclipdepth+baitboxwall)*2,baitboxhandledepth+baitboxwall,cornerd,2);
      translate([-baitboxclipl/2-baitboxclipcut+0.01,-baitboxclipdepth-baitboxwall*1.5,baitboxh-baitboxwall]) roundedbox(baitboxclipl+baitboxclipcut*2-0.02,(baitboxclipdepth+baitboxwall*1.5)*2,baitboxwall,cornerd,2);
    }

    // TODO: pidenna oteosaa (ehka 45 kulmalla), syvenna depthia,
    translate([-baitboxclipl/2-baitboxclipcut,-baitboxclipdepth-0.01,baitboxh-baitboxcliph-0.01]) cube([baitboxclipl+baitboxclipcut*2,baitboxclipdepth*2+0.02,baitboxcliph+0.02]);
    for (m=[0,1]) mirror([0,m,0]) {
	//translate([-baitboxclipl/2-baitboxclipcut,baitboxw/2,baitboxh-baitboxflangeh-0.01]) cube([baitboxclipl+baitboxclipcut*2,baitboxclipcut,baitboxflangeh+0.02]);
	for (m2=[0,1]) mirror([m2,0,0]) {
	    translate([-baitboxclipl/2-baitboxclipcut,baitboxclipdepth+0.01,baitboxh-baitboxcliph-0.01]) cube([baitboxclipcut,baitboxflangew/2-baitboxclipdepth+0.01,baitboxcliph+0.02]);
	  }
      }
		   
    translate([-baitboxl,0,baitboxh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(version, size=textsize-1, valign="bottom",halign="center",font="Liberation Sans:style=Bold");
    translate([baitboxl,0,baitboxh-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text("Bait", size=textsize, valign="top",halign="center",font="Liberation Sans:style=Bold");
  }
}

// Circular hole cut for swing movement
module swingcut() {
  swingtunneld=swingl+xtolerance+2;
  hull() {
    intersection() {
      translate([0,-swingtunnelw/2,axleheight]) rotate([-90,0,0]) cylinder(d=swingtunneld,h=swingtunnelw);
      hull() {
	translate([-swingl/2+wall*0.5,-swingtunnelw/2,wall]) roundedbox(swingl-wall*1,swingtunnelw,swingtunnelh,cornerd);
	translate([-swingl/2-wall,-swingtunnelw/2+wall,wall*2]) roundedbox(swingl+2*wall,swingtunnelw-wall*2,swingtunnelh-wall*2,cornerd);
      }
    }
  }
  hull() {
    intersection() {
      //      translate([0,-swingtunnelw/2,axleheight]) rotate([-90,0,0]) cylinder(d=swingtunneld,h=swingtunnelw);
      translate([0,-swingtunnelw/2,wall]) roundedbox(swingl/2+wall*3,swingtunnelw,wall*3,cornerd);
      hull() {
	translate([-swingl/2+wall*0.5,-swingtunnelw/2,wall]) roundedbox(swingl-wall*1,swingtunnelw,wall*3,cornerd);
	translate([-swingl/2-wall,-swingtunnelw/2+wall,wall*2]) roundedbox(swingl+2*wall,swingtunnelw-wall*2,wall*2,cornerd);
      }
    }
  }
}

module coverswingcut(x,y,z,l,h,w,axleheight,d,c) {
  intersection() {
    translate([x,y,axleheight]) rotate([-90,0,0]) cylinder(d=d,h=w);
    translate([x-l,y,z]) roundedbox(l*2,w,h,c);
  }
}

// This is complete spaghetti...
module swing(a,l) {
  translate([0,0,axleheight]) rotate([0,a,0]) translate([0,0,0]) {
    // Swing floor
    difference() {
      for (x=[-swingl/2,swingl/2-0.1]) {
	difference() {
	  union() {
	    hull() {
	      for (y=[-swingw/2,swingw/2]) {
		yy=-sign(y)/2+y;
		yyy=yy+(l&&(y<0)&&(x<0)?wall*2+1:0);
		for (y=[-swingw/2,swingw/2]) {
		  if (l && x>0) {
		    if (x>0) {
		      translate([x,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		      translate([x+smallstepx,y-sign(y)*wall/2,swingheight+wall/2+smallstepx*sin(closedangle)]) rotate([0,90,0]) cylinder(d=smallstependd,h=0.1);
		    }
		  }
		}
	      }
	    }

	    hull() {
	      for (y=[-swingw/2,swingw/2]) {
		yy=-sign(y)/2+y;
		yyy=yy+(l&&(y<0)&&(x<0)?wall*2+1:0);
		if (!l && x<0 && y>0) {
		  translate([x+wall,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		} else {
		  translate([x,yyy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
		if (l && x<0) {
		  translate([x+wall*2,yy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x,yyy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x+wall*2,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
		if (!l && x>0) {
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
		translate([-0.01*sign(x),yy,swingheight]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
	      }
	    }
	    if (!l && x>0) {
	      hull() {
		for (y=[-swingw/2,swingw/2]) {
		  yy=-sign(y)/2+y;
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x+swingweightl,yy,swingheight+wall+sin(closedangle)*swingweightl]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
	      }
	    } 
	    if (l && x<0) {
	      hull() {
		for (y=[-swingw/2+wall*2,swingw/2]) {
		  yy=-sign(y)+0.5+y;
		  yyy=yy+(y<0?0.5:0);
		  //yyy=-sign(y)*1+y;
		  translate([x,yy,swingheight+wall]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		  translate([x-swingweightl,yyy,swingheight+wall+sin(closedangle)*swingweightl+sin(closedangle)*wall-ztolerance]) rotate([0,90,0]) cylinder(d=wall,h=0.1);
		}
	      }
	    } 
	  }

	  voidh=0.1;

	  // Make voids to increase weight
	  if (weigthvoids) {
	    if (l && x<0) {
	      translate([x+wall,-swingw/2+0.5+wall,swingheight]) cube([swingl/2-wall*5,swingw-wall*2-1,voidh]);
	      translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8]) cube([swingl*3/4/2-wall*2,swingw-wall*2-1,voidh]);
	      translate([x+wall,-swingw/2+0.5+wall,swingheight+0.8*2]) cube([swingl/4-wall*2,swingw-wall*2-1,voidh]);
	      translate([x+wall-wall,-swingw/2+0.5+wall,swingheight+0.8*3]) cube([wall*4,swingw-wall*2-1,voidh]);
	    }
	    if (!l && x>0) {
	      translate([x-swingl/2+wall*4,-swingw/2+0.5+wall,swingheight]) cube([swingl/2-wall*5,swingw-wall*2-1,voidh]);
	      translate([x-swingl*3/4/2+wall,-swingw/2+0.5+wall,swingheight+0.8]) cube([swingl*3/4/2-wall*2,swingw-wall*2-1,voidh]);
	      translate([x-swingl/4+wall,-swingw/2+0.5+wall,swingheight+0.8*2]) cube([swingl/4-wall*2,swingw-wall*2-1,voidh]);
	      translate([x-wall*4,-swingw/2+0.5+wall,swingheight+0.8*3]) cube([wall*4,swingw-wall*2-1,voidh]);
	    }
	  }
	}
      }

      for (y=[-swingw/2+wall/2,swingw/2-wall/2-axledepth-1-ytolerance*2]) {
	hull() {
	  translate([-axled*1.3,y,-axled/2-2]) rotate([-90,0,0]) cylinder(d=axled+4,h=axledepth+1+ytolerance*2);
	  translate([0,y,0]) rotate([-90,0,0]) cylinder(d=axled+4,h=axledepth+1+ytolerance*2);
	  translate([axled*1.3,y,-axled/2-2]) rotate([-90,0,0]) cylinder(d=axled+4,h=axledepth+1+ytolerance*2);
	}
      }
    }
    
    // Swing sides
    for (y=[-swingw/2,swingw/2]) {
      yy=-sign(y)/2+y;
      hull() {
	translate([-swingl/2+wall*3,yy,swingheight]) sphere(d=wall);
	translate([0,y,swingheight]) sphere(d=wall);
	translate([0,y,-axled/2+wall/2]) sphere(d=wall);
      }
      hull() {
	translate([swingl/2-wall,yy,swingheight]) sphere(d=wall);
	translate([0,y,swingheight]) sphere(d=wall);
	translate([0,y,-axled/2+wall/2]) sphere(d=wall);
      }
    }
    
    // Weighting
    hull() {
      
    }

    translate([0,-swingw/2,0]) onehinge(axled,axlel,axledepth,0,ytolerance,axledtolerance);
    translate([0,swingw/2,0]) onehinge(axled,axlel,axledepth,0,ytolerance,axledtolerance);
  }
}

arml=sqrt(pow(-lockaxlex-(swingl/2+wall+xtolerance)*cos(closedangle),2)+pow(axleheight+(swingl/2+wall)*sin(closedangle),2))+swingheight+wall/5-lockaxleheight+1;
  
module lock(a) {
  xx=lockaxlex;
  yy=lockaxley;
  zz=lockaxleheight;
  
  translate([xx,yy,zz]) rotate([0,a,0]) onehinge(lockaxled,lockaxlel,axledepth,0,ytolerance,axledtolerance);
  ly=locklefty-lockaxley;
  ry=lockrighty-lockaxley;
  lwy=-lockweightw/2;

  // Bar to weight
  translate([xx,yy,zz]) rotate([0,a,0]) hull() {
    translate([0,ly-1.5,lockaxled*1.5]) rotate([-90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([-lockaxled/2+wall/2,ly+wall+0.5,arml+wall*4]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+wall*1.5+0.5,ly-wall*1+0.5,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=0.2);
  }

  translate([xx,yy,zz]) rotate([0,a,0]) hull() {
    w=wall*2+ytolerance+wall+ytolerance+0.2;
    translate([-lockaxled/2+wall/2,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=w);
    translate([-lockaxled/2+wall/2,lwy,arml+wall*3]) rotate([-90,0,0]) cylinder(d=wall,h=w);
    translate([-lockaxled/2+wall/2+wall*1.5,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=w-1);
  }

  translate([xx,yy,zz]) rotate([0,a,0]) hull() {
    translate([0,ly+1.5,0]) rotate([90,0,0]) cylinder(d=axled,h=wall+1.5);
    translate([0,ly+1.5,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=axled,h=wall+1.5);
  }

  translate([xx,yy,zz]) rotate([0,a,0]) hull() {
    translate([0,ly+1.5,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=axled,h=wall+1.5);
    translate([-lockaxled/2+wall*3,ly+wall+0.5-wall*2,arml-wall-ytolerance-0.5]) rotate([-90,0,0]) cylinder(d=wall,h=wall);
    translate([-lockaxled/2+wall/2,ly+wall+0.5,arml-wall*2.2-ytolerance-0.5]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+wall+1.8,ly+wall+0.5,arml-wall*1.5-ytolerance-0.5+0.7]) rotate([90,0,0]) cylinder(d=wall,h=wall*2);
  }

  // Weight
  translate([xx,yy,zz]) rotate([0,a,0]) hull() {
    translate([-lockaxled/2+wall/2,lwy,arml+wall*4]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2,lwy,arml+wall*3]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+lockweightl+wall*3,lwy,arml+wall*4.5]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
    translate([-lockaxled/2+wall/2+lockweightl,lwy,arml+wall*4.5+lockweighth]) rotate([-90,0,0]) cylinder(d=wall,h=wall*2);
  }

  // Out going release bar
  translate([xx,yy,zz]) rotate([0,a,0]) hull() {
    translate([0,ry+wall,0]) rotate([90,0,0]) cylinder(d=lockaxled,h=wall);
    translate([1,ry+wall,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled+2,h=wall);
  }

  difference() {
    union() {
      hull() {
	translate([xx,yy,zz]) rotate([0,a,0]) translate([1,ry+wall,lockaxled*1.5]) rotate([90,0,0]) cylinder(d=lockaxled+2,h=wall);
	translate([xx,yy,zz]) rotate([0,a,0]) translate([-lockaxled/2+10/2,ry+wall,arml+wall*2]) rotate([90,0,0]) cylinder(d=10,h=wall);
	translate([xx,yy,zz]) rotate([0,a-27,0]) translate([-xx,-yy,-zz]) translate([-swingl/2*cos(-20)-xtolerance-sin(20)*wall/2+1/2,yy+ry+wall,wall+ztolerance-1]) rotate([90,0,0]) cylinder(d=1,h=wall);
      }
    }

    hull() {
      for (y=[0,wall+0.1]) translate([-y/2,y,0]) {
	  intersection() {
	    translate([xx,yy,zz]) rotate([0,a-28,0]) translate([-xx,-yy,-zz]) translate([0,yy+ry-0.01,axleheight]) rotate([-90,0,0]) cylinder(d=swingl+dtolerance+xtolerance,h=0.2,$fn=360);
	    translate([boxx,yy+ry-0.01,axleheight+25]) cube([boxl,0.02,boxh-axleheight-25]);
	  }
	  intersection() {
	    translate([xx+xtolerance/2,yy,zz]) rotate([0,a-23,0]) translate([-xx,-yy,-zz]) translate([0,yy+ry-0.01,axleheight]) rotate([-90,0,0]) cylinder(d=swingl+xtolerance,h=0.02,$fn=360);
	    translate([boxx,yy+ry-0.01,0]) cube([boxl,0.02,25]);
	  }
	}
    }
  }
}

module lockcuts() {
  lockaxlecuts();

  difference() {
    union() {
      incomingtunnelcuts();
      outgoingtunnelcuts(0);
    }
    
    // Do not cut lock axle end covers
    for (y=[lockaxlelefty+ytolerance,lockaxley-lockaxlel/2-wall-ytolerance+0.5]) {
      hull() {
	translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+2,h=axledepth+0.5);
      }
    }
  }
}

module locksideclips(cut) {
  tolerance=0.2;
  dtolerance=0.4;
  yt=cut?tolerance:0;
  xt=cut?tolerance:0;
  zt=cut?tolerance:0;
  dt=cut?dtolerance:0;
  //  yt=cut?ytolerance:0;
  //xt=cut?xtolerance:0;
  //zt=cut?ztolerance:0;
  //dt=cut?dtolerance:0;
  
  intersection() {
    translate([boxx+lockinsertl/2-lockinsertclipd/2,lockinserty+lockinsertclipdepth,lockinsertclipd/2+1]) tubeclip(lockinsertl+lockinsertclipd/2,lockinsertclipd,cut);
    translate([boxx+lockinsertl/2-lockinsertl/2-(cut?0.01:0),lockinserty+lockinsertclipdepth-lockinsertclipd/2-dt*2,1]) cube([lockinsertl+lockinsertclipd/2+(cut?0.01:0),lockinsertclipd/2+dt,lockinsertclipd]);
  }

  intersection() {
    translate([boxx+lockinsertl/2-lockinsertclipd/2,lockinserty+lockinsertw-lockinsertclipdepth,lockinsertclipd/2+1]) tubeclip(lockinsertl+lockinsertclipd/2,lockinsertclipd,cut);
    translate([boxx+lockinsertl/2-lockinsertl/2-(cut?0.01:0),lockinserty+lockinsertw-lockinsertclipdepth,1]) cube([lockinsertl+lockinsertclipd/2+(cut?0.01:0),lockinsertclipd/2+dt*2,lockinsertclipd]);
  }
}

module lockinsertform(cut) {
  tolerance=0.2;
  dtolerance=0.4;
  yt=cut?tolerance:0;
  xt=cut?tolerance:0;
  zt=cut?tolerance:0;
  dt=cut?dtolerance:0;
  
  hull() {
    //    translate([boxx-(cut?0.01:0),lockinserty-yt,cut?-0.01:0]) cube([lockinsertl+(cut?0.01:0)+xt,lockinsertw+yt*2,(cut?0.01:0)+lockinserth+zt]);
    //    translate([boxx-(cut?0.01:0),lockinserty-yt,cut?-0.01:0]) cube([lockinsertl+lockinserth+(cut?0.01:0)+xt,lockinsertw+yt*2,0.01]);
    translate([boxx-(cut?0.01:0),lockinserty-yt,cut?-0.01:0]) roundedbox(lockinsertl+(cut?0.01:0)+xt,lockinsertw+yt*2,(cut?0.01:0)+lockinserth+zt,cornerd,5);
    translate([boxx-(cut?0.01:0),lockinserty-yt,cut?-0.01:0]) cube([lockinsertl+lockinserth+(cut?0.01:0)+xt,lockinsertw+yt*2,0.01]);
  }

  translate([boxx+lockinsertl-lockinsertclipd/2-1-(cut?0.01:0),-swingtunnelw/2-midwallw/2,lockinserth-lockinsertclipdepth]) sphere(d=lockinsertclipd+(cut?dtolerance:0));

  if (cut) locksideclips(cut);
}

module lockinsert() {
  difference() {
    union() {
      lockinsertform(0);
      locksideclips(0);
    }

    lockcuts();
  }

  lock(0);
}

module storagegate() {
  hull() {
    translate([boxx+wall+xtolerance,boxy+wall+storagew-boxincornerd,wall*2]) roundedbox(outholel-wall-xtolerance*2,boxincornerd+wall+swingtunnelw-wall-ytolerance-0.5-wall-ytolerance-0.05,outholeh,boxincornerd);
    translate([boxx+wall+(outholel-wall-xtolerance*2)/2-maxbridge/2+xtolerance,boxy+storagew+boxincornerd,outholel*1.7-maxbridge*2]) roundedbox(maxbridge,boxincornerd*2,boxincornerd,cornerd);
  }
}

module flap(cut,includeaxle) {
  difference() {
    union() {
      intersection() {
	union() {
	  if (includeaxle) translate([0,-flapaxlew/2-(cut?ytolerance:0),0]) rotate([-90,0,0]) roundedcylinder(saranad+(cut?dtolerance:0),flapaxlew+(cut?ytolerance*2:0),cornerd,0,90);
	  translate([cut?-xtolerance:0,-flapw/2-(cut?ytolerance:0),cut?-ztolerance:0]) roundedbox(saranad/2+(cut?xtolerance*2:0),flapw+(cut?ytolerance*2:0),flaph+(cut?ztolerance*2:0),cornerd,0);
	}

	translate([cut?-xtolerance:0,(cut?-ytolerance:0)-flapaxlew/2,(cut?-ztolerance:0)-saranad/2]) cube([saranad/2+(cut?xtolerance*2:0),flapaxlew+(cut?ytolerance*2:0),flaph+saranad/2+(cut?ztolerance*2:0)]);
      }
    }

    if (!cut) {
      translate([saranad/2-textdepth+0.01,0,flaph/2]) rotate([0,90,0]) linear_extrude(height=textdepth) text(version, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    }
  }
}

module mousestorage() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([storageboxx+storageboxl/2-doorl/2-wall*2,storageboxy-wall,0]) {
	    roundedboxxyz(doorl+wall*4,doorw+wall,storageboxh-wall-ztolerance,doorw+2,cornerd,1,90);
	  }
	
	  difference() {
	    union() {
	      intersection() {
		minkowski() {
		  cylinder(d=storageboxoutcornerd,h=1);
		  translate([storageboxx+storageboxoutcornerd/2,storageboxy+storageboxoutcornerd/2,0]) cube([storageboxl-storageboxoutcornerd,storageboxw-storageboxoutcornerd,storageboxh-cornerd]);
		}
		translate([storageboxx,storageboxy,0]) cube([storageboxl,storageboxw,storageboxh-wall-ztolerance]);
	      }

	      // locking storage box into mousebox
	      translate([storageboxx+storageboxl-boxcornerd/2,boxlocky,0]) cube([boxlockl+boxcornerd,boxlockw,boxlockh]);
	      for (y=boxlockpinholeytable) {
		translate([boxlockpinholex,y,0]) cylinder(d=boxlockpind,h=boxlockpinh);
	      }

	      if (antiwarp) {
		antiwarph=storageboxh+5;
		difference() {
		  minkowski(convexity=10) {
		    union() {
		      translate([storageboxx+storageboxoutcornerd/2-antiwarpdistance-antiwarpw,storageboxy+storageboxoutcornerd/2-antiwarpdistance-antiwarpw,0]) cube([storageboxl-storageboxoutcornerd+antiwarpdistance*2+antiwarpw*2,storageboxw-storageboxoutcornerd+antiwarpdistance*2+antiwarpw*2,antiwarph]);
		      translate([storageboxx+storageboxl/2-(doorl/2+wall)-storageboxoutcornerd/2+antiwarpdistance+antiwarpw,storageboxy-wall+storageboxoutcornerd/2-antiwarpdistance-antiwarpw,0]) cube([(doorl+wall*2)+storageboxoutcornerd-antiwarpdistance*2-antiwarpw*2,storageboxw-storageboxoutcornerd+antiwarpdistance+antiwarpw*2,antiwarph]);
		      translate([storageboxx+storageboxl-boxcornerd/2,boxlocky-antiwarpdistance-antiwarpw,0]) cube([boxlockl+boxcornerd-storageboxoutcornerd/2+antiwarpdistance+antiwarpw,boxlockw+antiwarpdistance*2+antiwarpw*2,antiwarph]);
		    }
		    cylinder(d=storageboxoutcornerd,h=1);
		  }
		  minkowski(convexity=10) {
		    union() {
		      translate([storageboxx+storageboxoutcornerd/2-antiwarpdistance,storageboxy+storageboxoutcornerd/2-antiwarpdistance,-0.1]) cube([storageboxl-storageboxoutcornerd+antiwarpdistance*2,storageboxw-storageboxoutcornerd+antiwarpdistance*2,antiwarph+0.2]);
		      translate([storageboxx+storageboxl/2-(doorl/2+wall)-storageboxoutcornerd/2+antiwarpw+antiwarpdistance,storageboxy-wall+storageboxoutcornerd/2-antiwarpdistance,-0.1]) cube([doorl+wall*2+storageboxoutcornerd-antiwarpdistance*2-antiwarpw*2,storageboxw+wall-storageboxoutcornerd+antiwarpdistance*2,antiwarph+0.2]);
		      translate([storageboxx+storageboxl-boxcornerd/2,boxlocky-antiwarpdistance,-0.1]) cube([boxlockl+boxcornerd-storageboxoutcornerd/2+antiwarpdistance,boxlockw+antiwarpdistance*2,antiwarph+0.2]);
		    }
		    cylinder(d=storageboxoutcornerd,h=1);
		  }

		  // Space between antiwarp and object needs to be outside to get brim in between.
		  translate([storageboxx+storageboxl/2,storageboxy+storageboxw,-0.1]) cube([1,antiwarpdistance+antiwarpw+1,0.4+0.1]);
		}
	      }
	    }

	    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-textdepth+0.01,storageboxh/2]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-textdepth+0.01,storageboxh/2-copyrighttextoffset]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");


	    // Opening between out tunnel and storage
	    hull() {
	      translate([storageboxx+storageboxl-wall-boxincornerd/2,outopeningy,wall*2]) roundedbox(boxincornerd+wall,outopeningw,outholeh,boxincornerd);
	      translate([storageboxx+storageboxl-wall-boxincornerd/2,outopeningy+(outopeningw-maxbridge)/2,wall*2+outholetotalh-1]) cube([boxincornerd+wall,maxbridge,1]);
	    }
	    
	    // Mouse storage
	    translate([storageboxx+wall,storageboxy+wall,wall]) roundedbox(storagel/2-boxincornerd-wall*3,storagew,storageh,boxincornerd);
	    translate([storageboxx+wall,storageboxy+wall+wall,wall]) roundedbox(storagel,storagew-wall,storageh,boxincornerd);
	    translate([storageboxx+storageboxl-wall-(storagel/2-boxincornerd-wall*3),storageboxy+wall,wall]) roundedbox(storagel/2-boxincornerd-wall*3,storagew,storageh,boxincornerd);
	  }
	}
      }

      for (x=[storageboxx+storageboxl/5,storageboxx+storageboxl-storageboxl/5]) {
	for (y=[storageboxy+clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }

      for (x=[storageboxx+storageboxl/4,storageboxx+storageboxl/2,storageboxx+storageboxl-storageboxl/4]) {
	for (y=[storageboxy+storageboxw-clipd/2]) {
	  translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
	}
      }
	
      for (x=[storageboxx+clipd/2,storageboxx+storageboxl-clipd/2]) {
	ylist=(x==storageboxx+clipd/2?[storageboxy+wall+storagew/4,storageboxy+wall+storagew*3/4]:storageboxy+wall+storagew/4);
	for (y=ylist) {
	  translate([x,y,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,0);
	}
      }

    }

    doorcut();

    translate([storageboxx+storageboxl/2,storageboxy+clipd/2,clipheight]) tubeclip(clipl,clipd,dtolerance);
  }

  // Flap to prevent mice to espace from storage box when emptying it
  difference() {
    x=flapaxlex-sin(flapangle)*flaph+(flapwalld-saranacoverd)/2;
    
    union() {
      hull() {
	translate([flapaxlex,flapy-flapaxleextend-thinwall-ytolerance,flapaxleheight]) rotate([-90,0,0]) roundedcylinder(saranacoverd,flapaxlew+xtolerance*2+thinwall*2,cornerd,0,90);
	translate([storageboxx+storageboxl-wall+wall/2,flapy-flapaxleextend-thinwall-ytolerance,flapaxleheight-saranacoverd*2/3-wall/2]) rotate([-90,0,0]) roundedcylinder(wall,flapaxlew+xtolerance*2+thinwall*2,cornerd,0,90);
      }

      intersection() {
	translate([storageboxx,storageboxy,0]) cube([storageboxl,storageboxw,storageboxh]);
	union() {
	  hull() {
	    translate([flapaxlex-sin(flapangle)*flaph,flapy-flapwall-ytolerance,saranacoverd/2]) rotate([-90,0,0]) roundedcylinder(saranacoverd,flapw+flapwall*2+xtolerance*2,flapwallcornerd,0,90);
	    translate([flapaxlex-sin(flapangle)*flaph-flapwall/2,flapy-flapwall-ytolerance,0]) rotate([-90,0,0]) roundedcylinder(saranacoverd,flapw+flapwall*2+xtolerance*2,flapwallcornerd,0,90);
	  }
	  
	  for (y=[flapy-flapwall-ytolerance,flapy+flapw+ytolerance]) {
	    hull() {
	      translate([flapaxlex,y,flapaxleheight]) rotate([-90,0,0]) roundedcylinder(flapwalld,flapwall,flapwallcornerd,0,90);
	      translate([storageboxx+storageboxl-flapwall/2,y+flapwall/2,flapaxleheight+saranacoverd-flapwall/2]) sphere(d=flapwall);
	      translate([flapaxlex,y,flapwalld/2]) rotate([-90,0,0]) roundedcylinder(flapwalld,flapwall,flapwallcornerd,0,90);
	      translate([x,y,flapwalld/2]) rotate([-90,0,0]) roundedcylinder(flapwalld,flapwall,flapwallcornerd,0,90);
	      translate([x-flapwall/2,y,0]) rotate([-90,0,0]) roundedcylinder(flapwalld,flapwall,flapwallcornerd,0,90);
	    }
	  }
	}
      }
    }

    hull() {
      translate([flapaxlex,flapy-flapaxleextend-ytolerance,flapaxleheight]) rotate([-90,0,0]) cylinder(d=saranad+dtolerance,h=flapaxlew+xtolerance*2);
      translate([flapaxlex+1/2,flapy-flapaxleextend-ytolerance,flapaxleheight+saranad*2/3]) rotate([-90,0,0]) cylinder(d=1,h=flapaxlew+xtolerance*2);
    }
    hull() {
      for (z=[flapaxleheight,flapaxleheight+saranacoverd]) {
	translate([flapaxlex,flapy+flapw/2,z]) flap(1,1);
      }
    }

    translate([flapaxlex,flapy+flapw/2,flapaxleheight]) hull() {
      for (a=[0,-90]) {
	rotate([0,a,0]) flap(1,0);
      }
    }

    translate([flapaxlex,flapy+flapw/2,flapaxleheight]) hull() {
      for (a=[-90,-180+flapangle,-180+flapangle+1,-180+flapangle+2,-180+flapangle+3,-180+flapangle+4,-180+flapangle+5]) {
	rotate([0,a,0]) flap(1,0);
      }
    }
  }
}

swingtunnelladjust=swingtunnelw/1.4;
endwin=maxbridge*1.4;//maxbridge*1.5;//+boxincornerd-wall/2;
endwout=maxbridge+wall*2;//+boxincornerd
tunnelendx=boxx+boxl-wall-swingtunnelladjust-1;
swingtunnell=boxincornerd/2+boxl-swingtunnelladjust;
outgoingswingtunnell=boxl+boxx+swingl/2-swingtunnelladjust;

module swingsupports() {
  // spaces for swing axles
  for (y=[-swingw/2+wall/2+ytolerance,swingw/2-wall/2-axledepth-1-ytolerance]) {
    for (yy=[y,y-swingtunnelw-midwallw]) {
      hull() {
	translate([-axleheight,yy+0.5,wall]) rotate([-90,0,0]) cylinder(d=1,h=axledepth-0.01);
	translate([0,yy,axleheight]) rotate([-90,0,0]) cylinder(d=axled+2,h=axledepth+1);
      }
      hull() {
	translate([0,yy,axleheight]) rotate([-90,0,0]) cylinder(d=axled+2,h=axledepth+1);
	translate([axleheight,yy+0.5,wall]) rotate([-90,0,0]) cylinder(d=1,h=axledepth-0.01);
      }
    }
  }

  for (y=[0,-swingtunnelw/2-midwallw-swingtunnelw/2]) {
    difference() {
      union() {
	hull() {
	  translate([-axleheight,y-swingtunnelw/2-0.1,1/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	  translate([0,y-swingtunnelw/2-0.1,axleheight-axled/2-1/2-ztolerance]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	  translate([axleheight,y-swingtunnelw/2-0.1,1/2]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	}
	
	hull() {
	  hull() {
	    translate([-axled+2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
	    translate([0,y-swingw/2+wall/2+ytolerance,axleheight+swingheight-axled/2-ztolerance-wall/2]) rotate([-90,0,0]) cylinder(d=axled,h=swingw-wall-ytolerance*2);
	    translate([axled-2,y-swingw/2+wall/2+ytolerance+1,axleheight-wall-ztolerance-wall/2-axled]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-1-2);
	  }
	  for (x=[-axleheight-axled,0,axleheight+axled]) {
	    translate([x,y-swingw/2+wall/2+ytolerance+abs(sign(x)),wall/2]) rotate([-90,0,0]) cylinder(d=wall,h=swingw-wall-ytolerance*2-abs(sign(x))*2);
	  }
	}
      }

      if (makevoids || mechanicstest) {
	hull() {
	  translate([-axleheight+wall*2.5,y-swingtunnelw/2-0.1,1/2+wall]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	  translate([0,y-swingtunnelw/2-0.1,axleheight-1/2-wall-ztolerance-wall/2-wall]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	  translate([axleheight-wall*2.5,y-swingtunnelw/2-0.1,1/2+wall]) rotate([-90,0,0]) cylinder(d=1,h=swingtunnelw+0.2);
	}
	
	hull() {
	  hull() {
	    translate([0,y-swingw/2+wall/2+ytolerance+wall,axleheight-wall-ztolerance-wall/2-wall]) rotate([-90,0,0]) cylinder(d=axled+2,h=swingw-wall-ytolerance*2-wall*2);
	  }
	  for (x=[-axleheight-axled+wall*3,0,axleheight+axled-wall*3]) {
	    translate([x,y-swingw/2+wall/2+ytolerance+abs(sign(x))+wall,wall/2+wall]) rotate([-90,0,0]) cylinder(d=wall,h=swingw-wall-ytolerance*2-abs(sign(x))*2-wall*2);
	  }
	}
      }
    }
  }
}

module mechanicsbox() {
  union() {
    intersection() {
      hull() {
	hull() {
	  translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	}
		  
	hull() {
	  translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	}
		  
	hull() {
	  translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	}
		  
	hull() {
	  translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	}
		  
	hull() {
	  translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,cornerd/2]) sphere(d=cornerd);
	  translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,boxh-cornerd/2]) sphere(d=cornerd);
	  translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,cornerd/2]) sphere(d=cornerd);
	  translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	}
      }
      translate([boxx,boxy,0]) cube([boxl,boxw,boxh-wall-ztolerance]);//-boxincornerd/2
    }
  }
}

module incomingtunnelcuts() {
  c=boxincornerd;
  translate([boxx-c/2,-swingtunnelw/2,wall*2]) roundedbox(swingtunnell,swingtunnelw,boxh-wall*3+c/2,c);
  hull() {
    translate([boxx-c/2,-swingtunnelw/2,wall*2]) roundedbox(swingtunnell-wall-c/2,swingtunnelw,boxh-wall*3-c/2,c);
    translate([-swingl/2*cos(closedangle)-swingheight*cos(closedangle)-cornerd/2-cornerd/2-swingweightl,-swingtunnelw/2,wall*2]) roundedbox(cornerd+2*swingweightl+swingl*cos(closedangle)-wall,swingtunnelw,boxh-wall*3-c/2,cornerd);
  }

  // Cut for lock movement, incoming tunnel
  translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall*2+ytolerance*2,storageh]);

  // Cut for lock movement, incoming tunnel
  //  translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall*2+ytolerance*2,storageh]);
}

module outgoingtunnelcuts(rightwide) {
  c=boxincornerd;
  
  // Cut for lock movement, outgoing tunnel
  hull() {
    translate([lockaxlex-lockaxled/2-axledtolerance/2,-swingtunnelw/2-midwallw-ytolerance-wall-ytolerance-0.5,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall+ytolerance+0.5,storageh]);
    translate([lockaxlex+lockaxled*2,-swingtunnelw/2-midwallw-ytolerance-wall-ytolerance-0.5,0.8]) cube([20-lockaxled,ytolerance+wall+ytolerance+0.5,storageh]);
  }

  // Outgoing tunnel
  hull() {
    translate([-swingl/2,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(outgoingswingtunnell,swingtunnelw,storageh-wall,c);
    translate([-swingl/2*cos(closedangle)-cornerd,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(swingweightl+swingheight*cos(closedangle)+swingl*cos(closedangle)+cornerd*2,swingtunnelw,boxh-wall*3,cornerd);
  }
  translate([boxx-c/2,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(swingtunnell,swingtunnelw-wall-ytolerance-wall-ytolerance,storageh-wall,c);
	      
  hull() {
    ywiden=rightwide?lockrighty-lockinserty:0;
    translate([lockaxlex-lockaxled/2-axledtolerance/2,lockrighty-ytolerance-ywiden,wall*2]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+xtolerance,ytolerance+wall+ytolerance+ywiden,lockinserth+ztolerance-wall*2]);
    translate([lockaxlex+lockaxled*2,lockrighty-ytolerance-ywiden,0.8]) cube([20-lockaxled,ytolerance+wall+ytolerance+ywiden,lockinserth+ztolerance-0.8]);
  }
}

// Open the mechanics box for mechanics
module mechanicscuts() {
  c=boxincornerd;
  
  // Spaces for swinging platforms
  swingcut();
  translate([0,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) swingcut();
    
  // Incoming tunnel
  incomingtunnelcuts();

  // Outgoing tunnel
  outgoingtunnelcuts(1);
  
  xx=swingl/2*cos(closedangle);

  // Opening between in and out tunnels
  hull() {
    translate([midtunnelx,-swingtunnelw-midwallw-swingtunnelw/2,wall*2]) roundedbox(midholel-swingtunnelladjust+wall,swingtunnelw+midwallw+swingtunnelw,boxh-wall*3+boxincornerd,boxincornerd);
    hull() {
      translate([midtunnelx,-swingtunnelw/2-midwallw/2-endwin/2,wall*2]) roundedbox(midholel,endwin,boxh-wall*3+boxincornerd/2,boxincornerd);
      translate([midtunnelx,-swingtunnelw/2-midwallw/2-endwin/2,wall*2+boxincornerd/4]) cube([midholel,endwin,boxh-boxincornerd/2+boxincornerd/4-wall*3]);
    }
  }

  // Opening at exit part of out tunnel
  translate([boxx+wall,-swingtunnelw/2-midwallw-swingtunnelw,wall*2]) roundedbox(-boxx-xx+boxincornerd,swingtunnelw-wall-lockaxledepth/2-wall/2-lockaxledepth+ytolerance,storageh,boxincornerd);
    
  // Cut for locking storage box into mousebox
  translate([boxx-0.01,boxlocky-ytolerance,-0.1]) hull() {
    cube([boxlockl+xtolerance,boxlockw+ytolerance*2,boxlockh+0.1+ztolerance]);
    cube([boxlockl+xtolerance+wall,boxlockw+ytolerance*2,0.1]);
  }
  if (!mechanicstest) for (y=boxlockpinholeytable) {
    translate([boxlockpinholex,y,0]) cylinder(d=boxlockpind+dtolerance,h=boxlockpinholeh);
  }

  // Cut for lock insert
  lockinsertform(1);
  
  // Cuts for lock movement
  lockcuts();
  
  // Cut for lock weight movement
  y=-swingtunnelw/2-midwallw/2-lockweightw/2-0.5-ytolerance;
  h=storageh-arml+lockweighth-wall*1-0.3-wall;
  height=arml/2;
  oheight=lockaxled/2+arml*cos(lockangle);
  oh=boxh-wall-oheight-wall/2;
  
  intersection() {
    union() {
      translate([lockaxlex-lockaxled/2+0.4,y,height]) cube([axledtolerance+lockaxled+arml*sin(90-lockangle)+lockweightl+xtolerance,ytolerance+lockweightw+ytolerance+1,h]);

      hull() {
	translate([lockaxlex-lockaxled/2-axledtolerance/2,y,oheight]) cube([arml*cos(lockangle)-lockaxled-wall,ytolerance+lockweightw+ytolerance+wall+0.1,oh]);
	translate([lockaxlex-lockaxled/2-axledtolerance/2+oh,y,oheight+oh-lockaxled/2-0.1]) cube([arml*cos(lockangle)-lockaxled-wall,ytolerance+lockweightw+ytolerance+wall+0.1,0.1]);
      }
    }

    translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(r=arml+lockweighth+lockweightl-wall*3,h=ytolerance+lockweightw+ytolerance+wall+0.1);
  }

  // Reduce print time for mechanicstest. Does not save time for actual print, as printing walls is more expensive than fill
  if (mechanicstest) {
    x=lockaxlex+arml+lockweighth+lockweightl-wall;
    l=midtunnelx-x-wall;
    translate([x,-swingtunnelw/2-midwallw+thinwall,thinwall]) cube([midtunnelx-x-wall,midwallw-thinwall*2,boxh]);
  }

  // Test saving holes, did not work, filament consumption increased.
  if (makevoids) {
    translate([boxx+lockaxled/2+lockaxled,midholey+wall,wall]) cube([midwalll-lockaxled/2-lockaxled-wall,midwallw-wall*2,height-wall-wall]);
    difference() {
      translate([boxx+lockaxled/2+lockaxled,midholey+wall,height]) cube([midwalll-lockaxled/2-lockaxled-wall,midwallw-wall*2,boxh-wall-wall-height]);
      translate([lockaxlex,y,lockaxleheight]) rotate([-90,0,0]) cylinder(r=arml+lockweighth+lockweightl-wall*3+wall,h=ytolerance+lockweightw+ytolerance+wall+0.1);
    }
  }
}

module crossbars() {
  // Roof crossbar to make cover stay in place better
  for (yy=[0,-swingtunnelw/2-midwallw-swingtunnelw/2]) {
    for (y=[-swingtunnelw/2-cornerd/2,swingtunnelw/2]) {
      hull() {
	for (x=[boxcrosssupportx,boxcrosssupportx+(swingtunnelw/2-maxbridge/2)]) {
	  translate([x,yy+y,boxcrosssupportheight]) roundedbox(boxcrosssupportl,cornerd,wall,cornerd);
	}
	translate([boxcrosssupportx+(swingtunnelw/2-maxbridge/2),yy+sign(y)*(maxbridge/4-cornerd/2),boxcrosssupportheight]) roundedbox(boxcrosssupportl,cornerd,boxcrosssupporth,cornerd);
      }
    }

    translate([boxcrosssupportx+(swingtunnelw/2-maxbridge/2),yy-(maxbridge/4-cornerd/2),boxcrosssupportheight]) roundedbox(boxcrosssupportl,maxbridge/2,boxcrosssupporth,cornerd);
  }

  // Incoming side crossbar
  translate([boxx,-swingtunnelw/2-midwallw-swingtunnelw-cornerd/2,incomingcrossbarheight]) roundedbox(wall,boxw-wall-wall+cornerd,boxinsupporth,cornerd);
}

module printadhesionsupports() {
  adhesiontowerh=swingsideh+9;
	    
  // Left support
  z=boxh-wall-ztolerance+0.1;
  lefty=locklefty+lockaxledepth*2;
  x=lockaxlex-lockaxled/2;

  righty=lockaxley-lockaxlel/2-wall/2-ytolerance;

  // Swings are very weakly connected through supports, so manually create support towers for better adhesion.
  ly=0;
  lx=-x-swingl/2-swingweightl;
  sl=swingl/2+swingweightl*2;
  sheight=axleheight+swingheight+wall+swingweighth+wall*2.5+0.3+0.3;
  translate([x,ly-swingw/2+wall*2,sheight]) {
    cube([sl,swingw-wall*2-1,0.8]);
    cube([lx-layerh,swingw-wall*2,0.8]);
  }

  swingmheight=axleheight+swingheight+wall+wall+0.6;
  swingmh=sheight-swingmheight;
	    
  for (lyy=mechanicstest?[0]:[-10,15]) {
    translate([x,lyy,sheight]) triangle(sl,0.8,adhesiontowerh,2);
    translate([x,lyy,swingmheight]) cube([lx-layerh,0.8,swingmheight]);
    hull() {
      translate([x+lx,lyy,swingmheight-0.9]) triangle(swingweightl,0.8,swingmh+1,3);
      translate([0,lyy,swingmheight-wall]) cube([0.4,0.8,swingmh+wall]);
      translate([0,lyy,swingmheight-wall]) cube([swingweightl-lx,0.8,swingmh+wall]);
    }

    for (xx=[x+lx+swingweightl:5:x+sl]) {
      translate([xx,lyy,axleheight+swingheight]) cube([layerh,0.4,swingmh]);
    }

    intersection() {
      for (xx=[x+lx+5:5:x+lx+swingweightl]) {
	translate([xx,lyy,axleheight+swingheight]) cube([layerh,0.4,swingmh+wall*3]);
      }
      hull() {
	translate([x+lx,lyy,axleheight+swingheight+wall]) triangle(swingweightl,0.8,swingmh,3);
	translate([x+lx,lyy,axleheight+swingheight+wall+swingmh]) cube([swingweightl,0.8,wall*2]);
      }
    }

    translate([x,ly-swingw/2+wall*2+1,sheight]) cube([0.4,swingw-wall*2-1,swingmheight-swingmh]);
  }
	    
  ry=-swingtunnelw/2-midwallw-swingtunnelw/2-wall*2-1;
  ryy=-swingtunnelw/2-midwallw-swingtunnelw/2;

  for (ryyy=(mechanicstest?[ryy]:[ryy-18,ryy+10])) {
    translate([x,ryy-swingw/2+1,axleheight+swingheight+wall+swingweighth+wall*2]) cube([swingl/2+swingweightl*2,swingw-wall*2-1,0.8]);
    translate([x,ryy-swingw/2-1,axleheight+swingheight+wall+swingweighth+wall*2]) cube([-x-swingl/2-layerh,swingw-wall*4-1,0.8]);
    translate([x,ryy,axleheight]) cube([-x-swingl/2-layerh,0.8,swingheight+wall+swingweighth+wall*2]);
	      
    translate([x,ryyy,sheight]) triangle(sl,0.8,adhesiontowerh,2);
    translate([x,ryyy,swingmheight]) cube([lx-layerh,0.8,swingmheight]);
    hull() {
      translate([x,ryyy,swingmheight-wall]) cube([sl,0.8,swingmh+wall]);
    }

    for (xx=[x+lx+swingweightl:5:x+sl]) {
      translate([xx,ryyy,axleheight+swingheight]) cube([layerh,0.4,swingmh]);
    }	

    translate([x,ry-swingw/2+wall*3+1,swingmheight]) cube([0.4,swingw-wall*2-3,swingmheight]);
  }
}

module lockaxlecuts() {
  translate([lockaxlex,lockaxley,lockaxleheight]) onehinge(lockaxled,lockaxlel,lockaxledepth,2,ytolerance,axledtolerance);
  hull() {
    translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+axledtolerance*2,h=lockaxlel+ytolerance*2);
    translate([lockaxlex+lockaxled/2+axledtolerance+1,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=0.5,h=lockaxlel+ytolerance*2);
  }

  // Accommodate lock angle in locked position
  intersection() {
    hull() {
      translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,lockaxleheight]) rotate([-90,0,0]) cylinder(d=lockaxled+axledtolerance*2,h=lockaxlel+ytolerance*2);
      translate([lockaxlex+lockaxled+axledtolerance+3,lockaxley-lockaxlel/2-ytolerance,lockaxleheight+lockaxled/2]) rotate([-90,0,0]) cylinder(d=0.5,h=lockaxlel+ytolerance*2);
    }
    
    union() {
      translate([lockaxlex,lockaxley-lockaxlel/2-ytolerance,wall]) cube([lockweightl,wall+ytolerance*2,wall+0.01]);
      translate([lockaxlex,-swingtunnelw/2,wall]) cube([lockweightl,wall+ytolerance*2+1.5,wall+0.01]);
    }
  }
}

module mousebox() {
  difference() {
    union() {
      difference() {
	mechanicsbox();
	    
	translate([boxx+boxl/2,boxy+boxw-textdepth+0.01,boxh/2]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	translate([boxx+boxl/2,boxy+boxw-textdepth+0.01,boxh/2-copyrighttextoffset]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
	translate([0,-swingtunnelw/2-midwallw/2,textdepth-0.01]) rotate([0,180,0]) linear_extrude(height=textdepth) text(version, size=textsize, valign="center",halign="left",font="Liberation Sans:style=Bold");

	mechanicscuts();
      }
	  
      // Support below swings
      swingsupports();

      crossbars();
	  
      if (adhesion) {
	printadhesionsupports();
      }
    }

    // Lock axle hinge cuts
    //lockaxlecuts();

    for (y=[0,-swingtunnelw/2-midwallw-swingtunnelw/2]) {
      translate([0,y-swingw/2,axleheight]) onehinge(axled,axlel,axledepth,2,ytolerance,axledtolerance);
      translate([0,y+swingw/2,axleheight]) onehinge(axled,axlel,axledepth,2,ytolerance,axledtolerance);
    }
  }

  for (x=boxclipxpositions) {
    for (y=[boxy+clipd/2,boxy+boxw-clipd/2]) {
      translate([x,y,clipheight]) tubeclip(clipl,clipd,0);
    }
  }
}

// Make a roof insert for cover. Call roundedroofcut separately as these may be unionized.
module roundedroof(x,y,z,l,w,h,c) {
  intersection() {
    translate([x,y,z-c/2]) roundedbox(l,w,h+c,c);
    translate([x+xtolerance,y+ytolerance,z+cutsmall]) cube([l-xtolerance*2,w-ytolerance*2,h-cutsmall]);
  }
}

// Cutout part of roof insert
module roundedroofcut(x,y,z,l,w,h,c) {
  translate([x,y,z-c/2]) roundedbox(l,w,c,c);
}

module storagecover() {
  difference() {
    union() {
      intersection() {
	minkowski() {
	  cylinder(d=storageboxoutcornerd,h=1);
	  translate([storageboxx+storageboxoutcornerd/2,storageboxy+storageboxoutcornerd/2,storageboxh-wall]) cube([storageboxl-storageboxoutcornerd,storageboxw-storageboxoutcornerd,wall-1]);
	}
      }

      theight=axleheight+swingheight+swingl/2*sin(closedangle)-wall;
      th=storageboxh-theight+wall+boxincornerd+0.01;
      tx=-cos(closedangle)*swingl/2-wall;
      tl=storageboxl-tx+storageboxx-wall;
  
      intersection() {
	union() {
	  difference() {
	    union() {
	      // Mouse storage
	      roundedroof(storageboxx+wall,storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew,boxincornerd/2,boxincornerd+xtolerance);
	      roundedroof(storageboxx+wall,storageboxy+wall+wall,storageboxh-wall-boxincornerd/2,storagel,storagew-wall,boxincornerd/2,boxincornerd+xtolerance);
	      roundedroof(storageboxx+storageboxl-wall-(storagel/2-boxincornerd-wall*3),storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew-2,boxincornerd/2,boxincornerd+xtolerance);
	    }

	    // Storage roof cut
	    roundedroofcut(storageboxx+wall,storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew,boxincornerd/2,boxincornerd);
	    roundedroofcut(storageboxx+wall,storageboxy+wall+wall,storageboxh-wall-boxincornerd/2,storagel,storagew-wall,boxincornerd/2,boxincornerd);
	    roundedroofcut(storageboxx+storageboxl-wall-(storagel/2-boxincornerd-wall*3),storageboxy+wall,storageboxh-wall-boxincornerd/2,storagel/2-boxincornerd-wall*3,storagew,boxincornerd/2,boxincornerd);
	  }
	}
      }

      if (windows) {
	windowframe(storageboxx+storageboxl/2,storageboxy+storageboxw/2,storagewindowheight,storagewindowl,storagewindoww,windowh);
      }
    }

    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-8,storageboxh-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([storageboxx+storageboxl/2,storageboxy+storageboxw-copyrighttextoffset-6,storageboxh-textdepth+0.01]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");

    // Cover locking clips
    for (x=[storageboxx+storageboxl/5,storageboxx+storageboxl-storageboxl/5]) {
      for (y=[storageboxy+clipd/2]) {
	translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
      }
    }
    
    for (x=[storageboxx+storageboxl/4,storageboxx+storageboxl/2,storageboxx+storageboxl-storageboxl/4]) {
      for (y=[storageboxy+clipd/2,storageboxy+wall+storagew+wall-clipd/2,storageboxy+wall+storagew+clipd/2,storageboxy+storageboxw-clipd/2]) {
	translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
      }
    }
    
    for (x=[storageboxx+clipd/2,storageboxx+storageboxl-clipd/2]) {
      for (y=[-swingtunnelw/2-midwallw-swingtunnelw/2,storageboxy+wall+storagew/4,storageboxy+wall+storagew*3/4]) {
	translate([x,y,clipheight]) rotate([0,0,90]) tubeclip(clipl,clipd,dtolerance);
      }
    }

    doorcut();

    if (windows) {
      windowcut(storageboxx+storageboxl/2,storageboxy+storageboxw/2,storagewindowheight,storagewindowl,storagewindoww,windowh);
    } else {
      // If no windows, make air holes 
      airholefromedge=boxincornerd+wall+5;
      airholeoutdiameter=10;
      airholeindiameter=2;
      airholesw=5;
      airholesl=10;
      airholexstep=(storagel-airholefromedge*2)/airholesl;
      airholeystep=(storagew-airholefromedge*2)/airholesw;
    
      for (x=[storageboxx+wall+airholefromedge+airholexstep/2:airholexstep:storageboxx+storageboxl-airholefromedge]) {
	for (y=[storageboxy+wall+airholefromedge+airholeystep/2:airholeystep:storageboxy+storagew-airholefromedge]) {
	  hull() {
	    translate([x,y,storageboxh-wall-0.1]) cylinder(d=airholeindiameter,h=0.4);
	    translate([x,y,storageboxh-wall-0.2]) cylinder(d=airholeoutdiameter,h=0.1);
	  }
	  translate([x,y,storageboxh-wall-0.1]) cylinder(d=airholeindiameter,h=wall+0.2);
	}
      }
    }
  }
}

module cover() {
  difference() {
    union() {
      intersection() {
	hull() {
	  hull() {
	    translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+cornerd/2,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+boxw-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([tunnelendx,boxy+boxw-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
		  
	  hull() {
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2-endwout/2,boxh-cornerd/2]) sphere(d=cornerd);
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,cornerd/2]) sphere(d=cornerd);
	    translate([boxx+boxl-cornerd/2,boxy+boxw/2+endwout/2-cornerd/2,boxh-cornerd/2]) sphere(d=cornerd);
	  }
	}
	
	//translate([boxx,boxy,0]) roundedbox(boxl,boxw,boxh,boxcornerd);
	translate([boxx-0.1,boxy-0.1,boxh-wall]) cube([boxl+0.2,boxw+0.02,wall]);
      }

      theight=axleheight+swingheight+swingl/2*sin(closedangle)+wall*1;
      //      th=boxh-theight+wall+boxincornerd+0.01;
      tx=-cos(closedangle)*swingl/2-wall;
      tl=boxl-tx+boxx-wall;

      c=boxincornerd;
      
      intersection() {
	union() {
	  difference() {
	    union() {
	      // Incoming tunnel
	      difference() {
		intersection() {
		  roundedroof(boxx+wall,-swingtunnelw/2,boxh-wall-c/2,swingtunnell-wall-c/2,swingtunnelw,c/2,c);
		  //		  translate([boxx+wall+xtolerance,-swingtunnelw/2+ytolerance,boxh-wall-boxincornerd]) cube([swingtunnell-wall-c/2-xtolerance*2,swingtunnelw-ytolerance*2,boxincornerd]);
		}

		//		translate([boxx+wall,-swingtunnelw/2,boxh-wall-boxincornerd]) cube([wall,swingtunnell,swingtunnelw]);
	      }

	      // Outgoing tunnel main section
	      roundedroof(tx,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-c/2,tl-swingtunnelladjust,swingtunnelw,c/2,c);
	      translate([boxx+wall+c/2+xtolerance,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,boxh-wall-c/2+cutsmall]) cube([tx-boxx+c/2-xtolerance*2,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance*2,c/2-wall]);
	      translate([tx+c/2,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,boxh-wall-c/2+cutsmall]) cube([c/2+xtolerance,swingtunnelw-ytolerance*2,c/2-1-cutsmall]);

	      // Opening between in and out tunnels
	      hull() {
		roundedroof(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,midholel-swingtunnelladjust+wall,swingtunnelw*2+midwallw,boxincornerd/2,boxincornerd);
		hull() {
		  roundedroof(boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2,boxh-wall-c/2,midholel-xtolerance*2,endwin,c/2,c);
		  hull() {
		    translate([boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2+ytolerance,boxh-wall-0.1]) cube([midholel-xtolerance*2,endwin-ytolerance*2,0.1]);
		    translate([boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2+ytolerance,boxh-wall-c/2]) cube([midholel-xtolerance*2-0.5,endwin-ytolerance*2,c/2]);
		  }
		}
	      }
	      
	      // Close extra spaces
	      translate([boxx+wall+xtolerance,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,theight-boxincornerd/2]) roundedbox(boxl-wall-tl-wall+boxincornerd/2-xtolerance,swingtunnelw-ytolerance-0.5-wall-ytolerance-wall-ytolerance,boxh-wall-theight+boxincornerd/2+wall,cornerd*2);
	    }

	    // Incoming tunnel roof cut
	    roundedroofcut(boxx+wall,-swingtunnelw/2,boxh-wall-c/2,boxl-wall-c/2-swingtunnelladjust,swingtunnelw,boxincornerd/2,boxincornerd);
	
	    // Outgoing tunnel roof cut
	    roundedroofcut(tx+boxincornerd/2,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,tl-boxincornerd/2-swingtunnelladjust,swingtunnelw,boxincornerd/2,boxincornerd);

	    // Swing cuts
	    coverswingcut(0,-swingtunnelw-midwallw-swingtunnelw/2,wall/2,swingl,boxh-2*wall-boxincornerd,swingtunnelw,axleheight,swingl+wall/2+ytolerance,boxincornerd);
	
	    // Opening between in and out tunnels roof cut
	    hull() {
	      roundedroofcut(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-boxincornerd/2,midholel-swingtunnelladjust+wall,swingtunnelw*2+midwallw,boxincornerd/2,boxincornerd);
	      hull() {
		roundedroofcut(boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw/2-endwin/2-c/4,boxh-wall-boxincornerd/2,midholel,endwin+c/2,c/2,c);
		//		translate([boxx+boxl-wall-midholel+xtolerance,-swingtunnelw/2-midwallw/2-endwin/2+ytolerance,boxh-wall-c/2]) cube([midholel-xtolerance*2,endwin-ytolerance*2,c/2]);
	      }
	    }
	    translate([boxx+boxl-wall-midholel,-swingtunnelw/2-midwallw-swingtunnelw,boxh-wall-c/2-0.1]) cube([midholel,swingtunnelw*2+midwallw,cutsmall+0.1]);
	  }
	}
      }

      closeheight=axleheight+swingheight-(-swingl/2)*sin(closedangle)+wall/2+wall+ztolerance;
      closeh=boxh-closeheight;
      closew=swingw-wall*2-wall/2-ytolerance*2-0.5;
	
      difference() {
	union() {
	  x=intunnelopenx;
	  z=closeheight-wall;
	  lx=x/2;
	  hull() {
	    translate([lx,-swingtunnelw/2+ytolerance,boxh-wall/2]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	    translate([x,-swingtunnelw/2+ytolerance,closeheight-wall+ztolerance]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	    translate([0,-swingtunnelw/2+ytolerance,boxh-wall/2]) rotate([-90,0,0]) cylinder(h=swingtunnelw-ytolerance*2,d=wall);
	  }
	}
      }

      translate([baitboxx,baitboxy,boxh-baitboxh]) rotate([0,0,baitboxangle]) baitboxslot();

      if (windows) {
	intersection() {
	  windowframe(boxx+inwindowcenterx,inwindowcentery,inwindowheight,inwindowl,inwindoww,windowh);
	  translate([boxx,-swingtunnelw/2+ytolerance,0]) cube([boxl,swingtunnelw-ytolerance*2,boxh]);
	}

	intersection() {
	  windowframe(boxx+outwindowcenterx,outwindowcentery,outwindowheight,outwindowl,outwindoww,windowh);
	  translate([boxx,-swingtunnelw/2-midwallw-swingtunnelw+ytolerance,0]) cube([boxl,swingtunnelw-ytolerance*2,boxh]);
	}
      }
    }

  // Cover locking clips
  for (x=boxclipxpositions) {
    for (y=[boxy+clipd/2,boxy+boxw-clipd/2]) {
      translate([x,y,clipheight]) tubeclip(clipl,clipd,dtolerance);
    }
  }

  if (windows) {
      windowcut(boxx+inwindowcenterx,inwindowcentery,inwindowheight,inwindowl,inwindoww,windowh);
      windowcut(boxx+outwindowcenterx,outwindowcentery,outwindowheight,outwindowl,outwindoww,windowh);
    }

    translate([baitboxx,baitboxy,boxh-baitboxh]) rotate([0,0,baitboxangle]) baitboxslotcut(); 

    translate([boxx+boxl/2,boxy+boxw/2+copyrighttextoffset/2,boxh-textdepth+0.01]) linear_extrude(height=textdepth) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
    translate([boxx+boxl/2,boxy+boxw/2-copyrighttextoffset/2,boxh-textdepth+0.01]) linear_extrude(height=textdepth) text(copyrighttext, size=copyrighttextsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module mousetrap(a,la) {
  intersection() {
    union() {
      mousebox();
      swing(a,1);
      translate([0,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) swing(a,0);

      //lockinsert();
      //translate([lockaxlex,lockaxley,lockaxleheight]) rotate([0,0,0]) translate([-lockaxlex,-lockaxley,-lockaxleheight]) lock(la);
    }
    //                    translate([-200,-swingtunnelw,-1]) cube([400,400,200]);//axleheight+1
    //                   translate([-200,-swingtunnelw/2+0.1-swingtunnelw-midwallw,-1]) cube([400,400,200]);//axleheight+1
    //                   translate([-200,-200,14]) cube([400,400,200]);//axleheight+1
    //translate([-100,-swingtunnelw/2-midwallw-6.8,-1]) cube([400,400,200]);//axleheight+1
    //        translate([-80,-100-swingtunnelw/2-midwallw-6.8,-1]) cube([400,400,200]);//axleheight+1
  }
}  

module door() {
  difference() {
    union() {
      translate([storageboxx+storagel/2-doorl/2,storageboxy,wall]) {
	hull() {
	  translate([doorw,doorw/4,0]) cube([doorl,doorw/2,doorh]);
	  translate([doorw,0,doorw/4]) cube([doorl,doorw,doorh-doorw/4]);
	  translate([0,doorw-0.01,doorw]) cube([doorl+doorw*2,0.01,doorh-doorw]);
	}
      }
      translate([storageboxx+storageboxl/2,storageboxy+clipd/2,clipheight]) tubeclip(clipl,clipd,0);
    }

    translate([storageboxx+storageboxl/2,storageboxy+textdepth-0.01,boxh/2-wall]) rotate([-90,90,180]) linear_extrude(height=textdepth) text(versiontext, size=textsize-3, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
}

module doorcut() {
  translate([storageboxx+storagel/2-doorl/2,storageboxy,wall-ztolerance]) {
    hull() {
      translate([-xtolerance+doorw,-ytolerance,0]) cube([doorl+ytolerance*2,doorw+xtolerance*2,doorh]);
      translate([-xtolerance,-ytolerance+doorw,wall]) cube([doorl+doorw*2+xtolerance*2,0.04+ytolerance*2,doorh+ztolerance]);
    }
    hull() {
      translate([(doorl-doorholel)/2+wall,-wall-0.01,boxincornerd/2]) cube([doorholel+ytolerance*2,doorw+xtolerance*2+wall+wall+0.02,doorholeh+boxincornerd-wall*2]);
      translate([(doorl-doorholel)/2+wall+(doorholel+ytolerance*2)/2-maxbridge/2,-wall-0.01,boxincornerd/2]) cube([maxbridge,doorw+xtolerance*2+wall+wall+0.02,doorholeh+boxincornerd+(doorholeh-maxbridge)/2-wall*2]);
    }
  }
}

xxx=lockaxlex-lockaxled/2;

mechanismx=lockaxlex-lockaxled/2-0.01;
mechanismy=-swingtunnelw/2-midwallw-swingtunnelw-axledepth;//-ytolerance;
mechanismz=wall/2;
mechanisml=swingl/2+swingweightl+1-xxx;
mechanismw=axledepth+swingtunnelw+midwallw+swingtunnelw+axledepth;
mechanismh=boxh-mechanismz;

module mechanics(angle,lockangle) {
  mousetrap(angle,lockangle);
}

module box() {
  difference() {
    mousetrap(0,0);
    translate([mechanismx-xtolerance,mechanismy-ytolerance,mechanismz-ztolerance]) cube([mechanisml+xtolerance*2,mechanismw+ytolerance*2,mechanismh+ztolerance*2]);
  }
}

if (print==0) {
  intersection() {
    union() {
      difference() {
	mechanics(angle,lockangle);
      }
      
      //mousestorage();
      //#door();
      //#storagecover();
      //#translate([baitboxx,baitboxy,boxh-baitboxh]) rotate([0,0,baitboxangle]) baitbox();
      //#cover();

      lockinsert();
    }
    //if (debug) translate([boxx,-swingtunnelw/2-midwallw/2,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
    //if (debug) translate([boxx,-swingtunnelw/2-swingtunnelw-50,boxh-wall*15]) cube([590,swingtunnelw*2+midwallw+50,100]);//axleheight+1
    //if (debug) translate([storageboxx+storageboxl/2-0,storageboxy,50]) cube([storageboxl+50,storageboxw,100]);
    //if (debug) translate([boxx-30,-swingtunnelw/2-midwallw-swingtunnelw/2,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
    if (debug) translate([boxx-30,-swingtunnelw/2-midwallw-3.5,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
    //if (debug) translate([boxx,-swingtunnelw/2-midwallw/2,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
    //if (debug) translate([boxx-50,0,0]) cube([590,swingtunnelw*2+midwallw,100]);//axleheight+1
  }
 }

if (print==1) {
  // Adhesion related
  h=(-swingl/2)-boxx;
  w=swingw-wall*2+wall+1.2+wall;

  intersection() {
    if (debug) translate([-1000-20,-swingtunnelw-swingw,0]) cube([1000,1000,1000]);
    //if (debug) translate([-1000-20,-swingw/2,0]) cube([1000,1000,1000]);
    if (mechanicstest) {
      union() {
	y=-swingtunnelw/2-midwallw/2;
	w2=midwallw+14;
	w3=midwallw+swingtunnelw-9;
	w4=midwallw+swingw*2+7;
	w5=midwallw+swingtunnelw*2+2;
	
	translate([-100,y-midwallw/2-0.01,0]) cube([100,midwallw+0.02,66]);
	translate([-80,y-w2/2,0]) cube([100,w2,50]);
	translate([-60,y-w3/2,0]) cube([100,w3,50]);
	difference() {
	  translate([-60,y-w4/2,0]) cube([36,w4,swingl+swingweightl+22]);
	  translate([-100,y-midwallw/2-0.01,66]) cube([101,midwallw+0.02,200]);
	}
	hull() {
	  translate([-axleheight-axled/2-1,y-w5/2,-boxx-axled/2]) cube([axleheight+axled/2+1,w5,axled+1]);
	  translate([-2,y-w5/2,0]) cube([axleheight,w5,-boxx+axled/2]);
	}
	//translate([-100,-swingtunnelw/2-midwallw-swingtunnelw-3,-200]) cube([400,boxw-6,200+40]);
	//translate([-70,-swingtunnelw/2-midwallw-swingtunnelw-3,-200]) cube([400,boxw-6,200+swingl/2-boxx]);
	//translate([-50,-swingtunnelw/2-midwallw-swingtunnelw-1,-200]) cube([400,boxw-4,200+swingl/2-boxx+swingweightl]);
      }
    }
    
    union() {
      if (adhesion) {
	// Support below incoming swing
	translate([-(axleheight+wall/2)-wall+0.4,-swingw/2+wall*2-ytolerance+0.4,0]) supportbox(wall,swingw-wall*2+wall/2-0.7,(-swingl/2)-boxx,1);
    
	// Support below outgoing swing
	difference() {
	  translate([-(axleheight+wall/2)-wall,-swingtunnelw/2-midwallw-swingw/2-swingw/2-wall/2-1,0]) supportbox(wall,w,h,1);
	  difference() {
	    translate([-(axleheight+wall/2)-0.3-wall,-swingtunnelw/2-midwallw-swingw/2-swingw/2-wall/2-1+w-h,-0.01]) triangle(wall+0.6,h+0.3,h,11);
	    translate([-(axleheight+wall/2)-0.3-wall,-swingtunnelw/2-midwallw-swingw/2-swingw/2-wall/2-2,0]) cube([wall+1,w-5,h]);
	  }
	}
      }

      difference() {
	union() {
	  translate([0,0,-xxx-0.01]) rotate([0,-90,0]) 
	    intersection() {
	    union() {
	      mousetrap(0,lockangleprint);
	    }
	    //if (debug) translate([-200,-swingtunnelw/2+10,30]) cube([400,400,60]);//axleheight+1
	    if (debug) translate([-200,-swingtunnelw/2-midwallw-swingtunnelw,30]) cube([400,400,60]);//axleheight+1
	  }
	}
	if (adhesion) {
	  hh=10;
	  translate([-(axleheight+wall/2)-0.3-wall-0.5,-swingtunnelw/2-midwallw-swingw/2-swingw/2-wall/2-1+w-hh+0.5,h-hh-0.01]) triangle(wall+0.6+1,hh+0.3,hh-0.01,10);
	}
      }
    }
  }
 }

if (print==2) {
  intersection() {
    translate([0,0,storageboxh]) rotate([180,0,0]) storagecover();

    if (debug) translate([storageboxx+storagel/2,-storageboxy-storagew/2,0]) cube([1000,1000,1000]);
  }
 }

if (print==3) {
  translate([-boxx,0,0]) {
    intersection() {
      if (debug) translate([storageboxx+storageboxl-60,storageboxy+storagew/2-10,0]) cube([60,flapaxlew+thinwall*2+flapwall,storageboxh]);
      mousestorage();
    }
    
    #if (debug) {
      translate([flapaxlex,flapy+flapw/2,flapaxleheight]) flap(0,1);
      translate([flapaxlex,flapy+flapw/2,flapaxleheight]) rotate([0,-180+flapangle,0]) flap(0,1);
    }
  }

 }

if (print==4) {
  difference() {
    rotate([0,0,45])
      intersection() {
      translate([0,0,boxh]) rotate([180,0,0]) {
	translate([-boxx,-boxy-boxw/2,0]) cover();
      }
      d=(boxw)/sqrt(2);
      d2=(boxw)/sqrt(2)+wall*2;
      hull() {
	translate([wall+ytolerance*2-0.3,0,0]) rotate([0,0,45]) translate([-d/2,-d/2,0]) cube([d,d,boxh]);
	translate([boxl-tunnelendx/2+5.95,0,0]) rotate([0,0,45]) translate([-d/2,-d/2,0]) cube([d,d,boxh]);

	translate([wall+ytolerance*2+0.5,0]) rotate([0,0,45]) translate([-d2/2,-d2/2,wall]) cube([d2,d2,boxh]);
	translate([boxl-tunnelendx/2+9,0,0]) rotate([0,0,45]) translate([-d2/2,-d2/2,wall]) cube([d2,d2,boxh]);
      }
    }

    //#    translate([73,73,0]) printareacube("ankermake");
  }
 }

if (print==5 || print==10) {
  translate([0.5,-storageboxy+doorl,0]) rotate([90,0,90]) translate([0,-storageboxy,0]) door();
 }

if (print==6) {
  intersection() {
    storagecover();
    mousestorage();
    //cover();
    //mechanics(angle,lockangle);
  }
 }

if (print==7) {
  rotate([0,0,90]) {
    intersection() {
      union() {
	if (debug) {
	  baitbox();
	  difference() {
	    baitboxslot();
	    baitboxslotcut();
	  }
	} else {
	  translate([0,0,baitboxh]) rotate([180,0,0]) baitbox();
	  //translate([0,baitboxflangew/2+baitboxflangew/2+ytolerance+baitboxwall+0.5,baitboxflangetopl/2+baitboxwall*2]) rotate([0,180,0]) {
	  translate([0,baitboxflangew/2+baitboxflangew/2+ytolerance+baitboxwall+0.5,baitboxh]) rotate([0,180,0]) {
	    difference() {
	      union() {
		baitboxslot();
		if (0) for (y=[-baitboxw/2,baitboxw/2-2]) {
		    translate([0,y,0]) cube([baitboxflangetopl/2+baitboxwall*2,2,baitboxh-cornerd]);
		  }
	      }
	      baitboxslotcut();
	    }
	  }
	}
      }
    
      if (debug) translate([0,0,-100]) cube([100,100,200]);
      //if (debug) translate([-50,0,-50]) cube([100,100,150]);
    }
  }
 }

if (print==4 || print==8) {
  translate([113,0,baitboxh]) rotate([180,0,45]) baitbox();
 }

if (print==9 || print==10) {
  rotate([0,-90,0]) flap(0,1);
 }

if (print==11) {
  windowtemplates();
 }

if (print==12) {
  translate([0,0,-boxx]) rotate([0,-90,0]) lockinsert();
 }

if (print==13) {
  x=20;
  translate([-x-0.8,0,-boxx]) rotate([0,-90,0]) lockinsert();

  intersection() {
    translate([-x,-55,0]) cube([x,50,50]);

    translate([0,0,-xxx-0.01]) rotate([0,-90,0]) mousetrap(0,lockangleprint);
  }
 }


