/// @description Tutorial start cutscene.
event_inherited();

player.fire_goto = 90;
if (global.killed) { exit; }

if (global.story)
{
	player.paused = true;
	
	con.wait(second(0.5));
	con.nametag("Wastoid");
	con.text("Now I must find [c_orange]ROBO LAZER[].");
	
	con.function_execute(function() { player.paused = false; });
	con.start();
}