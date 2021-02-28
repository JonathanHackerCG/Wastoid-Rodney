/// @description Find gamepad.
event_inherited();
var gp = global.input.gamepad_find();
gamepad_set_axis_deadzone(gp, 0.1);