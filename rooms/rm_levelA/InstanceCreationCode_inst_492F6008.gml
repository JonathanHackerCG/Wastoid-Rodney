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
			obj_control.start_level(rm_levelB);
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
		con.nametag("Zachary");
		con.text("Hey [c_lime]DUDE[]! Is that the [c_yellow]KEYTAR OF ALL SPACE-TIME[]?");
		
		con.nametag("Wastoid");
		con.text("Why yes it is [c_orange]Mr. Zachary[] sir!");
		
		con.nametag("The Transistor");
		con.text("No way! I've only heard about it in the most legendary of stories!");
		
		con.nametag("Wastoid");
		con.text("Do you guys wanna play at this party I'm putting together?");
		
		con.nametag("Zachary");
		con.text("Anything for the one who wields the [c_yellow]KEYTAR OF ALL SPACE-TIME[]!");
		
		con.wait(second(1));
		con.function_execute(function(){
			obj_control.start_level(rm_levelB);
		});
		con.start();
	}
}