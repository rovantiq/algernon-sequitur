extends "res://src/scripts/ui/interactions/InteractionPointSimple.gd"

#  ##########################################
#   INSTANCE AN INTERACTION POINT, MAKE IT
#   LOCAL, THEN ATTACH A COPY OF THIS SCRIPT 
#   AND ADJUST THE FOLLOWING AS NEEDED
#  ##########################################




func _ready() -> void:
	_set_name("Name")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") or (Input.is_action_just_pressed("left_click") and mouse_hover == true):
		if interaction_ui.visible == true and story_ui.visible == false and inventory_ui.visible:
			_show_text(["I'm simple!"])





#  Available methods:
#  
#  _show_text()
#  _show_text_and_destroy()
#  _play_story()
#  _play_story_and_destroy()
#  _set_name()
#  _transition()
#
#  See "res://src/scripts/InteractionPoint.gd" for more info
