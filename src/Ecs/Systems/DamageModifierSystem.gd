extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	event_bus.connect('damage_entity', self, 'on_damage_entity')
	_event_bus = event_bus

func on_damage_entity(entity, damage):
	if entity.has("StatusEffectsComponent"):
		var effects_component = entity.get("StatusEffectsComponent")
		for effect in effects_component.effects:
			damage = effect.process_damage(damage)
	_event_bus.emit_signal("damage_entity_modified", entity, damage)
