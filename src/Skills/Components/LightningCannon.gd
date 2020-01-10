extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.TARGETED
	signal_name = "lightning_cannon"
	 # TODO: proper art
	icon = preload("res://Assets/skills/stunpistol.png")