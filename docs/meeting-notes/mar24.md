# Agenda
---
Main Goal: Only implement things we have already done, Jackson "The Goat" Mclane.
- Place wall tiles
	- iterate through null tiles or floor and structure tiles, if it is neighboring a structure or a floor tile, place the correct wall
	- Not sure how this will be handled when we don't keep a data structure of tiles
	- Eventually, we could store them during creation in a dictionary
	- `Dictionary[tile_type: int, tiles: Array[Tile]`
		- `FLOOR: [Tile{position},...]`
		- `...`
- Attach collision on wall
- Start on player