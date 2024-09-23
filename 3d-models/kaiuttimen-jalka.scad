
bottomradius=27.07/2;
height=12.74;
topradius=12/2;

holebottomradius=2.6/2;
holetopradius=8.7/2;
holedepth=7;

insidebottomradius=bottomradius-4;
insidebottomheight=2;
insidecenterradius=8.2/2;
insidetopradius=insidecenterradius+2.3;
insidetopheight=9;


x1=0;
y1=height-holedepth;
x2=holebottomradius;
y2=height-holedepth;
x3=holetopradius;
y3=height;
x4=topradius;
y4=height;
x5=bottomradius;
y5=2;
x6=bottomradius;
y6=0;
x7=insidebottomradius;
y7=0;
x8=insidebottomradius;
y8=3.8;
x9=insidetopradius;
y9=insidetopheight;
x10=insidecenterradius;
y10=insidetopheight;
x11=insidecenterradius;
y11=insidebottomheight;
x12=0;
y12=insidebottomheight;
pointlist=[[x1,y1],
	   [x2,y2],
	   [x3,y3],
	   [x4,y4],
	   [x5,y5],
	   [x6,y6],
	   [x7,y7],
//	   [x8,y8],
//	   [x9,y9],
	   [x10,y10],
	   [x11,y11],
	   [x12,y12] ];
	   
rotate_extrude($fn=360) polygon(points=pointlist); 
