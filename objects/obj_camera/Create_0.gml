/// @description Camera initialization and methods.

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

	view_camera[0] = cam_id;
	view_visible[0] = true;
	view_enabled[0] = true;
	
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
function init_screen(width_min, width_max, height_min, height_max, scale_base, fullscreen)
{
	#region Updating parameter values.
	width_min		*= scale_base;
	width_max		*= scale_base;
	height_min	*= scale_base;
	height_max	*= scale_base;

	//Getting/calculating other display variables
	var screen_w = display_get_width();
	var screen_h = display_get_height();
	#endregion

	#region Calculating target width and height.
	var width = clamp(width_max, width_min, screen_w);
	var height = clamp(height_max, height_min, screen_h);
	var scale_real = 1;
	#endregion
	#region Determining fullscreen scale factor.
	if (fullscreen)
	{
		var area_max = 0;
		var area;
	
		//Choosing viable scale factors from the base scale value
		var scale_list = ds_list_create();
		ds_list_add(scale_list, 2, 3, 4);
		if (scale_base == 2)
		{
			ds_list_add(scale_list, 0.5);
		}
		else if (scale_base == 4)
		{
			ds_list_add(scale_list, 1.25, 1.5, 1.75);
		}
	
		//Iterate for every combination of allowed sizes and scale factors
		for (var w = width_min; w < width_max; w += 16) {
		for (var h = height_min; h < height_max; h += 16) {
		for (var i = 0; i < ds_list_size(scale_list); i++)
		{
			//Determine largest possible screen size and select width/height based on that.
			var s = scale_list[| i];
			if (w * s <= screen_w && h * s <= screen_h)
			{
				area = (w * s) * (h * s)
				if (area > area_max)
				{
					width = w;
					height = h;
				
					area_max = area;
					scale_real = s;
				}
			}
		} } }
	
		ds_list_destroy(scale_list); //Delete the scale factor list
	}
	global.screen_scale = scale_real;
	#endregion
	#region Fullscreen scaling.
	if (!fullscreen)
	{
		//Resize and position window in the center of the display
		var offset_x = (screen_w / 2) - (width / 2);
		var offset_y = (screen_h / 2) - (height / 2);
		window_set_size(width, height);
		window_set_position(offset_x, offset_y);
		window_set_fullscreen(false);
	}
	else
	{
		window_set_fullscreen(true);
	}
	surface_resize(application_surface, width, height);
	#endregion
	
	#region Resize the camera.
	camera.width = width / scale_base;
	camera.height = height / scale_base;
	camera.wcenter = camera.width / 2;
	camera.hcenter = camera.height / 2;
	camera_set_view_size(camera.cam_id, camera.width, camera.height);
	#endregion
	#region Resize the GUI.
	scale_base = 1;
	display_set_gui_size(width / scale_base, height / scale_base);
	display_set_gui_maximize(scale_real * scale_base, scale_real * scale_base, 0, 0);

	camera.gui_width = width / scale_base;
	camera.gui_height = height / scale_base;
	#endregion
	#region Set camera view values.
	view_camera[0] = camera.cam_id;
	view_visible[0] = true;
	view_enabled[0] = true;
	#endregion
	update();
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