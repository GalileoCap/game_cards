extends Node

#U: Checks if this argument is a valid type
func check_type(string, type):
	match type:
		ARG_INT:
			return string.is_valid_integer()
		ARG_FLOAT:
			return string.is_valid_float()
		ARG_STRING:
			return true
		ARG_BOOL:
			return (string == 'true' or string == 'false')
		_:
			return false

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

const valid_commands = [
	['start_server', [ARG_INT, ARG_INT]],
	['stop_server', []],
	['kick_player', [ARG_INT, ARG_STRING]],
	['list_players', []],
]

#U: Starts a server for n players
func start_server(port, max_players):
	port = int(port)
	max_players = int(max_players)
	
	var host = NetworkedMultiplayerENet.new()
	host.create_server(port, max_players + 1) #A: +1 for the server
	get_tree().set_network_peer(host)
	
	return 'Starting server on port %s' % port

#U: Stops the server
func stop_server():
	var players = get_tree().get_network_connected_peers()
	for id in players:
		var _trash = kick_player(id, 'Server Closed')
	
	get_tree().set_network_peer(null)
	
	return 'Stopped server'

#U: Kicks a specific player
func kick_player(id, reason):
	id = int(id)
	
	var players = get_tree().get_network_connected_peers()
	if id == 1:
		return 'Can\'t kick self'
	elif id in players:
		STC.send(id, 'kicked', reason)
		get_tree().get_network_peer().disconnect_peer(id)
		return 'Kicked %s' % id
	else:
		return 'Player %s doesn\'t exist' % id

#U: Lists all joined ids
func list_players():
	if get_tree().get_network_peer() != null:
		var players = get_tree().get_network_connected_peers()
	
		var out = 'PLAYERS:'
		for id in players:
			if id != 1:
				out += ' %s' % id
		
		return out
	else:
		return 'Server not started'

