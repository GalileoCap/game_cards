extends Area2D

const Order = ['']

var Turn = 0
var Cards = []
puppet var Players #U: Whose turn is it

#U: Throws coin for the first turn's order
func first_turn_order(id):
	if get_tree().is_network_server():
		var s_id = get_tree().get_network_unique_id()
		Players = [id, s_id]
		Players.shuffle()
		rset_id(id, 'Players', Players)
		#TODO: Announce player order

#U: Tells you whether it's your turn or not
func is_my_turn():
	var id = get_tree().get_network_unique_id()
	return id == Players[Turn % 2]

func spawn(number):
	Cards.append(number)
	
	var card = preload('res://old_src/game/cards/own_card.tscn').instance()
	card.set_name('card_' + number) #TODO: Better ID's
	card.Number = number
	var Start_pos = Vector2(1024/2, 300)
	card.Start_pos = Start_pos
	card.Disabled = true
	card.set_position(Start_pos)
	$field_cards.add_child(card)

func number(card):
	var n = card[0]
	match n:
		'A':
			return 1
		'X':
			return 10
		'J':
			return 11
		'Q':
			return 12
		'K':
			return 13
		_:
			return int(n)

#U: Gives a score between 0 and 16 based on the ranking of the card
func score(card):
	var n = number(card) #U: Number of the card
	var s = card[1] #U: Suit of the card
	
	if n >= 4 and n != 7:
		#A: Easy to score
		return n - 4 #[0, 9]
	elif n == 1:
		if s in ['H', 'D']:
			return 10 #A: Next after King
		elif s == 'C':
			return 15 #A: Second to highest
		else:
			return 16 #A: Highest one
	elif n == 2:
		return 11 #A: After the bad Aces
	elif n == 3:
		return 12 #A: After the Twos
	elif n == 7:
		if s in ['C', 'H']:
			return 3 #7 - 4
		elif s == 'D':
			return 13 #After the Threes
		else:
			return 14 #After the previous seven

func compare(c1, c2):
	var s1 = score(c1)
	var s2 = score(c2)
	
	if s1 > s2:
		return 0
	elif s1 < s2:
		return 1
	else: 
		return 0

remotesync func play_card(number):
	var sender_id = get_tree().get_rpc_sender_id()
	var id = get_tree().get_network_unique_id()
	if sender_id != id:
		#A: The other player played a card
		get_node('../enemy').remove_card()
	
	#TODO: Rearrange hands
	if Turn % 2 == 0:
		spawn(number)
	else:
		var prev = Cards[-1]
		spawn(number)
		var by = compare(prev, number)
		Players = [Players[by], Players[(by + 1) % 2]]
		#A: Shifted the array by "by"
	
	Turn += 1
	
	if Turn % 6 == 0:
		#A: Round over
		get_node('../').start_game()
