extends Control

const PORT = 3000

func user_entered(id):
	SHARED.rpc('set_player', CFG.get_info())
	#TODO: Start game

func host_room():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, 1) #A: Max players is two
	get_tree().set_network_peer(host)
	enter_room()

func join_room():
	var ip = '127.0.0.1' #TODO: Choose IP
	var host = NetworkedMultiplayerENet.new()
	host.create_client(ip, PORT)
	get_tree().set_network_peer(host)

func enter_room():
	pass
	#TODO: Wait until both players have joiend to start the game

func _ready():
	get_tree().connect('connected_to_server', self, 'enter_room')
	get_tree().connect('network_peer_connected', self, 'user_entered')
#	get_tree().connect('network_peer_disconnected', self, 'user_exited')
#	get_tree().connect('server_disconnected', self, '_server_disconnected')
