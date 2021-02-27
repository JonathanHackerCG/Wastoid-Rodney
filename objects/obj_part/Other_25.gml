/// @description Draw Particle
event_inherited();

if (sprite_index != noone)
{
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, alpha);
}

if (number != undefined)
{
	draw_set_alpha(alpha);
	draw_text(x, y, string(number));
	draw_set_alpha(1.0);
}