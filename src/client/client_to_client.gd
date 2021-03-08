extends Node

var Enemy #U: Enemy's id

#U: Receives a message on the chat
remote func receive_message(text):
	get_node('../client/ui/chat').output_message(text)

#U: Calls function f with the arguments to my enemy
func send(f, args = null):
	if args == null:
		rpc_id(Enemy, f)
	else:
		rpc_id(Enemy, f, args)
