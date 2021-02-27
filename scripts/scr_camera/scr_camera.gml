function is_on_screen(buffer)
{
	return point_in_rectangle(x, y,
	camera.xpos - buffer,
	camera.ypos - buffer,
	camera.xpos + camera.width + buffer,
	camera.ypos + camera.height + buffer);
}