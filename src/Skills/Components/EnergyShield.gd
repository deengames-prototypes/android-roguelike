extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.SELF
	signal_name = "energy_shield"
	icon = preload("res://Assets/skills/energyshield.png")