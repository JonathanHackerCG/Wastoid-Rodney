/// @description Causes same type objects to move apart slowly so they do not overlap too much.
/// @function object_avoid_clutter([object]);
/// @param [object]
function object_avoid_clutter() {

	var object = object_index;
	if (argument_count > 0)
	{
		object = argument[0];
	}

	var inst = instance_place(x, y, object);
	if (instance_exists(inst))
	{
		step_direction_solid(point_direction(inst.x, inst.y, x, y), 0.25);
	}


}
