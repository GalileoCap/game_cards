extends Node

var Me

remote func kicked(reason):
	print('Kicked ' + reason)
	Me.exit()

#U: Receives a value to set for a property
remote func receive_set(args):
	Me.get_node(args.path).set(args.key, args.value)

#U: Connects with the enemy
remote func connect_to_game(id):
	CTC.set('Enemy', id)
	CTC.set_network_master(id) #A: So that they can send us functions
	
	Me.get_node('ui/chat').enter()

#U: Receives the cards I've been dealt
remote func receive_cards(cards):
	for card in cards:
		Me.get_node('game/my_hand').pick_up(card)

#U: Spawns a card on the field
remote func field_spawn(data):
	Me.get_node('game/field').spawn_card(data.number)

#U: Removes a card from your hand
remote func remove_from_hand(card):
	Me.get_node('game/my_hand').remove_card(card)

#U: Remvoes a card from the enemy's hand
remote func remove_from_enemy():
	print('REMOVE FROM ENEMY')
	#Me.get_node('game/emy_nemy_hand').remove_card()

#U: Ends a match
remote func end_match():
	Me.get_node('game/my_hand').reset()
	Me.get_node('game/field').reset()

#U: Calls function f with args for the specified peer
func send(id, f, args = null):
	if args == null:
		rpc_id(id, f)
	else:
		rpc_id(id, f, args)
