/// @description Player draw.
event_inherited();

if (x <= 0 || y <= 0) { exit; }
//Draw health.

var count = 0;
repeat(hp)
{
	draw_sprite(spr_heart, 0, camera.xpos + 12 + (16 * count), camera.ypos + 12);
	count ++;
}
if (barrier)
{
	draw_sprite(spr_heart, 1, camera.xpos + 12 + (16 * count), camera.ypos + 12);
}

/*
draw_set_color(c_white);
var axis_x = global.input.axis_value(input.axis_rx);
var axis_y = global.input.axis_value(input.axis_ry);
var dir = point_direction(0, 0, axis_x, axis_y);
var range = clamp(point_distance(0, 0, axis_x, axis_y) * var_range, 0, var_range);
var xx = x + lengthdir_x(range, dir);
var yy = y + lengthdir_y(range, dir);
draw_line(x, y, xx, yy);

draw_set_color(c_red);
var xx = x + lengthdir_x(range, fire_angle);
var yy = y + lengthdir_y(range, fire_angle);
draw_line(x, y, xx, yy);

xx = x + lengthdir_x(range, fire_goto);
yy = y + lengthdir_y(range, fire_goto);
draw_set_color(c_lime);
draw_line(x, y, xx, yy);