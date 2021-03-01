/// @description Shoot the player.
event_inherited();
if (global.paused) { exit; }

if (audio.off_beat == 0 && is_on_screen(128))
{
	bullet(obj_bullet_enemy, image_angle + 90, 1.25);
	bullet(obj_bullet_enemy, image_angle - 90, 1.25);
}

if (!step_direction_solid_simple(image_angle, 0.75))
{
	image_angle += 180;
	image_angle = image_angle % 360;
}