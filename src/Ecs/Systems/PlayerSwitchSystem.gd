extends "res://Ecs/Core/System.gd"

const PlayerControlComponent = preload("res://Ecs/Components/PlayerControlComponent.gd")
const CameraFollowComponent = preload("res://Ecs/Components/CameraFollowComponent.gd")

var _event_bus

func _init(event_bus):
	self.required_component_types = ["PlayableComponent"]
	_event_bus = event_bus

func _process(delta):
	if Input.is_action_just_pressed("switch_player"):
		_switch_player()

func _switch_player():
	var from
	for e in entities:
		if e.has("PlayerControlComponent"):
			from = e
			break
	
	var to = entities[entities.find(from) -1]
	from.remove("PlayerControlComponent")
	from.remove("CameraFollowComponent")
	to.add("PlayerControlComponent", PlayerControlComponent.new())
	to.add("CameraFollowComponent", CameraFollowComponent.new())

	_event_bus.emit_signal("change_entity", from)
	_event_bus.emit_signal("change_entity", to)