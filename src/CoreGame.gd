extends Node2D

const SystemGroup = preload("res://Scripts/Ecs/Extension/SystemGroup.gd")

var _dungeon_generator = preload("res://Scripts/DungeonGenerator.gd").new()
var _event_bus = preload("res://Scripts/EventBus.gd").new()
var _system_group:SystemGroup

func _ready():
	_system_group = SystemGroup.new($Ground, $Creatures, $Camera2D)
	_system_group._setup(_event_bus)
	_dungeon_generator.generate_dungeon($Ground, _event_bus)
	_event_bus.connect("add_healthbar", self, "add_child")
	_event_bus.connect("remove_healthbar", self, "remove_child")

func _process(delta):
	_system_group.update_systems()
