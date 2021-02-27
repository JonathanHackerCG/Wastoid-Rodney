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

with (obj_explosive)
{
	if (place_meeting(x, y, myid))
	{
		camera.screenshake += 16;
		instance_create_layer(x, y, layer, obj_explosion);
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
		with (obj_powerup_base)
		{
			if (powerup == obj_key && !has_powerup)
			{
				instance_create_layer(x, y, layer, powerup);
				has_powerup = true;
			}
		}
	}
}

instance_destroy();