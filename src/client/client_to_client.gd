extends Node

var Me
var Enemy

remote func new_message(text):
	Me.output_message(text)

#U: Calls function f with the arguments to my enemy
func send(f, args):
	rpc_id(Enemy, f, args)
