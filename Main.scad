use <CardDimensions.scad>
use <modules/mUtilityFunction.scad>
use <parts/CardDeckSupport.scad>
use <parts/CardHolder.scad>
use <parts/LargeScissorBar.scad>
use <parts/OutsideBoxBottom.scad>
use <parts/OutsideBoxMiddle.scad>
use <parts/OutsideBoxTop.scad>
use <parts/SmallScissorBar.scad>

dimensions = get_dimensions();   
part_thickness = dict_lookup("part_thickness",dimensions);
wall_thickness = dict_lookup("wall_thickness",dimensions);
part_height = dict_lookup("part_height",dimensions);
side_offset = dict_lookup("side_offset",dimensions);
base_offset = dict_lookup("base_offset",dimensions);
free_space = dict_lookup("free_space",dimensions);
small_scissor_bar_length = dict_lookup("small_scissor_bar_length",dimensions);
small_scissor_bar_width = dict_lookup("small_scissor_bar_width",dimensions);

part_to_build = "LiftMechanismTop"; // "CardBox" or "OutsideBox"

if (part_to_build == "CardHolder") {
    OutsideBoxMiddle(dimensions);
} else if (part_to_build == "OutsideBoxTop") {
    OutsideBoxTop(dimensions);
} else if (part_to_build == "OutsideBoxBottom") {
    OutsideBoxBottom(dimensions);
} else if (part_to_build == "OutsideBoxMiddle") {
    OutsideBoxMiddle(dimensions);
} else if (part_to_build == "CardHolder") {
    CardHolder(dimensions);   
} else if (part_to_build == "CardDeckSupport") {
    CardDeckSupport(dimensions);
} else if (part_to_build == "LargeScissorBar") {
    LargeScissorBar(dimensions);
} else if (part_to_build == "SmallScissorBar") {
    SmallScissorBar(dimensions);

} else if (part_to_build == "LiftMechanismTop") {
   
    //translate([wall_thickness, wall_thickness, wall_thickness]) CardHolder(dimensions);   
    CardDeckSupport(dimensions);
    translate([ side_offset + part_thickness, base_offset, wall_thickness])LargeScissorBar(dimensions);
    rotate([0,0,180])translate([-small_scissor_bar_width -(side_offset +  part_thickness + free_space), 
        -small_scissor_bar_length - base_offset - part_height,wall_thickness])SmallScissorBar(dimensions);
} else if (part_to_build == "LiftMechanismTop") {
   
    //translate([wall_thickness, wall_thickness, wall_thickness]) CardHolder(dimensions);   
    CardDeckSupportBtm(dimensions);
    union() {%translate([ side_offset + 2 * part_thickness, base_offset, wall_thickness])LargeScissorBar(dimensions);
        rotate([0,0,180])translate([-small_scissor_bar_width -(side_offset +  2 * part_thickness + free_space), 
        -small_scissor_bar_length - base_offset - part_height,wall_thickness])SmallScissorBar(dimensions);
    }
}
    else {
    echo("Unknown part_to_build: ", part_to_build);
}
echo("Finished building: ", part_to_build);
//CardHolder();

