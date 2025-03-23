extends Resource
class_name Map

# Global variable that holds the size of the map in tiles
var size : Vector2i
# The map itself - double array of tiles 
var matrix = []
enum tile_types {
	FLOOR,
	WALL,
}

#TODO add world seed support
func config_map(arg_size: Vector2i):
	"""
	This is a constructor for the map
	It allocates memory for the tile instances
	"""
	assert (arg_size.x >= 0 && arg_size.y >= 0, "Map size invalid")
	size = arg_size
	for x in range(size.x):
		matrix.append([])
		for y in range(size.y):
			matrix [x].append(Tile.new())

func get_tile_type(pos):
	var tile = get_tile(pos)
	if tile == null:
		return null
	return tile.type

func get_tile(pos):
	if not in_bounds(pos):
		printerr (" accessing tile out of bounds")
		return null
	return matrix[pos.x][pos.y]

#TODO change the reset position to something else- does not suit large rectangular maps. 
#Maybe grab random walkable tile ^
#TODO handle theoritcal endless walk- maybe prevent consecutive skips
func random_walk(floor_density, edge_offset):
	"""
	Generation method for placing a tile, then walking to a new postion
	floor_density: Density of floor tile placement relative to size
	edge_offset: how close  floor tiles can be to the edge of the map
	"""
	var tiles_to_walk : int =  int ( float((size.x- edge_offset) * (size.y - edge_offset)) * floor_density )
	var start_pos : Vector2i = size/2
	var placed_tiles = 0
	var walk_pos = start_pos
	
	while placed_tiles < tiles_to_walk:
		walk_pos += pick_random_direction()
		if not in_bounds(walk_pos, edge_offset):
			walk_pos = start_pos
		
		var look_tile = get_tile(walk_pos)
		if look_tile.type != tile_types.FLOOR:
			look_tile.type = tile_types.FLOOR
			placed_tiles += 1

func pick_random_direction()->Vector2i:
	var chance = randi_range(0,3)
	var dirs = [
		Vector2i.UP,
		Vector2i.DOWN,
		Vector2i.LEFT,
		Vector2i.RIGHT,
	]
	return dirs [ chance ]

func print_map():
	'''
	A debug option for print map to console
	'''
	for x in matrix:
		var row = ""
		for tile in x:
			if tile.type == tile_types.FLOOR:
				row += "#"
			else:
				row += "_"
		print(row)

func in_bounds(pos, offset = 0):
	"""
	Returns true if arg is out of bounds
	offset argument allows you to close the bounds further for this case
	"""
	return pos.x >= offset && pos.x < size.x- offset && pos.y >= offset && pos.y < size.y - offset
