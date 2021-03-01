execute = function()
{
	global.paused = true;
	player.paused = true;
	
	if (!global.story)
	{
		con.wait(second(0.5));
		con.question("Victory!");
		con.answer("Next Level", 1);
		con.answer("Return to Title", 2);
		
		con.here(1);
		con.function_execute(function(){
			obj_control.start_level(rm_levelA);
		});
		con.goto(100);
		
		con.here(2);
		con.function_execute(function() {
			audio_stop_all();
			player.x = -128;
			player.y = -128;
			room_goto(rm_menu);
		});
		con.goto(100);
		
		con.here(100);
		con.start();		
	}
	else
	{
		con.wait(second(0.5));
		con.nametag("Wastoid");
		con.text("Are you the [rainbow]NEON KILLER CRUISER[]?");
	
		con.nametag("Neon Killer Cruiser");
		con.text("Heh, that depends on who's asking.");
	
		con.nametag("Wastoid");
		con.text("I'm putting together a party and heard that you'd be interested?");
	
		con.nametag("Neon Killer Cruiser");
		con.text("A party huh? Is it gonna be good?");
	
		con.nametag("Wastoid");
		con.text("Hell yeah! It's gonna be the [rainbow]PARTY OF ALL SPACE-TIME[]!");
	
		con.nametag("Neon Killer Curiser");
		con.text("Then you can count me in, and I'll bring my friends too!");
		con.text("Where I go, the party follows!");
		con.wait(second(1));
		con.function_execute(function(){
			obj_control.start_level(rm_levelA);
		});
		con.start();
	}
}