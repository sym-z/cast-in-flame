# Main Rules
---
- Any object that has its own scenes and scripts associated with it should all be housed within the same directory
	- Example:
		- `/level_generator`
			- TileMaps for floors and levels
			- Scripts for its resources and its main scene
			- `level_generator.tscn`: its main scene file.
- Assets should be stored in the `/assets` directory, and should indicate within subdirectories its type. 
	- Asset naming convention should classify its type first, then what level it belongs to 
	- Example: `floor_lust.png`
- All names of all files and directories must be in lower case, and use snake case.

# Main Directories
---
- assets
	- Art, sound, anything that is visually represented in the engine that can be seen and used outside of the context of a game engine
- debug_tools
	- Tools and scenes that are used by the development team
	- Example: `debug_camera.tscn`
- levels
	- Level generation, and the scenes and scripts associated with the levels in our game.