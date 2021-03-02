/// @description Perform code.
audio.play_sound(snd_win, !global.mute_sound / 2);
event_inherited();
if (execute != noone)
{
	execute();
}
instance_destroy();