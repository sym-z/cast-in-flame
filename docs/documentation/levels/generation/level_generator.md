# `level_generator.tscn`
---
- A Node2D that represents the object that can be added to a level scene to generate a level
	- `Floor Tiles`
		- A TileMapLayer Node that holds the palettes for the floor tiles used for the random walk.
# `level_generator.gd`
---
The central script involved with invoking the functions used to build the map in memory, and assigns a visual representation to the tile objects.

## Exported Variables
---
- `floor_tiles`
	- A TileMapLayer node for rendering tiles of the `FLOOR` tile type
- `map_size`
	- The size of the map to generate (in tiles), not including the offset to prevent the camera from seeing off the edge of the map
- `floor_density`
	- A float range from 0.01 to 0.5 that governs what percentage of the walkable space should be filled with tiles, defaulting 1 out of every 3 available tiles. 
	- **NOTE**: Using a large map and large `floor_density` will cause a lot of load on the generation because of the time it takes for the script to path to an empty tile when there are very few available.
## Variables
---
- `edge_offset`
	- How close the random walk can get to the edge of the map
- `map`
	- The map object itself that will be represented to the player.
## Functions
---
### `_ready()`
---
- Creates a new [map.gd](../custom-resources/map.gd.md) object
- Calls the function `config_map` in the map object's code to allocate memory for the tiles
- Calls the map's `random_walk()` function to associate a tile type for each allocated spot on the map
- Calls its own `render_tile_map()` function to assign a visualization to those tiles based on the type
## `render_tile_map()`
---
- Walks through the map object, looks at the type of each tile, and creates a visual representation of the tile based on its type, and the level it is meaning to represent.
- Right now, both the `WALL` and `FLOOR` type render as the floor, and all other tiles will be what we call the `NULL` tile, which indicates a non-playable space.
