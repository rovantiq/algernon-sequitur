extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "use", "inv"]


func look_pressed(look) -> void:
	_show_text(look, ["That's well within harpooning distance."])


func use_pressed(use) -> void:
	_show_text(use, ["Can't reach."])


func item_pressed(item) -> void:
	if item.text == "Rope Dart":
		options = ["go"]
		_play_story_and_end(item, "prologue_al.harpoon")
	else:
		_show_text(item, ["Nope."])


func go_pressed(go) -> void:
	_play_story_and_destroy(go, "prologue_al.climb")


