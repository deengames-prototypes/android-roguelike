extends "res://Scripts/Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	self.required_component_types = ["PlayerMovementComponent"]
	_event_bus = event_bus

func on_update():
	for entity in self.entities:
		if Input.is_action_just_pressed("move_up"):
			_event_bus.emit_signal("move_entity", entity, entity.x, entity.y - 1)
		if Input.is_action_just_pressed("move_down"):
			_event_bus.emit_signal("move_entity", entity, entity.x, entity.y + 1)
		if Input.is_action_just_pressed("move_left"):
			_event_bus.emit_signal("move_entity", entity, entity.x - 1, entity.y)
		if Input.is_action_just_pressed("move_right"):
			_event_bus.emit_signal("move_entity", entity, entity.x + 1, entity.y)