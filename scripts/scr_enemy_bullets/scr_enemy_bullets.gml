#region bullet_ring(number, speed);
/// @function bullet_ring(number, speed);
/// @param num
/// @param spd
function bullet_ring(_num, _spd)
{
	var angle = irandom(360 / _num);
	repeat (_num)
	{
		bullet(obj_bullet_enemy, angle, _spd);
		angle += 360 / _num;
	}
}
#endregion
#region bullet_target(speed);
/// @function bullet_target(speed);
/// @param spd
function bullet_target(_spd)
{
	var angle = point_direction(x, y, player.x, player.y);
	bullet(obj_bullet_enemy, angle + irandom_off(5), _spd);
}
#endregion
#region bullet_spiral(speed);
/// @function bullet_spiral(speed);
/// @param spd
function bullet_spiral(_spd)
{
	var angle = fire_angle;
	bullet(obj_bullet_enemy, angle, _spd);
	bullet(obj_bullet_enemy, angle + 180, _spd);
	
	fire_angle += 20;
	fire_angle = fire_angle % 360;
}
#endregion