extends Node

remote func receive_player_info(info):
	var id = get_tree().get_rpc_sender_id()
	get_node('../server').new_player(id, info)

remote func throw_card(data):
	var id = get_tree().get_rpc_sender_id()
	data.id = id
	
	var game = get_node('../server').find_game(id)
	game.throw_card(data)

func send(f, args = null):
	if args == null:
		rpc_id(1, f)
	else:
		rpc_id(1, f, args)
