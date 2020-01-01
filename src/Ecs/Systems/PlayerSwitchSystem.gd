extends "res://Ecs/Core/System.gd"

const PlayerControlComponent = preload("res://Ecs/Components/PlayerControlComponent.gd")
const CameraFollowComponent = preload("res://Ecs/Components/CameraFollowComponent.gd")

var _event_bus

func _init(event_bus):
	self.required_component_types = ["PlayableComponent"]
	_event_bus = event_bus
	_event_bus.connect("activate_tile", self, "on_activate_tile")

func _process(delta):
	if Input.is_action_just_pressed("switch_player"):
		_switch_player_to()

func on_activate_tile(tile):
	for e in entities:
		if e.position == tile and not e.has("PlayerControlComponent"):
			_switch_player_to(e)

func _switch_player_to(to=null):
	var from
	for e in entities:
		if e.has("PlayerControlComponent"):
			from = e
			break
	
	if to == null:
		to = entities[entities.find(from) -1]

	from.remove("PlayerControlComponent")
	from.remove("CameraFollowComponent")
	to.add("PlayerControlComponent", PlayerControlComponent.new())
	to.add("CameraFollowComponent", CameraFollowComponent.new())

	_event_bus.emit_signal("change_entity", from)
	_event_bus.emit_signal("change_entity", to)