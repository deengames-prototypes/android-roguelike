extends "res://Scripts/Ecs/Core/System.gd"

var _camera
var _tilemap
var _event_bus

func _init(event_bus, camera, tilemap):
	_event_bus = event_bus
	_camera = camera
	_tilemap = tilemap
	required_component_types = ["PlayerControlComponent", "SkillComponent"]

func on_update():
	if Input.is_action_just_pressed("activate_tile"):
		var target = _tilemap.world_to_map(_camera.get_global_mouse_position())
		for e in entities:
			var skill = e.get("SkillComponent").active
			if skill != null and skill.type == skill.TYPES.TARGETED:
				_event_bus.emit_signal(skill.signal_name, target)
