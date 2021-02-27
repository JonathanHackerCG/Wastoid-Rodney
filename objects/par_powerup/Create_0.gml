/// @description Creating powerup base.
event_inherited();

_depth = -bbox_bottom;
base = instance_place(x, y, obj_powerup_base);
if (!instance_exists(base))
{
	base = instance_create_layer(x, y, layer, obj_powerup_base);
	base.powerup = object_index;
	base.has_powerup = true;
}