// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

print=0;
debug=0;

tekstit=["Baari toimii nyyttikestiperiaatteella. ",
	 "Mikäli otat tästä, osallistu valikoiman ",
	 "täydentämiseen vastaavasti ",
	 "laadukkailla juomilla!"];
textsize=10;
textthickness=0.2; // two layers?
textgap=textsize/2;
edgew=2;
kylttithickness=1.6;
edgethickness=kylttithickness+0.4;
angle=45;
xtolerance=0.25;
ytolerance=0.25;
ztolerance=0.25;

shelfthickness=17.3;

kylttimargin=5;

cornerd=1;
kyltticornerd=10;

// Returns string length in mm
//function textlengthmm(t) = textmetrics(t).size[0];


tekstilen=[for (x=tekstit) textmetrics(x,font="Liberation Sans:style=Bold",size=textsize).size[0]];
rows=len(tekstit);
textboxheight=rows*textsize+(rows-1)*textgap;
kylttiwidth=edgew+kylttimargin+max(tekstilen)+kylttimargin+edgew;
					     kylttiheight=edgew+kylttimargin+textboxheight+kylttimargin+edgew;

basewidth=kylttiwidth-kyltticornerd;
basethickness=1.6;
basewall=2;
baseattachthickness=kylttithickness/2;
baseheight=kylttithickness;
attachsink=0.5;
attachheight=basethickness-attachsink;

backh=sin(angle)*kylttiheight-attachheight;
		
// +sin(angle)*basewall
basedepth=edgethickness+max(cos(angle)*(kylttiheight),kylttiheight/2);

module kyltti(showtext) {
  difference() {
    roundedboxxyz(kylttiwidth,kylttiheight,edgethickness,kyltticornerd+edgew,cornerd,1,30);
    translate([edgew,edgew,kylttithickness]) roundedboxxyz(kylttiwidth-edgew*2,kylttiheight-edgew*2,kylttithickness,kyltticornerd-edgew,0,0,30);

    if (showtext) {
      for (i=[0:1:rows-1]) {
	translate([edgew+kylttiwidth/2,edgew+kylttimargin+textsize/2+(rows-i-1)*textsize+(rows-i-1)*textgap,textthickness]) linear_extrude(kylttithickness-textthickness+0.02) text(text=tekstit[i],font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
      }
    }
    
    translate([kyltticornerd/2-xtolerance,-0.01,baseattachthickness]) cube([basewidth+xtolerance*2,edgew+ytolerance+0.01,edgethickness+0.02-baseattachthickness]);
  }
}

module base() {
  difference() {
    union() {
      translate([kyltticornerd/2,0,0]) roundedbox(basewidth,basedepth,basethickness,cornerd);

      hull() {
		translate([kyltticornerd/2,0,0]) roundedbox(basewidth,edgew-baseattachthickness-sin(angle)*ztolerance,attachheight+baseheight-cornerd/2,cornerd);
	//#	translate([kyltticornerd/2,0,0]) roundedbox(basewidth,edgew-baseattachthickness-sin(angle)*ztolerance,basethickness,cornerd);
	//	translate([kyltticornerd/2,0,attachheight+cos(angle)-cornerd/2]) roundedbox(basewidth,edgew-baseattachthickness-sin(angle)*ztolerance,cornerd,cornerd);
      }
  
      hull() {
	translate([kyltticornerd/2,0,attachheight+cos(angle)-cornerd/2]) roundedbox(basewidth,edgew-baseattachthickness-sin(angle)*ztolerance,cornerd,cornerd);
	translate([0,edgethickness,attachheight]) rotate([angle,0,0]) translate([kyltticornerd/2,0,baseattachthickness+sin(angle)*ztolerance]) cube([basewidth,edgew+0.01,edgethickness-baseattachthickness-sin(angle)*ztolerance]);
      }

      for (x=[kyltticornerd/2,kylttiwidth-kyltticornerd/2-basewall]) {
	hull() {
	  translate([x,basewall,0]) roundedbox(basewall,basedepth,basethickness-basewall,cornerd);
	  translate([x,basedepth-basewall,backh-basethickness]) roundedbox(basewall,basewall,basethickness,cornerd);
	}
	hull() {
	  translate([x,basewall+attachheight,0]) roundedbox(basewall,basedepth-basewall-attachheight,basewall,cornerd);
	  translate([x,basedepth-basewall,0]) roundedbox(basewall,basewall,backh,cornerd);
	  translate([x,basewall,attachheight]) rotate([angle,0,0]) translate([0,basewall-cos(angle)*basewall,-basewall-ztolerance]) roundedbox(basewall,cornerd,basewall,cornerd);
	}
	hull() {
	  translate([x,basewall,attachheight]) rotate([angle,0,0]) translate([0,kylttiheight-cornerd,-basewall-ztolerance]) roundedbox(basewall,cornerd,basewall,cornerd);
	  translate([x,basewall,attachheight]) rotate([angle,0,0]) translate([0,basewall-cos(angle)*basewall,-basewall-ztolerance]) roundedbox(basewall,cornerd,basewall,cornerd);
	}
      }

      translate([kyltticornerd/2,basedepth-basewall,0]) roundedbox(basewidth,basewall,backh,cornerd);
      hull() {
	translate([kyltticornerd/2,basedepth-basewall,backh-basewall]) roundedbox(basewidth,basewall,basewall,cornerd);
	translate([kyltticornerd/2,basewall,attachheight]) rotate([angle,0,0]) translate([0,kylttiheight-cornerd,-basewall-ztolerance]) roundedbox(basewidth,cornerd,basewall,cornerd);
      }
    }

    translate([0,edgethickness,attachheight]) rotate([angle,0,0]) translate([-xtolerance/2,-ytolerance/2,-ztolerance/2]) scale([1,1.1,1.1]) kyltti(0);
    translate([0,edgethickness,attachheight]) rotate([angle,0,0]) translate([-xtolerance/2,-ytolerance/2,-ztolerance/2+ztolerance]) scale([1,1.1,1.1]) kyltti(0);
    
    translate([kyltticornerd/2,basedepth-basewall-0.6,0]) lighten(basewidth,attachheight+sin(angle)*kylttiheight,basewall,5,7,10,"up");
  }
}

if (print==0) {
  intersection() {
    union() {
      translate([0,edgethickness,attachheight]) rotate([angle,0,0]) kyltti(1);
      base();
    }

    if (debug)     translate([kyltticornerd/2+1,0,0]) cube([kylttiwidth-14,kylttiheight+100,kylttiheight]);
  }
 }

if (print==1) 
  translate([kylttiheight/sqrt(2),0,0]) rotate([0,0,45]) kyltti(1);

if (print==2)
  translate([kylttiheight/sqrt(2),0,0]) rotate([0,0,45]) base();

  
