/// @description Follow the player.
event_inherited();

var dis = 48;
var xx = lengthdir_x(dis, player.var_direction);
var yy = lengthdir_y(dis, player.var_direction);
follow(player, 32, xx, yy);