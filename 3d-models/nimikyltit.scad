tekstit=["Juha",
	 "Timo",
	 "Matti",
	 "Kari",
	 "Mikko",
	 "Jari",
	 "Antti",
	 "Jukka",
	 "Mika",
	 "Markku",
	 "Pekka",
	 "Hannu",
	 "Heikki",
	 "Seppo",
	 "Janne",
	 "Ari",
	 "Sami",
	 "Ville",
	 "Marko",
	 "Petri",
	 "Tuula",
	 "Anne",
	 "Päivi",
	 "Anna",
	 "Ritva",
	 "Leena",
	 "Pirjo",
	 "Sari",
	 "Minna",
	 "Marja",
	 "Tiina",
	 "Riitta",
	 ""]; // End of list, do not remove it!

bedsize=220;
bedx=bedsize;
bedy=bedsize;

fontsize=10;
fontwidthmultiplier=0.72;
widecharmultiplier=1.4;
narrowcharmultiplier=0.8;
basewidth=15;
baselength=110;
textdepth=2;
backthickness=1;
backheight=8;
backnarrowing=1;
thickness=textdepth+backthickness;
labelwidthextra=10;
labelheightextra=5;
textoffset=1;

between=0.5;

module roundedbox(x,y,z) {
  smallcornerdiameter=1.5;
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

module nimikyltti(t, w) {
  //echo("text ", t, " w ", w);

  difference() {
    union() {
      roundedbox(w,fontsize+labelheightextra,thickness);
      translate([backnarrowing,fontsize,0]) cube([w-2*backnarrowing,backheight+labelheightextra,backthickness]);
    }

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,thickness-textdepth+0.01]) rotate([0,0,180]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,halign="center");
  }
}

//echo("0 ",tekstit[0], "1 ",tekstit[1], "2 ",tekstit[2]);
//echo(tekstit);
//echo(tekstit);

module r(tekstit,x,y,i) {
  charm=search("m", tekstit[i], 0);
  charM=search("M", tekstit[i], 0);
  widechars=len(charm[0]) + len(charM[0]); 
  echo("widechars ", widechars);
  chari=search("i", tekstit[i], 0);
  charI=search("I", tekstit[i], 0);
  charl=search("l", tekstit[i], 0);
  narrowchars=len(chari[0]) + len(charI[0]) + len(charl[0]);
  echo("narrowchars ", narrowchars);
  normalchars = len(tekstit[i]) - widechars - narrowchars;
  echo("t ", tekstit[i], " normalchars ", normalchars);
  
  width=normalchars*fontsize*fontwidthmultiplier + widechars * fontsize * fontwidthmultiplier * widecharmultiplier + narrowchars * fontsize * fontwidthmultiplier * narrowcharmultiplier + labelwidthextra;
  
  newx = (x + width + 1 > bedx) ? 0 : x;
  newy = (x + width + 1 > bedx) ? y+fontsize+labelheightextra+backheight+1 : y;

  echo("x ", newx, " y ", newy);
  translate([newx,newy,0]) nimikyltti(tekstit[i],width);

  if (tekstit[i+1] != "") {
    xoffset = width;
    r(tekstit,newx+xoffset+1,newy,i+1);
  }
}

r(tekstit,0,0,0);

	  
