/// @description 
event_inherited();

var_damage = 1;
if (player.explosiveshot)
{
	sprite_index = spr_bullet_player_explode;
	var_damage ++;
}