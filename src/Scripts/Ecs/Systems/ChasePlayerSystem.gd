extends "res://Scripts/Ecs/Core/System.gd"

var _player = null
var _rng = RandomNumberGenerator.new()
var _event_bus

func _init(event_bus):
	required_component_types = ["ChasePlayerComponent"]
	_event_bus = event_bus
	_event_bus.connect("end_turn", self, "on_turn_end")
	# connect to spawn entity to get a reference to player entity
	_event_bus.connect("spawn_entity", self, "on_spawn_entity")
	
	_rng.randomize()

func on_turn_end():
	if _player == null:
		return
	
	for entity in entities:
		var direction = entity.position.direction_to(_player.position)
		if abs(direction.x) > abs(direction.y):
			_event_bus.emit_signal("move_entity", entity, entity.position.x + sign(direction.x), entity.position.y)
		else:
			_event_bus.emit_signal("move_entity", entity, entity.position.x, entity.position.y + sign(direction.y))

func on_spawn_entity(entity):
	if entity.has("PlayerMovementComponent"):
		_player = entity