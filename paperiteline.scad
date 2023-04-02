// Paper towel roll holder
// height=x
// depth=y
// width=z

rollwidth=226;
rolldiameteroutside=205;
rolldiameterinside=46;
rollextra=4; // Distance from backplate to roll
rollborediameter=25;
screwdistance=166.5;

backplateheight=300;
backplatedepth=10;
holdersupportdepth=rolldiameteroutside/2+backplatedepth;
holdersupportwidth=10;
backplatewidth=rollwidth+holdersupportwidth*2;

rollaxisdepth=rolldiameteroutside/2+backplatedepth+rollextra;
rollaxisheight=rolldiameteroutside/2;
rollborewidth=40; // rollwidth + 2*holdersupportwidth + 10;

screwrecessdiameter=30;
screwrecessdepth=6.5;
screwrecessmid=backplatewidth/2;
screwrecessheight=backplateheight-screwrecessdiameter/2-10;
screwrecessleft=screwrecessmid-screwdistance/2;
screwrecessright=screwrecessmid+screwdistance/2;

screwholediameter=6.5;

fingerwidth=40;
fingerdepth=1.5;
fingerdepthposition=3.5;
fingerheight=20;
fingerupper=backplateheight - 40 - fingerheight; // rollaxisheight*2+backplatedepth/2-10-fingerheight;
fingerlower=10;
fingernotchdepth=2;
fingernotchmaledepth=1;
fingernotchwidth=3;

tolerance=0.2;
diametertolerance=0.985;
  
holeedge=63;
roundholediameter=40;

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
    }

    translate([rollaxisheight,rollaxisdepth,-0.01])
      cylinder(h=rollwidth+holdersupportwidth*2+1,d=rollborediameter);

    translate([screwrecessheight,screwrecessdepth,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);
    translate([screwrecessheight,screwrecessdepth,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+0.01,d1=screwrecessdiameter,d2=screwrecessdiameter+backplatedepth+0.01);

    translate([screwrecessheight,-0.01,screwrecessleft]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter,$fn=30);
    translate([screwrecessheight,-0.01,screwrecessright]) rotate([-90,0,0]) cylinder(h=backplatedepth+1,d=screwholediameter,$fn=30);

    // Lightening holes
    for (x=[holeedge/2:holeedge*1.7:backplateheight - holeedge])
      for (z=[holeedge:holeedge*1.7:backplatewidth - holeedge - holdersupportwidth])
	translate([x,-0.01,z]) rotate([0,45,0]) cube([holeedge,backplatedepth+1,holeedge]);
    z = holeedge + holeedge*1.7/2;
    for (x=[holeedge/2+holeedge*1.7/2:holeedge*1.7:backplateheight - holeedge / 2]) translate([x,-0.01,z]) rotate([0,45,0]) cube([holeedge,backplatedepth+1,holeedge]);

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
    translate([fingerlower,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+tolerance,fingerwidth+tolerance],center=false);
    translate([fingerlower,-0.01,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight+tolerance,fingerdepthposition+fingerdepth+fingernotchdepth+tolerance,fingernotchwidth+tolerance]);
  }
 }

if (print==2 || print==0) {
  difference() {
    holder();
    translate([-0.01,-0.01,-0.01]) cube([backplateheight+0.1,rollaxisdepth+rolldiameterinside+0.01,holdersupportwidth+rollwidth+0.01],center=false);
  }
  translate([fingerupper,fingerdepthposition,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight-tolerance,fingerdepth-tolerance,fingerwidth-tolerance],center=false);
  translate([fingerupper,fingerdepthposition+fingerdepth,holdersupportwidth+rollwidth-fingerwidth+fingernotchwidth/2]) rotate([0,90,0]) cylinder(h=fingerheight-tolerance,d=2*fingernotchmaledepth,$fn=30);
  translate([fingerlower,fingerdepthposition,holdersupportwidth+rollwidth-fingerwidth]) cube([fingerheight-tolerance,fingerdepth-tolerance,fingerwidth-tolerance],center=false);
  translate([fingerlower,fingerdepthposition+fingerdepth,holdersupportwidth+rollwidth-fingerwidth+fingernotchwidth/2]) rotate([0,90,0]) cylinder(h=fingerheight-tolerance,d=2*fingernotchmaledepth,$fn=30);
  translate([rollaxisheight,rollaxisdepth,rollwidth+holdersupportwidth*2-rollborewidth]) cylinder(h=rollborewidth,d=rollborediameter*diametertolerance);
  translate([rollaxisheight,rollaxisdepth,rollwidth+holdersupportwidth*2-holdersupportwidth]) cylinder(h=holdersupportwidth,d=rollborediameter);
 }
