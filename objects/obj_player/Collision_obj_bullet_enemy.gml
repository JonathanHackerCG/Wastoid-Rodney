/// @description Take damage from enemy bullets.
event_inherited();

hp -= other.var_damage;
instance_destroy(other);