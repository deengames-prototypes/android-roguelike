extends Camera2D

# TODO: extract magic numbers
func _ready():
	limit_top = 0
	limit_left = 0
	limit_right = Constants.TILES_WIDE * 32
	limit_bottom = Constants.TILES_HIGH * 32

func center_on(entity):
	global_position = Vector2(entity.x * 32, entity.y * 32)
