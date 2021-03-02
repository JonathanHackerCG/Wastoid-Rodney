/// @description Breaking.
event_inherited();

audio.play_sound(snd_crystal_break, !global.mute_sound / 4);
part_animation(x, y, layer, spr_crystal_break);