extends Node

# FOV with recursive shadow casting, translated from python
# see: http://www.roguebasin.com/index.php?title=Python_shadowcasting_implementation

# Multipliers for transforming coordinates to other octants:
const MULT = [
	[1,  0,  0, -1, -1,  0,  0,  1],
	[0,  1, -1,  0,  0, -1,  1,  0],
	[0,  1,  1,  0,  0, -1, -1,  0],
	[1,  0,  0,  1, -1,  0,  0, -1]
]

const BLOCKED_INDEXES = [1, 4]

func blocked(tilemap, x, y):
	return (x < 0 or y < 0 \
			or x >= Constants.TILES_WIDE or y >= Constants.TILES_HIGH \
			or tilemap.get_cell(x, y) in BLOCKED_INDEXES)

func set_lit(fov, x, y):
	if x >= 0 and x < Constants.TILES_WIDE and y >= 0 and y < Constants.TILES_HIGH:
		fov[Vector2(x, y)] = true

func _cast_light(tilemap, from_position, row, start, end, radius, xx, xy, yx, yy, id, fov):
	# Recursive lightcasting function
	if start < end:
		return
	
	var radius_squared = radius*radius
	var new_start
	for j in range(row, radius+1):
		var dx = -j-1
		var dy = -j
		var blocked = false
		while dx <= 0:
			dx += 1
			# Translate the dx, dy coordinates into map coordinates
			var X = from_position.x + dx * xx + dy * xy
			var Y = from_position.y + dx * yx + dy * yy
			# l_slope and r_slope store the slopes of the left and right
			# extremities of the square we're considering
			var l_slope = (dx-0.5)/(dy+0.5)
			var r_slope = (dx+0.5)/(dy-0.5)
			if start < r_slope:
				continue
			elif end > l_slope:
				break
			else:
				# Our light beam is touching this square; light it:
				if dx*dx + dy*dy < radius_squared:
					set_lit(fov, X, Y)
				if blocked:
					# we're scanning a row of blocked squares:
					if blocked(tilemap, X, Y):
						new_start = r_slope
						continue
					else:
						blocked = false
						start = new_start
				else:
					if blocked(tilemap, X, Y) and j < radius:
						# This is a blocking square, start a child scan:
						blocked = true
						_cast_light(tilemap, from_position, j+1, start, l_slope, radius, xx, xy, yx, yy, id+1, fov)
						new_start = r_slope
		# Row is scanned; do next row unless last square was blocked:
		if blocked:
			break

func do_fov(tilemap, position, radius):
	# add player's position, because for some reason it won't be lit otherwise
	var fov = {position: true}
	for oct in range(8):
		_cast_light(tilemap, position, 1, 1.0, 0.0, radius,
							MULT[0][oct], MULT[1][oct],
							MULT[2][oct], MULT[3][oct], 0, fov)
	return fov
