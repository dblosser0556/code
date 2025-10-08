// CardDimensions.scad
//holds all the dimensions and parameters for the card box and lift mechanism
//to be included in all parts

$fn=64; //number of facets for circles
//free_space - give a little space around cards and parts to allow for tolerances
free_space = .5;

//playing card dimensions mm
card_width = 63.5;  //2.5"
card_length = 89 ;  //3.5"
card_corner_radius = 3;  //tried 4  
card_thickness = 0.33;
card_deck_height = card_thickness * 52 + free_space*2;

//walls in mm
wall_thickness = 1.5;

//all parts will be made to the same height.  
part_height = 6;
part_thickness = 6;

//the diameter of the pin in the scissor lift mechanism
//this is also the diameter of the holes in the scissor bars
pin_diameter = part_height/2;
pin_hole_diameter = (part_height/2)/cos(180/$fn);

//scissor lift height is twice the part height plus a little extra
//to allow for some movement
scissor_lift_gap = part_height + 2;

//internal and external dimensions of card box 
card_box_inside_width = card_width + free_space;
card_box_inside_length = card_length + free_space;
card_box_inside_height = card_deck_height + scissor_lift_gap + wall_thickness + free_space;
card_box_outside_width = card_box_inside_width + 2 * wall_thickness;
card_box_outside_length = card_box_inside_length + 2 * wall_thickness;
card_box_outside_height = card_box_inside_height + wall_thickness;
card_box_corner_radius = card_corner_radius + wall_thickness;


//outside dimmesions of the box outside that holds the card box and lift mechanism
box_outside_width = card_box_outside_width + 2 * wall_thickness;
box_outside_length = card_box_outside_length + 2 * wall_thickness;
box_outside_height = card_box_outside_height + 2 * wall_thickness;
box_corner_radius = card_box_corner_radius + wall_thickness;

//spaces for lift mechanism
side_offset = part_thickness/2;
base_offset = 4;

//calulate the dimensions of the slide holder
//the length of the slide holder is the diffence between the x values of the scissor bar when 
//the scissor is laid flat and when it is fully extended.
//fully extended is then the card support is at the top of the card box.
//first calculate the length of the large scissor bar
large_scissor_bar_length = card_box_inside_length - 2 * base_offset;
//the small scissor bar sits inside the large scissor bar so it is shorter by 2 * part_thickness 
//add the free space to allow for tolerances
small_scissor_bar_length =card_box_inside_length - 2 * base_offset - 2 * part_thickness - free_space;
//then calculate the length of the slide holder
//using pythagorean theorem
//a^2 + b^2 = c^2
//a = card_box_inside_height
//c = large_scissor_bar_length
//b = sqrt(c^2 - a^2)
//slide_length = c - b
large_scissor_bar_slide_length = large_scissor_bar_length - sqrt( pow(large_scissor_bar_length,2) - pow(card_box_inside_height,2) ) + part_height;
small_scissor_bar_slide_length = small_scissor_bar_length - sqrt( pow(small_scissor_bar_length,2) - pow(card_box_inside_height,2) ) + part_height;

echo("large_scissor_bar_slide_length", large_scissor_bar_slide_length, "small_scissor_bar_slide_length", small_scissor_bar_slide_length);

function get_dimensions() = [
    ["card_width", card_width],
    ["card_length", card_length],
    ["card_corner_radius", card_corner_radius],
    ["card_thickness", card_thickness],
    ["card_deck_height", card_deck_height],
    ["wall_thickness", wall_thickness],
    ["part_height", part_height],
    ["part_thickness", part_thickness],
    ["pin_diameter", pin_diameter],
    ["pin_hole_diameter", pin_hole_diameter],
    ["scissor_lift_gap", scissor_lift_gap],
    ["free_space", free_space],
    ["card_box_inside_width", card_box_inside_width],
    ["card_box_inside_length", card_box_inside_length],
    ["card_box_inside_height", card_box_inside_height],
    ["card_box_outside_width", card_box_outside_width],
    ["card_box_outside_length", card_box_outside_length],
    ["card_box_outside_height", card_box_outside_height],
    ["card_box_corner_radius", card_box_corner_radius],
    ["side_offset", side_offset],
    ["base_offset", base_offset],
    ["box_outside_width", box_outside_width],
    ["box_outside_length", box_outside_length],
    ["box_outside_height", box_outside_height],
    ["box_corner_radius", box_corner_radius],
    ["large_scissor_bar_length", large_scissor_bar_length],
    ["small_scissor_bar_length", small_scissor_bar_length],
    ["large_scissor_bar_slide_length", large_scissor_bar_slide_length],
    ["small_scissor_bar_slide_length", small_scissor_bar_slide_length]
];
