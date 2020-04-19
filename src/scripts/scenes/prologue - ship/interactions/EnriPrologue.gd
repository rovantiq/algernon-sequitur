extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "talk"]        #["look", "talk", "use", "go", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.enri_look")


func talk_pressed(talk) -> void:
	_clear_option(talk, "talk", "prologue_ren.enri_talk")

