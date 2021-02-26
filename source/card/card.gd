extends StaticBody2D

var Selected = false

var Expanding = true

#U: Animates the card while selected
func animate():
	var curr = get_scale()
	var new = Vector2()
	
	if (Expanding or curr.x == 1) and curr.x < 1.3:
		#A: The card has to expand
		Expanding = true
		new.x = curr.x + 0.005
	elif (not Expanding) or curr.x >= 1.3:
		Expanding = false
		new.x = curr.x - 0.005
	
	new.y = new.x
	
	set_scale(new)
	#TODO: Instead of expanding the card itself,
	#      maybe move a glow around it

#U: Starts animating the card
func select():
	Selected = true
	
	Expanding = true
	#TODO: Deselect other cards

#U: Stops animating the card
func deselect():
	Selected = false
	
	set_scale(Vector2(1, 1))
	Expanding = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT and event.is_pressed():
			#A: You just clicked on this card
			if Selected:
				deselect()
			else:
				select()

func _physics_process(_delta):
	if Selected:
		animate()
