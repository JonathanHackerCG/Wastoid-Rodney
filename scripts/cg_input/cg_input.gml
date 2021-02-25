//Input channel definitions.
enum input
{
	//User defined inputs. Each check/axis needs its own enum value.
	//The defaults are provided for example. They may be changed.
	//These settings include an input for every gp input value.
	//It is recommended to remove any input IDs which are not being used.
	
	//Default user-defined buttons.
	SL,			//Left Shoulder Button
	SR,			//Right Shoulder Button
	start,	//Start Button
	
	//Default user-defined axes.
	axis_lx,	//Left Joystick X-Axis
	axis_ly,	//Left Joystick Y-Axis
	axis_rx,	//Right Joystick X-Axis
	axis_ry,	//Right Joystick Y-Axis
	
	//DO NOT MODIFY
	_total //End of the input enumerator.
}

//Input controller.
function InputController() constructor
{
	//InputController properties.
	_controller = instance_create_depth(0, 0, 0, obj_input_controller);
	_controller._owner = self;
	_input_data = array_create(input._total, undefined);
		
	//Define gamepad inputs.
	#region gamepad();
	/// @function gamepad();
	/// @description Returns the current gamepad slot.
	static gamepad = function()
	{
		return _gamepad;
	}
	#endregion
	#region gamepad_set(slot);
	/// @function gamepad_set(slot);
	/// @description Sets the currently active gamepad.
	static gamepad_set = function(_slot)
	{
		_gamepad = _slot;
	}
	#endregion
	#region gamepad_find();
	/// @function gamepad_find();
	/// @description Sets the gamepad to the first active gamepad.
	static gamepad_find = function()
	{
		//Search all gamepad slots.
		for (var i = 0; i <= 11; i++)
		{
			if (gamepad_is_connected(i))
			{
				_gamepad = i;
				return _gamepad;
			}
		}
		_gamepad = -1;
		return _gamepad;
	}
	#endregion
	_gamepad = self.gamepad_find();
	
	//Define input checks.
	#region _Check(name, key_check, gp_check); constructor
	/// @function _Check(name, key_check, gp_check);
	/// @description Constructor for an input check.
	/// @param name
	/// @param key_check
	/// @param gp_check
	static _Check = function(_name, _key_check, _gp_check) constructor
	{
		_type = "check";
		
		self._name = _name;
		self._key_check = _key_check;
		self._gp_check = _gp_check;
		
		_held = false;
		_pressed = false;
		_released = false;
		_not_held = false;
	}
	#endregion
	#region _Axis(name, key_pos, key_neg, gp_axis); constructor
	/// @function _Axis(name, key_pos, key_neg, gp_axis);
	/// @description Constructor for an Axis input.
	/// @param name
	/// @param key_pos
	/// @param key_neg
	/// @param gp_axis
	static _Axis = function(_name, _key_pos, _key_neg, _gp_axis) constructor
	{
		_type = "axis";
		
		self._name = _name;
		self._key_pos = _key_pos;
		self._key_neg = _key_neg;
		self._gp_axis = _gp_axis;
		
		_value = 0;
		_time = 0;
	}
	#endregion
	#region define_check(name, input, key_check, gp_check);
	/// @function define_check(name, input, key_check, gp_check);
	/// @description Defines a check.
	/// @param name
	/// @param input
	/// @param key_check
	/// @param gp_check
	static define_check = function(_name, _input, _key_check, _gp_check)
	{
		_input_data[_input] = new _Check(_name, _key_check, _gp_check);
	}
	#endregion
	#region define_axis(name, input, key_pos, key_neg, gp_axis);
	/// @function define_axis(name, input, key_pos, key_neg, gp_axis);
	/// @param name
	/// @param input
	/// @param key_pos
	/// @param key_neg
	/// @param gp_axis
	static define_axis = function(_name, _input, _key_pos, _key_neg, _gp_axis)
	{
		_input_data[_input] = new _Axis(_name, _key_pos, _key_neg, _gp_axis);
	}	
	#endregion
	
	//Update inputs.
	#region update_inputs();
	static update_inputs = function()
	{
		//Updating all input data.
		var check, pressed, released, held, not_held, value;
		for (var i = 0; i < input._total; i++)
		{
			//Getting each check/axis struct.
			check = _input_data[i];
			if (check == undefined) { continue; }
			
			if (check._type == "check")
			{
				#region Button Check Inputs
				//Setting default values.
				pressed = false;
				released = false;
				held = false;
				not_held = true;
				
				//Getting keyboard inputs for button checks.
				if (check._key_check != undefined)
				{
					pressed = keyboard_check_pressed(check._key_check);
					released = keyboard_check_released(check._key_check);
					held = keyboard_check(check._key_check);
				}
								
				//Getting gamepad inputs for button checks.
				if (gamepad_is_connected(_gamepad) && check._gp_check != undefined)
				{
					pressed = pressed || gamepad_button_check_pressed(_gamepad, check._gp_check);
					released = released || gamepad_button_check_released(_gamepad, check._gp_check);
					held = held || gamepad_button_check(_gamepad, check._gp_check);
				}
				not_held = !(pressed || released || held);
				
				//Set final input check values.
				check._pressed = pressed;
				check._released = released;
				check._held = held;
				check._not_held = not_held;
				#endregion
			}
			else
			{
				#region Axis Inputs
				//Setting default values.
				value = 0;
				
				//Getting keyboard input default axis values.
				if (check._key_pos != undefined && check._key_neg != undefined)
				{
					value = keyboard_check(check._key_pos) - keyboard_check(check._key_neg);
				}
				
				//Getting gamepad axis values.
				if (gamepad_is_connected(_gamepad) && check._gp_axis != undefined)
				{
					var gp_value = gamepad_axis_value(_gamepad, check._gp_axis);
					if (abs(gp_value) > value) { value = gp_value; }
				}
				
				//Incrementing axis time.
				check._value = value;
				if (value = 0) { check._time = 0; }
				else { check._time ++; }
				#endregion
			}
		}
	}
	#endregion
	#region print();
	/// @function print();
	/// @description Returns current input values as one string.
	static print = function()
	{
		//Loop for every input.
		var output = "";
		for (var i = 0; i < input._total; i++)
		{
			var check = _input_data[i];
			if (check != undefined)
			{
				output += check._name + ": ";
				if (check._type == "check")
				{
					output += string(check._pressed) + " ";
					output += string(check._held) + " ";
					output += string(check._released) + " ";
					output += string(check._not_held) + "\n\r";
				}
				else
				{
					output += string(check._value) + " ";
					output += string(check._time) + "\n\r";
				}
			}
			else
			{
				output += "--- Undefined Input ---\n\r";
			}
		}
		return output;
	}
	#endregion
	
	//Check inputs.
	#region check_held(input);
	/// @function check_held(input);
	/// @description Returns the held state of a check input.
	/// @param input
	static check_held = function(_input)
	{
		var check = _input_data[_input];
		if (check._type == "check")	{ return check._held; }
		else { show_error("Error with check_held. Input is an axis.", false); }
	}
	#endregion
	#region check_pressed(input);
	/// @function check_pressed(input);
	/// @description Returns the held state of a check input.
	/// @param input
	static check_pressed = function(_input)
	{
		var check = _input_data[_input];
		if (check._type == "check")	{ return check._pressed; }
		else { show_error("Error with check_pressed. Input is an axis.", false); }
	}
	#endregion
	#region check_released(input);
	/// @function check_released(input);
	/// @description Returns the released state of a check input.
	/// @param input
	static check_released = function(_input)
	{
		var check = _input_data[_input];
		if (check._type == "check")	{ return check._released; }
		else { show_error("Error with check_released. Input is an axis.", false); }
	}
	#endregion
	#region check_not_held(input);
	/// @function check_not_held(input);
	/// @description Returns the held state of a check input.
	/// @param input
	static check_not_held = function(_input)
	{
		var check = _input_data[_input];
		if (check._type == "check")	{ return check._not_held; }
		else { show_error("Error with check_not_held. Input is not a check.", false); }
	}
	#endregion
	#region check_name(_input);
	/// @function check_name(input);
	/// @description Returns the name of a check.
	/// @param input
	static check_name = function(_input)
	{
		return _input_data[_input]._name;
	}
	#endregion
	
	//Check axes.
	#region axis_value(input);
	/// @function axis_value(input);
	/// @description Returns the current value of an axis.
	/// @param input
	static axis_value = function(_input)
	{
		var axis = _input_data[_input];
		if (axis._type == "axis") { return axis._value; }
		else { show_error("Error with axis_value. Input is not an axis.", false); }
	}
	#endregion
	#region axis_time(input);
	/// @function axis_time(input);
	/// @description Returns the current value of an axis.
	/// @param input
	static axis_time = function(_input)
	{
		var axis = _input_data[_input];
		if (axis._type == "axis") { return axis._time; }
		else { show_error("Error with axis_time. Input is not an axis.", false); }
	}
	#endregion
	#region axis_name(input);
	/// @function axis_name(input);
	/// @description Returns the name of an axis.
	/// @param input
	static axis_name = function(_input)
	{
		return _input_data[_input]._name;
	}
	#endregion
	
	//InputController cleanup.
	#region InputController.destroy();
	/// @function destroy();
	/// @description Cleans up the InputController.
	static destroy = function()
	{
		instance_destroy(_controller);
	}
	#endregion
}