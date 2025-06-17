include <porygon/Porygon.scad>
include <hsu.scad>

print=2; // 1=porygon, 2=kivinenplate

diameter=70;
height=80+diameter/2;
thickness=2;
tukiw=diameter/6;
tukih=20;

textsize=8;
textdepth=0.7;

tolerance=0.25;

anglebetween=1;

cornerd=1;

s=0.7;

f="Liberation Sans:style=Bold";

function textwidth(text,f,fontsize) = let(tm=textmetrics(text,font=f,size=fontsize))
  tm.size[0];

module arc_text_r(radius, chars, i, fontsize, previousangle,below) {
  PI = 3.14159;
  circumference = 2 * PI * radius;
  tm=textmetrics(text=chars[i],font=f,size=fontsize,valign="top",halign="center");
  charwidth=tm.size[0];
  //step_angle = radius / (0.5*fontsize + radius)  / circumference * 360 * charwidth - 0.30+anglebetween;
  step_angle = 1 / circumference * 360 * charwidth - 0.30+anglebetween;
  //  echo(step_angle, chars[i], previousangle);
  rotate(previousangle-step_angle/2) {
    translate([0, radius + (below?fontsize:0), 0]) rotate([0,0,below?180:0]) {
      text(
	   chars[i], 
	   font = f, 
	   size = fontsize, 
	   valign = "bottom", halign = "center"
	   );
    }
  }
  if (chars[i+(below?-1:1)]) arc_text_r(radius, chars, i+(below?-1:1), fontsize, previousangle-step_angle,below);
}

function textangle(radius,text,i,font,fontsize) = (1/(2*3.14159*radius)*360*textwidth(text[i],f,fontsize))+(text[i+1]?textangle(radius,text,i+1,font,fontsize):0);

module arc_text(radius, chars, fontsize, angle,below) {
  textangle=textangle(radius,chars,0,f,fontsize)/2;
  echo(textangle(radius,chars,0,f,fontsize));
  arc_text_r(radius,chars,below?len(chars):0,fontsize,angle+textangle,below);
}

module kivinentexts() {
    translate([0,0,0]) rotate([0,0,90]) linear_extrude(textdepth) text("57",font=f,size=diameter/3,valign="center",halign="center");
    translate([0,0,0]) linear_extrude(textdepth) arc_text(diameter/2-diameter/6-1,"Tero",diameter/7,90,0);
    translate([0,0,0]) linear_extrude(textdepth) arc_text(diameter/2-diameter/6-1,"Kivinen",diameter/7,90+180,1);
}

module kivinen57() {
  difference() {
    union() {
      roundedcylinder(diameter,thickness,cornerd,1,90);
      translate([0,-tukiw/2,0]) roundedbox(diameter/2+tukih,tukiw,thickness,cornerd,1);
    }
    translate([0,0,thickness-textdepth+0.01]) kivinentexts();
    translate([0,0,-0.01]) mirror([0,1,0]) kivinentexts();
  }
}

module porygonwithcut() {
  difference() {
    porygon();
    translate([-thickness/2-tolerance,-tukiw/2-tolerance,height-diameter/2-tukih-tolerance]) cube([thickness+tolerance*2,tukiw+tolerance*2,diameter/2+tukih+tolerance*2]);
  }
}

if (print==0) {
  scale([s,s,s]) {
    porygonwithcut();
    translate([-thickness/2,0,height]) rotate([0,90,0]) kivinen57();
  }
 }

if (print==1) {
  scale([s,s,s]) porygonwithcut();
 }

if (print==2) {
  scale([s,s,s]) kivinen57();
 }

if (print==3) {
  scale([s,s,s]) porygon();
 }
