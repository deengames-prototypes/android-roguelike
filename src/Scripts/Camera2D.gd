extends Camera2D

func center_on(entity):
	global_position = Vector2(entity.x * 32, entity.y * 32)
