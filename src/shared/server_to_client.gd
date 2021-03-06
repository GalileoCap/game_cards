extends Node

var Me

remote func kicked(reason):
	print('Kicked ' + reason)
	Me.exit()

#U: Receives a value to set for a property
remote func receive_set(args):
	Me.set(args[0], args[1])

#U: Connects with the enemy
remote func connect_with_enemy(id):
	CTC.set('Enemy', id)
	CTC.set_network_master(id) #A: So that they can send us functions

#U: Calls function f with args for the specified peer
func send(id, f, args):
	rpc_id(id, f, args)
