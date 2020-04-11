extends Node


onready var curtain = StoryRunner.curtain

var story

func _ready() -> void:
	curtain.visible = true
	StoryRunner.player_can_move = false
	yield(StoryRunner, "loaded")
	story = StoryRunner.story
	story.observe_variable("stage_cue", self, "_stage_cue")
	StoryRunner.fade_in()
	yield(StoryRunner, "animation_finished")
#	StoryRunner.play_story("")
#	StoryRunner.player_can_move = true


#  If it's a side-view scene, use the following to create player boundaries

#func _process(delta: float) -> void:
#	if StoryRunner.player_position.x <= 50:
#		StoryRunner.player_blocked = "left"
#	elif StoryRunner.player_position.x >= 5000:
#		StoryRunner.player_blocked = "right"
#	else:
#		StoryRunner.player_blocked = ""


func _stage_cue(name, value) -> void:
	pass
