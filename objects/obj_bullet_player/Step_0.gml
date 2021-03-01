/// @description Destroy player bullet when hitting barrier.
event_inherited();

if (place_meeting(x, y, obj_enemy_barrier))
{
	instance_destroy();
}