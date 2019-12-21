extends "res://Scripts/Ecs/Core/System.gd"

var _tiles_tilemap:TileMap
var _entities_tilemap:TileMap

# TODO: figure this out
var tile_name_to_index = {
	"Wall": 0,
	"Player": 0
}

func _init(tiles_tilemap:TileMap, entities_tilemap:TileMap):
	self.required_component_types = ["SpriteComponent"]
	_tiles_tilemap = tiles_tilemap;
	_entities_tilemap = entities_tilemap
	
	_tiles_tilemap.clear()
	_entities_tilemap.clear()

func on_update():
	for entity in self.entities:
		var component = entity.get("SpriteComponent")
		var tile_index = tile_name_to_index[component.tile_name]
		
		if component.layer == "Ground":
			_tiles_tilemap.set_cell(entity.x, entity.y, tile_index)
		elif component.layer == "Creatures":
			_entities_tilemap.set_cell(entity.x, entity.y, tile_index)