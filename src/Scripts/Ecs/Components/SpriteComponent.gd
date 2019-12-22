extends "res://Scripts/Ecs/Core/Component.gd"

var tile_name:String # eg. "Wall" or "Goblin"
var layer:String # Ground or Creatures

func _init(image, layer):
	self.tile_name = image
	self.layer = layer