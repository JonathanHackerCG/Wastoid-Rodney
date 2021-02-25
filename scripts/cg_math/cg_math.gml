//Math, Rounding, and Conversion Functions

//Miscellaneous functions.
#region wrap(value, min, max);
/// @description Returns a value, wrapping it between two values.
/// CREDIT: GMLscripts.com/license
/// @param value
/// @param min
/// @param max
function wrap(_value, _min, _max)
{
	if (_max - _min == 0) { return _value; }
	var _mod = (_value - _min) % (_max - _min);
	if (_mod < 0) { return _mod + _max }
	else { return _mod + _min };
}
#endregion
#region alerp(val1, val2, amount);
/// @description Linear interpolation between two angles (correctly over the threshold).
/// @param val1
/// @param val2
/// @param amount
function alerp(_val1, _val2, _amount)
{
	_val1 += angle_difference(_val2, _val1) * _amount;
	return _val1;
}
#endregion
#region emod(val1, val2);
/// @description Modulo with positive remainder.
/// CREDIT: Sahaun (Discord)
function emod(_val1, _val2)
{
    var _mod = _val1 % _val2;
    if (_mod < 0) { _mod += abs(_val2); }
    return _mod;
}
#endregion

//Checking values.
#region is_between(target, val1, val2);
/// @description Returns true if the target value is between val1 and val2.
function is_between(_target, _val1, _val2)
{
	return median(_target, _val1, _val2);
}
#endregion
#region is_even(value);
/// @description Returns true for even values.
/// CREDIT: GMLscripts.com/license
function is_even(_value)
{
	return !(_value & 1);
}
#endregion
#region is_odd(value);
/// @description Returns true for odd values.
/// CREDIT: GMLscripts.com/license
function is_odd(_value)
{
	return (_value & 1);
}
#endregion

//Rounding functions.
#region ceil_divd(value, factor);
/// @description Round up to the nearest fraction of a value.
/// @param value
/// @param factor
function ceil_divd(_value, _factor)
{
	return ceil(_value * _factor) / _factor;
}
#endregion
#region floor_divd(value, factor);
/// @description Rounds down to the nearest fraction of a value.
/// @param value
/// @param factor
function floor_divd(_value, _factor)
{
	return floor(_value * _factor) / _factor;
}
#endregion
#region round_divd(value, factor);
/// @description Rounds to the nearest fraction of a value.
/// @param value
/// @param factor
function round_divd(_value, _factor)
{
	return round(_value * _factor) / _factor;
}
#endregion
#region ceil_mult(value, factor);
/// @description Rounds up to the nearest multiple of a value.
/// @param value
/// @param factor
function ceil_mult(_value, _factor)
{
	return ceil(_value / _factor) * _factor;
}
#endregion
#region floor_mult(value, factor);
/// @description Rounds down to the nearest multiple of a value.
/// @param value
/// @param factor
function floor_mult(_value, _factor)
{
	return floor(_value / _factor) * _factor;
}
#endregion
#region round_mult(value, factor);
/// @description Rounds to the nearest multiple of a value.
/// @param value
/// @param factor
function round_mult(_value, _factor)
{
	return round(_value / _factor) * _factor;
}
#endregion

//Converting values.
#region second(seconds);
function second(seconds)
{
	return (seconds * game_get_speed(gamespeed_fps));
}
#endregion
#region minute(minutes);
function minute(minutes)
{
	return (second(minutes) * 60);
}
#endregion