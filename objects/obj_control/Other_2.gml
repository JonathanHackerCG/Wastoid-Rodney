/// @description Initialize Game
event_inherited();

#region Graphics Settings
global.fullscreen = false;
camera.init();
camera.init_screen(256, 320, 180, 192, 4, global.fullscreen);
#endregion

room_goto(rm_menu);