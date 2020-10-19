extends Control


signal type
signal done_typing
signal ui_ready

onready var type_timer: = $TypeTimer

var ready: = false

var whitespace_character = "`"
var is_typing: = false
var type_speed: = 0.001
var skip_speed: = 0.0001


func _init() -> void:
	visible = false


func _ready() -> void:
	type_timer.wait_time = type_speed
	ready = true
	emit_signal("ui_ready")


func _process(_delta: float) -> void:
	if visible == true:
		StoryRunner.ui_active = true


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_cancel") or Input.is_action_just_released("right_click"):
		if is_typing == true:
			type_timer.wait_time = skip_speed


func type(text, label) -> void:
	var text_array = []
	for letter in text:
		text_array.append(letter)
	is_typing = true
	if text_array[0] == whitespace_character:
		label.text += "\n"
		yield(self, "type")
	else:
		for item in text_array:
			label.text += item
			yield(self, "type")
	is_typing = false
	type_timer.stop()
	emit_signal("done_typing")


func _on_TypeTimer_timeout() -> void:
	emit_signal("type")
