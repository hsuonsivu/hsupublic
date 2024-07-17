// -*-mode: SCAD; coding: latin-1;-*-
// libmac.scad  -  Utility library for 3D mechanical design
// Copyright (c) 2021-2022 Sampo Kellomaki (sampo@iki.fi), All Rights Reserved.
// This is free software / designware. Licensed under Apache2 licence.
//
// 20210907 separated to file of its own --Sampo
// 20211227 added steam engine plumbing stuff --Sampo
// 20220121 robotics parts --Sampo
// 20220318 added rounded corner cube using hull() --Sampo
//
// Last Modified: 12:46 Oct 10 2022 sampo
// Version: 1.91
// Edit time: 216 min
//
// Modules in this library allow more compact and informative description
// of models, where things are called by their usual names instead of
// the openscad primitives, e.g. "L_bar" instead of union of two cubes()
// or "tube" instead of differences of two cylinders() or "hole" instead
// of cylinder().
//
// The modules also echo to console their dimensions. This output can be
// postprocessed (post processing perl script sold separately :-) to BOM.
//
// It is possible to annotate some modules with their dimensions by setting
// SHOW_DIM variable.

// use <libmac.scad>
// include <libmac.scad>  // alows you to have last say on variables
//use <fonts.scad>
//include <MCAD/fonts.scad>
//include <Arial.scad>
// fc-list -f "%-60{{%{family[0]}%{:style[0]=}}}%{file}\n" | sort
// text("OpenSCAD", font = "Liberation Sans:style=Bold Italic");

// Special prefix characters: !show only this, #red, %transparent, *do not show

//ROUNDING=0;    // Do not render roundings on cubes even if specified (faster)
ROUNDING=1;    // Render roundings on cubes if specified
//SHOW_DIM=20; // 0 to disable, otherwise specifies text size
SHOW_DIM=0;
SHOW_DIM_COLOR="black";
T_PIPEFLANGE=3;    // Thickness of pipe pressure flanges
//MATERIAL_WEIGHT=600;  // Mänty = 600 kg/m3
//MATERIAL_WEIGHT=2700;  // Al = 2700 kg/m3
MATERIAL_WEIGHT=7874;  // Fe = 7874 kg/m3
VERBOSE=0; // enable some debug prints

module diff() {  // *** does not work
  difference() children(0);
}

module T(x=0,y=0,z=0,rx=0,ry=0,rz=0) { translate([x,y,z]) rotate([rx,ry,rz]) children(0); }
module rot(x,y,z) {  rotate([x,y,z]) children(0); }  // deprecated, use T(,,,rx=a,ry=b,rz=c)
module rx(ang)  { rotate([ang,0,0]) children(0); }
module ry(ang)  { rotate([0,ang,0]) children(0); }
module rz(ang)  { rotate([0,0,ang]) children(0); }

module cubint(x,y,z,c="",roundtype=1,roundness=0) {  // for internal use where echoing BOM is not desired
  if (ROUNDING == 1 && roundness > 0) {
    if (roundtype == 1) {          // rounding only in xy corners (hull of cylinders)
      hull() {
	T((x-roundness)/2,(y-roundness)/2,0) cylinder(d=roundness,h=z, center=true);
	T(-(x-roundness)/2,(y-roundness)/2,0) cylinder(d=roundness,h=z, center=true);
	T((x-roundness)/2,-(y-roundness)/2,0) cylinder(d=roundness,h=z, center=true);
	T(-(x-roundness)/2,-(y-roundness)/2,0) cylinder(d=roundness,h=z, center=true);
      }
    } else if (roundtype == 2) {   // rounding in all corners (hull of spheres)
      hull() {
	T((x-roundness)/2,(y-roundness)/2,(z-roundness)/2) sphere(d=roundness);
	T(-(x-roundness)/2,(y-roundness)/2,(z-roundness)/2) sphere(d=roundness);
	T((x-roundness)/2,-(y-roundness)/2,(z-roundness)/2) sphere(d=roundness);
	T(-(x-roundness)/2,-(y-roundness)/2,(z-roundness)/2) sphere(d=roundness);
	T((x-roundness)/2,(y-roundness)/2,-(z-roundness)/2) sphere(d=roundness);
	T(-(x-roundness)/2,(y-roundness)/2,-(z-roundness)/2) sphere(d=roundness);
	T((x-roundness)/2,-(y-roundness)/2,-(z-roundness)/2) sphere(d=roundness);
	T(-(x-roundness)/2,-(y-roundness)/2,-(z-roundness)/2) sphere(d=roundness);
      }
    } else {
      cube([x,y,z], center=true);
    }
  } else {
    cube([x,y,z], center=true);
  }
}

module cub(x,y,z,comment="",mod_type="cub",roundtype=1,roundness=0) {
  material_volume_m3 = x*y*z/1000000000;
  weight_kg = material_volume_m3*MATERIAL_WEIGHT;
  if (VERBOSE) echo(mod_type,x,y,z,comment,material_volume_m3,weight_kg);
  cubint(x,y,z,comment,roundtype,roundness);
  if (SHOW_DIM) {
    if (z < x && z < y) {  // z smallest: use xy-face
      if (x < y) {
	lab = y > 400 ? str(x," x ",y," x ",z,", ",round(100*weight_kg)/100," kg") : (y > 200 ? str(x," x ",y," x ") : str(y));
	T(0,0,z/2+1,rz=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
      } else {
	lab = x > 400 ? str(x," x ",y," x ",z,", ",round(100*weight_kg)/100," kg") : (x > 200 ? str(x," x ",y," x ") : str(x));
	T(0,0,z/2+1,rx=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
	//T(x/2+1,0,0,ry=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
      }
    } else if (x < z && x < y) { // x smallest: use yz-face
      if (y < z) {
	lab = z > 400 ? str(x," x ",y," x ",z,", ",round(100*weight_kg)/100," kg") : (z > 200 ? str(x," x ",y," x ") : str(z));
	T(-x/2-1,0,0,ry=-90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
      } else {
	lab = y > 400 ? str(x," x ",y," x ",z,", ",round(100*weight_kg)/100," kg") : (y > 200 ? str(x," x ",y," x ") : str(y));
	T(x/2+1,0,rx=90,rz=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
      }
    } else {  // y smallest: use xz-face
      if (x < z) {
	lab = z > 400 ? str(x," x ",y," x ",z,", ",round(100*weight_kg)/100," kg") : (z > 200 ? str(x," x ",y," x ") : str(z));
	T(0,y/2+1,0,rx=-90,ry=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
      } else {
	lab = x > 400 ? str(x," x ",y," x ",z,", ",round(100*weight_kg)/100," kg") : (x > 200 ? str(x," x ",y," x ") : str(x));
	T(0,-y/2-1,0,rx=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
      }    
    }
  }
}

// sheet metal

module sheet(x,y,z,c="") {
  cub(x,y,z,c,"sheet");
}

// Bending sheet metal

MAXCUB=20000;

module bendx(yoff=0,xangle=90,maxcub=MAXCUB) {
  if (VERBOSE) echo("begin(bendx,",yoff,")");
  union() {
    rx(xangle) intersection() {
      T(0,maxcub/2,0) cubint(maxcub,maxcub,maxcub);
      T(0,yoff,0) children(0);
    }
    intersection() {
      T(0,-maxcub/2,0) cubint(maxcub,maxcub,maxcub);
      T(0,yoff,0) children(0);
    }
  }
  if (VERBOSE) echo("end(bendx)");
}

module bendy(xoff=0,yangle=90,maxcub=MAXCUB) {
  if (VERBOSE) echo("begin(bendy,",xoff,")");
  union() {
    ry(yangle) intersection() {
      T(maxcub/2,0,0) cubint(maxcub,maxcub,maxcub);
      T(xoff,0,0) children(0);
    }
    intersection() {
      T(-maxcub/2,0,0) cubint(maxcub,maxcub,maxcub);
      T(xoff,0,0) children(0);
    }
  }
  if (VERBOSE) echo("end(bendy)");
}

module bendyz(zoff=0,yangle=90,maxcub=MAXCUB) {
  if (VERBOSE) echo("begin(bendyz,",zoff,")");
  union() {
    ry(yangle) intersection() {
      T(0,0,maxcub/2) cubint(maxcub,maxcub,maxcub);
      T(0,0,zoff) children(0);
    }
    intersection() {
      T(0,0,-maxcub/2) cubint(maxcub,maxcub,maxcub);
      T(0,0,zoff) children(0);
    }
  }
  if (VERBOSE) echo("end(bendyz)");
}

module bendzx(xoff=0,zangle=90,maxcub=MAXCUB) {
  if (VERBOSE) echo("begin(bendzx,",xoff,")");
  union() {
    rz(zangle) intersection() {
      T(maxcub/2,0,0) cubint(maxcub,maxcub,maxcub);
      T(xoff,0,0) children(0);
    }
    intersection() {
      T(-maxcub/2,0,0) cubint(maxcub,maxcub,maxcub);
      T(xoff,0,0) children(0);
    }
  }
  if (VERBOSE) echo("end(bendzx)");
}

module bendzy(yoff=0,zangle=90,maxcub=MAXCUB) {
  if (VERBOSE) echo("begin(bendzy,",yoff,")");
  union() {
    rz(zangle) intersection() {
      T(0,maxcub/2,0) cubint(maxcub,maxcub,maxcub);
      T(0,yoff,0) children(0);
    }
    intersection() {
      T(0,-maxcub/2,0) cubint(maxcub,maxcub,maxcub);
      T(0,yoff,0) children(0);
    }
  }
  if (VERBOSE) echo("end(bendzy)");
}

module label(txt,colori="black",siz=5,ht=.5) {
     color(colori)
	  linear_extrude(height=ht) { text(txt, size=siz, halign="center", valign="center"); }
}

module label2(txt1,txt2,colori="black",siz=5,ht=.5) {
  T(0,siz*.7,0) label(txt1,colori,siz,ht);
  T(0,-siz*.7,0) label(txt2,colori,siz,ht);
}

module box(x,y,z,t=1) {  // hollow cube
  difference() {
    cubint(x,y,z);
    cubint(x-2*t,y-2*t,z-2*t);
  }
}

module bar(w,d,l,c="bar",roundtype=1,roundness=0)    { cub(w,d,l,c,"bar",roundtype,roundness); }
module barz(w,d,l,c="barz",roundtype=1,roundness=0)  { bar(w,d,l,c,roundtype,roundness); }
module barx(w,d,l,c="barx",roundtype=1,roundness=0)  { ry(90) bar(w,d,l,c,roundtype,roundness); }
module bary(w,d,l,c="bary",roundtype=1,roundness=0)  { rx(90) bar(w,d,l,c,roundtype,roundness); }

// lbar
module L_bar(w,d,l,t=1,c="L_bar")   {
  if (VERBOSE) echo("L_bar",w,d,l,t,c);
  T(0,w/2-t/2,0) cubint(w,t,l);
  T(d/2-t/2,0,0) cubint(t,d,l);
}
module L_barz(w,d,l,t=1,c="L_barz")  { L_bar(w,d,l,t,c); }
module L_barx(w,d,l,t=1,c="L_barx")  { ry(90) L_bar(w,d,l,t,c); }
module L_bary(w,d,l,t=1,c="L_bary")  { rx(90) L_bar(w,d,l,t,c); }

// tbar
module T_bar(w,d,l,t=1,c="T_bar")   {
  if (VERBOSE) echo("T_bar",w,d,l,t,c);
  T(0,w/2-t/2,0) cubint(w,t,l);
  cubint(t,d,l);
}
module T_barz(w,d,l,t=1,c="T_barz")  { T_bar(w,d,l,t,c); }
module T_barx(w,d,l,t=1,c="T_barx")  { ry(90) T_bar(w,d,l,t,c); }
module T_bary(w,d,l,t=1,c="T_bary")  { rx(90) T_bar(w,d,l,t,c); }

// ubar
module U_bar(w,d,l,tb=1,ts=1,c="U_bar")   {
  if (VERBOSE) echo("U_bar",w,d,l,tb,ts,c);
  T(0,d/2-tb/2,0) cubint(w,tb,l);  // bottom
  T(w/2-ts/2,0,0) cubint(ts,d,l);  // sides
  T(-w/2+ts/2,0,0) cubint(ts,d,l);
}
module U_barz(w,d,l,tb=1,ts=1,c="U_barz")  { U_bar(w,d,l,tb,ts,c); }
module U_barx(w,d,l,tb=1,ts=1,c="U_barx")  { ry(90) U_bar(w,d,l,tb,ts,c); }
module U_bary(w,d,l,tb=1,ts=1,c="U_bary")  { rx(90) U_bar(w,d,l,tb,ts,c); }

// ibar
module I_bar(w,d,l,tb=1,ts=1,c="I_bar")   {
  if (VERBOSE) echo("I_bar",w,d,l,tb,ts,c);
  T(0,0,0) cubint(tb,d,l);  // middle
  T(0,d/2-ts/2,0) cubint(w,ts,l);  // end caps
  T(0,-d/2+ts/2,0) cubint(w,ts,l);
}
module I_barz(w,d,l,tb=1,ts=1,c="I_barz")  { I_bar(w,d,l,tb,ts,c); }
module I_barx(w,d,l,tb=1,ts=1,c="I_barx")  { ry(90) I_bar(w,d,l,tb,ts,c); }
module I_bary(w,d,l,tb=1,ts=1,c="I_bary")  { rx(90) I_bar(w,d,l,tb,ts,c); }

module sq_tube(x,y,z_len,t=1,c="",roundtype=1,roundness=0) {
  material_volume_m3 = 2*(x+y)*z_len*t/1000000000;
  weight_kg = material_volume_m3*MATERIAL_WEIGHT;
  lab = z_len > 400 ? str(x," x ",y," x ",z_len,", ",round(100*weight_kg)/100," kg") : (z_len > 200 ? str(x," x ",y," x ",z_len) : str(z_len));
  if (VERBOSE) echo("sq_tube",x,y,z_len,t,c,material_volume_m3,weight_kg);
  difference() {
    cubint(x,y,z_len,"outer",roundtype,roundness);
    cubint(x-2*t,y-2*t,z_len+10,"hole",roundtype,roundness);
  }
  T(0,-y/2-1,0,ry=-90,rz=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
  T(x/2+1,0,0,ry=90) label(lab,SHOW_DIM_COLOR,SHOW_DIM);
}

module sq_tubez(x,y,z,t=1,c="sq_tubez",roundtype=1,roundness=0)  { sq_tube(x,y,z,t,c,roundtype,roundness); }
module sq_tubex(x,y,z,t=1,c="sq_tubex",roundtype=1,roundness=0)  { ry(90) sq_tube(x,y,z,t,c,roundtype,roundness); }
module sq_tubey(x,y,z,t=1,c="sq_tubey",roundtype=1,roundness=0)  { rx(90) sq_tube(x,y,z,t,c,roundtype,roundness); }

module cylint(D,H,c="") {
  cylinder(d=D,h=H, center=true);
}

module cyl(D,H,c="") {
  if (c) {
    if (VERBOSE) echo("cylinder",D,H,c);
  }
  cylinder(d=D,h=H, center=true);
}

module cylz(d,l,c="axlez")  { cyl(d,l,c); }
module cylx(d,l,c="axlex")  { ry(90) cyl(d,l,c); }
module cyly(d,l,c="axley")  { rx(90) cyl(d,l,c); }

module axle(d,l,c="axle")    { if (VERBOSE) echo("axle",d,l,c); cylint(d,l); }
module axlez(d,l,c="axlez")  { axle(d,l,c); }
module axlex(d,l,c="axlex")  { ry(90) axle(d,l,c); }
module axley(d,l,c="axley")  { rx(90) axle(d,l,c); }

module hole(d,l=200,c="hole")    { if (VERBOSE) echo("hole",d,l,c); cylint(d,l); }
module holez(d,l=200,c="holez")  { hole(d,l,c); }
module holex(d,l=200,c="holex")  { ry(90) hole(d,l,c); }
module holey(d,l=200,c="holey")  { rx(90) hole(d,l,c); }

module holetoz(x,y,z,d,l=200,c="holetoz") {  if (VERBOSE) echo("holetoz",x,y,z,d,l,c); T(x,y,z) cylint(d,l); }
module holetox(x,y,z,d,l=200,c="holetox") {  if (VERBOSE) echo("holetox",x,y,z,d,l,c); T(x,y,z,ry=90) cylint(d,l); }
module holetoy(x,y,z,d,l=200,c="holetoy") {  if (VERBOSE) echo("holetoy",x,y,z,d,l,c); T(x,y,z,rx=90) cylint(d,l); }

module tube(D,H,T=1,C="tube") {
  if (VERBOSE) echo("tube",D,H,T,C);
  difference() {
    cylint(D,H);
    cylint(D-2*T,H+10);
  }
}

module tubez(D,H,T=1,C="tubez")  { tube(D,H,T,C); }
module tubex(D,H,T=1,C="tubex")  { ry(90) tube(D,H,T,C); }
module tubey(D,H,T=1,C="tubey")  { rx(90) tube(D,H,T,C); }

module curved_cyl(r,deg,od) {
  rotate_extrude(angle=deg) T(r,0,0) circle(d=od);
}

module T_conn(od,t=1) {
  if (VERBOSE) echo("T_conn id,od",od-2*t,od);
  rx(90) tube(od,3*od);
  T(0,0,-0.7*od) tube(od,1.5*od);
}

module elbow(r_curve,deg,od,t=1) {
  if (VERBOSE) echo("elbow",deg,od-2*t,od);
  difference() {
    curved_cyl(r_curve,deg,od);
    rot(0,0,-1) curved_cyl(r_curve,deg+2,od-2*t);
  }
}

module pipe_flange(ly,d_int,d_hole=4,t=1) {
  if (VERBOSE) echo("pipe_flange",d_int,d_int+2*t,ly);
  union() {
    tubey(d_int+2*t,ly,t);
    difference() {
      T(0,-ly/2+T_PIPEFLANGE/2,0) cub(d_int*1.7,T_PIPEFLANGE,d_int*1.7);
      T(0,-ly/2+T_PIPEFLANGE/2,0) axley(d_int,T_PIPEFLANGE+1);
      T(0,-ly/2+T_PIPEFLANGE/2,0,rx=90) sym4(d_int*.58,d_int*.58) hole(d_hole,T_PIPEFLANGE+1);
    }
  }
}

module cone(D1,D2,H) {
  cylinder(d1=D1,d2=D2,h=H, center=true);
}

module hollow_cone(D1,D2,H,T_WALL=1) {
  difference() {
    cone(D1, D2, H);
    if (VERBOSE) echo(D2=D2,T_WALL=T_WALL,D1INT=D1-2*T_WALL,D2INT=D2-2*T_WALL);
    T(0,0,0) cone(D1-2*T_WALL<0?0:D1-2*T_WALL, D2-2*T_WALL, H+1);
  }
}

module pipe_adapter(d1=8, d2=12, lz=24, t=1) {  // muhvi
  len_funnel = d2-d1;
  len_end = (lz-len_funnel)/2;
  T(0,0,len_funnel/2+len_end/2) tube(d1,len_end,t);
  //tube(d2,2*t,(d2-(d1-2*t))/2);
  hollow_cone(d2,d1,len_funnel+.1,t);
  T(0,0,-len_funnel/2-len_end/2) tube(d2,len_end,t);
}

module nut(screw_diam) {
  if (VERBOSE) echo("nut",screw_diam);
  T(0,0,screw_diam*.35) difference() {
    cylinder(d=screw_diam*2,h=screw_diam*.7,center=true,$fn=6);
    cylinder(d=screw_diam,h=screw_diam,center=true,$fn=20);    
  }
}

module nutz(screw_diam) { nut(screw_diam); }
module nutx(screw_diam) { ry(90) nut(screw_diam); }
module nuty(screw_diam) { rx(90) nut(screw_diam); }

// Screws are measured from the surface on which the head sits. Height
// of the screw is below surface and head generally above (height of
// the head is fixed multipler of the diameter and can not be changed
// without editing libmac.scad source code), except that in the case
// of flush screw, the head is included in the height (and thus the
// threaded part is that much shorter).
// Nut height (h_nut) specifies the distance from one surface to another
// and the nut, whose own height is fixed multiple of diameter, is entirely
// below h_nut. Washer sits directly above the nut and eats away from
// h_nut. If n_nut is zero or not specified, then no nut or washer appears.
// Thread is not rendered.

module flush_screw(screw_diam,h,h_nut=0,t_washer=.5,c="") {  // aka counter-sunk
  if (VERBOSE) echo("flush_screw",screw_diam,h,h_nut,c);
  T(0,0,-h/2) union() {
    cylint(screw_diam,h,c);
    T(0,0,h/2-screw_diam*.25) cone(screw_diam,2.5*screw_diam,screw_diam*.5);
    if (h_nut) {
      T(0,0,h/2-h_nut-screw_diam*.6-1) nutz(screw_diam);
      if (t_washer) {
	T(0,0,h/2-h_nut+t_washer*.5+.1) tube(2.8*screw_diam,t_washer,.9*screw_diam);
      }
    }
  }
}

module flush_screwz(d,h,h_nut=0,t_washer=.5,c="") {  flush_screw(d,h,h_nut,t_washer,c); }
module flush_screwx(d,h,h_nut=0,t_washer=.5,c="") {  ry(90) flush_screwz(d,h,h_nut,t_washer,c); }
module flush_screwy(d,h,h_nut=0,t_washer=.5,c="") {  rx(90) flush_screwz(d,h,h_nut,t_washer,c); }

module allen_screw(screw_diam,h,h_nut=0,t_washer=.5,c="") {  // socket screw, kuusiokolo
  if (VERBOSE) echo("allen_screw",screw_diam,h,h_nut,c);
  T(0,0,-h/2) union() {
    cylint(screw_diam,h,c);
    T(0,0,h/2+screw_diam*.5) difference() {
      cylint(2.5*screw_diam,screw_diam*1.0);
      T(0,0,.2) cylinder(d=1.5*screw_diam,h=screw_diam*1.0,center=true,$fn=6);
    }
    if (h_nut) {
      T(0,0,h/2-h_nut-screw_diam*.6-1) nutz(screw_diam);
      if (t_washer) {
	T(0,0,h/2-h_nut+t_washer*.5+.1) tube(2.8*screw_diam,t_washer,.9*screw_diam);
      }
    }
  }
}

module allen_screwz(d,h,h_nut=0,t_washer=.5,c="") {  allen_screw(d,h,h_nut,t_washer,c); }
module allen_screwx(d,h,h_nut=0,t_washer=.5,c="") {  ry(90) allen_screwz(d,h,h_nut,t_washer,c); }
module allen_screwy(d,h,h_nut=0,t_washer=.5,c="") {  rx(90) allen_screwz(d,h,h_nut,t_washer,c); }

// Labelled vector (arrow)
module vecy(l,w=1,c="",siz=8,fgcolor="black",bgcolor="blue",RZ=90) {
  color(bgcolor) linear_extrude(height=1,center=true,twist=0,slices=1) {
    polygon( points=[[0,0], [w/2,w/2], [w/4,w/2], [w/4,l], [-w/4,l], [-w/4,w/2], [-w/2,w/2]] );
  }
  T(0,l/2,0,rz=RZ) color(fgcolor) linear_extrude(height=2)
    text(c, size=siz, halign="center", valign="center");
}

module rulerx(from,to,siz=4) {
  for (x=[from:to]) {    T(x,0,0) cubint(.2,1,1);  }
  for (x=[from:5:to]) {  T(x,0,1) cubint(.2,1,2);  }
  for (x=[from:10:to]) {
    T(x,0,2) cubint(.2,1,4);
    T(x,0,7,rx=90) linear_extrude(height=2)
      text(str(x/10), size=siz, halign="center", valign="center");
  }
}

module rulery(from,to,siz=4) {
  for (y=[from:to]) {    T(0,y,0) cubint(1,.2,1);  }
  for (y=[from:5:to]) {  T(0,y,1) cubint(1,.2,2);  }
  for (y=[from:10:to]) {
    T(0,y,2) cubint(1,.2,4);
    T(0,y,7,rx=90,rz=90) linear_extrude(height=2)
      text(str(y/10), size=siz, halign="center", valign="center");
  }
}

module rulerz(from,to,siz=4) {
  for (z=[from:to]) {    T(0,0,z) cubint(1,1,.2);  }
  for (z=[from:5:to]) {  T(1,0,z) cubint(2,1,.2);  }
  for (z=[from:10:to]) {
    T(2,0,z) cubint(4,1,.2);
    T(7,0,z,rx=90) linear_extrude(height=2)
      text(str(z/10), size=siz, halign="center", valign="center");
  }
}

// Triangle like yield traffic sign, used for building support struts and scaffoldings
module yield(wid, TPIL=0.4) {
  x = sqrt(wid*wid/2);
  difference() {
    rot(0,45,0) cubint(x,TPIL,x);
    T(0,0,wid/4+0.5) cubint(wid+1,TPIL+1,wid/2+1);
  }
}

// 3D-printing support prop pylon. foot is radius of round foot brim, if any
module prop(W,H,foot=0) {
  T_PROP=.5;  // Thinnest layer that prints reliably (depends on slicer settings and printer)
  W_PROP=2;
  union() {
    cubint(W_PROP,T_PROP,H);  // stem (a plus sign profile)
    T(0,0,-T_PROP/2) cubint(T_PROP,W_PROP,H-T_PROP);
    T(0,0,H/2) rx(90)         // Triangle at top
      linear_extrude(height=T_PROP,center=true)
        polygon([[-W/2,0],[W/2,0],[0,-W/3]]);
    if (foot > 0) {
      T(0,0,-H/2+T_PROP/2) cylint(foot,T_PROP);
    }
  }
}

// snake_line([[x1,y1,z1],[x2,y2,z2],[x3,y3,z3]])

module snake_line(pts,siz=1) {
  lim=len(pts)-2;
  union() {
    for (i=[0:lim]) {
      hull() {
	translate(pts[i]) sphere(siz);
	translate(pts[i+1]) sphere(siz);
      }
    }
  }
}

module snake_line_2D(pts,siz=1) {
  lim=len(pts)-2;
  union() {
    for (i=[0:lim]) {
      hull() {
	translate(pts[i]) circle(siz);
	translate(pts[i+1]) circle(siz);
      }
    }
  }
}

module torus(r_ext,r_tube=5) {
  rotate_extrude(convexity = 10, $fn=72)
    translate([r_ext-r_tube/2, 0, 0])
    circle(r=r_tube, $fn=72);
}

module symx(X_OFF=0) {
  T(X_OFF,0,0) children(0);
  T(-X_OFF,0,0) scale([-1,1,1]) children(0);
}

module symy(Y_OFF=0) {
  T(0,Y_OFF,0) children(0);
  T(0,-Y_OFF,0) scale([1,-1,1]) children(0);
}

module symz(Z_OFF=0) {
  T(0,0,Z_OFF) children(0);
  T(0,0,-Z_OFF) scale([1,1,-1]) children(0);
}

module sym4(X_OFF=0,Y_OFF=0) {  // deprecated
  T(X_OFF,Y_OFF,0) children(0);
  T(-X_OFF,Y_OFF,0) scale([-1,1,1]) children(0);
  T(-X_OFF,-Y_OFF,0) scale([-1,-1,1]) children(0);
  T(X_OFF,-Y_OFF,0) scale([1,-1,1]) children(0);
}

module symxy(X_OFF=0,Y_OFF=0) {
  T(X_OFF,Y_OFF,0) children(0);
  T(-X_OFF,Y_OFF,0) scale([-1,1,1]) children(0);
  T(-X_OFF,-Y_OFF,0) scale([-1,-1,1]) children(0);
  T(X_OFF,-Y_OFF,0) scale([1,-1,1]) children(0);
}

module snap_clip(wid=2,depth=2,height=8) {
     linear_extrude(height=wid,center=true)
	  polygon(points=[[-depth,0],[0,0],[2.5,2],[2.5,3],[1,3],[1,height],[-depth,height]]);
}

module sq_triangle(a,b,h=100,c="") {
  if (c) {
    if (VERBOSE) echo("sq_triangle",a,b,h,c);
  }
  linear_extrude(height=h,center=true)
    polygon(points=[[0,0],[a,0],[0,b]]);
}

module sq_tri(a,b,h=100,c="") {
  sq_triangle(a,b,h,c);
}

module wedge(r,h,deg) {
  rz(-deg/2) rotate_extrude(angle=deg) square([r,h]);
}

module screw_mount(wid=12,d_hole=5,t_wall=2) {
  difference() {
    union() {
      hull() {
	T(0,16,t_wall/2+.001) cyl(wid,t_wall);
	T(0,10,t_wall/2+.001) cub(wid,4,t_wall);
      }
      symx(wid/2-t_wall/2) T(0,10,2,ry=-90) sq_tri(3,3,t_wall);
    }
    T(0,16,0) hole(d_hole);
  }
}

// color shorthand

module red(alpha=1) {
  color("red",alpha) children(0);
}

module green(alpha=1) {
  color("green",alpha) children(0);
}

module lime(alpha=1) {
  color("lime",alpha) children(0);
}

module blue(alpha=1) {
  color("blue",alpha) children(0);
}

module yel(alpha=1) {
  color("yellow",alpha) children(0);
}

module ora(alpha=1) {
  color("orange",alpha) children(0);
}

module mag(alpha=1) {
  color("magenta",alpha) children(0);
}

module cyan(alpha=1) {
  color("cyan",alpha) children(0);
}

module whi(alpha=1) {
  color("white",alpha) children(0);
}

module black(alpha=1) {
  color("black",alpha) children(0);
}

module gray(alpha=1) {
  color("gray",alpha) children(0);
}

//EOF - libmac.scad
