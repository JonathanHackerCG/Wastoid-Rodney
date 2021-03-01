/// @description Take damage from enemy bullets.
event_inherited();

damage(other.var_damage);
var part = part_fade(x, y, layer, spr_enemy_particle, 3, 3);
part._depth = -room_height;
part.image_angle = irandom(360);
instance_destroy(other);