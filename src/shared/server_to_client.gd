extends Node

var Me

remote func kicked(reason):
	print('Kicked ' + reason)
	Me.exit()

#U: Receives a value to set for a property
remote func receive_set(args):
	Me.set(args[0], args[1])

remote func connect_with_enemy(id):
	CTC.set('Enemy', id)
	CTC.set_network_master(id)

#U: Calls function f with args for the specified peer
func send(id, f, args):
	rpc_id(id, f, args)
