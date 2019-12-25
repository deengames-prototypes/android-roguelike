extends "res://Scripts/Ecs/Core/Component.gd"

var _health: int
var _max_health: int

func _init(health):
	_health = health
	_max_health = _health
