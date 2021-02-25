/// @description Sorting the instance drawing grid.
event_inherited();

if (ds_exists(depthgrid, ds_type_grid))
{
	//Resize the depthgrid to fit all the instances.
	var grid = depthgrid; //Make depthgrid local.
	var inst_num = instance_number(par_all_visible);
	ds_grid_resize(grid, 2, inst_num);
	
	//Fill grid with all the depth values.
	var pos = 0;
	with (par_all_visible)
	{
		grid[# 0, pos] = id;
		grid[# 1, pos] = _depth + ((layer_get_depth(layer) / 100) * room_height); //Separated by layers.
		pos ++;
	}
	
	//Sort the grid
	ds_grid_sort(grid, 1, false);
}