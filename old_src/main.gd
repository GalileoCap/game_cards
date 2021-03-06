extends Node

#U: Loads the game and starts waiting for the other player to load in
func load_game():
	$main_menu.hide()
	$game.show()
	$game.load_game()

#U: Goes back to the main menu
func reset():
	get_tree().set_network_peer(null)
	
	$main_menu.show()
	$game.hide()
