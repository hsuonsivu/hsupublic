// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

test=0; // changes dimensions for faster print
print=0; // 0 kaikki, 1 korkki, 2 varjostimen inside 3 varjostimen
	 // outside, 4 varjostimen ruuvi

$fn=180;

versiontext="V 1.0";
textdepth=0.7;
textsize=7;

screwdiameter=10.7;
mutteridiameter=13.4;
mutteridepth=4;
mutterithickness=3;
mutteriinsertx=mutteridiameter/1.75;
korkkidiameter=45.4;
korkkiheight=(test?mutteridepth+mutterithickness+1:28);

varjostinruuvid=5.2;
varjostinruuviupotusd=10.5;

varjostinruuvisuora=1;
varjostinruuviulkod=30;
varjostinruuvitopd=28;
varjostinruuvih=5.2;
varjostinruuviinsided=26;
varjostinruuviinsidetopd=25;
varjostinruuviinsideh=4;

varjostintolerancescale=1.02;
varjostintolerancezscale=1.04;

varjostinruuviupotush=varjostinruuviinsideh-varjostinruuvisuora;;

module varjostinruuviout() {
  cylinder(h=varjostinruuvih,d1=varjostinruuviulkod,d2=varjostinruuvitopd);
}

module varjostinruuviin() {
  cylinder(h=varjostinruuviinsideh,d1=varjostinruuviinsided,d2=varjostinruuviinsidetopd);
}


module varjostinruuvireika() {
  translate([0,0,-0.01]) cylinder(h=varjostinruuvisuora+0.02,d=varjostinruuvid);
  translate([0,0,varjostinruuvisuora]) cylinder(h=varjostinruuviupotush+0.01,d1=varjostinruuvid,d2=varjostinruuviupotusd+0.01);
}

if (print==0 || print==1) {
  translate([varjostinruuviinsided/2.3,varjostinruuviinsided/2+korkkidiameter/2-1,0]) 
  difference() {
    cylinder(h=korkkiheight,d=korkkidiameter,$fn=360);
    translate([0,0,-0.01]) cylinder(h=korkkiheight+0.02,d=screwdiameter,$fn=360);
    hull() {
      translate([0,0,korkkiheight-mutteridepth-mutterithickness]) cylinder(h=mutterithickness-0.2,d=mutteridiameter/cos(180/6),$fn=6);
      translate([0,0,korkkiheight-mutteridepth-mutterithickness]) cylinder(h=mutterithickness+0.01,d=mutteridiameter*0.97/cos(180/6),$fn=6);
    }
    translate([mutteriinsertx,0,korkkiheight-mutteridepth+mutterithickness]) cylinder(h=mutteridepth+0.01,d=mutteridiameter/cos(180/6),$fn=6);
    translate([mutteriinsertx,0,korkkiheight-mutteridepth]) cylinder(h=mutterithickness+0.01,d=mutteridiameter/cos(180/6),$fn=6);
    hull() {
      translate([0,0,korkkiheight-mutteridepth]) cylinder(h=0.01,d=mutteridiameter/cos(180/6),$fn=6);
      translate([0,0,korkkiheight-mutteridepth+mutterithickness]) cylinder(h=0.01,d=mutteridiameter/cos(180/6),$fn=6);
      translate([mutteriinsertx,0,korkkiheight-mutteridepth+mutterithickness]) cylinder(h=0.01,d=mutteridiameter/cos(180/6),$fn=6);
      translate([0,0,korkkiheight-0.5]) cylinder(h=0.01,d=screwdiameter);
      translate([mutteriinsertx,0,korkkiheight+0.01]) cylinder(h=0.01,d=screwdiameter);
      translate([0,0,korkkiheight+0.01]) cylinder(h=0.01,d=screwdiameter);
    }
    translate([-screwdiameter-1,0,korkkiheight-textdepth+0.01])  rotate([0,0,90]) linear_extrude(height=textdepth+1) text(versiontext, size=textsize, valign="center",halign="center",font="Liberation Sans:style=Bold");
  }
 }

if (print==0 || print==2 || print==4) {
  difference() {
    varjostinruuviin();
    varjostinruuvireika();
  }
}

if (print==0 || print==3 || print==4) {
  translate([varjostinruuviinsided/2+varjostinruuviulkod/2+0.5,0,varjostinruuvih]) {
    rotate([180,0,0]) difference() {
      varjostinruuviout();
      translate([0,0,-0.01]) scale([varjostintolerancescale,varjostintolerancescale,varjostintolerancezscale]) varjostinruuviin();
    }
  }
}
