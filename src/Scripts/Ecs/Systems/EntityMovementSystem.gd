extends "res://Scripts/Ecs/Core/System.gd"

func on_move_entity(entity, x, y):
	if is_empty(x, y):
		entity.x = clamp(x, 0, Constants.TILES_WIDE - 1)
		entity.y = clamp(y, 0, Constants.TILES_HIGH - 1)

func get_entities_on(x, y):
	var ret = []
	for e in entities:
		if e.x == x and e.y == y:
			ret.append(e)
	return ret

func is_empty(x, y):
	return len(get_entities_on(x, y)) == 0