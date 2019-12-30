extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	required_component_types = ["PlayerControlComponent", "SkillComponent"]
	_event_bus = event_bus
	_event_bus.connect("activate_tile", self, "on_activate_tile")

func on_activate_tile(tile):
	for e in entities:
		var skill = e.get("SkillComponent").active
		if skill != null and skill.type == skill.TYPES.TARGETED:
			_event_bus.emit_signal(skill.signal_name, e, tile)