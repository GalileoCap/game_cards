extends Control

onready var input_box = $input
onready var output_box = $output
onready var command_handler = $command_handler

var CmdHistory = []
var CmdLine = len(CmdHistory)

func _ready():
	input_box.grab_focus()

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_UP:
			goto_command_history(-1)
		if event.scancode == KEY_DOWN:
			goto_command_history(1)

func goto_command_history(offset):
	CmdLine += offset
	CmdLine = clamp(CmdLine, 0, CmdHistory.size())
	input_box.clear()
	input_box.grab_focus()
	if CmdLine < CmdHistory.size() and CmdHistory.size() > 0:
		input_box.text = CmdHistory[CmdLine]
		input_box.grab_focus()

func process_command(text):
	var words = text.split(' ')
	words = Array(words)
	
	for _i in range(words.count('')):
		words.erase('')
	
	if words.size() == 0:
		return
	
	CmdHistory.append(text)
	
	var command_word = words.pop_front()
	
	for c in command_handler.valid_commands:
		if c[0] == command_word:
			if words.size() != c[1].size():
				output_text('Failure executing command "%s", expected %s parameters' % [command_word, c[1].size()])
				return
			for i in range(words.size()):
				if not command_handler.check_type(words[i], c[1][i]):
					output_text('Failure executing command "%s", parameter %s ("%s") is of the wrong type' % [command_word, (i + 1), words[i]])
					return
			output_text(command_handler.callv(command_word, words))
			return
	output_text('Command "%s" does not exist.' % command_word)

func output_text(text):
	output_box.text += '\n' + text
	output_box.set_v_scroll(9999999)

func _on_input_text_entered(new_text):
	input_box.clear()
	process_command(new_text)
	CmdLine = CmdHistory.size()
