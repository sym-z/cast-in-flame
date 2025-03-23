extends Node2D
class_name LevelGenerator

@export var floor_tiles: TileMapLayer
## Size of the map in tiles
@export var map_size: Vector2i = Vector2i(50,50)
## How densely packed the floor tiles are placed in bounds of the map
@export_range(.01,.5) var floor_density: float = .3
# This is the distance between the edge of the map and the edge of the walk
var edge_offset = 7
var map: Map

# Makes a map, fills it with tiles, walks and sets tiles' type, sets tile sprite
func _ready():
	map = Map.new()
	map.config_map(map_size)
	map.random_walk(floor_density, edge_offset)
	render_tile_map()

func render_tile_map():
	'''
	Given a map object, walks through tiles and renders a sprite for them in tile map layer
	'''
	for x in map.size.x:
		for y in map.size.y:
			var tile_type = map.get_tile_type(Vector2i(x,y))
			if tile_type == map.tile_types.FLOOR or tile_type == map.tile_types.WALL:
				floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(randi_range(0,9), randi_range(0,9)))
			else:
				floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(9, 9))
