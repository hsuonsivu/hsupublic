// Batteries
// AA
lengthaa=51;
diameteraa=15;
// AAA
lengthaaa=45;
diameteraaa=11;
// 18650
lengthl18650=66;
diameterl18650=18.8;
// 9V battery
length9v=48;
width9v=26.5;
depth9v=17.5;

width=225;
length=280;

percentaa=0.65;
percentaaa=0.35;

celldistance = 2;

aaslotsx = (width - diameteraa - celldistance) / diameteraa;
aaslotsy = 8;

aaaslotsx = (width - diameteraaa - celldistance) / diameteraaa;
aaaslotsy = 6; // (length * percentaaa - diameteraaa - celldistance) / diameteraaa;

v9slotsy = 1;
v9slotsx = 7;

l18650slotsy = 2;
l18650slotsx = 8;

aaaystart = 1;
aaayend = aaaystart + aaaslotsy * (diameteraaa + celldistance);

aaystart = 1 + aaayend;
aayend = aaystart + aaslotsy * (diameteraa + celldistance);

v9start = 1 + aayend;
v9end = v9start + v9slotsy * (depth9v + celldistance);

l18650ystart = 1 + v9end;
l18650yend = l18650ystart + l18650slotsy * (diameterl18650 + celldistance);

labelwidth=50;
labelheight=20;

difference() {
union() {
cube([width,length,10]);
translate([-labelwidth + 0.001,0,0]) cube([labelwidth,length,labelheight]);
}
for (y = [aaaystart : diameteraaa + celldistance : aaayend - diameteraaa - celldistance]) 
    for (x = [diameteraaa / 2 + 1 : diameteraaa + celldistance : width - diameteraaa / 2 - 1])
    	translate([x,y + diameteraaa / 2,1])
		cylinder(h=lengthaaa, d=diameteraaa, $fa = 12, $fs = 2);

for (y = [aaystart: diameteraa + celldistance : aayend - diameteraa - celldistance]) 
    for (x = [diameteraa / 2 + 1 : diameteraa + celldistance : width - diameteraa / 2 - 1])
    	translate([x,y + diameteraa / 2,1])
		cylinder(h=lengthaa, d=diameteraa, $fa = 12, $fs = 2);
		
for (y = [v9start : depth9v + celldistance : v9end - depth9v - celldistance ])
    for (x = [1 : width9v + celldistance : width - width9v - 1 ] )
    translate([x,y,1])
	cube([width9v,depth9v,length9v]);

for (y = [l18650ystart: diameterl18650 + celldistance : l18650yend - diameterl18650 - celldistance]) 
    for (x = [diameterl18650 / 2 + 1 : diameterl18650 + celldistance : width - diameterl18650 / 2 - 1])
    	translate([x,y + diameterl18650 / 2,1])
		cylinder(h=lengthl18650, d=diameterl18650, $fa = 12, $fs = 2);
		
}

