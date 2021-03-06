#INFO: Both players have to have this script in the same state at all times
extends Node

#U: Info of each player based on their id
var Players = {}

remotesync func set_player(info):
	var id = get_tree().get_rpc_sender_id()
	Players[id] = info

func get_player(id):
	return Players[id]
