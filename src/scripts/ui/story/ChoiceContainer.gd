extends MarginContainer


# ############################################################################ #
# Imports
# ############################################################################ #

var ChoiceButton: = load("res://src/ui/story/ChoiceButton.tscn")

# ############################################################################ #
# Nodes
# ############################################################################ #

onready var choice_vbox = $ChoiceVBoxContainer

# ############################################################################ #
# Signal
# ############################################################################ #

signal choice_selected(index)

# ############################################################################ #
# Private properties
# ############################################################################ #

var _buttons = []

# ############################################################################ #
# Public Methods
# ############################################################################ #

func create_choices(choices) -> void:
	for choice in choices:
			var button = ChoiceButton.instance()
			button.text = choice.text
			if button.text == "->" or button.text == "-x-":
				button.set_text_align(1)
			button.connect("pressed", self, "_button_pressed", [button])
			_buttons.append(button)
			choice_vbox.add_child(button)
	choice_vbox.get_child(0).grab_focus()

# ############################################################################ #
# Private Methods
# ############################################################################ #

func _button_pressed(button) -> void:
	var index = _buttons.find(button)
	if index != -1:
		emit_signal("choice_selected", index)
