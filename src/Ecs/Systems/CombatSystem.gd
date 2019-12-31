extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	self.required_component_types = ["HealthComponent"]
	event_bus.connect('move_entity', self, 'on_move_entity')
	_event_bus = event_bus

func on_move_entity(attacker, new_position):
	# TODO: make TeamComponent, ensure entities on the same team can't attack each other
	var attacked = _get_attackable_entity(new_position)
	if attacked == null or attacked == attacker:
		return
	
	var attack_component = attacker.get("MeleeComponent")
	if attack_component == null:
		return
	
	_event_bus.emit_signal("damage_entity", attacked, attack_component.damage)

func _get_attackable_entity(position):
	for e in entities:
		if e.position == position:
			return e
	return null
