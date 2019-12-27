extends "res://Scripts/Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	self.required_component_types = ["PlayerMovementComponent"]
	_event_bus = event_bus

func on_update():
	for entity in self.entities:
		var mod = Vector2()
		if Input.is_action_just_pressed("move_up"):
			mod.y -= 1
		if Input.is_action_just_pressed("move_down"):
			mod.y += 1
		if Input.is_action_just_pressed("move_left"):
			mod.x -= 1
		if Input.is_action_just_pressed("move_right"):
			mod.x += 1
		
		if mod != Vector2(0, 0):
			_event_bus.emit_signal("move_entity", entity, entity.position + mod)
			end_turn()

func end_turn():
	_event_bus.emit_signal("end_turn")