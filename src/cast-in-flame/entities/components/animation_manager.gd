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
	
	
#func _on_state_machine_state_changed(new_state):
	#""" 
	#When the state machine changes states, it fires this signal. 
	#This sets the animation name and calls a new animation. it also updates the callbacks collection.
	#"""
	#current_state = new_state
	#callbacks = new_state.callbacks
	#update_anim()
	#func _on_direction_manager_direction_changed( direction):
	#"""
	#Updates sprite if direction changes.
	#Buffers direction change if current state locks direction
	#Direction buffer may need to move to another object. 
	#"""
	#current_direction = _direction_vec_to_string(direction)
	#update_anim()
#
#func _direction_vec_to_string(direction):
	#"""
	#Converts direction vector to string
	#"""
#

	#return direction_dict.get(direction , "south") # defaults to north
#
#func do_frame_callback(frm):
	#var callback
	#if callbacks: callback = callbacks.get(frm, null)
	#if callback:
		#if typeof(callback) == TYPE_ARRAY:
			#for i in callback:
				#i.call()
		#else:
			#callback.call()
#
#func _on_frame_changed():
	#do_frame_callback(frame)
#
#func _on_animation_finished():
	#var callback= callbacks.get("end", null)
	#if callback:
		#if typeof(callback) == TYPE_ARRAY:
			#for i in callback:
				#i.call()
		#else:
			#callback.call()
#
#func _on_animation_changed():
	#do_frame_callback("start")
