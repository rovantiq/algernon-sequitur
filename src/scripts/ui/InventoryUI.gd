extends Control


onready var ItemBox: = load("res://src/ui/inventory/ItemBox.tscn")

onready var story_ui = StoryRunner.story_ui
onready var menu_ui = StoryRunner.menu_ui


onready var item_hbox: = $InventoryHBox


var in_control = false
var mouse_hover = false

var combo: Array = []

var item_dict: Dictionary = {
	"Gun": ["res://assets/art/icons/gun.svg", "Bella."],
	"Drugs": ["res://assets/art/icons/drugs.svg", "Not much left..."],
	"Water": ["res://assets/art/icons/water.svg", "Some water."],
	"Dirty Orb": ["res://assets/art/icons/gold-shell.svg", "Interesting, but covered in grit."],
	"Clean Orb": ["res://assets/art/icons/gold-shell.svg", "Maybe some sort of key?"],
	"Rations": ["", "Ren insisted."],
	"Gear": ["", "Always be prepared!"]
}



func _init() -> void:
	visible = false


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_select"):
		if StoryRunner.ui_active == false:
			show_inventory()
		elif StoryRunner.ui_active == true:
			if in_control == true and story_ui.visible == false:
				_select_item()
	if Input.is_action_just_released("ui_cancel"):
		if in_control == true and story_ui.visible == false:
			_clear()
			if visible == true:
				visible = false
				combo = []
				StoryRunner.ui_active = false
				in_control = false
	if Input.is_action_just_released("right_click"):
		if in_control == true and story_ui.visible == false:
			if mouse_hover == true:
				_select_item()
			elif mouse_hover == false:
				_clear()
				if visible == true:
					visible = false
					combo = []
					StoryRunner.ui_active = false
					in_control = false




func show_inventory() -> void:
	StoryRunner.ui_active = true
	in_control = true
	if StoryRunner.inventory.size() > 0 and StoryRunner.inventory[0] != "Nothing" and StoryRunner.inventory[0] != "":
		_update_inventory()
		visible = true
		if Input.is_action_just_pressed("ui_select"):
			item_hbox.get_child(0).get_node("Button").grab_focus()
	else:
		StoryRunner.show_text("You aren't carrying anything.")
		yield(StoryRunner, "end_story")
		StoryRunner.ui_active = false
		in_control = false




func _clear() -> void:
	for item_box in item_hbox.get_children():
		item_box.queue_free()


func _update_inventory() -> void:
	for item in StoryRunner.inventory:
		var item_box = ItemBox.instance()
		var button = item_box.get_node("Button")
		item_box.get_node("VBoxContainer/Label").text = item
		if item_dict.has(item):
			if item_dict[item][0] != "":
				item_box.get_node("VBoxContainer/TextureRect").texture = load(item_dict[item][0])
		button.connect("pressed", self, "_inv_item_pressed", [item, button])
		button.connect("mouse_entered", self, "_inv_item_mouse_entered", [button])
		button.connect("mouse_exited", self, "_inv_item_mouse_exited", [button])
		item_hbox.add_child(item_box)


func _inv_item_pressed(item, button) -> void:
	if item_dict.has(item):
		button.set_focus_mode(0)
		StoryRunner.show_text(item_dict[item][1])
		yield(StoryRunner, "end_story")
		button.set_focus_mode(2)
		button.grab_focus()
		if button.toggle_mode == true:
			button.pressed = true


func _inv_item_mouse_entered(button) -> void:
	mouse_hover = true
	button.grab_focus()


func _inv_item_mouse_exited(_button) -> void:
	mouse_hover = false


func _select_item() -> void:
	for item_box in item_hbox.get_children():
		var button = item_box.get_node("Button")
		var text = item_box.get_node("VBoxContainer/Label").text
		if button.has_focus():
			if combo.size() == 0:
				button.toggle_mode = true
				button.pressed = true
				combo.append(text)
			elif combo.size() == 1:
				combo.append(text)
				_check_combo()
				_clear()
				mouse_hover = false
				yield(StoryRunner, "end_story")
				StoryRunner.ui_active = true
				combo = []
				_update_inventory()
				item_hbox.get_child(0).get_node("Button").grab_focus()
				break


func _check_combo() -> void:
	if combo.has("Water") and combo.has("Dirty Orb"):
		StoryRunner.play_story("combine_water_dirtyorb")
	else:
		StoryRunner.show_text("That doesn't accomplish anything.")
