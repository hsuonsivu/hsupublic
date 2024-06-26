// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

versiontext="V 1.1";

// This can only adjust all dimensions
maxcubes=10;
// Make holes to speed up printing and save material
cutaways=1;
// How deep text is cut
textdepth=0.8;
// Add vertical support every vdistance cubes
vdistance=8;

xcubes=maxcubes;
ycubes=maxcubes;
zcubes=maxcubes;

xmax=xcubes*10;
ymax=ycubes*10;
zmax=zcubes*10;
allmax=maxcubes*10;
textbox=8;
textboxnarrow=5;
textboxw=8;

module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
}

module cutouts() {
  union() {
    if (cutaways) {
      // Vertical support every vdistance cubes
      for (i=[0:vdistance:maxcubes-(vdistance-3)]) {
	cubes=min(vdistance-1,maxcubes-i-vdistance+4);//  min(1,(maxcubes-i-vdistance-2));

	xposition=0;
	yposition=max(10,i*10+10);
	zposition=max(maxcubes-i-vdistance-2,1)*10;
	//zposition=(maxcubes-i-vdistance-2)*10; //maxcubes*10-i*10-(vdistance*10+20);
	  
	ys=cubes*10;
	xs=10;
	zs=cubes*10;
	  
	// Triangle cut to upper part
	translate([xposition-0.01,yposition,zposition]) translate([0,cubes*10,0]) mirror([0,1,0]) prism(xs+0.02,ys,zs);
	// Cube cut to lower part
	if (zposition-10 > 0) translate([xposition-0.01,yposition,10]) cube([10.02,ys,zposition-10+0.01]);
      }
    }
  }
}

difference() {
  union() {
    y=0;
    for (x=[0:10:xmax-10]) {
      for (z=[0:10:xmax-10-x]) {
	translate([x,y,z]) cube([10,10,10]);
      }
    }

    x=0;
    for (y=[0:10:ymax-10]) {
      for (z=[0:10:zmax-10-y]) {
	translate([x,y,z]) cube([10,10,10]);
      }
    }
  }

#  translate([10.01-textdepth,11,1.5]) rotate([90,0,90]) linear_extrude(height=textdepth) text(versiontext, size=7);
  
  translate([textdepth-0.01,9,1]) rotate([90,0,270]) linear_extrude(height=textdepth) resize([textbox,0,0]) text("=Y", size=7);
  for(i=[10:10:zmax-10]) {
    translate([textdepth-0.01,5,i+1]) rotate([90,0,270]) linear_extrude(height=textdepth) resize([i<90?textboxnarrow:textbox,textbox,textbox]) text(str(i/10+1), size=textbox,halign="center");
  }
  for(i=[0:10:zmax-10]) {
    translate([5,ymax-i-textdepth+0.01,i+1]) rotate([90,0,180]) linear_extrude(height=textdepth) resize([i<90?textboxnarrow:textbox,textbox,textbox]) text(str(i/10+1), size=textbox,halign="center");
    translate([xmax-i-textdepth+0.01,5,i+1]) rotate([90,0,90]) linear_extrude(height=textdepth) resize([i<90?textboxnarrow:textbox,textbox,textbox]) text(str(i/10+1), size=textbox,halign="center");
  }
  

  for(i=[10:10:ymax-10]) {
    translate([textdepth-0.01,i+5,1]) rotate([90,0,270]) linear_extrude(height=textdepth) resize([i<90?textboxnarrow:textbox,textbox,textbox]) text(str(i/10+1), size=textbox,halign="center");
  }

  for(i=[10:10:zmax-10]) {
    translate([5,textdepth-0.01,i+1]) rotate([90,0,0]) linear_extrude(height=textdepth) resize([i<90?textboxnarrow:textbox,textbox,textbox]) text(str(i/10+1), size=textbox,halign="center");

  }

  translate([0.75,textdepth-0.01,1]) rotate([90,0,0]) linear_extrude(height=textdepth) resize([textbox,0,0]) text("X=", size=7);
  for(i=[10:10:xmax-10]) {
    translate([i+5,textdepth-0.01,1]) rotate([90,0,0]) linear_extrude(height=textdepth) resize([i<90?textboxnarrow:textbox,textbox,textbox]) text(str(i/10+1), size=textbox,halign="center");

  }
 translate([0.5,4.5,zmax-textdepth+0.01]) rotate([0,0,270+45]) linear_extrude(height=textdepth) text("z", size=9);

  for(i=[10:10:allmax-10]) {
    if (cutaways) {
      translate([-0.01,1,i-0.25]) cube([0.5,8,0.5]);
      translate([-0.01,i-0.25,1]) cube([0.5,0.5,8]);

      translate([1,-0.01,i-0.25]) cube([8,0.5,0.5]);
      if (i < allmax-10) translate([i-10+1,-0.01,allmax-10-0.25-i]) cube([18,0.5,0.5]);

      if (i < allmax-10) translate([i-0.25,-0.01,allmax-10-9-i]) cube([0.5,0.5,18]);

      translate([i-0.25,-0.01,1]) cube([0.5,0.5,8]);
      if (i < allmax-10) translate([-0.01,i-0.25,allmax-10-9-i]) cube([0.5,0.5,18]);
    
      if (i < allmax-10) translate([-0.01,i-9,allmax-10-0.25-i]) cube([0.5,18,0.5]);
    } else {
      translate([-0.01,1,i-0.25]) cube([0.5,allmax-10-i+8,0.5]);
      translate([-0.01,i-0.25,1]) cube([0.5,0.5,allmax-10-i+8]);
      translate([1,-0.01,i-0.25]) cube([allmax-10-i+8,0.5,0.5]);
      translate([i-0.25,-0.01,1]) cube([0.5,0.5,allmax-10-i+8]);
      if (i < allmax-10) translate([-0.01,i-0.25,allmax-10-9-i]) cube([0.5,0.5,18]);
    
      if (i < allmax-10) translate([-0.01,i-9,allmax-10-0.25-i]) cube([0.5,18,0.5]);
    }
  }

cutouts();
mirror([1,-1,0]) cutouts();
}

