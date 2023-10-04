// StarLink Extras for Spool cable wire winder v2.5
// Written by Sayko R. <roman.sayko@gmail.com>

use <threads.scad>


// Diameter of the hole of spool
hole_diameter = 35.0;

//Thickness of the wall
wall_thickness = 3.5;
//before final render set it to 24, for debugging 6 is ok
render_quality = 6;//[1:24]
//Diameter of the printer's nozzle, also used for tollerance
nozzle_diameter = 0.4; 

difference() {
    //translate([5.4/1.5,0,0])
    SWTool_long(48);
    translate([-5.4/2,0,-0.01])
   Slot(5.4,5.4,46);
}


translate([0,30,0])
difference() {
    //translate([13/4,0,0])
    SWTool_long(29);
    translate([-5.6/2,0,-0.01])
   Slot(4,5.6,27);
}

module SWTool_long(height){
    cylinder(h=1,
              r=(hole_diameter / 2) /2 + nozzle_diameter*2, $fn=6,
              center=false);
    cylinder(h=height,
              r=(hole_diameter / 2) /2 - nozzle_diameter, $fn=6,
              center=false);
    translate([0,0,wall_thickness + nozzle_diameter*2])
    cylinder(h=nozzle_diameter,
              r=(hole_diameter / 2) /2, $fn=6,
              center=false);
    translate([0,0,wall_thickness*3 + nozzle_diameter*2])
    cylinder(h=nozzle_diameter,
              r=(hole_diameter / 2) /2, $fn=6,
              center=false);
    //cube([hole_diameter/4-1,hole_diameter/2-3,nozzle_diameter*2], center = true);
}

module Slot(r=10, d=15, h=50){
    cylinder(h=h, r=r, $fn=render_quality*d/2, center=false);
    translate([d,0,0])
    cylinder(h=h, r=r, $fn=render_quality*r, center=false);
    translate([0,-r,0])
    cube([d, r*2, h], center = false);
}