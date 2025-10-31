//generates the middle outside box part for the card holder
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
use <../CardDimensions.scad>
include <BOSL2/std.scad>

module CarrierTop(dimensions) {
    carrier_height = dict_lookup("carrier_height",dimensions);
    carrier_width = dict_lookup("carrier_width",dimensions);
    carrier_length = dict_lookup("carrier_length",dimensions);
    screw_holder_diameter = dict_lookup("screw_holder_diameter",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);

    start = [-carrier_length/2, -carrier_width/2, -carrier_height/2];

    difference(){
    translate([0,0,carrier_height/2 - wall_thickness/2])   
        cuboid([carrier_length - 2 * wall_thickness , carrier_width - 2 * wall_thickness, wall_thickness], 
            rounding=screw_holder_diameter/2, edges = "Z", $fn=64); 
    
    
    translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_height])
        #tappered_screw_head(3.8,2.2,wall_thickness * 1.5);
    mirror([1,0,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_height])
        #tappered_screw_head(3.8,2.2,wall_thickness * 1.5);
    mirror([0,1,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_height])
        #tappered_screw_head(3.8,2.2,wall_thickness* 1.5);
    mirror([1,0,0])mirror([0,1,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_height])
        #tappered_screw_head(3.8,2.2,wall_thickness * 1.5);
    
    //cut out the thumb hole
    translate(start)translate([carrier_length * .75, carrier_width * .375,carrier_height - wall_thickness])
        rotate([0,0,90])thumb_hole(dimensions); 
    }

}


CarrierTop(get_dimensions());
