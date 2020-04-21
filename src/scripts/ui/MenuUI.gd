extends Control




onready var load_button: = $VBoxContainer/LoadButton
onready var resume_button: = $VBoxContainer/ResumeButton
onready var controls: = get_parent().get_node("Controls")
onready var back_button: = get_parent().get_node("Controls/CenterContainer/VBoxContainer/BackButton")


var in_control = false



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("right_click"):
		if StoryRunner.ui_active == false and in_control == false:
			StoryRunner.curtain.color = Color("000000")
			StoryRunner.ui_active = true
			in_control = true
			if StoryRunner.save_game_state == "":
				load_button.disabled = true
				load_button.set_focus_mode(0)
			visible = true
			if Input.is_action_just_pressed("ui_cancel"):
				resume_button.grab_focus()
		elif in_control == true:
			if controls.visible == true:
				controls.visible = false
				resume_button.grab_focus()
			else:
				StoryRunner.curtain.color = Color("00000000")
				StoryRunner.ui_active = false
				visible = false
				in_control = false



func _on_ResumeButton_pressed() -> void:
	StoryRunner.curtain.color = Color("00000000")
	StoryRunner.ui_active = false
	visible = false
	in_control = false


func _on_SaveButton_pressed() -> void:
	StoryRunner.save_game_state = StoryRunner.story.state.to_json()
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_var(StoryRunner.save_game_state)
	save_game.close()
	load_button.disabled = false
	load_button.set_focus_mode(2)


func _on_LoadButton_pressed() -> void:
	visible = false
	in_control = false
	StoryRunner.story.state.load_json(StoryRunner.save_game_state)
	StoryRunner.set_inventory()
	StoryRunner.change_scene("load", StoryRunner.story.variables_state.get("current_scene"))


func _on_TitleButton_pressed() -> void:
	StoryRunner.change_scene("MenuTitle", "TitleMenu")
	visible = false
	in_control = false


func _on_ControlsButton_pressed():
	controls.visible = true
	back_button.grab_focus()


func _on_BackButton_pressed():
	controls.visible = false
	resume_button.grab_focus()


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
