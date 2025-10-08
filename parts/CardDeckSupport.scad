// CardDeckSupport.scad
//this part raises the card deck to the top so they can be delt.
use <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
use <../modules/mRoundedCorners.scad>
use <../modules/mCardHolderModules.scad>


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
    small_scissor_bar_slide_length = dict_lookup("small_scissor_bar_slide_length",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    
    echo("wall_thickness", wall_thickness, "card width", card_width, "card length ", card_length);
    
    //build the deck support
    difference(){
    translate([wall_thickness,wall_thickness,0]) roundedcube([card_width, card_length, 6],false,card_corner_radius,"z");
    translate([wall_thickness,wall_thickness,wall_thickness]) roundedcube([card_width, card_length, 6],false,card_corner_radius,"z");
    }
    // add the lift mechanism holders  
    // the base holders are for the large scissor bar  
    translate([side_offset,base_offset,1])base_holder(dimensions);
    translate([card_box_inside_width - side_offset - part_thickness,base_offset,1])base_holder(dimensions);
    // the slide holders are for the small scissor bar - which fits inside the large scissor bar
    translate([side_offset + 2 * part_thickness + free_space/2,card_box_inside_length - base_offset - part_thickness - small_scissor_bar_slide_length - free_space/2,
        wall_thickness])slide_holder(dimensions, "small");
    translate([card_box_inside_width - side_offset - 3 * part_thickness - free_space/2 ,card_box_inside_length - base_offset - part_thickness - small_scissor_bar_slide_length - free_space/2,
        wall_thickness])slide_holder(dimensions, "small");
}

CardDeckSupport(get_dimensions());

