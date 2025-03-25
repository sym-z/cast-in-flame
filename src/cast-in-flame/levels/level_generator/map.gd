extends Resource
class_name Map

# Global variable that holds the size of the map in tiles
var size : Vector2i
# The map itself - double array of tiles 
var matrix = []
var edge_offset: int
enum tile_types {
	FLOOR,
	WALL,
	STRUCTURE,
}

#TODO add world seed support
func config_map(arg_size: Vector2i, arg_edge_offset: int = 0):
	"""
	This is a constructor for the map
	It allocates memory for the tile instances
	"""
	assert (arg_size.x >= 0 && arg_size.y >= 0, "Map size invalid")
	edge_offset = arg_edge_offset
	size = arg_size
	for x in range(size.x):
		matrix.append([])
		for y in range(size.y):
			matrix[x].append(Tile.new())

func add_structure(structure: StructureDetails):
	for i in range(20):
		var origin = get_random_pos()
		if structure_in_bounds(structure, origin):
			if not check_for_type_in_area(structure.size, origin, tile_types.STRUCTURE):
				for x in range(structure.size.x):
					for y in range(structure.size.y):
						var pos = origin + Vector2i(x,y)
						var tile = get_tile(pos)
						tile.type = tile_types.STRUCTURE
				structure.origin = origin
				return

func check_for_type_in_area(range_size: Vector2i, origin: Vector2i, type: tile_types) -> bool:
	for x in range(range_size.x):
		for y in range(range_size.y):
			var pos = origin + Vector2i(x,y)
			var current_type = get_tile_type(pos)
			if current_type == type:
				return true
	return false

func get_random_pos() -> Vector2i:
	return Vector2i(randi_range(edge_offset, size.x- edge_offset), randi_range(edge_offset, size.y - edge_offset))

# FIXME: Write a function or find a way to make sure it is not returning a false positive when checking a floor tile
	# directly to its diagonal.
func is_connected_to_map(structure: StructureDetails) -> bool:
	#Top Edge of structure (no corners)
	if check_for_type_in_area(Vector2i(structure.size.x,1), structure.origin - Vector2i(0,1), tile_types.FLOOR):
		return true
	#Bottom edge (no corners)
	if check_for_type_in_area(Vector2i(structure.size.x,1), structure.origin + Vector2i(0, structure.size.y), tile_types.FLOOR):
		return true
	#Left edge (no corners)
	if check_for_type_in_area(Vector2i(1,structure.size.y), structure.origin - Vector2i(1,0), tile_types.FLOOR):
		return true
	#Right edge (no corners)
	if check_for_type_in_area(Vector2i(1,structure.size.y), structure.origin + Vector2i(structure.size.x, 0), tile_types.FLOOR):
		return true
	return false

func connect_to_map(structure: StructureDetails):
	var origin = size/2
	if is_connected_to_map(structure):
		return
	var walk_pos: Vector2i = (structure.origin + (structure.size/2) )
	while true:
		var walk_dir = origin - walk_pos
		if abs(walk_dir.x) > abs (walk_dir.y):
			walk_pos.x += sign(walk_dir.x)
		else:
			walk_pos.y += sign(walk_dir.y)
		var look_type = get_tile_type(walk_pos)
		if look_type == tile_types.FLOOR || walk_pos == origin:
			return
		if look_type != tile_types.STRUCTURE:
			var tile = get_tile(walk_pos)
			tile.type = tile_types.FLOOR
		
func structure_in_bounds(structure: StructureDetails, pos: Vector2i) -> bool:
	if in_bounds(pos) and  in_bounds(pos + structure.size):
		return true
	return false

func get_tile_type(pos: Vector2i):
	var tile = get_tile(pos)
	if tile == null:
		return null
	return tile.type

func get_tile(pos: Vector2i):
	if not is_valid_tile(pos):
		printerr (" accessing tile out of bounds at ", pos)
		return null
	return matrix[pos.x][pos.y]


#TODO change the reset position to something else- does not suit large rectangular maps. 
#Maybe grab random walkable tile ^
#TODO handle theoritcal endless walk- maybe prevent consecutive skips
func random_walk(floor_density: float):
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
		var look_tile = get_tile(walk_pos)
		if look_tile.type == null:
			look_tile.type = tile_types.FLOOR
			placed_tiles += 1
		
		walk_pos += pick_random_direction()
		if not in_bounds(walk_pos):
			walk_pos = start_pos

func pick_random_direction() -> Vector2i:
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
	for y in range(size.y):
		var row = ""
		for x in range(size.x):
			var tile = matrix[x][y].type
			if tile == tile_types.FLOOR:
				row += "#"
			elif tile == tile_types.STRUCTURE:
				row += "$"
			else:
				row += "_"
		print(row)

func in_bounds(pos: Vector2i) -> bool:
	"""
	Returns true if arg is out of bounds
	offset argument allows you to close the bounds further for this case
	"""
	return pos.x >= edge_offset && pos.x < size.x- edge_offset && pos.y >= edge_offset && pos.y < size.y - edge_offset

func is_valid_tile(pos: Vector2i) -> bool:
	return pos.x >= 0 && pos.x < size.x && pos.y >= 0 && pos.y < size.y

func decide_all_walls():
	for x in size.x:
		for y in size.y:
			decide_walls(Vector2i(x,y))

func decide_walls(pos: Vector2i):
	'''
	Decides what walls are placed to a given tile
	'''
	var direction_rules = {
		"north" : {"north": true},
		"west": {"west": true},
		"east":{"east": true},
		"south": {"south": true},
		"nw": {"north": false, "nw": true, "west": false},
		"sw": {"south": false, "sw": true, "west": false},
		"ne": {"north": false, "ne": true, "east": false},
		"se": {"south": false, "se": true, "east": false}
	}
	var directions = direction_rules.keys()
	var displacement_vector = {
		"north" :Vector2i(0,-1),
		"west":Vector2i(-1,0),
		"east":Vector2i(1,0),
		"south":Vector2i(0,1),
		"nw":Vector2i(-1,-1),
		"sw":Vector2i(-1,1),
		"ne":Vector2i(1,-1),
		"se":Vector2i(1,1)
	}
	var tile = get_tile(pos)
	for direction in directions:
		var place_wall = true
		var current_requirements = direction_rules[direction].keys()
		for requirement in current_requirements:
			var peek_pos = displacement_vector[requirement] + pos
			var is_floor = is_valid_tile(peek_pos) && ( get_tile(peek_pos).type == tile_types.FLOOR || get_tile(peek_pos).type == tile_types.STRUCTURE)
			if is_floor != direction_rules[direction][requirement]:
				place_wall = false
				break
				
		if place_wall: 
			tile.walls.append(direction)
