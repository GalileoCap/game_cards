extends Panel

func join():
	update_status('CONNECTING TO SERVER')
	
	var input = $join/ip.text.split(':')
	var ip = input[0]
	var port = int(input[1])
	
	#TODO: Check if they're valid
	
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, port)
	get_tree().set_network_peer(host)
	
	$leave.show()
	$join.hide()

func leave():
	get_tree().set_network_peer(null)
	
	$leave.hide()
	$join.show()

func update_status(status):
	$leave/status.text = 'STATUS: %s' % status

func _ready():
	var _trash = get_tree().connect('connected_to_server', self, 'update_status', ['CONNECTED TO SERVER'])
	_trash = get_tree().connect('connection_failed', self, 'update_status', ['CONNECTION FAILED'])
	_trash = get_tree().connect('server_disconnected', self, 'update_status', ['SERVER DISCONNECTED'])
	
	$join.show()
	$leave.hide()
