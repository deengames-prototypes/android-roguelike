extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.TARGETED
	signal_name = "stun_pistol"
	icon = preload("res://Assets/skills/stunpistol.png")