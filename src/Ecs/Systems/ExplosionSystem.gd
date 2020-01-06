extends "res://Ecs/Core/System.gd"

var _event_bus
var _ground_tilemap

var los_lib = preload("res://Scripts/los.gd").new()

func _init(event_bus, ground_tilemap):
	required_component_types = ["HealthComponent"]
	_event_bus = event_bus
	_ground_tilemap = ground_tilemap
	_event_bus.connect("create_explosion", self, "on_create_explosion")

func on_create_explosion(target_tile, base_damage, radius):
	# TODO: observe line of sight
	for e in entities:
		var distance = e.position.distance_to(target_tile)
		if distance <= radius and los_lib.is_line_clear(_ground_tilemap, target_tile, e.position):
			var damage = base_damage - int(floor(distance))
			_event_bus.emit_signal("damage_entity", e, damage)
