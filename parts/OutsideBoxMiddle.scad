use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>

//creates the middle part of the box that holds the card box and lift mechanism
module OutsideBoxMiddle(dimensions) {
    difference(){
        build_outside_box(dimensions);
        translate([-10,-10, dict_lookup("box_outside_height",dimensions) - dict_lookup("wall_thickness",dimensions)])cube([dict_lookup("box_outside_width",dimensions)*2,dict_lookup("box_outside_length",dimensions)*2,dict_lookup("wall_thickness",dimensions)]);
        translate([-10,-10, 0])cube([dict_lookup("box_outside_width",dimensions)*2,dict_lookup("box_outside_length",dimensions)*2,dict_lookup("wall_thickness",dimensions)]);
        
    }
}