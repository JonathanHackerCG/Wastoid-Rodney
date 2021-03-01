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
			obj_control.start_level(rm_levelC);
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
		con.text("Are you [c_orange]ROBO LAZER[]?");
		
		con.nametag("Robo Lazer");
		con.text("How did you know that?!");
		
		con.nametag("Wastoid");
		con.text("It says so on your forehead.");
		
		con.nametag("Robo Lazer");
		con.text("Oh yeah, huh. What do you want?");
		
		con.nametag("Wastoid");
		con.text("I'm putting together the [rainbow]GREATEST PARTY IN THE MULTIVERSE[]! Do you want to come?");

		con.nametag("Robo Lazer");
		con.text("Hell yeah dude! I'm always down to party!");
		
		con.wait(second(1));
		con.function_execute(function(){
			obj_control.start_level(rm_levelC);
		});
		con.start();
	}
}