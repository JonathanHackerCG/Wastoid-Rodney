/// @description Shoot the player.
event_inherited();
if (global.paused) { exit; }

if (game_tick % fire_rate == 0)
{
	bullet(obj_bullet_enemy, image_angle, 2.0);
}