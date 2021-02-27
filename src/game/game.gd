extends Node2D

#U: Loads the game for this player
func load_game():
	$own_cards.shuffle_deck()
	#TODO: Start waiting for player

#U: Resets the game board
func reset():
	pass #TODO

#U: Starts the game when another player joins
func player_entered(id):
	print(id)
	#TODO: Stop waiting for enemy
	#TODO: Load their card backs
	#TODO: Throw coin to decide who's first

func _ready():
	var _tmp = get_tree().connect('network_peer_connected', self, 'player_entered')
