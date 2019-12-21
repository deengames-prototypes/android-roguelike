extends Node2D

var x:int
var y:int

# type (as a string) => instance
var _components = {}

func has(type:String):
	return self._components.has(type)

func get(type:String):
	return self._components[type]

func add(type:String, component):
	self._components[type] = component
	component.parent = self

func remove(type:String):
	if self._components.has(type):
		var component = self._components[type]
		component.parent = null
		self._components.erase(type)
	