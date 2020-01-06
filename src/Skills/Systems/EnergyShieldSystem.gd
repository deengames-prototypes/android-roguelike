extends "res://Ecs/Core/System.gd"

const EnergyShieldEffect = preload("res://Effects/Damage/EnergyShieldEffect.gd")

func _init(event_bus):
	required_component_types = ["StatusEffectsComponent"]
	event_bus.connect("energy_shield", self, 'activate')

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

func _get_shield(effects):
	for e in effects:
		if e is EnergyShieldEffect:
			return e
	return null
