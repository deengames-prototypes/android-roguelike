extends "res://Scripts/Ecs/Core/System.gd"

var _event_bus
var _player = null

func _init(event_bus):
	_event_bus = event_bus
	
	_event_bus.connect("spawn_entity", self, "on_spawn_entity")
	_event_bus.connect("move_entity", self, "on_move_entity")

func on_spawn_entity(entity):
	if entity.has("PlayerMovementComponent"):
		_player = entity
		update_player_fov()

func on_move_entity(entity, new_position):
	if _player != null and entity == _player:
		var pos = null
		if _is_empty(new_position):
			pos = new_position
		update_player_fov(pos)

func update_player_fov(pos=null):
	if pos == null:
		pos = _player.position
	_event_bus.emit_signal("fov_change", calculate_fov_from(pos, _player.get("SightComponent").sight_radius))

func calculate_fov_from(pos, radius):
	# what really should be used here is a set
	# though that has no equivalent in gdscript
	# so a dictionary with nonsensical values will have to do
	var fov = {} # Vector2(x, y) => true
	for y in range(Constants.TILES_HIGH):
		for x in range(Constants.TILES_WIDE):
			var tile = Vector2(x, y)
			if _is_in_fov(pos, radius, tile):
				fov[tile] = true
	
	return fov

func _is_in_fov(pos, radius, tile):
	if tile.x < pos.x - radius or \
		tile.y < pos.y - radius or \
		tile.x > pos.x + radius or \
		tile.y > pos.y + radius:
			
		return false
		
	return pos.distance_to(tile) <= radius

func _is_empty(pos):
	for e in entities:
		if e.position == pos:
			return false
	return true