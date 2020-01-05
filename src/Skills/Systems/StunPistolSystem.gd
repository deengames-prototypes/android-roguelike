extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	required_component_types = ["HealthComponent"]
	_event_bus = event_bus
	_event_bus.connect("stun_pistol", self, 'activate')

func activate(source_entity, target: Vector2):
	# TODO: ensure line of sight
	var target_entity = _get_entity_at(target)
	if target_entity != null and source_entity != target_entity:
		_event_bus.emit_signal("stun_entity", target_entity, Constants.PISTOL_TURNS_STUNNED)
		_event_bus.emit_signal("damage_entity", target_entity, Constants.PISTOL_DAMAGE)
		_event_bus.emit_signal("end_turn")

func _get_entity_at(position):
	for e in entities:
		if e.position == position:
			return e
	return null
