/// @description BOSS ABILITY
event_inherited();

if (global.paused) { exit; }

if (audio.off_beat == 0)
{
	bullet_ring(8, 2);
}

if (timer == -1)
{
	event_user(0);
	timer = second(5);
} else { timer --; }