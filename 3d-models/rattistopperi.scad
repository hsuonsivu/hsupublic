outerdiameter=23.77;
height=10.83 + 1.5;
internaldiameter=(8.72+8.93)/2 + 0.2;
holderdiameter=9.12;
lowercutheight=2.5;
lowercutdiameter=12.84;
maindiameter=75.1;
mainouterdiameter=87.4;
mainnarrowerdiameter=66.5;
cutheight=7-1.5 + 0.1;
boltbase=9;
boltbasediameter=12;

part=0;

$fn=360;
centerdistance=mainouterdiameter - internaldiameter;
center=mainouterdiameter - maindiameter/2 - holderdiameter/2;

difference() {
	translate([center,0,0]) cylinder(h=height,d=outerdiameter);
	translate([center,0,-0.01]) cylinder(h=height+0.02,d=internaldiameter);
	translate([center,0,-0.01]) cylinder(h=lowercutheight,d1=lowercutdiameter,d2=internaldiameter);
	translate([center,0,boltbase]) cylinder(h=height-boltbase+1,d=boltbasediameter);
	translate([0,0,-0.01]) cylinder(h=cutheight + 0.02,d=maindiameter + 0.1);
	cylinder(h=height+0.1,d=mainnarrowerdiameter+0.1);
	translate([0,0,cutheight]) cylinder(h=maindiameter/2,d1=maindiameter,d2=0);
	if (part == 1) {
	  translate([0,0,-0.01]) cylinder(h=cutheight,d=mainouterdiameter+outerdiameter+10);
	} else if (part == 2) {
	  translate([0,0,cutheight]) cylinder(h=height,d=mainouterdiameter+outerdiameter+10);
	  }
	}

if (0) {
color("red") {
	cylinder(h=lowercutheight + 0.02,d=maindiameter);
	cylinder(h=height,d=mainnarrowerdiameter);
}
}
