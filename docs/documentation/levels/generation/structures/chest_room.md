 A structure scene that is used to hold a room that houses a chest that the player can open to receive loot. As it stands currently, the room is 4x4 tiles.

This room can be edited as a scene, placing props and goodies that will be visible when it is instantiated and transported to the proper position during generation.

## Tree Structure
---
- Node2D Root
	- TilemapLayer `Floor Tiles` used for placing the shape of the floor of the structure.
	- Right now it is using a tileset `graybox_structure` to better identify them during this prototyping phase.