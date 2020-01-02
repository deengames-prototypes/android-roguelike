extends "res://Ecs/Core/System.gd"

var _effects_tilemap:TileMap

func _init(effects_tilemap:TileMap):
	required_component_types = ["StatusEffectsComponent"]
	_effects_tilemap = effects_tilemap

func _process(delta):
	_effects_tilemap.clear()

	for entity in self.entities:
		var component = entity.get("StatusEffectsComponent")
		var effects = component.effects
		
		for effect in effects:
			if effect.tile_name == null:
				continue
			var effect_tile_index = _effects_tilemap.tile_set.find_tile_by_name(effect.tile_name)
			_effects_tilemap.set_cell(entity.position.x, entity.position.y, effect_tile_index)
