extends Area2D

var Number = 'AH'

#U: Places the card based on it's position in the hand
func place(hz, i):
	position.y = 0
	position.x = 1024 / (hz + 1) * (1 + i)

#U: Changes the artwork to any image under resources/cards/
func change_artwork(which):
	var texture = load('res://resources/cards/' + which + '.png')
	var _tmp = $sprite.set_texture(texture)

func _ready():
	change_artwork(Number)
