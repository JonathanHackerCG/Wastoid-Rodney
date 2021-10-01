/// @description Tutorial start cutscene.
event_inherited();

player.fire_goto = 0;
if (global.killed) { exit; }

if (global.story)
{
	player.paused = true;
	con.wait(second(0.5));
	con.nametag("Wastoid");
	con.text("Woah! That was most radical!");
	con.text("An LCD Panel on the [c_yellow]KEYTAR[] says I need to find the [rainbow]NEON KILLER CRUISER[]. Let's go!");
	con.function_execute(function() { player.paused = false; });
	con.start();
}