extends "res://src/scripts/ui/interactions/InteractionPoint.gd"


var scanned: = false

func _ready() -> void:
	options = ["look", "use", "inv"]      


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.shuttle_bay_look")



func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.shuttle_bay_use")



func item_pressed(item) -> void:
	if item.text == "Scanner":
		if scanned == false:
			_play_story(item, "prologue_ren.shuttle_bay_scan")
			scanned = true
		else:
			_show_text(item, ["Already scanned this one."])
	else:
		_show_text(item, ["Nope."])
