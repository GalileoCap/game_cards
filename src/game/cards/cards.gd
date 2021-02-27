extends Node2D

export (int) var cards = 3

var RNG = RandomNumberGenerator.new()

func shuffle_deck():
	#TODO: Keep track of which cards have already been dealt
	for i in range(cards):
		var card = preload('res://src/game/cards/own_card.tscn').instance()
		card.set_name('card_' + str(i)) #TODO: Better ID's
		card.Number = randi() % 12 + 1
		var Start_pos = Vector2(0, 500) #TODO: Better positioning
		Start_pos.x = 1024 / (cards + 1) * (1 + i)
		card.Start_pos = Start_pos
		card.position = card.Start_pos
		add_child(card)
