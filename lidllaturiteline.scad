$fn=60;

chargerthickness=9;
chargerwidth=180.2;
chargerheight=85.2;
phonethickness=15;
phonewidth=82;
phoneheight=167;
phoneheightreduction=100;
phonebottomlevel=20; // Below bottom of charging pad
chargingcoildistance=95;
chargingcoildiameter=64;
usbholewidth=20;
usbholethickness=1;
bottomheight=25;
backthickness=2;
thicknessmargin=2;
legwidth=10;
legheight=phoneheight;
legthickness=phoneheight;
legposition=10;
phonecutdiameter=10;
phonecut=5; // Edge to which phone drops and stays in place
keycutposition=30-55;
keycutheight=55;
divideredge=chargingcoildistance-phonewidth;
microphoneholewidth=45;
microphoneholedepth=40;
microphoneholeangle=45;
microphoneholeposition=0; // Offset from center
smallcornerdiameter=2;
largecornerdiameter=10;

angle=45;
width=chargerwidth+10;
height=chargerheight+phoneheight-phoneheightreduction+bottomheight;
thickness=chargerthickness+phonethickness+backthickness+thicknessmargin+2;
difference() {
  rotate([angle,0,0]) {
    union() {
      translate([width/2,bottomheight+divideredge+0.5,backthickness+chargerthickness+usbholethickness]) rotate([0,0,45]) cube([usbholewidth/2.18,usbholewidth/2.18,thickness-backthickness-chargerthickness-usbholethickness]);
      
      difference() {
	union() {
	  hull() {
	  translate([smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([width-smallcornerdiameter/2,height-smallcornerdiameter/2,smallcornerdiameter/2]) sphere(d=smallcornerdiameter);
	  translate([largecornerdiameter/2,largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
	  translate([largecornerdiameter/2,height-largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
	  translate([width-largecornerdiameter/2,largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
	  translate([width-largecornerdiameter/2,height-largecornerdiameter/2,thickness-largecornerdiameter/2]) sphere(d=largecornerdiameter);
	    //cube([width,height,thickness]);
	  }
	  translate([legposition,0,-legthickness]) cube([legwidth,legheight,legthickness+0.01]);
	  translate([width-legposition-legwidth,0,-legthickness]) cube([legwidth,legheight,legthickness+0.01]);
	}
	translate([(width-chargerwidth)/2,bottomheight+phonebottomlevel,backthickness]) cube([chargerwidth,chargerheight,chargerthickness+phonethickness+10+0.01]);
	//translate([(width-chargerwidth)/2,bottomheight,backthickness+chargerthickness]) cube([chargerwidth,phoneheight,phonethickness+thicknessmargin+1]);
	translate([width/2-chargingcoildistance/2-phonewidth/2,bottomheight,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+1]);
	translate([width/2+chargingcoildistance/2-phonewidth/2,bottomheight,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+1]);
	translate([width/2-chargingcoildistance/2-phonewidth/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+5]);
	translate([width/2+chargingcoildistance/2-phonewidth/2,bottomheight+phonebottomlevel,backthickness+chargerthickness]) cube([phonewidth,phoneheight,phonethickness+thicknessmargin+5]);

	union() {
	  translate([width/2-usbholewidth/2,-0.01,backthickness]) cube([usbholewidth,bottomheight+phonebottomlevel+1,chargerthickness+usbholethickness]);
	  translate([width/2,-usbholewidth/1.45,backthickness]) rotate([0,0,45]) cube([usbholewidth,usbholewidth,thickness+1]);
	}
      
	hull() {
	  translate([width/2-chargingcoildistance/2-phonewidth/2+phonecutdiameter,bottomheight+phonecut+phonecutdiameter/2,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	  translate([width/2-chargingcoildistance/2-phonewidth/2+phonecutdiameter/2,bottomheight+phonecutdiameter+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	  translate([width/2-chargingcoildistance/2+phonewidth/2-phonecutdiameter/2,bottomheight+phonecutdiameter+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	  translate([width/2-chargingcoildistance/2+phonewidth/2-phonecutdiameter,bottomheight+phonecut+phonecutdiameter/2,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
      }

    translate([width/2-chargingcoildistance/2-microphoneholeposition-microphoneholewidth/2,bottomheight,backthickness+chargerthickness]) rotate([microphoneholeangle,0,0]) cube([microphoneholewidth,microphoneholewidth,microphoneholedepth]);
    translate([width/2+chargingcoildistance/2-microphoneholeposition-microphoneholewidth/2,bottomheight,backthickness+chargerthickness]) rotate([microphoneholeangle,0,0]) cube([microphoneholewidth,microphoneholewidth,microphoneholedepth]);
		 
      
      hull() {
	translate([width/2+chargingcoildistance/2-phonewidth/2+phonecutdiameter,bottomheight+phonecut+phonecutdiameter/2,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2+chargingcoildistance/2-phonewidth/2+phonecutdiameter/2,bottomheight+phonecutdiameter+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2+chargingcoildistance/2+phonewidth/2-phonecutdiameter/2,bottomheight+phonecutdiameter+phonebottomlevel,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
	translate([width/2+chargingcoildistance/2+phonewidth/2-phonecutdiameter,bottomheight+phonecut+phonecutdiameter/2,backthickness+chargerthickness]) cylinder(h=phonethickness+thicknessmargin+backthickness+2,d=phonecutdiameter);
      }

      translate([phonewidth,bottomheight+phonebottomlevel+chargerheight+keycutposition,chargerthickness+backthickness+1]) cube([width,keycutheight,phonethickness+thicknessmargin+backthickness]);

      //      translate([width/2,bottomheight+phonebottomlevel,-0.01]) rotate([0,0,45]) cube([chargerheight/1.45,chargerheight/1.45,thickness+1]);
      //     translate([width/2+27,bottomheight+phonebottomlevel+87,-0.01]) rotate([0,0,45]) cube([chargerheight/3.2,chargerheight/3.2,thickness+1]);
      //translate([width/2+27+40,bottomheight+phonebottomlevel+87,-0.01]) rotate([0,0,45]) cube([chargerheight/3.2,chargerheight/3.2,thickness+1]);
      //translate([27,bottomheight+phonebottomlevel+87,-0.01]) rotate([0,0,45]) cube([chargerheight/3.2,chargerheight/3.2,thickness+1]);
      //translate([27+40,bottomheight+phonebottomlevel+87,-0.01]) rotate([0,0,45]) cube([chargerheight/3.2,chargerheight/3.2,thickness+1]);
    }
  }
}
translate([-0.01,-2,-height]) cube([width+1,height,height+backthickness]);
translate([-0.01,125,-phoneheight]) cube([width+1,height+phoneheight,height+phoneheight]);
}
