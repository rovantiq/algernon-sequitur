extends "res://src/scripts/ui/interactions/InteractionPoint.gd"

onready var player_top = get_parent().get_parent().get_parent().get_node("PlayerTop")
onready var lower = get_parent().get_parent().get_node("LowerLevel")
onready var player_side = get_parent().get_node("PlayerSide")
onready var rens_room = get_parent()
onready var top_cam = get_parent().get_parent().get_parent().get_node("PlayerTop/Camera2D")
onready var audio = $DoorFX




func _ready() -> void:
	options = ["go"]


func go_pressed(go) -> void:
	go.set_focus_mode(0)
	interaction_indicator.visible = false
	_clear()
	StoryRunner.fade_out()
	audio.play()
	yield(StoryRunner, "animation_finished")
	player_side.visible = false
	rens_room.visible = false
	player_top.visible = true
	lower.visible = true
	top_cam.current = true
	_clear()
	z_index = 0
	StoryRunner.fade_in()
	StoryRunner.ui_active = false

