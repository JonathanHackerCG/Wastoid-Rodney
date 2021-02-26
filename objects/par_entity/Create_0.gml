/// @description Entity variables.
event_inherited();

hp = 0;
hp_max = hp;

function damage(amount)
{
	hp -= amount;
	if (hp <= 0) { event_user(ev_user.kill); }
}