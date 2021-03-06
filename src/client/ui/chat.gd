extends Panel

func output_message(text):
	$output.text += text+'\n'

func send_message(text):
	var id = get_tree().get_network_unique_id() #TODO: Get name
	text = '%s: %s' % [id, text]
	
	CTC.send('receive_message', text)
	output_message(text)
	
	$input.clear()

func _ready():
	var _trash = get_tree().connect('connected_to_server', self, 'show')
	_trash = get_tree().connect('server_disconnected', self, 'hide')
