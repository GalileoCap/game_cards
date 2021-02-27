extends Control

func user_entered(_id):
	SHARED.rpc('set_player', CFG.get_info())
	#TODO: Start game

func _ready():
	pass

