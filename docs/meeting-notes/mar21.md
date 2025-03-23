# Agendas to Ask
---
- [x] Cast Into Flame or Cast in Flame
- [x] Make GitHub Repo
	- [x] Decide on and Set up Repo Architecture
- [x] Set up markdown documentation in Repo!
	- [x] Use Obsidian?
	- [x] Set up schedule together for big points to hit
	- [x] Flowchart in Obsidian?
- [x] Decide on palette of 4-6 colors to represent the game and UI
- [x] Decide on file structure rules

# Schedule
---
1. ~~Repo setup, rules around file hierarchy~~, palette choice
2. ~~Game creation, project setting defaults~~
3. Levels
	1. Level Scene Architecture
		1. How do Boss Levels fit?
		2. Insertible structures on the walk
			1. Rooms
				1. Chest
				2. Shop
				3. Camp (Stretch)
			2. Sprinkle Props (Destructables/Traps)
	2. ~~Level Generation (Zoom/Pan Debug)~~
		1. Terrain
		2. Collision
		3. Tweakable Parameters
			1. ~~Size of the level (Tile x Tile)~~
			2. ~~Walk Depth~~
			3. Required distance between entry and exit points
		4. Refinement
			1. ~~Making sure the generation doesn't extend to the end of the world~~
			2. Sensible entry and exit points
	3. Scene Transitions (Level to Level) (Next Scene Debug Button)
4.  Player
	1. Set up buttons in Project Settings
	2. State machine
		1. Identify states
		2. Implement movement state
		3. Implement states as we go
	3. Controls that are programmable through functions and usable by player
	4. Animation
		1. Tie to state machine as we go
	5. Collision
	6. Health/Hurt
		1. Tie to state machine
	7. Chop Attack
		1. As we implement, make sure that it is replicatable for other attacks
		2. Animation
		3. Hitbox
		4. State machine
	8. Dash
		1. Parameters
			1. Length
			2. Cooldown
		2. Canceling?
		3. Animation
		4. State Machine
	9. Scene Transition
		1. Exit Use
		2. Death
			1. Anim
			2. State
	10. Find a method of keeping track of stats
5. Sample Enemy Recipe
	1. Greybox Sprites
	2. Collision
	3. Nav Mesh
	4. Hitbox
	5. Hurtbox 
	6. FOV
	7. Set up states
		1. Hurt
		2. Death
			1. Drops
		3. Startup
		4. Attack
		5. Idle/Patrol
		6. Seek/Pursuit
		7. Endlag(Stretch)
	8. Elite Version
6. Upgrades
	1. Currency
		1. Abundant
		2. Drops in
			1. Enemies
			2. Destructables
			3. Hidden Rooms
			4. Chests
			5. Bosses
	2. Persistent (Dash Cooldown, Max Health, Melee Resist, Drop chance, NEW MOVES)
		1. Purchased only in Limbo
		2. More expensive
		3. TWO GOOD EXAMPLES
	3. Inventory (Boots that make your dash firey)
		1. Cheaper
		2. Find in chests, boss drops
		3. TWO GOOD EXAMPLES
7. HUD
	1. Styleboxes
	2. In-Game
		1. Health
		2. Currency
		3. Minimap
		4. Hurt Filter
	3. Inventory
		1. Togglable overlay
	4. Persistent Skills
		1. Togglable overlay
	5. Pause/Resume
		1. Togglable overlay
8. Audio
	1. Attaching speakers
	2. Attaching busses
9. Menu
	1. Main
	2. Options
		1. Rebind
		2. Localization
		3. Sound
		4. Filters
10. Saving
	1. Clear Save
11. Roles
	1. Clarify roles of existing members
	2. Identify places for possible candidates
12. After Spring Break
	1. Marketing
	2. Boss
	3. Limbo
13. Stretch Goal after release
	1. Save slots
	2. Fake start
	3. Fishing Minigame
	4. Dev console

# Whiteboards Used
---
![Image](/whiteboards/tile-deliberation.png)
![Image](/whiteboards/currency-planning.png)
