extends Node

const DisplaySystem = preload("res://Scripts/Ecs/Systems/DisplaySystem.gd")
const PlayerMovementSystem = preload("res://Scripts/Ecs/Systems/PlayerMovementSystem.gd")
const EntityMovementSystem = preload("res://Scripts/Ecs/Systems/EntityMovementSystem.gd")
const CameraSystem = preload("res://Scripts/Ecs/Systems/CameraSystem.gd")

var _systems:Array = []

func _setup(event_bus):
	_setup_tilemaps()
	_setup_systems(event_bus)
	
	event_bus.connect("spawn_entity", self, "add_entity")

func _setup_tilemaps():
	var cell_size = Vector2(Constants.TILE_WIDTH, Constants.TILE_HEIGHT)
	$Ground.cell_size = cell_size
	$Creatures.cell_size = cell_size

func _setup_systems(event_bus):
	_systems.append(DisplaySystem.new($Ground, $Creatures))
	_systems.append(PlayerMovementSystem.new(event_bus))
	_systems.append(EntityMovementSystem.new(event_bus))
	_systems.append(CameraSystem.new($Camera2D))

func add_entity(e):
	for system in _systems:
		system.add(e)

func update_systems():
	for system in _systems:
		system.on_update()