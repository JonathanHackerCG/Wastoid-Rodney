/// @description Shoot the player.
event_inherited();
if (global.paused) { exit; }

if (audio.off_beat == 0)
{
	if (toggle) { bullet(obj_bullet_enemy, image_angle, 2.0); }
	toggle = !toggle;
}