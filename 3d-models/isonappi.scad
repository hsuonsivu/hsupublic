leikkaa=0;
support=1;

$fn=360;

// 1.6, 2.4, 0.8 ero

reunadiameterw=4.7;
reunadiameterh=4.1;
largediameter=107; // guess
insidelargediameter=largediameter; // another guess
thicknesscenter=3.5;
buttonholedistance=4.2;
buttonholediameter=2.8;

outsidediameter=28.8;
insidediameter=19;
// Total height must be 5.4
outsideringheight=5.4-reunadiameterh/2-thicknesscenter/2; //1.7;

supportdiameter=outsidediameter;
narrowing=0.25;

echo(outsidediameter/2,supportdiameter,outsideringheight,thicknesscenter/2+outsideringheight+reunadiameterh/2);

module nappi() {
  difference() {
    union() {
      intersection() {
	translate([0,0,largediameter/2-thicknesscenter/2]) sphere(d=largediameter);
	translate([0,0,-insidelargediameter/2+thicknesscenter/2]) sphere(d=insidelargediameter);
	translate([0,0,outsideringheight]) sphere(d=outsidediameter-reunadiameterw/2);
      }
      translate([0,0,outsideringheight]) rotate_extrude() translate([outsidediameter/2-reunadiameterw/2,0,0]) resize([reunadiameterw,reunadiameterh]) circle(d=1);
      if (support) #translate([0,0,-thicknesscenter/2+0.01]) cylinder(h=thicknesscenter/2+outsideringheight*narrowing-0.01,d1=supportdiameter-(thicknesscenter/2+outsideringheight/2)*2.5,d2=supportdiameter*(supportdiameter-reunadiameterw*narrowing)/supportdiameter);
    }
    translate([-buttonholedistance/2,-buttonholedistance/2,-thicknesscenter]) cylinder(h=thicknesscenter*2+1,d=buttonholediameter);
    translate([buttonholedistance/2,-buttonholedistance/2,-thicknesscenter]) cylinder(h=thicknesscenter*2+1,d=buttonholediameter);
    translate([-buttonholedistance/2,buttonholedistance/2,-thicknesscenter]) cylinder(h=thicknesscenter*2+1,d=buttonholediameter);
    translate([buttonholedistance/2,buttonholedistance/2,-thicknesscenter]) cylinder(h=thicknesscenter*2+1,d=buttonholediameter);
  }
}

if (leikkaa) {
  difference() {
    nappi();
    translate([-outsidediameter/2-1,0,-thicknesscenter/2]) cube([outsidediameter+2,outsidediameter+2,6]);
  }
 } else nappi();

  
