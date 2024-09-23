include <nutsnbolts/materials.scad>;
include <nutsnbolts/cyl_head_bolt.scad>;
//use <MCAD/nuts_and_bolts.scad>;
//include <MCAD/units.scad>;


bottomedge=25.77;
bottomh=4.2;
bodyedge=15.38;
bodyh=21.13;
midedge=22.8;
midshortedge=21;
midh=2;
topedge=22.6;
toph=1.8;
holediameter=9.14;
opening=2.5;
rounding=3;
$fn=120;
midz1=7.6;
midz2=12.87;

difference() {
union() {
	translate([-bodyedge/2,-bodyedge/2,0])
        cube([bodyedge,bodyedge,bodyh]);
	hull() {
	       translate([bottomedge/2-rounding/2,bottomedge/2-rounding/2,0]) cylinder(d=rounding,h=bottomh);
	       translate([-(bottomedge/2-rounding/2),bottomedge/2-rounding/2,0]) cylinder(d=rounding,h=bottomh);
	       translate([bottomedge/2-rounding/2,-(bottomedge/2-rounding/2),0]) cylinder(d=rounding,h=bottomh);
	       translate([-(bottomedge/2-rounding/2),-(bottomedge/2-rounding/2),0]) cylinder(d=rounding,h=bottomh);
	       };
	hull() {
	       translate([midedge/2-rounding/2,midedge/2-rounding/2,midz1]) cylinder(d=rounding,h=midh);
	       translate([-(midedge/2-rounding/2),midedge/2-rounding/2,midz1]) cylinder(d=rounding,h=midh);
	       translate([midedge/2-rounding/2,-(midedge/2-rounding/2),midz1]) cylinder(d=rounding,h=midh);
	       translate([-(midedge/2-rounding/2),-(midedge/2-rounding/2),midz1]) cylinder(d=rounding,h=midh);
	       };
	hull() {
	       translate([midedge/2-rounding/2,midedge/2-rounding/2,midz2]) cylinder(d=rounding,h=midh);
	       translate([-(midedge/2-rounding/2),midedge/2-rounding/2,midz2]) cylinder(d=rounding,h=midh);
	       translate([midedge/2-rounding/2,-(midedge/2-rounding/2),midz2]) cylinder(d=rounding,h=midh);
	       translate([-(midedge/2-rounding/2),-(midedge/2-rounding/2),midz2]) cylinder(d=rounding,h=midh);
	       };
	hull() {
	       translate([topedge/2-rounding/2,topedge/2-rounding/2,bodyh-toph]) cylinder(d=rounding,h=midh);
	       translate([-(midedge/2-rounding/2),midedge/2-rounding/2,bodyh-toph]) cylinder(d=rounding,h=midh);
	       translate([midedge/2-rounding/2,-(midedge/2-rounding/2),bodyh-toph]) cylinder(d=rounding,h=midh);
	       translate([-(midedge/2-rounding/2),-(midedge/2-rounding/2),bodyh-toph]) cylinder(d=rounding,h=midh);
	       };
}
union() {
cylinder(h=bodyh+1,d=holediameter,$fa=1,$fs=0.1);
//translate([0,0,bodyh+1]) hole_threaded("M10", l=40, thread="modeled");
};
//translate([0,0,-0.001]) cylinder(h=opening+0.001,d2=holediameter,d1=holediameter+opening,$fa=1,$fs=0.1);
}
//translate([0,0,bodyh+1]) hole_threaded("M10", l=40, thread="modeled");


//translate([50,0,0]) screw("M10x50", thread="modeled");
//translate([0,0,bodyh+1]) hole_threaded("M10", l=40, thread="modeled");
