extends "res://src/scripts/ui/interactions/InteractionPoint.gd"




func _ready() -> void:
	_set_name("Desk")
	options = ["use"]


func use_pressed(use) -> void:
	_play_story_and_destroy(use, "prologue_ren.end")
