use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>

//this create the top part for the box that holds the card box and lift mechanism
module OutsideBoxTop(dimensions) {
    difference(){
        build_outside_box(dimensions);
        translate([-10,-10,-dict_lookup("wall_thickness",dimensions)])cube([dict_lookup("box_outside_width",dimensions)*2,dict_lookup("box_outside_length",dimensions)*2,dict_lookup("box_outside_height",dimensions)]);
    }
   
}