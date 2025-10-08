include <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
use <../modules/mRoundedCorners.scad>
use <../modules/mCardHolderModules.scad>



module CardHolder(dimensions) {
    //get the dimensions values

    wall_thickness = dict_lookup("wall_thickness",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    side_offset = dict_lookup("side_offset",dimensions);
    base_offset = dict_lookup("base_offset",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    card_corner_radius = dict_lookup("card_corner_radius",dimensions);
    card_thickness = dict_lookup("card_thickness",dimensions);
    card_box_outside_width = dict_lookup("card_box_outside_width",dimensions);
    card_box_outside_length = dict_lookup("card_box_outside_length",dimensions);
    card_box_outside_height = dict_lookup("card_box_outside_height",dimensions);
    card_box_inside_width = dict_lookup("card_box_inside_width",dimensions);
    card_box_inside_length = dict_lookup("card_box_inside_length",dimensions);
    card_box_inside_height = dict_lookup("card_box_inside_height",dimensions);
    large_scissor_bar_slide_length = dict_lookup("large_scissor_bar_slide_length",dimensions);
    
    
    difference(){
        color("blue") card_box_outside_box(dimensions);   
        translate([wall_thickness,wall_thickness,wall_thickness])color("green") card_deck_space(dimensions);
        translate([wall_thickness,card_box_outside_length - card_corner_radius, card_box_outside_height - card_thickness ])card_hole(dimensions); 
        };
    // add the lift mechanism holders
    // the base holders are for the small scissor bar which fits inside the large scissor bar   
    translate([side_offset + 2 * part_thickness + free_space, base_offset + part_thickness + free_space/2,wall_thickness])base_holder(dimensions);
    translate([card_box_inside_width - side_offset - 3 * part_thickness, base_offset + part_thickness + free_space/2,wall_thickness])base_holder(dimensions);
    // the slide holders are for the large scissor bar
    translate([side_offset,card_box_inside_length - large_scissor_bar_slide_length - base_offset,wall_thickness])slide_holder(dimensions, "large");
    translate([card_box_inside_width - side_offset - part_thickness,card_box_inside_length -base_offset - large_scissor_bar_slide_length, wall_thickness])slide_holder(dimensions, "large");

}


