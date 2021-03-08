extends Control

#U: Writes a message on the chat
func output_message(text):
	$panel/output.text += text+'\n'

#U: Sends a message to the chat
func send_message(text):
	var id = get_tree().get_network_unique_id() #TODO: Get name
	text = '%s: %s' % [id, text]
	#A: Identified myself
	
	CTC.send('receive_message', text)
	output_message(text) #A: I also want to see the message
	
	$panel/input.clear()

func open():
	$panel.show()
	$open.hide()

func close():
	$panel.hide()
	$open.show()

#U: Sets up the chat when you enter a game
func enter():
	$panel/input.clear()
	$panel/output.text = ''
	
	$panel.hide()
	$open.show()
	show()

func _ready():
	var _trash = get_tree().connect('connected_to_server', self, 'enter')
	_trash = get_tree().connect('server_disconnected', self, 'hide')
	
	hide()
