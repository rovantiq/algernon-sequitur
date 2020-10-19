extends Node

# ############################################################################ 
# Imports
# ############################################################################ 

var InkRuntime: = load("res://addons/inkgd/runtime.gd")
var Story: = load("res://addons/inkgd/runtime/story.gd")

var UI: = load("res://src/ui/UI.tscn")
var Stage: = load("res://src/story/Stage.tscn")

var LineLabel: = load("res://src/ui/story/Label.tscn")
var ChoiceContainer: = load("res://src/ui/story/ChoiceContainer.tscn")
var ChoiceButton: = load("res://src/ui/story/ChoiceButton.tscn")

# ############################################################################ 
# Node
# ############################################################################ 

onready var ui = UI.instance()
onready var stage = Stage.instance()
onready var story_ui = ui.get_node("StoryUI")
onready var story_container = ui.get_node("StoryUI/StoryContainer")
onready var story_vbox = ui.get_node("StoryUI/StoryContainer/StoryVBoxContainer")
onready var type_timer = ui.get_node("StoryUI/TypeTimer")
onready var inventory_ui = ui.get_node("InventoryUI")
onready var menu_ui = ui.get_node("MenuUI")
onready var curtain = ui.get_node("Curtain")
onready var anim_player = ui.get_node("AnimationPlayer")

# ############################################################################ 
# Signals
# ############################################################################ 

signal loaded
signal saves_read
signal stage_set
signal start_story
signal end_story
signal animation_finished
signal scene_changed
signal timeout

# ############################################################################ 
# Public Properties
# ############################################################################ 

var _loading_thread

var story

var new_game_state: String
var save_game_state: String = ""
var inventory: Array

var ui_active: = false
var interaction_ui_hover: = false
var interaction_ui_clicked: = false
var clicked_interaction_ui: Node
var current_interaction_ui: Node

var GRAVITY: = 400

var player_sidescroll_speed: = 100
var player_topdown_speed: = 100
var player_side_position: Vector2 = Vector2(0, 0)
var player_blocked: String = ""

var loaded: = false
var saves_read = false
var stage_set: = false
var cutscene_active: = false

# ############################################################################ 
# Private Properties
# ############################################################################ 


var _current_choice_container
var _reset_position: = Vector2(960, 150)

# ############################################################################ 
# Lifecycle
# ############################################################################ 



func _ready():
	call_deferred("_init_story")
	yield(self, "loaded")
	new_game_state = story.state.to_json()
	var save_game = File.new()
	if save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.READ)
		save_game_state = save_game.get_var()
		save_game.close()
	emit_signal("saves_read")
	saves_read = true
	loaded = true
	set_inventory()
	story.observe_variable("player_inventory", self, "_update_inventory")
	story.observe_variable("scene_transition", self, "change_scene")
	_set_stage()
	yield(self, "stage_set")
	get_tree().set_current_scene(stage)
	story.variables_state.get("looked_back")


func _exit_tree():
	call_deferred("_remove_runtime")


# ############################################################################ 
# Public Methods
# ############################################################################ 



func play_story(section) -> void:
	ui_active = true
	if story_ui.visible == false:
		story_ui.visible = true
	story.choose_path_string(section)
	_continue_story()


func show_text(text) -> void:
	_clear()
	emit_signal("start_story")
	ui_active = true
	if story_ui.visible == false:
		story_ui.visible = true
	var label = LineLabel.instance()
	story_vbox.add_child(label)
	type_timer.start()
	story_ui.type(text, label)
	yield(story_ui, "done_typing")
	label.text = text
	_current_choice_container = ChoiceContainer.instance()
	story_vbox.add_child(_current_choice_container)
	var button = ChoiceButton.instance()
	button.text = "-x-"
	button.set_text_align(1)
	var choice_vbox = _current_choice_container.get_node("ChoiceVBoxContainer")
	button.connect("pressed", self, "_close_text")
	choice_vbox.add_child(button)
	choice_vbox.get_child(0).grab_focus()


func change_scene(_name, value) -> void:
	if curtain.color != Color("000000"):
		fade_out()
		yield(self, "animation_finished")
	_swap_set(value)
	emit_signal("scene_changed")


func set_inventory() -> void:
	inventory = story.variables_state.get("player_inventory").to_string().replace(" ", "").replace("_", " ").split(",")


func fade_in() -> void:
	anim_player.play("fade_in")
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	emit_signal("animation_finished")


func fade_out() -> void:
	anim_player.play("fade_out")
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	emit_signal("animation_finished")


func temp_timer(seconds):
	var t = Timer.new()
	t.set_wait_time(seconds)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	emit_signal("timeout")


# ############################################################################
# Private Methods
# ############################################################################ 


func _init_story() -> void:
	_add_runtime()
	_load_story("res://src/story/story.json")
	emit_signal("loaded")


func _set_stage() -> void:
	stage.add_child(ui)
	var current_scene = get_tree().get_current_scene()
	get_tree().get_root().call_deferred("remove_child", current_scene)
	get_tree().get_root().call_deferred("add_child", stage)
	stage.call_deferred("add_child", current_scene)
	emit_signal("stage_set")
	stage_set = true


func _load_story(file_path) -> void:
	var file = File.new()
	file.open(file_path, file.READ)
	var file_text = file.get_as_text()
	file.close()

	story = Story.new(file_text)


func _continue_story():
	_clear()
	emit_signal("start_story")
	var label = LineLabel.instance()
	story_vbox.add_child(label)
	while story.can_continue:
		var text = story.continue()
		if type_timer.wait_time < story_ui.type_speed:
			var text_array = []
			for letter in text:
				text_array.append(letter)
			if text_array[0] == story_ui.whitespace_character:
				label.text += "\n"
			else:
				label.text += text
		else:
			type_timer.start()
			if text != "" and text != "\n":
				story_ui.type(text, label)
				yield(story_ui, "done_typing")
	label.text = label.text.strip_edges()
	if story.current_choices.size() > 0 and story_ui.is_typing == false:
		_current_choice_container = ChoiceContainer.instance()
		story_vbox.add_child(_current_choice_container)
		_current_choice_container.create_choices(story.current_choices)
		_current_choice_container.connect("choice_selected", self, "_choice_selected")
	else:
		if cutscene_active == false:
			ui_active = false
		story_ui.visible = false
		_clear()
		emit_signal("end_story")


func _choice_selected(index) -> void:
	_clear()
	type_timer.wait_time = story_ui.type_speed
	story.choose_choice_index(index)
	_continue_story()


func _close_text() -> void:
	if inventory_ui.visible == false:
		ui_active = false
	story_ui.visible = false
	_clear()
	emit_signal("end_story")
	type_timer.wait_time = story_ui.type_speed


func _clear() -> void:
	for child in story_vbox.get_children():
		story_vbox.remove_child(child)
		child.queue_free()
	story_container.rect_size = Vector2(0, 0)
	story_container.rect_position = _reset_position


func _update_inventory(_name, value) -> void:
	inventory = value.to_string().replace(" ", "").replace("_", " ").split(",")


func _swap_set(value) -> void:
	var current_scene = stage.get_child(stage.get_child_count() - 1)
	stage.call_deferred("remove_child", current_scene)
	current_scene.call_deferred("free")
	var new_scene_resource = load("res://src/scenes/" + value + ".tscn")
	var new_scene = new_scene_resource.instance()
	stage.call_deferred("add_child", new_scene)
	emit_signal("stage_set")


func _add_runtime():
	InkRuntime.init(get_tree().root)

func _remove_runtime():
	InkRuntime.deinit(get_tree().root)
