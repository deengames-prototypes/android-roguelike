extends "res://Ecs/Core/System.gd"

var _event_bus
var _ground_tilemap

var los_lib = preload("res://Scripts/los.gd").new()

func _init(event_bus, ground_tilemap):
	required_component_types = ["HealthComponent"]
	_event_bus = event_bus
	_ground_tilemap = ground_tilemap
	_event_bus.connect("lightning_cannon", self, 'activate')

func activate(source_entity, target: Vector2):
	var target_entity = _get_entity_at(target)
	if target_entity != null and source_entity != target_entity:
		_lightning_cannon(source_entity, target_entity, Constants.LIGHTNING_CANNON_DAMAGE, Constants.LIGHTNING_CANNON_RADIUS)
		_event_bus.emit_signal("end_turn")

func _lightning_cannon(source, target, damage, radius):
	if damage <= 0 or radius <= 0:
		return
	
	_event_bus.emit_signal("damage_entity", target, damage)
	var target_2 = _get_entity_within_radius(target.position, radius)
	if target_2 != null and target_2 != target and source != target_2 and los_lib.is_line_clear(_ground_tilemap, target.position, target_2.position):
		var distance = target_2.position.distance_to(target.position)
		var new_damage = int(floor(damage - distance))
		var new_radius = radius - distance
		_lightning_cannon(source, target_2, new_damage, new_radius)

func _get_entity_within_radius(position, radius):
	var duplicate = entities.duplicate()
	duplicate.shuffle()
	for e in duplicate:
		if e.position.distance_to(position) <= radius and e.position != position:
			return e
	return null

func _get_entity_at(position):
	for e in entities:
		if e.position == position:
			return e
	return null