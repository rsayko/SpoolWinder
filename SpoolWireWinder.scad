// Spool cable wire winder v1.0
// Written by Sayko R. <roman.sayko@gmail.com>
// Only for drukarmy.org.ua
// Feel free to mail me about bugs and propositions
// ps. better code and better version will arrive in October 2023

use <threads.scad>
/*[ Main parameters ]*/

// Diameter of the spool
spool_diameter=175; 
// Diameter of the hole of spool
hole_diameter = 35;
//Spool width
spool_width = 60;
// Height of the base that will hold spool (overall height will be hole_diameter + plate height * 2)
plate_height = 20;
//(Beta) Try to reduce use of plastic (strenght may suffer)
//economy_mode = false;

/*[ Advanced parameters ]*/

// diameter of the handle
handle_diameter = 30;

//Distance of handle from base plate
handle_distance = 60;

//Diameter of the printer's nozzle, also used for tollerance
nozzle_diameter = 0.4; 

//Thickness of the wall
wall_thickness = 3.5;

test_height = 15;

TheTool();

translate([spool_diameter/18,hole_diameter,wall_thickness/2]) t("ДрукАрміЯ", s = spool_diameter/13, spacing = 1);

difference() {
translate([0,-hole_diameter - plate_height*2, -wall_thickness/2])
RodStart2(hole_diameter - (nozzle_diameter * 2), spool_width * 0.8, wall_thickness, hole_diameter + plate_height- (nozzle_diameter * 2));
translate([0,-hole_diameter - plate_height*2, spool_width / 2 - wall_thickness])
cylinder(h=spool_width,
      r=(hole_diameter / 2) /2, $fn=6,
      center=true);
}

difference() {
translate([hole_diameter*2,-hole_diameter - plate_height*2, -wall_thickness/2])
RodEnd2(hole_diameter - (nozzle_diameter * 2), spool_width * 0.8, hole_diameter + plate_height- (nozzle_diameter * 2), wall_thickness);

translate([hole_diameter*2,-hole_diameter - plate_height*2, spool_width / 2 - wall_thickness]) 
cylinder(h=spool_width,
      r=(hole_diameter / 2) /2, $fn=6,
      center=true);
}
Base(0, false);
Base(hole_diameter + plate_height * 2 + (nozzle_diameter * 2), true);

economy_extrude_width = spool_diameter / 3 - plate_height * 4;

module TheTool(){
    translate([0,0,5])
    cube([10, hole_diameter * 0.8, 10], center = true);
    translate([0,0,10])
    cylinder(h=20,
      r=(hole_diameter / 2) /2 - nozzle_diameter, $fn=6,
      center=true);
    }

module Handle(){
    difference() {
        Handle_part_base();
        translate([0,0,wall_thickness/2]);
        
        radius_start = (hole_diameter + plate_height) / 2;
        radius_end = hole_diameter;
        cylinder(h = handle_distance + handle_diameter / 2 + nozzle_diameter, r1 = radius_start, r2 = radius_end, center = false);
        
        width = hole_diameter;
        height = handle_distance + handle_diameter/2 - wall_thickness/2;
        diagonal_width = sqrt(pow(width, 2) + pow(height, 2));
        angle = atan(width/height);
        
        rotate([0, 0, 180])
        translate([- hole_diameter / 2 - plate_height,0,wall_thickness / 2])
  
        rotate([angle, 0, 0])
        cube([hole_diameter + plate_height * 2, width, diagonal_width], center = false);
    }
}

module Handle_part_base(){
    rotate([-90, 0, 0])
    translate([0,-handle_distance,hole_diameter])
    cylinder(h = spool_diameter - plate_height - hole_diameter * 2, r = handle_diameter/2, center = false);
    translate([- (hole_diameter / 2) - plate_height,0,wall_thickness / 2])
    cube([hole_diameter + plate_height * 2, hole_diameter, handle_distance + handle_diameter/2 - wall_thickness/2], center = false);
    
    
    translate([-hole_diameter / 2 - plate_height, hole_diameter * 1.5, handle_distance + handle_diameter / 2])
    rotate([0,180,180])
    prism(hole_diameter + (plate_height * 2),hole_diameter/2, handle_distance + handle_diameter / 2);
}

module Base(offset = 0, is_bottom_plate = false){
    if(!is_bottom_plate){
            Handle();
        mirror([0,1,0]) translate([0,-spool_diameter,0]) Handle();
        }
        
    difference() {
        Base_part_platform(offset, is_bottom_plate);
        translate([offset,0,0])
        
        cylinder(h = wall_thickness + nozzle_diameter * 2, r = (hole_diameter/2) + (nozzle_diameter * 2), center = true);
      
        translate([offset,spool_diameter,0])
        cylinder(h = wall_thickness + nozzle_diameter * 2, r = (hole_diameter/2) + (nozzle_diameter * 2), center = true);
        }
    
}

module Base_part_platform(offset = 0, is_bottom_plate = false){
    
    
    translate([offset,0,0])
    cylinder(h = wall_thickness, r = (hole_diameter/2) + plate_height, center = true);
    translate([offset,spool_diameter,0])
    cylinder(h = wall_thickness, r = (hole_diameter/2) + plate_height, center = true);
    translate([offset,spool_diameter/2,0])
    cube([(hole_diameter + (plate_height * 2)), spool_diameter, wall_thickness], center = true);
}

module BarrelScrew(x, y){
    translate([x,y,0])
    difference() {
    BarrelScrew_part_base();
        cylinder(h = spool_width * 0.75 + nozzle_diameter, r = hole_diameter/2 - (nozzle_diameter * 2) - wall_thickness , center = false);
    }
}

module BarrelScrew_part_base(){
    cylinder(h = wall_thickness, r = (hole_diameter/2) + (plate_height/2) - nozzle_diameter, center = true);
    cylinder(h = spool_width * 0.75, r = hole_diameter/2 - (nozzle_diameter * 2), center = false);
    }

module t(t, s = 18, style = ":style=Bold", spacing = 1) {
    rotate([0, 0, 90])
    linear_extrude(height = wall_thickness/3)
      text(t, size = s,
           spacing=spacing,
           font = str("Liberation Sans", style),
           $fn = 16);
}

module prism(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
      }
