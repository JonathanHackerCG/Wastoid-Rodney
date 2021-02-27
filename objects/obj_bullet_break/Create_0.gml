/// @description Destroying crystals.
event_inherited();

var myid = id;
with (obj_crystal)
{
	if (place_meeting(x, y, myid))
	{
		instance_destroy();
	}
}

if (player.key)
{
	var inst = instance_place(x, y, obj_lock);
	if (instance_exists(inst))
	{
		instance_destroy(inst);
		player.key = false;
	}
}

instance_destroy();