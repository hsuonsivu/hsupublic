// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// TODO: add lightening holes to reduce filament consumption.

include <hsu.scad>
include <hsubolt.scad>
include <casetools.scad>

print=0; //13;
debug=0;

lighteningholes=1;
cornerd=1.6;
wall=2;
abs=0;

maxbridge=10;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

fantype=7;

fansizetable=[[40,32,10],     //0
	      [50,40,10],     //1
	      [60,50,15],     //2
	      [70,60,15],     //3
	      [80,71.5,25],   //4
	      [92,82.5,25],   //5
	      [120,105,25.4],   //6
	      [60,50,11.5],	//7 measured from one of my fans
	      [70,60,25.5],     //8 measured from one of my fans
	      [140,124.5,28], //9
	      [200,154,30],   //10
	      [220,170,30]    //11
	      ];

fanl=fantype!=-1?fansizetable[fantype][0]:0;
fanw=fanl;
fand=min(fanl,fanw)-wall;
fanscrewl=(fantype!=-1)?fansizetable[fantype][1]:0;
fanscreww=fanscrewl;
fanh=fantype!=-1?fansizetable[fantype][2]:0;
fanzcornerd=fanw-fanscreww;

if (fantype!=-1) echo("Fan type ",fantype," size ",fanw," screws ",fanscrewl," thickness ",fanl);
fanscrewd=3.9;
fantowerh=6;
fanholderclipl=fanw/2;
fanholderclipd=wall+1.1;
fanholderl=xtolerance+fanh+xtolerance+fanholderclipd;
fanholderw=wall+ytolerance+fanw+ytolerance+wall;
fanholderh=wall+ztolerance+fanw+ztolerance+wall;

versiontext="V1.1";
textdepth=0.8;
textsize=8;
brandtext="Diskholder";
longtext=str(brandtext," ",versiontext);

// Bring case slightly forward from original measurements to allow
// floppy screwholes.
caseshift=5;

disk35=diskdimensions("3.5");
diskl=disk35[1];
diskw=disk35[2];
diskh=disk35[3];
diskspaceh=ztolerance+diskh+ztolerance;
diskspacew=ytolerance+diskw+ytolerance;

diskscrewxtable=disk35[4];
diskscrewztable=disk35[5];
diskscrewd=disk35[8];

disk25=diskdimensions("2.5");
disk25l=disk25[1];
disk25w=disk25[2];
disk25h=disk25[3];
disk25spacel=ztolerance+disk25l+ztolerance;
disk25spacew=ztolerance+disk25w+ztolerance;
disk25spaceh=ztolerance+disk25h+ztolerance;

floppy=diskdimensions("3.5FLOPPY");
floppyl=floppy[1];
floppyw=floppy[2];
floppyh=floppy[3];
floppyspaceh=ztolerance+floppyh+ztolerance;
floppyx=-25+caseshift;
floppyscrewxtable=floppy[4];
floppyscrewheight=floppy[5][0];
floppyscrewd=floppy[8];

baseheight=9;
baseh=wall;
bottomflange=7;
diskflange=9;

// top Screw distance
screww=265;

toph=150-wall-ztolerance; // 150+5 margin
basex=9;
basel=wall+xtolerance+diskl+xtolerance;//160;

screwholed=9.43;//8.25;
screwholeopening=7.95;
leftscrewdepth=11-screwholed/2;

rightscrewdepth=12.5-screwholed/2;

baserightx=50;
baserightl=basel-(baserightx-basex);
baserightw=screww-75;//190;

leftflangew=8.6+8;

baselefty=50; //leftflangey-wall-diskspacew-wall-diskspacew-wall;
baseleftx=basex;
baseleftl=110;
baseleftw=screww-baselefty+leftscrewdepth-leftflangew;//wall+diskspacew+wall+diskspacew;//209;
//leftw=250+wall;
leftflangey=screww+leftscrewdepth-leftflangew;//+baserighty;//baselefty+baseleftw;
leftscrewy=leftflangey+leftflangew-leftscrewdepth;

disks=7;
disks25=2;
disk25columns=2;

disksheight=28.15;
disks25height=disksheight+ztolerance+diskw+ztolerance+wall+ztolerance;
disk25zstep=ztolerance+disk25h+ztolerance+wall;

leftwallx=baseleftx;
leftwalll=baseleftl;
leftwally=leftflangey-wall;
disktoph=disks25height-ztolerance-wall+disk25zstep*2-baseheight;
leftwallh=disktoph+wall;//145.3+7.4-baseheight;

topx=basex-wall-xtolerance;
topl=wall+xtolerance+basel+xtolerance+wall;

leftflangex=topx;
leftflangel=topl;//baseleftl;
leftflangeheight=baseheight+140;

rightflangex=topx;
rightflangel=143.2-topx;
rightflangew=17.45;//6+6;
rightflangey=-rightscrewdepth;
rightflangeheight=123.5+baseheight;//128.5+7.5;

baserighty=rightflangey+rightflangew;

rightwallx=baserightx;
rightwally=baserighty;//rightscrewdepth;
rightwalll=baserightl;
rightwallh=toph+wall;//128.5+7.5-baseheight;

topw=leftwally-rightwally+wall;
topy=rightwally;
topheight=toph+baseheight;

leftscrewxtable=[49,49+49.4]; //90
rightscrewxtable=[basex+30,basex+120];

leftbottomxtable=[19,57];
rightbottomxtable=[21,122];

//leftbottomy=leftscrewy-73;
leftbottomy=leftscrewy-71;
rightbottomy=leftscrewy-204;

bottomsupportw=16;
supportflange=5;

rightbottomlefty=baserighty+baserightw;
leftbottomlefty=baselefty+baseleftw;
leftbottomrighty=baselefty;

diskwally=leftbottomrighty+wall+ytolerance+diskw+ytolerance;
diskleftwally=diskwally+wall+ytolerance+diskw+ytolerance;

openingbottom=28.15;

disksy=leftbottomrighty+wall;
disksx=basex+wall+xtolerance;
diskystep=ytolerance+diskh+ytolerance+wall;

disk25x=disksx+diskl-disk25l;
disk25y=baselefty+baseleftw/2-disk25w-ytolerance-wall/2;//baserighty+disk25w+ytolerance;
disk25cstep=ytolerance+disk25w+ytolerance+wall;

lockclipoverhang=1.4;
lockclipw=7;
lockclipl=9;
lockclipbodyh=4;
lockcliph=20;
lockclipoutl=lockclipl+wall*2+dtolerance*2+lockclipoverhang*2;
lockclipoutw=lockclipw+wall*2+dtolerance*2;
lockclipcut=lockclipoverhang*2+xtolerance*2;
lockclipoverhangh=6.5;
lockclipcuth=lockcliph-lockclipbodyh/2+lockclipoverhangh;
lockclipxoffset=wall*3;
lockclipyoffset=wall*3;
lockcliptotalh=lockcliph+lockclipbodyh*2+lockclipoverhangh;
lockclipheight=topheight+wall-lockcliph/2+ztolerance;

lockcliptable=[[basex+lockclipoutl/2,leftwally-lockclipoutw/2+wall,lockclipheight],
	       [basex+wall+basel-lockclipxoffset-lockclipoutl/2,leftwally-lockclipoutw/2+wall,lockclipheight],
	       [basex+lockclipoutl/2,leftbottomrighty+lockclipoutw/2,lockclipheight],
	       [basex+wall+basel-lockclipxoffset-lockclipoutl/2,leftbottomrighty+lockclipoutw/2,lockclipheight],
	       ];

// Old
tassuh=4.82;
tassul=15;
tassuw=12;
leftl=wall+xtolerance+disk25l;
lefth=100;//120?
maxh=150;
rightoverlap=28;
originalw=149;
disksw=wall+ytolerance+disk35[2]+ytolerance+wall;
disky=baserighty+disksw/2-diskw/2;
diskx=wall+xtolerance;

//disk25x=wall+xtolerance;
lefty=disk25y+disk25w+xtolerance+wall;

diskstopperw=wall+8;

floppyy=originalw/2+5.37+48+0.5-floppyw;
floppyheight=lefth+ztolerance;
floppytopheight=lefth-wall+floppyspaceh*2+wall;

bottomleftscrewd=5;//4.3;
bottomrightscrewd=5; // Slide in
bottomrightscrewbased=9;
bottomrightscrewopeningx=bottomrightscrewd/2+bottomrightscrewbased/2;
bottomscrewmoveh=8-wall;//+2;
bottomscrewbaseh=2; //3.5;
bottomscrewbased=9;
bottomscrewxflex=4;

//disksheight=wall+bottomscrewmoveh+bottomscrewbaseh+0.5;
//disks25height=wall+5+0.5;//disksheight;

diskhstep=ztolerance+diskh+ztolerance+wall;
//disk25hstep=ztolerance+disk25h+ztolerance+wall;

//disks=3;
//disks25=6;

disklockclips=1;

disklockl=30;
disklockw=3;
disklockh=diskh-2;
disk25lockh=disk25h-1;
disklockcut=0.50;

disksleftlockl=baserightl+xtolerance*2;

diskcliph=disk25h-1;
diskclipl=40;
diskcliplockw=9;
diskclipw=wall;
diskcliplockl=5;
diskcliplockh=diskcliph-4;
diskcliplockbarh=diskcliplockh+2;
diskcliplockx=10+2.5;
diskclipcoverl=wall+xtolerance+diskcliplockx+diskcliplockl+4;
diskclipcoverx=-wall-xtolerance;
diskcliphandlel=2;

diskcliplockcutx=diskclipcoverx+2;
diskcliplockcutl=diskcliplockx+diskcliplockl-diskcliplockcutx;

diskclipcut=0.6;

clipwall=1.6;

diskclipcoverh=wall+ztolerance+diskcliph+ztolerance+wall;
diskclipcoverfullw=wall+ytolerance+diskclipw+ytolerance+clipwall;

//diskclipx=diskx+diskl-diskclipl;
//disk25clipx=disk25x+disk25l-diskclipl;

diskclipheight=disksheight-ztolerance-wall-ztolerance;
diskclipx=disksx+diskl-diskclipl;
disk25clipx=disksx+diskl-diskclipl;
  
midsidey=baserighty+disksw-wall;

covercliph=disk25h-1;
coverclipl=22;
covercliplockw=9;
coverclipw=wall;
covercliplockl=5;
covercliplockh=covercliph-4;
covercliplockbarh=covercliplockh+2;
covercliplockx=10+3;
coverclipcoverl=wall+xtolerance+13+covercliplockl+4;
coverclipcoverx=-wall-xtolerance;
covercliphandlel=9;
covercliphandlew=4;
covercliphandleh=4;

covercliplockcutx=coverclipcoverx+2;
covercliplockcutl=covercliplockx+covercliplockl;//-covercliplockcutx;

coverclipcut=0.6;

coverclipcoverh=wall+ztolerance+covercliph+ztolerance+wall;
coverclipcoverfullw=wall+ytolerance+coverclipw+ytolerance+clipwall;

coverclipbridge=maxbridge+2;

fanframel=13;
fanframew=149; //148.29;
fanframeh=86;
fanframeflange=2;//1.5;
fanframeheight=0;
fanframelargecornerd=20;

fany=0;
fanx=-fanh+5;
fansupportw=wall+ytolerance+fanw+ytolerance+wall;
fansupportl=wall+1.5;
fansupporth=fansupportw;
fanframebasex=min(fanx-fansupportl,-(coverclipl-fanframel+fansupportl));
fanframeclipy=-fanframew/2+maxbridge+coverclipcoverh/2+fanframelargecornerd/2;

module clipbase(right) {
}

module clipbasecut() {
  for (c=lockcliptable) {
    x=c[0];
    y=c[1];
    z=c[2];
    translate([x,y,z]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,1);
    h=lockcliph/2+lockclipoverhangh+ztolerance;
    translate([x-lockclipoutl-wall,y-lockclipw/2,z-h]) cube([lockclipoutl*2+wall*2,lockclipw,ztolerance+lockclipoverhangh+ztolerance]);
  }
}

module diskclip() {
  difference() {
    union() {
      translate([0,0,-diskcliph/2]) roundedbox(diskclipl+xtolerance+wall,wall,diskcliph,cornerd,1);
      translate([diskclipl+xtolerance,-diskcliplockw+wall,-diskcliph/2]) roundedbox(wall,diskcliplockw,diskcliph,cornerd,1);
      hull() {
	translate([diskclipl,0,-diskcliph/2]) roundedbox(xtolerance+wall,wall,diskcliph,cornerd,1);
	translate([diskclipl+diskcliphandlel,0,-diskcliph/2]) roundedbox(xtolerance+wall,wall,diskcliph,cornerd,1);
      }
    }

    translate([diskcliplockx-xtolerance,-cornerd/2,-diskcliplockh/2-ztolerance]) roundedbox(diskcliplockl+xtolerance*2,diskclipw+cornerd,diskcliplockh+ztolerance*2,0);

    translate([(diskclipl+diskcliplockl+diskcliplockx+wall)/2,wall-textdepth+0.01,0]) rotate([-90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=textsize-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module diskclipcover(bottom=0) {
  hull() {
    translate([diskclipcoverx-xtolerance-diskclipcoverfullw+wall,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverfullw,wall,diskclipcoverh,cornerd);
    translate([diskclipcoverx-xtolerance,diskclipw+ytolerance,-diskclipcoverh/2]) roundedbox(wall,clipwall,diskclipcoverh,cornerd);
  }
  hull() {
    translate([diskcliplockcutx+diskcliplockcutl-wall*2,diskclipw+ytolerance,-diskcliplockbarh/2]) roundedbox(wall,clipwall,diskcliplockbarh,0);
    translate([diskcliplockcutx+diskcliplockcutl-wall*2+diskcliphandlel,diskclipw+ytolerance+diskcliphandlel,-diskcliplockbarh/2]) roundedbox(wall,clipwall/2,diskcliplockbarh,clipwall/2,0);
  }
  translate([diskclipcoverx-xtolerance,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverl+xtolerance,diskclipcoverfullw,wall,cornerd);
  if (bottom) hull() {
    translate([diskclipcoverx-xtolerance,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverl+xtolerance,diskclipcoverfullw,wall,cornerd);
    translate([diskclipcoverx-xtolerance,-wall-ytolerance,-diskclipcoverh/2-diskclipcoverfullw+wall]) roundedbox(diskclipcoverl-xtolerance,wall,wall,cornerd);
    translate([diskclipcoverx-xtolerance-diskclipcoverfullw+wall,-wall-ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverfullw,wall,wall,cornerd);
  }
  translate([diskclipcoverx-xtolerance,diskclipw+ytolerance,-diskclipcoverh/2]) roundedbox(diskclipcoverl+xtolerance,clipwall,diskclipcoverh,cornerd);
  translate([diskclipcoverx,-wall-ytolerance,+diskclipcoverh/2-wall]) roundedbox(diskclipcoverl,diskclipcoverfullw,wall,cornerd);
  hull() {
    translate([diskcliplockx,diskclipw+ytolerance,-diskcliplockh/2]) cube([diskcliplockl,clipwall,diskcliplockh]);
    translate([diskcliplockx,0,-diskcliplockh/2+diskclipw+ytolerance]) cube([1,diskclipw+ytolerance+clipwall,diskcliplockh-(diskclipw+ytolerance)*2]);
  }
}

module diskclipcovercut() {
  difference() {
    union() {
      translate([diskcliplockcutx,diskclipw+ytolerance-diskclipcut,-diskcliplockbarh/2-diskclipcut]) cube([diskcliplockcutl+diskclipcut,clipwall+diskclipcut+0.01,diskclipcut]);
      translate([diskcliplockcutx+diskcliplockcutl,diskclipw+ytolerance-0.01,-diskcliplockbarh/2-diskclipcut]) cube([diskclipcut*2,clipwall+0.02,diskcliplockbarh+diskclipcut*2]);
      translate([diskcliplockcutx,diskclipw+ytolerance-0.01,diskcliplockbarh/2]) cube([diskcliplockcutl+diskclipcut,clipwall+0.02,diskclipcut]);
    }
  }
}

module case2topattachment() {
  margin=10;
  barw=8;
  
  difference() {
    union() {
      difference() {
	union() {
	  // Right wall
	  translate([topx,rightwally,rightflangeheight]) roundedbox(topl,wall,toph+wall-(rightflangeheight-baseheight)+supportflange/2,cornerd,7);

	  // Left wall
	  translate([topx,topy+topw+ytolerance,leftflangeheight]) roundedbox(topl,wall,baseheight+toph-leftflangeheight+wall+supportflange/2,cornerd,7);
	  
	  // Screw flanges
	  translate([leftflangex,leftflangey+ytolerance,leftflangeheight]) roundedbox(leftflangel,leftflangew-ytolerance,wall,cornerd,7);
	  translate([rightflangex,rightflangey,rightflangeheight]) roundedbox(rightflangel,rightflangew+wall,wall,cornerd,7);
      
	  // Top plate
	  translate([topx,topy,topheight]) roundedbox(topl,topw+ytolerance+wall,wall,cornerd,7);
	  translate([topx,topy,topheight-supportflange/2]) roundedbox(wall,topw+ytolerance+wall,wall+supportflange,cornerd,7);
	  hull() {
	    translate([topx+topl-wall,topy,topheight]) roundedbox(wall,topw+ytolerance+wall,wall,cornerd,7);
	    translate([topx+topl-wall+supportflange/2,topy,topheight+supportflange/2]) roundedbox(wall,topw+ytolerance+wall,wall,cornerd,7);
	    translate([topx+topl-wall+supportflange/2,topy,topheight-supportflange/2]) roundedbox(wall,topw+ytolerance+wall,wall,cornerd,7);
	  }

	  // Support flanges
	  for (y=[baserighty,baselefty-ytolerance-wall,topy+topw+ytolerance]) {
	    translate([topx,y,topheight-supportflange/2]) roundedbox(topl+supportflange/2,wall,wall+supportflange,cornerd,7);
	  }
	}

	translate([topx,baserighty-wall,topheight]) rotate([90,0,90]) lighten(baselefty-baserighty+wall+margin/2,basel,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
	translate([topx,baselefty,topheight]) rotate([90,0,90]) lighten(diskwally-baselefty,topl,wall,margin-0.9,barw,maxbridge,"up",cornerd=cornerd); // -0.8 is for mystical bug
	translate([topx,diskwally-margin/2,topheight]) rotate([90,0,90]) lighten(leftbottomlefty-diskwally+margin/2,topl,wall,margin,barw,maxbridge,"up",cornerd=cornerd);

	// Right wall
	for (y=[rightwally+wall,baselefty+wall]) {
	  translate([topx,y,rightflangeheight]) rotate([90,-90,90]) lighten(toph-(rightflangeheight-baseheight)+wall,topl/2,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
	  translate([topx+topl/2,y,rightflangeheight]) rotate([90,-90,90]) lighten(toph-(rightflangeheight-baseheight)+wall,topl/2,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
	}
      }

      for (c=lockcliptable) {
	x=c[0];
	y=c[1];
	z=topheight;
	hull() {
	  w=wall*2+lockclipw+wall*2;
	  translate([x-lockclipl/2-wall*2+xtolerance,y-w/2,z]) roundedbox(wall*2+lockclipl+wall*2-xtolerance,w,wall,cornerd,7);
	  if (x>topl/2) {
	    translate([x-lockclipl/2-w-wall,y-lockclipw/2-wall*2,z]) roundedbox(wall,wall,wall,cornerd,7);
	  }
	}
      }
    }

    clipbasecut();
    
    // Top screw holes
    for (x=leftscrewxtable) {
      translate([x,leftflangey+leftflangew-leftscrewdepth,leftflangeheight-0.01]) rotate([0,0,-45]) {
	cylinder(d=screwholed,h=wall+0.02,$fn=90);
	translate([-screwholeopening/2,0,0]) cube([screwholeopening,leftscrewdepth*3,wall+0.02]);
      }
    }
    for (x=rightscrewxtable) {
      translate([x,rightflangey+rightscrewdepth,rightflangeheight-0.01]) rotate([0,0,45]) {
	cylinder(d=screwholed,h=wall+0.02,$fn=90);
	translate([-screwholeopening/2,-rightscrewdepth*3,0]) cube([screwholeopening,rightscrewdepth*3,wall+0.02]);
      }
    }

    translate([(rightscrewxtable[0]+rightscrewxtable[1])/2,0,rightflangeheight+wall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(longtext, size=textsize-1, valign="bottom",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module case2diskholder() {
  margin=10;
  barw=8;

  difference() {
    union() {
      // Bottom plate
      translate([baseleftx,baselefty,baseheight]) roundedbox(baseleftl,baseleftw,wall,cornerd,7);
      translate([baseleftx,leftbottomy-bottomsupportw/2-wall/2,baseheight]) roundedbox(basel,bottomsupportw,wall,cornerd,7);
      translate([baseleftx,rightbottomy-bottomsupportw/2-wall/2,baseheight]) roundedbox(basel,bottomsupportw,wall,cornerd,7);

      // Supports below disks
      for (y=[leftbottomy-wall/2,rightbottomy-wall/2]) {
	translate([baseleftx,y,baseheight]) roundedbox(basel,wall,disksheight-ztolerance-baseheight,cornerd,7);
      }

      //translate([baserightx,baserighty,baseheight]) roundedbox(baserightl,baserightw,wall,cornerd,7);
      translate([baserightx,baselefty,baseheight]) roundedbox(baserightl,baserightw-(baselefty-baserighty),wall,cornerd,7);
      translate([baseleftx,baselefty,baseheight]) roundedbox(wall,baseleftw,bottomflange,cornerd,7);
      
      // Disks plate
      translate([baseleftx,baselefty,disksheight-ztolerance-wall]) roundedbox(basel,baseleftw,wall,cornerd,7);

      // Disk back holders
      translate([baseleftx,baselefty,disksheight-ztolerance-wall-bottomflange]) roundedbox(wall,baseleftw,bottomflange+wall+bottomflange,cornerd,7);
      translate([baseleftx,baselefty,disksheight+ztolerance+diskw+ztolerance-bottomflange]) roundedbox(wall,baseleftw,bottomflange+wall+bottomflange,cornerd,7);

      for (i=[0:1:disks-1]) {
	translate([basex,disksy+i*diskystep+ytolerance+diskh+ytolerance,disksheight-ztolerance-wall]) roundedbox(wall+xtolerance+diskl+xtolerance,wall,diskflange,cornerd,7);
	translate([basex,disksy+i*diskystep+ytolerance+diskh+ytolerance,disksheight+ztolerance+diskw+ztolerance-diskflange+wall]) roundedbox(wall+xtolerance+diskl+xtolerance,wall,diskflange,cornerd,7);
	z=disksheight+i*diskhstep;
	translate([diskclipx,disksy+i*diskystep+diskh-diskcliph/2,diskclipheight]) rotate([90,0,0]) mirror([0,1,0]) diskclipcover();
      }
      
      // 2.5 disk plate
      translate([baseleftx,baselefty,disks25height-ztolerance-wall]) roundedbox(basel,baseleftw,wall,cornerd,7);

      // 2.5 disk holders
      for (c=[0:1:disk25columns-1]) {
	for (i=[0:1:disks25-1]) {
	  z=disks25height+i*disk25zstep;
	  for (y=[disk25y+c*disk25cstep-ytolerance-wall,disk25y+c*disk25cstep+ytolerance+disk25w+ytolerance]) {
	    translate([disk25x-xtolerance-wall,y,z-ztolerance-wall]) roundedbox(wall+disk25spacel,wall,wall+disk25spaceh+wall,cornerd,0);
	  }
	  translate([disk25x-xtolerance-wall,disk25y+c*disk25cstep+ytolerance+disk25w+ytolerance-diskflange,z+disk25zstep-ztolerance-wall]) roundedbox(wall+disk25spacel,diskflange+cornerd,wall,cornerd,0);
	  translate([disk25x-xtolerance-wall,disk25y+c*disk25cstep+ytolerance-wall,z+disk25zstep-ztolerance-wall]) roundedbox(wall+disk25spacel,diskflange+wall,wall,cornerd,0);
	  translate([disk25x-xtolerance-wall,disk25y+c*disk25cstep-ytolerance-wall,z-ztolerance-wall]) roundedbox(wall,diskflange+wall,wall+disk25spaceh+wall,cornerd,0);
	  translate([disk25x-xtolerance-wall,disk25y+c*disk25cstep+disk25spacew-diskflange,z-ztolerance-wall]) roundedbox(wall,diskflange+wall,wall+disk25spaceh+wall,cornerd,0);
	}
      }

      for (i=[0:1:disks25-1]) {
	z=disks25height+i*disk25zstep;
	translate([disk25clipx,disk25y-ytolerance-wall-ytolerance,z+ztolerance+disk25h/2]) rotate([0,0,0]) mirror([0,1,0]) diskclipcover();
	translate([disk25clipx,disk25y+disk25spacew+wall+disk25spacew+wall+ytolerance,z+ztolerance+disk25h/2]) rotate([180,0,0]) mirror([0,1,0]) diskclipcover();
      }

      for (c=[0:1:disk25columns-1]) {
	for (i=[0:1:disk25columns-1]) {
	  z=disks25height-ztolerance-wall;
	  h=disk25zstep*disks25+wall;
	  for (y=[disk25y-ytolerance-wall,disk25y+ytolerance+diskflange-wall,disk25y+disk25spacew-diskflange,disk25y+disk25spacew]) {
	    yy=y+c*disk25cstep;
	    hull() {
	      translate([disk25x-xtolerance-wall,yy,z]) roundedbox(wall,wall,h,cornerd,0);
	      translate([disk25x-xtolerance-wall-h,yy,z]) roundedbox(wall,wall,wall,cornerd,0);
	    }
	  }
	}
      }
      
      // Left wall
      translate([leftwallx,leftwally,baseheight]) roundedbox(leftwalll,wall,leftwallh,cornerd,7);
      translate([leftwallx,leftwally,disks25height-wall]) roundedbox(basel,wall,leftwallh-disks25height+baseheight+wall,cornerd,7);
      translate([leftwallx,leftwally-bottomflange,baseheight]) roundedbox(wall,bottomflange+wall,leftwallh,cornerd,7);

      // Mid wall
      translate([basex,leftbottomrighty,baseheight]) roundedbox(basel,wall,leftwallh,cornerd,7);
      translate([basex,leftbottomrighty,baseheight]) roundedbox(wall,bottomflange+wall,leftwallh,cornerd,7);

      for (c=lockcliptable) {
	x=c[0];
	y=c[1];
	z=disks25height-ztolerance-wall;
	h=baseheight+leftwallh-z;
	hull() {
	  w=lockclipoutw;
	  translate([x-lockclipoutl/2,y-w/2,z]) roundedbox(wall*2+lockclipl+wall*2,w,h,cornerd,7);
	  if (x>basel/2) {
	    translate([x-lockclipoutl/2-lockclipoutw,y<leftwally-20?leftbottomrighty:leftwally,z]) roundedbox(wall,wall,h,cornerd,7);
	  }
	}
      }
    }

    for (i=[0:1:disks-1]) {
      z=disksheight+i*diskhstep;
      translate([diskclipx,disksy+i*diskystep+diskh-diskcliph/2,diskclipheight]) rotate([90,0,0]) mirror([0,1,0]) diskclipcovercut();
    }
    
    for (i=[0:1:disks25-1]) {
      z=disks25height+i*disk25zstep;
      translate([disk25clipx,disk25y-ytolerance-wall-ytolerance,z+ztolerance+disk25h/2]) rotate([0,0,0]) mirror([0,1,0]) diskclipcovercut();
      translate([disk25clipx,disk25y+disk25spacew+wall+disk25spacew+wall+ytolerance,z+ztolerance+disk25h/2]) rotate([180,0,0]) mirror([0,1,0]) diskclipcovercut();
    }

    clipbasecut();
    
    // Lightening holes
    if (lighteningholes) {
      // Supports below disks
      for (y=[leftbottomy-wall/2,leftbottomrighty,rightbottomy-wall/2]) {
	for (x=[baseleftx,baseleftx+basel/2]) {
	  translate([x,y+wall,baseheight]) rotate([90,-90,90]) lighten(disksheight-ztolerance-baseheight,basel/2,wall,margin-3,barw,maxbridge,"up",cornerd=cornerd);
	}
      }

      // Wall tops
      for (y=[leftwally+wall,baselefty+wall]) {
	  translate([basex+lockclipoutl,y,rightflangeheight]) rotate([90,-90,90]) lighten(toph-(rightflangeheight-baseheight)+wall,wall+basel-lockclipxoffset-lockclipoutl/2-lockclipoutw-wall-lockclipoutl,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
	}
	
      translate([baseleftx,leftwally+wall,baseheight]) rotate([90,-90,90]) lighten(disksheight-ztolerance-baseheight,leftwalll,wall,margin-3,barw,maxbridge,"up",cornerd=cornerd);

      translate([basex,leftbottomy-wall/2,baseheight]) rotate([90,0,90]) lighten(leftbottomlefty-leftbottomy,baseleftl,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      translate([basex,rightbottomy-wall/2,baseheight]) rotate([90,0,90]) lighten(leftbottomy-rightbottomy,basel,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      //translate([basex,diskwally,baseheight]) rotate([90,0,90]) lighten(rightbottomlefty-diskwally,basel,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
      //translate([baserightx,baserighty,baseheight]) rotate([90,0,90]) lighten(baselefty-baserighty+wall,basel-(baserightx-basex),wall,margin,barw,maxbridge,"up",cornerd=cornerd);

      // Left wall
      translate([leftwallx,leftwally+wall,disksheight-margin/2]) rotate([90,-90,90]) lighten(diskspacew+margin,leftwalll,wall,margin,barw,maxbridge,"up",cornerd=cornerd);
            
      // Mid wall
      translate([basex,leftbottomrighty+wall,disksheight-margin/2]) rotate([90,-90,90]) lighten(diskspacew+margin,basel,wall,margin,barw,maxbridge,"up",cornerd=cornerd);

      translate([baseleftx+basel/2,disksy-wall-ytolerance+diskh/2+margin/2,disks25height-ztolerance-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(longtext, size=textsize-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
    }
  }
  
  if (0) {
    translate([textsize,floppyy-floppyw/2,lefth+floppyspaceh*2+wall-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(longtext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module fantappi(d,h) {
  hull() {
    cylinder(h=h+0.4,d=d,$fn=30);
    translate([0,0,h+0.1+(d-d/2)/2]) sphere(d=d/2,$fn=30);
  }
}

module fan() {
  difference() {
    translate([-fanl/2,-fanw/2,0]) roundedbox(fanl,fanw,fanh,cornerd,0);
    translate([0,0,-0.1]) rotate([0,00,0]) cylinder(d=fanw-2,h=fanh+0.2,$fn=90);
    for (x=[-fanscrewl/2,fanscrewl/2]) {
      for (y=[-fanscreww/2,fanscreww/2]) {
	translate([x,y,-0.1]) cylinder(d=fanscrewd,h=fanh+0.2,$fn=90);
      }
    }
  }
}

module fanframe() {
  difference() {
    union() {
      difference() {
	union() {
	  // Hole frame
	  translate([-cornerd/2,-fanframew/2,-fanframeh/2]) roundedbox(cornerd/2+fanframel,fanframew,fanframeh,cornerd,7);

	  // Flange
	  hull() {
	    translate([-wall,-fanframew/2-fanframeflange,-fanframeh/2-fanframeflange]) roundedbox(wall,fanframew+fanframeflange*2,fanframeh+fanframeflange*2,cornerd,7);
	    translate([-wall-wall,-fanframew/2,-fanframeh/2]) roundedbox(wall,fanframew,fanframeh,cornerd,7);
	  }

	  difference() {
	    hull() {
	      translate([-wall-wall,-fanframew/2,-fanframeh/2]) roundedbox(wall,fanframew,fanframeh,cornerd,7);
	      translate([fanframebasex+wall,-fanframew/2,-fanframeh/2]) rotate([0,-90,0]) roundedboxxyz(fanframeh,fanframew,wall,fanframelargecornerd,cornerd,2,90);
	    }
	    hull() {
	      translate([-wall-wall-cornerd/2,-fanframew/2+wall,-fanframeh/2+wall]) roundedbox(wall+cornerd/2,fanframew-wall*2,fanframeh-wall*2,cornerd,0);
	      translate([fanframebasex+wall*2,-fanframew/2+wall,-fanframeh/2+wall]) rotate([0,-90,0]) roundedboxxyz(fanframeh-wall*2,fanframew-wall*2,wall,fanframelargecornerd,cornerd,2,90);
	    }
	  }
      
	  // Fan base
	  translate([fanframebasex,-fansupportw/2,-fansupporth/2]) roundedbox(fansupportl,fansupportw,fansupporth,cornerd,7);
	  
	  // Front
	  translate([fanframebasex+wall,-fanframew/2,-fanframeh/2]) rotate([0,-90,0]) roundedboxxyz(fanframeh,fanframew,wall,fanframelargecornerd,cornerd,2,90);
	}

	// Opening cut
	translate([-wall*2-cornerd/2,-fanframew/2+wall,-fanframeh/2+wall]) roundedbox(wall*2+fanframel+cornerd,fanframew-wall*2,fanframeh-wall*2,cornerd,0);

	// Fan air hole
	translate([fanframebasex-0.01,0,0]) rotate([0,90,0]) cylinder(d=fand,h=fansupportl+0.02,$fn=90);
      }

      // Taps for fan
      for (y=[-fanscreww/2,fanscreww/2]) {
	for (z=[-fanscrewl/2,fanscrewl/2]) {
	  translate([fanframebasex,y,z]) rotate([0,90,0]) fantappi(fanscrewd,wall+ztolerance+4);
	}
      }

      // Fan side holders
      for (r=[0,90,180,270]) rotate([r,0,0]) {
	  translate([fanframebasex+fansupportl-cornerd/2,-fanholderclipl/2,-fanholderh/2]) roundedbox(cornerd/2+fanholderl,fanholderclipl,wall,cornerd,0);
	  hull() {
	    translate([fanframebasex+fansupportl+fanholderl-fanholderclipd,-fanholderclipl/2,-fanholderh/2]) roundedbox(fanholderclipd,fanholderclipl,wall,cornerd,0);
	    translate([fanframebasex+fansupportl+fanholderl-fanholderclipd/2,0,-fanholderh/2+fanholderclipd/2]) rotate([0,0,90]) tubeclip(fanholderclipl,fanholderclipd,0);
	  }
	}

      // side clips
      for (m=[0,1]) mirror([0,m,0]) {
	  clipcoverbottomx=fanframel-coverclipl-coverclipcoverx-xtolerance;
	  clipcoverbottomslopex=clipcoverbottomx-coverclipcoverfullw+wall;
	  b=fanframebasex-clipcoverbottomslopex-wall;
	  translate([fanframel-coverclipl,-fanframew/2+wall+ytolerance,0]) coverclipcover(bottom=b);
	  for (n=[0,1]) mirror([0,0,n]) {
	      translate([fanframel-coverclipl,fanframeclipy,-fanframeh/2+wall+ztolerance]) rotate([90,0,0]) coverclipcover(bottom=b);
	    }
	}
    }

    // side clip cuts
    for (m=[0,1]) mirror([0,m,0]) {
	translate([fanframel-coverclipl,-fanframew/2+wall+ytolerance,0]) coverclipcovercut();
	for (n=[0,1]) mirror([0,0,n]) {
	    translate([fanframel-coverclipl,fanframeclipy,-fanframeh/2+wall+ztolerance]) rotate([90,0,0]) coverclipcovercut();
	  }
      }

    l=-fanframebasex-wall-cornerd/2;
    translate([fanframebasex+l/2,0,fanframeh/2-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(longtext, size=min(textsize,l)-1, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }

  translate([fanframebasex,0,0]) rotate([0,90,0]) grill(fand+1,thickness=wall);
}

if (print==0) {
  difference() {
    union() {
      intersection() {
	if (debug) union() {
	  //translate([-1000,-1000,-1000]) cube([2000,2000,1000+disks25height+disk25spaceh/2+disk25spaceh+wall]);
	  translate([-1000,-1000,-1000]) cube([2000,1250,2000]);
	}

	union() {
      
	  case2diskholder();
	  case2topattachment();

	  for (c=lockcliptable) {
	    x=c[0];
	    y=c[1];
	    z=c[2];
	    translate([x,y,z]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,0);
	  }
	  
	  for (i=[0:1:disks-1]) {
	      z=disksheight+i*diskhstep;
	      %translate([disksx+diskl,disksy+i*diskystep,disksheight+diskw/2]) rotate([90,0,180]) diskform("3.5");
	      #translate([diskclipx,disksy+i*diskystep+diskh-diskcliph/2,diskclipheight]) rotate([90,0,0]) mirror([0,1,0]) diskclip();
	  }
	  
	  for (c=[0:1:disk25columns-1]) {
	    for (i=[0:1:disks25-1]) {
	      z=disks25height+i*disk25zstep;
	      %translate([disk25x+disk25l,disk25y+c*disk25cstep+disk25w/2,z]) rotate([0,0,180]) diskform("2.5");
	    }
	  }

	  for (i=[0:1:disks25-1]) {
	    z=disks25height+i*disk25zstep;
	    #translate([disk25clipx,disk25y-ytolerance-wall-ytolerance,z+ztolerance+disk25h/2]) rotate([0,0,0]) mirror([0,1,0]) diskclip();
	    #translate([disk25clipx,disk25y+disk25spacew+wall+disk25spacew+wall+ytolerance,z+ztolerance+disk25h/2]) rotate([180,0,0]) mirror([0,1,0]) diskclip();
	  }
	}
      }
    }

    //if (debug) translate([0,235/2+baserighty+20,235/2+baseheight]) rotate([0,90,0]) #printareacube("ankermake");
  }
 }

module prints() {
  union() {
    if (print==1 || print==13) {
      intersection() {
	if (debug) union() {
	    translate([-1000,-1000,-1000]) cube([900,2000,2000]);
	  }
	union() {

	  difference() {
	    translate([0,0,-basex]) rotate([0,-90,0]) {
	      case2diskholder();
	    }
	  }
      
	  //if (debug) #printareacube("ankermake");
	}
      }
    }

    if (print==2 || print==12) {
      translate([0,0,-topx]) rotate([0,-90,45]) case2topattachment();
    }

    if (print==3 || print==12) {
      for (i=[0:1:3]) translate([-210,0.5*sqrt(2),lockclipw/2]) rotate([0,0,45]) translate([0,(lockcliptotalh+0.5)*(i-1),0]) rotate([90,0,0]) lockclip(lockclipl,lockclipw,lockcliph,lockclipoverhang,cornerd,0);
    }

    if (print==4 || print==13) {
      translate([-basex-disksheight-diskclipl-diskcliphandlel-wall-0.5,disksy+bottomflange+wall+diskcliplockw,0]) rotate([0,0,0]) {
	for (i=[0:1:disks+disks25*2-1]) {
	  translate([0,i*(diskcliplockw+0.5),diskcliph/2]) diskclip();
	}
      }
    }

    if (print==5) {
      x=disk25x+disk25l-diskclipl-7;
      translate([30,-70,-x]) rotate([0,-90,0]) intersection() {
	icopdiskholder();
	translate([x,disk25x+disk25l-30,0]) cube([100,20,21]);
      }
      translate([0,0,diskcliph/2]) diskclip();
    }

    if (print==6) {
      rotate([0,-90,0]) intersection() {
	icopdiskholder();
	union() {
	  translate([bottomleftscrewxtable[0]-10,-200,-100]) cube([20,400,100+wall+1]);
	  translate([0,-bottomscreww/2-10,-100]) cube([bottomrightscrewxtable[1]+bottomscrewbased-2,20,100+disksheight]);
	  translate([0,-bottomscreww/2-22,-100]) cube([145,14,100+disksheight-wall-1]);
	  translate([0,-bottomscreww/2-22,-100]) cube([wall+1,200,100+disksheight+5]);
	  translate([0,-10,-100]) cube([100,20,100+disks25height-wall-0.01]);
	  translate([0,bottomscreww/2-13,-100]) cube([70,20,100+disksheight-wall-1]);
	  translate([0,bottomscreww/2-7,-100]) cube([bottomleftscrewxtable[1]+bottomscrewbased-2,20,100+disksheight-wall]);
	}
      }
    }

    if (print==7) {
      intersection() {
	icopdiskholder();
	if (1) union() {
	    translate([bottomleftscrewxtable[0]-10,-200,0]) cube([20+10,400,wall+1]);
	    translate([bottomleftscrewxtable[0]-10,-200,0]) cube([20+60,400,wall+1]);
	    translate([0,-bottomscreww/2-10,0]) cube([bottomrightscrewxtable[1]+bottomscrewbased-2,20,disksheight]);
	    translate([0,-bottomscreww/2-22,0]) cube([145,14,disksheight-wall-1]);
	    translate([0,-bottomscreww/2-22,0]) cube([wall+20,200,disksheight-5]);
	    translate([0,-10,0]) cube([100,20,disks25height-wall-0.01]);
	    translate([0,bottomscreww/2-13,0]) cube([70,20,disksheight-wall-1]);
	    translate([0,bottomscreww/2-7,0]) cube([bottomleftscrewxtable[1]+bottomscrewbased-2,20,disksheight-wall]);
	  }
      }
    }

    if (print==8 || print==10) {
      translate([0,0,-fanframebasex]) rotate([0,-90,0]) intersection() {
	if (debug) translate([-100,-100,0]) cube([200,200,200]);
	difference() {
	  union() {
	    fanframe();
	  }

	  if (debug) for (m=[0,1]) mirror([0,m,0]) {
		clipcoverbottomx=fanframel-coverclipl-coverclipcoverx-xtolerance;
		clipcoverbottomslopex=clipcoverbottomx-coverclipcoverfullw+wall;
		b=fanframebasex-clipcoverbottomslopex-wall;
		translate([fanframel-coverclipl,-fanframew/2+wall+ytolerance,0]) coverclip();
		for (n=[0,1]) mirror([0,0,n]) {
		    translate([fanframel-coverclipl,fanframeclipy,-fanframeh/2+wall+ztolerance]) rotate([90,0,0]) coverclip();
		  }
	      }
	}
      }
    }

    if (print==9 || print==10) {
      for (i=[0:1:5]) translate([fanframeh/2+0.5+1,(i-3)*(covercliplockw+covercliphandlel+0.5)+covercliph/2,covercliph/2]) rotate([0,0,0]) coverclip();
    }

    if (print==11) {
      translate([0,0,-fanframebasex]) rotate([0,-90,0]) intersection() {
	translate([-fanframel,fanframeclipy-15,-30-20]) cube([30,38,20]);
	fanframe();
      }
  
      for (i=[0]) translate([fanframeh/2+0.5+1,(i-3)*(covercliplockw+covercliphandlel+0.5)+covercliph/2,covercliph/2]) rotate([0,0,0]) coverclip();
    }
  }
}

if (print>0) {
  if (1) difference() {
    brim(w=7,heatcoverh=abs?basel:0,heatcoverwall=0.4) prints();
    brimcut(w=7) prints();
  }

  prints();
 }
