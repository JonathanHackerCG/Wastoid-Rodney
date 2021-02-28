/// @description Default dialogue inputs.
if (global.input.check_pressed(input.SR) || global.input.check_pressed(input.SL)) { con.input_confirm(); }
if (keyboard_check_pressed(ord("R"))) { con.input_confirm(); }
if (global.input.axis_time(input.axis_ly) == 1 && global.input.axis_value(input.axis_ly) < 0) { con.input_up(); }
if (global.input.axis_time(input.axis_ly) == 1 && global.input.axis_value(input.axis_ly) > 0) { con.input_down(); }
if (global.input.axis_time(input.axis_ry) == 1 && global.input.axis_value(input.axis_ry) < 0) { con.input_up(); }
if (global.input.axis_time(input.axis_ry) == 1 && global.input.axis_value(input.axis_ry) > 0) { con.input_down(); }