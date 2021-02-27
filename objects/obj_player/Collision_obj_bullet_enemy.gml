/// @description Take damage from enemy bullets.
event_inherited();

camera.screenshake += 12;
damage(other.var_damage);
instance_destroy(other);

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