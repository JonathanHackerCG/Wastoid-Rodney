/// @description Camera initialization and methods.

global.smart_camera = true;

#region Scribble and font initialization.
scribble_init("", "fnt_pixelfont", false);
global.fnt_pixelfont = font_add_sprite_ext(fnt_pixelfont, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'()<>^*+=-/%:;_$", 1, 4);
global.fnt_smallfont = font_add_sprite_ext(fnt_smallfont, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,()'?!-/$", 1, 3);
scribble_add_spritefont("fnt_pixelfont", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'()<>^*+=-/%:;_$", 1, 4);
scribble_add_spritefont("fnt_smallfont", "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,()'?!-/$", 1, 3);
#endregion

#region init();
/// @description Create the camera data and initialize.
/// @function init_camera();
function init()
{
	//Width variables
	width = 1;
	height = 1;
	wcenter = width / 2;
	hcenter = height / 2;
	
	//GUI variables
	gui_width = 1;
	gui_height = 1;
	
	//Coordinate variables
	xpos = 0;
	ypos = 0;
	xcenter = xpos + wcenter;
	ycenter = ypos + hcenter;
	
	cam_id = camera_create_view(0, 0, 0, 0, 0, -1, -1, -1, -1, -1);
	camera_set_view_pos(cam_id, xpos, ypos);
	camera_set_view_size(cam_id, width, height);
	application_surface_draw_enable(false);
}
#endregion
#region update();
/// @description Updates camera variables.
function update()
{
	//Clamp the camera to within the room boundary
	xpos = clamp(xpos, 0, room_width - width);
	ypos = clamp(ypos, 0, room_height - height);
	
	camera_set_view_pos(cam_id, xpos + irandom_off(screenshake), ypos + irandom_off(screenshake));
	xcenter = xpos + wcenter;
	ycenter = ypos + hcenter;
}
#endregion
#region follow(inst, factor, [xoffset], [yoffset]);
/// @description The camemra follows an instance
/// @function follow(instance, factor, [xoffset], [yoffset]);
/// @param instance
/// @param factor
/// @param [xoffset]
/// @param [yoffset]
function follow(_inst, _factor, _xoff, _yoff)
{
	if (is_undefined(_xoff)) { _xoff = 0; }
	if (is_undefined(_yoff)) { _yoff = 0; }
	if (!instance_exists(_inst)) { return false; }

	//Find target locations.
	var targetx = rdec(_inst.x - wcenter) + _xoff;
	targetx = clamp(targetx, 0, room_width - width);	
	var targety = rdec(_inst.y - hcenter) + _yoff;
	targety = clamp(targety, 0, room_height - height);
	
	if (xpos == targetx && ypos == targety) {	return false;	}
	var minimum = 0.25;
	
	#region X-Movement
	var xdis = targetx - xpos;
	if (xdis > minimum) {	xpos += ceil_divd(xdis / _factor, 4); }
	else if (xdis < -minimum)	{ xpos += floor_divd(xdis / _factor, 4);	}
	else { xpos = targetx; }
	#endregion
	#region Y-Movement
	var ydis = targety - ypos;
	if (ydis > minimum)	{	ypos += ceil_divd(ydis / _factor, 4); }
	else if (ydis < -minimum)	{	ypos += floor_divd(ydis / _factor, 4);	}
	else { ypos = targety; }
	#endregion
	
	update();
	return true;
}
#endregion
#region init_screen(width_min, width_max, height_min, height_max, scale_base, fullscreen);
/// @description Initializes the screen display / scaling.
/// @param width_min
/// @param width_max
/// @param height_min
/// @param height_max
/// @param scale_base
/// @param fullscreen
/// @param [original]
function init_screen(w_min, w_max, h_min, h_max, scale_base, fullscreen, original)
{
	if (GX)
	{
		init_screen_simple(320, 192, 1280, 768);
		exit;
	}
	
	if (is_undefined(original)) { original = false; }
	#region Updating parameter values.
	w_min	*= scale_base;
	h_min	*= scale_base;
	w_max	*= scale_base;
	h_max	*= scale_base;
	var buffer_w = 64;
	var buffer_h = 128;
	#endregion
	#region Calculating target width and height.
	var screen_w = display_get_width();	 //Screen width  (real).
	var screen_h = display_get_height(); //Screen height (real).
	if (fullscreen)
	{
		var target_w = screen_w; //Target final width.
		var target_h = screen_h; //Target final height.
	}
	else
	{
		target_w = screen_w - buffer_w; //Target final width.
		target_h = screen_h - buffer_h; //Target final height.
	}
	#endregion
	#region Determining the scale factor.
	var a, a_max = 0;
	var scale_w = clamp(w_max, w_min, target_w);
	var scale_h = clamp(h_max, h_min, target_h);
	var scale_real = 1;
	
	#region Choosing viable scale factors from the base scale value
	var scale_list = ds_list_create();
	if (original) { ds_list_add(scale_list, 1); }
	else
	{
		ds_list_add(scale_list, 1, 2, 3, 4);
		if (scale_base == 2) { ds_list_add(scale_list, 0.5); }
		else if (scale_base == 4)	{ ds_list_add(scale_list, 1.25, 1.5, 1.75);	}
	}
	#endregion
	#region Calculate the largest possible scale factor based on target size.
	var _size = ds_list_size(scale_list);
	var s, w_min_scaled, w_max_scaled, h_min_scaled, h_max_scaled;
	for (var i = 0; i < _size; i++)
	{
		s = scale_list[| i];
		w_min_scaled = w_min * s;
		h_min_scaled = h_min * s;
		w_max_scaled = min(w_max * s, target_w);
		h_max_scaled = min(h_max * s, target_h);
		if (w_max_scaled < w_min_scaled || h_max_scaled < h_min_scaled) { continue; }
		
		a = w_max_scaled * h_max_scaled;
		if (a > a_max)
		{
			a_max = a;
			scale_real = s;
			scale_w = floor(w_max_scaled / s);
			scale_h = floor(h_max_scaled / s);
		}
	}
	#endregion
	ds_list_destroy(scale_list); //Delete the scale factor list
	#endregion
	#region Set window size/fullscreen enabled.
	if (!fullscreen)
	{
		window_set_fullscreen(false);
		window_set_size(scale_w * scale_real, scale_h * scale_real);
		var offset_x = (screen_w - (scale_w * scale_real)) / 2;
		var offset_y = (screen_h - (scale_h * scale_real)) / 2;
		offx = 0;
		offy = 0;
		window_set_position(offset_x, offset_y);
	}
	else
	{
		window_set_fullscreen(true);
		offx = (screen_w - (scale_w * scale_real)) / 2;
		offy = (screen_h - (scale_h * scale_real)) / 2;
	}
	surface_resize(application_surface, scale_w * scale_real,  scale_h * scale_real);
	#endregion
	#region Resize the camera.
	width  = scale_w / scale_base;
	height = scale_h / scale_base;
	wcenter = width  / 2;
	hcenter = height / 2;
	camera_set_view_size(cam_id, width, height);
	#endregion
	#region Resize the GUI.
	display_set_gui_maximize(1, 1, 0, 0);
	gui_width  = display_get_gui_width();
	gui_height = display_get_gui_height();
	
	con.set_position((width / 2) - 80, height - 54 - 4);
	#endregion
	#region Set camera view values.
	view_camera[0] = cam_id;
	view_visible[0] = true;
	view_enabled[0] = true;
	#endregion
	update();
}
#endregion
#region init_screen_simple();
/// @function init_screen_simple();
/// @param wcam
/// @param hcam
/// @param wport
/// @param hport
function init_screen_simple(_wcam, _hcam, _wport, _hport)
{
	width  = _wcam;
	height = _hcam;
	wcenter = _wcam / 2;
	hcenter = _hcam / 2;
	camera.cam_id = camera_create_view(0, 0, _wcam, _hcam);
	view_enabled = true;
	view_visible[0] = true;
	view_camera[0] = camera.cam_id;
	view_set_wport(0, _wport);
	view_set_hport(0, _hport);
}
#endregion

screenshake = 0;
screenshake_max = 16;
flash_alpha = 0.00;
global.screenshake = true;
global.flashing = true;

#region Main draw variable initialization.
depthgrid = ds_grid_create(2, 1);
#endregion