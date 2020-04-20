extends Node2D


onready var background: Array = $ParallaxBackground.get_children()
onready var ambient_sound: = $AmbientSound
onready var fx: = $FX
onready var anim: = $AnimationPlayer
onready var player: = $Player
onready var look_back: = $Triggers/LookBack
onready var noticed_stones: = $Triggers/NoticeStones
onready var stones: = $Interactions/Stones
onready var stone_pile: = $Stones
onready var tree: = $Tree
onready var animal_encounter: = $Triggers/AnimalEncounter
onready var animal: = $Interactions/Beast
onready var ledge_approach: = $Triggers/LedgeApproach
onready var look_ahead: = $Triggers/End
onready var camp: = $Interactions/Camp


var stones_taken: = load("res://assets/art/environments/side/objects/prologue-planet/stones-taken.png")
var tree_normal: = load("res://assets/art/environments/side/objects/prologue-planet/tree.png")
var tree_rope: = load("res://assets/art/environments/side/objects/prologue-planet/tree-rope.png")

var stone_throw: = load("res://assets/sound/sfx/misc/stone_throw.wav")
var gun_shot: = load("res://assets/sound/sfx/misc/gunshot_spacey.wav")
var harpoon: = load("res://assets/sound/sfx/misc/harpoon.wav")


var story

var left_limit: = 50
var right_limit = 820




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
	if value == "stone_taken":
		stone_pile.texture = stones_taken
	if value == "rock_thrown":
		animal.visible = false
		animal.collision_mask = 0
		right_limit = 2030
		fx.stream = stone_throw
		fx.play()
	if value == "beast_shot":
		animal.visible = false
		animal.collision_mask = 0
		right_limit = 2030
		fx.stream = gun_shot
		fx.play()
	if value == "harpoon_shot":
		anim.play("HarpoonShot")
	if value == "climb_ledge":
		StoryRunner.fade_out()
		yield(StoryRunner, "animation_finished")
		player.position = Vector2(2125, 72)
		player.get_node("Camera2D").limit_bottom = 120
		left_limit = 2110
		right_limit = 2850
		tree.texture = tree_normal
		StoryRunner.ui_active = true
		StoryRunner.fade_in()
		yield(StoryRunner, "animation_finished")
		StoryRunner.play_story("prologue_al.getting_late")
	if value == "getting_late":
		anim.play("TimeAdvances")
	if value == "looking_for_camp":
		camp.collision_mask = 1
		camp.input_pickable = true
	if value == "camp":
		StoryRunner.fade_out()


func _check_story_state() -> void:
	if story.variables_state.get("looked_back") == 1:
		look_back.queue_free()
	if story.variables_state.get("noticed_stones") == 1:
		noticed_stones.queue_free()
	if story.variables_state.get("has_stones") == 1:
		stones.queue_free()
		stone_pile.texture = stones_taken
		if story.variables_state.get("climbed_ledge") == 0 and story.variables_state.get("animal_gone") == 0:
			player.position = Vector2(718, 229)
	if story.variables_state.get("animal_encountered") == 1:
		animal_encounter.queue_free()
	if story.variables_state.get("animal_gone") == 1:
		animal.queue_free()
		if story.variables_state.get("climbed_ledge") == 0:
			player.position = Vector2(1067, 229)
			right_limit = 2030
	if story.variables_state.get("ledge_approached") == 1:
		ledge_approach.queue_free()
	if story.variables_state.get("shot_harpoon") == 1:
		if story.variables_state.get("climbed_ledge") == 0:
			tree.texture = tree_rope
	if story.variables_state.get("climbed_ledge") == 1:
		player.position = Vector2(2125, 71)
		player.get_node("Camera2D").limit_bottom = 120
		left_limit = 2110
		right_limit = 2850
		anim.play("TimeAdvances")
	if story.variables_state.get("looked_ahead") == 1:
		look_ahead.queue_free()
		camp.collision_mask = 1
		camp.input_pickable = true
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
#		StoryRunner.play_story("testing")
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
