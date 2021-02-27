/// @description Performing explosion.
event_inherited();

camera.flash_alpha = 1.00;
part_fade(x, y, layer, sprite_index, 0, 10);

var myid = id;
with (par_enemy)
{
	if (place_meeting(x, y, myid))
	{
		damage(10);
	}
}

with (obj_explosive)
{
	if (place_meeting(x, y, myid))
	{
		instance_destroy();
	}
}

with (obj_crystal)
{
	if (place_meeting(x, y, myid))
	{
		instance_destroy();
	}
}

if (place_meeting(x, y, player))
{
	player.damage(10);
}

instance_destroy();