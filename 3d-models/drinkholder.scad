// Copyright 2026 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=0;

canh=68; // This is holder height, not actual can height
cand=68; // Slightly less, allow tolarance;

based=140;

holderwall=5; // Some fill to insulate.

holderbasewall=2;

holdertaperh=10;

versiontext="1.0";
brandtext="Drinkholder";
fulltext=str(brandtext," ",versiontext);
textdepth=0.7;
textsize=8;
textfont="Liberation Sans:style=Bold";

//function stable(t) = 
module cylindertext(text=t,d=cand+holderwall*2,textdepth=textdepth,textsize=textsize,font=textfont) {
  len=textlen(text,textsize,textfont);
  averagew=len/len(text);
  angle=360*(len/(3.14159*d/2));
  //echo(len,3.14159*d/2,angle);

  if (len(text) > 0) {
    rotate([0,0,-angle/2]) {
      ltable=[for (c=text) [c,textmetrics(c,size=textsize,font=textfont)]];
      
      cumulativeltable=[for (s="",l=0,i=0; i<len(ltable); s=str(s,ltable[i][0]),l=l+ltable[i][1].position[0]+ltable[i][1].advance[0],i=i+1) [ltable[i][0],l,ltable[i][1]] ];

      echo(cumulativeltable);
      for (sl=cumulativeltable) {
	a=360*(sl[1]/(3.14159*d));
	wa=0;//360*(sl[2]/(3.14159*d));
	echo("a ",a," c ",sl[0]," position ",sl[2].position[0]," advance ", sl[2].advance[0], " width ",sl[2].size[0]," cumulativewidth ",sl[1]," char width angle ",wa," angle ",a-wa/2);
	rotate([0,0,a]) {//-wa/2
	  //translate([d/2-1,-averagew/2,-1]) cube([1,sl[2].size[0],1]);
	  translate([d/2-textdepth+0.01,-sl[2].position[0]-averagew/2,0]) rotate([90,0,90]) linear_extrude(textdepth) text(sl[0],size=textsize,font=textfont,valign="baseline",halign="left");
	}
      }
    }
  }
}

module drinkholder() {
  difference() {
    union() {
      rotate_extrude($fn=90) {
	hull() {
	  translate([cand/2+holderwall/2,holderwall/2,holderwall]) circle(d=holderwall,$fn=90);
	  translate([cand/2+holderwall/2,holderwall+canh-holderwall/2,holderwall]) circle(d=holderwall,$fn=90);
	}
      }
      hull() {
	cylinder(d=cand+holderwall*2,h=holderwall,$fn=90);
	roundedcylinder(based,holderbasewall,holderbasewall,1,180);
      }
    }
    
    //translate([0,0,holderwall]) roundedcylinder(cand,canh+holderwall/2,holderwall,1,90);
    //hull() {
    //translate([0,0,holderwall+canh-holdertaperh]) cylinder(roundedcylinder(cand,holderwall/2,holderwall,1,90);
    //}

    translate([0,textsize/2+1,holderwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) text(text=brandtext,size=textsize,font=textfont,valign="center",halign="center");
    translate([0,-textsize/2-1,holderwall-textdepth+0.01]) rotate([0,0,0]) linear_extrude(textdepth) text(text=versiontext,size=textsize,font=textfont,valign="center",halign="center");
    translate([0,0,textdepth-0.01]) rotate([180,0,0]) linear_extrude(textdepth) text(text=fulltext,size=textsize,font=textfont,valign="center",halign="center");

    translate([0,0,holderwall+canh/2]) cylindertext(text=fulltext,d=cand+holderwall*2,textsize=textsize,font=textfont);
  }
}

if (print==0) {
  intersection() {
    if (debug) translate([0,0,0]) cube([1000,1000,1000]);
  
    drinkholder();
  }
 }

