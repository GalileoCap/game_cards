#INFO: Both players have to have this script in the same state at all times
extends Node

#U: Info of each player based on their id
var Players = {}

remotesync func set_player(info):
	var id = get_tree().get_rpc_sender_id()
	Players[id] = info

func get_player(id):
	return Players[id]

#U: Standard 40 card deck for Truco
var Deck = [1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12]

func shuffle_deck():
	Deck.shuffle()

func get_deck():
	return Deck
