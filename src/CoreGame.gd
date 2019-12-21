extends Node2D

# ecs/game loop

# instantiate systems and execute them
onready var display = preload('res://System/Display.gd').new()
onready var player = preload('res://Entity/Player.tscn').instance()

func _process(delta):
	display.tick(delta)

# TODO: Read tilemap, place entities
func _ready():
	add_child(player)