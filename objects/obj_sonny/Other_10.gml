/// @description Teleport randomly.
event_inherited();

var myid = id;
with (par_enemy) { if (id != myid) { instance_destroy(); } }

with (instance_find(obj_sunny_spawn, irandom(instance_number(obj_sunny_spawn))))
{
	obj_sonny.x = x;
	obj_sonny.y = y;
}

with (obj_sunny_spawn)
{
	if (instance_position(x, y, obj_sonny) == noone && irandom(1))
	{
		instance_create_layer(x, y, layer, choose(obj_circle_turret, obj_target_turret, obj_spiral_turret));
	}
}