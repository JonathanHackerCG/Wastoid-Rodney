/// @description Attacking.
event_inherited();
if (global.paused) { exit; }

if (game_tick % fire_rate == 0 && is_on_screen(128))
{
	bullet_ring(4, fire_speed);
}