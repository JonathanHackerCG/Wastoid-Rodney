/// @description Teleport to start location.
event_inherited();

hp = hp_max;
//Disabling powerups.
tripleshot = false;
barrier = false;
speedy = false;
key = false;
explosiveshot = false;

var inst = instance_nearest(x, y, obj_player_start);
if (instance_exists(inst))
{
	x = inst.x;
	y = inst.y;
}

with (camera)
{
	var dis = 64;
	var xx = lengthdir_x(dis, player.fire_goto);
	var yy = lengthdir_y(dis, player.fire_goto);
	follow(player, 1, xx, yy);
}