extends "res://src/scripts/ui/interactions/InteractionPoint.gd"

#  ##########################################
#   INSTANCE AN INTERACTION POINT, THEN SAVE 
#   A NEW COPY OF THIS SCRIPT TO ATTACH AND
#   ADJUST THE FOLLOWING AS NEEDED
#  ##########################################


func _ready() -> void:
	options = ["look", "use", "inv"]        #["look", "talk", "use", "go", "inv"]


func look_pressed(look) -> void:
	_play_story(look, "knot")
#	_show_text(look, ["text1", "text2"])
#	_clear_option(look, "look", "knot")


func use_pressed(use) -> void:
	_play_story(use, "knot")
#	_show_text(use, ["text1", "text2"])
#	_play_story_and_destroy("next story knot")


func item_pressed(item) -> void:
	if item.text == "correct item":
		_play_story(item, "knot")
#	elif item.text == "another item":
#		_show_text(item, ["text1"])
	else:
		_show_text(item, ["text1", "text2"])


func talk_pressed(talk) -> void:
	_play_story(talk, "knot")
#	_show_text(talk, ["text1", "text2"])
#	_clear_option(talk, "talk", "knot")


func go_pressed(go) -> void:
	_transition(go, "new_scene")



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



