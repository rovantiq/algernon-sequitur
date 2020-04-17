extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "go"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_al.look_clearing")


func go_pressed(go) -> void:
	_play_story_and_end(go, "prologue_al.end")
