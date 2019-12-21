extends Node
# generic component script

func _ready():
	GameData.component_map.get(name).append(self)
