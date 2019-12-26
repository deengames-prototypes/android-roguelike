extends Node

const DisplaySystem = preload("res://Scripts/Ecs/Systems/DisplaySystem.gd")
const PlayerMovementSystem = preload("res://Scripts/Ecs/Systems/PlayerMovementSystem.gd")
const EntityMovementSystem = preload("res://Scripts/Ecs/Systems/EntityMovementSystem.gd")
const CameraSystem = preload("res://Scripts/Ecs/Systems/CameraSystem.gd")
const CombatSystem = preload("res://Scripts/Ecs/Systems/CombatSystem.gd")
const ChasePlayerSystem = preload("res://Scripts/Ecs/Systems/ChasePlayerSystem.gd")

var _ground_tilemap:TileMap
var _creatures_tilemap:TileMap
var _camera:Camera2D

var _systems:Array = []

func _init(ground_tilemap, creatures_tilemap, camera):
	_ground_tilemap = ground_tilemap
	_creatures_tilemap = creatures_tilemap
	_camera = camera

func add_entity(e):
	for system in _systems:
		system.add(e)

func remove_entity(e):
	for system in _systems:
		system.remove(e)

func update_systems():
	for system in _systems:
		system.on_update()

func _setup(event_bus):
	_setup_tilemaps()
	_setup_systems(event_bus)
	event_bus.connect("spawn_entity", self, "add_entity")
	event_bus.connect("entity_died", self, "remove_entity")

func _setup_tilemaps():
	var cell_size = Vector2(Constants.TILE_WIDTH, Constants.TILE_HEIGHT)
	_ground_tilemap.cell_size = cell_size
	_creatures_tilemap.cell_size = cell_size

func _setup_systems(event_bus):
	_systems.append(DisplaySystem.new(event_bus, _ground_tilemap, _creatures_tilemap))
	_systems.append(PlayerMovementSystem.new(event_bus))
	_systems.append(EntityMovementSystem.new(event_bus))
	_systems.append(CameraSystem.new(_camera))
	_systems.append(CombatSystem.new(event_bus))
	_systems.append(ChasePlayerSystem.new(event_bus))
