/// @description Define the DialogueQueue.
global.conversation = new DialogueQueue();
#macro con global.conversation

con.set_name_buffer(3, 0, 4, 4);
con.set_name_display(spr_dialogue_name, 12, 160, "fnt_smallfont");
con.set_box_buffer(4, 4, 5, 4);
con.set_box_display(spr_dialogue_box, 54, 160, "fnt_pixelfont", 2);
con.set_answer_buffer(3, 4, 4, 4, 4);
con.set_answer_display(spr_dialogue_answer, spr_dialogue_answer_select, 12, 160, "fnt_smallfont");

con.set_position(80, 116);