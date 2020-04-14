extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "talk", "use", "inv"]


func look_pressed(look) -> void:
	_show_text(look, ["text1", "text2"])
#	_play_story(look, "knot")
#	_clear_option(look, "look", "text")

func talk_pressed(talk) -> void:
	_show_text(talk, ["text1", "text2"])
#	_play_story(talk, "knot")
#	_clear_option(talk, "talk", "text")


func use_pressed(use) -> void:
	_show_text(use, ["text1", "text2"])
#	_play_story(use, "knot")
#	_play_story_and_destroy("next story knot")


func item_pressed(item) -> void:
	if item.text == "Stone":
		_play_story_and_destroy(item, "prologue_al.beast_rock")
#	elif item.text == "another item":
#		_show_text(item, ["text1"])
	else:
		_show_text(item, ["Nope"])
