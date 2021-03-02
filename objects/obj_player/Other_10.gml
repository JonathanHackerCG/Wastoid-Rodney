/// @description Taking damage.
event_inherited();
if (hp <= 0)
{
	audio.play_sound(snd_death, !global.mute_sound / 3);
	room_restart();
}
else { audio.play_sound(snd_hit, !global.mute_sound / 5); }

//Disabling powerups.
if (!global.endless_upgrades)
{
	if (key) { audio.play_sound(snd_key_lose, !global.mute_sound / 2); }
	
	tripleshot = false;
	barrier = false;
	speedy = false;
	key = false;
	explosiveshot = false;
	
	//Respawning powerups.
	with (obj_powerup_base)
	{
		if (!has_powerup)
		{
			instance_create_layer(x, y, layer, powerup);
			has_powerup = true;
		}
	}
}