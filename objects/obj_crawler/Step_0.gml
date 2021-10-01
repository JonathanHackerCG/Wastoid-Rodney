/// @description Shoot the player.
event_inherited();
if (global.paused) { exit; }

if (game_tick % fire_rate == 0 && is_on_screen(128))
{
	bullet(obj_bullet_enemy, image_angle + 90, fire_speed);
	bullet(obj_bullet_enemy, image_angle - 90, fire_speed);
}

if (!step_direction_solid_simple(image_angle, 0.75))
{
	image_angle += 180;
	image_angle = image_angle % 360;
}