extends "res://Ecs/Core/System.gd"

const StunnedComponent = preload("res://Ecs/Components/StunnedComponent.gd")

var _event_bus

func _init(event_bus):
	required_component_types = ["StunnedComponent"]
	_event_bus = event_bus
	_event_bus.connect("stun_entity", self, "on_stun_entity")
	_event_bus.connect("end_turn", self, "on_end_turn")

func on_stun_entity(entity, turns):
	if entity.has("StunnedComponent"):
		var component = entity.get("StunnedComponent")
		component.turns = turns
	else:
		entity.add("StunnedComponent", StunnedComponent.new(turns))
		_event_bus.emit_signal("change_entity", entity)

func on_end_turn():
	for e in entities:
		var component = e.get("StunnedComponent")
		component.turns -= 1
		if component.turns <= 0:
			e.remove("StunnedComponent")
			_event_bus.emit_signal("change_entity", e)
