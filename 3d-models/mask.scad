// Copyright 2023 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

eyedistance=80;
eyewidth=22;
noseheight=-5;
$fn=30;
korkeus1=1.4;
korkeus2=1.4;
fullkorkeus=0.2;
attachmentheight=1;
attachmentdiameter=6;
attachmentholediameter=3;
attachmentx=90.5;
attachmenty=3;
diameter=0.8;
leaflength=20;
leafwidth=10;
distance=10;
//connectheight=(korkeus1+korkeus2)/4;
connectheight=0.2;
stringh=0.6;
stringw=0.6;

points1=[[0,0],[3.5,6],[8,7],[12.5,6],[16,3],[20,0]];
points2=[[0,0],[20,0]];
points3=[[2,0],[3.5,6]];
points4=[[5.5,0],[8,7]];
points5=[[9.75,0],[12.5,6]];
points6=[[14,0],[16,3]];

leaftable=[[0,distance,90],
	   [distance/2,0,30],
	   [cos(30)*(leaflength+distance),sin(30)*leafwidth+distance/2-1,30],
	   [cos(30)*(leaflength+distance)+leaflength-1,sin(30)*leafwidth+distance/2+2,0],
	   [cos(30)*(leaflength+distance)+leaflength+leaflength+distance/2-2,sin(30)*leafwidth+distance/2-4,-10],
	   [distance/3,-10,-40],
	   [cos(-40)*(leaflength+distance)-2,-sin(-50)*leafwidth-35,0],
  [cos(-50)*(leaflength+distance)+leaflength+distance/2,-sin(-50)*leafwidth-35,10],
	   [cos(-50)*(leaflength+distance)+cos(10)*(leaflength+distance)+leaflength-3,-sin(-50)*leafwidth-35+sin(10)*leaflength+3,50],
	   ];

leafconnectpoint=[[0,0],    // 0 0
		  [3.5,6],  // 1
		  [3.5,-6], // 2
		  [8,7],    // 3 1
		  [8,-7],   // 4 2
		  [12.5,6], // 5
		  [12.5,-6],// 6
		  [16,3],   // 7
		  [16,-3],  // 8
		  [20,0]];  // 9 3

// first leaf, second leaf, contactpoint in first, contactpoint in second
leafconnect=[[0,1,0,0],
	     [0,1,0,3],
	     [0,1,1,1],
	     [0,1,2,3],
	     [0,1,4,5],
	     [1,2,9,0],
	     [1,2,8,0],
	     [1,2,7,1],
	     [1,2,8,2],
	     [1,2,6,2],
	     [0,2,4,1],
	     [0,2,6,3],
	     [2,3,4,2],
	     [2,3,6,0],
	     [2,3,8,1],
	     [2,3,8,0],
	     [2,3,9,3],
	     [3,4,9,1],
	     [3,4,9,0],
	     [3,4,8,0],
	     [3,4,6,0],
	     [3,4,7,1],
	     [3,4,6,2],
	     [0,5,0,0],
	     [1,5,0,0],
	     [1,5,0,1],
	     [1,5,2,1],
	     [1,5,4,3],
	     [5,6,9,0],
	     [5,6,8,0],
	     [5,6,9,1],
	     [5,6,5,3],
	     [5,6,7,1],
	     [6,7,9,0],
	     [6,7,5,3],
	     [6,7,7,1],
	     [6,7,8,0],
	     [6,7,6,2],
	     [7,8,9,2],
	     [7,8,3,3],
	     [7,8,5,1],
	     [7,8,7,0],
	     [7,8,9,0],
	     [8,4,3,2],
	     [8,4,5,4],
	     [8,4,7,4],
	     [8,4,7,6],
	     [8,4,9,6],
	     [8,4,9,8],
	     [8,4,8,8],
	     [8,4,6,9],
	     ];

module plotlines(points,height) {
  for(j=[0:1:len(points)-2]) {
    hull() {
      translate(points[j]) cylinder(h=height,d=diameter);
      translate(points[j+1]) cylinder(h=height,d=diameter);
    }
  }
}

module leafside() {
  hull() {
    plotlines(points1,fullkorkeus);
    plotlines(points2,fullkorkeus);
    plotlines(points3,fullkorkeus);
    plotlines(points4,fullkorkeus);
    plotlines(points5,fullkorkeus);
    plotlines(points6,fullkorkeus);
  }
  
  plotlines(points1,korkeus1);
  plotlines(points2,korkeus1);
  plotlines(points3,korkeus1);
  plotlines(points4,korkeus1);
  plotlines(points5,korkeus1);
  plotlines(points6,korkeus1);
}

module leaf(size,angle) {
  leafside();
  mirror([0,1,0]) leafside();
}

module maskside() {
  for (i=[0:1:len(leaftable)-1]) {
    //    echo("i ",i," x ",leaftable[i][0]," y ",leaftable[i][1]," a ",leaftable[i][2]);
    translate([leaftable[i][0],leaftable[i][1],0]) rotate([0,0,leaftable[i][2]]) color("red") leaf();
  }

  for (c=[0:1:len(leafconnect)-1]) {
    // first leaf
    hull() {
      translate([leaftable[leafconnect[c][0]][0],leaftable[leafconnect[c][0]][1],connectheight]) rotate([0,0,leaftable[leafconnect[c][0]][2]]) translate([+leafconnectpoint[leafconnect[c][2]][0],+leafconnectpoint[leafconnect[c][2]][1],0]) cylinder(h=stringh,d=stringw);
      // second leaf
  
      translate([leaftable[leafconnect[c][1]][0],leaftable[leafconnect[c][1]][1],connectheight]) rotate([0,0,leaftable[leafconnect[c][1]][2]]) translate([+leafconnectpoint[leafconnect[c][3]][0],+leafconnectpoint[leafconnect[c][3]][1],0]) cylinder(h=stringh,d=stringw);
    }
  }

  difference() {
    translate([attachmentx,attachmenty,0]) cylinder(h=attachmentheight,d=attachmentdiameter);
    translate([attachmentx,attachmenty,-0.01]) cylinder(h=attachmentheight+0.02,d=attachmentholediameter);
  }
}

maskside();
mirror([1,0,0]) maskside();
