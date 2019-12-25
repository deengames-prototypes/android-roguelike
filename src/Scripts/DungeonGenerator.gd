extends Node

const RandomWalker = preload("res://Scripts/RandomWalker.gd")

const Entity = preload("res://Scripts/Ecs/Core/Entity.gd")

const PlayerMovementComponent = preload("res://Scripts/Ecs/Components/PlayerMovementComponent.gd")
const CameraFollowComponent = preload("res://Scripts/Ecs/Components/CameraFollowComponent.gd")

var wall_index = 0
var empty_index = -1

func generate_dungeon(tilemap: TileMap, event_bus):
	flood_with_walls(tilemap, wall_index)
	
	var random_walker = RandomWalker.new(Constants.TILES_WIDE, Constants.TILES_HIGH)
	
	for _i in range(Constants.RANDOM_WALK_STEPS):
		random_walker.walk()
		tilemap.set_cell(random_walker.position.x, random_walker.position.y, empty_index)
	
	spawn_entities(tilemap, event_bus)
	spawn_player(event_bus)

func flood_with_walls(tilemap, wall_index):
	for x in range(Constants.TILES_WIDE):
		for y in range(Constants.TILES_HIGH):
			tilemap.set_cell(x, y, wall_index)

func spawn_entities(tilemap, event_bus):
	for x in range(Constants.TILES_WIDE):
		for y in range(Constants.TILES_HIGH):
			if tilemap.get_cell(x, y) == 0:
				event_bus.emit_signal("spawn_entity", Entity.new(x, y).sprite("Wall", "Ground"))

func spawn_player(event_bus):
	event_bus.emit_signal("spawn_entity", Entity.new(15, 9)\
					.sprite("Player", "Creatures")\
					.add("PlayerMovementComponent", PlayerMovementComponent.new())\
					.add("CameraFollowComponent", CameraFollowComponent.new())
					)