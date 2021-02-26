/// @function bullet(bullet, direction, speed);
/// @description Creates a bullet at current location with given direction and speed.
/// @param bullet
/// @param direction
/// @param speed
function bullet(_bullet, _dir, _spd)
{
	var inst = instance_create_layer(x, y, layer, _bullet);
	inst.move_direction = _dir;
	inst.var_speed = _spd;
	return inst;
}