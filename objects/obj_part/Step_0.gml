/// @description Effects.
event_inherited();

//Fading timer effect.
if (timer_length == 0)
{
	if (timer_fade > 0)
	{
		alpha = (timer_fade / timer_fade_max);
		timer_fade --;
	}
	else if (timer_fade == 0) { instance_destroy(); }
}
else if (timer_length > 0) { timer_length --; }