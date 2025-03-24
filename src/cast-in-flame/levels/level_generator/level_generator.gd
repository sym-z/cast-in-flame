extends Node2D
class_name LevelGenerator

@export var floor_tiles: TileMapLayer
## Size of the map in tiles
@export var map_size: Vector2i = Vector2i(50,50)
## How densely packed the floor tiles are placed in bounds of the map
@export_range(.01,.5) var floor_density: float = .3
@onready var chest_room: PackedScene = preload("res://levels/structures/chest_room/structure_chest_room.tscn")
# This is the distance between the edge of the map and the edge of the walk
var edge_offset: int = 7
var map: Map

# Makes a map, fills it with tiles, walks and sets tiles' type, sets tile sprite
func _ready():
	map = Map.new()
	map.config_map(map_size, edge_offset)
	var room_instances = create_structures([chest_room,chest_room,chest_room,chest_room,chest_room,chest_room,])
	map.random_walk(floor_density)
	for instance in room_instances:
		map.connect_to_map(instance.details)
	map.print_map()
	render_tile_map()

func render_tile_map():
	'''
	Given a map object, walks through tiles and renders a sprite for them in tile map layer
	'''
	for x in map.size.x:
		for y in map.size.y:
			if map.in_bounds(Vector2i(x,y)):
				var tile_type = map.get_tile_type(Vector2i(x,y))
				if tile_type == map.tile_types.FLOOR:
					floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(randi_range(0,8), randi_range(0,8)))
				elif tile_type == map.tile_types.STRUCTURE:
					pass
				else:
					floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(9, 9))
			else:
				floor_tiles.set_cell(Vector2i(x,y),0, Vector2i(9, 9))

func create_structures(structure_prefabs: Array[PackedScene]):
	var structure_instances = []
	for prefab in structure_prefabs:
		structure_instances.append( create_structure(prefab) )
	return structure_instances

func create_structure(prefab:PackedScene):
	var instance = prefab.instantiate()
	add_child(instance)
	map.add_structure(instance.details)
	instance.position = instance.details.origin * floor_tiles.tile_set.tile_size
	return instance
