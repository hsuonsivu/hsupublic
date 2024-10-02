// Copyright 2024 Heikki Suonsivu
// Licensed under Creative Commons CC-BY-NC-SA, see https://creativecommons.org/licenses/by-nc-sa/4.0/
// For commercial licensing, please contact directly, hsu-3d@suonsivu.net, +358 40 551 9679

bicyclebarh=60;
bicyclebarw=42;
barl=250; // Only used for testing

dtolerance=0.7;
xtolerance=0.3;
ytolerance=0.3;
ztolerance=0.3;

wall=2;

screwdistance=62;

cand=66;
canh=115;

limupullod=61;
limupulloh=160;
  
holderdiameter=cand+dtolerance;
offset=wall;
drinkcenter=offset+holderdiameter/2;
drinkbottomheight=wall;

originald=65;
originalh=150;

screwd=5;

module bar() {
  translate([-bicyclebarh/2,0,0]) resize([bicyclebarh,bicyclebarw,barl]) cylinder(d=bicyclebarw,h=barl,$fn=60);
}

module can() {
  translate([drinkcenter,0,drinkbottomheight]) cylinder(d=cand,h=canh);
}

module bottleholder() {
  
}

#bar();
#can();
bottleholder();
