// Copyright 2025 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

kaivo0d=216;
kaivo9d=212.5;
kaivo24d=195;
kaivoh=17;

kansid=216-2*1.1; // 216??;
kansi9d=202-0.5;//196;
kansi24d=200-0.5;//194;

cornerd=2;

difference() {
  union() {
    //translate([0,0,24-9]) cylinder(d1=kaivo9d,d2=kaivo0d,h=9,$fn=180);
    translate([0,0,0]) cylinder(d=kaivo9d,h=24-9,$fn=180);
  }
  //  translate([0,0,24-9]) cylinder(d1=kansid-4,d2=kansid,h=9+0.01,$fn=180);
  translate([0,0,-0.01]) cylinder(d1=kansi24d,d2=kansi9d,h=24-9+0.02,$fn=180);
}

