extends "res://src/scripts/ui/interactions/InteractionPoint.gd"


var scanned = false


func _ready() -> void:
	options = ["look", "use", "inv"]        #["look", "talk", "use", "go", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "prologue_ren.hoverbike_look")
#	_show_text(look, ["text1", "text2"])
#	_clear_option(look, "look", "knot")


func use_pressed(use) -> void:
	_play_story(use, "prologue_ren.hoverbike_use")
#	_show_text(use, ["text1", "text2"])
#	_play_story_and_destroy("next story knot")


func item_pressed(item) -> void:
	if item.text == "Scanner":
		if scanned == false:
			_play_story(item, "prologue_ren.hoverbike_scan")
			scanned = true
		else:
			_show_text(item, ["Already scanned this one."])
#	elif item.text == "another item":
#		_show_text(item, ["text1"])
	else:
		_show_text(item, ["Nope"])


#  Available methods:
#  
#  _show_text()
#  _show_text_and_destroy()
#  _play_story()
#  _cycle_stories()
#  _play_story_and_end()
#  _play_story_and_destroy()
#  _clear_option()
#  _set_name()
#  _transition()
#
#  See "res://src/scripts/InteractionPoint.gd" for more info



