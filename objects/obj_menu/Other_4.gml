/// @description Main menu.
event_inherited();

audio.start_music(msc_introduction, 146);

#region Main Options
con.here("start");
con.menu();
con.answer("Story Mode", 1);
con.answer("Level Select", 5);
con.answer("Options", 2);
con.answer("Controls", 3);
if !(GX) { con.answer("Exit Game", 4); }

con.here(1);
con.function_execute(function() {	obj_control.start_level(rm_scene_intro); global.story = true; });
con.goto(100);
#endregion
queue_options();
#region Display Controls
con.here(3);
con.nametag("Keyboard/Mouse");
con.text("Move = WASD\nDash = LShift\nAim = Arrows/Mouse\nShoot = Space\L-Mouse");
con.nametag("Gamepad");
con.text("Move = L-Stick\nDash = L-Shoulder\nAim = R-Stick\nShoot = R-Shoulder");
con.nametag("");
con.goto("start");
#endregion
#region End Game
con.here(4);
con.function_execute(game_end);
#endregion
#region Level Select
con.here(5);
con.menu();
con.answer("Tutorial - Radical Void", 200);
con.answer("Level One - Robot Arcade", 300);
con.answer("Level Two - Radio Raceway", 400);
con.answer("Level Three - Aluminum Fortress", 500);
con.answer("Back", "start");

con.here(200);
con.function_execute(function() { obj_control.start_level(rm_tutorial); global.story = false; });
con.goto(100);
con.here(300);
con.function_execute(function() { obj_control.start_level(rm_levelA); global.story = false; });
con.goto(100);
con.here(400);
con.function_execute(function() { obj_control.start_level(rm_levelB); global.story = false; });
con.goto(100);
con.here(500);
con.function_execute(function() { obj_control.start_level(rm_levelC); global.story = false; });
con.goto(100);
#endregion

con.here(100);
con.start();