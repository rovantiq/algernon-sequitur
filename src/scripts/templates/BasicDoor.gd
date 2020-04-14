extends Area2D


onready var story_ui = StoryRunner.story_ui
onready var inventory_ui = StoryRunner.inventory_ui
onready var ui = $SimpleInteractionUI/InteractionIndicator

onready var anim = $AnimationPlayer

var inside = false
var mouse_hover = false



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept") or (Input.is_action_just_released("left_click") and mouse_hover == true):
		if inside == true and StoryRunner.ui_active == false:
			anim.play("open")



func _on_body_entered(_body: Node) -> void:
	inside = true
	ui.visible = true


func _on_body_exited(_body: Node) -> void:
	inside = false
	ui.visible = false


func _on_mouse_entered() -> void:
	mouse_hover = true
	ui.visible = true


func _on_mouse_exited() -> void:
	mouse_hover = false
	ui.visible = false
