extends "res://Scripts/Ecs/Core/System.gd"

# n-th hotkey = n-th skill
var skill_hotkeys = ['1']

func _init():
	required_component_types = ["PlayerControlComponent", "SkillComponent"]

func on_update():
	for hotkey in skill_hotkeys:
		if Input.is_action_just_pressed("skill_" + hotkey):
			var hotkey_index = skill_hotkeys.find(hotkey)
			for entity in self.entities:
				var skill_component = entity.get("SkillComponent")
				if hotkey_index <= len(skill_component.skills):
					skill_component.active = skill_component.skills[hotkey_index]
