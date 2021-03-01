/// @description Tutorial start cutscene.
event_inherited();

player.fire_goto = 90;

if (global.story)
{
	global.paused = true;
	player.paused = true;
	
	con.wait(second(0.5));
	con.nametag("Wastoid");
	con.text("The [c_yellow]KEYTAR[] says that I'm ready to party! One final bash before [shake][c_red]MILITARY SCHOOL[].");
	
	con.wait(second(0.5));
	con.function_execute(function() { instance_create_layer(536, 304, layer, obj_sonny); });
	con.nametag("W.B. Sonny");
	con.text("NO! I WON'T ALLOW IT!");
	
	con.nametag("Wastoid");
	con.text("What do you have against partying anyway dude?");
	
	con.nametag("W.B. Sonny");
	con.text("Do you know how many noise complaints I've had to take care of?");
	con.text("The party of the multiverse would just end in the noise complaint of the multiverse!");
	
	con.nametag("Wastoid");
	con.text("That is most heinous dude!");
	
	con.nametag("W.B. Sonny");
	con.text("I won't let this party go on!");
	con.text("Nothing can stop you from being sent to [shake][c_red]MILITARY SCHOOL[]!");
	
	con.function_execute(function() { player.paused = false; global.paused = false; });
	con.start();
}
else
{
	instance_create_layer(536, 304, layer, obj_sonny);
}