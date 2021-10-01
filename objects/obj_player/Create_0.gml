/// @description Initialize player variables.
event_inherited();

global.endless_upgrades = false;
paused = false;
dash_cooldown = -1;
iframes = 0;

hp = 5;
hp_max = hp;

spd = 0;
spd_goto = 0;
spd_max = 3;
accel = 0.25;

var_range = 320;
var_direction = 0;

fire_rate = 30;
fire_angle = 0;
fire_timer = 0;
fire_goto = fire_angle;
bullet_speed = 8;
mx_previous = mouse_x;
my_previous = mouse_y;

//Aim assist values.
aim_off = 15;
aim_target_off = 5;
aim_speed = 0.50;
aim_enabled = true;

//Powerup variables.
tripleshot = false;
barrier = false;
speedy = false;
key = false;
explosiveshot = false;