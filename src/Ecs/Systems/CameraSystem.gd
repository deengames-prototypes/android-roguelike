extends "res://Ecs/Core/System.gd"

var _camera

func _init(camera):
	_camera = camera
	self.required_component_types = ["CameraFollowComponent"]

func _process(delta):
	if len(entities) > 0:
		_camera.center_on(entities[0]);