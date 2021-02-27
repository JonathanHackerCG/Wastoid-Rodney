/// @description Updating graphics.
event_inherited();

if (has_powerup) { sprite_index = spr_powerup_base; }
else { sprite_index = spr_powerup_base_disabled; }