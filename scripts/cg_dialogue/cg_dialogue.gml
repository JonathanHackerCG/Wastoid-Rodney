//DialogueQueue textbox type ID.
enum textbox_type
{
	//Text display types.
	name,
	text,
	question,
	answer,
	menu,
	
	//Commands.
	goto,
	here,
	wait,
	
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
	#region Display properties defaults.
	_pos = -1;
	_active = false;
	_timer = -1;
	_nametag = "";
	_message = "";
	_answer_num = 0;
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
	name_font = fnt_cg_dialogue;
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
	box_font = fnt_cg_dialogue;
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
		
		scribble_set_box_align(fa_left, fa_top);
		scribble_set_wrap(box_width - box_bufferR - box_bufferL, box_height);
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

		scribble_set_box_align(fa_left, fa_top);
		scribble_set_wrap(box_width - box_bufferR - box_bufferL, box_height);
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
	answer_font = fnt_cg_dialogue;
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
		if (!active() || empty() || _pos < 0) { exit; }
		
		var textbox = _textboxes[| _pos];
		var type = textbox.type;
		if (type == textbox_type.text || type == textbox_type.question || type == textbox_type.menu)
		{
			#region Initialize default display variables.
			var name = _nametag;
			var text = _message;
			var yoff = draw_y;
			var xoff = draw_x;
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
					var aid = 0;
					if (ans.toggle != noone)
					{
						aid = 1 + ans.toggle_check();
					}
					
					draw_sprite(answer_sprite, aid, ansx1 - answer_bufferL, ansy1 - answer_bufferT + off);
					if (_answer_select == i) { draw_sprite(answer_sprite_select, aid, ansx1 - answer_bufferL, ansy1 - answer_bufferT + off); }
					if (show_bounds) { draw_rectangle(ansx1, ansy1 + off, ansx2, ansy2 + off, true); }
					scribble_draw(ansx1, ansy1 + off, ans.text);
				}
				#endregion
			}
				
			#region Drawing nametag.
			if (name != "")
			{
				draw_sprite(name_sprite, 0, xoff, yoff);
				
				var namex1 = xoff + name_bufferL;
				var namey1 = yoff + name_bufferT - name_height;
				var namex2 = xoff + name_width - name_bufferB;
				var namey2 = yoff - name_bufferR;
			
				if (show_bounds) { draw_rectangle(namex1, namey1, namex2, namey2, true); }
				scribble_draw(namex1, namey1, name);
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
				scribble_draw(boxx1, boxy1, text);
			}
			#endregion
		}
	}
	#endregion
	#region DialogueQueue.update();
	/// @function update();
	/// @description Update performed every step. Check for inputs and process commands.
	static update = function()
	{
		//Exit if not currently updating.
		if (!active() || empty() || _pos < 0) { exit; }
		
		//Checking for user inputs.
		#region Getting textbox properties.
		var textbox = _textboxes[| _pos];
		var type = textbox.type;
		#endregion
		#region Performing updates based on input.
		switch (type)
		{
			#region Text
			case textbox_type.text:
			{
				//Confirming text.
				if (_input_confirm) { next(); audio.play_sound(snd_confirm, !global.mute_sound / 2); }
			} break;
			#endregion
			#region Question/Answer text.
			case textbox_type.question:
			case textbox_type.menu:
			{
				//Confirming answer to question.
				if (_answer_num > 0)
				{
					if (_input_up && _answer_select > 0) { _answer_select --; audio.play_sound(snd_select, !global.mute_sound / 2); }
					if (_input_down && _answer_select < _answer_num - 1) { _answer_select ++; audio.play_sound(snd_select, !global.mute_sound / 2); }
				}
				if (_input_confirm)
				{
					audio.play_sound(snd_confirm, !global.mute_sound / 2);
					if (_answer_num > 0)
					{
						var ans = _answer_list[| _answer_select];
						if (ans.toggle == noone)
						{
							_goto_execute(ans.pos);
							next();
						}
						else
						{
							ans.toggle_execute();
							ans.toggle = ans.toggle_check();
						}
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
			#region Nametag
			case textbox_type.name:
			{
				if (textbox.name != "")
				{
					_nametag = scribble_draw(0, 0, "[" + name_font + "]" + textbox.name);
				} else { _nametag = ""; }
				next();
			} break;
			#endregion
			#region Text
			case textbox_type.text:
			{
				_message = scribble_draw(0, 0, "[" + box_font + "]" + textbox.text);
			} break;
			#endregion
			#region Question
			case textbox_type.question:
			case textbox_type.menu:
			{
				if (type == textbox_type.question) { _message = scribble_draw(0, 0, "[" + box_font + "]" + textbox.text); }
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
					if (textbox.type == textbox_type.answer)
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
				textbox.func();
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
	#region DialogueQueue.active();
	/// @function active();
	/// @description Returns the active state of the DialogueQueue.
	static active = function()
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
	}
	#endregion
	#region DialogueQueue._textbox_queue(textbox);
	/// @function _textbox_queue(textbox);
	/// @description Adds a newly created textbox to the _textboxes list.
	/// @param textbox
	static _textbox_queue = function(_textbox)
	{
		if (active()) { ds_list_insert(_textboxes, _pos + 1, _textbox); }
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
		con.wait(10);
		var textbox = new _Textbox(textbox_type.name);
		textbox.name = _name;
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
		textbox.text = _text;
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
		textbox.text = _text;
		textbox.select = 0;
		if (!is_undefined(_select)) { textbox.select = _select; }
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.menu([select]);
	/// @function menu([select]);
	/// @description Adds a menu (only answers) textbox.
	/// @param [select]
	static menu = function(_text, _select)
	{
		var textbox = new _Textbox(textbox_type.menu);
		textbox.select = 0;
		if (!is_undefined(_select)) { textbox.select = _select; }
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.answer(text, pos);
	/// @function answer(text, pos);
	/// @description An answer response to a question.
	/// @param text
	/// @param pos
	/// @param [toggle_check]
	/// @param [toggle_execute]
	static answer = function(_text, _pos, _toggle_check, _toggle_execute)
	{
		var textbox = new _Textbox(textbox_type.answer);
		textbox.text = scribble_draw(0, 0, "[" + answer_font + "]" + _text);
		textbox.pos = _pos;
		
		if (is_undefined(_toggle_check))
		{
			textbox.toggle = noone;
			textbox.toggle_check = noone;
			textbox.toggle_execute = noone;
		}
		else
		{
			textbox.toggle_check = _toggle_check;
			textbox.toggle_execute = _toggle_execute;
			textbox.toggle = _toggle_check();
		}
		
		return _textbox_queue(textbox);
	}
	#endregion
	#region DialogueQueue.start();
	/// @function start();
	/// @description Starts a dialogue sequence after queuing.
	static start = function()
	{
		set_active(true);
		next();
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
	#region DialogueQueue.function_execute(function);
	/// @function function_execute(function);
	/// @description Runs a provided function.
	/// @param function
	static function_execute = function(_function)
	{
		var textbox = new _Textbox(textbox_type.func_execute);
		textbox.func = _function;
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
	if (!GX) { con.answer("Fullscreen", 0,
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