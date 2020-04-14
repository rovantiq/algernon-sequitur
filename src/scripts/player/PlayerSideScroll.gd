extends KinematicBody2D



onready var anim = $AnimationPlayer
onready var sprite = $Sprite


var motion: Vector2

var target: Vector2
var mouse_hover = false
var clicked: = false



func _process(_delta: float) -> void:
	if visible == true:
		StoryRunner.player_side_position = global_position
		if StoryRunner.ui_active == false:
			update_motion()
		elif StoryRunner.ui_active == true and StoryRunner.cutscene_active == false:
			anim.play("idle")
			clicked = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		if mouse_hover == false:
			target = get_global_mouse_position()
			if abs(global_position.x - target.x) > 15 and StoryRunner.ui_active == false:
				clicked = true
		elif mouse_hover == true and StoryRunner.ui_active == false:
			StoryRunner.inventory_ui.show_inventory()


func update_motion() -> void:
	motion.y = StoryRunner.GRAVITY
	
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") and StoryRunner.player_blocked != "left":
		motion.x = -StoryRunner.player_sidescroll_speed
		sprite.flip_h = true
		anim.play("walk")
		clicked = false
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") and StoryRunner.player_blocked != "right":
		motion.x = StoryRunner.player_sidescroll_speed
		sprite.flip_h = false
		anim.play("walk")
		clicked = false
	elif clicked == true:
		if global_position.x < target.x and abs(global_position.x - target.x) > 5 and StoryRunner.player_blocked != "right":
			sprite.flip_h = false
			anim.play("walk")
			motion.x = StoryRunner.player_sidescroll_speed
		elif global_position.x > target.x and abs(global_position.x - target.x) > 5 and StoryRunner.player_blocked != "left":
			sprite.flip_h = true
			anim.play("walk")
			motion.x = -StoryRunner.player_sidescroll_speed
		else:
			clicked = false
			motion.x = 0
			anim.play("idle")
			if StoryRunner.interaction_ui_clicked == true:
				StoryRunner.clicked_interaction_ui._add_buttons()
	else:
		motion.x = 0
		anim.play("idle")
	
	motion = move_and_slide(motion)



func _on_mouse_entered() -> void:
	mouse_hover = true


func _on_mouse_exited() -> void:
	mouse_hover = false
