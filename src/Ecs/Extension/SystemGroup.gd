extends Node2D

const DisplaySystem = preload("res://Ecs/Systems/DisplaySystem.gd")
const FovSystem = preload("res://Ecs/Systems/FovSystem.gd")
const PlayerMovementSystem = preload("res://Ecs/Systems/PlayerMovementSystem.gd")
const EntityMovementSystem = preload("res://Ecs/Systems/EntityMovementSystem.gd")
const CameraSystem = preload("res://Ecs/Systems/CameraSystem.gd")
const CombatSystem = preload("res://Ecs/Systems/CombatSystem.gd")
const ChasePlayerSystem = preload("res://Ecs/Systems/ChasePlayerSystem.gd")
const HealthBarSystem = preload("res://Ecs/Systems/HealthBarSystem.gd")
const DamageSystem = preload("res://Ecs/Systems/DamageSystem.gd")
const SkillSelectSystem = preload("res://Ecs/Systems/SkillSelectSystem.gd")
const TargetedSkillSystem = preload("res://Ecs/Systems/TargetedSkillSystem.gd")
const PlayerUpdateSystem = preload("res://Ecs/Systems/PlayerUpdateSystem.gd")

# skill systems
const BowAttackSystem = preload("res://Skills/Systems/BowAttackSystem.gd")

func add_entity(e):
	for system in get_children():
		system.add(e)

func remove_entity(e):
	for system in get_children():
		system.remove(e)

func change_entity(e):
	remove_entity(e)
	add_entity(e)

func _setup(ground_tilemap, creatures_tilemap, camera, event_bus):
	_setup_tilemaps(ground_tilemap, creatures_tilemap)
	_setup_systems(ground_tilemap, creatures_tilemap, camera, event_bus)
	event_bus.connect("spawn_entity", self, "add_entity")
	event_bus.connect("change_entity", self, "change_entity")
	event_bus.connect("entity_died", self, "remove_entity")

func _setup_tilemaps(ground_tilemap, creatures_tilemap):
	var cell_size = Vector2(Constants.TILE_WIDTH, Constants.TILE_HEIGHT)
	ground_tilemap.cell_size = cell_size
	creatures_tilemap.cell_size = cell_size

func _setup_systems(ground_tilemap, creatures_tilemap, camera, event_bus):
	add_child(DisplaySystem.new(event_bus, ground_tilemap, creatures_tilemap))
	add_child(FovSystem.new(event_bus))
	add_child(PlayerMovementSystem.new(event_bus))
	add_child(EntityMovementSystem.new(event_bus))
	add_child(CameraSystem.new(camera))
	add_child(CombatSystem.new(event_bus))
	add_child(ChasePlayerSystem.new(event_bus))
	add_child(HealthBarSystem.new(event_bus))
	add_child(DamageSystem.new(event_bus))
	add_child(SkillSelectSystem.new())
	add_child(TargetedSkillSystem.new(event_bus, creatures_tilemap))
	add_child(PlayerUpdateSystem.new(event_bus))

	# skills
	add_child(BowAttackSystem.new(event_bus))