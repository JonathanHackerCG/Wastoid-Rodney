/// @description Initialize player variables.
event_inherited();

spd = 0;
spd_goto = 0;
spd_max = 1.5;
accel = 0.25;

var_range = 320;
var_direction = 0;

fire_rate = 30;
fire_angle = 0;
fire_goto = fire_angle;
mx_previous = mouse_x;
my_previous = mouse_y;

//Aim assist values.
aim_off = 10;
aim_target_off = 5;
aim_speed = 0.50;
aim_enabled = true;

//Powerup variables.
tripleshot = false;
barrier = false;
speedy = false;
key = false;
explosiveshot = false;