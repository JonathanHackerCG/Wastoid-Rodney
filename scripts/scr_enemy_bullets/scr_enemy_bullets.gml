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