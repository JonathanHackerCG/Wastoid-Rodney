/// @description Main menu.
event_inherited();

con.here("start");
con.menu();
con.answer("Start Game", 1);
con.answer("Options", 2);
con.answer("Controls", 3);
con.answer("Exit Game", 4);

con.here(1);
con.function_execute(function() {
	obj_control.start_level(rm_levelA);
});
con.goto(100);

con.here(2);
#region Choosing Option Menu
con.menu();
con.answer("Graphics", 20);
con.answer("Gameplay", 30);
con.answer("Audio", 40);
con.answer("Back", "start");
#endregion
#region Options Menus
#region Graphics
con.here(20);
con.menu();
con.answer("Fullscreen", 0,
function() { return global.fullscreen; },
function() {
	global.fullscreen = !global.fullscreen;
	camera.init_screen(256, 320, 180, 192, 4, global.fullscreen);
});
con.answer("Screenshake", 0,
function() { return global.screenshake; },
function() { global.screenshake = !global.screenshake; });
con.answer("Flashing Effects", 0,
function() { return global.flashing; },
function() { global.flashing = !global.flashing; });
con.answer("Back", 2);
#endregion
#region Gameplay
con.here(30);
con.menu();
con.answer("Aim Assist", 0,
function() { return player.aim_enabled; },
function() {	player.aim_enabled = !player.aim_enabled; });
con.answer("Back", 2);
#endregion
#region Audio
con.here(40);
con.menu();
con.answer("Mute Audio", 0,
function() { return global.mute_sound; },
function() { global.mute_sound = !global.mute_sound; });
con.answer("Mute Music", 0,
function() { return global.mute_music; },
function () { global.mute_music = !global.mute_music; });
con.answer("Back", 2);
#endregion
#endregion
con.goto("start");

con.here(3);
con.nametag("Keyboard/Mouse");
con.text("Move = WASD\nDash = LShift\nAim = Arrows/Mouse\nShoot = Space\L-Mouse");
con.nametag("Gamepad");
con.text("Move = L-Stick\nDash = L-Shoulder\nAim = R-Stick\nShoot = R-Shoulder");
con.nametag("");
con.goto("start");

con.here(4);
con.function_execute(game_end);

con.here(100);
con.start();