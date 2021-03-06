extends Node

var Me
var Enemy

remote func receive_message(text):
	Me.get_node('chat').output_message(text)

#U: Calls function f with the arguments to my enemy
func send(f, args):
	if Enemy != null:
		#A: We've already made a connection
		rpc_id(Enemy, f, args)
	else:
		print('ERR: We shouldn\'t be here CTC %s %s' % [f, args])
