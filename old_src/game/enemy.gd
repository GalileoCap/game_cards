extends Node2D

func shuffle_deck():
	var cards = 3
	#TODO: Keep track of which cards have already been dealt
	for i in range(cards):
		var card = preload('res://src/game/cards/enemy_card.tscn').instance()
		card.set_name('card_' + str(i)) #TODO: Better ID's
		var Start_pos = Vector2(0, 100) #TODO: Better positioning
		Start_pos.x = 1024 / (cards + 1) * (1 + i)
		card.set_position(Start_pos)
		add_child(card)

func remove_card():
	get_children()[0].queue_free()
