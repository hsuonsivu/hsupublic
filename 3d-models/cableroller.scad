// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
use <threadlib/threadlib.scad>

// Roller handle for rolling cables to 3d filament rolls
// 0 Full model, 1 body only, 2 crank, 3 knob and bolt, 4 knob, 5 threadtest, 6 clas ohlson adapter,
// 7 frontierfila adapter, 8 no name 72 mm centerhole adapter, 9 handle bar, 10 roller handle,
// 11 roller handle, handle bar and two handlebar bolts, 12 two handlebar bolts, 13 sunly refill adapter
// 14 esun cardboard adapter
print=15;
debug=print==0?1:0;

nametext="Cable Roller";
versiontext="V1.1";
fulltext=str(nametext," ",versiontext);
textsize=7;
textdepth=0.7;
textfont="Liberation Sans:style=Bold";
versiontextlen=textlen(versiontext,textsize);

dtolerance=0.6;
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;
maxbridge=10;

wall=3;

$fn=180;

cornerd=2;

clasohlsoninnerd=53;
clasohlsonouterd=58;
clasohlsonh=66-ztolerance*2;
clasohlsonouth=20;
clasohlsonoutcut=4;
clasohlsonoutcutn=4;
clasohlsonoutcuth=7; // Reduction
clasohlsonwall=3;
clasohlsoninserth=7.9-3.2;

frontierfilad=57;
frontierfilah=60;

noname72d=72;
noname72h=60;

sunlurefilld=54.6;
sunlurefillh=66.5;

esuncardboardd=53.5;
esuncardboardh=64.5;

maxrollh=max(clasohlsonh,frontierfilah,noname72h,sunlurefillh,esuncardboardh);
maxrolld=max(clasohlsoninnerd,frontierfilad,noname72d,sunlurefilld,esuncardboardd);

l=(print==5?20:ztolerance+maxrollh+ztolerance); // Axle length max
lflex=10; // Rolls come in different sizes
smalld=48;//50; // Up to 55mm?
larged=70; // Up to 75mm?
outd=(print==5?smalld+2:205);

adapterdtable=[53,57,71];

bodythickness=3;
crankthickness=3;
crankbasethickness=5;
crankd=30;
crankbasedistance=outd/2-crankd/2;//+crankbasethickness;
crankaxlenarrowd=22;
crankheight=bodythickness+l;
crankh=crankthickness;
crankhandlel=80;
frictionknobn=6;
frictionknobdepth=1;
frictionknobd=5;

maind=42; // M42
main_pitch=0; // Calculated by threads
main_tooth_angle=30;

div=1.5;//1.5;
drext=2.842/div;
drint=2.7505/div;
m20div=1.3;
m20drext=1.5830/m20div;
m20drint=1.5330/m20div+0.1;

MY_THREAD_TABLE=[
		 ["M42-ext", [4.5, 18.003+(2.842-drext), 36.536+(2.842-drext)*2, [[0, -1.959], [0, 1.959], [drext, 0.3182], [drext, -0.3182]]]],
		 ["M42-int", [4.5, -21.4825, 42.4825, [[0, 2.2019], [0, -2.2019], [drint, -0.6139], [drint, 0.6139]]]],

		 ["M20-ext", [2.5, 8.3120+(1.1583-m20drext)+0.1, 16.9380+(1.5830-m20drext)*2, [[0, -1.0929], [0, 1.0929], [m20drext+0.1, 0.1790], [m20drext+0.1, -0.1790]]]],
		 //["M20-ext", [2.5, 8.3120, 16.9380, [[0, -1.0929], [0, 1.0929], [m20drext+0.1, 0.1790], [m20drext+0.1, -0.1790]]]],
		 ["M20-int", [2.5, -10.2925, 20.2925, [[0, 1.2304], [0, -1.2304], [m20drint, -0.3453], [m20drint, 0.3453]]]]
		 ];

specsext=thread_specs("M42-ext",table=MY_THREAD_TABLE);
specsint=thread_specs("M42-int",table=MY_THREAD_TABLE);

//echo(specsext);
//echo(specsint);

holespecs=specsext;
holepitch=holespecs[0];
holeturns=(l+bodythickness)/holepitch-1-5;
holeflexturns=floor(lflex/holepitch);
holeflex=holeflexturns*holepitch;
holeDsupport=holespecs[2];
holeh=holeturns*(holepitch)+holepitch/2;
screwspecs=specsint;
screwpitch=screwspecs[0];
screwturns=(l+bodythickness)/screwpitch-1;
screwflexturns=floor(lflex/screwpitch);
screwflex=screwflexturns*screwpitch;
screwDsupport=screwspecs[2];

boltbaseh=6;
boltfingerd=13;
boltfingersteps=12;
boltbased=larged+18;//20; // screwDsupport+boltfingerd;

axled=32;
axleh=bodythickness+l+crankthickness+ztolerance+boltbaseh;

lightengap=5;
lightenholelarged=30;
lightenholesmalld=22;
lholes=12;

lockingpins=18;
lockingpind=6;
lockingd=smalld+10;//screwDsupport+dtolerance+10;

cabled=7;
cableholderd=9;
cableholderl=10;
cablecutl=20;

knobshaftnarrowheight=1.5;
knobshaftnarrowing=0.6;
knobshaftnarrowh=2;
knobwall=2;
knobtolerance=0.3;
knobdtolerance=0.6;
knobspringin=1;
knobspringa=10;
knobspringcut=1;
knobspringh=6.5;

//maxrollh=max(clasohlsonh,frontierfilah,noname72h);

handled=27;
handlel=100;
carryhandleendd=32;
carryhandled=27;
carryhandlel=handlel;
handlebased=50;
handlerotate=-20;
handledistance=125+carryhandleendd/2;
handlesupportthickness=4;
handlelockh=3;
handlelockd=axled-dtolerance+3;
handlelocknarrowingh=(handlelockd-axled)/2;
handlecut=1.2;
handlecutn=18;
handlecuth=20; // From top (handleaxleh)
handlesupportringd=carryhandleendd+6;
handlesupportd=carryhandled+6;
handlesupportringl=8;
handlesupportringdepth=2;
handleindistance=outd/2+handlesupportringd/2;
handlesupportboltholed=20+dtolerance;
handleboltturns=5;
carryhandleendl=8;
carryboltholespecs=thread_specs("M20-int",table=MY_THREAD_TABLE);
carryboltholepitch=carryboltholespecs[0];
carryboltholed=carryboltholespecs[2];
carryboltholel=(handleboltturns+1)*carryboltholespecs[0];
carryboltspecs=thread_specs("M20-ext",table=MY_THREAD_TABLE);
carryboltpitch=carryboltspecs[0];
carryboltd=carryboltspecs[2];
carryboltl=(handleboltturns+1)*carryboltpitch;
carryboltbasel=7;
//echo(carryboltholel,carryboltl);

handleaxleh=handlesupportthickness+ztolerance+bodythickness+maxrollh+ztolerance+crankthickness+ztolerance+boltbaseh+ztolerance;
handleaxleheight=-handlesupportthickness-ztolerance;
handlecutheight=handleaxleh-handlecuth;

handleboltthreadh=ztolerance+handlesupportringl-handlesupportringdepth+carryboltbasel;

module handlebarbolt() {
  difference() {
    union() {
      translate([0,0,0]) roundedcylinder(handlesupportringd,carryboltbasel,cornerd,1,6);
      translate([0,0,carryboltbasel-cornerd]) roundedcylinder(carryboltholed,handlesupportringl-handlesupportringdepth+cornerd,1,90);
      translate([0,0,handlesupportringl-handlesupportringdepth+carryboltbasel-0.01]) cylinder(d=carryboltd,h=ztolerance+0.02);
      translate([0,0,handleboltthreadh+carryboltpitch/2]) bolt("M20",turns=handleboltturns,table=MY_THREAD_TABLE);
    }

    translate([0,0,-0.01]) linear_extrude(textdepth) rotate([180,0,0]) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module handlebar(cutout) {
  difference() {
    union() {
      for (m=[0,1]) mirror([0,0,m]) hull() {
	  translate([0,0,-handlel/2-(cutout?ztolerance:0)]) roundedcylinder(carryhandleendd-handlesupportringdepth*2+(cutout?dtolerance:0),carryhandleendl+(cutout?ztolerance*2:0),cornerd,3,90);
	  translate([0,0,-handlel/2+handlesupportringdepth-(cutout?ztolerance:0)]) roundedcylinder(carryhandleendd+(cutout?dtolerance:0),-handlesupportringdepth+carryhandleendl+(cutout?ztolerance*2:0)-handlesupportringdepth,cornerd,3,90);
	}
      translate([0,0,-handlel/2+carryhandleendl-cornerd-0.1]) cylinder(d=carryhandled,h=handlel-carryhandleendl*2+cornerd*2+0.2);
    }
    
    if (!cutout) {
      translate([0,0,-carryhandlel/2+carryboltholepitch/2-0.01]) tap("M20",turns=handleboltturns,table=MY_THREAD_TABLE);
      translate([0,0,carryhandlel/2-carryboltholepitch/2+0.01]) rotate([180,0,0]) tap("M20",turns=handleboltturns,table=MY_THREAD_TABLE);
    }

    for (m=[0,1]) mirror([0,0,m]) {
	hull() {
	  translate([0,0,-carryhandlel/2-0.01+carryboltholel-0.01]) cylinder(d=carryboltholed,h=0.01,$fn=90);
	  translate([0,0,-carryhandlel/2-0.01+carryboltholel]) cylinder(d1=carryboltholed,d2=maxbridge,h=carryboltholed-maxbridge,$fn=90);
	}
      }

    labeldepth=carryhandled/2-cos(atan((textsize/2)/(carryhandled/2)))*(carryhandled/2);
    labellen=textlen(versiontext,textsize)+1;
    hull() {
      translate([-textsize/2,-carryhandled/2-textdepth-0.01,-labellen/2-labeldepth*2]) cube([textsize,labeldepth+0.01,labeldepth*2+labellen+labeldepth*2]);
      translate([-textsize/2,-carryhandled/2-0.01,-labellen/2]) cube([textsize,labeldepth+0.01,labellen]);
    }
    translate([0,-carryhandled/2+textdepth+labeldepth-0.01]) rotate([90,-90,0]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");

    rotate([0,0,180]) hull() {
      l=textlen(nametext)-20;
      translate([-textsize/2,-carryhandled/2-textdepth-0.01,-l/2-labeldepth*2]) cube([textsize,labeldepth+0.01,labeldepth*2+l+labeldepth*2]);
      translate([-textsize/2,-carryhandled/2-0.01,-l/2]) cube([textsize,labeldepth+0.01,l]);
    }
    rotate([0,0,180]) translate([0,-carryhandled/2+textdepth+labeldepth-0.01]) rotate([90,-90,0]) linear_extrude(textdepth) text("Cable Roller",size=textsize,font=textfont,valign="center",halign="center");
  }
}

module rollerhandle() {
  difference() {
    union() {
      translate([0,0,handleaxleheight]) cylinder(d=axled-dtolerance,h=handleaxleh);
      hull() {
	translate([0,0,handleaxleheight+handleaxleh-0.01]) cylinder(d=axled-dtolerance,h=handlelockh);
	translate([0,0,handleaxleheight+handleaxleh+handlelocknarrowingh]) cylinder(d=handlelockd,h=0.3);
      }

      rotate([0,0,0]) {
	for (m=[0,1]) mirror([0,m,0]) {
	    difference() {
	      hull() {
		translate([handledistance,-handlel/2-handlesupportringl+handlesupportringdepth,handleaxleh/2]) rotate([-90,0,0]) roundedcylinder(handlesupportringd,handlesupportringl,cornerd,0,90);
		translate([handleindistance,-handlel/2-handlesupportringl+handlesupportringdepth,handleaxleheight+handlesupportd/2]) rotate([-90,0,0]) roundedcylinder(handlesupportd,handlesupportringl,cornerd,0,90);
	      }

	      hull() {
		translate([handledistance,-handlel/2-handlesupportringl+handlesupportringdepth-0.1,handleaxleh/2]) rotate([-90,0,0]) cylinder(d=handlesupportboltholed,h=handlesupportringl+0.2,$fn=90);
		bridge=8;
		translate([handledistance-bridge/2,-handlel/2-handlesupportringl+handlesupportringdepth-0.1,handleaxleh/2+handlesupportboltholed/2]) rotate([-90,0,0]) cube([bridge,handlesupportringl+0.2,handlesupportboltholed/2]);
	      }
	    }

	    hull() {
	      translate([handleindistance,-handlel/2-handlesupportringl+handlesupportringdepth,handleaxleheight+handlesupportd/2]) rotate([-90,0,0]) roundedcylinder(handlesupportd,handlesupportringl,cornerd,0,90);
	      translate([handleindistance-handlesupportd/3+2,-handlel/2-handlesupportringl+handlesupportthickness+8,handleaxleheight]) rotate([-0,0,0]) roundedcylinder(handlesupportd,handlesupportthickness,cornerd,0,90);
	    }
	  }
	
	hull() {
	  for (m=[0,1]) mirror([0,m,0]) {
	      translate([handleindistance-handlesupportd/3+2,-handlel/2-handlesupportringl+handlesupportthickness+8,handleaxleheight]) rotate([-0,0,0]) roundedcylinder(handlesupportd,handlesupportthickness,cornerd,0,90);
	    }
	  translate([0,0,handleaxleheight]) roundedcylinder(handlebased,handlesupportthickness,cornerd,0,90);
	}
      }
    }

    translate([0,0,handleaxleheight-0.01]) cylinder(d=axled-dtolerance-wall*2,h=handleaxleh+handlelockh+0.02);
    
    for (a=[0:360/handlecutn:359]) {
      rotate([0,0,a]) {
	translate([(axled-dtolerance)/2-wall-1,-handlecut/2,handlecutheight-0.01]) cube([wall+handlelocknarrowingh+2,handlecut,handlecuth+0.02]);
      }
    }

    hull() {
      translate([handledistance-carryhandleendd*1.5,0,handleaxleh/2+8]) rotate([-90,0,0]) handlebar(1);//roundedcylinder(handled,handlel,cornerd,1,90);
      translate([handledistance,0,handleaxleh/2]) rotate([-90,0,0]) handlebar(1);//roundedcylinder(handled,handlel,cornerd,1,90);
    }

    translate([outd/2+2+textsize,0,handleaxleheight+textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) rotate([0,0,-90]) text(fulltext,size=textsize,font=textfont,valign="center",halign="center");
    translate([outd/2+2+textsize,0,handleaxleheight+handlesupportthickness-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) rotate([0,0,-90]) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module lightenholes(nohandle) {
    for (i=[(nohandle==1?2:0):1:lholes-1-(nohandle==1?1:0)]) {
    a=i*360/lholes;
    rotate([0,0,a])
    hull() {
      translate([boltbased/2+lightengap+lightenholesmalld/2,0,-0.1]) cylinder(d=lightenholesmalld,h=bodythickness+0.2);
      translate([outd/2-lightengap-lightenholelarged/2,0,-0.1]) cylinder(d=lightenholelarged,h=bodythickness+0.2);
    }
  }
}

module lockingpins() {
  for (i=[0:1:lockingpins-1]) {
    a=i*360/lockingpins;
    rotate([0,0,a])
    hull() {
      translate([lockingd/2,0,-0.1]) cylinder(d=lockingpind+dtolerance,h=crankh+0.2);
      translate([0,0,-0.1]) cylinder(d=1,h=crankh+0.2);
    }
    //translate([0,0,-0.1]) cylinder(d=lockingd+dtolerance,h=crankh+0.2);
  }
}

module adapterversiontext(d,h,sunklabel,n,text=versiontext) {
  a=360/(is_undef(n)?90:n);
  labeldepth=(sunklabel?d/2-min(cos(atan((textsize/2)/(d/2))),cos(a/2))*(d/2):0);
  labellen=textlen(text,textsize)+1;

  if (labeldepth) hull() {
      translate([-textsize/2,d/2-0.01,h-labellen/2-labeldepth*2]) cube([textsize,labeldepth+0.01,labeldepth*2+labellen+labeldepth*2]);
      translate([-textsize/2,d/2-labeldepth-0.01,h-labellen/2]) cube([textsize,labeldepth+0.01,labellen]);
    }
  
  translate([0,d/2-labeldepth-textdepth+0.01,h]) rotate([-90,90,0]) linear_extrude(textdepth) text(text,size=textsize,font=textfont,valign="center",halign="center");
}

module adapterlockingpins(h) {
  for (i=[0:1:lockingpins-1]) {
    a=i*360/lockingpins;
    rotate([0,0,a]) {
      difference() {
	hull() {
	  translate([lockingd/2,0,bodythickness+ztolerance+h]) roundedcylinder(lockingpind,crankh,cornerd,2,90);
	  translate([lockingd/2,0,bodythickness+ztolerance+h-0.01]) cylinder(d=lockingpind,h=crankh-cornerd/2+0.01);
	  translate([0,0,bodythickness+ztolerance+h]) cylinder(d=1,h=crankh);
	}

	translate([0,0,bodythickness+ztolerance+h-0.02]) cylinder(d=smalld+dtolerance,h=crankh+0.03,$fn=90);
      }
    }
  }
}

module clasohlsonadapter() {
  difference() {
    union() {
      translate([0,0,bodythickness+ztolerance]) roundedcylinder(clasohlsoninnerd,clasohlsonh,cornerd,2,lockingpins);
      translate([0,0,bodythickness+ztolerance+cornerd]) cylinder(d=clasohlsoninnerd,h=clasohlsonh-cornerd,$fn=lockingpins);
      translate([0,0,bodythickness+ztolerance+clasohlsonh-clasohlsoninserth]) cylinder(d=clasohlsonouterd+clasohlsonwall,h=clasohlsoninserth,$fn=lockingpins);
    }
    translate([0,0,bodythickness]) cylinder(d=smalld+dtolerance,h=clasohlsonh+ztolerance*2,$fn=90);

    adapterversiontext(clasohlsoninnerd,clasohlsonh/2,1,lockingpins,text="ClasOhlson");
    rotate([0,0,180]) adapterversiontext(clasohlsoninnerd,clasohlsonh/2-2,1,lockingpins,text=str(versiontext," ",clasohlsoninnerd,"mm"));
  }

  outheight=bodythickness+ztolerance+clasohlsonh-clasohlsonouth;
  difference() {
    union() {
      translate([0,0,outheight]) roundedcylinder(clasohlsonouterd+clasohlsonwall*2,clasohlsonouth,cornerd,2,lockingpins);
      translate([0,0,outheight+cornerd/2]) cylinder(d=clasohlsonouterd+clasohlsonwall*2,h=clasohlsonouth-cornerd/2,$fn=lockingpins);
    }
    translate([0,0,outheight-0.1]) cylinder(d=clasohlsonouterd,h=clasohlsonouth+0.2,$fn=90);

    for (a=[0:360/4:359]) {
      rotate([0,0,a]) {
	translate([clasohlsonouterd/2-0.1,-clasohlsonoutcut/2,outheight-0.1]) cube([clasohlsonwall+1,clasohlsonoutcut,clasohlsonouth-clasohlsonoutcuth]);
      }
    }
  }

  adapterlockingpins(clasohlsonh);
}

module frontierfilaadapterold() {
  difference() {
    union() {
      translate([0,0,bodythickness+ztolerance]) roundedcylinder(frontierfilad,frontierfilah,cornerd,2,lockingpins);
      translate([0,0,bodythickness+ztolerance+cornerd]) cylinder(d=frontierfilad,h=frontierfilah-cornerd+0.01,$fn=lockingpins);
    }
    translate([0,0,bodythickness]) cylinder(d=smalld+dtolerance,h=frontierfilah+ztolerance*2,$fn=90);

    adapterversiontext(frontierfilad,frontierfilah/2,1,lockingpins);
    rotate([0,0,180]) adapterversiontext(frontierfilad,frontierfilah/2,1,lockingpins,text="Frontierfila ");
  }

  adapterlockingpins(frontierfilah);
  
  if (0) for (i=[0:1:lockingpins-1]) {
    a=i*360/lockingpins;
    rotate([0,0,a]) {
      difference() {
	hull() {
	  translate([lockingd/2,0,bodythickness+ztolerance+frontierfilah]) roundedcylinder(lockingpind,crankh,cornerd,2,90);
	  translate([lockingd/2,0,bodythickness+ztolerance+frontierfilah-0.01]) cylinder(d=lockingpind,h=crankh-cornerd/2+0.01);
	  translate([0,0,bodythickness+ztolerance+frontierfilah]) cylinder(d=1,h=crankh);
	}

	translate([0,0,bodythickness+ztolerance+frontierfilah-0.02]) cylinder(d=smalld+dtolerance,h=crankh+0.03,$fn=90);
      }
    }
  }
}

module noname72adapterold() {
  dd=(noname72d-lockingd+lockingpind/2)/2;
  dh=dd/2;

  difference() {
    union() {
      translate([0,0,bodythickness+ztolerance]) roundedcylinder(noname72d,noname72h,cornerd,1,lockingpins);

      adapterlockingpins(noname72h);
      if (0) for (i=[0:1:lockingpins-1]) {
	a=i*360/lockingpins;
	rotate([0,0,a]) {
	  difference() {
	    hull() {
	      translate([lockingd/2,0,bodythickness+ztolerance+noname72h-ztolerance-0.01]) roundedcylinder(lockingpind,crankh+ztolerance+0.01,cornerd,2,90);
	      translate([lockingd/2,0,bodythickness+ztolerance+noname72h-ztolerance-0.01]) cylinder(d=lockingpind,h=crankh+ztolerance-cornerd/2+0.01);
	      translate([0,0,bodythickness+ztolerance+noname72h-ztolerance-0.01]) cylinder(d=1,h=crankh+ztolerance+0.01);
	    }
	  }
	}
      }
    }

    adapterversiontext(noname72d,noname72h/2+bodythickness+ztolerance,1,lockingpins,text=str(versiontext," 72mm"));
    rotate([0,0,180]) adapterversiontext(noname72d,noname72h/2+bodythickness+ztolerance,1,lockingpins,text="No name");
    
    translate([0,0,bodythickness]) cylinder(d=smalld+dtolerance,h=ztolerance+noname72h+ztolerance+crankh+0.03,$fn=90);
  }
}

module genericadapter(d,h,name) {
  dd=(d-lockingd+lockingpind/2)/2;
  dh=dd/2;

  difference() {
    union() {
      translate([0,0,bodythickness+ztolerance]) roundedcylinder(d,h,cornerd,2,lockingpins);
      translate([0,0,bodythickness+ztolerance+cornerd]) cylinder(d=d,h=h-cornerd,$fn=lockingpins);

      adapterlockingpins(h);
      if (0) for (i=[0:1:lockingpins-1]) {
	a=i*360/lockingpins;
	rotate([0,0,a]) {
	  difference() {
	    hull() {
	      translate([lockingd/2,0,bodythickness+ztolerance+h-ztolerance-0.01]) roundedcylinder(lockingpind,crankh+ztolerance+0.01,cornerd,2,90);
	      translate([lockingd/2,0,bodythickness+ztolerance+h-ztolerance-0.01]) cylinder(d=lockingpind,h=crankh+ztolerance-cornerd/2+0.01);
	      translate([0,0,bodythickness+ztolerance+h-ztolerance-0.01]) cylinder(d=1,h=crankh+ztolerance+0.01);
	    }
	  }
	}
      }
    }

    adapterversiontext(d,h/2+bodythickness+ztolerance,1,lockingpins,text=str(versiontext," ",d,"mm"));
    rotate([0,0,180]) adapterversiontext(d,h/2+bodythickness+ztolerance,1,lockingpins,text=name);
    
    translate([0,0,bodythickness]) cylinder(d=smalld+dtolerance,h=ztolerance+h+ztolerance+crankh+0.03,$fn=90);
  }
}

module sunlurefilladapterold() {
  dd=(sunlurefilld-lockingd+lockingpind/2)/2;
  dh=dd/2;

  difference() {
    union() {
      translate([0,0,bodythickness+ztolerance]) roundedcylinder(sunlurefilld,sunlurefillh,cornerd,2,lockingpins);
      translate([0,0,bodythickness+ztolerance+cornerd]) cylinder(d=sunlurefilld,h=sunlurefillh-cornerd,$fn=lockingpins);

      adapterlockingpins(sunlurefillh);
      if (0) for (i=[0:1:lockingpins-1]) {
	a=i*360/lockingpins;
	rotate([0,0,a]) {
	  difference() {
	    hull() {
	      translate([lockingd/2,0,bodythickness+ztolerance+sunlurefillh-ztolerance-0.01]) roundedcylinder(lockingpind,crankh+ztolerance+0.01,cornerd,2,90);
	      translate([lockingd/2,0,bodythickness+ztolerance+sunlurefillh-ztolerance-0.01]) cylinder(d=lockingpind,h=crankh+ztolerance-cornerd/2+0.01);
	      translate([0,0,bodythickness+ztolerance+sunlurefillh-ztolerance-0.01]) cylinder(d=1,h=crankh+ztolerance+0.01);
	    }
	  }
	}
      }
    }

    adapterversiontext(sunlurefilld,sunlurefillh/2+bodythickness+ztolerance,1,lockingpins);
    rotate([0,0,180]) adapterversiontext(sunlurefilld,sunlurefillh/2+bodythickness+ztolerance,1,lockingpins,text="Sunlu Refill");
    
    translate([0,0,bodythickness]) cylinder(d=smalld+dtolerance,h=ztolerance+sunlurefillh+ztolerance+crankh+0.03,$fn=90);
  }
}

module esuncardboardadapterold() {
  dd=(esuncardboardd-lockingd+lockingpind/2)/2;
  dh=dd/2;

  difference() {
    union() {
      translate([0,0,bodythickness+ztolerance]) roundedcylinder(esuncardboardd,esuncardboardh,cornerd,2,lockingpins);
      translate([0,0,bodythickness+ztolerance+cornerd]) cylinder(d=esuncardboardd,h=esuncardboardh-cornerd,$fn=lockingpins);

      adapterlockingpins(esuncardboardh);
      if (0) for (i=[0:1:lockingpins-1]) {
	a=i*360/lockingpins;
	rotate([0,0,a]) {
	  difference() {
	    hull() {
	      translate([lockingd/2,0,bodythickness+ztolerance+esuncardboardh-ztolerance-0.01]) roundedcylinder(lockingpind,crankh+ztolerance+0.01,cornerd,2,90);
	      translate([lockingd/2,0,bodythickness+ztolerance+esuncardboardh-ztolerance-0.01]) cylinder(d=lockingpind,h=crankh+ztolerance-cornerd/2+0.01);
	      translate([0,0,bodythickness+ztolerance+esuncardboardh-ztolerance-0.01]) cylinder(d=1,h=crankh+ztolerance+0.01);
	    }
	  }
	}
      }
    }

    adapterversiontext(esuncardboardd,esuncardboardh/2,1,lockingpins);
    
    translate([0,0,bodythickness]) cylinder(d=smalld+dtolerance,h=ztolerance+esuncardboardh+ztolerance+crankh+0.03,$fn=90);
  }
}

module rollerbody() {
  difference() {
    union() {
      roundedcylinder(outd,bodythickness,cornerd,1,180);
      roundedcylinder(smalld,bodythickness+l-holeflex,cornerd,1,180);
    }

    translate([0,0,bodythickness]) tap("M42",turns=holeturns-holeflexturns,table=MY_THREAD_TABLE);
    translate([0,0,-0.1]) cylinder(d=screwDsupport,h=bodythickness-holepitch/2+0.2);
    translate([0,0,bodythickness+holeh-holeflex-0.01]) cylinder(d=screwDsupport,h=l-holeh+holeflex-1);

    lightenholes(0);

    distance=maxrolld/2;
    translate([distance+2+textsize/2,0,bodythickness-textdepth+0.01]) linear_extrude(textdepth) rotate([0,0,90]) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
    translate([handlebased/2+2+textsize,0,-0.01]) linear_extrude(textdepth) rotate([180,0,90]) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module rollerbolt() {
  boltsupportbaseheight=bodythickness+l;
  boltbaseheight=boltsupportbaseheight+crankthickness+ztolerance;
  difference() {
    union() {
      translate([0,0,bodythickness+screwflex]) bolt("M42",turns=screwturns-screwflexturns,table=MY_THREAD_TABLE);
      translate([0,0,boltsupportbaseheight]) roundedcylinder(screwDsupport,crankthickness+cornerd,cornerd,0,90);
      translate([0,0,boltbaseheight]) roundedcylinder(boltbased,boltbaseh,cornerd,2,90);
      for (a=[0:360/boltfingersteps:359]) {
	rotate([0,0,a]) {
	  hull() {
	    translate([boltbased/2,0,boltbaseheight]) roundedcylinder(boltfingerd,boltbaseh,cornerd,2,90);
	    translate([0,0,boltbaseheight]) roundedcylinder(boltfingerd,boltbaseh,cornerd,2,90);
	  }
	}
      }
    }

    translate([0,0,-0.1]) cylinder(d=axled+dtolerance,h=axleh+0.2);
    
    translate([0,boltbased/2-1-textsize,boltbaseheight+boltbaseh-textdepth+0.01]) linear_extrude(textdepth) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module OLDknobaxle(knobd,knobh) {
  knobshaftd=knobd-5;

  knobshafth=knobh-knobwall-ztolerance;
  knobshaftnarrowd=knobshaftd-knobshaftnarrowing*2;
  hull() {
    translate([0,0,0]) roundedcylinder(knobshaftd,knobshaftnarrowheight-knobshaftnarrowing,cornerd,1,90);
    translate([0,0,0]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowheight);
  }

  translate([0,0,0+knobshaftnarrowheight-0.1]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowing+knobshaftnarrowh+0.2);
  hull() {
    translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=knobshaftd,h=knobshafth-knobshaftnarrowheight-knobshaftnarrowh*2);
    translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh]) cylinder(d=knobshaftnarrowd,h=knobshaftnarrowing);
  }
}

module OLDknob(knobd,knobh) {
  knobshaftd=knobd-5;
  knobaxleheight=0;
  knobshaftnarrowd=knobshaftd-knobshaftnarrowing*2;
  knobshafth=knobh-knobwall-ztolerance;
  
  difference() {
    union() {
      translate([0,0,0+knobshaftnarrowheight]) roundedcylinder(knobd,knobh-knobshaftnarrowheight,cornerd,2,90);
    }
    
    translate([0,0,0+knobshaftnarrowheight+knobspringin-0.1]) cylinder(d=knobshaftnarrowd+dtolerance,h=knobshaftnarrowh-knobspringin+0.2);
    translate([0,0,0+knobshaftnarrowheight-0.1]) cylinder(d1=knobshaftd+dtolerance*2,d2=knobshaftnarrowd+dtolerance,h=knobshaftnarrowh-knobspringin+0.2);
    hull() {
      translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh+knobshaftnarrowing]) cylinder(d=knobshaftd+dtolerance,h=knobshafth-knobshaftnarrowheight-knobshaftnarrowh*2+ztolerance);
      translate([0,0,0+knobshaftnarrowheight+knobshaftnarrowh]) cylinder(d=knobshaftnarrowd+dtolerance,h=knobshaftnarrowing);
    }
    translate([0,0,0+knobshaftnarrowheight-0.1]) ring(knobd-2,knobshaftnarrowing,knobspringh,0,90);
    for (a=[0:360/knobspringa:359]) {
      rotate([0,0,a]) translate([0,-knobspringcut/2,0+knobshaftnarrowheight-0.1]) cube([(knobd-2)/2,knobspringcut,knobspringh]);
    }

    //translate([0,0,-knobaxleheight+knobshaftnarrowheight+knobh-textdepth+0.01]) linear_extrude(textdepth) text(versiontext,size=textsize-1,font=textfont,valign="center",halign="center");

  }
}

module rollercrank() {
  crankcutx=crankbasedistance-handled/2-crankthickness*2;
  
  difference() {
    union() {
      translate([0,0,crankheight]) roundedcylinder(outd,crankh,cornerd,1,180);

      // Crank base strengtening
      hull() {
	translate([crankbasedistance,0,crankheight]) roundedcylinder(handled,crankbasethickness,cornerd,1,90);
	intersection() {
	  hull() {
	    translate([0,0,crankheight]) roundedcylinder(outd,crankh,cornerd,2,180);
	  }
	  translate([crankcutx,-outd/2,crankheight]) cube([handled+crankthickness+outd,outd,crankh]);
	}
      }

      // Cable holder
      intersection() {

	for (a=[-25,-35,-45]) {
	  rotate([0,0,a]) {
	    r=(a==-25?-4:(a==-35?180:10));
	    x=outd/2-cabled-(a==-35?cabled/3:0);
	    difference() {
	      hull() {
		translate([x,0,crankheight+crankbasethickness+cabled/4]) rotate([0,0,r]) rotate([90,0,0]) translate([0,0,-cableholderl/2]) roundedcylinder(cableholderd,cableholderl,cornerd,0,90);
		translate([x,0,crankheight]) roundedcylinder(cableholderl,crankthickness,cornerd,1,90);
	      }

	      translate([x,0,crankheight+crankbasethickness+cabled/4+cabled/5]) rotate([90,0,r]) translate([-cabled/4,0,-cableholderl/2-1]) cylinder(d=cabled,h=cableholderl+2);
	    }
	  }
	}
      }
 
      //translate([crankbasedistance,0,crankheight+crankbasethickness]) cylinder(d1=handled-cornerd*2,d2=handled-10,h=5);
      translate([crankbasedistance,0,crankheight+crankbasethickness-0.01]) knobaxle(handled,crankhandlel);
    }

    rotate([0,0,-15]) {
      translate([outd/2-cabled/4,cableholderl/2+1,crankheight+crankbasethickness/2]) rotate([50,-30,0]) translate([0,0,-cablecutl/2]) cylinder(d=cabled,h=cablecutl);
    }
	
    // Cut hole for bolt
    translate([0,0,bodythickness+l-0.1]) cylinder(d=screwDsupport+dtolerance,h=crankthickness+0.2,$fn=90);

    // Locking pins hole
    translate([0,0,bodythickness+l]) lockingpins();
    
    translate([0,0,crankheight]) lightenholes(1);

    translate([crankcutx-2-textsize/2,0,crankheight+crankh-textdepth+0.01]) linear_extrude(textdepth) rotate([0,0,-90]) text(fulltext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

module crankknob() {
  difference() {
    knob(handled,crankhandlel);
    translate([0,0,crankhandlel-textdepth+0.01]) linear_extrude(textdepth) rotate([0,0,-90]) text(versiontext,size=textsize,font=textfont,valign="center",halign="center");
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([-500,0,-500]) cube([1000,1000,1000]);
    //if (debug) translate([-500,-1000,-500]) cube([500+handledistance,1150,1000]);

    union() {
      rollerhandle();
      rollerbody();
      rollerbolt();
      rollercrank();
      translate([crankbasedistance,0,crankheight+crankbasethickness-0.01]) crankknob();
      clasohlsonadapter();
      //frontierfilaadapter();
      //noname72adapter();
      //sunlurefilladapter();
      //esuncardboardadapter();
      translate([handledistance,0,handleaxleh/2]) rotate([-90,0,0]) handlebar(0);
      translate([handledistance,carryhandlel/2+handleboltthreadh,handleaxleh/2]) rotate([-90,0,180]) handlebarbolt();
    }
  }
 }

if (print==1) {
  rollerbody();
 }

if (print==2) {
  translate([0,0,-crankheight]) rollercrank();
 }

if (print==3) {
  r=0; //outd/2/sqrt(2)+boltbased/2-boltfingerd/2+0.5;
  translate([r,r,bodythickness+l+crankthickness+boltbaseh+ztolerance]) rotate([180,0,0]) rollerbolt();
 }

if (print==3 || print==4) {
  difference() {
    translate([0,0,crankhandlel]) rotate([180,0,0]) crankknob();
  }
 }

if (0 && print==5) {
  intersection() {
    if (debug) translate([-500,-1000,-500]) cube([1000,1000,1000]);

    union() {
      //rollerbody();
      //translate([outd+boltfingerd/2+0.5,0,bodythickness+l+crankthickness+boltbaseh+ztolerance]) rotate([180,0,360/12/2]) rollerbolt();
    }
  }
 }

if (print==6 || print==15) {
  translate([0,0,bodythickness+ztolerance+clasohlsonh+crankh]) rotate([180,0,0]) clasohlsonadapter();
 }

if (print==7 || print==15) {
  translate([lockingd+0.5+lockingpind,0,0]) translate([0,0,bodythickness+ztolerance+frontierfilah+crankh]) rotate([180,0,0]) genericadapter(frontierfilad,frontierfilah,"Frontierfila");
 }

if (print==8 || print==15) {
  rotate([0,0,-61.5]) translate([lockingd+lockingpind+4.5,0,0]) translate([0,0,-bodythickness-ztolerance]) genericadapter(noname72d,noname72h,"Noname");
 }

if (print==9 || print==11) {
  translate([handledistance+5,carryhandlel/2-handlesupportringd/2,handlel/2]) handlebar(0);
 }

if (print==10 || print==11) {
  translate([0,0,handlesupportthickness+ztolerance]) rollerhandle();
 }

if (print==12 || print==11) {
  translate([handledistance+5,-carryhandleendd/2-0.5-handlesupportringd/2+6,0]) rotate([0,0,30]) handlebarbolt();
  translate([handledistance+handlesupportringd/2+2,0,0]) rotate([0,0,30]) handlebarbolt();
 }

if (print==13 || print==15) {
  rotate([0,0,60]) translate([lockingd+0.5+lockingpind,0,0]) translate([0,0,bodythickness+ztolerance+sunlurefillh+crankh]) rotate([180,0,0]) genericadapter(sunlurefilld,sunlurefillh,"Sunlu refill");
 }

if (print==14 || print==15) {
  rotate([0,0,120]) translate([lockingd+0.5+lockingpind,0,0]) translate([0,0,bodythickness+ztolerance+esuncardboardh+crankh]) rotate([180,0,0]) genericadapter(esuncardboardd,esuncardboardh,"esun recycle");
 }

