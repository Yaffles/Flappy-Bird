extends Node2D


func _ready():
	pass

func _physics_process(delta):
	position += Vector2(-1.6, 0)
	if get_global_position()[0] < -1450:
		position = Vector2(0, 0)
