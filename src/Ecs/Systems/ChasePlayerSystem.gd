extends "res://Ecs/Core/System.gd"

var _player = null
var _rng = RandomNumberGenerator.new()
var _event_bus

func _init(event_bus):
	required_component_types = ["ChasePlayerComponent", "SightComponent"]
	_event_bus = event_bus
	_event_bus.connect("end_turn", self, "on_turn_end")
	_event_bus.connect("set_player", self, "on_set_player")
	
	_rng.randomize()

func on_turn_end():
	if _player == null:
		return
	
	for entity in entities:
		if entity.has("StunnedComponent"):
			continue
		# Move only if player is in monster FOV.
		# Expensive but accurate, assumes few monsters and done once per turn.
		# If this is too expensive, switch to manhattan distance (no sqrt)
		var distance = _player.position.distance_to(entity.position)
		if distance <= entity.get("SightComponent").sight_radius:
			
			var direction = entity.position.direction_to(_player.position)
			var movement = Vector2()
			if abs(direction.x) > abs(direction.y):
				movement.x = sign(direction.x)
			else:
				movement.y = sign(direction.y)
			_event_bus.emit_signal("move_entity", entity, entity.position + movement)

func on_set_player(player):
	_player = player
