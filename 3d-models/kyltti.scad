// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

include <hsu.scad>

tekstit=["Älä sammuta valoja jos","pyykkikone on tyhjentämättä!"];
textsize=10;
textthickness=0.2; // two layers?
textgap=textsize/5;
edgew=2;
kylttithickness=1.6;
edgethickness=kylttithickness+0.4;

kylttimargin=5;

cornerd=1;
kyltticornerd=10;

// Returns string length in mm
//function textlengthmm(t) = textmetrics(t).size[0];

//					 echo(max(textlengthmm(tekstit)));

tekstilen=[for (x=tekstit) textmetrics(x,font="Liberation Sans:style=Bold",size=textsize).size[0]];

module kyltti() {
  rows=len(tekstit);
  textboxheight=rows*textsize+(rows-1)*textgap;
  kylttiwidth=edgew+kylttimargin+max(tekstilen)+kylttimargin+edgew;
  kylttiheight=edgew+kylttimargin+textboxheight+kylttimargin+edgew+textsize;

  difference() {
    roundedboxxyz(kylttiwidth,kylttiheight,edgethickness,kyltticornerd+edgew,cornerd,1,30);
    translate([edgew,edgew,kylttithickness]) roundedboxxyz(kylttiwidth-edgew*2,kylttiheight-edgew*2,kylttithickness,kyltticornerd-edgew,0,0,30);
  
    for (i=[0:1:rows-1]) {
      translate([edgew+kylttiwidth/2,edgew+kylttimargin+textsize/2+(rows-i-1)*(textsize*textgap),textthickness]) linear_extrude(kylttithickness-textthickness+0.02) text(text=tekstit[i],font="Liberation Sans:style=Bold",size=textsize,valign="center",halign="center");
    }
  }
}

kyltti();


