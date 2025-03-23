extends Node2D
class_name LevelGenerator

@export var floor_tiles: TileMapLayer
@export var map_size: Vector2i = Vector2i(50,75)
@export_range(.01,.5) var floor_density: float = .3
# This is the distance between the edge of the map and the edge of the walk
var edge_offset = 7
var map: Map

func _ready():	
	# Make the map object
	# Generate
	#   Place floor and walls
	#   Decide where walls are structures
	#   Auto tile
	map = Map.new()
	map.config_map(map_size)
	map.random_walk(floor_density, edge_offset)
	render_tile_map()
	# Tile map populate based on map object


func render_tile_map():
	for x in map.size.x:
		for y in map.size.y:
			if map.get_tile_type(Vector2i(x,y)) == map.tile_types.FLOOR:
				floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(randi_range(0,9), randi_range(0,9)))
			else:
				floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(9, 9))
