/// @description 
event_inherited();

_depth = -bbox_bottom;
var dis = point_distance(x, y, player.x, player.y);
if (player.key && dis > 32)
{
	if (dis > 128) { x = player.x; y = player.y; }
	step_towards_point(player.x, player.y, player.spd_goto);
}

if (!player.key)
{
	x = -32;
	y = -32;
}