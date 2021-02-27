extends Control

const PORT = 3000

#U: Starts hosting a game
func host():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, 1) #A: 1+1 = Two players max
	get_tree().set_network_peer(host)
	
	get_node('../').load_game()

#U: Joins a game
func join():
	var ip = $ip_input.text
	if ip.is_valid_ip_address():
		var host = NetworkedMultiplayerENet.new()
		host.create_client(ip, PORT)
		get_tree().set_network_peer(host)
	else:
		print('INVALID IP ADRESS %s' % ip)
		#TODO: Warn
