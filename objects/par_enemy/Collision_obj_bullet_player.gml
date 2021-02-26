/// @description Take damage from enemy bullets.
event_inherited();

damage(other.var_damage);
instance_destroy(other);