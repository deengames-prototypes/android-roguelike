extends Node2D

const DisplaySystem = preload("res://Scripts/Ecs/Systems/DisplaySystem.gd")
const PlayerMovementSystem = preload("res://Scripts/Ecs/Systems/PlayerMovementSystem.gd")

const Entity = preload("res://Scripts/Ecs/Core/Entity.gd")

const SpriteComponent = preload("res://Scripts/Ecs/Components/SpriteComponent.gd")
const PlayerMovementComponent = preload("res://Scripts/Ecs/Components/PlayerMovementComponent.gd")

const TILES_WIDE = 30
const TILES_HIGH = 17

###################################
# TODO: put into a container/thing
var _systems:Array = []
# Also TODO: put in with _systems
func add_entity(e:Entity):
	for system in _systems:
		system.add(e)

func update_systems():
	for system in _systems:
		system.on_update()
###################################

func _ready():
	_setup_systems()
	_create_hardcoded_dungeon()
	_spawn_player()

func _process(delta):
	self.update_systems()

func _setup_systems():
	_systems.append(DisplaySystem.new($Ground, $Creatures))
	_systems.append(PlayerMovementSystem.new())

func _create_hardcoded_dungeon():
	for x in range(TILES_WIDE):
		self.add_entity(Entity.new(x, 0).sprite("Wall", "Ground"))
		self.add_entity(Entity.new(x, TILES_HIGH - 1).sprite("Wall", "Ground"))
	
	for y in range(TILES_HIGH):
		self.add_entity(Entity.new(0, y).sprite("Wall", "Ground"))
		self.add_entity(Entity.new(TILES_WIDE - 1, y).sprite("Wall", "Ground"))

func _spawn_player():
	self.add_entity(Entity.new(15, 9)\
					.sprite("Player", "Creatures")\
					.add("PlayerMovementComponent", PlayerMovementComponent.new())
					)