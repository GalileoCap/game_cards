extends Area2D

func spawn_card(WhichCard, is_mine):
	var card = preload('res://src/client/game/my_card.tscn').instance()
	card.set_name('%s' % WhichCard) #TODO: Better ID's
	card.WhichCard = WhichCard
	card.Where = 'Field'
	
	add_child(card)
	
	var which_field = get_node('mine')
	var y = 400
	if not is_mine:
		which_field = get_node('enemy')
		y = 200
	
	var sz = which_field.get_child_count()
	for i in range(sz):
		which_field.get_child(i).place(sz, i, y)

func reset():
	for child in $mine.get_children() + $enemy.get_children():
		child.queue_free()
