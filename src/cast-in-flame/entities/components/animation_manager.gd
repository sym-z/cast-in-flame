extends AnimatedSprite2D
class_name AnimationManager

@export var character: CharacterBody2D
var current_state : Node = null
#var callbacks = {}

var direction_dict : Dictionary[Vector2, String] = {
	Vector2(0,1.0): "south",
	Vector2(0,-1): "north",
	Vector2(1,0): "east",
	Vector2(-1,0): "west",
}

func update_anim():
	print(character.direction_manager.look_vector, current_state)
	var animation_name = "%s_%s" % [current_state.animation_name, direction_dict[character.direction_manager.look_vector]] 
	if animation_name:
		play(animation_name)
	print(animation_name)
	
func _on_state_machine_state_changed(new_state_node):
	current_state = new_state_node
	update_anim()
	
func _on_direction_manager_direction_changed(_look_vector):
	update_anim()
	

func _on_animation_finished():
	if current_state.has_method("animation_end"):
		current_state.animation_end()
