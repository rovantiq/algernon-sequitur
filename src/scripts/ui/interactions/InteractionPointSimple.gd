extends Area2D


onready var story_ui = StoryRunner.story_ui
onready var inventory_ui = StoryRunner.inventory_ui

onready var interaction_ui = $SimpleInteractionUI
onready var interaction_indicator = interaction_ui.get_node("InteractionIndicator")




var count: = 0
var inside: = false
var mouse_hover = false

var indicator_text: = ""


#func _ready() -> void:                              
#	_set_name("name")                            # optionally sets text that appears on the indicator in code


# ############################## #
#     STATIC FUNCTIONS BELOW     #
# ############################## #



func _show_text(text) -> void:
	StoryRunner.show_text(text[count])
	yield(StoryRunner, "end_story")
	if count < text.size() - 1:
		count += 1
	else:
		count = 0


func _show_text_and_destroy(text) -> void:
	StoryRunner.show_text(text)
	queue_free()


func _play_story(text) -> void:
	StoryRunner.play_story(text)
	yield(StoryRunner, "end_story")


func _play_story_and_destroy(text) -> void:
	StoryRunner.play_story(text)
	queue_free()


func _set_name(name) -> void:
	interaction_indicator.text = name


func _transition(scene) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(scene)


func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.visible == true:
		if StoryRunner.current_interaction_ui != null:
			if StoryRunner.current_interaction_ui != interaction_ui:
				StoryRunner.current_interaction_ui.visible = false
		StoryRunner.current_interaction_ui = interaction_ui
		inside = true
		interaction_indicator.visible = true


func _on_body_exited(_body: PhysicsBody2D) -> void:
	inside = false
	interaction_indicator.visible = false
	if StoryRunner.current_interaction_ui == interaction_ui:
		StoryRunner.current_interaction_ui = null


func _on_mouse_entered() -> void:
	mouse_hover = true


func _on_mouse_exited() -> void:
	mouse_hover = false


func _on_StoryRunner_start_story() -> void:
	if inside == true:
		interaction_indicator.visible = false


func _on_StoryRunner_end_story() -> void:
	if inside == true and StoryRunner.current_interaction_ui != null:
		StoryRunner.current_interaction_ui.visible = true
