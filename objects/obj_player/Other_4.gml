/// @description Move to player start location.
event_inherited();

var inst = instance_nearest(x, y, obj_player_start);
if (instance_exists(inst))
{
	player.x = inst.x;
	player.y = inst.y;
}