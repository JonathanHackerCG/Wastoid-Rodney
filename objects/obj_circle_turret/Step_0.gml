/// @description 
event_inherited();
if (global.paused) { exit; }

if (audio.off_beat == 0 && is_on_screen(128))
{
	bullet_ring(4, 1.75);
}