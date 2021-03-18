extends Area2D

var Where = 'Field'

var WhichCard = 'AH'

var Selected = false #U: Has been selected
var Held = false #U: Is currently being held

#U: Places the card based on it's position in the hand
func place(hz, i, y = 600):
	position.y = y
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
				'WhichCard': WhichCard,
			}
			
			CTS.send('throw_card', data)
	
	var Hand = get_parent().Hand
	place(Hand.size(), Hand.find(self))

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and Where == 'Hand':
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

func hovering():
	if Where == 'Hand' and not Held:
		position.y = 500

func dehover():
	if Where == 'Hand' and not Held:
		position.y = 600

func _physics_process(_delta):
	if Held:
		follow_mouse()

func _ready():
	change_artwork(WhichCard)
