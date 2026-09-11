// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>
include <hsubolt.scad>

print=0;
debug=0;

cornerd=1.6;
wall=2;

maxbridge=10;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;
dtolerance=0.5;

versiontext="V1.0";
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

diskscrewxtable=disk35[4];
diskscrewztable=disk35[5];
diskscrewd=disk35[8];

disk25=diskdimensions("2.5H");
disk25l=disk25[1];
disk25w=disk25[2];
disk25h=disk25[3];
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

basew=175;
baseleftl=120;
bottomscreww=162.5; //164;
bottomleftscrewxtable=[35+caseshift-1,95+caseshift-1]; // plusminus 4mm;
bottomrightscrewxtable=[35+caseshift-1,115+caseshift-1];
leftl=wall+xtolerance+disk25l;
lefth=100;//120?
maxh=150;
tassuh=6.4;
rightoverlap=28;
originalw=149;
disksw=wall+ytolerance+disk35[2]+ytolerance+wall;
baserighty=-originalw/2-rightoverlap;
disky=baserighty+disksw/2-diskw/2;
diskx=wall+xtolerance;

disk25y=baserighty+disksw+xtolerance;
disk25x=wall+xtolerance;
lefty=disk25y+disk25w+xtolerance+wall;

diskstopperw=wall+8;

floppyy=originalw/2+5.37+48-floppyw;
floppyheight=lefth+ztolerance;

bottomscrewd=4.3;
bottomscrewbaseh=3.5;
bottomscrewbased=10;
bottomscrewxflex=4;

disksheight=wall+bottomscrewbaseh+0.5;
disks25height=disksheight;

diskhstep=ztolerance+diskh+ztolerance+wall;
disk25hstep=ztolerance+disk25h+ztolerance+wall;

disks=3;
disks25=6;

baserightl=wall+xtolerance+diskl; //140;

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
diskcliphandlel=2.5;

diskcliplockcutx=diskclipcoverx+2;
diskcliplockcutl=diskcliplockx+diskcliplockl-diskcliplockcutx;

diskclipcut=0.6;

clipwall=1.6;

diskclipcoverh=wall+ztolerance+diskcliph+ztolerance+wall;
diskclipcoverfullw=wall+ytolerance+diskclipw+ytolerance+clipwall;

diskclipx=diskx+diskl-diskclipl;
disk25clipx=disk25x+disk25l-diskclipl;

module lockcut() {
  cube([disklockl+0.01,disklockw+0.02,disklockcut]);
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
    translate([diskcliplockcutx+diskcliplockcutl-wall*2+diskcliphandlel,diskclipw+ytolerance+diskcliphandlel,-diskcliplockbarh/2]) roundedbox(wall,clipwall,diskcliplockbarh,0);
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

    if (0) for (z=[-diskcliplockbarh/2-diskclipcut,diskcliplockbarh/2]) {
      for (x=[diskcliplockcutx+diskcliplockcutl-0.4,diskcliplockcutx+diskcliplockcutl/2-0.2]) {
	if ((z < 0) || (x < diskcliplockcutx+diskcliplockcutl/2)) {
	  translate([x,diskclipw+ytolerance,z-0.01]) cube([0.4,0.4,diskclipcut+0.02]);
	  translate([x,diskclipw+ytolerance,z+diskclipcut-0.2]) cube([0.4,clipwall,0.2+0.01]);
	  translate([x,diskclipw+ytolerance+clipwall-0.4,z-0.01]) cube([0.4,0.4,diskclipcut+0.02]);
	}
      }
    }
  }
}

module icopdiskholder() {
  difference() {
    union() {
      // Bottom plate
      translate([0,-basew/2,0]) roundedbox(baseleftl,basew,wall,cornerd,7);
      translate([0,baserighty,0]) roundedbox(baserightl+xtolerance+wall,disksw,wall,cornerd,7);

      // Right disk side plate
      translate([0,baserighty,0]) roundedbox(baserightl,wall,lefth,cornerd,7);
      translate([0,baserighty,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);

      // Left side plate
      translate([0,lefty-wall,0]) roundedbox(leftl,wall,lefth,cornerd,7);
      if (disklockclips) {
	for (i=[0:1:disks25-1]) {
	  z=disks25height+i*disk25hstep+disk25spaceh/2;
	  translate([disk25clipx,lefty+ytolerance,z]) diskclipcover(i==0);
	}
      } else {
	for (i=[0:1:disks25-1]) {
	  z=disksheight+i*disk25hstep;
	  hull() {
	    translate([leftl-wall+xtolerance*2,lefty-wall,z+disk25h/2-disk25lockh/2]) roundedbox(wall,wall,disk25lockh,cornerd,0);
	    translate([leftl-wall+xtolerance*2+disklockw,lefty-wall-disklockw,z+disk25h/2-disk25lockh/2]) roundedbox(wall,wall,disk25lockh,cornerd,0);
	  }
	}
      }
      
      // Left disk side plate
      translate([0,baserighty+disksw-wall,0]) roundedbox(disksleftlockl,wall,lefth,cornerd,7);
      translate([0,baserighty+disksw-diskstopperw,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);
      if (disklockclips) {
	for (i=[0:1:disks-1]) {
	  z=disksheight+i*diskhstep+diskspaceh/2;
	  translate([diskclipx,baserighty-ytolerance,z]) mirror([0,1,0]) diskclipcover(i==0);//rotate([180,0,0])
	}
	if (0) hull() {
	  translate([diskclipx-diskclipcoverl,baserighty-diskclipcoverfullw+wall,disksheight+diskspaceh/2-diskclipcoverh/2]) roundedbox(diskclipcoverl+diskclipl,diskclipcoverfullw,wall,cornerd);
	  translate([diskclipx-diskclipcoverl,baserighty,disksheight+diskspaceh/2-diskclipcoverh/2-diskclipcoverfullw+wall]) roundedbox(diskclipcoverl+diskclipl,wall,wall,cornerd);
	}
      } else {
	for (i=[0:1:disks-1]) {
	  z=disksheight+i*diskhstep;
	  hull() {
	    translate([disksleftlockl-wall,baserighty+disksw-wall,z+diskh/2-disklockh/2]) roundedbox(wall,wall,disklockh,cornerd,0);
	    translate([disksleftlockl-wall+disklockw,baserighty+disksw-wall-disklockw,z+diskh/2-disklockh/2]) roundedbox(wall,wall,disklockh,cornerd,0);
	  }
	}
      }

      // Left top
      translate([0,lefty-basew,lefth-wall]) roundedbox(leftl,basew,wall,cornerd,7);
      
      // Raise bottom screws to avoid them hitting disks
      for (x=bottomrightscrewxtable) {
	h=wall+bottomscrewbaseh+0.5;

	hull() {
	  for (xx=[-bottomscrewxflex/2,bottomscrewxflex/2]) {
	    translate([x+xx,-bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=h,$fn=90);
	    translate([x+xx,-bottomscreww/2-bottomscrewbased/4,0]) cube([bottomscrewbased/2+wall,bottomscrewbased/2,h]);
	    translate([x+xx-bottomscrewbaseh-0.5,-bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=wall,$fn=90);
	  }
	}
      }
      for (x=bottomleftscrewxtable) {
	h=wall+bottomscrewbaseh+0.5;
	hull() {
	  for (xx=[-bottomscrewxflex/2,bottomscrewxflex/2]) {
	    translate([x+xx,bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=h,$fn=90);
	    translate([x+xx,bottomscreww/2-bottomscrewbased/4,0]) cube([bottomscrewbased/2+wall,bottomscrewbased/2,h]);
	    translate([x+xx-bottomscrewbaseh-0.5,bottomscreww/2,0]) cylinder(d=bottomscrewbased+wall*2,h=wall,$fn=90);
	  }
	}
      }

      // Disk supports
      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep;
	translate([0,baserighty,z-wall]) roundedbox(baserightl,diskstopperw,wall,cornerd,7);
	translate([0,baserighty+disksw-diskstopperw,z-wall]) roundedbox(baserightl,diskstopperw,wall,cornerd,7);
      }

      for (i=[0:1:disks25-1]) {
	z=disksheight+i*disk25hstep;
	translate([0,disk25y-xtolerance-wall,z-wall]) roundedbox(wall+xtolerance+disk25l,diskstopperw,wall,cornerd,7);
	translate([0,disk25y+disk25w+xtolerance+wall-diskstopperw,z-wall]) roundedbox(wall+xtolerance+disk25l,diskstopperw,wall,cornerd,7);
      }
      translate([0,disk25y-xtolerance-wall,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);
      translate([0,disk25y+disk25w+xtolerance+wall-diskstopperw,0]) roundedbox(wall,diskstopperw,lefth,cornerd,7);

      // Floppy supports
      translate([0,floppyy+ytolerance,lefth-wall]) roundedbox(leftl,wall,floppyspaceh*2+wall+wall,cornerd,7);
      translate([0,floppyy-floppyw-ytolerance-wall,lefth-wall]) roundedbox(leftl,wall,floppyspaceh*2+wall+wall,cornerd,7);
      translate([0,floppyy-floppyw-ytolerance-wall,lefth-wall+floppyspaceh*2+wall]) roundedbox(leftl,wall+ytolerance+floppyw+ytolerance+wall,wall,cornerd,7);
      
      // First top
      translate([0,baserighty,lefth-wall]) roundedbox(baserightl,disksw,wall,cornerd,7);
    }

    // Disk locks
    if (!disklockclips) for (i=[0:1:disks-1]) {
      z=disksheight+i*diskhstep;

      translate([disksleftlockl-disklockl,baserighty+disksw-disklockw-0.01,z]) lockcut();
      translate([disksleftlockl-disklockl,baserighty+disksw-disklockw-0.01,z+ztolerance+diskh+ztolerance-disklockcut]) lockcut();
    }

    if (disklockclips) {
      for (i=[0:1:disks25-1]) {
	z=disks25height+i*disk25hstep+disk25spaceh/2;
	translate([disk25clipx,lefty+ytolerance,z]) diskclipcovercut();
      }
      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep+diskspaceh/2;
	translate([diskclipx,baserighty-ytolerance,z]) mirror([0,1,0]) diskclipcovercut();
      }
    }
    
    // Floppy and upper slots screwholes
    for (i=[0:1:1]) {
      z=floppyheight+i*(ztolerance+floppyh+ztolerance);
      w=wall+ytolerance+floppyw+ytolerance+wall;
      for (x=floppyscrewxtable) {
	translate([floppyx+floppyl-x,floppyy+ytolerance+wall-w-0.1,z+floppyscrewheight]) rotate([-90,0,0]) cylinder(d=floppyscrewd,h=w+0.2,$fn=30);
      }

      for (zz=diskscrewztable) {
	for (x=diskscrewxtable) {
	  translate([floppyl-x,floppyy+ytolerance+wall-w-0.1,z+zz]) rotate([-90,0,0]) cylinder(d=floppyscrewd,h=w+0.2,$fn=30);
	}
      }
    }
    
    // Screw holesprotect
    for (x=bottomrightscrewxtable) {
      h=bottomscrewbaseh+0.5+0.02;
      hull() {
	for (xx=[-bottomscrewxflex/2,bottomscrewxflex/2]) {
	  translate([x+xx,-bottomscreww/2,wall]) cylinder(d=bottomscrewbased,h=h,$fn=90);
	  translate([x+xx,-bottomscreww/2-bottomscrewbased/4,wall]) cube([bottomscrewbased/2,bottomscrewbased/2,h]);
	}
      }
      hull() {
	for (xx=[-bottomscrewxflex/2,bottomscrewxflex/2]) {
	  translate([x+xx,-bottomscreww/2,-0.01]) cylinder(d=bottomscrewd,h=wall+0.02,$fn=90);
	}
      }
    }
    for (x=bottomleftscrewxtable) {
      h=wall+bottomscrewbaseh+0.5;
      intersection() {
	hull() {
	  for (xx=[-bottomscrewxflex/2,bottomscrewxflex/2]) {
	    translate([x+xx,bottomscreww/2,wall]) cylinder(d=bottomscrewbased,h=h,$fn=90);
	  }
	}
      }
      hull() {
	for (xx=[-bottomscrewxflex/2,bottomscrewxflex/2]) {
	  translate([x+xx,bottomscreww/2,-0.01]) cylinder(d=bottomscrewd,h=wall+0.02,$fn=90);
	}
      }
    }

    translate([textsize,floppyy-floppyw/2,lefth+floppyspaceh*2+wall-textdepth+0.01]) rotate([0,0,-90]) linear_extrude(height=textdepth) text(longtext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([-1000,-1000,-1000]) cube([2000,2000,1000+disks25height+disk25spaceh/2+disk25spaceh+wall]);

    union() {
      
      icopdiskholder();

      for (i=[0:1:disks-1]) {
	z=disksheight+i*diskhstep;
	%translate([diskx+diskl,disky+diskw/2,z]) rotate([0,0,180]) diskform("3.5");
	#translate([diskx+diskl-diskclipl,baserighty-ytolerance,z+ztolerance+diskh/2]) mirror([0,1,0]) diskclip();
      }

      for (i=[0:1:disks25-1]) {
	z=disksheight+i*disk25hstep;
	%translate([disk25x+disk25l,disk25y+disk25w/2,z]) rotate([0,0,180]) diskform("2.5");
	#translate([disk25x+disk25l-diskclipl,lefty+ytolerance,z+ztolerance+disk25h/2]) diskclip();
      }

      for (i=[0:1:1]) {
	z=floppyheight+i*(ztolerance+floppyh+ztolerance);
	%translate([floppyx+floppyl,floppyy-floppyw/2,z]) rotate([0,0,180]) diskform("3.5FLOPPY");
      }
    }
  }
 }

if (print==1 || print==3) {
  rotate([0,-90,0]) icopdiskholder();
 }

if (print==2 || print==3) {
  translate([-diskcliplockw-0.5,-diskclipl-diskstopperw-diskcliplockl,0]) rotate([0,0,90]) {
    for (i=[0:1:disks+disks25-1]) {
      translate([0,i*(diskcliplockw+0.5),diskcliph/2]) diskclip();
    }
  }
 }

if (print==6) {
  intersection() {
    icopdiskholder();
    union() {
      translate([bottomleftscrewxtable[0]-10,-200,-100]) cube([20,400,100+wall+1]);
      translate([0,-bottomscreww/2-10,00]) cube([300,20,disksheight]);
      translate([0,bottomscreww/2-7,00]) cube([300,20,disksheight]);
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
