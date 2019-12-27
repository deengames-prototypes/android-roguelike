extends "res://Scripts/Ecs/Core/System.gd"

func _init(event_bus):
	event_bus.connect('move_entity', self, 'on_move_entity')

func on_move_entity(entity, new_position):
	if is_empty(new_position):
		entity.position.x = clamp(new_position.x, 0, Constants.TILES_WIDE - 1)
		entity.position.y = clamp(new_position.y, 0, Constants.TILES_HIGH - 1)

func is_empty(pos):
	for e in entities:
		if e.position == pos:
			return false
	return true