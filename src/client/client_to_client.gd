extends Node

var Me
var Enemy

#U: Receives a message on the chat
remote func receive_message(text):
	Me.get_node('ui/chat').output_message(text)

#U: Calls function f with the arguments to my enemy
func send(f, args = null):
	if args == null:
		rpc_id(Enemy, f)
	else:
		rpc_id(Enemy, f, args)
