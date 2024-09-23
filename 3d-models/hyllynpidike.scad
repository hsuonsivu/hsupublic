
radius=16/2;
nailradius=1;
nailcentertoflat=5.5;
depth=6.5;

difference() {
    cylinder(h=depth,r=radius,center=true, $fn=360);
    cylinder(h=depth+2,r=nailradius+0.2,center=true, $fn=90);
    translate([nailcentertoflat, -radius, -depth+1])
	cube(size=radius*2,center=false);
}

