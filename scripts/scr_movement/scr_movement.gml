//General movement functions/collision checking.

#region step_direction(direction, speed);
/// @description Causes an instance to step in a particular direction.
/// @function step_direction
/// @param direction
/// @param speed
function step_direction(dir, spd) {
	#region Adjusting parameters.
	//Make speed absolute and correct direction.
	if (spd < 0)
	{
		dir += 180;
		spd = abs(spd);
	}

	//Exit if it will not move at all.
	if (spd == 0)
	{
		return false;
	}
	#endregion
	#region Getting x and y components of the movement.
	var xx = lengthdir_x(spd, dir);
	var yy = lengthdir_y(spd, dir);
	#endregion
	#region Periodic rate change (for slow speeds).
	var xrate = 1;
	if (abs(xx) <= 0.25 && xx != 0)
	{
		xrate = ceil(0.25 / abs(xx));
		if (game_tick % xrate == 0) { xx = xx * xrate; }
		else { xx = 0; }
	}

	var yrate = 1;
	if (abs(yy) <= 0.25 && yy != 0)
	{
		yrate = ceil(0.25 / abs(yy));
		if (game_tick % yrate == 0) { yy = yy * yrate; }
		else { yy = 0; }
	}
	#endregion
	#region Final Movement.
	var xx = rdec(xx);
	var yy = rdec(yy);
	x += xx;
	y += yy;
	#endregion
	return (x != x1 || y != y1);
}
#endregion
#region step_direction_solid(direction, speed);
/// @description Causes an instance to step in a particular direction. Stops if it collides with given object.
/// @function step_direction_solid
/// @param direction
/// @param speed
function step_direction_solid(dir, spd) {
	#region Adjusting parameters.
	var x1 = x; var y1 = y;

	//Make speed absolute and correct direction.
	if (spd < 0)
	{
		dir += 180;
		spd = abs(spd);
	}

	//Exit if it will not move at all.
	if (spd == 0)
	{
		return false;
	}
#endregion
	#region Getting x and y components of the movement.
	var xx = lengthdir_x(spd, dir);
	var yy = lengthdir_y(spd, dir);
	#endregion
	#region Periodic rate change (for slow speeds).
	var xrate = 1;
	if (abs(xx) <= 0.25 && xx != 0)
	{
		xrate = ceil(0.25 / abs(xx));
		if (game_tick % xrate == 0) { xx = xx * xrate; }
		else { xx = 0; }
	}

	var yrate = 1;
	if (abs(yy) <= 0.25 && yy != 0)
	{
		yrate = ceil(0.25 / abs(yy));
		if (game_tick % yrate == 0) { yy = yy * yrate; }
		else { yy = 0; }
	}
	#endregion
	#region Collision checking and movement.
	var xx = rdec(xx);
	var yy = rdec(yy);
	if (place_free(x + xx, y + yy))
	{
		//Moving into a free space.
		x += xx;
		y += yy;
	}
	else
	{
		if (place_free(x + xx, y)) { x += xx; }
		else
		{
			//Moving up against walls horizontally.
			if (xx > 0) { move_contact_solid(000, xx); }
			else { move_contact_solid(180, -xx); }
		}
	
		if (place_free(x, y + yy)) { y += yy; }
		else
		{
			//Moving up against walls vertically.
			if (yy > 0) { move_contact_solid(270, yy); }
			else { move_contact_solid(90, -yy); }
		}
	}
	#endregion
	return (x != x1 || y != y1);
}
#endregion
#region step_direction_solid_simple(direction, speed);
/// @description Causes an instance to step in a particular direction. Stops if it collides with given object.
/// @function step_direction_solid_simple
/// @param direction
/// @param speed
function step_direction_solid_simple(dir, spd) {
	#region Adjusting parameters
	if (spd < 0)
	{
		dir += 180;
		spd = abs(spd);
	}
	if (spd == 0)
	{
		return false;
	}
	#endregion
	#region Final movement.
	var xx = x + lengthdir_x(spd, dir);
	var yy = y + lengthdir_y(spd, dir);

	if (!place_free(xx, yy))
	{
		move_contact_solid(dir, spd);
	}
	else
	{
		x = xx;
		y = yy;
	}
	#endregion
	return (x != xprevious || y != yprevious);
}
#endregion
#region step_towards_point(x, y, distance);
/// @description Moves the instances towards a particular point a particular distance.
/// Returns true/false if it has moved or not.
/// @function step_towards_point(x, y, distance);
/// @param xx
/// @param yy
/// @param distance
function step_towards_point(xx, yy, dis)
{
	//Far enough to move. This check prevents vibrating once reached the position.
	if (point_distance(x, y, xx, yy) >= dis)
	{
		var dir = point_direction(x, y, xx, yy);
		step_direction(dir, dis);

		return true;
	}
	else
	{
		//Set the position exactly.
		x = xx;
		y = yy;
		return false;
	}
}
#endregion
#region step_towards_point(xx, yy, distance);
/// @description Moves the instances towards a particular point a particular distance.
/// Returns true/false if it has moved or not.
/// @function step_towards_point(x, y, distance);
/// @param x
/// @param y
/// @param distance
function step_towards_point_solid(xx, yy, dis)
{
	//Far enough to move. This check prevents vibrating once reached the position.
	dis = min(dis, point_distance(x, y, xx, yy));
	var dir = point_direction(x, y, xx, yy);

	return step_direction_solid(dir, dis);
}
#endregion
#region rdec();
/// @description Rounds a coordinate value to the 1/4 grid
/// @function rdec(value);
/// @param value
/// @param decimal
function rdec() {
	var value = argument[0];
	var ratio = 4;
	return round(value * ratio) / ratio;
}
#endregion