tubeoutsidediameter=25.2;
tubeinsidediameter=22;
outsidediameter=tubeoutsidediameter+5;
lowerheight=100;
upperheight=100;
bottomheight=10;
tubebottom=5;
flatheight=80;
heightadjustdiameter=60;
heightadjustheight=10;
heightadjustnarrow=10;
totalheight=lowerheight+upperheight+bottomheight;
ploughdistance=50;

$fn=90;
  
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

rotate([180,0,0]) difference() {
  union() {
    //translate([0,0,totalheight-flatheight]) cylinder(d=heightadjustdiameter,h=heightadjustheight);
    //translate([0,0,totalheight-flatheight+heightadjustnarrow-0.01]) cylinder(d2=outsidediameter,d1=heightadjustdiameter,h=heightadjustnarrow);
    
    hull() {
      cylinder(d=outsidediameter,h=upperheight);
      translate([0,0,upperheight-0.01]) cylinder(h=lowerheight,d=outsidediameter);
      translate([outsidediameter/2,0,upperheight-0.01]) cylinder(h=lowerheight,d=outsidediameter);
      translate([-outsidediameter,0.01,lowerheight-0.01]) triangle(outsidediameter,outsidediameter/2,lowerheight,6);
      translate([-outsidediameter,-outsidediameter/2-0.01,lowerheight-0.01]) triangle(outsidediameter,outsidediameter/2,lowerheight,4);
    }
    hull() {
      translate([-outsidediameter,0.01,lowerheight+upperheight-flatheight-0.01]) triangle(outsidediameter,outsidediameter/2,1,6);
      translate([-outsidediameter,-outsidediameter/2-0.01,lowerheight+upperheight-flatheight-0.01]) triangle(outsidediameter,outsidediameter/2,1,4);
      translate([-outsidediameter-ploughdistance,0.01,lowerheight+upperheight-1-0.01]) triangle(outsidediameter+ploughdistance,outsidediameter/2,1,6);
      translate([-outsidediameter-ploughdistance,-outsidediameter/2-0.01,lowerheight+upperheight-1-0.01]) triangle(outsidediameter+ploughdistance,outsidediameter/2,1,4);
    }
  }

  translate([0,0,-0.01]) cylinder(d=tubeoutsidediameter,h=upperheight);
translate([0,0,upperheight-0.02]) cylinder(d=tubeinsidediameter,h=lowerheight);
  hull() {
    translate([0,0,upperheight+tubebottom]) cylinder(d=tubeinsidediameter,h=lowerheight+bottomheight);
    translate([outsidediameter,0,upperheight+tubebottom+30]) cylinder(d=tubeinsidediameter,h=lowerheight+bottomheight);
  }
}

