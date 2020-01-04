extends "res://Effects/Effect.gd"

var strength
var turns_passed = 0

func _init(parent, _strength):
    _super(parent)
    strength = _strength
    tile_name = 'EnergyShield'

func process_damage(damage):
    # shield nullifies damage
    if Constants.SHIELD_DIES_AFTER_3_HITS:
        strength -= 1
        if strength <= 0:
            _end_effect()
    return 0