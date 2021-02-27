function part_animation(_x1, _y1, _layer, _sprite)
{
	var inst = instance_create_layer(_x1, _y1, _layer, obj_part);
	inst.sprite_index = _sprite;
	inst.end_animation = 1;
	
	return inst;
}

function part_fade(_x1, _y1, _layer, _sprite, _length, _fade)
{
	var inst = instance_create_layer(_x1, _y1, _layer, obj_part);
	inst.sprite_index = _sprite;
	inst.timer_length = _length;
	inst.timer_length_max = _length;
	inst.timer_fade = _fade;
	inst.timer_fade_max = _fade;
	
	return inst;
}