extends "res://Ecs/Core/System.gd"

var _event_bus
var _skillmenu 

func _init(ui, event_bus):
	_skillmenu  = ui.get_node("SkillMenu")
	_event_bus = event_bus
	_event_bus.connect("set_player", self, "on_set_player")

func on_set_player(player):
	if player.has("SkillComponent") and OS.has_touchscreen_ui_hint():
		clear_skillmenu()
		var skills = player.get("SkillComponent").skills
		for skill in skills:
			var index = skills.find(skill)
			var skill_button = create_skill_button(skill, index)
			skill_button.position.x = 64 * index
			_skillmenu.add_child(skill_button)

func create_skill_button(skill, index):
	var btn = TouchScreenButton.new()
	btn.normal = skill.icon
	btn.scale = Vector2(4, 4)
	btn.action = "skill_" + String(index + 1)
	return btn

func clear_skillmenu():
	for child in _skillmenu.get_children():
		_skillmenu.remove_child(child)