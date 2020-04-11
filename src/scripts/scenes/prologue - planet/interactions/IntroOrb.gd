extends "res://src/scripts/ui/interactions/InteractionPoint.gd"

onready var fx = get_parent().get_parent().get_node("FX")


var shot = 0



func _ready() -> void:
	_set_name("?")
	options = ["look", "talk", "use", "inv"]


func look_pressed(look) -> void:
	_show_text(look, ["Something shiny half buried in the infernal dust catches Algernon's eye.", "The gleam is still there, slowly collecting new layers of dust."])


func talk_pressed(talk) -> void:
	_clear_option(talk, "talk", "Algernon begins asking it questions without irony. One never knows in this world. It doesn't respond.")


func use_pressed(use) -> void:
	_play_story_and_destroy(use, "prologue_al.item_use")


func item_pressed(item) -> void:
	if item.text == "Gun":
		if shot == 0:
			_show_text(item, ["The bullet thuds into the ground six inches off. Unheard of at point blank range!"])
			fx.stream = load("res://assets/sound/sfx/gunshots/FX_gunshot1_session.wav")
			fx.play()
			shot += 1
		elif shot == 1:
			_show_text(item, ["He gets even closer before firing this time but the bullet lands an inch shy with a weak plop." + "\n" + "Algernon puts the weapon away in anger, unwilling to waste any more bullets."])
			fx.stream = load("res://assets/sound/sfx/gunshots/FX_gunshot1_session.wav")
			fx.play()
			shot += 1
		else:
			_show_text(item, ["Nope."])
	else:
		_show_text(item, ["Nope."])
