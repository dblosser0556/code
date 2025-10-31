use <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
//function to store card box dimensions and other parameters
//used by other parts






module LargeScissorBar(dimensions){
    //get the dimensions values
    part_thickness = dict_lookup("part_thickness",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    side_offset = dict_lookup("side_offset",dimensions);
    large_scissor_bar_length = dict_lookup("large_scissor_bar_length",dimensions);  
    large_scissor_bar_width = dict_lookup("large_scissor_bar_width",dimensions) - 2 * part_thickness;
    pin_hole_diameter = dict_lookup("pin_hole_diameter",dimensions);
    
    difference() {
        union(){
            //build the first scissor bar
            translate([part_thickness,0,part_height])rotate([0,180,0])scissor_bar(dimensions, large_scissor_bar_length);
            //build the connector bars
            translate([part_thickness,part_height/2,part_height/2])rotate([0,90,0])cylinder(h=large_scissor_bar_width,d=part_height);
            translate([part_thickness,large_scissor_bar_length - part_height/2,part_height/2])
                rotate([0,90,0])cylinder(h=large_scissor_bar_width,d=part_height);
            //build the second scissor bar
            translate([large_scissor_bar_width + part_thickness,0,0])scissor_bar(dimensions, large_scissor_bar_length);
            //add the hook 
            translate([(large_scissor_bar_width + 3 * part_thickness)/2,part_height,part_height/3*2])rotate([0,0,180])hook(dimensions);
        }
        //remove the pin holes
        //scissor_bar_length is the total length including the the two half circles on the end
        translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(h=large_scissor_bar_width * 2,d=pin_hole_diameter);
        translate([0,large_scissor_bar_length/2,part_height/2])rotate([0,90,0])cylinder(h=part_thickness * 2,d=pin_hole_diameter);
        translate([large_scissor_bar_width,large_scissor_bar_length/2,part_height/2])rotate([0,90,0])cylinder(h=part_thickness * 2,d1=pin_hole_diameter, d2=pin_hole_diameter - pin_hole_diameter * 0.2);

        translate([0,large_scissor_bar_length - part_height/2, part_height/2])rotate([0,90,0])cylinder(h=large_scissor_bar_width * 2,d=pin_hole_diameter);
    }
}
LargeScissorBar(get_dimensions());