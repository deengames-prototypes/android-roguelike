extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.TARGETED
	signal_name = "lightning_cannon"
	icon = preload("res://Assets/skills/stunpistol.png")