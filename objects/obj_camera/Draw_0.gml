/// @description Rendering all objects.
event_inherited();

var inst_num = ds_grid_height(depthgrid);
for (var i = 0; i < inst_num; i++)
{
	var inst = depthgrid[# 0, i];
	with (inst) { event_user(ev_user.draw_default); }
}