extends "res://Skills/Core/Skill.gd"

func _init():
	type = TYPES.SELF
	signal_name = "heal_self"
	# TODO: proper art
	icon = preload("res://Assets/skills/bowattack.png")