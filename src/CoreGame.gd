extends Node2D

var _dungeon_generator = preload("res://Dungeon/DungeonGenerator.gd").new()
var _event_bus = preload("res://Scripts/EventBus.gd").new()
onready var _system_group = $SystemGroup

func _ready():
	_system_group._setup($Ground, $Creatures, $Effects, $Camera2D, $UI, _event_bus)
	_dungeon_generator.generate_dungeon($Ground, _event_bus)
	_event_bus.connect("add_healthbar", self, "add_child")
	_event_bus.connect("remove_healthbar", self, "remove_child")
