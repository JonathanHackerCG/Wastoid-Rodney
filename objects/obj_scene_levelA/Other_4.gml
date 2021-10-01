/// @description Tutorial start cutscene.
event_inherited();

player.fire_goto = 0;
wb_sonnyA.sprite_index = noone;
if (global.killed) { exit; }

if (global.story)
{
	player.paused = true;
	
	con.wait(second(0.5));
	con.nametag("Wastoid");
	con.text("Now the [c_yellow]KEYTAR[] is saying I need to find [c_orange]ZACHARY[] and [c_teal]THE TRANSISTOR[].");
	
	con.wait(second(0.5));
	con.function_execute(function() { wb_sonnyA.sprite_index = spr_wb_sonny; });
	con.nametag("W.B. Sonny");
	con.text("Stop right there!");
	
	con.nametag("Wastoid");
	con.text("Who are you?!");
	
	con.nametag("W.B. Sonny");
	con.text("My name is [c_gray]W.B. SONNY[], vice cop of the Multiverse Police Department (MPD).");
	
	con.nametag("Wastoid");
	con.text("Woah dude! You like my dad, but like, metal...");
	
	con.nametag("W.B. Sonny");
	con.text("If you try to throw this party, I'm going to have to use force!");
	
	con.nametag("Wastoid");
	con.text("What?! Just try to stop me!");
	
	con.nametag("W.B. Sonny");
	con.text("ROBOTS! [shake]GET HIM![]");
	
	con.function_execute(function() { instance_destroy(wb_sonnyA); });
	con.function_execute(function() { player.paused = false; });
	con.start();
}