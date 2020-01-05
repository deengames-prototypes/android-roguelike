extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	_event_bus = event_bus
	_event_bus.connect("rocket_launcher", self, 'activate')

func activate(source_entity, target: Vector2):
	if source_entity.position != target:
		_event_bus.emit_signal("create_explosion", target, Constants.ROCKET_EXPLOSION_DAMAGE, Constants.ROCKET_EXPLOSION_RADIUS)
		_event_bus.emit_signal("end_turn")
