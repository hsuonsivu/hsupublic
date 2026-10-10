// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Tools for building computer case parts such as disk frames and fan cases

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

module coverclip() {
  difference() {
    union() {
      hull() {
	translate([0,0,-covercliph/2+wall]) roundedbox(coverclipl+xtolerance+wall,wall/2,covercliph-wall*2,cornerd,1);
	translate([wall/2,0,-covercliph/2]) roundedbox(coverclipl+xtolerance+wall-wall/2,wall,covercliph,cornerd,1);
      }
      translate([coverclipl+xtolerance,-covercliplockw+wall,-covercliph/2]) roundedbox(wall,covercliplockw+covercliphandlel,covercliph,cornerd,1);

      hull() {
	translate([covercliplockx,0,-covercliplockh/2]) cube([covercliplockl,clipwall,covercliplockh]);
	translate([covercliplockx+covercliplockl-1,0,-covercliplockh/2+coverclipw+ytolerance]) cube([1,coverclipw+ytolerance+clipwall,covercliplockh-(coverclipw+ytolerance)*2]);
      }
    }

    translate([coverclipl/2,textdepth-0.01,0]) rotate([90,180,0]) linear_extrude(height=textdepth) text(versiontext, size=6, valign="center",halign="center",font="Liberation Sans:style=Bold"); 
  }
}

module coverclipcover(bottom=0) {
  hull() {
    x=coverclipcoverx-xtolerance-coverclipcoverfullw+wall;
    if (x>bottom) translate([x,coverclipw+ytolerance+clipwall-coverclipcoverfullw,-coverclipcoverh/2+wall]) roundedbox(wall,wall,coverclipcoverh-wall*2,cornerd);
    if (x<bottom) translate([bottom,coverclipw+ytolerance+clipwall-coverclipcoverfullw,-coverclipcoverh/2]) roundedbox(wall,coverclipcoverfullw,coverclipcoverh,cornerd);
    translate([coverclipcoverx-xtolerance,coverclipw+ytolerance+clipwall-coverclipcoverfullw,-coverclipcoverh/2]) roundedbox(wall,coverclipcoverfullw,coverclipcoverh,cornerd);
  }
  hull() {
    translate([coverclipcoverx+coverclipl-covercliphandlew+wall+xtolerance,coverclipw+ytolerance,coverclipcoverh/2-clipwall-clipwall-wall]) roundedbox(covercliphandlew,clipwall,covercliphandlew+wall,cornerd);
    translate([coverclipcoverx+coverclipl-covercliphandlel+wall+xtolerance+covercliphandlel-clipwall,coverclipw+ytolerance+covercliphandlew,coverclipcoverh/2-wall+covercliphandlew]) roundedbox(clipwall,clipwall,clipwall,cornerd);
  }
  hull() {
    translate([coverclipcoverx+coverclipl-covercliphandlel+wall+xtolerance-covercliphandlew,coverclipw+ytolerance,coverclipcoverh/2-clipwall]) roundedbox(covercliphandlel+covercliphandlew,clipwall,clipwall,cornerd);
    translate([coverclipcoverx+coverclipl-covercliphandlel+wall+xtolerance,coverclipw+ytolerance+covercliphandlew,coverclipcoverh/2-wall+covercliphandlew]) roundedbox(covercliphandlel,clipwall,clipwall,cornerd);
  }
  for (m=[0,1]) mirror([0,0,m]) {
      translate([coverclipcoverx-xtolerance,-wall-ytolerance,-coverclipcoverh/2]) roundedbox(coverclipcoverl+xtolerance,coverclipcoverfullw-clipwall-coverclipcut,wall,cornerd);
    }
  for (m=[0]) mirror([0,0,m]) {
      translate([coverclipcoverx-xtolerance,-wall-ytolerance,-coverclipcoverh/2-coverclipbridge-wall]) roundedbox(coverclipcoverl+xtolerance,coverclipcoverfullw,wall,cornerd);
    }
  translate([coverclipcoverx-xtolerance,coverclipw+ytolerance,-coverclipcoverh/2]) roundedbox(coverclipcoverl+xtolerance,clipwall,coverclipcoverh,cornerd);
  translate([covercliplockx,coverclipw+ytolerance,-coverclipcoverh/2-coverclipbridge-wall]) roundedbox(covercliplockl+wall*2,clipwall,coverclipcoverh+coverclipbridge+wall,cornerd);
}

module coverclipcovercut() {
  translate([covercliplockcutx,coverclipw+ytolerance-coverclipcut,-coverclipcoverh/2-0.01]) cube([coverclipcoverl,coverclipcut,coverclipcoverh+0.02]);
  translate([covercliplockx-xtolerance,coverclipw-cornerd/2,-covercliplockh/2-ztolerance]) roundedbox(covercliplockl+xtolerance*2,coverclipw+cornerd,covercliplockh+ztolerance*2,0);
  translate([coverclipl,-ytolerance-wall-cornerd/2,-covercliph/2-ztolerance]) roundedbox(wall+cornerd+xtolerance,wall+cornerd,covercliph+ztolerance*2,0);
}

