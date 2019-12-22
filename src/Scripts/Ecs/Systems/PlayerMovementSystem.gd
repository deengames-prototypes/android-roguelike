extends "res://Scripts/Ecs/Core/System.gd"

func _init():
	self.required_component_types = ["PlayerMovementComponent"]

func on_update():
	for entity in self.entities:
		if Input.is_action_just_pressed("move_up"):
			entity.y -= 1
		if Input.is_action_just_pressed("move_down"):
			entity.y += 1
		if Input.is_action_just_pressed("move_left"):
			entity.x -= 1
		if Input.is_action_just_pressed("move_right"):
			entity.x += 1