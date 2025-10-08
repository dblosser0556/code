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

    //this is the length of the bar that connects the two sides of the scissor lift
    //it needs to be shorter than the platform width to allow for the holders, thickness of the scissor bars, and the side offsets
    scissor_bar_width = dict_lookup("card_box_inside_width", dimensions) - 2 * (side_offset + 2 * part_thickness);
   
    union(){
        //build the first scissor bar
        translate([0,0,part_height])rotate([0,180,0])scissor_bar(dimensions, large_scissor_bar_length,[4,3,4]);
        //build the connector bars
        translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(h=scissor_bar_width,d=part_height);
        translate([0,large_scissor_bar_length - part_height/2,part_height/2])rotate([0,90,0])cylinder(h=scissor_bar_width,d=part_height);
        //build the second scissor bar
        translate([scissor_bar_width,0,0])scissor_bar(dimensions, large_scissor_bar_length, [4,3,4]);
        //add the hook 
        translate([scissor_bar_width/2 + part_thickness/2,part_thickness,part_height/3*2])rotate([0,0,180])hook(dimensions);
    }
}