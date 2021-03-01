/// @description Tutorial start cutscene.
event_inherited();

global.paused = true;
player.paused = true;
obj_audio.start_music(msc_introduction, 0);
player.x = -128;
player.y = -128;
	
con.wait(second(0.5));
con.nametag("Scarlett George");
con.text("[c_lime]WASTOID! You did it!");
con.text("You defeated the vice-sheriff of the multiverse police department!");
con.text("Now we can throw [rainbow]THE GREATEST PARTY OF ALL OF SPACE AND TIME[]!");

con.nametag("Wastoid");
con.text("Most excellent!");
con.nametag("");

con.menu();
con.answer("Return to menu.", 1);
con.here(1);
con.function_execute(function() {
	audio_stop_all();
	player.x = -128;
	player.y = -128;
	room_goto(rm_menu);
});
con.start();