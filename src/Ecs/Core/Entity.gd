extends Node2D

const SpriteComponent = preload("res://Ecs/Components/SpriteComponent.gd")

# type (as a string) => instance
var _components = {}

func _init(x, y):
	position.x = x
	position.y = y

func has(type:String):
	return self._components.has(type)

func get(type:String):
	return self._components[type]

func add(type:String, component):
	self._components[type] = component
	component.parent = self
	return self

func remove(type:String):
	if self._components.has(type):
		var component = self._components[type]
		component.parent = null
		self._components.erase(type)