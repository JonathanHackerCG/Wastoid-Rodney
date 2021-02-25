//Weighted list.
function Wlist() constructor
{
	//Properties.
	_list = ds_list_create();
	_weight = 0;
	
	//Wlist getters/setters.
	#region Wlist.clear();
	/// @function clear();
	/// @description Clears all values from the Wlist.
	static clear = function()
	{
		var size = ds_list_size(_list);
		for (var i = 0; i < size; i++)
		{
			delete _list[| i];
		}
		ds_list_clear(_list);
	}
	#endregion
	#region Wlist.weight();
	/// @function weight();
	/// @description Returns the total weight of the Wlist.
	static weight = function()
	{
		return _weight;
	}
	#endregion
	#region Wlist.size();
	/// @function size();
	/// @description Returns the length of the Wlist.
	static size = function()
	{
		return ds_list_size(_list);
	}
	#endregion
	#region Wlist.empty();
	/// @function empty();
	/// @description Returns true for empty Wlist.
	static empty = function()
	{
		return ds_list_empty(_list);
	}
	#endregion
	#region Wlist.index_value(index);
	/// @function index_value(index);
	/// @description Returns the value of the node at a position index.
	/// @param index
	static index_value = function(_index)
	{
		return _list[| _index]._value;
	}
	#endregion
	#region Wlist.index_weight(index);
	/// @function index_weight(index);
	/// @description Returns the weight of a wlist node at position index.
	/// @param index
	static index_weight = function(_index)
	{
		return _list[| _index]._weight;
	}
	#endregion
	#region Wlist.index_find_value(pos, value);
	/// @function index_find_value(pos, value);
	/// @description Finds the index of a node with a certain value, starting at pos.
	/// @param pos
	/// @param value
	static index_find_value = function(_pos, _value)
	{
		var length = size();
		for (var i = _pos; i < length; i++)
		{
			if (_list[| i]._value == _value) { return i; }
		}
		return -1;
	}
	#endregion
	#region Wlist.index_find_weight(pos, weight);
	/// @function index_find_weight(pos, weight);
	/// @description Finds the index of a node with a certain weight, starting at pos.
	/// @param pos
	/// @param value
	static index_find_weight = function(_pos, _weight)
	{
		var length = size();
		for (var i = _pos; i < length; i++)
		{
			if (_list[| i]._weight == _weight) { return i; }
		}
		return -1;
	}
	#endregion
	#region Wlist.print();
	/// @function print();
	/// @description Outputs a string showing the contents of the Wlist.
	static print = function()
	{
		var output = "";
		var length = size();
		for (var i = 0; i < length; i++)
		{
			output += "(" + string(index_value(i)) + ", " + string(index_weight(i)) + ")\n\r";
		}
		return output;
	}
	#endregion
	
	//Wlist operations.
	#region Wlist._Node(); constructor
	/// @function _Node();
	/// @description Creates a new node for the Wlist.
	static _Node = function(_val, _w) constructor
	{
		_value = _val;
		_weight = _w;
	}
	#endregion
	#region Wlist.add(value, weight);
	/// @function add(value, weight);
	/// @description Adds a new node with given value and weight.
	/// @param value
	/// @param weight
	static add = function(_val, _w)
	{
		ds_list_add(_list, new _Node(_val, _w));
		_weight += _w;
	}
	#endregion
	#region Wlist.remove(index);
	/// @function remove(index);
	/// @description Removes a node at a position index.
	/// @param index
	static remove = function(_index)
	{
		var node = _list[| _index];
		_weight -= node._weight;
		ds_list_delete(_list, _index);
		delete node;
	}
	#endregion
	#region Wlist.pick([remove]);
	/// @function pick([remove]);
	/// @description Chooses a random value from the Wlist based on its weight.
	/// @param [remove]
	static pick = function(_remove)
	{
		if (!is_undefined(_remove)) { _remove = false; }
		
		//Randomization.
		var chance = irandom_range(1, weight());
		ds_list_shuffle(_list);
		
		//Finding the node to choose.
		var count = 0;
		var length = size();
		for (var i = 0; i < length; i++)
		{
			//If the count exceeds the random chance, return that value.
			count += index_weight(i);
			if (chance <= count)
			{
				var val = index_value(i);
				if (_remove) { remove(i); }
				return val;
			}
		}
	}
	#endregion

	//Wlist cleanup.
	#region Wlist.destroy();
	/// @description Clears the data in a wlist.
	function destroy()
	{
		clear();
		ds_list_destroy(_list);
	}
	#endregion
}