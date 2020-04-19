extends "res://src/scripts/ui/interactions/InteractionPoint.gd"

#  ##########################################

func _ready() -> void:
	options = ["look", "use", "inv"]        #["look", "talk", "use", "go", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.storage_look")



func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.storage_use")



func item_pressed(item) -> void:
	if item.text == "Scanner":
			_show_text(item, ["No port here."])
	else:
		_show_text(item, ["Nope."])
