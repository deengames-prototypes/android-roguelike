extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	required_component_types = ["PlayerControlComponent", "SkillComponent"]
	_event_bus = event_bus
	_event_bus.connect("switched_skill", self, "on_switched_skill")

func on_switched_skill(entity, skill):
    # self skills fire as soon as they're selected
    if skill.type == skill.TYPES.SELF:
        _event_bus.emit_signal(skill.signal_name, entity)
        entity.get("SkillComponent").active = null
