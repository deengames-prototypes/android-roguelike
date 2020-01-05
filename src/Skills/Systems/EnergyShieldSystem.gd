extends "res://Ecs/Core/System.gd"

const EnergyShieldEffect = preload("res://Effects/Damage/EnergyShieldEffect.gd")

var _player

func _init(event_bus):
	required_component_types = ["StatusEffectsComponent"]
	event_bus.connect("energy_shield", self, 'activate')
	event_bus.connect("end_turn", self, "on_end_turn")
	event_bus.connect("set_player", self, "on_set_player")

func activate(entity):
	var status_effects_component = entity.get("StatusEffectsComponent")
	var effects = status_effects_component.effects

	# if there is an existing shield, reset its strength
	var shield = _get_shield(effects)
	if shield != null:
		shield.strength = Constants.ENERGY_SHIELD_STRENGTH
		shield.turns_left = Constants.ENERGY_SHIELD_TURNS
	else:
		shield = EnergyShieldEffect.new(status_effects_component, Constants.ENERGY_SHIELD_STRENGTH, Constants.ENERGY_SHIELD_TURNS)
		effects.append(shield)

func on_end_turn():
	if not _player.has("StatusEffectsComponent"):
		return

	var shield = _get_shield(_player.get("StatusEffectsComponent").effects)
	if shield == null:
		return

	shield.turns_left -= 1
	if shield.turns_left == 0:
		shield._end_effect()

func on_set_player(player):
	_player = player

func _get_shield(effects):
	for e in effects:
		if e is EnergyShieldEffect:
			return e
	return null
