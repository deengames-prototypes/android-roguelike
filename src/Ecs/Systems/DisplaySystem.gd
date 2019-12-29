extends "res://Ecs/Core/System.gd"

var _tiles_tilemap:TileMap
var _entities_tilemap:TileMap

var tilemaps_by_name = {}
var _fov_cache = {}
var _fog_of_war_seen_tiles = {}  # Vector2(x, y) instances for O(1) search

var _event_bus

func _init(event_bus, tiles_tilemap:TileMap, entities_tilemap:TileMap):
	self.required_component_types = ["SpriteComponent"]
	_event_bus = event_bus
	_tiles_tilemap = tiles_tilemap;
	_entities_tilemap = entities_tilemap
	
	tilemaps_by_name = {
		"Ground": _tiles_tilemap,
		"Creatures": _entities_tilemap
	}
	
	_event_bus.connect("fov_change", self, "on_fov_change")

func _process(delta):
	_tiles_tilemap.clear()
	_entities_tilemap.clear()

	for y in range(Constants.TILES_HIGH):
		for x in range(Constants.TILES_WIDE):
			var pos = Vector2(x, y)
			
			# flood with fog
			_tiles_tilemap.set_cell(x, y, _tiles_tilemap.tile_set.find_tile_by_name("Fog"))
			
			# except in fov or seen before
			if _fov_cache.has(pos):
				_tiles_tilemap.set_cell(x, y, _tiles_tilemap.tile_set.find_tile_by_name("Floor"))
			elif _fog_of_war_seen_tiles.has(pos):
				_tiles_tilemap.set_cell(x, y, _tiles_tilemap.tile_set.find_tile_by_name("DiscoveredFloor"))

	for entity in self.entities:
		var component = entity.get("SpriteComponent")
		var tilemap = tilemaps_by_name[component.layer]
		
		if _fov_cache.has(entity.position):
			tilemap.set_cell(entity.position.x, entity.position.y, tilemap.tile_set.find_tile_by_name(component.tile_name))
		
		elif _fog_of_war_seen_tiles.has(entity.position):
			if component.seen_tile_name != null:
				_tiles_tilemap.set_cell(entity.position.x, entity.position.y, _tiles_tilemap.tile_set.find_tile_by_name(component.seen_tile_name))

func on_fov_change(new_fov):
	_fov_cache = new_fov

	for pos in new_fov.keys():
        _fog_of_war_seen_tiles[pos] = true
