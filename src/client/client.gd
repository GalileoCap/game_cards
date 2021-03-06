extends Node

func _on_test_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.create_client('127.0.0.1', 3000)
	get_tree().set_network_peer(host)
