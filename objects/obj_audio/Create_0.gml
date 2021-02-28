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
	msc = audio_play_sound(_music, !global.mute_music, true);
	audio_sound_gain(msc, !global.mute_music, 0);
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