A custom resource that holds [[tile.gd]] objects that are assigned a type using a random walk function.

# Variables
---
- `size`
	- A global Vector2i variable used to keep track of the bounds of the map
- `matrix`
	- A 2D Array of tile objects, used as a low-level representation of the map during the walk
- `tile_types`
	- An enum that tracks the different classifications of tiles, so far they are:
		- `WALL`
		- `FLOOR`
# Functions
---
## `config_map(arg_size : Vector2i)`
---
- Allocates memory for the tiles within the `matrix` array.
- Assigns the global `size` variable to be the incoming `arg_size`
- Fills the `matrix` array with `size.x` by `size.y` tiles with a `NULL` type.

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