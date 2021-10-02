/// @description Player movement.
event_inherited();

if (x <= 0 || y <= 0) { exit; }
if (paused) { exit; }

if (iframes > 0) { iframes --; }
if (global.input.check_pressed(input.start))
{
	if (global.paused) { obj_control.resume(); }
	else { obj_control.pause(); }
}

if (global.paused) { exit; }

_depth = -bbox_bottom;
#region Movement.
spd_max = 2.75;
if (speedy) { spd_max = 4.0; }

var axis_x = global.input.axis_value(input.axis_lx);
var axis_y = global.input.axis_value(input.axis_ly);
var dir = point_direction(0, 0, axis_x, axis_y);
if (axis_x != 0 || axis_y != 0) { var_direction = dir; }

spd_goto = point_distance(0, 0, axis_x, axis_y);
spd_goto = clamp(spd_goto * spd_max, -spd_max, spd_max);
spd = lerp(spd, spd_goto, accel);

if (dash_cooldown <= second(0.04))
{
	step_direction_solid(var_direction, spd);
}

if (spd > 0) { sprite_index = spr_player_walk; }
else { sprite_index = spr_player; }

if (image_xscale = 1)
{
	if (abs(angle_difference(var_direction, 000)) >= 115)
	{
		image_xscale = -1;
	}
}
else
{
	if (abs(angle_difference(var_direction, 180)) >= 115)
	{
		image_xscale = 1;
	}
}
#endregion
#region Aim Inputs.
var axis_x = global.input.axis_value(input.axis_rx);
var axis_y = global.input.axis_value(input.axis_ry);
var aim_direction = point_direction(0, 0, axis_x, axis_y);
#endregion
#region Dashing.
if ((global.input.check_pressed(input.SL) || global.input.check_pressed(input.L) || mouse_check_button_pressed(mb_right)) && dash_cooldown == -1)
{
	dash_cooldown = second(0.35);
	audio.play_sound(snd_dash, !global.mute_sound / 2);
	iframes += second(0.25);
	
	var dis = 72;
	var dir = fire_angle;
	
	var xx = x + lengthdir_x(dis, dir);
	var yy = y + lengthdir_y(dis, dir);
	var count = 0;
	repeat(8)
	{
		part_fade(x, y, layer, sprite_index, 0, 5 + count);
		step_towards_point_solid(xx, yy, dis / 8);
		count ++;
	}
}

if (dash_cooldown >= 0) { dash_cooldown --; }
#endregion
#region Aiming.
var dir = aim_direction;
var range = clamp(point_distance(0, 0, axis_x, axis_y) * var_range, 0, var_range);
if (range > var_range / 3) { fire_goto = dir; }

//PC Method works slightly better. This will suffice however.
//var mx = display_mouse_get_x();
//var my = display_mouse_get_y();
var mx = mouse_x - camera.xpos;
var my = mouse_y - camera.ypos;
if (axis_x == 0 && axis_y == 0)
{
	if (point_distance(mx, my, mx_previous, my_previous) >= 2)
	{
		dir = point_direction(x, y, mouse_x, mouse_y);
		fire_goto = dir;
	}
}
mx_previous = mx;
my_previous = my;

if (aim_enabled)
{
	var dis_min = undefined;
	with (par_enemy)
	{
		var enemy_dir = point_direction(player.x, player.y, x, y);
		var enemy_dis = point_distance(player.x, player.y, x, y);
		if ((dis_min == undefined || enemy_dis < dis_min) && enemy_dis <= range - 4 && collision_line(player.x, player.y, x, y, obj_wall, false, true) == noone)
		{
			if (abs(angle_difference(player.fire_goto, enemy_dir)) <= player.aim_off + (targeted * player.aim_target_off))
			{
				targeted = true;
				player.fire_goto = enemy_dir;
				dis_min = enemy_dis;
			} else { targeted = false; }
		} else { targeted = false; }
	}
}

fire_angle = alerp(fire_angle, fire_goto, aim_speed);
#endregion
#region Shooting.
fire_rate = 15;
if (speedy) { fire_rate = 10; }

if ((global.input.check_held(input.SR) || global.input.check_held(input.R) || mouse_check_button(mb_left)))
{
	if (fire_timer % fire_rate == 0)
	{
		audio.play_sound(snd_player_shoot, !global.mute_sound / 10);
	
		bullet(obj_bullet_player, fire_angle, bullet_speed);
		if (tripleshot)
		{
			var off = 10;
			bullet(obj_bullet_player, fire_angle + off, bullet_speed);
			bullet(obj_bullet_player, fire_angle - off, bullet_speed);
		}
	}
	fire_timer ++;
}
else if (fire_timer > 0)
{
	fire_timer ++;
	if (fire_timer % fire_rate == 0) { fire_timer = 0; }
}
#endregion