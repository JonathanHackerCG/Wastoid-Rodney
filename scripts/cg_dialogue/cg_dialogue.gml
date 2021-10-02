//DialogueQueue textbox type ID.
enum textbox_type
{
	//Text display types.
	name,
	text,
	voice,
	question,
	answer,
	answer_input,
	menu,
	
	//Commands.
	goto,
	here,
	wait,
	
	//Custom.
	speaker,
	
	//Functions.
	event_execute,
	func_execute,
	func_queue
}

//DialogueQueue constructor.
function DialogueQueue() constructor
{
	//DialogueQueue properties.
	_textboxes = ds_list_create();
	_answer_list = ds_list_create();
	_function_queue = new FunctionQueue();
	_controller = instance_create_depth(0, 0, 0, obj_dialogue_controller);
	_controller._owner = self;
	#region Temporary variables (for use in dialogue trees).
	tempA = undefined;
	tempB = undefined;
	tempC = undefined;
	#endregion
	#region Display properties defaults.
	_pos = -1;
	_pos_offset = 1;
	_active = false;
	_timer = -1;
	_nametag = "";
	_message = "";
	_answer_num = 0;
	
	//Custom
	_speaker = noone;
	_alpha = 1.00;
	#endregion
	#region Control input values.
	_input_confirm = false;
	_input_up = false;
	_input_down = false;
	#endregion
	#region DEFINE Display coordinate values.
	draw_x = 128;
	draw_y = 256;
	#region set_position(x, y);
	/// @function set_position(x, y);
	/// @description The display offset to the top/left corner of the main box.
	/// @param x
	/// @param y
	static set_position = function(_x1, _y1)
	{
		draw_x = _x1;
		draw_y = _y1;
	}
	#endregion
		
	#region DEFINE Nametag variables.
	name_bufferT = 8;
	name_bufferB = 8;
	name_bufferL = 8;
	name_bufferR = 8;
	name_height = 32;
	name_width = 256;
	name_sprite = spr_dialogue_name;
	name_font = fnt_debug;
	#endregion
	#region set_name_buffer(bufferT, bufferB, bufferL, bufferR);
	/// @function set_name_buffer(bufferT, bufferB, bufferL, bufferR);
	/// @description Sets the text buffers on the nametag box.
	/// @param bufferT
	/// @param bufferB
	/// @param bufferL
	/// @param bufferR
	static set_name_buffer = function(_bufferT, _bufferB, _bufferL, _bufferR)
	{
		name_bufferT = _bufferT;
		name_bufferB = _bufferB;
		name_bufferL = _bufferL;
		name_bufferR = _bufferR;
	}
	#endregion
	#region set_name_display(sprite, height, width, font);
	/// @function set_name_display(sprite, height, width, font);
	/// @description Defines the sprite, height, and width of the nametag box.
	/// @param sprite
	/// @param height
	/// @param width
	/// @param font
	static set_name_display = function(_sprite, _height, _width, _font)
	{
		name_sprite = _sprite;
		name_height = _height;
		name_width = _width;
		name_font = _font;
	}
	#endregion
		
	#region DEFINE Textbox variables.
	box_bufferT = 8;
	box_bufferB = 8;
	box_bufferL = 8;
	box_bufferR = 8;
	box_height = 128;
	box_width = 256;
	box_sprite = spr_dialogue_box;
	box_font = fnt_debug;
	box_separation = 16;
	#endregion
	#region set_box_buffer(bufferT, bufferB, bufferL, bufferR);
	/// @function set_box_buffer(bufferT, bufferB, bufferL, bufferR);
	/// @description Sets the text buffers on the nametag box.
	/// @param bufferT
	/// @param bufferB
	/// @param bufferL
	/// @param bufferR
	static set_box_buffer = function(_bufferT, _bufferB, _bufferL, _bufferR)
	{
		box_bufferT = _bufferT;
		box_bufferB = _bufferB;
		box_bufferL = _bufferL;
		box_bufferR = _bufferR;
	}
	#endregion
	#region set_box_display(sprite, height, width, font, separation);
	/// @function set_box_display(sprite, height, width, font, separation);
	/// @description Defines the sprite, height, and width of the nametag box.
	/// @param sprite
	/// @param height
	/// @param width
	/// @param font
	/// @param separation
	static set_box_display = function(_sprite, _height, _width, _font, _separation)
	{
		box_sprite = _sprite;
		box_height = _height;
		box_width = _width;
		box_font = _font;
		box_separation = _separation;
	}
	#endregion
		
	#region DEFINE Answer variables.
	answer_bufferT = 8;
	answer_bufferB = 8;
	answer_bufferL = 8;
	answer_bufferR = 8;
	answer_height = 32;
	answer_width = 256;
	answer_sprite = spr_dialogue_answer;
	answer_sprite_select = spr_dialogue_answer_select;
	answer_font = fnt_debug;
	answer_gap = 8;
	#endregion
	#region set_answer_buffer(bufferT, bufferB, bufferL, bufferR, gap);
	/// @function set_answer_buffer(bufferT, bufferB, bufferL, bufferR, gap);
	/// @description Sets the text buffers on the nametag box.
	/// @param bufferT
	/// @param bufferB
	/// @param bufferL
	/// @param bufferR
	/// @param gap
	static set_answer_buffer = function(_bufferT, _bufferB, _bufferL, _bufferR, _gap)
	{
		answer_bufferT = _bufferT;
		answer_bufferB = _bufferB;
		answer_bufferL = _bufferL;
		answer_bufferR = _bufferR;
		answer_gap = _gap;
	}
	#endregion
	#region set_answer_display(sprite, select, height, width, font, separation);
	/// @function set_answer_display(sprite, select, height, width, font);
	/// @description Defines the sprite, height, and width of the nametag box.
	/// @param sprite
	/// @param select
	/// @param height
	/// @param width
	/// @param font
	static set_answer_display = function(_sprite, _select, _height, _width, _font)
	{
		answer_sprite = _sprite;
		answer_sprite_select = _select;
		answer_height = _height;
		answer_width = _width;
		answer_font = _font;
	}
	#endregion
			
	show_bounds = false;
	#region set_debug(enabled);
	/// @function set_debug(enabled);
	/// @description Enables/Disabled the debug display properties.
	/// @param enabled
	static set_debug = function(_enabled)
	{
		show_bounds = _enabled;
	}
	#endregion
	#endregion
	
	//Setting display properties.
	#region DialogueQueue.set_active(active);
	/// @function set_active(active);
	/// @description Sets the current active state of the DialogueQueue.
	/// @param active
	static set_active = function(_active)
	{
		self._active = _active;
	}
	#endregion
	
	//DialogueQueue drawing/updating.
	#region DialogueQueue.draw();
	/// @function draw();
	/// @description Draws the DialogueQueue according to current display properties.
	static draw = function()
	{
		//Exit if not currently drawing.
		if (!is_active() || empty() || _pos < 0) { exit; }
		
		var textbox = _textboxes[| _pos];
		var type = textbox.type;

		switch (type)
		{
			case textbox_type.text:
			case textbox_type.question:
			case textbox_type.menu:
			case textbox_type.voice:
			{
				#region Initialize default display variables.
				var name = _nametag;
				var text = _message;
				var xoff = camera.xpos + draw_x;
				var yoff = camera.ypos + draw_y;
				#endregion
			
				//Question/Answer display offsets.
				if (type == textbox_type.question || type == textbox_type.menu)
				{
					yoff -= _answer_num * (answer_height + answer_gap);
					#region Calculating position coordinates.
					var ansx1 = xoff + answer_bufferL;
					var ansy1 = yoff + box_height + answer_bufferT + answer_gap;
					var ansx2 = xoff + answer_width - answer_bufferR;
					var ansy2 = yoff + box_height + answer_height - answer_bufferB + answer_gap;
					//var answ = answer_width - (answer_bufferL + answer_bufferR);
					#endregion
					#region Drawing all the answer boxes (for question textboxes).
					for (var i = 0; i < _answer_num; i++)
					{
						var ans = _answer_list[| i];
						var off = (i * (answer_height + answer_gap));
						var aid = 0 + (ans.toggle_execute != noone) + ans.toggle;
					
						draw_sprite(answer_sprite, aid, ansx1 - answer_bufferL, ansy1 - answer_bufferT + off);
						if (_answer_select == i) { draw_sprite(answer_sprite_select, aid, ansx1 - answer_bufferL, ansy1 - answer_bufferT + off); }
						if (show_bounds) { draw_rectangle(ansx1, ansy1 + off, ansx2, ansy2 + off, true); }
						ans.text.draw(ansx1, ansy1 + off);
					}
					#endregion
				}
			
				if (type != textbox_type.voice)
				{
					#region Drawing nametag.
					if (name != "")
					{
						draw_sprite(name_sprite, 0, xoff, yoff);
				
						var namex1 = xoff + name_bufferL;
						var namey1 = yoff + name_bufferT - name_height;
						var namex2 = xoff + name_width - name_bufferB;
						var namey2 = yoff - name_bufferR;
			
						if (show_bounds) { draw_rectangle(namex1, namey1, namex2, namey2, true); }
						name.draw(namex1, namey1);
					}
					#endregion
					#region Drawing textbox.
					if (type != textbox_type.menu)
					{
						draw_sprite(box_sprite, 0, xoff, yoff);
			
						var boxx1 = xoff + box_bufferL;
						var boxy1 = yoff + box_bufferT;
						var boxx2 = xoff + box_width - box_bufferR;
						var boxy2 = yoff + box_height - box_bufferB;
			
						if (show_bounds) { draw_rectangle(boxx1, boxy1, boxx2, boxy2, true); }
						text.draw(boxx1, boxy1);
					}
					#endregion
				}
				else
				{
					text.draw(camera.xcenter, camera.ycenter);
				}
			} break;
		}
	}
	#endregion
	#region DialogueQueue.update();
	/// @function update();
	/// @description Update performed every step. Check for inputs and process commands.
	static update = function()
	{
		//Exit if not currently updating.
		if (!is_active() || empty() || _pos < 0) { exit; }
		_pos_offset = 1;
		
		//Checking for user inputs.
		#region Getting textbox properties.
		var textbox = _textboxes[| _pos];
		var type = textbox.type;
		#endregion
		#region Performing updates based on input.
		switch (type)
		{
			#region Text/Voice
			case textbox_type.text:
			case textbox_type.voice:
			{
				//Confirming text.
				if (_input_confirm) { next(); audio.play_sound(snd_confirm, !global.mute_sound / 2); }
			} break;
			#endregion
			#region Question/Answer
			case textbox_type.question:
			case textbox_type.menu:
			{
				//Confirming answer to question.
				if (_answer_num > 0)
				{
					var ans = _answer_list[| _answer_select];
					
					//Switching answers.
					if (_input_up) { _answer_select = wrap(_answer_select - 1, 0, _answer_num); audio.play_sound(snd_select, !global.mute_sound / 2); }
					if (_input_down) { _answer_select = wrap(_answer_select + 1, 0, _answer_num); audio.play_sound(snd_select, !global.mute_sound / 2); }
					if (_input_confirm)
					{
						//Choosing answer and goto target position.
						if (!is_undefined(ans.pos))
						{
							if (ans.toggle_execute != noone)
							{
								ans.toggle_execute();
								ans.toggle = ans.toggle_check();
								audio.play_sound(snd_confirm, !global.mute_sound / 2);
							}
							else
							{
								//Jump to position.
								_goto_execute(ans.pos);
								audio.play_sound(snd_confirm, !global.mute_sound / 2);
								next();
							}
						}
					}
					//Answer inputs.
					if (ans.type == textbox_type.answer_input)
					{
						ans.func(ans.params);
					}
				}
			} break;
			#endregion
			#region Waiting on Wait timer.
			case textbox_type.wait:
			{
				_timer --;
				if (_timer <= -1) { next(); }
			} break;
			#endregion
			#region Waiting on FunctionQueue.
			case textbox_type.func_queue:
			{
				//Updating function queue.
				_function_queue.update();
				if (_function_queue.empty()) { next(); }
			} break;
			#endregion
			default: break;
		}
		#endregion
		
		//Reset to default. (False).
		_input_confirm = false;
		_input_up = false;
		_input_down = false;
	}
	#endregion
	#region DialogueQueue.next();
	/// @function next();
	/// @description Moves to the next textbox in the DialogueQueue.
	static next = function()
	{
		//Exit if there is nothing in the DialogueQueue.
		if (empty()) { exit; }
		
		set_active(true);
		#region Increment and end dialogue if the queue is finished.
		_pos ++;
		if (_pos >= size() || _pos < 0)
		{
			clear();
			set_active(false);
			exit;
		}
		#endregion
		#region Getting textbox properties.
		var textbox = _textboxes[| _pos];
		var type = textbox.type;
		#endregion
		switch (type)
		{
			#region Nametag/Speaker
			case textbox_type.speaker:
			{
				_speaker = textbox._id;
				if (textbox._id != noone)
				{
					//var inst = textbox._id;
					//part_animation(inst.x, inst.y - 14, "PartAbove", part_speaker);
				}
			} //Skip Break
			case textbox_type.name:
			{
				if (textbox.name != "")
				{
					_nametag = textbox.name;
				} else { _nametag = ""; }
				next();
			} break;
			#endregion
			#region Text
			case textbox_type.text:
			case textbox_type.voice:
			{
				_message = textbox.text;
			} break;
			#endregion
			#region Question
			case textbox_type.question:
			case textbox_type.menu:
			{
				if (type == textbox_type.question)
				{
					_message = textbox.text;
				}
				else { _message = ""; }
				_answer_select = textbox.select;
				ds_list_clear(_answer_list);
				#region Building a list of answers after a question.
				var count = 0;
				var length = size();
				while (_pos + 1 + count < length)
				{
					count ++;
					var textbox = _textboxes[| _pos + count];
					if (textbox.type == textbox_type.answer || textbox.type == textbox_type.answer_input)
					{
						ds_list_add(_answer_list, textbox);
					}
					else { break; } //Cancel if not an answer.
				}
				_answer_num = ds_list_size(_answer_list);
				#endregion
			} break;
			#endregion
			#region Goto
			case textbox_type.goto:
			{
				_goto_execute(textbox.pos);
				next();
			} break;
			#endregion
			#region Wait
			case textbox_type.wait:
			{
				_timer = textbox.frames;
			} break;
			#endregion
			#region Execute Function
			case textbox_type.func_execute:
			{
				if (textbox.params == noone) { textbox.func(); }
				else { textbox.func(textbox.params); }
				next();
			} break;
			#endregion
			#region Queue Function
			case textbox_type.func_queue:
			{
				_function_queue.insert_append(textbox.func);
			} break;
			#endregion
			#region Skipping
			case textbox_type.here:
			case textbox_type.answer:
			case textbox_type.answer_input:
			{
				next();
			} break;
			#endregion
			default: break;
		}
	}
	#endregion
	#region DialogueQueue.input_confirm();
	/// @function intput_confirm();
	/// @description Confirms input. Progress dialogue.
	static input_confirm = function()
	{
		_input_confirm = true;
	}
	#endregion
	#region DialogueQueue.input_up();
	/// @function input_up();
	/// @description Up input for selecting answer boxes.
	static input_up = function()
	{
		_input_up = true;
	}
	#endregion
	#region DialogueQueue.input_down();
	/// @function input_down();
	/// @description Down input for selecting answers.
	static input_down = function()
	{
		_input_down = true;
	}
	#endregion
	
	//DialogueQueue getters/setters.
	#region DialogueQueue.clear();
	/// @function clear();
	/// @description Clears the DialogueQueue.
	static clear = function()
	{
		_nametag = "";
		ds_list_clear(_textboxes);
		_pos = -1;
		set_active(false);
	}
	#endregion
	#region DialogueQueue.reset();
	/// @function reset();
	/// @description Resets the dialogue to the start.
	static reset = function()
	{
		_pos = -1;
		_function_queue.clear();
		con.next();
	}
	#endregion
	#region DialogueQueue.size();
	/// @function size();
	/// @description Returns the current size of the DialogueQueue.
	static size = function()
	{
		return ds_list_size(_textboxes);
	}
	#endregion
	#region DialogueQueue.empty();
	/// @function empty();
	/// @description Returns true for an empty DialogueQueue.
	static empty = function()
	{
		return ds_list_empty(_textboxes);
	}
	#endregion
	#region DialogueQueue.is_active();
	/// @function is_active();
	/// @description Returns the active state of the DialogueQueue.
	static is_active = function()
	{
		return _active;
	}
	#endregion
	
	//Queuing display text.
	#region DialogueQueue._Textbox(); constructor
	/// @function _Textbox();
	/// @description Constructor for a general textbox.
	/// @param type
	static _Textbox = function(_type) constructor
	{
		type = _type;
		
		#region update_text(string, font);
		/// @function update_text
		/// @param string
		static update_text = function(_string)
		{
			text = scribble(_string);
			text.starting_format(con.box_font);
			text.wrap(con.box_width);
		}
		#endregion
		#region update_answer(string, font);
		/// @function update_answer
		/// @param string
		static update_answer = function(_string)
		{
			text = scribble(_string);
			text.starting_format(con.answer_font);
			text.wrap(con.answer_width);
		}
		#endregion
	}
	#endregion
	#region DialogueQueue._textbox_queue(textbox);
	/// @function _textbox_queue(textbox);
	/// @description Adds a newly created textbox to the _textboxes list.
	/// @param textbox
	static _textbox_queue = function(_textbox)
	{
		if (is_active())
		{
			ds_list_insert(_textboxes, _pos + _pos_offset, _textbox);
			_pos_offset ++; //Handles inserting multiple things on the same step in order.
		}
		else { ds_list_add(_textboxes, _textbox); }
		return _textbox;
	}
	#endregion
	#region DialogueQueue.nametag(name);
	/// @function nametag(name);
	/// @description Updates the current nametag. Persists.
	/// @param name
	static nametag = function(_name)
	{
		var textbox = new _Textbox(textbox_type.name);
		textbox.name = scribble(_name);
		textbox.name.starting_format(name_font);
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.text(text);
	/// @function text(text);
	/// @description Adds a text textbox.
	/// @param text
	static text = function(_text)
	{
		var textbox = new _Textbox(textbox_type.text);
		textbox.update_text(_text);
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.voice(text);
	/// @function voice(text);
	/// @description Adds a voice textbox.
	/// @param text
	static voice = function(_text)
	{
		var textbox = new _Textbox(textbox_type.voice);
		textbox.text = scribble(_text);
		textbox.text.starting_format("fnt_pixels_shadow");
		textbox.text.align(fa_center, fa_center);
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.question(text, [select]);
	/// @function question(text, [select]);
	/// @description Adds a question textbox.
	/// @param text
	/// @param [select]
	static question = function(_text, _select)
	{
		var textbox = new _Textbox(textbox_type.question);
		textbox.text = scribble(_text);
		textbox.text.starting_format(box_font);
		textbox.text.wrap(box_width);
		textbox.select = 0;
		if (!is_undefined(_select)) { textbox.select = _select; }
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.menu([select]);
	/// @function menu([select]);
	/// @description Adds a menu (only answers) textbox.
	/// @param [select]
	static menu = function(_select)
	{
		var textbox = new _Textbox(textbox_type.menu);
		textbox.select = 0;
		if (!is_undefined(_select)) { textbox.select = _select; }
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.answer(text, pos, [toggle_check], [toggle_execute]);
	/// @function answer
	/// @description An answer response to a question.
	/// @param text
	/// @param pos
	/// @param [toggle_check]
	/// @param [toggle_execute]
	static answer = function(_text, _pos, _toggle_check = noone, _toggle_execute = noone)
	{
		//If intended speaker exists or is set to noone.
		if (!is_undefined(_speaker) && (_speaker == noone || instance_exists(_speaker)))
		{
			var textbox = new _Textbox(textbox_type.answer);
			textbox.text = scribble(_text);
			textbox.text.starting_format(answer_font);
			textbox.pos = _pos;
			
			textbox.toggle_check = _toggle_check;
			textbox.toggle_execute = _toggle_execute;
			if (_toggle_check != noone) { textbox.toggle = textbox.toggle_check(); }
			else { textbox.toggle = 0; }

			return _textbox_queue(textbox);
		}
		return false;
	}
	#endregion
	#region DialogueQueue.answer_input(text, instance, function, pos, [cancel], [speaker], [condition]);
	/// @function answer_input
	/// @description An answer response to a question. Calls a function when it is selected.
	/// @param text
	/// @param function
	/// @param params
	/// @param pos
	/// @param [cancel]
	/// @param [speaker]
	/// @param [condition]
	static answer_input = function(_text, _func, _params, _pos, _cancel = false, _speaker = noone, _condition = true)
	{
		//If intended speaker exists or is set to noone.
		if (_condition && !is_undefined(_speaker) && (_speaker == noone || instance_exists(_speaker)))
		{
			var textbox = new _Textbox(textbox_type.answer_input);
			textbox.text = scribble(_text);
			textbox.text.starting_format(answer_font);
			textbox.func = _func;
			_params.textbox = textbox;
			textbox.params = _params;
			textbox.pos = _pos;
			textbox.cancel = _cancel;

			return _textbox_queue(textbox);
		}
		return false;
	}
	#endregion
	#region DialogueQueue.start();
	/// @function start();
	/// @description Starts a dialogue sequence after queuing.
	static start = function()
	{
		if (!is_active())
		{
			//Reset inputs (for the DialogueQueue).
			_input_confirm = false;
			_input_up = false;
			_input_down = false;
			_speaker = noone;
			set_active(true);
			next();
		}
	}
	#endregion
	
	//Custom display text.
	#region DialogueQueue.speaker([id]);
	/// @function speaker
	/// @param [id]
	static speaker = function(_id = id)
	{
		con.wait(10);
		var textbox = new _Textbox(textbox_type.speaker);
		if (!instance_exists(_id))
		{
			textbox._id = noone;
			textbox.name = scribble("???");
		}
		else
		{
			textbox._id = _id;
			textbox.name = scribble(_id.name);
		}
		textbox.name.starting_format(name_font);
		return _textbox_queue(textbox);
	}
	#endregion
	
	//Queuing commands.
	#region DialogueQueue._goto_execute(pos);
	/// @function _goto_execute(pos);
	/// @description Moves the DialogueQueue position to a matching here position.
	/// @param pos
	static _goto_execute = function(_position)
	{
		#region Iterate through the queue after current position.
		var length = size();
		for (var i = _pos; i < length; i++)
		{
			var textbox = _textboxes[| i];
			if (textbox.type == textbox_type.here && textbox.pos == _position)
			{
				_pos = i;
				return true;
			}
		}
		#endregion
		#region Iterate through the queue before current position.
		for (var i = 0; i < _pos; i++)
		{
			var textbox = _textboxes[| i];
			if (textbox.type == textbox_type.here && textbox.pos == _position)
			{
				_pos = i;
				return true;
			}
		}
		#endregion
		return false;
	}
	#endregion
	#region DialogueQueue.goto(pos);
	/// @function goto(pos);
	/// @description Jumps the dialogue to a matching here textbox.
	/// @param pos
	static goto = function(_position)
	{
		var textbox = new _Textbox(textbox_type.goto);
		textbox.pos = _position;
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.here(pos);
	/// @function here(pos);
	/// @description Marker for jumping from goto textbox.
	/// @param pos
	static here = function(_position)
	{
		var textbox = new _Textbox(textbox_type.here);
		textbox.pos = _position;
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.wait(frames);
	/// @function wait(frames);
	/// @description Causes the dialogue to ddelay for some number of frames.
	/// @param frames
	static wait = function(_frames)
	{
		var textbox = new _Textbox(textbox_type.wait);
		textbox.frames = _frames;
		return _textbox_queue(textbox);
	}
	#endregion
	
	//Queuing functions.
	//event_execute
	#region DialogueQueue.function_execute(function, [params]);
	/// @function function_execute
	/// @description Runs a provided function.
	/// @param function
	/// @param [params]
	static function_execute = function(_function, _params = noone)
	{
		var textbox = new _Textbox(textbox_type.func_execute);
		textbox.func = _function;
		textbox.params = _params;
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.function_queue(function);
	/// @function function_queue(function);
	/// @description Queues a function that must return true to proceed.
	/// @param function
	static function_queue = function(_function)
	{
		var textbox = new _Textbox(textbox_type.func_queue);
		textbox.func = _function;
		return _textbox_queue(textbox);
	}
	#endregion
	
	//DialogueQueue cleanup.
	#region DialogueQueue.destroy();
	static destroy = function()
	{
		ds_list_destroy(_textboxes);
		ds_list_destroy(_answer_list);
		_function_queue.destroy();
	}
	#endregion
}

//These are from Wastoid Rodney to show the options menus.
//Leaving them here for now for reference.
function queue_options()
{
	#region Choosing Option Menu
	con.here(2);
	con.menu();
	con.answer("Graphics", 20);
	con.answer("Gameplay", 30);
	con.answer("Audio", 40);
	con.answer("Back", "start");
	#endregion
	#region Options Menus
	#region Graphics
	con.here(20);
	con.menu();
	if !(GX) { con.answer("Fullscreen", 0,
	function() { return global.fullscreen; },
	function() {
		global.fullscreen = !global.fullscreen;
		camera.init_screen(256, 320, 180, 192, 4, global.fullscreen);
	}); }
	con.answer("Screenshake", 0,
	function() { return global.screenshake; },
	function() { global.screenshake = !global.screenshake; });
	con.answer("Flashing Effects", 0,
	function() { return global.flashing; },
	function() { global.flashing = !global.flashing; });
	con.answer("Back", 2);
	#endregion
	#region Gameplay
	con.here(30);
	con.menu();
	con.answer("Aim Assist", 0,
	function() { return player.aim_enabled; },
	function() { player.aim_enabled = !player.aim_enabled; });
	con.answer("Smart Camera", 0,
	function() { return global.smart_camera; },
	function() { global.smart_camera = !global.smart_camera; });
	con.answer("Permanent Powerups - Easy Mode", 0,
	function() { return global.endless_upgrades; },
	function() { global.endless_upgrades = !global.endless_upgrades; });
	con.answer("Back", 2);
	#endregion
	#region Audio
	con.here(40);
	con.menu();
	con.answer("Mute Audio", 0,
	function() { return global.mute_sound; },
	function() { global.mute_sound = !global.mute_sound; });
	con.answer("Mute Music", 0,
	function() { return global.mute_music; },
	function () { global.mute_music = !global.mute_music; audio_sound_gain(audio.msc, !global.mute_music / 4, 0); });
	con.answer("Back", 2);
	#endregion
	#endregion
}