extends Node

remote func kicked(reason):
	print('Kicked ' + reason)
	get_node('../client').exit()

#U: Receives a value to set for a property
remote func receive_set(args):
	get_node('../client/%s' % args.path).set(args.key, args.value)

#U: Connects with the enemy
remote func connect_to_game(id):
	CTC.set('Enemy', id)
	CTC.set_network_master(id) #A: So that they can send us functions
	
	get_node('../client/ui/chat').enter()

#U: Shuffles the player's deck
remote func shuffle_deck():
	get_node('../client/game/my_hand').shuffle_deck()

#U: Receives the cards I've been dealt
remote func pick_up(n):
	get_node('../client/game/my_hand').pick_up(n)

remote func enemy_pick_up(n):
	get_node('../client/game/enemy_hand').pick_up(n)

#U: Spawns a card on the field
remote func field_spawn(data):
	var is_mine = data.id == get_tree().get_network_unique_id()
	get_node('../client/game/field').spawn_card(data.WhichCard, is_mine)

#U: Removes a card from your hand
remote func remove_from_hand(data):
	if data.id == get_tree().get_network_unique_id():
		get_node('../client/game/my_hand').remove_card(data.WhichCard)
	else:
		get_node('../client/game/enemy_hand').remove(1)

#U: Ends a match
remote func end_match():
	get_node('../client/game').reset()
	get_node('../client/ui/main_menu').leave() #TODO: Offer rematch

#U: Calls function f with args for the specified peer
func send(id, f, args = null):
	if args == null:
		rpc_id(id, f)
	else:
		rpc_id(id, f, args)
