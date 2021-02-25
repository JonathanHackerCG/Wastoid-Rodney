/// @description Player movement.
event_inherited();

#region Movement.
var axis_x = global.input.axis_value(input.axis_lx);
var axis_y = global.input.axis_value(input.axis_ly);
var dir = point_direction(0, 0, axis_x, axis_y);
var spd = clamp(point_distance(0, 0, axis_x, axis_y) * var_speed, -var_speed, var_speed);
step_direction_solid(dir, spd);
#endregion
#region Shooting.
var axis_x = global.input.axis_value(input.axis_rx);
var axis_y = global.input.axis_value(input.axis_ry);
var dir = point_direction(0, 0, axis_x, axis_y);
fire_goto = dir;

var dis_min = undefined;
with (par_enemy)
{
	var enemy_dir = point_direction(player.x, player.y, x, y);
	var enemy_dis = point_distance(player.x, player.y, x, y);
	if (dis_min == undefined || enemy_dis < dis_min)
	{
		if (abs(angle_difference(player.fire_goto, enemy_dir)) <= player.aim_off + (targeted * player.aim_target_off))
		{
			targeted = true;
			player.fire_goto = enemy_dir;
			dis_min = enemy_dis;
		} else { targeted = false; }
	} else { target = false; }
}

fire_angle = alerp(fire_angle, fire_goto, aim_speed);
#endregion