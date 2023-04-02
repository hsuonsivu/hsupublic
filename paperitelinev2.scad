// Paper towel roll holder
// height=x
// depth=y
// width=z

rollwidth=226;
rolldiameteroutside=200;
rolldiameterinside=43;
rollextra=5; // Distance from backplate to roll
rollborediameter=26;
screwdistance=166.5;

backplateheight=295;
backplatedepth=10;
holdersupportdepth=rolldiameteroutside/2+backplatedepth;
holdersupportwidth=10;
backplatewidth=rollwidth+holdersupportwidth*2;

rollaxisdepth=rolldiameteroutside/2+backplatedepth+rollextra;
rollaxisheight=rolldiameteroutside/2;
rollborewidth=40; // rollwidth + 2*holdersupportwidth + 10;

screwrecessdiameter=30;
screwrecessdepth=5;
screwrecessmid=backplatewidth/2;
screwrecessheight=backplateheight-screwrecessdiameter/2-10;
screwrecessleft=screwrecessmid-screwdistance/2;
screwrecessright=screwrecessmid+screwdistance/2;

screwholediameter=6.5;

fingerwidth=40;
fingerdepth=2.5;
fingerdepthposition=2.5;
fingerheight=15;
fingerupper=backplateheight - 45 - fingerheight; // rollaxisheight*2+backplatedepth/2-10-fingerheight;
fingerlower=10;
fingernotchdepth=2; //backplatedepth;
fingernotchmalediameter=1;
fingernotchwidth=3;

tolerance=0.20;
tolerancedepth=0.30;
diametertolerance=0.97;
  
holeedge=63;
roundholediameter=40;
holezadjust=6;

print=1; // 1=left, 2=right

module holder() {
  difference() {
    union() {
      cube([backplateheight,backplatedepth,backplatewidth],center=false);

      hull() {
	translate([backplatedepth/2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
	translate([rollaxisheight,rollaxisdepth,0]) cylinder(h=holdersupportwidth,d=rolldiameterinside);
	translate([rollaxisheight*2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
      };

      translate([0,0,backplatewidth-holdersupportwidth])
	hull() {
	translate([backplatedepth/2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
	translate([rollaxisheight,rollaxisdepth,0]) cylinder(h=holdersupportwidth,d=rolldiameterinside);
	translate([rollaxisheight*2,backplatedepth/2,0]) cylinder(h=holdersupportwidth,d=backplatedepth);
      };

      translate([rollaxisheight,rollaxisdepth,holdersupportwidth])
	cylinder(h=rollwidth+1,d=rolldiameterinside);
      
      text = "V2";
      font = "Liberation Sans";
      translate([10,10,holdersupportwidth+10]) rotate([-90,270,0]) linear_extrude(height = 0.5) text(text = str(text), font = font, size = 10, valign=110);
    }

    translate([rollaxisheight,rollaxisdepth,-0.01])
      cylinder(h=rollwidth+holdersupportwidth*2+1,d=rollborediameter);

    translate([screwrecessheight,screwrecessdepth,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);
    translate([screwrecessheight,screwrecessdepth,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);

    translate([screwrecessheight,-0.01,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter);
    translate([screwrecessheight,-0.01,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter);

    // Lightening holes
    for (x=[holeedge/2:holeedge*1.7:backplateheight - holeedge])
      for (z=[holeedge + holezadjust:holeedge*1.7:backplatewidth - holeedge - holdersupportwidth + holezadjust])
	translate([x,-0.01,z]) rotate([0,45,0]) cube([holeedge,backplatedepth+1,holeedge]);
    z = holeedge + holeedge*1.7/2 + holezadjust;
    for (x=[holeedge/2+holeedge*1.7/2:holeedge*1.7:backplateheight - holeedge / 2]) translate([x,-0.01,z]) rotate([0,45,0]) cube([holeedge,backplatedepth+1,holeedge]);

    x1 = holeedge/3.5;
    z1 = holeedge + holeedge*1.7/2 + holezadjust;
    translate([x1,-0.01,z1]) rotate([0,45,0]) cube([holeedge/1.7,backplatedepth+1,holeedge/1.7]);

    x2 = holeedge/2+holeedge*1.7/2 + 24;
    z2 = holeedge / 2 + 3 + holezadjust;
    translate([x2,-0.01,z2]) rotate([0,45,0]) cube([holeedge/2.1,backplatedepth+1,holeedge/2.1]);

    x3 = holeedge/2+holeedge*1.7/2 + 24;
    z3 = holeedge / 2 + 3 + holeedge * 2.6 + holezadjust;
    translate([x3,-0.01,z3]) rotate([0,45,0]) cube([holeedge/2.1,backplatedepth+1,holeedge/2.1]);

    // Lightening holes in roll supports
    for (x=[55:roundholediameter*1.1:160]) {
      y = 35;
      translate([x,y,-0.1]) cylinder(h=rollwidth + holdersupportwidth * 2 + 1, d=roundholediameter);
    }

    for (x=[55+roundholediameter/2:roundholediameter*1.1:160]) {
      y = 75;
      translate([x,y,-0.1]) cylinder(h=rollwidth + holdersupportwidth * 2 + 1, d=roundholediameter * 0.8);
    }

  }

}

if (print==1 || print==0) {
  difference() {
    holder();
    translate([-0.01,-0.01,holdersupportwidth+rollwidth-0.01]) cube([backplateheight+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+1],center=false);
    translate([fingerupper,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+tolerance,fingerwidth+tolerance],center=false);
    translate([fingerupper,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+fingernotchdepth+tolerance,fingernotchwidth+tolerance]);
    translate([fingerupper+fingerheight/2,-0.01,holdersupportwidth+rollwidth-fingerwidth+1.5]) rotate([0,90,90]) cylinder(h=holdersupportwidth+1,d=5,$fn=30);
    translate([fingerlower,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+tolerance,fingerwidth+tolerance],center=false);
    translate([fingerlower,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+fingernotchdepth+tolerance,fingernotchwidth+tolerance]);
    translate([fingerlower+fingerheight/2,-0.01,holdersupportwidth+rollwidth-fingerwidth+1.5]) rotate([0,90,90]) cylinder(h=holdersupportwidth+1,d=5,$fn=30);
  }
 }

if (print==2 || print==0) {
  difference() {
    holder();
    translate([-0.01,-0.01,-0.01]) cube([backplateheight+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+rollwidth+0.01],center=false);
  }
  translate([fingerupper,fingerdepthposition,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight-tolerance,fingerdepth-tolerancedepth,fingerwidth-tolerance],center=false);
  translate([fingerupper,fingerdepthposition+fingerdepth,holdersupportwidth+rollwidth-fingerwidth+fingernotchwidth/2]) rotate([0,90,0]) cylinder(h=fingerheight-tolerancedepth,d=2*fingernotchmalediameter,$fn=30);
  translate([fingerlower,fingerdepthposition,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight-tolerance,fingerdepth-tolerancedepth,fingerwidth-tolerance],center=false);
  translate([fingerlower,fingerdepthposition+fingerdepth,holdersupportwidth+rollwidth-fingerwidth+fingernotchwidth/2]) rotate([0,90,0]) cylinder(h=fingerheight-tolerancedepth,d=2*fingernotchmalediameter,$fn=30);
  translate([rollaxisheight,rollaxisdepth,rollwidth+holdersupportwidth*2-rollborewidth]) cylinder(h=rollborewidth,d=rollborediameter*diametertolerance);
  translate([rollaxisheight,rollaxisdepth,rollwidth+holdersupportwidth*2-holdersupportwidth]) cylinder(h=holdersupportwidth,d=rollborediameter);
 }
