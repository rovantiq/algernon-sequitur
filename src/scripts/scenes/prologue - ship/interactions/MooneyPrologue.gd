extends "res://src/scripts/ui/interactions/InteractionPoint.gd"


func _ready() -> void:
	if StoryRunner.loaded == false:
		yield(StoryRunner, "loaded")
	if StoryRunner.story.variables_state.get("bridge_scanned") == 0:
		options = ["look", "talk",]
	else:
		options = ["look"]


func look_pressed(look) -> void:
	_cycle_stories(look, ["prologue_ren.mooney_look", "prologue_ren.mooney_look2", "prologue_ren.mooney_look3"])



func talk_pressed(talk) -> void:
	_clear_option(talk, "talk", "prologue_ren.mooney_talk")








