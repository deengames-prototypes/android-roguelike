extends "res://Scripts/Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	self.required_component_types = ["HealthComponent"]
	event_bus.connect('move_entity', self, 'on_move_entity')
	_event_bus = event_bus

func on_move_entity(attacker, x, y):
	var attacked = get_attackable_entity(x, y)
	if attacked == null or attacked == attacker:
		return
	
	var attack_component = attacker.get("AttackComponent")
	if attack_component == null:
		return
	
	var health_component = attacked.get("HealthComponent")
	
	health_component.health -= attack_component.damage
	print("entity attacked")
	if health_component.health <= 0:
		print("entity killed")
		_event_bus.emit_signal("entity_died", attacked)

func get_attackable_entity(x, y):
	for e in entities:
		if e.position.x == x and e.position.y == y:
			return e
	return null
