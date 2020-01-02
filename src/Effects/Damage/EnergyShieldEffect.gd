extends "res://Effects/Effect.gd"

var strength

func _init(parent, _strength):
    _super(parent)
    strength = _strength
    tile_name = 'EnergyShield'

func process_damage(damage):
    # shield nullifies damage
    strength -= 1
    if strength <= 0:
        _end_effect()
    return 0