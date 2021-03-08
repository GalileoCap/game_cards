extends Node2D

var Hand = []

#U: Picks up a card
func pick_up(number):
	var card = preload('res://src/client/game/my_card.tscn').instance()
	card.set_name('%s' % number) #TODO: Handle duplicates
	card.Number = number
	
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
