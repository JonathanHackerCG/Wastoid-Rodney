/// @description Performing explosion.
event_inherited();

audio.play_sound(snd_explosion, !global.mute_sound / 5);

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
	camera.screenshake += 20;
	player.damage(1);
	with (player) { event_user(0); }
}

instance_destroy();