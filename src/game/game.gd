extends Node2D

#U: Loads the game for this player
func load_game():
	var children = $own_cards.get_children() + $enemy.get_children() + $field/field_cards.get_children()
	for card in children:
		card.queue_free()
	
	$ui/waiting.show()
	$ui/enemy_left.hide()

#U: Starts the game when another player joins
func player_entered(id):
	$own_cards.shuffle_deck()
	$enemy.shuffle_deck()
	$ui/waiting.hide()
	
	if get_tree().is_network_server():
		var s_id = get_tree().get_network_unique_id()
		$field.Players = [id, s_id]
		$field.Players.shuffle()
		$field.rset_id(id, 'Players', $field.Players)
		#TODO: Announce player order

func _ready():
	var _tmp = get_tree().connect('network_peer_connected', self, 'player_entered')
