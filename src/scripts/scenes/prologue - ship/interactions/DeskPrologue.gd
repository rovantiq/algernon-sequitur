extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "use"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.desk_look")


func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.desk_use")
