extends "res://Scripts/Ecs/Core/System.gd"

var _tilesTilemap:TileMap
var _entitiesTilemap:TileMap

func _init(tilesTilemap:TileMap, entitiesTilemap:TileMap):
	self.required_component_types = ["SpriteComponent"]
	_tilesTilemap = tilesTilemap;
	_entitiesTilemap = entitiesTilemap

func _update():
	for entity in self.entities:
		_tilesTilemap.SetCell(entity.x, entity.y, entity.get("SpriteComponent").tileName)