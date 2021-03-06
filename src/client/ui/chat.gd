extends Panel

func output_message(text):
	$output.text += '\n'+text

func send_message(text):
	CTC.send('receive_message', text)
	$input.clear()

func _ready():
	var _trash = get_tree().connect('connected_to_server', self, 'show')
	_trash = get_tree().connect('server_disconnected', self, 'hide')
