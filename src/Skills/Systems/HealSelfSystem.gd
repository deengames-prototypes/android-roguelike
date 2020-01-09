extends "res://Ecs/Core/System.gd"

var _event_bus

func _init(event_bus):
	_event_bus = event_bus
	_event_bus.connect("heal_self", self, 'activate')

func activate(entity):
	_event_bus.emit_signal("heal_entity", entity, Constants.HEAL_SELF_AMOUNT)