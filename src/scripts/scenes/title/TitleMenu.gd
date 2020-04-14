extends CanvasLayer


onready var options: = $Options
onready var title_card: = $TitleCard
onready var load_button: = $Options/LoadButton
onready var new_button: = $Options/NewButton

var loading: = false


func _ready() -> void:
	options.visible = false
	StoryRunner.ui_active = true
	if StoryRunner.saves_read == false:
		yield(StoryRunner, "saves_read")
	if StoryRunner.save_game_state == "":
		load_button.disabled = true
		load_button.set_focus_mode(0)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept") or Input.is_action_just_released("ui_cancel") or Input.is_action_just_released("ui_select"):
		if options.visible == false and loading == false:
			options.visible = true
			new_button.grab_focus()
	if Input.is_action_just_released("left_click"):
		if options.visible == false and loading == false:
			options.visible = true


func _on_NewButton_pressed() -> void:
	loading = true
	StoryRunner.story.state.load_json(StoryRunner.new_game_state)
	StoryRunner.curtain.visible = true
	title_card.visible = false
	options.visible = false
	StoryRunner.change_scene("new", "ProloguePlanet")


func _on_LoadButton_pressed() -> void:
	loading = true
	StoryRunner.story.state.load_json(StoryRunner.save_game_state)
	StoryRunner.curtain.visible = true
	StoryRunner.set_inventory()
	title_card.visible = false
	options.visible = false
	StoryRunner.change_scene("load", StoryRunner.story.variables_state.get("current_scene"))


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
