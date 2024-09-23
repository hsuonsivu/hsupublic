totalheight=25;
diametertop=28;
diameterbottom=23;
wallthickness=5;
insideheight=totalheight-wallthickness;
insidediametertop=diametertop-5*2;
insidediameterbottom=diameterbottom-5*2;

$fn=360;

difference() {
cylinder(h=totalheight,d1=diametertop,d2=diameterbottom);
translate([0,0,-0.01]) cylinder(h=insideheight + 0.01,d1=insidediametertop,d2=insidediameterbottom);
}

