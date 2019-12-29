extends "res://Ecs/Core/Component.gd"

var tile_name:String # eg. "Wall" or "Goblin"
var seen_tile_name
var layer:String # Ground or Creatures

func _init(_layer, image, seen_image=null):
	layer = _layer
	tile_name = image
	seen_tile_name = seen_image