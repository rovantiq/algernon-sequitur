extends "res://src/scripts/ui/interactions/InteractionPoint.gd"


onready var player_top = get_parent().get_parent().get_parent().get_parent().get_node("PlayerTop")
onready var lower = get_parent().get_parent()
onready var player_side = get_parent().get_parent().get_parent().get_node("RensQuarters/PlayerSide")
onready var rens_room = get_parent().get_parent().get_parent().get_node("RensQuarters")
onready var room_cam = get_parent().get_parent().get_parent().get_node("RensQuarters/Camera2D")
onready var ship_cam = get_parent().get_parent().get_parent().get_parent().get_node("PlayerTop/Camera2D")
onready var audio = $DoorFX




func _ready() -> void:
	options = ["look", "go"]


func look_pressed(look) -> void:
	_clear_option(look, "look", "Ren's current little corner of the galaxy.")


func go_pressed(go) -> void:
	go.set_focus_mode(0)
	interaction_indicator.visible = false
	_clear()
	StoryRunner.fade_out()
	audio.play()
	yield(StoryRunner, "animation_finished")
	player_top.visible = false
	lower.visible = false
	player_side.visible = true
	rens_room.visible = true
	room_cam.current = true
	_clear()
	z_index = 0
	StoryRunner.fade_in()
	StoryRunner.ui_active = false
