extends "res://Ecs/Core/System.gd"


func _init(event_bus):
    required_component_types = ["StatusEffectsComponent"]
    event_bus.connect("end_turn", self, "on_end_turn")

func on_end_turn():
    for e in entities:
        for effect in e.get("StatusEffectsComponent").effects:
            effect.on_end_turn()
