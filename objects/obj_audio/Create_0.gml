/// @description Initialize audio functions.
event_inherited();

global.mute_sound = false;
global.mute_music = false;

msc = noone;
bpm = 0;
bps = 0;
off_beat = 0;

#region start_music(music, bpm);
/// @function start_music(music, bpm);
/// @param music
/// @param bpm
function start_music(_music, _bpm)
{
	audio_stop_sound(msc);
	msc = audio_play_sound(_music, !global.mute_music / 4, true);
	audio_sound_gain(msc, !global.mute_music / 4, 0);
	bpm = _bpm;
	bps = bpm / 60;
}
#endregion
#region update_beat();
function update_beat()
{
	if (msc == noone) { off_beat = 120; return off_beat; }
	
	var pos = audio_sound_get_track_position(msc);
	var beat = pos * bps;
	var off_new = beat - round(beat);
	off_new = off_new * second(1);
	
	//Calculating exact frame of beat.
	if (off_beat < 0 && off_new > 0)
	{
		off_new = 0;
	}
	off_beat = off_new;
	
	//Return the final beat offset.
	return off_beat;
}
#endregion
#region play_sound();
/// @description play_sound(sound_id, volume, pitch_variation, [pitch_offset], [priority], [loops]);
/// @function play_sound
/// @param sound_id
/// @param volume
/// @param [pitch_variation]
/// @param [pitch_offset]
/// @param [priority]
/// @param [loops]
function play_sound() {
	var sound = argument[0];
	var volume = argument[1];

	var pitch = 0.2;
	var pitch_offset = 0;
	var priority = 1;
	var loops = false;

	if (argument_count > 2)
	{
		var pitch = argument[2];
		if (argument_count > 3)
		{
			pitch_offset = argument[3];
			if (argument_count > 4)
			{
				priority = argument[4];
				if (argument_count > 5)
				{
					loops = argument[5];
				}
			}
		}
	}

	var snd = audio_play_sound(sound, priority, loops);
	audio_sound_gain(snd, volume, 0);
	audio_sound_pitch(snd, 1+random_range(-pitch, pitch)+pitch_offset);

	return snd;
}
#endregion