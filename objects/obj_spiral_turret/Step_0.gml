/// @description 
event_inherited();
if (global.paused) { exit; }

if (game_tick % fire_rate == 0 && is_on_screen(128))
{
	bullet_spiral(fire_speed);
}