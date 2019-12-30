extends "res://Ecs/Core/System.gd"

var _tilemap
var _event_bus

func _init(event_bus, tilemap):
	_event_bus = event_bus
	_tilemap = tilemap
	required_component_types = ["PlayerControlComponent", "SkillComponent"]

func _process(delta):
	if Input.is_action_just_pressed("activate_tile"):
		for e in entities:
			var skill = e.get("SkillComponent").active
			if skill != null and skill.type == skill.TYPES.TARGETED:
				_event_bus.emit_signal(skill.signal_name, e, _tilemap.world_to_map(get_global_mouse_position()))
