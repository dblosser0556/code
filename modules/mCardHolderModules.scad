
use <mUtilityFunction.scad>
use <mRoundedCorners.scad>

$fn = 64;
module snap_fit_pivot(stem_length=3, stem_radius=1.5, head_length=2 ){
    tip_bulge = 0.25;
    tip_radius = stem_radius * (1 + tip_bulge);
    difference(){
        union(){
            cylinder(h=stem_length,r=stem_radius);    
            translate([0,0,stem_length])cylinder(h=head_length*.25,r1=stem_radius,r2=tip_radius);
            translate([0,0,stem_length + head_length*.25 ])cylinder(h=head_length*.35,r1=tip_radius,r2=tip_radius);
            translate([0,0,stem_length + head_length * .6 ])cylinder(h=head_length*.40,r1=tip_radius,r2=stem_radius);
        }
        translate([-stem_radius*.2,-tip_radius,0])cube([stem_radius*(2*tip_bulge),tip_radius*2,stem_length+head_length]);
            
    }
}

//functions to buld the outside box and cutouts
module card_holder_space(dimensions) {   
    cube([dict_lookup("card_box_outside_width",dimensions), dict_lookup("card_box_outside_length",dimensions), dict_lookup("card_box_outside_height",dimensions)]);
    }

module thumb_hole(dimensions){
   
    box_outside_width = dict_lookup("box_outside_width",dimensions);
    box_outside_length = dict_lookup("box_outside_length",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);

    union(){
        cube([box_outside_width/4,box_outside_length/2,wall_thickness*2]);
        translate([box_outside_width/8,box_outside_length/2,0])cylinder(wall_thickness*2,d=box_outside_width/4);
        translate([box_outside_width/8,0,0])cylinder(wall_thickness*2,d=box_outside_width/4);
    }
}

module card_holder_cutout(dimensions){
    cube([dict_lookup("card_box_outside_width",dimensions),dict_lookup("wall_thickness",dimensions)*4,dict_lookup("card_box_outside_height",dimensions)]);
}

module card_holder_pushout_hole(dimensions){
    rotate([90,0,0])cylinder(dict_lookup("wall_thickness",dimensions)*4, r = dict_lookup("box_outside_height",dimensions)/4);
}

module card_deal_slot(dimensions) {
    cube([dict_lookup("card_box_outside_width",dimensions),dict_lookup("card_corner_radius",dimensions) * 2,dict_lookup("card_thickness",dimensions) * 1.5],false);
}

module outside_box(dimensions) {
    box_outside_width = dict_lookup("box_outside_width",dimensions);
    box_outside_length = dict_lookup("box_outside_length",dimensions);
    box_outside_height = dict_lookup("box_outside_height",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);

    union() {
        cube([box_outside_width, box_outside_length, box_outside_height]);
 
        //add screw - nudge out so full opening can be had for card holder
       screw_holder_radius = 2;
       nudge = screw_holder_radius - wall_thickness; 
       translate([box_outside_width + nudge, box_outside_length + nudge,0])screw_holder(box_outside_height,screw_holder_radius);
       translate([box_outside_width + nudge,-(nudge),0])screw_holder(box_outside_height,screw_holder_radius);
       translate([-(nudge),box_outside_length + nudge,0])screw_holder(box_outside_height,screw_holder_radius);
       translate([-(nudge),-(nudge),0])screw_holder(box_outside_height,screw_holder_radius);
    }
}

module build_outside_box(dimensions) {

    box_outside_width = dict_lookup("box_outside_width",dimensions);
    box_outside_length = dict_lookup("box_outside_length",dimensions);
    box_outside_height = dict_lookup("box_outside_height",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);
    card_thickness = dict_lookup("card_thickness",dimensions);

    difference(){
        outside_box(dimensions);
        translate([wall_thickness,wall_thickness,wall_thickness])card_holder_space(dimensions);
        translate([box_outside_width/8*3,box_outside_length/4,box_outside_height-wall_thickness*2])thumb_hole(dimensions);
        translate([wall_thickness,box_outside_length-wall_thickness,wall_thickness])card_holder_cutout(dimensions);
        translate([box_outside_width/2,wall_thickness,box_outside_height/2])card_holder_pushout_hole(dimensions);
        translate([wall_thickness,0,box_outside_height-wall_thickness - card_thickness*1.5])card_deal_slot(dimensions);
    }

}
//modules to build the card box, card deck, and holddowns for the lift mechanism
//create the base holder 
module base_holder(dimensions){
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);

    pin_diameter = part_height/2;
    difference(){
        union(){
            cube([part_thickness, part_height, free_space]);
            translate([0,0,free_space])cube([part_thickness, part_height, part_height/2]);
            translate([0, part_height/2, part_height/2 + free_space ])rotate([0,90,0])cylinder(part_thickness,d=part_height);
        }
        translate([0, part_height/2, part_height/2 + free_space ])rotate([0,90,0])cylinder(part_thickness,d=pin_diameter);
    }
}


//slide holder
module slide_holder(dimensions, type){
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    pin_diameter = dict_lookup("pin_diameter",dimensions);

    //determine the length of the slide holder based on the type
    slide_holder_length = (type == "large") ? dict_lookup("large_scissor_bar_slide_length",dimensions) : dict_lookup("small_scissor_bar_slide_length",dimensions);
 
    difference(){
        union(){
            cube([part_thickness, slide_holder_length + part_height, free_space + part_height/2]);
            translate([0,0,free_space])
            union(){
            translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([0,part_height/2,0])cube([part_thickness, slide_holder_length, part_height]);
            translate([0,part_height/2 + slide_holder_length,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            }
        }
        translate([0,0,free_space])
        union(){
            translate([0, part_height/2, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=pin_diameter);
            translate([0,part_height/2,(part_height-pin_diameter)/2])cube([part_thickness, slide_holder_length, pin_diameter]);
            translate([0,part_height/2 + slide_holder_length, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=pin_diameter);
        }
    }
}

module card_box_outside_box(dimensions) {
    card_box_corner_radius = dict_lookup("card_box_corner_radius",dimensions);
    card_box_outside_width = dict_lookup("card_box_outside_width",dimensions);
    card_box_outside_length = dict_lookup("card_box_outside_length",dimensions);
    card_box_outside_height = dict_lookup("card_box_outside_height",dimensions);
    //create the overall box
    roundedcube([card_box_outside_width,card_box_outside_length,card_box_outside_height],false, card_box_corner_radius, "z");
    }


module card_deck_space(dimensions) {  
    card_corner_radius = dict_lookup("card_corner_radius",dimensions);
    card_box_inside_width = dict_lookup("card_box_inside_width",dimensions);
    card_box_inside_length = dict_lookup("card_box_inside_length",dimensions);
    card_box_inside_height = dict_lookup("card_box_inside_height",dimensions);
    //create the space for the card deck
    roundedcube([card_box_inside_width, card_box_inside_length, card_box_inside_height], false, card_corner_radius,"z");
}

module card_hole(dimensions) {
    cube([dict_lookup("card_width",dimensions),dict_lookup("card_corner_radius", dimensions) * 2,dict_lookup("card_thickness",dimensions)],false);
}

//modules call be the scissor lift parts
module hook(dimensions){
    pin_diameter = dict_lookup("pin_diameter",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);

    difference(){
        base_holder(dimensions);
        translate([0, part_height/2, part_height/4 + free_space ])cube([part_thickness, part_height, pin_diameter]);
    }
}


module scissor_end(dimensions, type, free_space){
    pin_diameter = dict_lookup("pin_diameter",dimensions);
    pin_hole_diameter = dict_lookup("pin_hole_diameter",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);

    echo("pin_diameter", pin_diameter, "pin_hole_diameter", pin_hole_diameter);
    echo("part_height", part_height, "part_thickness", part_thickness);


    if (type == "open") {
        difference(){
            translate([0,0,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([0,0,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=pin_hole_diameter);
        }
    }
    if (type == "joiner"){     
        union(){
            translate([0,0,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([part_thickness,0,part_height/2])rotate([0,90,0])snap_fit_pivot(stem_length=part_thickness,stem_radius=pin_diameter/2,head_length=part_thickness/2);
        }
    }
    if (type == "pivot"){
        union(){
            translate([0,0,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([part_thickness,0,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=pin_diameter);
        }
    }
     if (type == "rounded_joiner"){
        union(){
            translate([0,0,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([part_thickness,0,part_height/2])cylinder(free_space,d=pin_diameter);
            translate([part_thickness + free_space,0,part_height/2])sphere(d=pin_diameter);
        }
    }

}

module scissor_bar(dimensions, scissor_bar_length, type=[1,3,2]){
    //get the dimensions values
   
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    
    union(){
         difference(){
            //we add .5 part height to each end so the length of the cube needs to be shortened by one part height
            translate([0,part_height/2,0])cube([part_thickness,scissor_bar_length-part_height, part_height]);
            //cut the holes for the ends.  undercut a little so they fit better
            translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height-.05);
            translate([0,scissor_bar_length/2,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height-.05);
            translate([0,scissor_bar_length - part_height/2, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height-.05);
        }
        //cylinders alway work around thier center so the add material to both sides of thier center
        //scissor_bar_length is the total length including the the two half circles on the end
        //add the 2 ends and the middle types of joints
        translate([0,part_height/2,0]){
            if (type[0] == 1) scissor_end(dimensions,"pivot");
            if (type[0] == 2) scissor_end(dimensions,"joiner");
            if (type[0] == 3) scissor_end(dimensions,"open");
            if (type[0] == 4) scissor_end(dimensions,"rounded_joiner");
        }
        translate([0,scissor_bar_length/2,0]){
            if (type[1] == 1) scissor_end(dimensions,"pivot");
            if (type[1] == 2) scissor_end(dimensions,"joiner");
            if (type[1] == 3) scissor_end(dimensions,"open");
            if (type[1] == 4) scissor_end(dimensions,"rounded_joiner");
            }
        translate([0,scissor_bar_length-part_height/2,0]){
            if (type[2] == 1) scissor_end(dimensions,"pivot");
            if (type[2] == 2) scissor_end(dimensions,"joiner");
            if (type[2] == 3) scissor_end(dimensions,"open");
            if (type[2] == 4) scissor_end(dimensions,"rounded_joiner");
            }
       

    }
}
