extends Node2D

#U: Standard 40 card deck for Truco.
#'A'ce, 'J'ack, 'Q'ueen, 'K'ing
#'C'lubs = Basto
#'S'pades = Espada
#'H'earts = Copa
#'D'iamonds = Oro
var Deck = ['AC', '2C', '3C', '4C', '5C', '6C', '7C', 'XC', 'KC', 'JC', 'QC', 'AS', '2S', '3S', '4S', '5S', '6S', '7S', 'XS', 'KS', 'JS', 'QS', 'AD', '2D', '3D', '4D', '5D', '6D', '7D', 'XD', 'KD', 'JD', 'QD', 'AH', '2H', '3H', '4H', '5H', '6H', '7H', 'XH', 'KH', 'JH', 'QH']

func shuffle_deck():
	if get_tree().is_network_server():
		Deck.shuffle()
		rpc('shuffle_cards', [Deck[0], Deck[1], Deck[2]])
		shuffle_cards([Deck[3], Deck[4], Deck[5]])

remote func shuffle_cards(cards):
	for i in len(cards):
		var card = preload('res://old_src/game/cards/own_card.tscn').instance()
		card.set_name('card_' + cards[i]) #TODO: Better ID's
		card.Number = cards[i]
		var Start_pos = Vector2(0, 500) #TODO: Better positioning
		Start_pos.x = 1024 / (float(len(cards)) + 1) * (1 + i)
		card.Start_pos = Start_pos
		card.set_position(Start_pos)
		add_child(card)
