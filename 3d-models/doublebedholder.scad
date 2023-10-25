// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// Only rectangular or circular bed feet supported. Configure foot
// diameter and distance between feet.

bedlegcorner=55;
distancebetween=180-55;

versiontext="1.0";
textfont="DejaVu Sans:style=Bold";
textdepth=0.7;
textheight=6;
textvspacing=textheight*1.5;

wall=15;
straight=10;
narrowing=40;
topopening=10;
insidecornerdiameter=2;
outsidecornerdiameter=4;
thickness=20;

secondcolumn=bedlegcorner+wall+50;
firstcolumn=bedlegcorner+wall+10;

module roundedbox(x,y,z,topx,topy,c) {
  corner=(c > 0) ? c : 1;
  scd = ((x < 1 || y < 1 || z < 1) ? min(x,y,z) : corner);
  f=90;

  tx=(topx>0) ? topx : x;
  ty=(topy>0) ? topy : y;
  echo("roundedbox x y z topx topy c scd", x,y,z,topx,topy,c,scd);
  hull() {
    translate([scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([x-scd/2,y-scd/2,scd/2]) sphere(d=scd,$fn=f);
    translate([(x-tx)/2+scd/2,(y-ty)/2+scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([(x-tx)/2+scd/2,ty+(y-ty)/2-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([tx+(x-tx)/2-scd/2,(y-ty)/2+scd/2,z-scd/2]) sphere(d=scd,$fn=f);
    translate([tx+(x-tx)/2-scd/2,ty+(y-ty)/2-scd/2,z-scd/2]) sphere(d=scd,$fn=f);
  }
}

module jalka() {
  difference() {
    translate([-wall,-wall,0]) roundedbox(bedlegcorner+wall*2,bedlegcorner+wall*2,straight+narrowing,0,0,outsidecornerdiameter);
    translate([0,0,-insidecornerdiameter/2]) roundedbox(bedlegcorner,bedlegcorner,straight+insidecornerdiameter+0.01,0,0,insidecornerdiameter);
    translate([0,0,straight-insidecornerdiameter/2]) roundedbox(bedlegcorner,bedlegcorner,narrowing+insidecornerdiameter,bedlegcorner+topopening,bedlegcorner+topopening,insidecornerdiameter);
  }
}

jalka();
translate([distancebetween+bedlegcorner,0,0]) jalka();
difference() {
  translate([bedlegcorner+wall-outsidecornerdiameter,-wall,0]) roundedbox(distancebetween-wall*2+outsidecornerdiameter*2,bedlegcorner+wall*2,thickness,0,0,outsidecornerdiameter);

  translate([firstcolumn,bedlegcorner - textvspacing*2,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(text = "Version",size=textheight, halign="left", font=textfont);
  translate([secondcolumn,bedlegcorner - textvspacing*2,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(text = str(versiontext),size=textheight, halign="left", font=textfont);

  translate([firstcolumn,bedlegcorner - textvspacing*3,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(text = str("↔"),size=textheight, halign="left", font=textfont);
  translate([secondcolumn,bedlegcorner - textvspacing*3,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(text = str(distancebetween, " mm"),size=textheight, halign="left", font=textfont);

  translate([firstcolumn,bedlegcorner - textvspacing*4,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(text = str("□"),size=textheight, halign="left", font=textfont);
  translate([secondcolumn,bedlegcorner - textvspacing*4,thickness-textdepth+0.01]) linear_extrude(height=textdepth) text(text = str(bedlegcorner, " mm"),size=textheight, halign="left", font=textfont);
}
