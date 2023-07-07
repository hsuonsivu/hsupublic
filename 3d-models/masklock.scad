// lock for cpap mask to replace broken one
topwidth=26;
addheight=2;
strapholewidth=18;
strapholeheight=17.52+addheight;
fullwidthheight=0.75; // How large part is full width
strapholesize=4;
strapholeupperdiameter=6;
strapholeupperz=strapholeheight+strapholesize+strapholeupperdiameter/2;
strapholeside=3.5;
lockpinwidth=6.6;
lockpinlowersupportwidth=lockpinwidth+4;
lockpindiameter=5;
lockpinheight=8.7+addheight;
lockpiny=12.3;
lockpinysupport=3;
lockpinverticalsupporty=lockpiny-1;
lockpinverticalsupportysize=lockpinysupport+1;
lockbasey=3.77;
basey=5.5;
$fn=90;

module roundedbox(x,y,z) {
  smallcornerdiameter=1;
  f=30;
  hull() {
    translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
    translate([x-smallcornerdiameter/2,y-smallcornerdiameter/2,z-smallcornerdiameter/2]) sphere(d=smallcornerdiameter,$fn=f);
  }
}


hull() {
  translate([0,0,strapholeheight*fullwidthheight]) roundedbox(topwidth,basey,strapholeheight*(1-fullwidthheight));
  translate([topwidth/2-lockpinlowersupportwidth/2,0,0]) roundedbox(lockpinlowersupportwidth,basey,lockpinysupport);
}
translate([strapholeupperdiameter/2,strapholeupperdiameter/2,strapholeupperz]) rotate([0,90,0]) cylinder(h=topwidth-strapholeupperdiameter,d=strapholeupperdiameter);
translate([0,0,strapholeheight*fullwidthheight]) roundedbox(strapholeside,basey,strapholeupperz+strapholeupperdiameter/2-strapholeheight*fullwidthheight);
translate([topwidth-strapholeside,0,strapholeheight*fullwidthheight]) roundedbox(strapholeside,basey,strapholeupperz+strapholeupperdiameter/2-strapholeheight*fullwidthheight);
translate([topwidth/2-lockpinwidth/2,lockpiny,lockpinheight]) rotate([0,90,0]) cylinder(h=lockpinwidth,d=lockpindiameter);
translate([topwidth/2-lockpinlowersupportwidth/2,0,0]) roundedbox(lockpinlowersupportwidth,lockpiny+lockpindiameter/2,lockpinysupport+addheight);
hull() {
  translate([topwidth/2-lockpinwidth/2,lockpinverticalsupporty,0]) roundedbox(lockpinwidth,lockpinverticalsupportysize,lockpinheight+lockpinwidth/2);
  translate([topwidth/2-lockpinlowersupportwidth/2,lockpinverticalsupporty,0]) roundedbox(lockpinlowersupportwidth,lockpinverticalsupportysize,lockpinysupport+lockpinwidth/2);
}
