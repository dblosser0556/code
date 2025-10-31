// CardDeckSupport.scad
//this part raises the card deck to the top so they can be delt.
use <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
//use <../modules/mRoundedCorners.scad>
use <../modules/mCardHolderModules.scad>
include <BOSL2/std.scad> //for minkowski

module CardDeckSupport (dimensions) {
    //get the dimensions values

    wall_thickness = dict_lookup("wall_thickness",dimensions);
    card_width = dict_lookup("card_width",dimensions);
    card_length = dict_lookup("card_length",dimensions);
    card_corner_radius = dict_lookup("card_corner_radius",dimensions);
    side_offset = dict_lookup("side_offset",dimensions);
    base_offset = dict_lookup("base_offset",dimensions);
    card_box_inside_length = dict_lookup("card_box_inside_length",dimensions);
    card_box_inside_width = dict_lookup("card_box_inside_width",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    
    free_space = dict_lookup("free_space",dimensions);
    //width and length of the scissor bars
    large_scissor_bar_width = dict_lookup("large_scissor_bar_width",dimensions);
    small_scissor_bar_width = dict_lookup("small_scissor_bar_width",dimensions);
    small_scissor_bar_length = dict_lookup("small_scissor_bar_length",dimensions);
    small_scissor_bar_slide_length = dict_lookup("small_scissor_bar_slide_length",dimensions);
    
    
    translate([card_width/2, card_length/2, wall_thickness/2])cuboid([card_width, card_length, wall_thickness], rounding = card_corner_radius, edges = "Z", $fn=64);
    translate([card_width/2, card_length/2, wall_thickness/2])rect_tube(size=[card_width, card_length], wall=wall_thickness, h=wall_thickness, rounding = card_corner_radius, $fn=64);
    // add the lift mechanism holders  
    //place both slides on the deck support.
    // the base holders are for the large scissor bar  
    translate([side_offset, base_offset, wall_thickness])slide_holder(dimensions, "large", "right");
    translate([side_offset + part_thickness + large_scissor_bar_width, base_offset, wall_thickness])slide_holder(dimensions, "large", "left");
    
     // the base holders are for the small scissor bar    
    translate([side_offset + 2 * part_thickness + free_space, 
        base_offset + small_scissor_bar_length, wall_thickness])
        base_holder(dimensions, true, 0);
    translate([side_offset + 3 * part_thickness + free_space + small_scissor_bar_width, 
        base_offset + small_scissor_bar_length,wall_thickness])
        base_holder(dimensions, true,0.2);
        
}

//test code
CardDeckSupport(get_dimensions());

