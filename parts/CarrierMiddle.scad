//generates the middle outside box part for the card holder
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
use <../CardDimensions.scad>
include <BOSL2/std.scad>




module CarrierMiddle(dimensions) {
    carrier_height = dict_lookup("carrier_height",dimensions);
    carrier_width = dict_lookup("carrier_width",dimensions);
    carrier_length = dict_lookup("carrier_length",dimensions);
    screw_holder_diameter = dict_lookup("screw_holder_diameter",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);
    card_box_outside_length = dict_lookup("card_box_outside_length",dimensions);
    card_box_outside_width = dict_lookup("card_box_outside_width",dimensions);
    card_box_outside_height = dict_lookup("card_box_outside_height",dimensions);
    start = [-carrier_length/2, -carrier_width/2, -carrier_height/2];
    
    echo("carrier_height", carrier_height, "carrier_width", carrier_width, "carrier_length", carrier_length);
    difference() {
        union(){
            //main box
            difference() {
                cuboid([carrier_length, carrier_width, carrier_height], rounding=screw_holder_diameter/2, edges = "Z", $fn=64);
                cuboid([carrier_length - 2 * wall_thickness , carrier_width - 2 * wall_thickness, carrier_height - 2 * wall_thickness], 
                        rounding=screw_holder_diameter/2, edges = "Z", $fn=64); 
                //cut out the top which wll be added in the top part
                translate([0,0,carrier_height/2 - wall_thickness])   
                    cuboid([carrier_length - 2 * wall_thickness , carrier_width - 2 * wall_thickness, wall_thickness*2], 
                        rounding=screw_holder_diameter/2, edges = "Z", $fn=64); 
              
            }
            //add the wall to handle the card boxx
            translate([0,(carrier_width - 2 * screw_holder_diameter - wall_thickness)/2, - wall_thickness/2])cube([carrier_length, wall_thickness, card_box_outside_height], center=true);
            translate([0,-(carrier_width - 2 * screw_holder_diameter - wall_thickness)/2, - wall_thickness/2])cube([carrier_length, wall_thickness, card_box_outside_height], center=true);
            
            //add the screw holders
            translate(start)translate([wall_thickness, wall_thickness, wall_thickness])square_screw_holder(carrier_height - 2 * wall_thickness, screw_holder_diameter, 1.75);
            mirror([1,0,0])translate(start)translate([wall_thickness, wall_thickness, wall_thickness])square_screw_holder(carrier_height - 2 * wall_thickness, screw_holder_diameter, 1.75);
            mirror([0,1,0])translate(start)translate([wall_thickness, wall_thickness, wall_thickness])square_screw_holder(carrier_height - 2 * wall_thickness, screw_holder_diameter, 1.75);
            mirror([1,0,0])mirror([0,1,0])translate(start)translate([wall_thickness, wall_thickness, wall_thickness])square_screw_holder(carrier_height - 2 * wall_thickness, screw_holder_diameter, 1.75);

            
        }

        //pushout hole for the card holder
        translate(start)translate([0,carrier_width/2, carrier_height/2])rotate([0,90,0])cylinder(wall_thickness*4, r = carrier_height/4);
        //cut out the card deal slot
        card_thickness = dict_lookup("card_thickness",dimensions);
        translate(start)translate([0, wall_thickness + screw_holder_diameter, carrier_height - wall_thickness - card_thickness * 1.5])
            cube([wall_thickness * 4, card_box_outside_width, 10]);
        //cut out the hole for the card holder to fit into the carrier
        translate(start)translate([carrier_length - wall_thickness, wall_thickness + screw_holder_diameter,wall_thickness])cube([wall_thickness, card_box_outside_width, carrier_height]);
        //cut off the bottom of the carrier to better attach the adruino supports
        #translate([0,0,-(carrier_height - wall_thickness)/2]) cuboid([carrier_length, carrier_width, wall_thickness + .05], rounding=screw_holder_diameter/2, edges = "Z", $fn=64);
    }


}
CarrierMiddle(get_dimensions());