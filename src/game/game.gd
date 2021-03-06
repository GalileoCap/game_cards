extends Node2D

func reset_board():
	var children = $own_cards.get_children() + $enemy.get_children() + $field/field_cards.get_children()
	for card in children:
		card.queue_free()

#U: Loads the game for this player
func load_game():
	reset_board()
	
	$ui/waiting.show()
	$ui/enemy_left.hide()

func start_game():
	reset_board()

	$own_cards.shuffle_deck()
	$enemy.shuffle_deck()
	$ui/waiting.hide()
	
	var id = get_tree().get_network_connected_peers()[0]
	$field.first_turn_order(id)
	
#U: Starts the game when another player joins
func player_entered(_id):
	start_game()

func _ready():
	var _tmp = get_tree().connect('network_peer_connected', self, 'player_entered')
