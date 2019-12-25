extends "res://Scripts/Ecs/Core/Component.gd"

var health: int
var max_health: int

func _init(_health):
	health = _health
	max_health = _health
