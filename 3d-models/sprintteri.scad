
include <hsu.scad>

module sprintteri() {
scalefactor=1/25.4;  //304.8;
scale([scalefactor,scalefactor,scalefactor]) import("sprintteri.stl");
}

sprintteri();



