/// @description Rendering all objects.
event_inherited();

var inst_num = ds_grid_height(depthgrid);
for (var i = 0; i < inst_num; i++)
{
	var inst = depthgrid[# 0, i];
	with (inst) { event_user(ev_user.draw_default); }
}

if (flash_alpha > 0.0)
{
	draw_set_color(c_white);
	draw_set_alpha(flash_alpha);
	draw_rectangle(xpos, ypos, xpos + width, ypos + height, false);
	draw_set_alpha(1.00);
	flash_alpha -= 0.025;
}