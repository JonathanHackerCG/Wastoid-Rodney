/// @description Take damage from enemy bullets.
event_inherited();

if (iframes > 0) { exit; }
iframes = second(1);

camera.screenshake += 12;
if (barrier) { barrier = false; }
else { damage(other.var_damage); }
instance_destroy(other);

event_user(0);