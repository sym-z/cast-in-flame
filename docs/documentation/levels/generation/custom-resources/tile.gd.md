# `tile` Custom Resource
---
- Tiles are used as a back-end representation of an object that is placed on the map that has a type. The type is initialized to `null`
- Tiles have a variable, `walls` that keep track of an array of strings identifying what collection of walls, if any, to apply to this tile during the `level_generator`'s `render_walls()` function.
