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