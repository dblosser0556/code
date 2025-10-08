use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
//function to store card box dimensions and other parameters
//used by other parts




module SmallScissorBar(dimensions){
    //get the dimensions values
    part_thickness = dict_lookup("part_thickness",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    small_scissor_bar_length = dict_lookup("small_scissor_bar_length",dimensions);  
    side_offset = dict_lookup("side_offset",dimensions);
    free_space = dict_lookup("free_space",dimensions);

    
    
    //this is the length of the bar that connects the two sides of the scissor lift
    //it needs to be shorter than the platform width to allow for the holders, thickness of the scissor bars, and the side offsets
    scissor_bar_width = dict_lookup("card_box_inside_width", dimensions) - 2 * (side_offset + 4 * part_thickness) - free_space;
   
    union(){
        //generate the first scissor bar
        translate([0,0,part_height])rotate([0,180,0])scissor_bar(dimensions,small_scissor_bar_length,[4,4,4]);
        //generate the connecting bar
        translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(h=scissor_bar_width,d=part_height);
        //generate the middle connecting bar
        translate([0,small_scissor_bar_length/2,part_height/2])rotate([0,90,0])cylinder(h=scissor_bar_width,d=part_height);
        //generate the last scissor bar
        translate([0,small_scissor_bar_length - part_height/2, part_height/2])rotate([0,90,0])cylinder(h=scissor_bar_width,d=part_height);
        //generate the last scissor bar
        translate([scissor_bar_width,0,0])scissor_bar(dimensions,small_scissor_bar_length,[4,4,4]);
        //generate the hook
        translate([scissor_bar_width/2 + part_thickness/2,part_thickness,part_height/3*2])rotate([0,0,180])hook(dimensions);
        //add the two middle pivots
        translate([-part_thickness,small_scissor_bar_length/2,0])rotate(a=180, v=[0,0,1])scissor_end(dimensions, "rounded_joiner");
        translate([scissor_bar_width + part_height,small_scissor_bar_length/2,0])scissor_end(dimensions, "rounded_joiner");
    }
}