extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	required_component_types = ["HealthComponent"]
	_event_bus = event_bus
	_event_bus.connect("create_explosion", self, "on_create_explosion")

func on_create_explosion(target_tile, base_damage, radius):
	# TODO: observe line of sight
	for e in entities:
		var distance = e.position.distance_to(target_tile)
		if distance <= radius:
			var damage = base_damage - int(floor(distance))
			_event_bus.emit_signal("damage_entity", e, damage)
