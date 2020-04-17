extends "res://src/scripts/ui/interactions/InteractionPoint.gd"



func _ready() -> void:
	options = ["look", "talk", "use", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_al.beast_look")

func talk_pressed(talk) -> void:
	_play_story(talk, "prologue_al.beast_talk")


func use_pressed(use) -> void:
	_play_story(use, "prologue_al.beast_use")


func item_pressed(item) -> void:
	if item.text == "Stone":
		_play_story_and_end(item, "prologue_al.beast_rock")
	elif item.text == "Revolver":
		_play_story_and_end(item, "prologue_al.beast_gun")
	else:
		_show_text(item, ["Nope."])
