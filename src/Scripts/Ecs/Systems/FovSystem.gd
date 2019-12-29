extends "res://Scripts/Ecs/Core/System.gd"

var _event_bus
var _player = null

func _init(event_bus):
	_event_bus = event_bus

	_event_bus.connect("move_entity", self, "on_move_entity")
	_event_bus.connect("change_player", self, "on_change_player")

func on_change_player(player):
	_player = player
	update_player_fov(_player.position)

func on_move_entity(entity, new_position):
	if _player != null and entity == _player and _is_empty(new_position):
		update_player_fov(new_position)

func update_player_fov(pos):
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