use <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
//function to store card box dimensions and other parameters
//used by other parts




module SmallScissorBar(dimensions){
    //get the dimensions values
    part_thickness = dict_lookup("part_thickness",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    side_offset = dict_lookup("side_offset",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    pin_hole_diameter = dict_lookup("pin_hole_diameter",dimensions);

    small_scissor_bar_length = dict_lookup("small_scissor_bar_length",dimensions);  
    small_scissor_bar_width = dict_lookup("small_scissor_bar_width", dimensions) - 2 * part_thickness;
    
    
    difference() {
    union(){
        //generate the first scissor bar
        translate([2*part_thickness,0,part_height])rotate([0,180,0])scissor_bar(dimensions,small_scissor_bar_length);
        //generate the connecting bar
        translate([2*part_thickness,part_height/2,part_height/2])rotate([0,90,0])cylinder(h=small_scissor_bar_width,d=part_height);
        //generate the middle connecting bar
        translate([0,small_scissor_bar_length/2,part_height/2])rotate([0,90,0])cylinder(h=small_scissor_bar_width + 4 * part_thickness,d=part_height);
        //generate the last connecting bar
        translate([2*part_thickness,small_scissor_bar_length - part_height/2, part_height/2])rotate([0,90,0])cylinder(h=small_scissor_bar_width,d=part_height);
        //generate the last scissor bar
        translate([2*part_thickness + small_scissor_bar_width,0,0])scissor_bar(dimensions,small_scissor_bar_length);
        //generate the hook
        translate([(small_scissor_bar_width + 5 * part_thickness)/2,part_height,part_height/3*2])rotate([0,0,180])hook(dimensions);
        
        

        
    }
      //remove the pin holes
        //scissor_bar_length is the total length including the the two half circles on the end
    translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(h=small_scissor_bar_width * 2,d=pin_hole_diameter);
    translate([0,small_scissor_bar_length/2,part_height/2])rotate([0,90,0])cylinder(h=small_scissor_bar_width * 45,d=pin_hole_diameter);

    translate([part_thickness,small_scissor_bar_length - part_height/2, part_height/2])rotate([0,90,0])#cylinder(h=small_scissor_bar_width / 2,d1=pin_hole_diameter, d2=pin_hole_diameter * .8);
    translate([small_scissor_bar_width + 3 * part_thickness, small_scissor_bar_length - part_height/2, part_height/2])#rotate([0,270,0])cylinder(h=small_scissor_bar_width / 2,d1=pin_hole_diameter, d2=pin_hole_diameter * .8);
    }
}
SmallScissorBar(get_dimensions());