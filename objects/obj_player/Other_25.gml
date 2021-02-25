/// @description Player draw.
event_inherited();

draw_set_color(c_white);
var axis_x = global.input.axis_value(input.axis_rx);
var axis_y = global.input.axis_value(input.axis_ry);
var dir = point_direction(0, 0, axis_x, axis_y);
var xx = x + lengthdir_x(var_range, dir);
var yy = y + lengthdir_y(var_range, dir);
draw_line(x, y, xx, yy);

draw_set_color(c_red);
var xx = x + lengthdir_x(var_range, fire_angle);
var yy = y + lengthdir_y(var_range, fire_angle);
draw_line(x, y, xx, yy);

xx = x + lengthdir_x(var_range, fire_goto);
yy = y + lengthdir_y(var_range, fire_goto);
draw_set_color(c_lime);
draw_line(x, y, xx, yy);