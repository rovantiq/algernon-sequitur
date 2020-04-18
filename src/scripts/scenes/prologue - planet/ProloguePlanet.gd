extends Node2D


onready var background: Array = $ParallaxBackground.get_children()
onready var ambient_sound: = $AmbientSound
onready var anim: = $AnimationPlayer
onready var player: = $Player
onready var look_back: = $Triggers/LookBack


var story

var left_limit: = 50
var right_limit = 820

var looked_back: = false



func _ready() -> void:
	StoryRunner.ui_active = true
	StoryRunner.curtain.visible = true
	if StoryRunner.loaded != true:
		yield(StoryRunner, "loaded")
	story = StoryRunner.story
	story.observe_variable("stage_cue", self, "_stage_cue")
	if StoryRunner.story_ui.ready == false:
		yield(StoryRunner.story_ui, "ui_ready")
	_check_story_state()


func _process(_delta: float) -> void:
	if StoryRunner.player_side_position.x <= left_limit:
		StoryRunner.player_blocked = "left"
	elif StoryRunner.player_side_position.x >= right_limit:
		StoryRunner.player_blocked = "right"
	else:
		StoryRunner.player_blocked = ""


func _stage_cue(_name, value) -> void:
	if value == "rock_thrown":
		get_node("Interactions/Beast").visible = false
		get_node("Interactions/Beast").collision_mask = 0
		right_limit = 2030
	elif value == "beast_shot":
		get_node("Interactions/Beast").visible = false
		get_node("Interactions/Beast").collision_mask = 0
		right_limit = 2030
	elif value == "climb_ledge":
		StoryRunner.fade_out()
		yield(StoryRunner, "animation_finished")
		player.position = Vector2(2125, 70)
		player.get_node("Camera2D").limit_bottom = 120
		left_limit = 2110
		right_limit = 2850
		StoryRunner.ui_active = true
		StoryRunner.fade_in()
		yield(StoryRunner, "animation_finished")
		StoryRunner.play_story("prologue_al.getting_late")
	elif value == "looking_for_camp":
		get_node("Interactions/Camp").collision_mask = 1
		get_node("Interactions/Camp").input_pickable = true
	elif value == "camp":
		StoryRunner.fade_out()


func _check_story_state() -> void:
	if story.variables_state.get("looked_back") == 1:
		look_back.queue_free()
	if story.variables_state.get("intro_complete") == 0:
#		StoryRunner.temp_timer(1)
#		yield(StoryRunner, "timeout")
#		StoryRunner.play_story("opening")
#		yield(StoryRunner, "end_story")
#		StoryRunner.ui_active = true
#		StoryRunner.temp_timer(1)
#		yield(StoryRunner, "timeout")
#		ambient_sound.play()
		StoryRunner.fade_in()
#		yield(StoryRunner, "animation_finished")
#		StoryRunner.play_story("prologue_al")
#		yield(StoryRunner, "end_story")
		StoryRunner.play_story("testing")
		StoryRunner.ui_active = false
	else:
		StoryRunner.fade_in()
		ambient_sound.play()
		StoryRunner.ui_active = false





#####   TRIGGERS   #####





func _on_LookBack_body_entered(_body: PhysicsBody2D) -> void:
	if story.variables_state.get("looked_back") == 0:
		StoryRunner.play_story("prologue_al.look_back")


func _on_NoticeStones_body_entered(_body):
	if story.variables_state.get("noticed_stones") == 0:
		StoryRunner.play_story("prologue_al.notice_stones")


func _on_AnimalEncounter_body_entered(_body):
	if story.variables_state.get("animal_encountered") == 0:
		StoryRunner.play_story("prologue_al.animal_encounter")


func _on_LedgeApproach_body_entered(_body):
	if story.variables_state.get("ledge_approached") == 0:
		StoryRunner.play_story("prologue_al.ledge_approach")


func _on_End_body_entered(_body: Node) -> void:
	if story.variables_state.get("looked_ahead") == 0:
		StoryRunner.play_story("prologue_al.too_dark")
