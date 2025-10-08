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


part_to_build = "CardDeckSupport"; // "CardBox" or "OutsideBox"

if (part_to_build == "OutsideBoxMiddle") {
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

} else if (part_to_build == "Inside") {
    part_thickness = dict_lookup("part_thickness",dimensions);
    wall_thickness = dict_lookup("wall_thickness",dimensions);
    part_height = dict_lookup("part_height",dimensions);
    translate([wall_thickness, wall_thickness, wall_thickness]) CardHolder(dimensions);   
    translate([2 * wall_thickness,2* wall_thickness, 2* wall_thickness + part_height])CardDeckSupport(dimensions);
    translate([2 * part_thickness + 2 * wall_thickness, 2 * wall_thickness, 2* wall_thickness])LargeScissorBar(dimensions);
    translate([3 * part_thickness + 2 * wall_thinkess, 2 * wall_thickness, 2 * part_height])SmallScissorBar(dimensions);
}
    else {
    echo("Unknown part_to_build: ", part_to_build);
}
echo("Finished building: ", part_to_build);
//CardHolder();

