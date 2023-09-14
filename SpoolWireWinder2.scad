// Spool cable wire winder v2.1
// Written by Sayko R. <roman.sayko@gmail.com>
// Feel free to mail me about bugs and propositions

use <threads.scad>
/*[ Main ]*/

// Diameter of the spool
spool_diameter=175; 
// Diameter of the hole of spool
hole_diameter = 35.0;
//Spool width
spool_width = 60;
// Height of the base that will hold spool (overall height will be hole_diameter + plate height * 2)
plate_height = 20;
//(Beta) Try to reduce use of plastic (strenght may suffer)
hollow_plate = true;

/*[ Split ]*/
//split plates if the size of the printer bed is smaller than spool_diameter*2. Maybe i reccomend separate_handle=true if split_base. Tests wasn't made till now
split_base = true;
//number of connector to glue two plates
number_of_connectors = 5;

/*[ Holder base ]*/
//make hole under the handle to reduce use of plastic
hollow_base = true;
//normaly the reasonable value is 20, but you can play with parameters if you want something fancy
holder_top_fillet = 20;//[0:90]
holder_bottom_fillet = 20;//[0:90]

/*[ Handle ]*/

// diameter of the handle
handle_diameter = 30;

//Distance of handle from base plate
handle_distance = 45;

//additional material forn make handle more strenght
handle_margin = 3;

//additional material for handle on the beggining
handle_champfer = 15; //[0:50]

//print handle separated from base
separate_handle = false;

/*[ Other ]*/

//Thickness of the wall
wall_thickness = 3.5;
//before final render set it to 24, for debugging 6 is ok
render_quality = 24;//[1:24]
//Diameter of the printer's nozzle, also used for tollerance
nozzle_diameter = 0.4; 

hole_radius = hole_diameter / 2;
spool_radius = spool_diameter / 2;

connector_size = ((hole_diameter + plate_height * 2)/ (number_of_connectors))/2;
echo("Connector size is ", connector_size);
half_plate_width = spool_diameter + nozzle_diameter + (split_base?connector_size*2:0);



Plate(true);

mirror([1,0,0]) translate([hole_diameter + plate_height * 3,0]) Plate(false);

if(separate_handle){
    translate([spool_radius,0,0])
     cylinder(h = spool_diameter - hole_diameter + (split_base?0:nozzle_diameter), r = handle_diameter/2, $fn=render_quality*hole_radius, center = false);   
}

TheTool();
translate([-hole_diameter - plate_height * 3,0,0]) TheTool();

//Rod Start
difference() {
translate([0,-hole_diameter - plate_height*2, -wall_thickness/2])
RodStart2(hole_diameter - (nozzle_diameter * 2), spool_width * 0.8, wall_thickness, hole_diameter + plate_height- (nozzle_diameter * 2), 20,0,0);
translate([0,-hole_diameter - plate_height*2, spool_width / 2 - wall_thickness])
cylinder(h=spool_width,
      r=(hole_diameter / 2) /2, $fn=6,
      center=true);
}

//Rod End
difference() {
translate([hole_diameter*2,-hole_diameter - plate_height*2, -wall_thickness/2])
RodEnd2(hole_diameter - (nozzle_diameter * 2), spool_width * 0.8, hole_diameter + plate_height- (nozzle_diameter * 2), wall_thickness);

translate([hole_diameter*2,-hole_diameter - plate_height*2, spool_width / 2 - wall_thickness]) 
cylinder(h=spool_width,
      r=(hole_diameter / 2) /2, $fn=6,
      center=true);
}

module Plate(is_first){
  
   Base(false, is_first);
    if(split_base){
        mirror([0,1,0]) 
        translate([0,-half_plate_width - nozzle_diameter])
        Base(true, is_first);
    } else {
        mirror([0,1,0]) 
        translate([0,-half_plate_width]) 
        Base(true, is_first);
    }
    
    
   echo("Half_plate_width is ", half_plate_width);
}

module TheTool(){
    translate([0,0,5])
    cube([10, hole_diameter * 0.8, 10], center = true);
    translate([0,0,10])
    cylinder(h=20,
      r=(hole_diameter / 2) /2 - nozzle_diameter, $fn=6,
      center=true);
    }

module Handle_part_base(is_second_half){
    translate([0,0,wall_thickness])
    cylinder(h = handle_distance + handle_diameter + handle_margin, r = hole_radius + plate_height, $fn=render_quality*hole_radius, center = false);
    
    //Handle
    if(!separate_handle){
        translate([0,0,wall_thickness + handle_distance + handle_diameter/2])
        rotate([-90,0,0])
        cylinder(h = spool_radius + (split_base?0:nozzle_diameter), r = handle_diameter/2, $fn=render_quality*hole_radius, center = false);
        if(split_base){
            if(!is_second_half){
                translate([0,spool_radius,wall_thickness + handle_distance + handle_diameter/2])
            rotate([-90,0,0])
            cylinder(h = connector_size, r = handle_diameter/4, $fn=render_quality*hole_radius, center = false);
            }
               
        }
    }
    
    
    //Handle chamfer
    translate([0,hole_radius+plate_height/4,wall_thickness + handle_distance + handle_diameter/2])
    rotate([-90,0,0])
    cylinder(h = handle_champfer, r1 = handle_champfer, r2 = handle_diameter/2, $fn=render_quality*hole_radius, center = false);
 }

module Handle_part_base_cut(is_second_half){
    translate([0,0,wall_thickness - 0.01])
    cylinder(h = handle_distance + handle_diameter + handle_margin*2 + 0.005, r = hole_radius + plate_height/2 - nozzle_diameter, $fn=render_quality*hole_radius, center = false);
//    translate([-hole_radius - plate_height,-hole_radius - plate_height,wall_thickness - 0.01])
//    cube([(hole_diameter + (plate_height * 2)), hole_radius + plate_height, handle_distance + handle_diameter + 1], center = false);
    
    translate([0,holder_top_fillet,handle_distance + handle_diameter + wall_thickness - holder_top_fillet + handle_margin])
    rotate([0,90,0])
    QuartTube(holder_top_fillet*3, holder_top_fillet, hole_diameter + plate_height * 2);
    
    translate([0,-holder_bottom_fillet, wall_thickness + holder_bottom_fillet])
    rotate([180,-90,0])
    QuartCylinder(holder_bottom_fillet,hole_diameter + plate_height * 2);
    
    translate([-hole_radius - plate_height,-hole_radius - plate_height,wall_thickness])
    cube([hole_diameter + plate_height * 2, hole_radius + plate_height - holder_bottom_fillet, handle_distance + handle_diameter + handle_margin], center = false);
    
    translate([-hole_radius - plate_height,-hole_radius - plate_height,wall_thickness + holder_bottom_fillet])
    cube([hole_diameter + plate_height * 2, hole_radius + plate_height, handle_distance + handle_diameter - holder_top_fillet - holder_bottom_fillet + handle_margin + 0.005], center = false);
    
    if(hollow_base){
       translate([-hole_radius,0,wall_thickness - handle_margin])
       cube([hole_diameter, hole_diameter + plate_height*2, handle_distance - hole_radius], center = false);
        translate([0,0,handle_distance - hole_radius + wall_thickness - handle_margin])
        rotate([-90,0,0])
        cylinder(h = hole_diameter + plate_height*2, r = hole_radius, $fn=render_quality*hole_radius, center = false);
     }
     translate([-hole_radius-plate_height,-hole_radius-plate_height,wall_thickness + handle_distance+handle_diameter + handle_margin])
     cube([hole_diameter + plate_height*2,hole_diameter*2 + plate_height*2,100]);
     
     if(is_second_half){
            translate([0,spool_radius-connector_size + 0.005,wall_thickness + handle_distance + handle_diameter/2])
        rotate([-90,0,0])
        cylinder(h = connector_size, r = handle_diameter/4 + nozzle_diameter, $fn=render_quality*hole_radius, center = false);
        }
        
    //Handle
    if(separate_handle){
        translate([0,hole_radius,wall_thickness + handle_distance + handle_diameter/2])
        rotate([-90,0,0])
        cylinder(h = spool_diameter/2 - hole_diameter + (split_base?0:nozzle_diameter), r = handle_diameter/2 + nozzle_diameter, $fn=render_quality*hole_radius, center = false);
    }
    //translate([0,0,handle_distance + handle_diameter])
    //rotate([holder_base_chamfer_angle,0,0])
    //cube([hole_diameter + plate_height*2, 200, holder_base_chamfer], center = true);
}

module QuartTube(outer_radius, inner_radius, height){
    difference(){
        cylinder(h = height, r = outer_radius, $fn=render_quality*outer_radius, center = true);    cylinder(h = height + 1, r = inner_radius, $fn=render_quality*inner_radius, center = true);
        translate([outer_radius/2,0,0])
        cube([outer_radius,outer_radius*2, height + 1], center = true);
        translate([0,outer_radius/2,0])
        cube([outer_radius*2,outer_radius, height + 1], center = true);
    }
}

module QuartCylinder(radius, height){
    difference(){
        cylinder(h = height, r = radius, $fn=render_quality*radius, center = true);   
        translate([radius/2,0,0])
        cube([radius,radius*2, height + 1], center = true);
        translate([0,radius/2,0])
        cube([radius*2,radius, height + 1], center = true);
    }
}

module Connectors(is_second_half = false){
    for (i=[0:number_of_connectors - 1]){
       translate([i*(connector_size * 2),0,0])
        if(is_second_half){ // here
            translate([nozzle_diameter - nozzle_diameter * 2,0,-wall_thickness/2 + nozzle_diameter])
            cube([connector_size + nozzle_diameter * 2, connector_size, wall_thickness], center = false);
            translate([-connector_size + (i == 0?0:-nozzle_diameter),0,wall_thickness/2])
            cube([connector_size + (i == 0?nozzle_diameter:nozzle_diameter*2), connector_size, wall_thickness], center = false);
            
        } else {
            translate([0,0,-wall_thickness / 2 + nozzle_diameter])
            cube([connector_size, connector_size, wall_thickness], center = false);
            translate([connector_size,0,wall_thickness/2])
            cube([connector_size, connector_size, wall_thickness], center = false);
        }
      
    }
}

module Base(is_second_half, is_first){
   if(is_first){
    difference(){
       Handle_part_base(is_second_half);
       Handle_part_base_cut(is_second_half);
    }   
    }
    difference() {
        Base_part();
        //test joints
        //translate([-50,-50,-25])
        //#cube([100, 100, 100], center = false);
        cylinder(h = wall_thickness + 1, r = hole_radius + nozzle_diameter, $fn=render_quality*hole_radius, center = false);
        if(hollow_plate){
            translate([-hole_diameter/2,0,0])
           cube([hole_diameter, half_plate_width/2 - (split_base?plate_height:plate_height/2), wall_thickness+1], center = false);     
        }
        if(split_base){
                if(is_second_half){
                    translate([- hole_radius - plate_height + connector_size, (half_plate_width / 2) - connector_size,0])
                    Connectors(is_second_half);
                } else {
                    translate([- hole_radius - plate_height, (half_plate_width / 2) - connector_size,0])
                    Connectors(is_second_half);
                }
            }
    }
    if(hollow_plate){
        difference(){
            cylinder(h = wall_thickness, r = hole_radius + plate_height, $fn=render_quality*hole_radius, center = false);
            cylinder(h = wall_thickness + 1, r = hole_radius + nozzle_diameter, $fn=render_quality*hole_radius, center = false);
         }
        
    }
}

module Base_part(){
    cylinder(h = wall_thickness, r = hole_radius + plate_height, $fn=render_quality*hole_radius, center = false);
    translate([-hole_radius - plate_height,0,0])
    cube([(hole_diameter + (plate_height * 2)), half_plate_width / 2, wall_thickness], center = false);
}