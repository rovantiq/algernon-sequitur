extends Sprite

func _ready() -> void:
	material.set_shader_param("direction", Vector2(0.0,-1.0))
	material.set_shader_param("speed_scale",0.0125)
