extends Node

# bresenham's line algorithm, translated from python
# see: http://www.roguebasin.com/index.php?title=Bresenham%27s_Line_Algorithm

func rotate(vector):
	var tmp = vector.x
	vector.x = vector.y
	vector.y = tmp

func get_line(point1, point2):
	# """Bresenham's Line Algorithm
	# Produces a list of tuples from point1 and point2
 
	# >>> points1 = get_line((0, 0), (3, 4))
	# >>> points2 = get_line((3, 4), (0, 0))
	# >>> assert(set(points1) == set(points2))
	# >>> print points1
	# [(0, 0), (1, 1), (1, 2), (2, 3), (3, 4)]
	# >>> print points2
	# [(3, 4), (2, 3), (1, 2), (1, 1), (0, 0)]
	# """

	# Setup initial conditions
	var dx = point2.x - point1.x
	var dy = point2.y - point1.y
 
	# Determine how steep the line is
	var is_steep = abs(dy) > abs(dx)
 
	# Rotate line
	if is_steep:
		rotate(point1)
		rotate(point2)
 
	# Swap start and end points if necessary and store swap state
	var swapped = false
	if point1.x > point2.x:
		var tmp = point1
		point1 = point2
		point2 = tmp
		swapped = true
 
	# Recalculate differentials
	dx = point2.x - point1.x
	dy = point2.y - point1.y
 
	# Calculate error
	var error = int(dx / 2)
	var ystep = 1 if point1.y < point2.y else -1
 
	# Iterate over bounding box generating points between start and end
	var y = point1.y
	var points = []
	for x in range(point1.x, point2.x + 1):
		var coord
		if is_steep:
			coord = Vector2(y, x)
		else:
			coord = Vector2(x, y)
		points.append(coord)
		error -= abs(dy)
		if error < 0:
			y += ystep
			error += dx
 
	# Reverse the list if the coordinates were swapped
	if swapped:
		points.invert()
	return points

func is_line_clear(tilemap, point1, point2):
	for point in get_line(point1, point2):
		if tilemap.get_cell(point.x, point.y) in Constants.BLOCKED_INDEXES:
			return false
	return true