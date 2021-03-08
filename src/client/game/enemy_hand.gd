extends Node2D

var Hand = []

#U: Adds n cards to the enemy's hand
func pick_up(n):
	for i in range(Hand.size(), Hand.size() + n):
		var card = preload('res://src/client/game/enemy_card.tscn').instance()
		card.set_name('%s' % i)
		card.Number = 'back_blue' #TODO: Choose back
		
		Hand.append(card)
		add_child(card)
	
	for i in range(Hand.size()):
		Hand[i].place(Hand.size(), i)

#U: Removes n cards from the enemy's hand
func remove(n):
	n = clamp(n, 0, get_child_count())
	
	for i in range(n):
		var card = get_child(i)
		card.queue_free()
		Hand.erase(card)
	
	for i in range(Hand.size()):
		var card = Hand[i]
		card.place(Hand.size(), i)

func reset():
	Hand = []
	
	for child in get_children():
		child.queue_free()
