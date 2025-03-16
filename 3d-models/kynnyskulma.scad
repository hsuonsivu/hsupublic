// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

// width=x, depth=y
final=1; // 0 for test print
vertical=1; // vertical prints parts in vertical mode, which makes them more difficult to attach to each other, but can be printed in a smaller printer
printerwidth=220;
thickness=21;//23;
flat=5;
slopedepth=80;
totaldepth=flat+slopedepth;
length=95;
tappidiameter=10;
tappitolerance=0.6;
tolerance=0.3;
$fn=90;
connectorwidth=vertical?5:10;
connectordepth=vertical?10:20;
connectorendnarrowing=1;
narrowing=0.75;
connectorposition=(vertical?(thickness/2-connectorwidth/2)*0.6:(totaldepth/2-connectordepth/2)*0.75);
maxwidth=295*3+9;//960;
printparts=1; // Multiphase print if all do not fit into the print bed

module male(x,y,h) {
  linear_extrude(height=h) {
    polygon(points=[[0,0],[0,y],[x,y-(y-y*narrowing)/2],[x,(y-y*narrowing)/2]]);
  }
}

module triangle(x,y,z,mode) {
  if (mode==0) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[x,z],[x,0]]);
  } else if (mode==1) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,z]]);
  } else if (mode==2) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,0],[0,z],[x,0]]);
  } else if (mode==3) {
    translate([0,y,0]) rotate([90,0,0]) linear_extrude(height=y) polygon(points=[[0,z],[x,z],[x,0]]);
  } else if (mode==4) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[y,x],[y,0]]);
  } else if (mode==5) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,x]]);
  } else if (mode==6) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,0],[0,x],[y,0]]);
  } else if (mode==7) {
    translate([x,0,0]) rotate([0,0,90]) linear_extrude(height=z) polygon(points=[[0,x],[y,x],[y,0]]);
  } else if (mode==8) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[z,y],[z,0]]);
  } else if (mode==9) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,y]]);
  } else if (mode==10) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,0],[0,y],[z,0]]);
  } else if (mode==11) {
    translate([0,0,z]) rotate([0,90,0]) linear_extrude(height=x) polygon(points=[[0,y],[z,y],[z,0]]);
  }
}

//for (x=[0:1:11]) translate([x*20,0,0]) triangle(10,20,40,x);

module lista(t,l) {
  union() {
    difference() {
      union() {
	cube([l,flat+0.01,thickness]);
	translate([0,totaldepth,0]) rotate([0,0,-90]) triangle(slopedepth,l,thickness,0);
      }
      
      if (t=="right") {
	// Nothing here
      }

      if (t=="center") {
	// Left locking hole
	if (vertical) {
	  translate([l-connectorwidth,totaldepth-0.01,connectorposition-0.01]) rotate([90,0,0]) male(connectorwidth+0.01,connectordepth,totaldepth);
	} else {
	  translate([l-connectorwidth,connectorposition,-0.01]) male(connectorwidth+0.01,connectordepth,thickness+0.02);
	}
      }
      
      if (t=="left") {
	// Left locking hole
	if (vertical) {
	  translate([l-connectorwidth,totaldepth-0.01,connectorposition-0.01]) rotate([90,0,0]) male(connectorwidth+0.01,connectordepth,totaldepth);
	} else {
	  translate([l-connectorwidth+0.01,connectorposition,-0.01]) male(connectorwidth+0.01,connectordepth,thickness+0.02);
	}
      }
    }

    if (t=="center") {
      intersection() {
	if (vertical) {
	  hull() {
	    translate([-connectorwidth+connectorendnarrowing+tolerance,connectorendnarrowing,connectorposition+connectorendnarrowing+tolerance-0.01]) rotate([90,0,0]) male(connectorwidth-connectorendnarrowing,connectordepth-connectorendnarrowing*2-tolerance*2,connectorendnarrowing);
	    translate([-connectorwidth+tolerance,totaldepth+tolerance,connectorposition+tolerance-0.01]) rotate([90,0,0]) male(connectorwidth,connectordepth-tolerance*2,totaldepth-connectorendnarrowing*2+tolerance);
	  }
	} else {
	  translate([-connectorwidth+tolerance,connectorposition+tolerance,0]) male(connectorwidth+0.01,connectordepth-tolerance*2,thickness);
	}
	
	translate([-connectorwidth,totaldepth,0]) rotate([0,0,-90]) union() {
	  triangle(slopedepth,l,thickness,0);
	  translate([slopedepth,0,0]) cube([connectorwidth+0.01,flat+0.01,thickness]);
	}
      }
    }
    
    if (t=="right") {
      intersection() {
	if (vertical) {
	  //translate([-connectorwidth+tolerance,totaldepth+tolerance,connectorposition+tolerance-0.01]) rotate([90,0,0]) male(connectorwidth,connectordepth-tolerance*2,totaldepth+tolerance);
	  hull() {
	    translate([-connectorwidth+connectorendnarrowing+tolerance,connectorendnarrowing,connectorposition+connectorendnarrowing+tolerance-0.01]) rotate([90,0,0]) male(connectorwidth-connectorendnarrowing,connectordepth-connectorendnarrowing*2-tolerance*2,connectorendnarrowing);
	    translate([-connectorwidth+tolerance,totaldepth+tolerance,connectorposition+tolerance-0.01]) rotate([90,0,0]) male(connectorwidth,connectordepth-tolerance*2,totaldepth-connectorendnarrowing*2+tolerance);
	  }
	} else {
	  translate([-connectorwidth+tolerance,connectorposition+tolerance,0]) male(connectorwidth+0.01,connectordepth-tolerance*2,thickness);
	}
	
	translate([-connectorwidth,totaldepth,0]) rotate([0,0,-90]) union() {
	  triangle(slopedepth,l,thickness,0);
	  translate([slopedepth,0,0]) cube([connectorwidth+0.01,flat+0.01,thickness]);
	}
      }
    }

  }
}

// 3 pieces, 33, 30, 33

if (final) rotate([0,0,vertical?90:0]) {
  i=0;

  sections=floor(maxwidth/printerwidth);
  
  totalsections=(sections*printerwidth < maxwidth)?sections+1:sections;
  
  sectionwidth=maxwidth/totalsections;

  partsonego=vertical ? floor(printerwidth/(thickness+1)) : floor(printerwidth/(totaldepth+1));

  
  echo("totalsections, sectionwidth, width, partsonego, totaldepth ", totalsections, sectionwidth, totalsections*sectionwidth, partsonego, totaldepth);

  if (vertical) {
    if ((thickness+1) * totalsections >= printerwidth) {
      echo("Printer too small to print all in one go, use printparts to get other parts");
    }
  } else {
    if ((totaldepth+1) * totalsections >= printerwidth) {
      echo("Printer too small to print all in one go, use printparts to get other parts");
    }
  }

  if (printparts==1) {
    if (vertical) rotate([90,0,0]) {
	lista("left",sectionwidth);
      } else {
      lista("left",sectionwidth);
    }
    if (vertical) {
	translate([0,(thickness+1)*1,0]) rotate([90,0,0]) lista("right",sectionwidth);
      } else {
      translate([0,(totaldepth+1)*1,0]) lista("right",sectionwidth);
    }
  }
  
  for (i=[2:1:totalsections-1]) {
    echo("i ",i);
    if (i >= (printparts-1)*partsonego && i < printparts*partsonego) {
      if (vertical) {
	translate([0,(thickness+1)*i,0]) rotate([90,0,0]) lista("center",sectionwidth);
      } else {
	translate([0,(totaldepth+1)*i,0]) lista("center",sectionwidth);
      }
    }
  }
} else {
  if (vertical) {
    rotate([90,0,0]) lista("right",10);
  } else {
    lista("right",10);
  }

  if (vertical) {
    translate([0,thickness+1,0]) rotate([90,0,0]) lista("center",20);
  } else {
    translate([0,totaldepth+1,0]) lista("center",20);
  }

  if (vertical) {
    translate([0,(thickness+1)*2,0]) rotate([90,0,0]) lista("left",20);
  } else {
    translate([0,(totaldepth+1)*2,0]) lista("left",20);
  }
 }
