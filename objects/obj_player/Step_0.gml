/// @description Player movement.
event_inherited();

var axis_x = global.input.axis_value(input.axis_lx);
var axis_y = global.input.axis_value(input.axis_ly);
var dir = point_direction(0, 0, axis_x, axis_y);
var spd = point_distance(0, 0, axis_x, axis_y) * var_speed;

step_direction_solid(dir, spd);