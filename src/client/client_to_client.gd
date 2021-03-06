extends Node

var Me
var Enemy

#U: Receives a message on the chat
remote func receive_message(text):
	Me.get_node('ui/chat').output_message(text)

#U: Calls function f with the arguments to my enemy
func send(f, args):
	if Enemy != null:
		#A: We've already made a connection
		rpc_id(Enemy, f, args)
	else:
		print('ERR: We shouldn\'t be here CTC %s %s' % [f, args])
