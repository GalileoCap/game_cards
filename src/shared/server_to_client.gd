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

#U: Receives the cards I've been dealt
remote func receive_cards(cards):
	for card in cards:
		get_node('../client/game/my_hand').pick_up(card)

#U: Spawns a card on the field
remote func field_spawn(data):
	get_node('../client/game/field').spawn_card(data.number)

#U: Removes a card from your hand
remote func remove_from_hand(card):
	get_node('../client/game/my_hand').remove_card(card)

#U: Remvoes a card from the enemy's hand
remote func remove_from_enemy(n):
	get_node('../client/game/enemy_hand').remove(n)

remote func deal_to_enemy(n):
	get_node('../client/game/enemy_hand').pick_up(n)

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
