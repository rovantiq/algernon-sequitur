extends "res://src/scripts/ui/interactions/InteractionPoint.gd"


onready var cam = get_parent().get_parent().get_parent().get_node("PlayerTop/Camera2D")
onready var player = get_parent().get_parent().get_parent().get_node("PlayerTop")
onready var level = get_parent()


var viewing = false


func _ready() -> void:
	options = ["look"]


func look_pressed(_look) -> void:
	StoryRunner.fade_out()
	yield(StoryRunner,"animation_finished")
	viewing = true
	cam.offset.x = -120
	cam.zoom = Vector2(1.5,1.5)
	cam.limit_bottom = 875
	player.visible = false
	level.visible = false
	StoryRunner.fade_in()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if viewing == true:
			StoryRunner.fade_out()
			yield(StoryRunner,"animation_finished")
			cam.offset.x = 0
			cam.zoom = Vector2(0.25,0.25)
			cam.limit_bottom = 850
			player.visible = true
			level.visible = true
			viewing = false
			StoryRunner.fade_in()
