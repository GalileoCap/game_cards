#INFO: Both players have to have this script in the same state at all times
extends Node

#U: Info of each player based on their id
var Players = {}

remotesync func set_player(info):
	var id = get_tree().get_rpc_sender_id()
	Players[id] = info

func get_player(id):
	return Players[id]

#U: Standard 40 deck for Truco 'C' = Clubs, 'S' = Spades, 'H' = Hearts, 'D' = Diamonds
puppet var Deck = ['AC', '2C', '3C', '4C', '5C', '6C', '7C', '10C', 'KC', 'JC', 'QC', 'AS', '2S', '3S', '4S', '5S', '6S', '7S', '10S', 'KS', 'JS', 'QS', 'AD', '2D', '3D', '4D', '5D', '6D', '7D', '10D', 'KD', 'JD', 'QD', 'AH', '2H', '3H', '4H', '5H', '6H', '7H', '10H', 'KH', 'JH', 'QH']

func shuffle_deck():
	if get_tree().is_network_server():
		Deck.shuffle()
		rset('Deck', Deck)

func get_deck():
	return Deck
