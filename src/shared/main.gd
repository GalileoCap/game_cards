extends Node

func _ready():
#	var args = Array(OS.get_cmdline_args())
	if OS.has_feature('server'):
		#A: Start as server
		var _trash = get_tree().change_scene('res://src/server/server.tscn')
	else:
		#A: Start as client
		var _trash = get_tree().change_scene('res://src/client/client.tscn')
