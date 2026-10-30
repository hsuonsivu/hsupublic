// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

w=102.85+0.3;
sidewall=1.93;
inw=w-sidewall*2;
h=26;
topbottomwall=1.71;
inh=h-topbottomwall*2;
l=6.13;
inl=4;
inx=l-4;
clipl=16.65+0.05;
clipwl=4.3;
clipbothh=18.88;
cliph=6;
clipw=1.1;
clipcornerd=clipw;
cornerd=2;
clipdepth=2.5;
clipslope=clipdepth-clipw;
clipy=-w/2+sidewall-clipw;

module cover35() {
  difference() {
    union() {
      translate([0,-w/2,-h/2]) roundedbox(l,w,h,cornerd,3);
    }

    hull() {
      translate([inx,-inw/2+inl,-inh/2+inl]) roundedbox(inl,inw-inl*2,inh-inl*2,cornerd,3);
      translate([inx+inl,-inw/2-cornerd/2,-inh/2-cornerd/2]) roundedbox(inl,inw+cornerd,inh+cornerd,cornerd,3);
    }
  }

  for (n=[0,1]) mirror([0,n,0]) {
      hull() {
	translate([cornerd/2+clipcornerd/2,clipy,-h/2]) roundedbox(clipl-(h-clipbothh)/2-cornerd/2-clipcornerd/2,clipw,h,clipcornerd,3);
	translate([cornerd/2+clipcornerd/2,clipy,-clipbothh/2]) roundedbox(clipl-cornerd/2-clipcornerd/2,clipw,clipbothh,clipcornerd,3);
      }

      for (m=[0,1]) mirror([0,0,m]) {
	  hull() {
	    translate([clipl-clipwl,clipy+clipw-clipdepth,-clipbothh/2]) roundedbox(clipcornerd,clipdepth,cliph,clipcornerd,3);
	    translate([clipl-clipdepth,clipy,-clipbothh/2]) roundedbox(clipdepth,clipw,cliph,clipcornerd,3);
	    translate([clipl-clipwl,clipy,-clipbothh/2-clipslope]) roundedbox(clipcornerd,clipcornerd,cliph+clipslope*2,clipcornerd,3);
	  }
	}
    }
}

cover35();
