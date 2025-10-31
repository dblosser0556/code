use <../CardDimensions.scad>
use <../modules/mUtilityFunction.scad>
use <mRoundedCorners.scad>
use <../modules/mCardHolderModules.scad>



module CardHolder(dimensions) {
    //get the dimensions values

    wall_thickness = dict_lookup("wall_thickness",dimensions);
    
   
    
    card_corner_radius = dict_lookup("card_corner_radius",dimensions);
    card_box_corner_radius = dict_lookup("card_box_corner_radius",dimensions);
    card_thickness = dict_lookup("card_thickness",dimensions);
    card_box_outside_width = dict_lookup("card_box_outside_width",dimensions);
    card_box_outside_length = dict_lookup("card_box_outside_length",dimensions);
    card_box_outside_height = dict_lookup("card_box_outside_height",dimensions);
    card_box_inside_width = dict_lookup("card_box_inside_width",dimensions);
    card_box_inside_length = dict_lookup("card_box_inside_length",dimensions);
    card_box_inside_height = dict_lookup("card_box_inside_height",dimensions);
    
    start = [-card_box_outside_length/2, -card_box_outside_width/2, -card_box_outside_height/2];
    
    difference(){
        
        cuboid([card_box_outside_width, card_box_outside_length, card_box_outside_height],rounding = card_box_corner_radius, edges = "Z");
        cuboid([card_box_inside_width, card_box_inside_length,card_box_inside_height], rounding = card_corner_radius,edges = "Z");
        translate([0,0,card_box_outside_height/2 - wall_thickness/2]) cuboid([card_box_inside_width, card_box_inside_length, card_box_inside_height], rounding = card_corner_radius,edges = "Z");
        translate([-card_box_inside_width/2, card_box_outside_length/2 - card_corner_radius, card_box_outside_height/2 - card_thickness ])#card_hole(dimensions); 
    
        };
    

}
CardHolder(get_dimensions());
