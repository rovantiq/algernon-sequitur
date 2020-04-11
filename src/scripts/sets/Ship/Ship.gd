extends Node2D


onready var bay: = $ShuttleBay
onready var upper: = $UpperLevel
onready var mid: = $CaptainsQuarters
onready var lower: = $LowerLevel

onready var transition_bay: = $Transitions/ShuttleBay
onready var transition_cq: = $Transitions/CaptainsQuarters
onready var transition_fore: = $Transitions/Fore
onready var transition_aft: = $Transitions/Aft


var current_floor: = ""
var transition_pause: = false


func _on_ShuttleBay_body_entered(_body: Node) -> void:
	if transition_pause == false:
		if current_floor == "bay":
			bay.visible = false
			for child in bay.get_children():
				child.collision_mask = 0
			upper.visible = true
			for child in upper.get_children():
				child.collision_mask = 1
			current_floor = "upper"
		elif current_floor == "upper":
			upper.visible = false
			for child in upper.get_children():
				child.collision_mask = 0
			bay.visible = true
			for child in bay.get_children():
				child.collision_mask = 1
			current_floor = "bay"
	transition_pause = true
	StoryRunner.temp_timer(1)
	yield(StoryRunner, "timeout")
	transition_pause = false


func _on_CaptainsQuarters_body_entered(_body: Node) -> void:
	if current_floor == "upper":
		upper.visible = false
		for child in upper.get_children():
			child.collision_mask = 0
		mid.visible = true
		for child in mid.get_children():
			child.collision_mask = 1
		current_floor = "mid"
	elif current_floor == "mid":
		mid.visible = false
		for child in mid.get_children():
			child.collision_mask = 0
		upper.visible = true
		for child in upper.get_children():
			child.collision_mask = 1
		current_floor = "upper"


func _on_Fore_body_entered(_body: Node) -> void:
	if current_floor == "upper":
		upper.visible = false
		for child in upper.get_children():
			child.collision_mask = 0
		lower.visible = true
		for child in lower.get_children():
			child.collision_mask = 1
		current_floor = "lower"
	elif current_floor == "lower":
		lower.visible = false
		for child in lower.get_children():
			child.collision_mask = 0
		upper.visible = true
		for child in upper.get_children():
			child.collision_mask = 1
		current_floor = "upper"


func _on_Aft_body_entered(_body: Node) -> void:
	if current_floor == "upper":
		upper.visible = false
		for child in upper.get_children():
			child.collision_mask = 0
		lower.visible = true
		for child in lower.get_children():
			child.collision_mask = 1
		current_floor = "lower"
	elif current_floor == "lower":
		lower.visible = false
		for child in lower.get_children():
			child.collision_mask = 0
		upper.visible = true
		for child in upper.get_children():
			child.collision_mask = 1
		current_floor = "upper"

