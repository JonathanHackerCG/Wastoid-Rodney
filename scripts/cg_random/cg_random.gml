//Randomization and Selection Functions

//Miscellaneous functions.
#region percent(percent);
/// @description Returns true some percentage of times it is run.
/// @param percent
function percent(_percent)
{
	if (_percent <= 0) { return false; }
	return random(100) <= _percent;
}
#endregion
#region roll_dice(num, sides);
/// @description Returns the sum of rolling some number of dice with a number of sides.
/// CREDIT: GMLscripts.com/license
function roll_dice(_num, _sides)
{
	var sum = 0;
	repeat(_num) { sum += irandom_range(1, _sides); }
	return sum;
}
#endregion
#region choose_list(list);
/// @function choose_list(list);
/// @param list
function choose_list(_list)
{
	return _list[| irandom(ds_list_size(_list))];
}
#endregion

//Random offset.
#region random_off(value);
/// @description Returns a random decimal value between -value and value.
function random_off(_value)
{
	return random_range(-_value, _value);
}
#endregion
#region irandom_off(value);
/// @description Returns a random integer value between -value and value.
function irandom_off(_value)
{
	return irandom_range(-_value, _value);
}
#endregion

//Selction functions.
#region select(n, ...);
/// @description Returns an argument with index n.
/// CREDIT: GMLscripts.com/license
function select(n)
{
	if (!is_real(n)) { return undefined; }
	else
	{
		n = clamp(n + 1, 1, argument_count - 1);
		return argument[n];
	}
}
#endregion
#region select_index(target, ...);
/// @description Returns the index of an argument matching target.
function select_index(_target)
{
	//Iterate through the optional arguments.
	for (var i = 1; i < argument_count; i++)
	{
		if (argument[0] == argument[i])
		{
			return i - 1;
		}
	}
	return undefined;
}
#endregion