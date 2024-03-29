/// @description Default InputController
//The following code is a default controller mapping definition.
//It provides a keyboard and gamepad mapping for every default input ID.
//This is provided primarily as an example. This should be modified to suit your purposes.

global.input = new InputController();
if (!GX)
{
	global.input.define_check("L", input.SL, vk_lshift, gp_shoulderl);
	global.input.define_check("LB", input.L, vk_lshift, gp_shoulderlb);
}
else
{
	global.input.define_check("L", input.SL, ord("Q"), gp_shoulderl);
	global.input.define_check("LB", input.L, ord("Q"), gp_shoulderlb);
}
global.input.define_check("R", input.SR, vk_space, gp_shoulderr);
global.input.define_check("RB", input.R, vk_space, gp_shoulderrb);
global.input.define_check("Start", input.start, vk_escape, gp_start);
global.input.define_axis("Axis-LX", input.axis_lx, ord("D"), ord("A"), gp_axislh);
global.input.define_axis("Axis-LY", input.axis_ly, ord("S"), ord("W"), gp_axislv);
global.input.define_axis("Axis-RX", input.axis_rx, vk_right, vk_left, gp_axisrh);
global.input.define_axis("Axis-RY", input.axis_ry, vk_down, vk_up, gp_axisrv);

var gp = global.input.gamepad_find();
gamepad_set_axis_deadzone(gp, 0.1);