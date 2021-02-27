extends Node2D

export (int) var cards = 3

var RNG = RandomNumberGenerator.new()

func shuffle():
	for i in range(cards):
		var card = preload('res://src/cards/card.tscn').instance()
		card.set_name('card_' + str(i)) #TODO: Better ID's
		card.Number = RNG.randi_range(1, 13)
		card.position = Vector2(1024 / (cards + 1) * (1 + i), 500) #TODO: Better positioning
		card.connect('select', self, 'select')
		add_child(card)

#U: Selects one card a deselects all the rest
func select(card):
	for child in get_children():
		if child == card:
			child.select()
		else:
			child.deselect()

func _ready():
	RNG.set_seed(0)
	shuffle()
