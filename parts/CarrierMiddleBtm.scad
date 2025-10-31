//generates the middle outside box part for the card holder
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
use <../CardDimensions.scad>
include <BOSL2/std.scad>


module CarrierMiddleBtm(dimensions) {
    
    carrier_height = dict_lookup("carrier_height",dimensions);
    carrier_width = dict_lookup("carrier_width",dimensions);
    carrier_length = dict_lookup("carrier_length",dimensions);
    screw_holder_diameter = dict_lookup("screw_holder_diameter",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);
    card_box_outside_length = dict_lookup("card_box_outside_length",dimensions);
    card_box_outside_width = dict_lookup("card_box_outside_width",dimensions);
    card_box_outside_height = dict_lookup("card_box_outside_height",dimensions);
    
    echo("screw_holder_diameter", screw_holder_diameter);
    
    carrier_btm_height = 15 + wall_thickness; //height of the adruino board plus space for standoff and any wires ect. 
    adruino_length = 92.4; //length of the adruino board mm
    adruino_width = 61; //width of the adruino board
    adruino_corner_radius = 6; //radius of the adruino board corners
    adruino_standoff_height = carrier_btm_height - wall_thickness - 11.50; //height of the adruino standoff

    start = [-carrier_length/2, -carrier_width/2, -carrier_height/2];
    //calculate the position of the adruino mounting supports
    adriuno_standoff_x = (carrier_length - adruino_length)/2 + 10.22;
    adriuno_standoff_y = (carrier_width - adruino_width)/2 + 6.25;
    difference(){
        union(){
            //add the bottom
            translate([0,0,-(carrier_height - wall_thickness)/2]) cuboid([carrier_length, carrier_width, wall_thickness], rounding=screw_holder_diameter/2, edges = "Z", $fn=64);
            //add the adruino mounting supports
            translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, - adruino_standoff_height])screw_holder(adruino_standoff_height, screw_holder_diameter, 2.5);
            mirror([1,0,0])translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, - adruino_standoff_height])screw_holder(adruino_standoff_height, screw_holder_diameter, 2.5);
            mirror([0,1,0])translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, - adruino_standoff_height])screw_holder(adruino_standoff_height, screw_holder_diameter, 2.5);
            mirror([1,0,0])mirror([0,1,0])translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, - adruino_standoff_height])screw_holder(adruino_standoff_height, screw_holder_diameter, 2.5);
        }
        union(){
            //add the adruino mounting screw holes
             translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, wall_thickness + .01])tappered_screw_head(3.8,2.5,wall_thickness * 1.5);
             mirror([1,0,0])translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, wall_thickness + .01])tappered_screw_head(3.8,2.5,wall_thickness * 1.5);
             mirror([0,1,0])translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, wall_thickness + .01])tappered_screw_head(3.8,2.5,wall_thickness * 1.5);
             mirror([1,0,0])mirror([0,1,0])translate(start)translate([adriuno_standoff_x, adriuno_standoff_y, wall_thickness + .01])tappered_screw_head(3.8,2.5,wall_thickness * 1.5);
            //add the case screw holes
            #translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, wall_thickness])cylinder(h=wall_thickness * 2,d=2.25,center=true, $fn=32);
            mirror([1,0,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, wall_thickness])cylinder(h=wall_thickness * 2,d=2.25,center=true, $fn=32);
            mirror([0,1,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, wall_thickness])cylinder(h=wall_thickness * 2,d=2.25,center=true, $fn=32);
            mirror([1,0,0])mirror([0,1,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, wall_thickness])cylinder(h=wall_thickness * 2,d=2.25,center=true, $fn=32);

        }
    
    }
    
    

}
CarrierMiddleBtm(get_dimensions());