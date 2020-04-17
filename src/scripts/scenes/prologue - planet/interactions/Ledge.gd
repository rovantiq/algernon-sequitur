extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "use", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_al.ledge_look")


func use_pressed(use) -> void:
	_play_story(use, "prologue_al.ledge_use")


func item_pressed(item) -> void:
	if item.text == "Rope Dart":
		options = ["go"]
		_play_story_and_end(item, "prologue_al.ledge_harpoon")
	else:
		_show_text(item, ["Nope."])


func go_pressed(go) -> void:
	_play_story_and_destroy(go, "prologue_al.climb")


