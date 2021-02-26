/// @description Variable initialization.
event_inherited();

enum ev_user
{
	kill = 14,
	draw_default = 15
}
#macro game_tick global.gametick_time
game_tick = 0;

/// @function start_level(level);
/// @description Begins a level.
function start_level(_level)
{
	room_goto(_level);
}