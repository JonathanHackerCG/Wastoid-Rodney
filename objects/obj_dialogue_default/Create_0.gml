/// @description Define the DialogueQueue.
con = new DialogueQueue();

con.here(4);
con.nametag("Cloaked Games");
con.question("Welcome to CG_Dialogue module.");
con.question("Would you like a tutorial for how to use it?");
con.answer("Yes please.", 1);
con.answer("No, go away!", 2);

con.here(2);
con.text("Thank goodness. I'd rather not write one anyways.");
con.goto("exit");

con.here(1);
con.text("Okay. Well, there are a few things you can do.");
con.text("You have already seen a question with multiple answers.");
con.text("You can also delay the text like so--");
con.wait(120);
con.text("That was a two second delay. You can also directly execute functions.");
con.function_execute(function() {
	show_debug_message("Hello World!");
});
con.text("You can also queue functions which will only progress the dialogue once they return true.");
con.function_queue(function() {
	static timer = 60;
	timer --;
	if (timer <= 0) {
		timer = 60;
		return true;
	}
	return false;
});
con.text("That was a one second delay due to a queued function.");
con.text("You can insert new messages at runtime.");
con.here(3);
con.function_execute(function() {
	static count = 0;
	count ++;
	con.text("This message was inserted! Count: " + string(count));
});
con.question("See that again?");
con.answer("No.", 1);
con.answer("Sure.", 3);

con.here(1);
con.nametag("Not Cloaked Games?");
con.text("And change the nametag whenever.");
con.text("More stuff too but I'm too lazy to explain. Good luck!");

con.here("exit");
con.start();