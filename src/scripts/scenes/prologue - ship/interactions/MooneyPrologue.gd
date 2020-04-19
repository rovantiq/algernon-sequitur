extends "res://src/scripts/ui/interactions/InteractionPoint.gd"

#  ##########################################
#   INSTANCE AN INTERACTION POINT, THEN SAVE 
#   A NEW COPY OF THIS SCRIPT TO ATTACH AND
#   ADJUST THE FOLLOWING AS NEEDED
#  ##########################################


func _ready() -> void:
	options = ["look", "talk",]        #["look", "talk", "use", "go", "inv"]


func look_pressed(look) -> void:
	_cycle_stories(look, ["prologue_ren.mooney_look", "prologue_ren.mooney_look2", "prologue_ren.mooney_look3"])



func talk_pressed(talk) -> void:
	_clear_option(talk, "talk", "prologue_ren.mooney_talk")








