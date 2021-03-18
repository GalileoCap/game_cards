extends Node

var Players #U: Each turn the players go in the order of this list

var Turn = 0 #U: Who won each turn
var History = [] #U: Card history

#U: Returns the other player's id
func other_player(id):
	return Players[(Players.find(id) + 1) % 2]

#U: Spawns a card on the field of the player who threw it
func field_spawn(data):
	for id in Players:
		STC.send(id, 'field_spawn', data)
		STC.send(id, 'remove_from_hand', data)

#U: Checks if you can throw the card and throws it
func throw_card(data):
	if data.id == Players[Turn % 2]:
		#A: It's this player's turn
		field_spawn(data)
		
		Turn += 1
		
		if Turn % 6 == 0:
			#A: End of match
			end_match()

func end_match():
	for id in Players:
		STC.send(id, 'end_match')

func _ready():
	for id in Players:
		STC.send(id, 'shuffle_deck')
		STC.send(id, 'pick_up', 3)
		STC.send(id, 'enemy_pick_up', 3)
