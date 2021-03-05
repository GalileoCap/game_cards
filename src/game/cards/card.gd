extends Area2D

var Start_pos = Vector2()
var Number = null

var Disabled = false
var Selected = false

#U: Animates the card while selected
func animate():
	var mouse_pos = get_viewport().get_mouse_position()
	set_global_position(mouse_pos)
	#A: Following the mouse

#U: Starts animating the card
func select():
	Selected = true

#U: Stops animating the card
func release():
	Selected = false
	
	for field in get_overlapping_areas():
		if field.name == 'field':
			if field.is_my_turn():
				#A: It's my turn
				field.rpc('play_card', Number)
				queue_free()
	
	set_position(Start_pos)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and not Disabled:
		if event.get_button_index() == BUTTON_LEFT:
			if event.is_pressed():
				#A: You just clicked on this card
				select()
			else:
				#A: You just released this card
				release()
	#TODO: Differentiate if just clicking or holding the mouse

func _physics_process(_delta):
	if Selected:
		animate()

func _ready():
	var texture = load('res://resources/cards/' + Number + '.png')
	var _tmp = $sprite.set_texture(texture)
