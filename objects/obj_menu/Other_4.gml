/// @description Main menu.
event_inherited();

#region Main Options
con.here("start");
con.menu();
con.answer("Story Mode", 1);
con.answer("Level Select", 5);
con.answer("Options", 2);
con.answer("Controls", 3);
con.answer("Exit Game", 4);

con.here(1);
con.function_execute(function() {	obj_control.start_level(rm_levelA); global.story = true; });
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
con.answer("Tutorial - Pale Facility", 200);
con.answer("Level One - Robot Arcade", 300);
con.answer("Back", "start");

con.here(200);
con.function_execute(function() { obj_control.start_level(); global.story = false; });
con.here(300);
con.function_execute(function() { obj_control.start_level(rm_levelA); global.story = false;});
#endregion

con.here(100);
con.start();