/// @description 
event_inherited();

global.paused = true;
player.paused = true;
	
if (!global.story)
{
	con.wait(second(0.5));
	con.question("Victory! Beat every level in story mode to see the final ending!");
	con.answer("Return to Title", 2);
		
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
	con.function_execute(function(){
		obj_control.start_level(rm_scene_final);
	});
	con.start();
}