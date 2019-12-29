extends "res://Ecs/Core/System.gd"

var _healthbars = {} # entity => healthbar
var _fov = {}
var _event_bus

func _init(event_bus):
	required_component_types = ["HealthComponent"]
	_event_bus = event_bus
	_event_bus.connect("fov_change", self, "on_fov_change")
	_event_bus.connect("entity_died", self, "on_entity_died")

func _process(delta):
	for entity in entities:
		_update_healthbar_for(entity)

func on_fov_change(new_fov):
	_fov = new_fov

func on_entity_died(entity):
	if _healthbars.has(entity):
		_event_bus.emit_signal("remove_healthbar", _healthbars[entity])
		_healthbars.erase(entity)

func _update_healthbar_for(entity):
	if not _healthbars.has(entity):
		_healthbars[entity] = _create_healthbar(entity)

	if _fov.has(entity.position):
		_healthbars[entity].visible = true
	else:
		_healthbars[entity].visible = false

	_update_healthbar_properties(_healthbars[entity], entity)

func _create_healthbar(entity):
	var p = ProgressBar.new()
	p.percent_visible = false
	p.min_value = 0
	p.rounded = true
	p.step = 1
	
	_update_healthbar_properties(p, entity)
	_event_bus.emit_signal("add_healthbar", p)
	return p

func _update_healthbar_properties(healthbar, entity):
	var health_component = entity.get("HealthComponent")
	
	healthbar.rect_position = entity.position * Vector2(Constants.TILE_WIDTH, Constants.TILE_HEIGHT)
	healthbar.rect_size = Vector2(Constants.TILE_WIDTH, Constants.TILE_HEIGHT / 3)
	healthbar.max_value = health_component.max_health
	healthbar.value = health_component.health