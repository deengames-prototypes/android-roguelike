extends "res://Ecs/Core/System.gd"

var _tilemap
var _event_bus

func _init(event_bus, tilemap):
	_event_bus = event_bus
	_tilemap = tilemap

func _input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		_activate_tile(get_canvas_transform().xform_inv(event.position))
	elif event is InputEventMouseButton and event.pressed == true and event.button_index == BUTTON_LEFT:
		_activate_tile(get_global_mouse_position())

func _activate_tile(click_position):
	var tile_clicked = _tilemap.world_to_map(click_position)
	_event_bus.emit_signal("activate_tile", tile_clicked)