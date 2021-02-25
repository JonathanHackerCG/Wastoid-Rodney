//FunctionQueue.
function FunctionQueue() constructor
{
	_functions = ds_list_create();
	_target = noone;
	_pos = 0;
	
	//FunctionQueue setters/getters.
	#region FunctionQueue.clear();
	/// @function clear();
	/// @description Clears the FunctionQueue and resets pos.
	static clear = function()
	{
		ds_list_clear(_functions);
		_pos = 0;
	}
	#endregion
	#region FunctionQueue.size();
	/// @function size();
	/// @description Returns the current size of the queue.
	static size = function()
	{
		return ds_list_size(_functions);
	}
	#endregion
	#region FunctionQueue.empty();
	/// @function empty();
	/// @description Returns true for empty FunctionQueue.
	static empty = function()
	{
		return ds_list_empty(_functions);
	}
	#endregion
	#region FunctionQueue.set_target(target);
	/// @function set_target(target);
	/// @description Sets the target instance to perform the functions.
	/// @param target
	static set_target = function(_target)
	{
		self._target = _target;
	}
	#endregion
	#region FunctionQueue.print();
	/// @function print();
	/// @description Outputs the contents of the FunctionQueue as a string.
	static print = function()
	{
		var size = ds_list_size(_functions);
		var output = "FunctionQueue Functions:\n";
		for (var i = 0; i < size; i++)
		{
			output += script_get_name(_functions[| i]) + "\n";
		}
		return output;
	}
	#endregion
	
	//FunctionQueue operations.
	#region FunctionQueue.update();
	/// @function update();
	/// @description Run current function and update conditionally.
	static update = function()
	{
		//Check for functions in the queue.
		if (ds_list_empty(_functions)) { return false; }
		
		//Run the function, if it returns true progress to the next function in the queue.
		var func = _functions[| _pos];
		if (_target == noone) { var done = func(); }
		else { with(_target) { var done = func(); } }
		
		if (done)
		{
			_pos++;
			var size = ds_list_size(_functions);
			if (_pos >= size)
			{
				clear();
				return false;
			}
			return true;
		}
	}
	#endregion
	#region FunctionQueue.insert_pos(pos, function);
	/// @function insert_pos(pos, function);
	/// @description Inserts some functions at a position.
	/// @param pos
	/// @param function
	static insert_pos = function(_pos)
	{
		for (var i = 1; i < argument_count; i++)
		{
			//Insert every input into the functions list.
			ds_list_insert(_functions, _pos + i - 1, argument[i]);
		}
	}
	#endregion
	#region FunctionQueue.insert_next(function);
	/// @function insert_next(function);
	/// @description Inserts some functions after the current position.
	/// @param function
	static insert_next = function()
	{
		for (var i = 0; i < argument_count; i++)
		{
			//Insert every input into the functions list.
			ds_list_insert(_functions, _pos + 1 + i, argument[i]);
		}
	}
	#endregion
	#region FunctionQueue.insert_append(function);
	/// @function insert_append(function);
	/// @description Inserts some functions at the end of the FunctionQueue.
	/// @param function
	static insert_append = function()
	{
		for (var i = 0; i < argument_count; i++)
		{
			//Insert every input into the functions list.
			ds_list_add(_functions, argument[i]);
		}
	}
	#endregion
	#region FunctionQueue.back();
	/// @function back();
	/// @description Moves the queue back one position.
	static back = function()
	{
		_pos --;
	}
	#endregion
		
	//FunctionQueue cleanup.
	#region FunctionQueue.destroy();
	/// @description Clears all dynamic memory from the FunctionQueue.
	function destroy()
	{
		ds_list_destroy(_functions);
	}
	#endregion
}

#region function_ext(_function, _params);
/// @description Runs a functin/method with a list of parameters.
/// @param function
/// @param parameters
function function_ext(_function, _params)
{
	var size = ds_list_size(_params);
	switch(size)
	{
		case 0: return _function();
		case 1: return _function(_params[| 0]);
		case 2: return _function(_params[| 0], _params[| 1]);
		case 3: return _function(_params[| 0], _params[| 1], _params[| 2]);
		case 4: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3]);
		case 5: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4]);
		case 6: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5]);
		case 7: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5], _params[| 6]);
		case 8: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5], _params[| 6], _params[| 7]);
		case 9: return _function(_params[| 0], _params[| 1], _params[| 2], _params[| 3], _params[| 4], _params[| 5], _params[| 6], _params[| 7], _params[| 8]);
		default: show_error("Too many arguments. Update function_ext to make it work, you nitwit!", false); return false;
	}
}
#endregion