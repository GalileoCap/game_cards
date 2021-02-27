extends StaticBody2D

var Start_pos = Vector2()

var Selected = false
var Expanding = true

#U: Animates the card while selected
func animate():
	var mouse_pos = get_viewport().get_mouse_position()
	set_global_position(mouse_pos)
	#A: Following the mouse

#U: Starts animating the card
func select():
	Selected = true
	Expanding = true

#U: Stops animating the card
func deselect():
	Selected = false
	Expanding = true
	
	set_position(Start_pos)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.get_button_index() == BUTTON_LEFT:
			if event.is_pressed():
				#A: You just clicked on this card
				select()
			else:
				#A: You just released this card
				deselect()
	#TODO: Differentiate if just clicking or holding the mouse

func _physics_process(_delta):
	if Selected:
		animate()

func _ready():
	$number/label.text = str(Number)
