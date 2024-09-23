// Business card storage holder set

// Inside measures
businesscard_width=60;
businesscard_length=100;
businesscard_height=50;
short_businesscard_box_length = 50 - 7.5/2;

// Wall thickness
wall_thickness=5;
notch_width = 40;

module lifter(lifter_foot,lifter_width,lifter_height,lifter_thickness)
{
  lifter_x1 = 0;
  lifter_y1 = -lifter_thickness;
  lifter_x2 = lifter_thickness;
  lifter_y2 = 0;
  lifter_x3 = lifter_thickness;
  lifter_y3 = lifter_width;
  lifter_x4 = 0;
  lifter_y4 = lifter_width + lifter_thickness;

   union() { 
       cube([lifter_thickness,lifter_width,lifter_height+10]); 
       cube([lifter_foot,lifter_width,lifter_thickness]); 
       linear_extrude(height=lifter_height) 
         polygon(points=[[lifter_x1,lifter_y1],
			[lifter_x2,lifter_y2],
			[lifter_x3,lifter_y3],
			[lifter_x4,lifter_y4],
			[lifter_x1,lifter_y1]
			]);
      }
}

module notch(notch_x,notch_y,notch_z,notch_length,notch_height,notch_depth)
{
notch_x_in = 10;
notch_x_out = 7.5;

translate([notch_x,notch_y,notch_z]) linear_extrude(height=notch_height) 
  polygon(points=[[notch_x_in, 0.01],
		[notch_x_out, -notch_depth],
		[notch_length - notch_x_out, -notch_depth],
		[notch_length - notch_x_in, 0.01],
		[notch_x_in, 0.01]
		]);
}


module businesscard_box(box_width, box_length, box_height, box_wall_thickness) {
  female_scale = 1;
  difference() {
       union() {
           cube([box_width + 1.5 * box_wall_thickness, box_length + 1.5 * box_wall_thickness, box_height + box_wall_thickness]);
	   translate([box_wall_thickness,0,0]) cube([box_width, box_wall_thickness/2,box_height + box_wall_thickness + 20]);
           notch((box_width + 1.5 * box_wall_thickness) / 2 - notch_width / 2, 0, 0, notch_width, box_height + box_wall_thickness, box_wall_thickness / 2);
           translate([box_width + 1.5 * box_wall_thickness, 0, 0]) rotate(90,[0,0,1]) notch(0, 0, 0, notch_width, box_height + box_wall_thickness, box_wall_thickness / 2);
           if (box_length > short_businesscard_box_length) {
	      translate([box_width + 1.5 * box_wall_thickness, short_businesscard_box_length + 7.5, 0]) rotate(90,[0,0,1]) notch(0, 0, 0, notch_width, box_height + box_wall_thickness, box_wall_thickness / 2);
	   }
       }
       translate([box_wall_thickness, box_wall_thickness / 2, box_wall_thickness]) 
            cube([box_width, box_length, box_height + 2 * box_wall_thickness]);
       rotate(90,[0,0,1]) notch(-female_scale/2, 0, -1, notch_width + female_scale, box_height + box_wall_thickness + 2, box_wall_thickness / 2);
       if (box_length > short_businesscard_box_length) {
       	  translate([0,short_businesscard_box_length + 7.5, 0])rotate(90,[0,0,1]) notch(-female_scale/2, 0, -1, notch_width + female_scale, box_height + box_wall_thickness + 2, box_wall_thickness / 2);
	  translate([box_wall_thickness / 2, box_length / 2 - (notch_width - 17.5) / 2, box_wall_thickness / 2]) 
	      lifter(box_width / 2 + 1, notch_width - 25 + 1,box_height + 20,box_wall_thickness / 2 + 0.1);
//	      union() { 
//	           cube([box_width / 2,notch_width - 25,box_height + box_wall_thickness]); 
//                   linear_extrude(height=box_height + box_wall_thickness) 
//                        polygon(points=[[lifter_x1,lifter_y1],
//					[lifter_x2,lifter_y2],
//					[lifter_x3,lifter_y3],
//					[lifter_x4,lifter_y4],
//					[lifter_x1,lifter_y1]
//					]);
//              }
       }
       translate([-female_scale/2, box_length + 1.5 * box_wall_thickness, -0.1]) notch((box_width + 1.5 * box_wall_thickness) / 2 - notch_width / 2, 0, 0, notch_width + female_scale, box_height + box_wall_thickness + 1, box_wall_thickness / 2);
  };
}

// businesscard_box(businesscard_width, businesscard_length, businesscard_height, wall_thickness);
businesscard_box(businesscard_width, short_businesscard_box_length, businesscard_height, wall_thickness);
translate([0,short_businesscard_box_length + 7.5 + 7.5,0]) businesscard_box(businesscard_width, short_businesscard_box_length, businesscard_height, wall_thickness);
translate([80,0,0]) businesscard_box(businesscard_width, short_businesscard_box_length, businesscard_height, wall_thickness);
translate([80,short_businesscard_box_length + 7.5 + 7.5,0]) businesscard_box(businesscard_width, short_businesscard_box_length, businesscard_height, wall_thickness);

// rotate(90,[0,-1,0]) 
translate([-10,20,0]) rotate(180,[0,0,1]) lifter(businesscard_width / 2,15,businesscard_height + 10,wall_thickness / 2);
