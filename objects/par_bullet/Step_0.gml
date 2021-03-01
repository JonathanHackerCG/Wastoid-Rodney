/// @description Bullet movement/collisions.
event_inherited();

if (global.paused) { exit; }

_depth = -bbox_bottom;
if (!step_direction_solid_simple(move_direction, var_speed) && var_speed > 0)
{
	instance_destroy();
}