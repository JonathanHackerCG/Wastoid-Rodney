/// @description Destroy this enemy.
event_inherited();

if (lock != noone) { instance_destroy(lock); }
instance_destroy();