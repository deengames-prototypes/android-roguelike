extends "res://Ecs/Core/System.gd"

var _event_bus
var _ground_tilemap

var los_lib = preload("res://Scripts/los.gd").new()

func _init(event_bus, ground_tilemap):
	required_component_types = ["PlayerControlComponent", "SkillComponent"]
	_event_bus = event_bus
	_ground_tilemap = ground_tilemap
	_event_bus.connect("activate_tile", self, "on_activate_tile")

func on_activate_tile(tile):
	for e in entities:
		var skill = e.get("SkillComponent").active
		if skill != null and skill.type == skill.TYPES.TARGETED and los_lib.is_line_clear(_ground_tilemap, e.position, tile):
			_event_bus.emit_signal(skill.signal_name, e, tile)