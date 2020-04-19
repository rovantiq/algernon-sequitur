extends Node2D



onready var ship: = $Ship
onready var upper_level: = ship.get_node("UpperLevel")
onready var lower_level: = ship.get_node("LowerLevel")
onready var shuttle_bay: = ship.get_node("ShuttleBay")
onready var rens_quarters: = ship.get_node("ShuttleBay")
onready var captains_quarters: = ship.get_node("CaptainsQuarters")
onready var starting_level: Node = ship.get_node("UpperLevel")
onready var player_top: = $PlayerTop
onready var anim_player1: = $AnimationPlayer1
onready var anim_player2: = $AnimationPlayer2
onready var Enri: = load("res://src/characters/Enri/EnriTop.tscn")

onready var enri = $Ship/UpperLevel/EnriTop
onready var mooney = $Ship/UpperLevel/MooneyTop



var story
var left_boundary: = 150
var right_boundary: = 250



func _ready() -> void:
	StoryRunner.ui_active = true
	StoryRunner.curtain.visible = true
	StoryRunner.player_sidescroll_speed = 100
	StoryRunner.player_topdown_speed = 100
	if StoryRunner.loaded != true:
		yield(StoryRunner, "loaded")
	story = StoryRunner.story
	story.observe_variable("stage_cue", self, "_stage_cue")
	if StoryRunner.story_ui.ready == false:
		yield(StoryRunner.story_ui, "ui_ready")
	_check_story_state()


func _process(_delta: float) -> void:
	if StoryRunner.player_side_position.x <= left_boundary:
		StoryRunner.player_blocked = "left"
	elif StoryRunner.player_side_position.x >= right_boundary:
		StoryRunner.player_blocked = "right"
	else:
		StoryRunner.player_blocked = ""


func _stage_cue(_name, value) -> void:
	if value == "cap_leaves":
		anim_player1.play("cap_leaves")
	if value == "enri_approaches":
		anim_player2.play("enri_approaches")
	if value == "enri_leaves":
		anim_player2.play("enri_leaves")
		yield(anim_player2, "animation_finished")
		enri.queue_free()
		enri = Enri.instance()
		captains_quarters.add_child(enri)
		enri.position = Vector2(-45, -350)
		enri.rotation_degrees = 90
		enri.get_node("AnimationPlayer").play("Sit")
	if value == "quit":
		StoryRunner.fade_out()
		yield(StoryRunner, "animation_finished")
		get_tree().quit()


func _check_story_state() -> void:
	if story.variables_state.get("welcomed_home") == 0:
		_set_current_floor("upper")
		StoryRunner.temp_timer(1)
		yield(StoryRunner, "timeout")
		StoryRunner.fade_in()
#		yield(StoryRunner, "animation_finished")
#		StoryRunner.play_story("prologue_ren")
#		yield(StoryRunner, "end_story")
		StoryRunner.play_story("testing2")
		StoryRunner.ui_active = false
	else:
		_set_current_floor("upper")
		mooney.position = Vector2(0, -574)
		mooney.rotation_degrees = 270
		mooney.get_node("AnimationPlayer").play("Sit")
		enri.queue_free()
		enri = Enri.instance()
		captains_quarters.add_child(enri)
		enri.position = Vector2(-45, -350)
		enri.rotation_degrees = 90
		enri.get_node("AnimationPlayer").play("Sit")
		StoryRunner.fade_in()
		StoryRunner.ui_active = false


func _set_current_floor(selected_floor) -> void:
	ship.current_floor = selected_floor
	starting_level.visible = true
	for child in starting_level.get_children():
		child.collision_mask = 1
