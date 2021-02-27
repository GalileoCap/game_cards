extends Control

func enemy_left(_id = null):
	$enemy_left.show()

func _ready():
	var _tmp = get_tree().connect('network_peer_disconnected', self, 'enemy_left')
	_tmp = get_tree().connect('server_disconnected', self, 'enemy_left')
	
	_tmp = $enemy_left/leave.connect('pressed', get_node('../../'), 'reset')
	_tmp = $waiting/leave.connect('pressed', get_node('../../'), 'reset')
