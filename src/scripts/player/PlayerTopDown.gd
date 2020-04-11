extends KinematicBody2D



onready var anim = $AnimationPlayer

var motion: Vector2

var target: Vector2
var mouse_hover = false
var clicked: = false




func _process(delta: float) -> void:
	if visible == true:
		if StoryRunner.ui_active == false:
			update_motion()
			motion = move_and_slide(motion) * delta
			if motion.x != 0 or motion.y != 0:
				if anim.is_playing() != true:
					anim.play("walk")
			else:
				anim.play("idle")
		elif StoryRunner.ui_active == true and StoryRunner.cutscene_active == false:
			anim.play("idle")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		if mouse_hover == false:
			target = get_global_mouse_position()
			if target.distance_to(global_position) > 15 and StoryRunner.ui_active == false:
				clicked = true
			else:
				clicked = false
		elif mouse_hover == true and StoryRunner.ui_active == false:
			StoryRunner.inventory_ui.show_inventory()


func update_motion() -> void:
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = -StoryRunner.player_topdown_speed
		clicked = false
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = StoryRunner.player_topdown_speed
		clicked = false
	else:
		motion.y = 0
	
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -StoryRunner.player_topdown_speed
		clicked = false
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = StoryRunner.player_topdown_speed
		clicked = false
	else:
		motion.x = 0
	
	if clicked == true:
		if target.distance_to(global_position) > 5:
			if StoryRunner.interaction_ui_clicked == true:
				if StoryRunner.clicked_interaction_ui.inside == false:
					motion = (target - position).normalized() * StoryRunner.player_topdown_speed
				else:
					StoryRunner.clicked_interaction_ui._add_buttons()
					clicked = false
					motion = Vector2(0,0)
			else:
				motion = (target - position).normalized() * StoryRunner.player_topdown_speed
		else:
			clicked = false
			motion = Vector2(0,0)

	
	look_at(get_global_position() + motion)


func _on_mouse_entered() -> void:
	mouse_hover = true


func _on_mouse_exited() -> void:
	mouse_hover = false
