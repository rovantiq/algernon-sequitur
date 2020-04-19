extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "use", "inv"] 


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.small_shuttle_look")



func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.small_shuttle_use")



func item_pressed(item) -> void:
	if item.text == "Scanner":
			_play_story(item, "prologue_ren.small_shuttle_scan")
	else:
		_show_text(item, ["Nope."])
