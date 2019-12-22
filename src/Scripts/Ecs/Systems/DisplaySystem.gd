extends "res://Scripts/Ecs/Core/System.gd"

var _tiles_tilemap:TileMap
var _entities_tilemap:TileMap

var tilemaps_by_name = {}

func _init(tiles_tilemap:TileMap, entities_tilemap:TileMap):
	self.required_component_types = ["SpriteComponent"]
	_tiles_tilemap = tiles_tilemap;
	_entities_tilemap = entities_tilemap
	
	tilemaps_by_name = {
		"Ground": _tiles_tilemap,
		"Creatures": _entities_tilemap
	}

	_tiles_tilemap.clear()
	_entities_tilemap.clear()

func on_update():
	for entity in self.entities:
		var component = entity.get("SpriteComponent")

		var tilemap = tilemaps_by_name[component.layer]
		var tile_index = tilemap.tile_set.find_tile_by_name(component.tile_name)
		tilemap.set_cell(entity.x, entity.y, tile_index)