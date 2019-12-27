extends "res://Scripts/Ecs/Core/Component.gd"

var tile_name:String # eg. "Wall" or "Goblin"
var seen_tile_name
var layer:String # Ground or Creatures

func _init(image, layer, seen_image=null):
	self.tile_name = image
	self.layer = layer
	seen_tile_name = seen_image