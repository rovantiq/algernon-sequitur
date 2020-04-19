extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "use", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.dorm_look")



func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.dorm_use")



func item_pressed(item) -> void:
	if item.text == "Scanner":
			_show_text(item, ["No port in here."])
	else:
		_show_text(item, ["Nope."])
