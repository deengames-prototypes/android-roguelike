extends Node

const RandomWalker = preload("res://Scripts/RandomWalker.gd")

var _entity_factory = preload("res://Scripts/Ecs/Extension/EntityFactory.gd").new()
var wall_index = 0
var empty_index = -1
var rng = RandomNumberGenerator.new()

func generate_dungeon(tilemap: TileMap, event_bus):
	rng.randomize()

	flood_with_walls(tilemap, wall_index)
	
	var random_walker = RandomWalker.new(Constants.TILES_WIDE, Constants.TILES_HIGH, rng)
	
	for _i in range(Constants.RANDOM_WALK_STEPS):
		random_walker.walk()
		tilemap.set_cell(random_walker.position.x, random_walker.position.y, empty_index)

	spawn_walls(tilemap, event_bus)
	spawn_player(random_walker.get_history(), event_bus)
	spawn_enemies(random_walker.get_history(), event_bus)

func flood_with_walls(tilemap, wall_index):
	for x in range(Constants.TILES_WIDE):
		for y in range(Constants.TILES_HIGH):
			tilemap.set_cell(x, y, wall_index)

func get_random_empty_tile(empty_tiles):
	return empty_tiles[int(rng.randf() * len(empty_tiles))]

func spawn_walls(tilemap, event_bus):
	for x in range(Constants.TILES_WIDE):
		for y in range(Constants.TILES_HIGH):
			if tilemap.get_cell(x, y) == 0:
				var tile = Vector2(x, y)
				event_bus.emit_signal("spawn_entity", _entity_factory.create_wall(tile))

func spawn_player(empty_tiles, event_bus):
	var tile = get_random_empty_tile(empty_tiles)
	event_bus.emit_signal("spawn_entity", _entity_factory.create_player(tile))

func spawn_enemies(empty_tiles, event_bus):
	for i in rng.randi_range(Constants.MIN_ENEMIES_PER_DUNGEON, Constants.MAX_ENEMIES_PER_DUNGEON):
		var tile = get_random_empty_tile(empty_tiles)
		event_bus.emit_signal("spawn_entity", _entity_factory.create_monster(tile))