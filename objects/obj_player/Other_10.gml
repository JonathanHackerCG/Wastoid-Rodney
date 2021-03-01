/// @description Taking damage.
event_inherited();
if (hp <= 0)
{
	room_restart();
}

//Disabling powerups.
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