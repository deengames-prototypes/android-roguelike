extends Node2D

var _max_x
var _max_y

var rng = RandomNumberGenerator.new()

func _init(max_x, max_y):
	_max_x = max_x
	_max_y = max_y
	
	rng.randomize()
	
	position.x = rng.randi_range(0, _max_x)
	position.y = rng.randi_range(0, _max_y)

func walk():
	var mod = Vector2()
	if rng.randf() < 0.5:
		mod.y = 1 * rand_sign()
	else:
		mod.x = 1 * rand_sign()
	
	if is_out_of_bounds(position + mod):
		walk()
	else:
		position += mod

func rand_sign():
	if rng.randf() < 0.5:
		return 1
	else:
		return -1

func is_out_of_bounds(pos):
	return pos.x > _max_x or pos.x < 0 or pos.y > _max_y or pos.y < 0