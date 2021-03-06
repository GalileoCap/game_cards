extends Area2D

var Disabled = false

var Number = 'AH'

var Selected = false #U: Has been selected
var Held = false #U: Is currently being held

#U: Places the card based on it's position in the hand
func place(hz, i):
	position.y = 500
	position.x = 1024 / (hz + 1) * (1 + i)

#U: Changes the artwork to any image under resources/cards/
func change_artwork(which):
	var texture = load('res://resources/cards/' + which + '.png')
	var _tmp = $sprite.set_texture(texture)

#U: Follows the mouse around the screen
func follow_mouse():
	var mouse_pos = get_viewport().get_mouse_position()
	set_global_position(mouse_pos)
	#A: Following the mouse

func hold():
	Held = true
	Selected = false

func release():
	Held = false
	
	var areas = get_overlapping_areas()
	for area in areas:
		if area.name == 'field':
			#A: Throwing into the field
			var data = {
				'name': name,
				'number': Number,
			}
			
			CTS.send('throw_card', data)
	
	var Hand = get_parent().Hand
	place(Hand.size(), Hand.find(self))

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and not Disabled:
		var button = event.get_button_index()
		if button == BUTTON_LEFT:
			if event.is_pressed():
				#A: You just clicked on this card
				hold()
			else:
				#A: You just released this card
				release()
		elif button == BUTTON_RIGHT and not Held:
			#TODO: Highlight this card and show more info
			pass

func _physics_process(_delta):
	if Held:
		follow_mouse()

func _ready():
	change_artwork(Number)
