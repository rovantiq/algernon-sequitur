extends "res://src/scripts/ui/interactions/InteractionPoint.gd"





func _ready() -> void:
	options = ["look", "use"]


func look_pressed(look) -> void:
	_show_text(look, ["text1", "text2"])
#	_play_story(look, "knot")


func use_pressed(use) -> void:
	_play_story_and_destroy(use, "prologue_al.collect_stone")


