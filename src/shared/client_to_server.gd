extends Node

var Me #U: Receiver node

remote func receive_player_info(info):
	var id = get_tree().get_rpc_sender_id()
	Me.new_player(id, info)

func send(f, args):
	rpc_id(1, f, args)
