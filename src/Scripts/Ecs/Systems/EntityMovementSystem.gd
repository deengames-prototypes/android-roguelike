extends "res://Scripts/Ecs/Core/System.gd"

func on_move_entity(entity, x, y):
	entity.x = clamp(x, 0, Constants.TILES_WIDE - 1)
	entity.y = clamp(y, 0, Constants.TILES_HIGH - 1)
