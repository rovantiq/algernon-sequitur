extends "res://src/scripts/ui/interactions/InteractionPoint.gd"

onready var music = get_parent().get_node("RensMusic")

var playing = false



func _ready() -> void:
	_set_name("Music Player")
	options = ["look",  "use"]


func look_pressed(look) -> void:
	_show_text(look, ["Ren found this recently. Not many tracks on it."])


func use_pressed(_use) -> void:
	if playing == false:
		music.play()
		playing = true
	else:
		music.stop()
