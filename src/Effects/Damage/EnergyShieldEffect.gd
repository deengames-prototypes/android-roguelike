extends "res://Effects/Effect.gd"

var strength
var turns_left

func _init(parent, _strength, _turns_left):
    _super(parent)
    strength = _strength
    turns_left = _turns_left
    tile_name = 'EnergyShield'

func process_damage(damage):
    # shield nullifies damage
    strength -= 1
    if strength == 0:
        _end_effect()
    return 0