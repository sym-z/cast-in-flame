# Tile Size
---
- Environment tiles are now 240x240

# James at the helm
---
- Tile.gd
	- Tiles are resources that are being used by a resource, map
	- Tiles have a type, starting at null
- Map.gd
	- Map uses tiles
	- Map keeps track of tile types
		- FLOOR
		- WALL
	- `config_map(size: Vector2)`
		- Creates necessary object
		- Size must be less than or equal to 0
		- A constructor for the map
		- Double for loop to populate the map
		- `matrix`: Contains the tiles
			- `size.x` x `size.y`
			- `arg_size` is used to create a size using an argument, `size` is used in order to be referenced from the scene globally.
	- `random_walk()`
		- var tiles_to_walk
		- var start_pos = center of map
			- Vector2i(size.x/2)
		- var placed_tile = 0
		- var walk_position = start_position
		- while placed < tiles to walk
			- walk_pos += pick random direction
			- if !inbounds(walk pos)
				- go back to center
			- var look tile = get_tile(walk pos)
				- if it isnt a floor
					- set it to a floor
					- increment tiles placed
	- print_map()
		- prints all tiles in the map
	- func get_tile(pos)
		- if not in bounds 
			- printerr(return null)
	- func pick_random_direction() -> Vector2:
		- returns random direction
	- func bounds_check(pos)
		- keeps things within the map
- level_generator.gd
	- has a map
		- map = map.new()
	- makes a map
	- generates the map
# Discord Whiteboards
---
![Image](/whiteboards/structure-brainstorm.png)
![Image](/whiteboards/walk-offset.png)