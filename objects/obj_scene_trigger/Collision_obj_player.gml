/// @description Perform code.

player.iframes = 0;
audio_stop_sound(audio.msc);
audio.win = audio.play_sound(snd_win, !global.mute_sound / 2, 0, 0);
global.killed = false;
event_inherited();
if (execute != noone)
{
	execute();
}
instance_destroy();