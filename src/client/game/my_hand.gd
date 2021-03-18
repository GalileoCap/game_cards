extends Node2D

#U: Standard 40 card deck for Truco. TODO
#'A'ce, 'J'ack, 'Q'ueen, 'K'ing
#'C'lubs = Basto
#'S'pades = Espada
#'H'earts = Copa
#'D'iamonds = Oro
var Deck = ['AC', '2C', '3C', '4C', '5C', '6C', '7C', 'XC', 'KC', 'JC', 'QC', 'AS', '2S', '3S', '4S', '5S', '6S', '7S', 'XS', 'KS', 'JS', 'QS', 'AD', '2D', '3D', '4D', '5D', '6D', '7D', 'XD', 'KD', 'JD', 'QD', 'AH', '2H', '3H', '4H', '5H', '6H', '7H', 'XH', 'KH', 'JH', 'QH']

var Hand = []

#U: Picks up n cards
func pick_up(n):
	for _i in range(n):
		var WhichCard = Deck.pop_front()
		
		var card = preload('res://src/client/game/my_card.tscn').instance()
		card.set_name('%s' % WhichCard) #TODO: Handle duplicates
		card.WhichCard = WhichCard
		card.Where = 'Hand'
		
		Hand.append(card)
		add_child(card)
	
	for i in range(get_child_count()):
		Hand[i].place(Hand.size(), i)

#U: Resets my cards
func reset():
	Hand = []
	
	for child in get_children():
		child.queue_free()

#U: Removes a card and adjusts your hand's position
func remove_card(card):
	var this_child = get_node(card)
	this_child.queue_free()
	Hand.erase(this_child)
	
	for i in range(Hand.size()):
		Hand[i].place(Hand.size(), i)

#U: Shuffles the deck
func shuffle_deck():
	Deck.shuffle()
