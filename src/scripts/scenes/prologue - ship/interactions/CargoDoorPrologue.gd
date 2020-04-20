extends "res://src/scripts/ui/interactions/InteractionPoint.gd"




func _ready() -> void:
	options = ["look", "use", "inv"]        #["look", "talk", "use", "go", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.cargo_look")



func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.cargo_use")



func item_pressed(item) -> void:
	if item.text == "Scanner":
		if StoryRunner.story.variables_state.get("cargo_scanned") == 0:
			_play_story(item, "prologue_ren.cargo_scan")
		else:
			_show_text(item, ["Already scanned this one."])
	else:
		_show_text(item, ["Nope."])

