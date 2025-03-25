A custom resource that holds [tile.gd](../generation/custom-resources/tile.gd.md) objects that are assigned a type using a random walk function.

# Variables
---
- `size`
	- A global Vector2i variable used to keep track of the bounds of the map
- `matrix`
	- A 2D Array of tile objects, used as a low-level representation of the map during the walk
- `edge_offset`
	- An int that keeps track of how close the random walk and structures can generate to the edge of the map
- `tile_types`
	- An enum that tracks the different classifications of tiles, so far they are:
		- `WALL`
		- `FLOOR`
		- `STRUCTURE`
# Functions
---
## `config_map(arg_size : Vector2i)`
---
- Allocates memory for the tiles within the `matrix` array.
- Assigns the global `size` variable to be the incoming `arg_size`
- Fills the `matrix` array with `size.x` by `size.y` tiles with a `NULL` type.

## `add_structure(structure: StructureDetails)`
---
- Grabs a random position on the map
- Calculates if `structure.size` tiles can fit given the random point grabbed
- If it cannot, it tries again until it has tried 20 times
- If it can fit a structure at that spot given the size of the structure, it checks to see if a structure already resides in that area, if one does, it begins another attempt
- If there is not structure in that spot, it marks `structure.size.x` by `structure.size.y` tiles as `tile_types.STRUCTURE` and sets `structure.origin` to be that random position.

## `check_for_type_in_area(range_size: Vector2i, origin: Vector2i, type: tile_types) -> bool`
---
- Scans a rectangular area of `range_size.x` by `range_size.y` starting at `origin` to see if there are any tiles of type `type`. If there are, it returns true, if not, it returns false.
- Used currently to identify if there is a structure in a given area before laying down a new structure.

## `get_random_pos() -> Vector2i`
---
- Returns a random position on the map in tile coordinates that exists in the walkable area (not within the edge offset). 
- Used to find possible origins for structures

## `is_connected_to_map(structure: StructureDetails) -> bool`
---
- Used after the random walk has generated floor tiles in order to tie the random walk map to structures
- Checks the tiles that surround the borders of the structure to see if any of the tiles are floor tiles
- Checks the left column, then iterates through the top and bottom rows of the border, then checks the right column
- Returns true if it finds a floor tile that surrounds it.
- **NOTE**: Currently we need to fix the condition that it will return true if it is touching a floor tile directly to its diagonal.

## `connect_to_map(structure: StructureDetails)`
---
- Creates a path of floor tiles from a structure that is not connected to the map, back towards the center of the map. Once the path reaches another floor tile, it stops pathing.
- Each iteration of a loop the path will calculate its displacement vector from the center, and place a tile in the direction that is closest to the map's center until it touches another floor tile, marking each new tile placed as a `FLOOR` type, if it is not a `STRUCTURE` tile type.

## `structure_in_bounds(structure: StructureDetails, pos: Vector2i) -> bool`
---
- Checks given a position on a map and a structure's size if a structure can fit on the map given the map's edge offset

## `get_tile_type(pos : Vector2i)`
---
- Returns the type of the tile at the given position, `pos`

## `get_tile(pos : Vector2i)`
---
- Checks if the position given is in bounds, prints an error and returns null if not
- Otherwise, returns the tile object in the matrix at `(pos.x,pos.y)`

## `random_walk(floor_density : float, edge_offset : int) `
---
- Calculates the amount of tiles to walk using the edge offset to keep space from the walk to the border of the map, and takes a percentage of that space, `floor_density`, to find the total tiles that it needs to place and stores that value in the variable `tiles_to_walk`.
- Starts in the center of the map
- Picks a random direction and moves one space
	- If there is no tile type set on that space, it marks that tile as a floor tile, and increments the count of tiles it has walked
	- If it tries to walk off of the edge of the map, it then moves the position of the walk back to the center.
	- Once it has walked the total amount of tiles calculated to walk given the edge offset and density (`tiles_to_walk`)

## `pick_random_direction() -> Vector2i`
---
- Returns a vector pointing up, down, left or right to be used by the random walk function

## `print_map()`
---
- Prints a debug version of the map to the console, using UTF characters to represent the tile types

## `in_bounds(pos:Vector2i, offset:int) -> bool`
---
- Returns a boolean identifying if a position given in a vector is inside of the bounds of the map, with an optional parameter, `offset` to constrain the value to the available walking space of the random walk.
