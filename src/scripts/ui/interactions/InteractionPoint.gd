extends Area2D


onready var LookButton = load("res://src/ui/interactions/LookButton.tscn")
onready var TalkButton = load("res://src/ui/interactions/TalkButton.tscn")
onready var UseButton = load("res://src/ui/interactions/UseButton.tscn")
onready var GoButton = load("res://src/ui/interactions/GoButton.tscn")
onready var InvButton = load("res://src/ui/interactions/InvButton.tscn")
onready var ItemButton = load("res://src/ui/interactions/ItemButton.tscn")


onready var story_ui = StoryRunner.story_ui
onready var inventory_ui = StoryRunner.inventory_ui
onready var menu_ui = StoryRunner.menu_ui


onready var interaction_ui = $InteractionUI
onready var interaction_indicator = $InteractionUI/InteractionIndicator
onready var option_hbox = $InteractionUI/OptionHBoxContainer


signal cleared


var look_button
var talk_button
var use_button
var go_button
var inv_button
var item_container
var item_container_active = false
var in_control = false
var mouse_hover = false


var count: = 0
var last_button
var inside: = false

var indicator_text: = ""
var options: Array  = []            # This controls what interaction options appear in the menu, alter it with _init()





func _ready() -> void:
#	_set_name("name")                # optionally set text that appears on the indicator in code
	options = []                     # options = ["look", "talk", "use", "go", "inv"] shows all of them


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_accept") or (Input.is_action_just_released("left_click") and mouse_hover == true):
		if StoryRunner.ui_active == false and interaction_indicator.visible == true and option_hbox.get_child_count() == 0:
			if inside == true:
				_add_buttons()
			else:
				StoryRunner.interaction_ui_clicked = true
				StoryRunner.clicked_interaction_ui = self
	if Input.is_action_just_released("ui_cancel") or Input.is_action_just_released("right_click"):
		if in_control == true and story_ui.visible == false:
			if interaction_indicator.visible == true and item_container_active == true:
				for item in item_container.get_children():
					item.queue_free()
				item_container_active = false
				_enable_buttons()
				if Input.is_action_just_released("ui_cancel"):
					option_hbox.get_child(option_hbox.get_child_count() -1).grab_focus()
			elif interaction_indicator.visible == true and item_container_active == false:
				_clear()
				z_index = 0
				StoryRunner.ui_active = false
				in_control = false







func look_pressed(look) -> void:
	_show_text(look, ["", ""])                      # Insert an array of strings for _show_text(). It will cycle through reponses if it has more than one.
#	_play_story(look, "knot")                       # Or insert a string for an ink knot if you need to _play_story
#	_clear_option(look, "look", "")


func talk_pressed(talk) -> void:
#	_show_text(talk, ["", ""])
#	_play_story(talk, "knot")
	_clear_option(talk, "talk", "It doesn't respond.")     # _clear_option destroys the button and removes the option (2nd arg) from this object. The last arg is sent to a _show_text() call


func use_pressed(use) -> void:                      # _play_story and _play_story_and_destroy play a story segment via Ink
	_play_story_and_destroy(use, "next story")           # _play_story_and_destroy (and _show_text_and_destroy) destroy this object when they're done
#	_show_text(use, ["", ""])
#	_play_story(use, "knot")                        # Don't add items to the inventory from here as it's handled in Ink during the relevant story knot


func item_pressed(item) -> void:
	if item.text == "Correct Item":                 # This plays the next story beat on a successful choice and 
		_play_story_and_destroy(item, "next_story")       # destroys the interaction point as the story runner takes over
#	elif item.text == "another item":             
#		_show_text(item, ["text1", "text2"])        # Optional secondary item response
	else:                                          
		_show_text(item, ["Doesn't work.", "Nope."])# Fallback text here (remember it needs to be an array)


#func go_pressed(go) -> void:
#	_transition(go, "new_scene")  # Just the scene name here, no path or filetype since StoryRunner.change_scene() handles that





# ###############################
#   STATIC FUNCTIONS BELOW
# ###############################


func _add_buttons() -> void:
	_clear()
	z_index = 100
	StoryRunner.ui_active = true
	StoryRunner.interaction_ui_clicked = false
	in_control = true
	if options.has("look"):
		look_button = LookButton.instance()
		option_hbox.add_child(look_button)
		look_button.connect("pressed", self, "look_pressed", [look_button])
		look_button.connect("mouse_entered", self, "_option_mouse_entered", [look_button])
		look_button.connect("mouse_exited", self, "_option_mouse_exited", [look_button])
	if options.has("talk"):
		talk_button = TalkButton.instance()
		option_hbox.add_child(talk_button)
		talk_button.connect("pressed", self, "talk_pressed", [talk_button])
		talk_button.connect("mouse_entered", self, "_option_mouse_entered", [talk_button])
		talk_button.connect("mouse_exited", self, "_option_mouse_exited", [talk_button])
	if options.has("use"):
		use_button = UseButton.instance()
		option_hbox.add_child(use_button)
		use_button.connect("pressed", self, "use_pressed", [use_button])
		use_button.connect("mouse_entered", self, "_option_mouse_entered", [use_button])
		use_button.connect("mouse_exited", self, "_option_mouse_exited", [use_button])
	if options.has("go"):
		go_button = GoButton.instance()
		option_hbox.add_child(go_button)
		go_button.connect("pressed", self, "go_pressed", [go_button])
		go_button.connect("mouse_entered", self, "_option_mouse_entered", [go_button])
		go_button.connect("mouse_exited", self, "_option_mouse_exited", [go_button])
	if options.has("inv") and StoryRunner.inventory.size() > 0 and StoryRunner.inventory[0] != "Nothing" and StoryRunner.inventory[0] != "":
		inv_button = InvButton.instance()
		option_hbox.add_child(inv_button)
		inv_button.connect("pressed", self, "_inv_pressed", [inv_button])
		inv_button.connect("mouse_entered", self, "_option_mouse_entered", [inv_button])
		inv_button.connect("mouse_exited", self, "_option_mouse_exited", [inv_button])
	if Input.is_action_just_released("ui_accept"):
		option_hbox.get_child(0).grab_focus()


func _inv_pressed(inv) -> void:
	_disable_buttons()
	item_container = inv.get_node("ItemVBoxContainer")
	item_container_active = true
	for item in StoryRunner.inventory:
		var button = ItemButton.instance()
		button.text = item
		if inventory_ui.item_dict.has(item) and inventory_ui.item_dict[item][0] != "":
				button.icon = load(inventory_ui.item_dict[item][0])
		button.connect("pressed", self, "item_pressed", [button])
		button.connect("mouse_entered", self, "_option_mouse_entered", [button])
		button.connect("mouse_exited", self, "_option_mouse_exited", [button])
		item_container.add_child(button)
	if Input.is_action_just_released("ui_accept"):
		item_container.get_child(0).grab_focus()


func _clear():
	for button in option_hbox.get_children():
		option_hbox.remove_child(button)
		button.queue_free()
		emit_signal("cleared")


func _disable_buttons() -> void:
	for option in option_hbox.get_children():
		option.disabled = true
		option.set_focus_mode(0)


func _enable_buttons() -> void:
	for option in option_hbox.get_children():
		option.disabled = false
		option.set_focus_mode(2)




func _show_text(button, text) -> void:
	if button != last_button:
		count = 0
	last_button = button
	button.set_focus_mode(0)
	StoryRunner.show_text(text[count])
	yield(StoryRunner, "end_story")
	StoryRunner.ui_active = true
	if count < text.size() - 1:
		count += 1
	else:
		count = 0
	button.set_focus_mode(2)
	button.grab_focus()


func _show_text_and_destroy(button, text) -> void:
	button.set_focus_mode(0)
	StoryRunner.show_text(text)
	StoryRunner.ui_active = false
	queue_free()


func _play_story(button, text) -> void:
	button.set_focus_mode(0)
	StoryRunner.play_story(text)
	yield(StoryRunner, "end_story")
	StoryRunner.ui_active = true
	button.set_focus_mode(2)
	button.grab_focus()


func _play_story_and_end(button, text) -> void:
	button.set_focus_mode(0)
	_clear()
	z_index = 0
	StoryRunner.ui_active = false
	in_control = false
	StoryRunner.play_story(text)


func _play_story_and_destroy(button, text) -> void:
	button.set_focus_mode(0)
	StoryRunner.play_story(text)
	yield(StoryRunner, "end_story")
	StoryRunner.ui_active = false
	queue_free()


func _clear_option(button, option, text) -> void:
	StoryRunner.show_text(text)
	option_hbox.remove_child(button)
	options.erase(option)
	button.queue_free()
	yield(StoryRunner, "end_story")
	StoryRunner.ui_active = true
	option_hbox.get_child(0).grab_focus()



func _set_name(name) -> void:
	interaction_indicator.text = name


func _transition(button, scene) -> void:
	button.set_focus_mode(0)
	StoryRunner.ui_active = false
	StoryRunner.change_scene("go", scene)  # Pretty sure the 1st arg shouldn't matter, it's there to be a dummy for the Ink variable observer's (unused) 1st arg that's sent when script changes scenes.



func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.visible == true:
		if StoryRunner.current_interaction_ui != null:
			if StoryRunner.current_interaction_ui != interaction_indicator:
				StoryRunner.current_interaction_ui.visible = false
		StoryRunner.current_interaction_ui = interaction_indicator
		inside = true
		interaction_indicator.visible = true


func _on_body_exited(_body: PhysicsBody2D) -> void:
	inside = false
	interaction_indicator.visible = false
	if StoryRunner.current_interaction_ui == interaction_indicator:
		StoryRunner.current_interaction_ui = null


func _on_mouse_entered() -> void:
	if StoryRunner.ui_active == false and mouse_hover == false and inside == false and interaction_indicator.visible == false:
		interaction_indicator.visible = true


func _on_mouse_exited() -> void:
	if StoryRunner.ui_active == false and mouse_hover == false and inside == false and interaction_indicator.visible == true:
		interaction_indicator.visible = false


func _on_InteractionIndicator_mouse_entered() -> void:
	mouse_hover = true
	StoryRunner.interaction_ui_hover = true


func _on_InteractionIndicator_mouse_exited() -> void:
	mouse_hover = false
	StoryRunner.interaction_ui_hover = false
	if inside == false and StoryRunner.ui_active == false:
		interaction_indicator.visible = false


func _option_mouse_entered(button) -> void:
	button.grab_focus()


func _option_mouse_exited(_button) -> void:
	pass


func _on_StoryRunner_start_story() -> void:
	if inside == true:
		interaction_indicator.visible = false


func _on_StoryRunner_end_story() -> void:
	if inside == true and StoryRunner.current_interaction_ui != null:
		StoryRunner.current_interaction_ui.visible = true
