extends Node2D

var _dungeon_generator = preload("res://Scripts/DungeonGenerator.gd").new()
var _event_bus = preload("res://Scripts/EventBus.gd").new()
onready var _system_group = $SystemGroup

func _ready():
	_system_group._setup(_event_bus)
	_dungeon_generator.generate_dungeon($SystemGroup/Ground, _event_bus)

func _process(delta):
	_system_group.update_systems()
