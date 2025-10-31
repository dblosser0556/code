// CardDeckSupportbTM.scad
//this part raises the card deck to the top so they can be delt.
//this is the bottom part of the deck support
//it has the base holders for the scissor lift mechanism
//this is version 2 which uses metal inserts for to keep the scissor bars in place
use <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
include <BOSL2/std.scad> //for minkowski

module CardDeckSupportBtm(dimensions) {
    //get the dimensions values

    wall_thickness = dict_lookup("wall_thickness",dimensions);
    card_width = dict_lookup("card_width",dimensions);
    card_length = dict_lookup("card_length",dimensions);
    card_corner_radius = dict_lookup("card_corner_radius",dimensions);
    side_offset = dict_lookup("side_offset",dimensions);
    base_offset = dict_lookup("base_offset",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    
    free_space = dict_lookup("free_space",dimensions);
    //width and length of the scissor bars
    large_scissor_bar_width = dict_lookup("large_scissor_bar_width",dimensions);
    large_scissor_bar_length = dict_lookup("large_scissor_bar_length",dimensions);
    small_scissor_bar_width = dict_lookup("small_scissor_bar_width",dimensions);
    small_scissor_bar_length = dict_lookup("small_scissor_bar_length",dimensions);
    
    
    difference(){
        union(){
            translate([card_width/2, card_length/2, wall_thickness/2])cuboid([card_width, card_length, wall_thickness], rounding = card_corner_radius, edges = "Z", $fn=64);
            translate([card_width/2, card_length/2, wall_thickness/2])rect_tube(size=[card_width, card_length], wall=wall_thickness, h=wall_thickness, rounding = card_corner_radius, $fn=64);
        }
        //translate([card_width/8*3,card_length/4,0])thumb_hole(dimensions);
    }
    
    // add the lift mechanism holders
   

    // the slide holders are for the small scissor bar - which fits inside the large scissor bar
     translate([side_offset + 2 * part_thickness + free_space, 
        base_offset + part_height + free_space/2,wall_thickness])
        slide_holder(dimensions, "small", "right");
    translate([side_offset + 3 * part_thickness + free_space + small_scissor_bar_width, 
        base_offset + part_height + free_space/2,wall_thickness])
        slide_holder(dimensions, "small", "right");

    
    // the base holders are for the large scissor bar
    translate([side_offset, 
        base_offset + large_scissor_bar_length - part_height,wall_thickness])base_holder(dimensions, true);
    translate([side_offset + part_thickness + large_scissor_bar_width, 
        base_offset + large_scissor_bar_length - part_height,wall_thickness])base_holder(dimensions, true, 0.2);
}

//test code
CardDeckSupportBtm(get_dimensions());

