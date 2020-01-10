extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	event_bus.connect('heal_entity', self, 'on_heal_entity')
	_event_bus = event_bus

func on_heal_entity(entity, amount):
	amount = max(amount, 0)
	var health_component = entity.get("HealthComponent")
	health_component.health += amount
	
	if health_component.health > health_component.max_health:
		health_component.health = health_component.max_health