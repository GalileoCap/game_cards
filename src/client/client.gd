extends Node

var Enemy

func _on_test_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.create_client('127.0.0.1', 3000)
	get_tree().set_network_peer(host)

func send_info():
	CTS.send('receive_player_info', {'test':'ing'})
	$input.show()
	$output.show()

func exit():
	get_tree().quit()

func _on_input_text_entered(text):
	CTC.send('new_message', text)
	$input.clear()

func output_message(text):
	$output.text += '\n'+text

func _ready():
	STC.Me = self
	CTC.Me = self
	
	var _trash = get_tree().connect('connected_to_server', self, 'send_info')
	_trash = get_tree().connect('server_disconnected', self, 'exit')
