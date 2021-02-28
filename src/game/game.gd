extends Node2D

#U: Loads the game for this player
func load_game():
	for card in ($own_cards.get_children() + $enemy.get_children()):
		card.queue_free()
	
	$ui/waiting.show()
	$ui/enemy_left.hide()

#U: Starts the game when another player joins
func player_entered(_id):
	SHARED.shuffle_deck()
	$own_cards.shuffle_deck()
	$enemy.shuffle_deck()
	$ui/waiting.hide()
	#TODO: Throw coin to decide who's first

func _ready():
	var _tmp = get_tree().connect('network_peer_connected', self, 'player_entered')
