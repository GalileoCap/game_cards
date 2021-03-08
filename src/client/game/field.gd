extends Area2D

func spawn_card(number):
	var card = preload('res://src/client/game/my_card.tscn').instance()
	card.set_name('%s' % number) #TODO: Better ID's
	card.Number = number
	card.Disabled = true
	card.set_position(Vector2(512, 300))
	add_child(card)

func reset():
	for child in get_children():
		if child.name != 'col':
			child.queue_free()
