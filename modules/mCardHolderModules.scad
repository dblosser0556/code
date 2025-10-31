use <../CardDimensions.scad>
use <mUtilityFunction.scad>
use <mRoundedCorners.scad>
include <BOSL2/std.scad> 

$fn = 64;
/* v2
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
*/
module square_screw_holder(length,side,hole_diameter){
    $fn = 32;  
    difference(){
        cube([side, side, length], center=false);
        translate([side/2, side/2, length/2])
            cylinder(h=length,d=hole_diameter, center=true );
    }
}

module screw_holder(height, outside_diameter, hole_diameter){
    $fn = 32;
    translate([0,0,height/2])
    difference(){
        cylinder(h=height, d=outside_diameter, center = true);
        cylinder(h=height, d=hole_diameter, center=true);
    }
}
module tappered_screw_head(head_diameter,screw_diameter, depth, taper = 45) {
    $fn=32;
    h = tan(taper)*((head_diameter - screw_diameter)/2);
    rotate([180,0,0])  //flip so the head is on top
    union(){
        cylinder(h=h,d1=head_diameter,d2=screw_diameter);
        cylinder(h=depth,d=screw_diameter);    
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


//modules to build the card box, card deck, and holddowns for the lift mechanism
//create the base holder 
module base_holder(dimensions, fillet, taper){
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    pin_hole_diameter = dict_lookup("pin_hole_diameter", dimensions);

    taper =  (taper == undef) ? 0 : taper; //default taper
    

    difference(){
        union(){
            cube([part_thickness, part_height, free_space]);
            translate([0,0,free_space])cube([part_thickness, part_height, part_height/2]);
            translate([0, part_height/2, part_height/2 + free_space ])rotate([0,90,0])cylinder(part_thickness,d=part_height);
        }
        translate([0,part_height/2,part_height/2 + free_space])
          rotate([0,90,0])cylinder(d1=pin_hole_diameter,d2 = pin_hole_diameter - taper * pin_hole_diameter, h=part_thickness );       
    }
    
    if (fillet == true) {
        translate([0,-part_height/2,0])zrot(a=180,cp=[0,part_height/2,0])fillet(l=part_height, d = pin_hole_diameter, orient=FORWARD);
        translate([part_thickness,part_height/2,0])fillet(l=part_height, d = pin_hole_diameter, orient=FORWARD);
        translate([part_thickness/2,0,0])zrot(a=270,cp=[0,0,1])fillet(l=part_thickness, d = pin_hole_diameter, orient=FRONT);
        translate([part_thickness/2,part_height,0])zrot(a=90,cp=[0,0,1])fillet(l=part_thickness, d = pin_hole_diameter, orient=FRONT);
    }//translate([-part_thickness/2,0,0])fillet(l=part_height, d = pin_hole_diameter, orient=RIGHT);
}


//slide holder
module slide_holder(dimensions, type, hole_side){
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    pin_hole_diameter = dict_lookup("pin_hole_diameter",dimensions);

    //determine the length of the slide holder based on the type
    slide_holder_length = (type == "large") ? dict_lookup("large_scissor_bar_slide_length",dimensions) : dict_lookup("small_scissor_bar_slide_length",dimensions);
    
    difference(){
        union(){
            cube([part_thickness, slide_holder_length, free_space + part_height/2]);
            translate([0,0,free_space])
            union(){
            translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([0,part_height/2,0])cube([part_thickness, slide_holder_length - part_height, part_height]);
            translate([0,part_height/2 + slide_holder_length - part_height, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            }
        }
        translate([0,0,free_space])  //v2
        union(){
            translate([0, part_height/2, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=pin_hole_diameter);
            translate([0,part_height/2,(part_height-pin_hole_diameter)/2])cube([part_thickness, slide_holder_length - part_height, pin_hole_diameter]);
            translate([0,slide_holder_length - part_height/2, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=pin_hole_diameter);
        } 
        /*x = (hole_side == "left") ? 0 : part_thickness;  //removed v2
        translate([x,part_height/2,free_space])
        #union(){
            translate([0, 0, part_height/2])sphere(d=pin_hole_diameter);
            translate([0, slide_holder_length - part_height, part_height/2])rot(a=90,v=[1,0,0])cylinder(slide_holder_length - part_height, d = pin_hole_diameter);
            translate([0, slide_holder_length - part_height, part_height/2])sphere(d=pin_hole_diameter);
        } */
    }
    translate([0,-slide_holder_length/2,0])zrot(a=180,cp=[0,slide_holder_length/2,0])fillet(l=slide_holder_length, d = pin_hole_diameter, orient=FORWARD);
    translate([part_thickness,slide_holder_length/2,0])fillet(l=slide_holder_length, d = pin_hole_diameter, orient=FORWARD);
    
  

}
/*
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
*/
module card_hole(dimensions) {
    cube([dict_lookup("card_width",dimensions),dict_lookup("card_corner_radius", dimensions) * 2,dict_lookup("card_thickness",dimensions)],false);
}

//modules call be the scissor lift parts
module hook(dimensions){
    pin_hole_diameter = dict_lookup("pin_hole_diameter",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);

    difference(){
        base_holder(dimensions, false);
        translate([0, part_height/2, part_height/4 + free_space + .25])cube([part_thickness, part_height, pin_hole_diameter - .5]);
    }
}

/* removed v2
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
            //make the pin a little smaller than full width to give some slack
            translate([part_thickness - pin_diameter/8,0,part_height/2])sphere(d=pin_diameter);
        }
    }

}
*/
module scissor_bar(dimensions, scissor_bar_length){
    //get the dimensions values
   
    part_height = dict_lookup("part_height",dimensions);
    part_thickness = dict_lookup("part_thickness",dimensions);
    free_space = dict_lookup("free_space",dimensions);
    pin_hole_diameter = dict_lookup("pin_hole_diameter",dimensions);
    difference(){
         union(){
            //we add .5 part height to each end so the length of the cube needs to be shortened by one part height
            translate([0,part_height/2,part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);
            translate([0,part_height/2,0])cube([part_thickness,scissor_bar_length-part_height, part_height]);
            translate([0,scissor_bar_length - part_height/2, part_height/2])rotate([0,90,0])cylinder(part_thickness,d=part_height);           
         }
        
       
       

    }
}

//test code
//tappered_screw_head(6,3,6);
//square_screw_holder(10,4,1.5);
//screw_holder(10,4,1.25);
base_holder(get_dimensions(), true, .2);
