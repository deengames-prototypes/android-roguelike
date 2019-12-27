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
		_event_bus.emit_signal("fov_change", calculate_player_fov())

func on_move_entity(entity, new_position):
	if _player != null and entity == _player:
		var fov = calculate_player_fov()
		_event_bus.emit_signal("fov_change", fov)


func calculate_player_fov():
	# what really should be used here is a set
	# though that has no equivalent in gdscript
	# so a dictionary with nonsensical values will have to do
	var fov = {} # Vector2(x, y) => true
	for y in range(Constants.TILES_HIGH):
		for x in range(Constants.TILES_WIDE):
			var pos = Vector2(x, y)
			if _is_in_player_fov(pos):
				fov[pos] = true
	
	return fov

func _is_in_player_fov(pos):
	var player_sight = _player.get("SightComponent").sight_radius
	
	if pos.x < _player.position.x - player_sight or \
		pos.y < _player.position.y - player_sight or \
		pos.x > _player.position.x + player_sight or \
		pos.y > _player.position.y + player_sight:
			
		return false
		
	return _player.position.distance_to(pos) <= player_sight