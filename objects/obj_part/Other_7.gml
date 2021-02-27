/// @description Destroying on animation end.
event_inherited();

if (end_animation >= 0)
{
	end_animation --;
	if (end_animation == 0) { instance_destroy(); }
}

if (stop_animation)
{
	image_speed = 0;
	image_index = image_number - 1;
}