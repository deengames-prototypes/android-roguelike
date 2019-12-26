extends "res://Scripts/Ecs/Core/System.gd"

var _tiles_tilemap:TileMap
var _entities_tilemap:TileMap

var tilemaps_by_name = {}
var _fov_cache = {} # [x, y] => true/false
var _fog_of_war_seen_tiles = {} # [x, y] instances for O(1) search

var _event_bus
var _player = null

func _init(event_bus, tiles_tilemap:TileMap, entities_tilemap:TileMap):
	self.required_component_types = ["SpriteComponent"]
	_event_bus = event_bus
	_tiles_tilemap = tiles_tilemap;
	_entities_tilemap = entities_tilemap
	
	tilemaps_by_name = {
		"Ground": _tiles_tilemap,
		"Creatures": _entities_tilemap
	}
	
	_event_bus.connect("spawn_entity", self, "on_spawn_entity")
	_event_bus.connect("move_entity", self, "on_move_entity")

func on_update():
	
	if _player == null:
		return
		
	_tiles_tilemap.clear()
	_entities_tilemap.clear()
	
	var populate_cache = _fov_cache.empty()
	# Fill with fog and populate FOV cache
	for y in range(Constants.TILES_HIGH):
		for x in range(Constants.TILES_WIDE):
			var key = "%s, %s" % [x, y]
			# Player just moved. Don't recalculate FOV every turn.
			# Also, they may have gotten rid of some fog-of-war, so mark
			# the current view as seen.
			if populate_cache:
				_fov_cache[key] = _is_in_player_fov(x, y)
				if _fov_cache[key]:
					_fog_of_war_seen_tiles[key] = true
			if not _fov_cache[key]:
				_tiles_tilemap.set_cell(x, y, _tiles_tilemap.tile_set.find_tile_by_name("Fog"))
			
	for entity in self.entities:
		var component = entity.get("SpriteComponent")
		var tilemap = tilemaps_by_name[component.layer]
		var key = "%s, %s" % [entity.position.x, entity.position.y]
		
		# It's in our FOV, or it's a wall in fog-of-war
		if  (_fov_cache.has(key) and _fov_cache[key] == true) or \
			(component.tile_name == "Wall" and _fog_of_war_seen_tiles.has(key)):
			var tile_index = tilemap.tile_set.find_tile_by_name(component.tile_name)
			tilemap.set_cell(entity.position.x, entity.position.y, tile_index)

func _is_in_player_fov(x, y):
	if x < _player.position.x - _player.sight_radius or \
		y < _player.position.y - _player.sight_radius or \
		x > _player.position.x + _player.sight_radius or \
		y > _player.position.y + _player.sight_radius:
			
		return false
		
	return sqrt(pow(x - _player.position.x, 2) + pow(y - _player.position.y, 2)) <= _player.sight_radius

func on_spawn_entity(entity):
	if entity.has("PlayerMovementComponent"):
		_player = entity

func on_move_entity(entity, x, y):
	if _player != null and entity == _player:
		_fov_cache.clear()