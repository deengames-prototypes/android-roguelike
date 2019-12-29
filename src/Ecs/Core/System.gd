extends Node2D

const Entity = preload("res://Ecs/Core/Entity.gd")

# Expect all these components
var required_component_types:Array = []
var entities:Array = []

func add(e:Entity):
	for type in self.required_component_types:
		if not e.has(type):
			# print("Can't add " + str(e) + " to " + str(self) + " because it lacks a component of type " + str(type))
			return
		
	entities.append(e)

func remove(e: Entity):
	entities.erase(e)

func _process(delta):
	pass