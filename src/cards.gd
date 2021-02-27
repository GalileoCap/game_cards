extends Node2D

export (int) var cards = 3

var RNG = RandomNumberGenerator.new()

func shuffle():
	for i in range(cards):
		var card = preload('res://src/cards/card.tscn').instance()
		card.set_name('card_' + str(i)) #TODO: Better ID's
		card.Number = RNG.randi_range(1, 13)
		card.Start_pos = Vector2(1024 / (cards + 1) * (1 + i), 500) #TODO: Better positioning 
		card.position = card.Start_pos
		add_child(card)

func _ready():
	RNG.set_seed(0)
	shuffle()
