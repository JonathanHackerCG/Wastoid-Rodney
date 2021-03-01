/// @description Variable initialization.
event_inherited();

enum ev_user
{
	kill = 14,
	draw_default = 15
}
#macro game_tick global.gametick_time
game_tick = 0;
global.story = true;

/// @function start_level(level);
/// @description Begins a level.
function start_level(_level)
{
	con.clear();
	resume();
	room_goto(_level);
	switch(_level)
	{
		case rm_tutorial: audio.start_music(msc_levelA, 115); break;
		case rm_levelA: audio.start_music(msc_levelA, 115); break;
	}
}

global.paused = false;
function pause()
{
	global.paused = true;
	audio_pause_all();
	
	#region Main Options
	con.here("start");
	con.menu();
	con.answer("Resume", 1);
	con.answer("Options", 2);
	con.answer("Controls", 3);
	con.answer("Exit Level", 4);
	#endregion
	#region Resume
	con.here(1);
	con.function_execute(function() {
		obj_control.resume();
	});
	con.goto(100);
	#endregion
	queue_options();
	#region Display Controls
	con.here(3);
	con.nametag("Keyboard/Mouse");
	con.text("Move = WASD\nDash = LShift\nAim = Arrows/Mouse\nShoot = Space\L-Mouse");
	con.nametag("Gamepad");
	con.text("Move = L-Stick\nDash = L-Shoulder\nAim = R-Stick\nShoot = R-Shoulder");
	con.nametag("");
	con.goto("start");
	#endregion
	#region Exit Level
	con.here(4);
	con.function_execute(function() {
		audio_stop_all();
		player.x = -128;
		player.y = -128;
		room_goto(rm_menu);
	});
	con.goto(100);
	#endregion

	con.here(100);
	con.start();
}

function resume()
{
	player.paused = false;
	global.paused = false;
	audio_resume_all();
	con.reset();
	con.clear();
	con.set_active(false);
}