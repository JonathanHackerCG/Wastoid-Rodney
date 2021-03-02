/// @description Collecting powerup.
event_inherited();

audio.play_sound(snd_powerup, !global.mute_sound / 4);
event_user(0);
base.has_powerup = false;
instance_destroy();