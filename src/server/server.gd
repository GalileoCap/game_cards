extends Node

var Players = {} #U: Dict with every player's info
var Waiting = [] #U: List of players waiting to join a game

#U: Receives a new player's info
func new_player(id, info):
	$console.output_text('PLAYER %s JOINED' % id)
	
	Players[id] = info
	Waiting.append(id) #A: Add them to the waiting list
	
	if Waiting.size() >= 2:
		#A: Enough players to start a match
		start_match()

#U: Removes a player and stops their match
func remove_player(id):
	Players.erase(id)
	#TODO: Stop match

#U: Starts a new match
func start_match():
	var id1 = Waiting.pop_front()
	var id2 = Waiting.pop_front()
	#A: Removed players from the waiting list
	
	STC.send(id1, 'connect_with_enemy', id2)
	STC.send(id2, 'connect_with_enemy', id1)
	#A: "Connected" both players
	
	var game = preload('res://src/server/game.tscn').instance()
	game.set_name('game_%s' % $games.get_children().size())
	game.Players = [id1, id2]
	$games.add_child(game)
	#A: Created game TODO: Is this needed?

func _ready():
	CTS.Me = self
	
	var _trash = get_tree().connect('network_peer_disconnected', self, 'remove_player')
