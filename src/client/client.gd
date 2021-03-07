extends Node

var Enemy

func send_info():
	CTS.send('receive_player_info', {'test':'ing'})

func _ready():
	STC.Me = self
	CTC.Me = self
	
	var _trash = get_tree().connect('connected_to_server', self, 'send_info')
	
	$ui.show()
