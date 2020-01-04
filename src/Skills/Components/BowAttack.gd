extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.TARGETED
	signal_name = "bow_attack"
	icon = preload("res://Assets/skills/bowattack.png")