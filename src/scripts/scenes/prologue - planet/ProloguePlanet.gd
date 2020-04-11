extends Node2D


onready var background: Array = $ParallaxBackground.get_children()
onready var ambient_sound: = $AmbientSound
onready var anim: = $AnimationPlayer
onready var player: = $Player
onready var orb: = $Interactions/Orb
onready var look_back: = $Triggers/LookBack


var story

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
	if StoryRunner.player_side_position.x <= 50:
		StoryRunner.player_blocked = "left"
	else:
		StoryRunner.player_blocked = ""


func _stage_cue(_name, _value) -> void:
	pass


func _check_story_state() -> void:
	if story.variables_state.get("looked_back") == 1:
		look_back.queue_free()
	if story.variables_state.get("has_orb") == 1:
		orb.queue_free()
		if story.variables_state.get("time_passed") == 0:
			player.position.x = 750
	if story.variables_state.get("time_passed") == 1:
		player.position.x = 2690
		anim.current_animation = "TimeAdvances"
		anim.seek(60.0, true)
	if story.variables_state.get("intro_complete") == 0:
		StoryRunner.temp_timer(1)
		yield(StoryRunner, "timeout")
		StoryRunner.play_story("opening")
		yield(StoryRunner, "end_story")
		StoryRunner.ui_active = true
		StoryRunner.temp_timer(1)
		yield(StoryRunner, "timeout")
		ambient_sound.play()
		StoryRunner.fade_in()
		yield(StoryRunner, "animation_finished")
		StoryRunner.play_story("prologue_al")
		yield(StoryRunner, "end_story")
		StoryRunner.ui_active = false
	else:
		StoryRunner.fade_in()
		ambient_sound.play()
		StoryRunner.ui_active = false


func _on_LookBack_body_entered(_body: PhysicsBody2D) -> void:
	if looked_back == false:
		StoryRunner.play_story("prologue_al.look_back")
		looked_back = true


func _on_TimeAdvance_body_entered(_body: PhysicsBody2D) -> void:
	anim.play("TimeAdvances")
	StoryRunner.play_story("prologue_al.time_forward")
	yield(StoryRunner, "end_story")
	StoryRunner.player_sidescroll_speed = story.variables_state.get("player_speed")


func _on_End_body_entered(_body: Node) -> void:
	StoryRunner.fade_out()
	StoryRunner.play_story("prologue_al.end")

