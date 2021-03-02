/// @description Destroy this enemy.
event_inherited();

audio.play_sound(choose(snd_robo_deathA, snd_robo_deathB), !global.mute_sound / 3);
if (lock != noone) { instance_destroy(lock); }
instance_destroy();