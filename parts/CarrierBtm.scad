//CarrierBtm.scad
//generates the bottom outside box part for the card holder
//generates the middle outside box part for the card holder
use <../modules/mUtilityFunction.scad>
use <../modules/mCardHolderModules.scad>
use <../CardDimensions.scad>
include <BOSL2/std.scad>

module CarrierBtm(dimensions) {
    carrier_height = dict_lookup("carrier_height",dimensions);
    carrier_width = dict_lookup("carrier_width",dimensions);
    carrier_length = dict_lookup("carrier_length",dimensions);
    screw_holder_diameter = dict_lookup("screw_holder_diameter",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);

    echo("carrier_height", carrier_height, "carrier_width", carrier_width, "carrier_length", carrier_length);

    //this is the bottom part of the carrier and holds the adruino in place
    //it is a box with rounded corners and holes for screws in each corner
    //the screen is held in place by screws that go through the bottom of the carrier middle.
    //for development this will have a bottom sufface but in production it will be open to save material
    //the bottom part will be screwed to the middle part with 4 screws in the corners
    //the adriuno will be held in place with 4 screws that go through the bottom and into the adruino mounting holes
    carrier_btm_height = 15 + wall_thickness; //height of the adruino board plus space for standoff and any wires ect. 
    adruino_length = 92.4; //length of the adruino board mm
    adruino_width = 61; //width of the adruino board
    adruino_corner_radius = 6; //radius of the adruino board corners
    adruino_standoff = carrier_btm_height - 11.50; //height of the adruino standoff

    camera_container_length = 25 + wall_thickness; //length of the camera container
    camera_container_width = 25 + 2 *  wall_thickness; //width of the camera container
    camera_height = 10;
    camera_width = 9;
    camera_length = 9;

    echo("camera_space", carrier_btm_height - (carrier_btm_height - camera_height - wall_thickness));
    
    //set the lower right hand corner of the container to make translations easier
    start = [-carrier_length/2, -carrier_width/2, 0];
    
    //create the walls using two ajoined rectangular tubes
    rounding = [screw_holder_diameter/2, screw_holder_diameter/2, screw_holder_diameter/2, 0];
    rounding2 = [screw_holder_diameter/2, 0, 0, screw_holder_diameter/2];
    
    difference() {
        union(){       
            rect_tube(size=[carrier_length, carrier_width], wall = wall_thickness, rounding=rounding, h=carrier_btm_height, $fn=64 ){
                attach(RIGHT,LEFT, align=FRONT)
                        rect_tube(size=[camera_container_length, camera_container_width], wall = wall_thickness, rounding=rounding2, h=carrier_btm_height, $fn=64);
                attach(RIGHT,LEFT, align=FRONT+TOP)
                        #cuboid([camera_container_length, camera_container_width, carrier_btm_height - camera_height - wall_thickness], rounding = screw_holder_diameter/2, edges = [FRONT+RIGHT, BACK+RIGHT], $fn=64);

                }

            
            //add the top and the bottom
            translate([0,0,carrier_btm_height + wall_thickness/2])
            cuboid([carrier_length, carrier_width, wall_thickness], rounding = screw_holder_diameter/2, edges = [FRONT+LEFT, BACK+LEFT, BACK+RIGHT], $fn=64)
                attach(RIGHT,LEFT,align=FRONT)
                    cuboid([camera_container_length, camera_container_width, wall_thickness],rounding = screw_holder_diameter/2, edges = [FRONT+RIGHT, BACK+RIGHT], $fn=64);

            //add the case screw holders
            translate(start)translate([wall_thickness, wall_thickness, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            mirror([1,0,0])translate(start)translate([wall_thickness, wall_thickness, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            mirror([0,1,0])translate(start)translate([wall_thickness, wall_thickness, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            mirror([1,0,0])mirror([0,1,0])translate(start)translate([wall_thickness, wall_thickness, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            //add the camera screw holders
            translate(start)translate([carrier_length + + wall_thickness, wall_thickness, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            translate(start)translate([carrier_length + camera_container_length - wall_thickness - screw_holder_diameter, wall_thickness, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            translate(start)translate([carrier_length + + wall_thickness, camera_container_width - wall_thickness - screw_holder_diameter, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
            translate(start)translate([carrier_length + camera_container_length - wall_thickness - screw_holder_diameter, camera_container_width - wall_thickness - screw_holder_diameter, 0])square_screw_holder(carrier_btm_height, screw_holder_diameter, 2.25);
        }
    
        union(){
            //add the screw holes on the top.
            translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_btm_height + wall_thickness])
                tappered_screw_head(3.8,2.5,wall_thickness);
            mirror([1,0,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_btm_height + wall_thickness])
                tappered_screw_head(3.8,2.5,wall_thickness);
            mirror([0,1,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_btm_height + wall_thickness])
                tappered_screw_head(3.8,2.5,wall_thickness);
            mirror([1,0,0])mirror([0,1,0])translate(start)translate([wall_thickness + screw_holder_diameter/2, wall_thickness + screw_holder_diameter/2, carrier_btm_height + wall_thickness])
                tappered_screw_head(3.8,2.5,wall_thickness);

            //subtract the cut out for the adruino screen
            translate([0,0, carrier_btm_height])
                cuboid([adruino_length, adruino_width, wall_thickness + 5], rounding = adruino_corner_radius, edges="Z", $fn=64);

            //take out the space for the thin strip of the camera
            translate([carrier_length/2 - screw_holder_diameter, - carrier_width/2 + screw_holder_diameter + wall_thickness, 0])
               cube([camera_container_length - 2 * screw_holder_diameter, camera_container_width - 2 * (wall_thickness + screw_holder_diameter), 5]);
            
            //take out the space for the usbc port on the adruino
            translate(start)translate([20 + wall_thickness,carrier_width - 2 * wall_thickness, carrier_btm_height - 10])#cube([20,8,3]);
            //take out the space for the microsd card on the adruino
            translate(start)translate([64 + wall_thickness,carrier_width - 2 * wall_thickness, carrier_btm_height - 10])#cube([14,8,3]);
            //take out the space for the usb port and lights on the adruino
            translate(start)translate([-2 * wall_thickness,(carrier_width - adruino_width)/2 +  20.25, carrier_btm_height - 9.5])#cube([8,22,4]);

        }
    }
    
}


CarrierBtm(get_dimensions());