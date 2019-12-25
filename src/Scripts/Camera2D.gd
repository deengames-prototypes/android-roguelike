extends Camera2D

func _ready():
	limit_top = 0
	limit_left = 0
	limit_right = Constants.TILES_WIDE * Constants.TILE_WIDTH
	limit_bottom = Constants.TILES_HIGH * Constants.TILE_HEIGHT

func center_on(entity):
	global_position = Vector2(entity.position.x * Constants.TILE_WIDTH, entity.position.y * Constants.TILE_HEIGHT)
