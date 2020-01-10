extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.TARGETED
	signal_name = "rocket_launcher"
	 # TODO: proper art
	icon = preload("res://Assets/skills/stunpistol.png")