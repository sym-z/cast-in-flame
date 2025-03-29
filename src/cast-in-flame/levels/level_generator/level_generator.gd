extends Node2D
class_name LevelGenerator

@export var floor_tiles: TileMapLayer
## Size of the map in tiles
@export var map_size: Vector2i = Vector2i(50,50)
## How densely packed the floor tiles are placed in bounds of the map
@export_range(.01,.5) var floor_density: float = .3
@export var player : Player
@export var nav_mesh_maker: NavMeshMaker
@onready var chest_room: PackedScene = preload("res://levels/structures/chest_room/structure_chest_room.tscn")
# This is the distance between the edge of the map and the edge of the walk
var edge_offset: int = 7
var map: Map
var layers: Dictionary[String, TileMapLayer]
var tile_size
# Makes a map, fills it with tiles, walks and sets tiles' type, sets tile sprite
func _ready():
	tile_size = floor_tiles.tile_set.tile_size
	map = Map.new()
	map.config_map(map_size, edge_offset)
	var room_instances = create_structures([chest_room,chest_room,chest_room,chest_room,])
	map.random_walk(floor_density)
	for instance in room_instances:
		map.connect_to_map(instance.details)
	#map.print_map()
	map.decide_all_walls()
	render_tile_map()
	layers = {
		"north": $North,
		"south": $South,
		"east": $East,
		"west": $West,
		"nw": $NW,
		"sw": $SW,
		"ne": $NE,
		"se": $SE,
	}
	render_walls()
	nav_mesh_maker.make_mesh(get_corners())
	
	place_player()
	#print(map.tile_record)


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

				
func render_walls():
	const tileset_coordinate = {
		"north": Vector2i(0,0),
		"west": Vector2i(0,1),
		"east": Vector2i(1,0),
		"south": Vector2i(2,0),
		"nw":Vector2i(1,2),
		"sw":Vector2i(0,2),
		"ne":Vector2i(1,1),
		"se":Vector2i(2,1)
	}
	
	for x in map.size.x:
		for y in map.size.y:
			if map.get_tile_type(Vector2i(x,y)) == null:
				var tile = map.get_tile(Vector2i(x,y))
				for direction in tile.walls:
					layers[direction].set_cell(Vector2i(x,y), 0, tileset_coordinate[direction] )
					map.set_tile_type(map.tile_types.WALL, Vector2i(x,y))

func create_structures(structure_prefabs: Array[PackedScene]) -> Array[Node2D]:
	var structure_instances: Array[Node2D] = []
	for prefab in structure_prefabs:
		structure_instances.append( create_structure(prefab) )
	return structure_instances

func create_structure(prefab: PackedScene) -> Node2D:
	var instance = prefab.instantiate()
	add_child(instance)
	map.add_structure(instance.details)
	instance.position = instance.details.origin * floor_tiles.tile_set.tile_size
	return instance


func tile_pos_to_world(pos):
	return  pos * floor_tiles.tile_set.tile_size
	


func place_player():
	# select random floor tile
	var valid_tiles = map.tile_record[map.tile_types.FLOOR]
	var chance = randi_range(0, valid_tiles.size())
	var tile_pos = valid_tiles[chance].pos
	var target_pos = tile_pos_to_world(tile_pos)
	if player:
		teleport(target_pos, player)
	
func teleport(pos, obj):
	obj.position = pos
	


func get_corners():
	# Used the extra distance to debug 
	var extra_distance = Vector2(0,0)
	var top_left = Vector2(-extra_distance.x,-extra_distance.y)
	var top_right = Vector2((tile_size.x * map_size.x)+ extra_distance.x, -extra_distance.y)
	var bot_right = Vector2((tile_size.x * map_size.x)+ extra_distance.x, (tile_size.y * map_size.y) + extra_distance.y)
	var bot_left = Vector2(-extra_distance.x,(tile_size.y * map_size.y) + extra_distance.y)
	return PackedVector2Array([
		top_left, 
		top_right,
		bot_right,
		bot_left
	])
