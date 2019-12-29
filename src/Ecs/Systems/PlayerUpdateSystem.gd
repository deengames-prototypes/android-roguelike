extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	_event_bus = event_bus
	_event_bus.connect("change_entity", self, "on_change_entity")
	_event_bus.connect("spawn_entity", self, "on_change_entity")

func on_change_entity(entity):
	if entity.has("PlayerControlComponent"):
		_event_bus.emit_signal("change_player", entity)