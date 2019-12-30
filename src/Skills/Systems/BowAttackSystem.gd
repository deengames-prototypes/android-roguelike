extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	required_component_types = ["HealthComponent"]
	_event_bus = event_bus
	_event_bus.connect("bow_attack", self, 'activate')

func activate(source, target: Vector2):
	# TODO: ensure line of sight
	var target_entity = _get_entity_at(target)
	if target_entity != null and not source == target_entity:
		var damage = Constants.BOW_BASE_DAMAGE
		var distance = int(source.position.distance_to(target)) - 1
		damage -= Constants.BOW_DAMAGE_LOSS_PER_DISTANCE_UNIT * distance
		_event_bus.emit_signal("damage_entity", target_entity, damage)
		_event_bus.emit_signal("end_turn")

func _get_entity_at(position):
	for e in entities:
		if e.position == position:
			return e
	return null
