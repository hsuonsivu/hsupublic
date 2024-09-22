// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

debug=0;

include <hsu.scad>

print=2;

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
bedsizey=300;

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
ztolerance=0.5;//0.4;
xtolerance=0.4;//.4;
ytolerance=0.4;//0.4;
cornerd=0.5;
wall=1.5;

module roundedbox(x,y,z,c) {
  cube([x,y,z]);
}

// Holder for name plates
nametagsidespace=1+xtolerance+wall;
holderbase=1;
holderbasetop=backthickness+1.5*ztolerance;
  
labeltotalheight=fontsize+labelheightextra+backheight;

versiontext="Guest nametags   v1.1";
versiontextdepth=0.6;
versiontextsize=backheight-3;

// Angle for label holder
angle=-14;//8; // -11
nametagdistance=(fontsize+labelheightextra++1)*cos(angle);;
yangled=-cos(angle)*(labeltotalheight+holderbase);
		   zangled=sin(angle)*(labeltotalheight+holderbase);

				     holderbaseh=zangled;
  
between=0.5;

ruuvid=3.5;
ruuvitornid=3*ruuvid;
ruuvilength=30;
ruuvidistance=bedsize/1.5;
maxrows=floor(bedsizey/nametagdistance)-1;
maxheight=(maxrows+1)*nametagdistance+backheight+1;

// Holder for unallocated name tags

module nametag(t, w) {

  difference() {
    union() {
      roundedbox(w,fontsize+labelheightextra,thickness,cornerd);
      translate([backnarrowing,fontsize,0]) cube([w-2*backnarrowing,backheight+labelheightextra,backthickness]);
    }

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,thickness-textdepth+0.01]) rotate([0,0,180]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,halign="center");
  }
}

module nametagb(t, w) {
  difference() {
    union() {
      roundedbox(w,fontsize+labelheightextra,thickness,cornerd);
      translate([backnarrowing,fontsize,0]) cube([w-2*backnarrowing,backheight+labelheightextra,backthickness]);
    }

    translate([w/2,fontsize+labelheightextra-labelheightextra/2-textoffset,thickness-textdepth+0.01]) rotate([0,0,0]) linear_extrude(height=textdepth) text(text=t,font="Liberation Sans:style=Bold",size=fontsize,valign="bottom", halign="center");
  }
}

module r(tekstit,x,y,i) {
  charm=search("m", tekstit[i], 0);
  charM=search("M", tekstit[i], 0);
  widechars=len(charm[0]) + len(charM[0]); 
  chari=search("i", tekstit[i], 0);
  charI=search("I", tekstit[i], 0);
  charl=search("l", tekstit[i], 0);
  narrowchars=len(chari[0]) + len(charI[0]) + len(charl[0]);
  normalchars = len(tekstit[i]) - widechars - narrowchars;
  
  width=normalchars*fontsize*fontwidthmultiplier + widechars * fontsize * fontwidthmultiplier * widecharmultiplier + narrowchars * fontsize * fontwidthmultiplier * narrowcharmultiplier + labelwidthextra;
  
  newx = (x + width + 1 > bedx) ? 0 : x;
  newy = (x + width + 1 > bedx) ? y+fontsize+labelheightextra+backheight+1 : y;

  translate([newx,newy,0]) nametag(tekstit[i],width);

  if (tekstit[i+1] != "") {
    xoffset = width;
    r(tekstit,newx+xoffset+1,newy,i+1);
  }
}

module labelholder() {
  difference() {
    union() {
      for (i=[0:1:maxrows]) {
	difference() {
	  union() {
    
	    translate([0,i*nametagdistance,0]) rotate([angle,0,0]) {
	      difference() {
		union() {
		  roundedbox(bedsize,labeltotalheight+holderbase,backthickness,cornerd);
		  translate([0,labeltotalheight,0]) roundedbox(bedsize,holderbase,backthickness+holderbasetop+backthickness+ztolerance,cornerd);
		  translate([0,labeltotalheight-backheight+holderbase,backthickness+holderbasetop+ztolerance]) roundedbox(bedsize,backheight,backthickness,cornerd);
		}
	      }
	    }

	    hull() {
	      translate([0,i*nametagdistance,0]) rotate([angle,0,0]) translate([0,0,backthickness+ztolerance]) {
		translate([0,labeltotalheight,0]) roundedbox(bedsize,holderbase,backthickness+holderbasetop,cornerd);
	      }
	      translate([0,i*nametagdistance+cos(angle)*labeltotalheight-sin(angle)*(backthickness+holderbasetop),zangled]) roundedbox(bedsize,holderbase,backthickness,cornerd);
	    }
	  }
	}

	# if (debug) translate([2*wall,i*nametagdistance,0]) rotate([angle,0,0]) translate([0,0,backthickness+ztolerance]) nametag(tekstit[0],100);
	translate([0,i*nametagdistance,zangled]) roundedbox(bedsize,labeltotalheight+holderbase,backthickness,cornerd);
      }
    }
    translate([0,maxrows*nametagdistance,0]) rotate([angle,0,0]) {
    translate([bedsize/2,labeltotalheight-versiontextsize/2,3*backthickness+holderbasetop-ztolerance-versiontextdepth+0.01]) rotate([180,180,0]) linear_extrude(height=versiontextdepth) text(text=versiontext,font="Liberation Sans:style=Bold",size=versiontextsize,valign="center", halign="center");
    }
  }

  if (!debug) {
    for (x=[-wall*2,bedsize+wall]) translate([x,0,zangled]) {
	hull() {
	  roundedbox(wall,maxheight,-zangled+cornerd+wall,cornerd);
	  translate([(x==-wall*2)?2*wall:-2*wall,0,0]) roundedbox(wall,maxheight,-zangled+cornerd-wall,cornerd);
	}
      }
  }

  difference() {
    hull() {
      translate([0,0,zangled]) roundedbox(bedsize,holderbase,-zangled+cornerd,cornerd);

      for (x=[bedsize/2-ruuvidistance/2,bedsize/2+ruuvidistance/2]) {
	translate([x,-ruuvitornid/2,zangled]) cylinder(h=-zangled+cornerd,d=ruuvitornid);
      }
    }

    for (x=[bedsize/2-ruuvidistance/2,bedsize/2+ruuvidistance/2]) {
      translate([x,-ruuvitornid/2,+cornerd-ruuvilength+0.01]) ruuvireika(ruuvilength,ruuvid,1,1);
    }
    
    textsize=ruuvitornid-ruuvid; // -1
    translate([bedsize/2,-textsize/2-2,cornerd-textdepth+0.01]) rotate([180,180,0]) linear_extrude(height=textdepth) text(text="NAME TAGS",font="Liberation Sans:style=Bold",size=textsize,valign="center", halign="center");
  }
}

if (print==1) {
  r(tekstit,0,0,0);
 }

if (print==2) {
  translate([0,0,bedsize]) rotate([0,90,0])
  labelholder();
 }

	  
