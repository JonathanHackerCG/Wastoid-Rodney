/// @description 
event_inherited();

wastoidA.sprite_index = spr_ralph_nokeytar;
wastoid_dadA.sprite_index = noone;
scarlettA.sprite_index = noone;

con.nametag("???");
con.text("Ralph ... Ralph! ... RALPH!!!");
con.wait(second(0.5));
con.function_execute(function() { wastoid_dadA.sprite_index = spr_sgt_rodney; });

con.nametag("Sgt. Rodney");
con.text("Ralph! You may not start [c_red][shake]MILITARY SCHOOL[] until tomorrow, but I won't let you slack off!");

con.nametag("Wastoid");
con.text("Ugh, you're the worst, dad! And how many times do I have to tell you: my name is [c_lime]WASTOID![]");

con.nametag("Sgt. Rodney");
con.text("I named you Ralph and that is what your name will always be, you slacker!");

con.nametag("Wastoid");
con.text("Eat. My. Shorts.");

con.nametag("Sgt. Rodney");
con.text("Get out of bed, you burn out. I can't wait to get rid of you.");
con.function_execute(function() { wastoid_dadA.sprite_index = noone; });
con.wait(second(0.5));

con.nametag("Wastoid");
con.text("God, only one more day until I go to [c_red][shake]MILITARY SCHOOL[]. This is most not excellent!");

con.wait(second(0.5));
con.nametag("???");
con.text("[c_lime]WASTOID...[]");

con.nametag("Wastoid");
con.text("Huh?");

con.nametag("???");
con.text("[c_lime]WASTOID...[]");
con.function_execute(function() { scarlettA.sprite_index = spr_scarlett; });

con.nametag("Wastoid");
con.text("Woah, who are you?");

con.nametag("Scarlett George");
con.text("My name is [c_red]SCARLETT GEORGE[], I come from a place outside of space and time. I'm here to bestow your [wobble]destiny[] upon you.");
con.text("It is your destiny, [c_lime]WASTOID[], to throw [rainbow]THE GREATEST PARTY IN THE MULTIVERSE![]");

con.nametag("Wastoid");
con.text("Woah, that is a most excellent [wobble]destiny[] my friend, but how do I do it?");

con.function_execute(function() { wastoidA.sprite_index = spr_player; });
con.nametag("Scarlett George");
con.text("Take this, it's the [c_yellow]KEYTAR OF ALL SPACE-TIME[].");
con.text("All you must do is play it, and it will take you to the [rainbow]MOST RADICAL[] partiers in the entire multiverse.");
con.text("Convince them to party with you!");

con.nametag("Wastoid");
con.text("I WILL throw the best party of all time!");

con.nametag("Scarlett George");
con.text("But be warned, there will be buzzkills who try to stop you. Use the [c_yellow]KEYTAR[] to protect yourself!");
con.function_execute(function() {	obj_control.start_level(rm_tutorial); global.story = true; });
con.start();