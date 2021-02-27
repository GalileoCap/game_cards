extends Node

#U: Loads the game and starts waiting for the other player to load in
func load_game():
	$main_menu.hide()
	$game.show()
	$game.load_game()
	$leave.show() #TODO: Actual prompt in waiting screen

#U: Goes back to the main menu
func reset():
	get_tree().set_network_peer(null)
	
	$main_menu.show()
	$game.hide()
	$game.reset()
	$leave.hide()

#U: Prompts you to leave when the enemy disconnects
func enemy_left(_id = null):
	$leave.show()
	#TODO: Actual prompt

func _ready():
	var _tmp = get_tree().connect('connected_to_server', self, 'load_game')
	_tmp = get_tree().connect('network_peer_disconnected', self, 'enemy_left')
	_tmp = get_tree().connect('server_disconnected', self, 'enemy_left')
