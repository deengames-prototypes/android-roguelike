extends "res://Scripts/Ecs/Core/System.gd"

func _init(event_bus):
	event_bus.connect('move_entity', self, 'on_move_entity')

func on_move_entity(entity, x, y):
	if is_empty(x, y):
		entity.x = clamp(x, 0, Constants.TILES_WIDE - 1)
		entity.y = clamp(y, 0, Constants.TILES_HIGH - 1)

func is_empty(x, y):
	for e in entities:
		if e.x == x and e.y == y:
			return false
	return true