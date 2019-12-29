extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	event_bus.connect('damage_entity', self, 'on_damage_entity')
	_event_bus = event_bus

func on_damage_entity(entity, damage):
	var health_component = entity.get("HealthComponent")
	health_component.health -= damage
	
	if health_component.health <= 0:
		_event_bus.emit_signal("entity_died", entity)