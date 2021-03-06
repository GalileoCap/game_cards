extends Panel

#U: Writes a message on the chat
func output_message(text):
	$output.text += text+'\n'

#U: Sends a message to the chat
func send_message(text):
	var id = get_tree().get_network_unique_id() #TODO: Get name
	text = '%s: %s' % [id, text]
	#A: Identified myself
	
	CTC.send('receive_message', text)
	output_message(text) #A: I also want to see the message
	
	$input.clear()

#U: Sets up the chat when you enter a game
func enter():
	$input.clear()
	$output.text = ''
	show()
