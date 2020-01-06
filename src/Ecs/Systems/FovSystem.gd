extends "res://Ecs/Core/System.gd"

var _event_bus
var _tilemap
var _player = null

var fov_lib = preload("res://Scripts/fov.gd").new()

func _init(event_bus, ground_tilemap):
	_event_bus = event_bus
	_tilemap = ground_tilemap

	_event_bus.connect("move_entity", self, "on_move_entity")
	_event_bus.connect("set_player", self, "on_set_player")

func on_set_player(player):
	_player = player
	update_player_fov(_player.position)

func on_move_entity(entity, new_position):
	if _player != null and entity == _player and _is_empty(new_position):
		update_player_fov(new_position)

func update_player_fov(pos):
	_event_bus.emit_signal("fov_change", calculate_fov_from(pos, _player.get("SightComponent").sight_radius))

func calculate_fov_from(pos, radius):
	return fov_lib.do_fov(_tilemap, pos, radius)

func _is_empty(pos):
	for e in entities:
		if e.position == pos:
			return false
	return true