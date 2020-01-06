extends "res://Ecs/Core/System.gd"

var _event_bus
var _tilemap
var fov_map = {}  # playable_entity: fov

var fov_lib = preload("res://Scripts/fov.gd").new()

func _init(event_bus, ground_tilemap):
	_event_bus = event_bus
	_tilemap = ground_tilemap

	_event_bus.connect("move_entity", self, "on_move_entity")
	_event_bus.connect("spawn_entity", self, "on_move_entity")

func on_move_entity(entity, new_position=null):
	if new_position == null or not _is_empty(new_position):
		new_position = entity.position
	
	if entity.has("PlayableComponent") and entity.has("SightComponent"):
		fov_map[entity] = calculate_fov_from(new_position, entity.get("SightComponent").sight_radius)
		_event_bus.emit_signal("fov_change", get_total_fov())

func calculate_fov_from(pos, radius):
	return fov_lib.do_fov(_tilemap, pos, radius)

func get_total_fov():
	var total_fov = {}
	for fov in fov_map.values():
		for tile in fov:
			total_fov[tile] = true
	return total_fov

func _is_empty(pos):
	for e in entities:
		if e.position == pos:
			return false
	return true